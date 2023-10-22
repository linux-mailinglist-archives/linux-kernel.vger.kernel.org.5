Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E0F7D2278
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjJVKIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVKIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:08:23 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C91E6;
        Sun, 22 Oct 2023 03:08:21 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5ae99bb5ccdso1080999a12.1;
        Sun, 22 Oct 2023 03:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697969301; x=1698574101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgnGtHufG+xvCzQs2ZVtnujeeQwsYYAk6Y3rSnTjot8=;
        b=FsXJgTHwKcjGZUdjywDUMBNMCJfHqsXpChXIGkw7o+ubjLgskiMXy16VaEME5hIxU5
         7vkn0wEQQZYTi4AxU1WWhIv+BF6G7VvLeE+UxetfCd0cIPV+GiUHcklJFPg9tvbW7nU6
         J5UeM/cHI2XYtOxaCrZY5bgTPVXQLEJ10wC3qZQIUuNNibkG9gcvRHA6FKKxpt3sG8na
         Kop2tW6G3aesi6HYXG+UFeukIDlU7+CLr7vTH6Y0ICOkBM7KYjVsE37TV6bIAsWaV9/y
         PHn2vKBfEY3hzzMkXWHF5FbepzcLEBNGJ2R2QYTY7dYp8YNMQ4/tIQk+zO17ZB+avaog
         quwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697969301; x=1698574101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgnGtHufG+xvCzQs2ZVtnujeeQwsYYAk6Y3rSnTjot8=;
        b=k5Mua8UZ2/6e9pdHUEgeQgEUwOnUFB7axdGrS4vZBvpW9I3fQ9TIpYvasIwYyX86H9
         zslyUX1mHEoEaGqF47PDqtLiDTtJ0WD6PzszXAwuS1V7grlD6lJu0L1XVt/BgaITL4NB
         /OuLvvEWnNTEZqxxmiUcBZBeZvowVA3KE00mI3jXdZh6ldgjxstc89wFJ47fMMNfgo4t
         BVii/q3poG97lditPNmj6L5G+g4t5xCxK+OVroMabNaE8uFCf9FtApqcM7hxbhiFRqxg
         RVnOgFYT0LGtoTe1ySo/hT2sn6gXGm3QB0efhzpjU29Ue4djarA+vnSZIHPg/fg7ia9O
         HtKw==
X-Gm-Message-State: AOJu0YwT5AMwUKsKO6FQHpv0yIr1P8alvSKV3xJknovnjxoCWKEmX+/T
        4MzdrsR9LPzpfkB5p1CDDcQ=
X-Google-Smtp-Source: AGHT+IFwfDsLhajsOmzpsF08fQz5zAkvoLBDv4lRrEuQax1IruNZCwsM4pEysX9xzA3i0rA09m+WVg==
X-Received: by 2002:a17:90b:4f4b:b0:27d:9f6:47b1 with SMTP id pj11-20020a17090b4f4b00b0027d09f647b1mr4206403pjb.33.1697969300963;
        Sun, 22 Oct 2023 03:08:20 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a000500b00267d9f4d340sm6453994pja.44.2023.10.22.03.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 03:08:20 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EF51196ACF1E; Sun, 22 Oct 2023 17:08:17 +0700 (WIB)
Date:   Sun, 22 Oct 2023 17:08:17 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     JPT <j-p-t@gmx.net>,
        Linux Media Subsystem <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Gon Solo <gonsolo@gmail.com>
Subject: Re: si2157 not working at all?
Message-ID: <ZTT0kZCijyLDN1LG@debian.me>
References: <08125fef-3cb4-4f01-975c-d7c409153c4a@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TyRnEwhs9Qk8a6qs"
Content-Disposition: inline
In-Reply-To: <08125fef-3cb4-4f01-975c-d7c409153c4a@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TyRnEwhs9Qk8a6qs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 09:57:07AM +0200, JPT wrote:
> Hi,
>=20
> I've got a
> 	TerraTec Cinergy TC2 Stick / Terratec Cinergy H6 rev. 2
> DVB-T2/DVB-C USB stick using chips:
> 	IT9306, Si2157, Si2168-B40
>=20
> Is there a way to make it work?
> Or is the si2157 chip just not supported?
>=20
> si2157 7-0063: device is buggy, skipping firmware download
> si2157 7-0063: firmware version: =EF=BF=BD.=EF=BF=BD.255
>=20

Do you already have latest linux-firmware package?

> This patch added the "skipping firmware download":
> https://patchwork.kernel.org/project/linux-media/patch/20191010095103.380=
3-3-gonsolo@gmail.com/
>=20
> is there a way to tell the module to force load the firmware?
> Or do I have to patch the kernel?
>=20
> I tried on Kubuntu 23.4, kernel 6.2.0-35-generic
> and on Libreelec 9.2@raspberry 3B,  kernel 4.19.127? , where it failed
> differently.

Can you check latest mainline (currently v6.6-rc6) instead?

>=20
> libreelec log see http://ix.io/4JBp
>=20

Can you also attach full kernel logs from both systems?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--TyRnEwhs9Qk8a6qs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTT0jQAKCRD2uYlJVVFO
owQsAQCJn7ZFU9tZeqyyzIn0DhZ/C0IeYD2TpHCMo7ljmUgn+wD+NOa7IgorzGBt
J3dBuJBch8bmtqrgRmUbXa2061/YCA8=
=xNMW
-----END PGP SIGNATURE-----

--TyRnEwhs9Qk8a6qs--
