Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D3D7FB10C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbjK1FDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1FDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:03:47 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0F61AD;
        Mon, 27 Nov 2023 21:03:54 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c239897895so3411906a12.2;
        Mon, 27 Nov 2023 21:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701147834; x=1701752634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W23J0BcgxSklclO8sluyghV5NSHeDrAZd0UrfhgnfVA=;
        b=ZRpk78XtHwpInvUHIEr6OftfgYaxjxx6ARRz61ZxfE5JAsW7RNFjkPqtjoTvKfioxx
         tb9QaCUpGLjUxKsa9JCWJrA4VjVd15NGMzrp5cocSqwK1r/3Bh+ZOdfb3fGA9axQLeOL
         HUmIM17Q9S5pqkKOY9H1Lc+ArDVgE/g4fJZFpSm40Mi+51TF0rKZXyuen4B0Uj/XKZuR
         4L+uqzkJDSdkadJ6ZKfkPCYwc+nc+0zpzU/TpNhM2kLsaTVAwUDKw1zxR2wi7m+LbkV4
         Q1QBbEeAosbURzhzeBdr4TDUxtOY9r8nFJLgn9hGvwOAuoBEMKZ7AaNSo6FAEP02j8Oj
         DDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701147834; x=1701752634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W23J0BcgxSklclO8sluyghV5NSHeDrAZd0UrfhgnfVA=;
        b=K12Qw7LcNJn3j5kmtm9PmVqVNW08wB7/vzrTsrOLcFTS3ibszWiXT7AloBmtwKMvMB
         p8Kjf5PSVbvROx48XWnBOZHnQFT7K9/IqOZfbqSIU9PiGcgPiEIohM1xCpUOJYoZIJ2d
         MTupbTcBGzHnMO7fWjnZFtBnQs9+YXs/4NF3BxXHw+xpT/7BRF0XVQxskJRFNESF0TUT
         +arpP4ExEJtsyY9zAtW89gSvxtPgYuwbZ8nGUl/3F7U2YCYc9gy6K++fbMqeU8ZEPvJ2
         9BaS8SGy5a6EEVlhhoBP9CGTB8i+9VNh1NbADBd1cWNZVaMfGXukYzKoFQ3AQ4SVH23+
         jOUQ==
X-Gm-Message-State: AOJu0Yw7aDKq+F0VbWpl5RweVf/wzBtS8McWs2xsGMcExZ6BmdyS2v5n
        gzdQ/Ogd62wSc47+OKU2xbg=
X-Google-Smtp-Source: AGHT+IFuJn1MeVxt1Lb37TBLOtXkrbySVrPTWFS2/isDPs/CGbGxTtuD1nU4JDP4hz4LPEdarkbjSQ==
X-Received: by 2002:a05:6a20:9e4d:b0:187:9521:92b4 with SMTP id mt13-20020a056a209e4d00b00187952192b4mr15282620pzb.19.1701147833813;
        Mon, 27 Nov 2023 21:03:53 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903230a00b001cfc44aac0fsm3860940plh.111.2023.11.27.21.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 21:03:52 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id D5C34101D8AAE; Tue, 28 Nov 2023 12:03:50 +0700 (WIB)
Date:   Tue, 28 Nov 2023 12:03:50 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/525] 6.6.3-rc4 review
Message-ID: <ZWV0tk_99WPgDgv1@archie.me>
References: <20231126154418.032283745@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="22dtCgJlc3FKpRYP"
Content-Disposition: inline
In-Reply-To: <20231126154418.032283745@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--22dtCgJlc3FKpRYP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 03:46:18PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 525 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--22dtCgJlc3FKpRYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWV0sgAKCRD2uYlJVVFO
o0ijAP0RDLvzKuwa7DyIA5i0DwkZMEZnmCpEUPiA/1G6gmMefQD/SIfbBmRymQCW
4SybJh+OqlDHhDkn4EmBcZCCrkLoXwg=
=k/b/
-----END PGP SIGNATURE-----

--22dtCgJlc3FKpRYP--
