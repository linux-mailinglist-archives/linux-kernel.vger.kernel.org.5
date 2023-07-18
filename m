Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDC275737E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGRF7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjGRF7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:59:52 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC70C10C2;
        Mon, 17 Jul 2023 22:59:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8b2b60731so28861385ad.2;
        Mon, 17 Jul 2023 22:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689659991; x=1692251991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZgx1U1mPSutohyae00KOSAim5lD82mg/ErHhPpbWQw=;
        b=G3oBHbm9cxHBLCRB1lea28oryApGG51xlyyh3VAN/mNV4o2ks5rCBEbhXG8AySZc/H
         zejxPbx9NBI4bf4OCmOLkPKcN8ph4B5/EWq6Y2Zfe9rm/B5O+zBi8TAXH+i6K0fL++cu
         yKQZ469UNG2rzLmBJWISQmUI7hvm3NXP/lXk7Nc3OY46JFVrvogCvEpiyaR9oN1Iw0Wb
         fngjW6dcUcLulRstYpvKFYjTOrHb8U9MI4hpZTuP1J0mYSTXz0YejDyIx3GixjMI6Rd6
         9unNmA/i7Iyi8HmVEFiTO3fmm3jmU4EZ0k1nrPBiXk+dhi7MutsFSTFFnL/cCbrVLglx
         rO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689659991; x=1692251991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZgx1U1mPSutohyae00KOSAim5lD82mg/ErHhPpbWQw=;
        b=iaFXz/0tXfx8WwS222+85StyEAUBqlrVaDEq6VxS+pJgYYyKMNRlOuxAoRQBT4yosd
         uKu6jeulsGFenRTUTDqvtExs3YecmorAj8yXOAYBPrnR1swthGt/h03UyMFkewyqyhLo
         fI/TWFaww2nRY7QwmqDs9hlfsA8sCAJL/iAJp4kvdfJzSKYzV+hkEe0Ry2p8wkNuyqBu
         p0c+GVR6KGNH57fEttOAv73OhuPTwn7fXvN2d5q3TTAm1q8tCjJAYvkRwdC5QKpeXtoM
         2K18idQlgYOfLAVTBXyoPeRThO2047qz/eqLEqh3hGg90FEW8jBzwScDlRZOdp5iMRM6
         vHjg==
X-Gm-Message-State: ABy/qLaiil1BPi6PYFFnSUwwz6wWT/QVFRqX3I0b1nfTls77oACGz0Qc
        PLoC7Dnlg5AucpH+xNtLet6iX9kSWKS7fRE3
X-Google-Smtp-Source: APBJJlGEo8z5JP96Wwh1eVTC8awXH8O/BTkxUtwpGEycThW3hHQiwoSQYtxgdhE345zJvnRTvkTR6Q==
X-Received: by 2002:a17:902:c109:b0:1b9:cc6b:408c with SMTP id 9-20020a170902c10900b001b9cc6b408cmr11723848pli.38.1689659991061;
        Mon, 17 Jul 2023 22:59:51 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001b890009634sm877139plh.139.2023.07.17.22.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 22:59:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1DFE282EE10F; Tue, 18 Jul 2023 12:59:44 +0700 (WIB)
Date:   Tue, 18 Jul 2023 12:59:44 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/589] 6.1.39-rc3 review
Message-ID: <ZLYqUMPXAWIoUUVG@debian.me>
References: <20230717201547.359923764@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AeDpJC/wnI4TchjW"
Content-Disposition: inline
In-Reply-To: <20230717201547.359923764@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AeDpJC/wnI4TchjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 10:34:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.39 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--AeDpJC/wnI4TchjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZLYqSwAKCRD2uYlJVVFO
o00eAP0av/TSaLWmcQ9ryLiYGP58xF1ayuybl/YxvT9PEmXjJAEAyRi7/ZbkSwbL
rtnm+UFSvUCw8GpO+R1kq4Yhgf+Bag4=
=Qw23
-----END PGP SIGNATURE-----

--AeDpJC/wnI4TchjW--
