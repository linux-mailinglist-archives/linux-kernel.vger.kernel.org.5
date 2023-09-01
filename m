Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D5378FA2C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbjIAIrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjIAIrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:47:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE55DE54;
        Fri,  1 Sep 2023 01:47:36 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdc19b782aso12714205ad.0;
        Fri, 01 Sep 2023 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693558056; x=1694162856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Bz9KhSLDYES3lHxf4Rv9YDVYI9ZYxEiIT0+MdSGQk8=;
        b=k7K2pcI/cD8M44bNrPHSUzALEQUSNgxmlBYRYnJkBcID3jIjtZaPEYaJDuA44XE5Zr
         ajTRL3HT+AEy4Lw803/GojlSOMExSyCNWbAt0Hm4mRQjH/howfYJPdFaBDsullvL0gIf
         T1KDmhgZ4hzQmiENk/vye11cMAQ0y3GntlsZ7tR0mwF65dasGAti/dM6hNj8TFlJpsHW
         dJivUqYIzhzgtvg2+p69tIjR943YkDhIWFEKJfNLwwrCP4i2S4sEUzVt6uhj0PgqAkv9
         g/RYizbbwMO7odFZhZQIjt4iz2mNAiMPfp+EY733WI2YrSqBVOlIoLjmeH2yB+Vj7Nxc
         b0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693558056; x=1694162856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Bz9KhSLDYES3lHxf4Rv9YDVYI9ZYxEiIT0+MdSGQk8=;
        b=U1hXkhz+VHNE4bkh5Qs8Uf5DeGRt/AlQkGrhd7d5pCMHTSzQ0fPEb99u6P7l5f3L0F
         HM7kAtCr1CTy/fWLoLCOmpj81yt9FyoPvIlrz5EF3RWq+be1NzOUud5ybPeh7rLtl5tX
         KqDGln0yGTUWZ9nII4H1r1yn6ESa6A+bSGStPAReGQuctRy7kGBE6Gus3/ryvo1Bh+FT
         NNaOQrEG9DIALc3hkPSAkzSrg7zjjqxQCl0iURTsLgN3W2EDIOlugKLVyzGVeRguvB7B
         PtRjXshXkXEtv5bpHXvvXTLBmPXpgze4gq/bVU1z4FaP6OsP/MPRKDQpj453r0lO+mHl
         TJNw==
X-Gm-Message-State: AOJu0YxIyMYWgNseL21475BT41pOa4deGs3/envILmej4mMBWMWzDSaH
        rUeiJCEGBhRgWPT+qZM335E=
X-Google-Smtp-Source: AGHT+IEjqAYBqhW8Mr7ASWnCHFOpu3hTAsiUodZhqfPQeIEG/NEmy75N67CrcQ4donGK1J7bvXKMWQ==
X-Received: by 2002:a17:903:446:b0:1bd:f378:b1a8 with SMTP id iw6-20020a170903044600b001bdf378b1a8mr1806392plb.11.1693558056119;
        Fri, 01 Sep 2023 01:47:36 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902a70500b001bbb22652a4sm2473053plq.226.2023.09.01.01.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 01:47:35 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7AE7F8088643; Fri,  1 Sep 2023 15:47:30 +0700 (WIB)
Date:   Fri, 1 Sep 2023 15:47:30 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/10] 6.1.51-rc1 review
Message-ID: <ZPGlItgI-l2ljpff@debian.me>
References: <20230831110831.079963475@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t06PUDhssnELXJBU"
Content-Disposition: inline
In-Reply-To: <20230831110831.079963475@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t06PUDhssnELXJBU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 01:10:40PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--t06PUDhssnELXJBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPGlHAAKCRD2uYlJVVFO
o/FyAQCXZJ4Q/8tTXYsUP4MbS7KC0hEaigYtfyLzq2dA0cRXtwEA8YaAYPN3MSF7
bmdjwsBCc8aBjaa5AMY8MNJ2Fq153gY=
=PAcP
-----END PGP SIGNATURE-----

--t06PUDhssnELXJBU--
