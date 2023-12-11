Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC8180C0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjLKFTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjLKFTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:19:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3747C3;
        Sun, 10 Dec 2023 21:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702271988;
        bh=5sNtilsWwU1x5jkzfc9dPKYu30Z5wT/4p92EP0oqClo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TY/MC4uInXd8Ar3RZACEymrzFF/oqjw1AEYXGZo1brr8DgAfNORkdg/NBEb+eW/P0
         Rw7fEvOUH/V6eU8XbYHxL4lfDNq5n50PJBkMWTQdr3vln1eE01ihS5ssXTOhje4OOH
         HOtpdf3CntO13FpJn7evPxIE9Yi3HdsK4zRoYGxPbRIGYpW1O9KNgUl1YaI9+zwBrC
         pPO/9XNfQ/XIDcDVwMV9fhq87JpiKdw/XaMBHUVIvFbqLHC8t3rjB/9d0bYvVUIYk6
         /u8eVRAmwZxqAGP1/DRwA9lry2SAyczQY02NvBln3qszX8wd51Ud62iz5HT1AWkU5o
         Qy2Sn3lV3r67Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpVRl32fMz4xGR;
        Mon, 11 Dec 2023 16:19:47 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 16:19:46 +1100
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
Message-ID: <20231211161946.2f151d13@canb.auug.org.au>
In-Reply-To: <CAFULd4Y4n4uGy-pTc0PD6+-OytzGZHeJTPZ_CPJDq7VM7ChRdA@mail.gmail.com>
References: <20231201112918.294b40b1@canb.auug.org.au>
        <CAFULd4Yfh0=TkhoevuJP1kghP5VLFj2zP9av68_s2pez3n2iog@mail.gmail.com>
        <20231204150807.600c2f09@canb.auug.org.au>
        <CAFULd4Y4n4uGy-pTc0PD6+-OytzGZHeJTPZ_CPJDq7VM7ChRdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n7biqZpoMx/uBlMl96h8naj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n7biqZpoMx/uBlMl96h8naj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 4 Dec 2023 08:02:56 +0100 Uros Bizjak <ubizjak@gmail.com> wrote:
>
> On Mon, Dec 4, 2023 at 5:08=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
> >
> > On Fri, 1 Dec 2023 13:09:45 +0100 Uros Bizjak <ubizjak@gmail.com> wrote=
: =20
> > >
> > > On Fri, Dec 1, 2023 at 1:29=E2=80=AFAM Stephen Rothwell <sfr@canb.auu=
g.org.au> wrote: =20
> > > > =20
> >  > After merging the tip tree, today's linux-next build (x86_64 allmodc=
onfig) =20
> > > > produced these warnings:
> > > >
> > > > WARNING: modpost: EXPORT symbol "const_pcpu_hot" [vmlinux] version =
generation failed, symbol will not be versioned.
> > > > Is "const_pcpu_hot" prototyped in <asm/asm-prototypes.h>?
> > > > WARNING: modpost: "const_pcpu_hot" [arch/x86/kernel/msr.ko] has no =
CRC!
> > > > WARNING: modpost: "const_pcpu_hot" [arch/x86/kvm/kvm.ko] has no CRC=
! =20
> > >
> > > My build doesn't produce any warnings. A defconfig + enabling kvm.ko =
as module:
> > >
> > > ...
> > >  AR      built-in.a
> > >  AR      vmlinux.a
> > >  LD      vmlinux.o
> > >  OBJCOPY modules.builtin.modinfo
> > >  GEN     modules.builtin
> > >  MODPOST Module.symvers
> > >  CC      .vmlinux.export.o
> > >  CC [M]  arch/x86/kvm/kvm.mod.o
> > >  CC [M]  fs/efivarfs/efivarfs.mod.o
> > > ...
> > >
> > > Does the attached patch help? Or is there anything else I should do to
> > > trigger the above problem? =20
> >
> > The patch does not help.  I am just doing an X86_64 allmodconfig build
> > with CONFIG_WERROR=3Dn. gcc is
> >
> > $ x86_64-linux-gnu-gcc --version
> > x86_64-linux-gnu-gcc (Debian 13.2.0-2) 13.2.0
> >
> > This is a cross build with a ppc64le host. =20
>=20
> The warning is triggered by CONFIG_MODVERSIONS=3Dy and will be fixed in
> a different way by the patch in [1].
>=20
> [1] https://lore.kernel.org/lkml/20231203232017.994963-1-ubizjak@gmail.co=
m/

I am still seeing the warnings ...

--=20
Cheers,
Stephen Rothwell

--Sig_/n7biqZpoMx/uBlMl96h8naj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2m/IACgkQAVBC80lX
0Gy7Ggf7BIUS+NkdpG1CaDhdDdn9Sf7DQqJjlQVNB2BakU8u72if/VFG4Cke1I3t
e1iCTtOzUp9RYmB3RGUSbgFDC9RS1SV+TjERYpYG8gXOybY3XOef4WiAeMDD+ndf
L8se+m2iLmoCbzaGxprfKUr6LwLcxj3NDnOXqPYqYJOAb5KGWEA/XD0WvJEle7pv
TwDNenp5C+5p7SPUFxlMIreU6uNQgxfIj8WwcqW+RdNXTsvFx4JAXsW+QQtqA8GJ
eOkr3bkFAdw+jw5QoC/ThZeK2bdZXErWOfmIzB9rBNWZpHdptda9l4p3HF4b8b+q
6iIN0bKZVkInJW8Dy+0QSHP+HJgwxQ==
=JHmK
-----END PGP SIGNATURE-----

--Sig_/n7biqZpoMx/uBlMl96h8naj--
