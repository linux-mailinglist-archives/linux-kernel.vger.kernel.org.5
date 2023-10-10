Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9E67BF2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442232AbjJJGXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442213AbjJJGXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:23:37 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED539D;
        Mon,  9 Oct 2023 23:23:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3495848a12.2;
        Mon, 09 Oct 2023 23:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696919016; x=1697523816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QmKiVGXOMoFSb0jdRS7/I36LbjLoB/tR7BGYo9BXzVA=;
        b=bU//9CUYDTN8pLJsQSn4VcKRMi95VvX1Fz9f7Vg8Pkg/rxMYRhyDXF9qonOp2cnP1/
         ld8MN7WceDuIVZdT7bU7IDJzfwYGLVAV+2/+Ih/87p6vcKRYgmGdnB5D2EKC/GcF0reO
         7OIR6Bf3nHFpRk3CbzcraaHU94UuEVbeH83HD64/3lsF4h0oJpP/t3T1Yrrv39wy7s3C
         oaXCUdsjJzMn5k7VewVx6PgRReJzNvOofczwsmyDO/kai3d9rm0EwH4SLlo/VNccc+x2
         lj74bHWu6gd3sR7lJFToy3w1qTFBG2bEP/7xN+AGv+JHTzZzUyhpd89D5FIJyaj9BvbR
         j/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696919016; x=1697523816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmKiVGXOMoFSb0jdRS7/I36LbjLoB/tR7BGYo9BXzVA=;
        b=Fko73mVVN7Qkk00XeYVAUFiuCFGFoz9rrRfI2rmWiVk6ZNsBglti9HYpF1KtMDlGkN
         vIQxvw1txKtlcB9X8wSfL6mw5Z/83SKx281ZRo6G4oRrZ51VCu1ycKRzMkleF4mot7gH
         Ld5vMbIgLlxoiHc/Cgqxkm/UkQcBlfBn26BRDrgHhhan3zgLlqhKWu4ypDg+/nDNiW/b
         5JvOoCA5FvQk9f6JMm28C34hE6aZLZwIVkivuEbGMf+6ptaSUpxjfru1zG3zN6L62Fsl
         l6SNjsBIaHPjObt6AOmLLGusstI80OEq92JpcuPIF1lk9H1Jhyvgqwko1zNzVkNCmH5J
         xO4Q==
X-Gm-Message-State: AOJu0YzQSAcXYGdY97W0VQFktDdaoWUfH+NFhfRdVxydB/5EaDjSb+IZ
        +JUcLLU2KF0rzBBEea2D/ao=
X-Google-Smtp-Source: AGHT+IECxhjXjrQAv2tcqtN64pPrEu0AY9j+48dsFtrXG8ACl2uQZd14H8qDoT/6c3Qfm2xGYEa6Ew==
X-Received: by 2002:a05:6a20:8f0e:b0:16b:f8ef:f31e with SMTP id b14-20020a056a208f0e00b0016bf8eff31emr10060052pzk.5.1696919015682;
        Mon, 09 Oct 2023 23:23:35 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y4-20020aa78544000000b006878cc942f1sm7410333pfn.54.2023.10.09.23.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 23:23:34 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0AFFE84B9020; Tue, 10 Oct 2023 13:23:30 +0700 (WIB)
Date:   Tue, 10 Oct 2023 13:23:30 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/163] 6.5.7-rc1 review
Message-ID: <ZSTt4p9ezc4cvxNW@debian.me>
References: <20231009130124.021290599@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n50QiLsRPrBx+8ui"
Content-Disposition: inline
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n50QiLsRPrBx+8ui
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 02:59:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.7 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--n50QiLsRPrBx+8ui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSTt3gAKCRD2uYlJVVFO
oyj0AP4ggBKxdQt22d6oxanLTajhPHPJW+1RISWNnDHMNWqvJgEAyndXFQuvH2PI
1tVI4HuXNSvspscewOFdHo3u6aUsIQc=
=N3HI
-----END PGP SIGNATURE-----

--n50QiLsRPrBx+8ui--
