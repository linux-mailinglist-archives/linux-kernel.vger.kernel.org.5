Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA9A7A9799
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjIURZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjIURZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:25:29 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9366645610;
        Thu, 21 Sep 2023 10:13:52 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59c0442a359so15070627b3.0;
        Thu, 21 Sep 2023 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316431; x=1695921231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v41ItM9EXYIC22XbO3MBvIrVnukFuETmf/6WBr3dSG8=;
        b=bp2uQvudPv4ajm3GXC4Q7E0ZRePq4fJc83M5k1YkhaCfBPoYYy00fUP1u4bszomlbx
         9WXMDBpX9bt3qiA26h75KDsVsriTmK5XXUPMothBs3CXdPHXwqOM9o3zQuO0Aa/7jHIg
         8UMIrKU86ty8gtmtD5eGEmKl1LjZsEUFDJ+UsOz2M132oUYcuejMpYTeW/FzD3alSCoS
         VgbBQ9QZUgVHPbMVo5lrohn0QKe3bK5KXG1JBkkTJYGk9NKRasjzASz5BrFzkIpFz7TL
         tbL+SaQzTFjYpgv3gFE3Ct1DKXVf/VgyyIVDRrg7eKcL1Xm+oMuOErk6XS3+YxZv8D0V
         03rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316431; x=1695921231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v41ItM9EXYIC22XbO3MBvIrVnukFuETmf/6WBr3dSG8=;
        b=abpoWCTBbRK37bt+Q5rWIvR0/0QJpgs7lUAB4eVL29GPzVjYMn6ClHDuRgu8w/zUji
         FfuUxYJ6TTp0gA1c2thMJfUmETr3xwnGOHjyfZHUCB+WnwiP9gLArFXSqPUNnUZOdJ/E
         I4Dkoo4urL+oJezQgS7IMAI2gfR+/cxO1COxmGy2svw6nC331kTcg/XrLbQHqpf6onhk
         3YpU81vOqFplPXDIlmH/ULpOCvJ96qNOLVOIyyCwq4eIa32so1emGoG4l1wC3oS1y2sw
         s3UIXJl4clwqZ6jhjI+tIGL4VJHnw4F+2H/2d1srj6Ta6aI5AtTmZ9L6UnDNsT4kcCgB
         FSmA==
X-Gm-Message-State: AOJu0YzLVRtCaBR8v9TCIpn9PxsetndV6PBESvi5RmFJCWpMtLMlUTNC
        gXcfdukz/zqdGIDTHZE8kW2MVZMGOEE=
X-Google-Smtp-Source: AGHT+IGVmo/gftbdfuKH0B4o/qNKwTfwk4yyKQsxA9zdx8SBcpiPCk4TsmV5HrGlycHJiYo39qaa7Q==
X-Received: by 2002:a17:902:c404:b0:1c3:9bce:817 with SMTP id k4-20020a170902c40400b001c39bce0817mr4695608plk.3.1695269370868;
        Wed, 20 Sep 2023 21:09:30 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902ec9200b001c1f0b3e900sm289499plg.229.2023.09.20.21.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 21:09:30 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3B8CD8134683; Thu, 21 Sep 2023 11:09:26 +0700 (WIB)
Date:   Thu, 21 Sep 2023 11:09:26 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/211] 6.5.5-rc1 review
Message-ID: <ZQvB9k_JLsHZDAq1@debian.me>
References: <20230920112845.859868994@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="APCRpmKMn0NWwniv"
Content-Disposition: inline
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--APCRpmKMn0NWwniv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 01:27:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.5 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--APCRpmKMn0NWwniv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQvB8gAKCRD2uYlJVVFO
o6w2AQCP+cIumMniBqwRP72EIDzFpHxMIAZp64z62tWTCeh7RAEAuxe5UyRxFD7O
OPKv7P6Ms/7jA4JxhI0LsY9hJA2AAAg=
=bQtx
-----END PGP SIGNATURE-----

--APCRpmKMn0NWwniv--
