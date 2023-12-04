Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7056E802AB0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjLDEIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 23:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDEII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:08:08 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7714BCD;
        Sun,  3 Dec 2023 20:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701662890;
        bh=Mt4zD1tGaHWza6GlukoEY8R3eTQNovJ0fviSb32nqVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ewJAXGH6U02n2FgyDaFgjxx238vOel2u39LFbW7foifF87ed0nAWrHhBijgyuXKVz
         F/Wa3GaSdSvu0Wk7zE2Pg7wuScZYpwcp/YN0RFhQznQjeHAaNzPKEkNJd0T8Yxlnzi
         MQwkogMp10QXfQpcYVWppbC0rrOGIyopo+TIrPsM6xBSqB78uRAzSfa/tjjy9unQ6A
         iIFyRhnt2fuwuDkqPCs3Zjc5x+nzdmaWJ2PPhL/cH6ZfXzYFREiEYOLPEzid/lf9zU
         jwE/OABx/ecltWMyRov7FYwsf/6SSkoA0wb5L+bCu1KNMTA1KQDp/j7CWPNEH0SAVq
         sgk1u0lAl9LUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sk9BK5V1Tz4xMw;
        Mon,  4 Dec 2023 15:08:09 +1100 (AEDT)
Date:   Mon, 4 Dec 2023 15:08:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <20231204150807.600c2f09@canb.auug.org.au>
In-Reply-To: <CAFULd4Yfh0=TkhoevuJP1kghP5VLFj2zP9av68_s2pez3n2iog@mail.gmail.com>
References: <20231201112918.294b40b1@canb.auug.org.au>
        <CAFULd4Yfh0=TkhoevuJP1kghP5VLFj2zP9av68_s2pez3n2iog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Dg2jyPmbbaRHaFvwrb0cc6+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Dg2jyPmbbaRHaFvwrb0cc6+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Uros,

On Fri, 1 Dec 2023 13:09:45 +0100 Uros Bizjak <ubizjak@gmail.com> wrote:
>
> On Fri, Dec 1, 2023 at 1:29=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
> >
 > After merging the tip tree, today's linux-next build (x86_64 allmodconfi=
g)
> > produced these warnings:
> >
> > WARNING: modpost: EXPORT symbol "const_pcpu_hot" [vmlinux] version gene=
ration failed, symbol will not be versioned.
> > Is "const_pcpu_hot" prototyped in <asm/asm-prototypes.h>?
> > WARNING: modpost: "const_pcpu_hot" [arch/x86/kernel/msr.ko] has no CRC!
> > WARNING: modpost: "const_pcpu_hot" [arch/x86/kvm/kvm.ko] has no CRC! =20
>=20
> My build doesn't produce any warnings. A defconfig + enabling kvm.ko as m=
odule:
>=20
> ...
>  AR      built-in.a
>  AR      vmlinux.a
>  LD      vmlinux.o
>  OBJCOPY modules.builtin.modinfo
>  GEN     modules.builtin
>  MODPOST Module.symvers
>  CC      .vmlinux.export.o
>  CC [M]  arch/x86/kvm/kvm.mod.o
>  CC [M]  fs/efivarfs/efivarfs.mod.o
> ...
>=20
> Does the attached patch help? Or is there anything else I should do to
> trigger the above problem?

The patch does not help.  I am just doing an X86_64 allmodconfig build
with CONFIG_WERROR=3Dn. gcc is

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 13.2.0-2) 13.2.0

This is a cross build with a ppc64le host.

--=20
Cheers,
Stephen Rothwell

--Sig_/Dg2jyPmbbaRHaFvwrb0cc6+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVtUKcACgkQAVBC80lX
0GyX5Qf+IJQio0mJpBjKa1FbCKwrDuxIAft+twott7IlJiGqoa7e2KjWcL1FtE1f
FBjcAduG4o77sbjveubm/ygUQVYurLOYr5DgGRV76oEaw2BjAFGzyJV2610ukcz6
nW108H/suWcSe9Scc6lG80eI6Rl4f5qXqHzNNYcsK2YXBMXvrVPKWVVwXbHStGe9
tjvPjOnSJ6nv7m8fLuK0AyXwWJ9EgZgYSTcbUyqVvs57VWeQvipPeuUMkYGhauBq
aElTkGciwGlqtGYMxMxCl2p3YoSY+E3lDJV+ExSG7jAsV4+maQejikyqCKbHG1qe
V8ZPsglm0Yk7E86ich+vIA/6Ra8B2Q==
=GxVn
-----END PGP SIGNATURE-----

--Sig_/Dg2jyPmbbaRHaFvwrb0cc6+--
