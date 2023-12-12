Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7E880F991
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377372AbjLLVh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjLLVhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:37:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB59DB3;
        Tue, 12 Dec 2023 13:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702417080;
        bh=fvRCGNHhInfrca07PkN6n9fo3WBgL+C2V/czG3LgI6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KUkMEO8R0i7Wa1ufMi6lexwcEjqPNrQG5aNDi8Bzdo/avKU80eHkcTANG5sAtqa0T
         Qh8ghOl+9gNc+/IrxPagtmYac0hzEXyssM0LOTFShpvjXTR0OJDRafgb2dRjg+7woN
         xT5KAGeV5ZDUJoPt3NP6CxJgsfDwYwmcEzrv4jliJG3o27C3lUYQl6l3pq7C7ldcqu
         T9FKxi22dwTBJImanc0NgQ5h2zjE+6tM8EdZS9OVk/eb8LwFiOWX8oVTYZh7OdizeE
         UHj7kbE02tphhAKyiA2YYqrWBHv1tFgGXEs9oB8D4VNfsG1nY1mlSf/dBirX/DiIAG
         AHxEmmKq78xMg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SqX6048vVz4wcX;
        Wed, 13 Dec 2023 08:38:00 +1100 (AEDT)
Date:   Wed, 13 Dec 2023 08:37:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: linux-next: Tree for Dec 11 (drivers/perf/riscv_pmu_sbi.c)
Message-ID: <20231213083759.738f0798@canb.auug.org.au>
In-Reply-To: <CAHVXubitXvkWmvHd7JXs5kTZC4L2VvOD2B_ue3D5hUhevOpwfA@mail.gmail.com>
References: <20231211172504.058ad6b6@canb.auug.org.au>
        <846f4d8a-16ad-4ce2-9bcc-34e03f057421@infradead.org>
        <CAHVXubitXvkWmvHd7JXs5kTZC4L2VvOD2B_ue3D5hUhevOpwfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qbFGRDteV3hlvbqKI=wJrAu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qbFGRDteV3hlvbqKI=wJrAu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 12 Dec 2023 08:24:54 +0100 Alexandre Ghiti <alexghiti@rivosinc.com>=
 wrote:
>
> On Mon, Dec 11, 2023 at 10:22=E2=80=AFPM Randy Dunlap <rdunlap@infradead.=
org> wrote:
> >
> > on riscv32:
> >
> > ../drivers/perf/riscv_pmu_sbi.c:1015:35: error: initialization of 'int =
(*)(const struct ctl_table *, int,  void *, size_t *, loff_t *)' {aka 'int =
(*)(const struct ctl_table *, int,  void *, unsigned int *, long long int *=
)'} from incompatible pointer type 'int (*)(struct ctl_table *, int,  void =
*, size_t *, loff_t *)' {aka 'int (*)(struct ctl_table *, int,  void *, uns=
igned int *, long long int *)'} [-Werror=3Dincompatible-pointer-types]
> >  1015 |                 .proc_handler   =3D riscv_pmu_proc_user_access_=
handler,
> >       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> > ../drivers/perf/riscv_pmu_sbi.c:1015:35: note: (near initialization for=
 'sbi_pmu_sysctl_table[0].proc_handler')
>
> I already sent a fix for that here:
> https://lore.kernel.org/all/20231207083512.51792-1-alexghiti@rivosinc.com/

I have added that patch to linux-next today and will keep it until it
turns up in the sysctl tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/qbFGRDteV3hlvbqKI=wJrAu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV40rcACgkQAVBC80lX
0GxV7Af/QwhYbcoWsMdJIIFO0tko1rCwK/E6gTa1AFUsTcmChBp8DqtUyZLBwFX9
E3HXxUvLoEAra02Icv+m5r2ngYJTbRN+uzvqhE14XrifnRZxaziquztjC6s/U/h7
OeLeOArcDrsT3yIZREl1Hee7M9g+V7j7VfYQjBrXU+K1Gr8H8WWSw579dVw++I4e
w9rPGbUorYwtQiv47BXUUSbRXCcWs+6A3mvjFmXIkUSL5E+6F4C+KmxvAW1CZOg1
2CD0L1sjj9+9vig5ssrAz8nuDviPQ0pHdzCm30tYPxNFVfl62mhVwD5Igx2M5Jrt
scG4B/UIqJ8HKCxEeZfPtYXgZVKsxQ==
=CDKO
-----END PGP SIGNATURE-----

--Sig_/qbFGRDteV3hlvbqKI=wJrAu--
