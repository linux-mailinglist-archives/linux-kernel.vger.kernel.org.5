Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BDA77D909
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbjHPD2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241535AbjHPD14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:27:56 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8858E199D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:27:54 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a3efebcc24so5178008b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692156474; x=1692761274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwjgK2dfjusAmnPgA0cwl3aotLdxMSAMr7Xpy27yFbM=;
        b=O8/Btqw/e0heP0IILDuZlus/a/5n9Uiwh2vCGO8r9IeJN+7IHqW1bbDbEC4xF4BK1q
         XMD3ouBXgaFT87rNGhqfzw6DZ6yOdDAlRb+HcIDqnA0JQLK+GHsjxkFEDpgXa5vZYMWW
         xHKROFMcxwd6op5eZIG7CMNGn5s0IfhdnV+evF+9PRpKq65pc1u44K7/CJKkWRvvsU9C
         x5HKhiN8c+28G9zmirabjQvQuDKWTGaDhPzroHZK/cAl+rDCQcg8yTm/8231iIU/Tv6m
         IBRbK2F3S0oDGDBKnVzqvO80rQxuro9sXgso5y3boFdVaLehTvk/Hn8XbokRObOPPsDc
         or1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692156474; x=1692761274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwjgK2dfjusAmnPgA0cwl3aotLdxMSAMr7Xpy27yFbM=;
        b=VgBJKU2mOpu/sDlaXVQwA/XmS/7vw7k1VQ7TZY1K9+9bJ9QjGEO5fKh47/7bOIejH0
         cCknx2fNti9c9YGTOtDvmcbYwA60VB3MVgaaZXGWNKM+qNDV/kqTWziZM5lC8cZfmC6n
         THP9nppJDgzrhXtHFXUHE/RBLFCVRR3cCMAw5K3CFJTqvJbBxlGBoW/QdkzK70KPi8oi
         k/ervtm1PP1IFxmHT4D5/vkX/pfXksKfslQ4fKiOr9kmaqR38WSVNeYmswMHGr1znBdj
         gPdywurko7GWlVA1fmzUx3P+171RzzOawErEGMwX5VV3CfmKaP/c+xi6XR5YhWzxGWg8
         unZw==
X-Gm-Message-State: AOJu0Yx/3mii7koHQwaAD9m2EOqakpff/xVpMI3Og/ztZAD8Y6XGER6x
        JRXb/RcL8U2BJDLi0iR9q9U=
X-Google-Smtp-Source: AGHT+IHNRfcN9HhzdykwL4I8izOHAzCPXZDBx+2HEKdktKDD/pF+0DDW+LZpTgGz/B2qltEShoqhFw==
X-Received: by 2002:a05:6358:9490:b0:134:c279:c829 with SMTP id i16-20020a056358949000b00134c279c829mr1271417rwb.18.1692156473689;
        Tue, 15 Aug 2023 20:27:53 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id q3-20020a63ae03000000b00563ff7d9c4bsm11014268pgf.73.2023.08.15.20.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 20:27:53 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 02B52821D995; Wed, 16 Aug 2023 10:27:49 +0700 (WIB)
Date:   Wed, 16 Aug 2023 10:27:49 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Andrew Randrianasulu <randrianasulu@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: Build failure in 6.5-rcX ?
Message-ID: <ZNxCNRzvDN87_MIf@debian.me>
References: <CA+rFky5xK35402EGQ-6VqxT-arR7SWLAcp2PyB1xK9ZGRqhs2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ixZCtGygK7ok2r5u"
Content-Disposition: inline
In-Reply-To: <CA+rFky5xK35402EGQ-6VqxT-arR7SWLAcp2PyB1xK9ZGRqhs2A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ixZCtGygK7ok2r5u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 11:39:06PM +0300, Andrew Randrianasulu wrote:
> I was trying to crosscompile linux git
>=20
> 9106536c1aa37bcf60202ad93bb8b94bcd29f3f0
>=20
> Unfortunately I got this error:
>=20
> =3D=3D=3D=3D
> bash-5.1$ make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-unknown-linux-gnu-
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CHK     kernel/kheaders_data.tar.xz
>   UPD     include/generated/utsversion.h
>   CC      init/version-timestamp.o
>   LD      .tmp_vmlinux.kallsyms1
> arch/x86/kernel/irq.o: In function `__common_interrupt':
> irq.c:(.text+0x1727): undefined reference to `irq_regs'
> irq.c:(.text+0x172f): undefined reference to `irq_regs'
> irq.c:(.text+0x179a): undefined reference to `irq_regs'
> arch/x86/kernel/irq.o: In function `__sysvec_x86_platform_ipi':
> irq.c:(.text+0x1897): undefined reference to `irq_regs'
> irq.c:(.text+0x189f): undefined reference to `irq_regs'
> arch/x86/kernel/irq.o:irq.c:(.text+0x194a): more undefined references
> to `irq_regs' follow
> make[2]: *** [scripts/Makefile.vmlinux:36: vmlinux] =D0=9E=D1=88=D0=B8=D0=
=B1=D0=BA=D0=B0 1
> make[1]: *** [/dev/shm/linux-2.6/Makefile:1250: vmlinux] =D0=9E=D1=88=D0=
=B8=D0=B1=D0=BA=D0=B0 2
> make: *** [Makefile:234: __sub-make] =D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0=
 2
>=20
> =3D=3D=3D=3D
>=20
> config attached.
>=20
> I use binutils 2.25.1 and gcc 7.5.0 targeting x86_64-unknown-linux-gnu-
>=20
> so my compile line was
>=20
>  make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-unknown-linux-gnu- -j8
>=20
> after adding crosscompiler into PATH
>=20
> I tried to rebuild with make clean, but issue still here.
>=20

What system are you running your kernel builds?

And in the future, please run make with V=3D1. Also, try prepending it with
LC_ALL=3Den_US.UTF-8 to set compilation messages to English instead of your
language, as people here can understand what's going wrong.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ixZCtGygK7ok2r5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZNxCMQAKCRD2uYlJVVFO
o8VuAQDNa9qlwXFRnSZbbKtZ7icrbEDzReQg4z1UfrVIxgXGFgEAkC0Krl879SJT
khsDJxpSpWbzDWDk9unN6rPoH9p9NAg=
=e+2E
-----END PGP SIGNATURE-----

--ixZCtGygK7ok2r5u--
