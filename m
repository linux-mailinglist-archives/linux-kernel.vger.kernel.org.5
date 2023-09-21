Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B397A90EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjIUCeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIUCea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:34:30 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D428DD;
        Wed, 20 Sep 2023 19:34:24 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-577a98f78b2so284884a12.3;
        Wed, 20 Sep 2023 19:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695263663; x=1695868463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YyjiBsVBYHl7tXi/d8DrdE74sHAHItbdpqTvGKn8leQ=;
        b=NAxOGka9aPC8TyDCTZqhQ6DsDqjad9xdwo4h0enmpVOcsAM0xYViV18T2OfWgXgyCP
         /hdHkWSGVrBQk0894zX8Q+xwPVKfMeoI52VT0KEfT9Ebp0W6PRXOyF6mBaQhX8/lo1Xx
         waJ0Jp9sDcMS8XQKeO59/JB5WZ9UpGths8Pa1hISU1TPKLzYTvcJ0z1bnvD9U0t8So38
         DEDfvQvoDOAeYnpSMjJoxBz3hHLMCMuaxh+PgKb9CghvJbzDFHdgXZk9Ho8YvFwMis9B
         ahTZJ/vPIki3GsyETkePvZJulHTz5BJSgvlpIHu3Gdlj5dp3nz8YeKliSw09M3KcK/ca
         99Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695263664; x=1695868464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyjiBsVBYHl7tXi/d8DrdE74sHAHItbdpqTvGKn8leQ=;
        b=wnJl0d6jKSrP0/kL4en29WC8PSVLDu8PILbbP5UZDm15/f/Xb41+1X4ANIWNPT6M9S
         GiDclWZR+cvie0pXdN29LqN+IApxN0CcsjdzVFSaaNpMTe4h6m+yJUEh77wyMJM/0GMc
         /yhKI0r31quAbNF3xCkfryO/oHdPLeDk2aISspea64JD38b7YiL8KP8ccD6c6mzWrBj0
         L/D6uokj+h+bmRIHZIDaiGBAUJulgEhsUU+QYk/G+KthGBF9q6IlXTGlJ9J3LU/hDE3Y
         VVHeGpk0pRQrG5SLicsn8fcXWZ2FURgg9zAUROsbShUgwaMPEKzPlptvkUQTFklcRqJo
         lbhg==
X-Gm-Message-State: AOJu0YxnGsYaUrE7TsmU9SUAVQ43ZTXNs35+QvfNrv4DizJ9vUXa/gIQ
        o7/Gk8MgQm2vxLhjhE64yx8=
X-Google-Smtp-Source: AGHT+IFWnXge3YgYaXFugjt4aiKInwf6x/gri9XVD1qdAJQgrpt84UgD+Akn+6/VeQ63B7uqZyoZtA==
X-Received: by 2002:a17:903:1109:b0:1bb:d59d:8c57 with SMTP id n9-20020a170903110900b001bbd59d8c57mr5541324plh.18.1695263663614;
        Wed, 20 Sep 2023 19:34:23 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b001bde6fa0a39sm187922plh.167.2023.09.20.19.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 19:34:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 46DFC80B8F69; Thu, 21 Sep 2023 09:34:19 +0700 (WIB)
Date:   Thu, 21 Sep 2023 09:34:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/139] 6.1.55-rc1 review
Message-ID: <ZQurqopWz1634-lg@debian.me>
References: <20230920112835.549467415@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HWzh9Wt8MK8C9IfR"
Content-Disposition: inline
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HWzh9Wt8MK8C9IfR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 01:28:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.55 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--HWzh9Wt8MK8C9IfR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQurowAKCRD2uYlJVVFO
o6ajAP9HLQbD5uS+7yuaxIhQ11td0NZOwywX25L8xil3ZNW2GgEAhuiU0lRxYcvP
IVpOtULpEcizvVpUDJogonNEpl/uuws=
=+p3Z
-----END PGP SIGNATURE-----

--HWzh9Wt8MK8C9IfR--
