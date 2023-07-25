Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F32B761E55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjGYQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjGYQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:21:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E113397
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:21:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso8451273a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690302081; x=1690906881;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQ1JJZA4GThkoE4/Cz7k+1DGdmZ6yMPdgW7Euy20CH8=;
        b=sQfv/4QHTbos8bmSh9UYF56je+S99om+H2gKx8j9w48p/oT7R1J/GBwJ4g3ohtO0Cb
         BL22GzLzcxAT0jSnnQj3TDOTZ8IUsaFPLSJBl2GhiDx5fO4RTfKEDEWEII2afZQDOdaA
         8eDLhM+RHdcYcgC+KYjnbEofU+YlcDLz1mTGYPRoPD1Okjef4fI4BQBgH9w0dy/9YBGJ
         N7vItLiPFWb11w/6gYiUw1NTK9xkk5+F32JrxEsYpZAQTalbE6RGM+5c1AGx0C11sI4V
         h0IrdtIgJVPqD5eGtBUTWi4Po2N9s0P01wBFr0nz2FJAYUAicF9mJBKRU5jlFSu3st4L
         nGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690302081; x=1690906881;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQ1JJZA4GThkoE4/Cz7k+1DGdmZ6yMPdgW7Euy20CH8=;
        b=L3DHC+eqgJoxwaElrzTTymzMGrNS/iTP21nPQvv+k8dt7U1cWAfYifAoTS4xxoSbGB
         b/tyudNt2/vQhikE1M6O+xFcaxrvk8XeUU3QWMKvV0oINwg87Q51PWRqdM4OhalSR3D+
         bv56lhy6p+rWLG9wOo2tdIgUWnRUP3X3uL6TKE1/wSeiu1X99+30LQqHGR0oDNORT8be
         zDo6B74Gs0eNf1WUGX0gRSm8paO27rN2eTclHx0uXpAXC6W8XMZ5Kka7RdOqkYOz9d+P
         ujq5soUGa+9vUXKNRiXG0kzub832m3VkMCy4dWsAAVma9+NU047WoHFsruYDi1mNAt8s
         Xlng==
X-Gm-Message-State: ABy/qLbcLgJG9ZUbiRS2IAcpKMB5LYGjsfwECZPoMVgIIZ3UYfKKJs9J
        DjzHGfsJlrEOhqOnHjP2tYU=
X-Google-Smtp-Source: APBJJlGZpGERatKzh35+ALl5dKcKF22+g94KBwNl3+wfFYy+1bAOV/m2l0zgJ9OvCCflF1b9mYxfNw==
X-Received: by 2002:aa7:d3da:0:b0:522:214c:516 with SMTP id o26-20020aa7d3da000000b00522214c0516mr6324327edr.42.1690302080905;
        Tue, 25 Jul 2023 09:21:20 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7ce0f000000b0052238bc70ccsm2319037edv.89.2023.07.25.09.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:21:20 -0700 (PDT)
Date:   Tue, 25 Jul 2023 18:21:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     kernel test robot <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: pwm-rz-mtu3.c:undefined reference to `clk_rate_exclusive_put'
Message-ID: <ZL_bEBGNb73wbpRF@orome>
References: <202307251752.vLfmmhYm-lkp@intel.com>
 <OS0PR01MB59220756AD4F8184ACF34B238603A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1nG26Lhuxqqc7sfI"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59220756AD4F8184ACF34B238603A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1nG26Lhuxqqc7sfI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 01:51:38PM +0000, Biju Das wrote:
> Hi kernel test robot,
>=20
> I have fixed the original issue by adding dependency to COMMON_CLK.
>=20
> But I hit below error which related to m68k compiler/arch specific.
> Can you please fix this issue?
>=20
> /home/user/0day/gcc-12.3.0-nolibc/m68k-linux/bin/m68k-linux-ld: section .=
rodata VMA [00002000,009a758f] overlaps section .text VMA [00000400,012a08f=
f]
> make[2]: *** [../scripts/Makefile.vmlinux:35: vmlinux] Error 1
> make[2]: Target '__default' not remade because of errors.
> make[1]: *** [/builds/0/rzg2l-linux/Makefile:1250: vmlinux] Error 2
> make[1]: Target '__all' not remade because of errors.
> make[1]: Leaving directory '/builds/0/rzg2l-linux/build_dir'
> make: *** [Makefile:226: __sub-make] Error 2
> make: Target '__all' not remade because of errors.
>=20
> Note:
> You can reproduce this issue by
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6210babb0741..eeecf249f372 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -506,6 +506,7 @@ config PWM_ROCKCHIP
>  config PWM_RZ_MTU3
>         tristate "Renesas RZ/G2L MTU3a PWM Timer support"
>         depends on RZ_MTU3 || COMPILE_TEST
> +       depends on COMMON_CLK

It probably doesn't change anything about the build issue, but I think a
slightly more correct dependency would be:

	depends on HAVE_CLK

Thierry

--1nG26Lhuxqqc7sfI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS/9n8ACgkQ3SOs138+
s6HCahAAm4mljjEiowzQcfV+PM/gJkBoR+l8hkHZbHAPzUsBcORf6bSKHo1Tr6VE
mXH3lLdKHFjPj7YpHqpSG8uOlxKZk+Dy105VSHHWa6OTsca+qJETzdSLLqgcSMYI
m2XO2sHdp9Le9i4nn9Ss7NH52TTPm9dpHbr64mxLAHZ1ma0KfBQ+Yfs8/MSd7IyU
hzZl35dmLn+mLpVsVJQNaeSDS3ZosszmIi98bL/LhbQqwFOkgW1P2U9zRjUi5MYi
U9/Nv76haVw1JjLWpCJm6KcGZPq9IJD5D4MtEbCRi91qnQDmsApkqxu7RggHvvUe
CEpBQiCIwbnq8qFkwsykxvcwz2I3spgjbx16HscaJNAqjbqFrFgDDrAwIkeBZTCk
aDE0tVknn9B6IkVmMj7iByFlhLxwKi7jBXOuJgGqSPid1g59sqJXjM66XxePMT5+
uB9OPtFPAfr7jtzZ0uy7TDcTbG+p35yuj6XrwpfSsONygMkNWehqkoqIPY9KXUHb
V/Uhjvpp+qWJdjKMbSdUJZRYQvkH+2MHHOSdKfxaFK6wP1tJiqwlPrgGfuAQxMo/
aaw3AfvT+opFLU7BfLRIjcW4XoMzRfdWKqXs8U+ezqh2BkFccDY8uGjF86+imcqE
9fkGoMZIaDDAYgyj/akYUZ7lwKhCNsuJ0MhOyQZgMQoiyO9zoCQ=
=mdEU
-----END PGP SIGNATURE-----

--1nG26Lhuxqqc7sfI--
