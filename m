Return-Path: <linux-kernel+bounces-31213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6E3832AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05511C2417B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF84753805;
	Fri, 19 Jan 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YKa/glm0"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477E52F8E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671676; cv=none; b=jGNwGlGHTFt4poYwAx+18V5VqsQYRD24DD9vYHGyzGqZqp9UagkInr2HEHxcvT3JiX+D7ldi7yoV3WKPm0ExsKHyPtNIFNivAPnRZH27syo3h/M6XSwj1LEv3l4NNN7lGoHbq4A+RZJKuLGYnl5AvgSzqX1nCZbOiOH51744D4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671676; c=relaxed/simple;
	bh=b0xfR74rQwJYDQ7hKAqecK3XXaONSV3o5NImcOt3A8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gzBBOqeAhsujqRzmoILrGh4hMtPfpD1oEaKF7G198XcjvYgVlXDJGj7BLACXKXkak7iZuv0zYYBJyVxXrBIEl9OEDnVwIVNAMQUrnUDhwrc5lq4/wkBooI2qjlVqJfrNdoR9i3l6A/i8DqMY/zQXpiiZgyVk7byqfkEEWiak1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YKa/glm0; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1705671672; x=1737207672;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MbsAdrN7i6BnaKJBhIQfCSADFTjl5gSJsfm5oYBjTQM=;
  b=YKa/glm04o1I0mL39E2SaNIh38LTaMUwqbMdKMTMZWFkYppV2rvs1Rfm
   Njj+kKvxZ3eirjBHTYKzNtUBIaBJhmVxUboIy5EAEiiy+3kcgkh8BEq1u
   VkXibGfJUaNM4/aBwhVk31mzJVwXaIvm+MZFtVRKs67HrDN4k2cQ3s6Ta
   SpDfi+SN9kzghJfDPaqU1aHGS6v/nJUzv2BPy7IgW5MnFV4gEpu31iWY4
   45nTPZsqd/ozFsLEMHrx9zH6TxPPjaofEW9bgT1K0NNYh1tUTRs09YNhT
   I5vfJuoRPlluyMTgSxWyZ/ZPz2A7KmOFZ8EARu8RbRUERb0uUnwVr6686
   w==;
X-IronPort-AV: E=Sophos;i="6.05,204,1701126000"; 
   d="scan'208";a="34983167"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 19 Jan 2024 14:41:10 +0100
Received: from [192.168.2.128] (SCHIFFERM-M2.tq-net.de [10.121.53.15])
	by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3DC49280075;
	Fri, 19 Jan 2024 14:41:10 +0100 (CET)
Message-ID: <5610a6223b54a845185f28f54999ad72269b72f5.camel@ew.tq-group.com>
Subject: Re: [PATCH] powerpc/6xx: set High BAT Enable flag on G2 cores
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux@ew.tq-group.com" <linux@ew.tq-group.com>,  Michael Ellerman
 <mpe@ellerman.id.au>
Date: Fri, 19 Jan 2024 14:41:10 +0100
In-Reply-To: <ad3d0d4d-f63b-4704-b829-e630a69a6cf3@csgroup.eu>
References: <20231221124538.159706-1-matthias.schiffer@ew.tq-group.com>
	 <2fad9563-09ee-4017-8a67-5958475d56c8@csgroup.eu>
	 <b4eae5a8f451a3d253521a61b9625e3d7634f430.camel@ew.tq-group.com>
	 <ad3d0d4d-f63b-4704-b829-e630a69a6cf3@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-22 at 18:41 +0000, Christophe Leroy wrote:
> Le 22/12/2023 =C3=A0 09:48, Matthias Schiffer a =C3=A9crit=C2=A0:
> > [Vous ne recevez pas souvent de courriers de matthias.schiffer@ew.tq-gr=
oup.com. D=C3=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/L=
earnAboutSenderIdentification ]
> >=20
> > On Thu, 2023-12-21 at 13:57 +0000, Christophe Leroy wrote:
> > >=20
> > >=20
> > > Le 21/12/2023 =C3=A0 13:45, Matthias Schiffer a =C3=A9crit :
> > > > MMU_FTR_USE_HIGH_BATS is set for G2-based cores (G2_LE, e300cX), bu=
t the
> > > > high BATs need to be enabled in HID2 to work. Add register definiti=
ons
> > > > and introduce a G2 variant of __setup_cpu_603.
> > >=20
> > > Well spotted.
> > >=20
> > > I have a mpc8321, hence e300c2. I never had the problem you had.
> > >=20
> > > But ... looks like U-boot configuration has CONFIG_HID2_HBE so that's
> > > set by U-boot indeed, that's the reason why I never had that problem.
> >=20
> > I'll extend the commit message to mention that U-Boot setting in v2.
> >=20
> >=20
> > >=20
> > > >=20
> > > > This fixes boot on CPUs like the MPC5200B with STRICT_KERNEL_RWX en=
abled.
> > > >=20
> > > > Fixes: e4d6654ebe6e ("powerpc/mm/32s: rework mmu_mapin_ram()")
> > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com=
>
> > > > ---
> > > >    arch/powerpc/include/asm/cpu_setup.h      |  1 +
> > > >    arch/powerpc/include/asm/reg.h            |  2 ++
> > > >    arch/powerpc/kernel/cpu_setup_6xx.S       | 25 +++++++++++++++++=
+++++-
> > > >    arch/powerpc/kernel/cpu_specs_book3s_32.h | 10 ++++-----
> > > >    4 files changed, 32 insertions(+), 6 deletions(-)
> > > >=20
> > > >=20
> > > > I have only tested this on the MPC5200B (G2_LE), but according to t=
he
> > > > e300 manual, e300cX cores should behave the same.
> > > >=20
> > > > The Fixes tag is the best I could come up with - I believe that the
> > > > underlying issue of setting USE_HIGH_BATS without actually enabling=
 them
> > > > is as old as Linux's PowerPC implementation, but the specific code
> > > > causing the boot failure was added in the mentioned commit.
> > >=20
> > > Agreed, before that only BATs 0 to 3 were used anyway.
> > > There was also BAT 4 used by platforms/embedded6xx/wii.c  , but that'=
s
> > > probably not a G2 ?
> > >=20
> > > >=20
> > > > Another issue I found in the code is that
> > > > arch/powerpc/platforms/52xx/lite5200_sleep.S uses the SPRN_HID2 def=
inition
> > > > which does not refer to HID2 on the 5200... but that will be for so=
meone
> > > > else to fix, if there is still anyone left using that platform.
> > >=20
> > > Maybe file an issue for it at https://github.com/linuxppc/issues/issu=
es
> > > if you don't plan to fix it ?
> > >=20
> > > By the way, it looks like the SPRN_HID2 definition we have is very
> > > specific to the IBM 750.
> > >=20
> >=20
> > IBM 750GX even - googling for IBM 750 came up with several other cores =
that either don't have HID2,
> > or have it at a different SPR.
> >=20
> >=20
> > > MPC 750 has SPRN_HID2 as 1011 =3D=3D 0x3f3 like others.
> >=20
> > > >=20
> > > >=20
> > > > diff --git a/arch/powerpc/include/asm/cpu_setup.h b/arch/powerpc/in=
clude/asm/cpu_setup.h
> > > > index 30e2fe3895024..68d804e74d221 100644
> > > > --- a/arch/powerpc/include/asm/cpu_setup.h
> > > > +++ b/arch/powerpc/include/asm/cpu_setup.h
> > > > @@ -35,6 +35,7 @@ void __setup_cpu_750fx(unsigned long offset, stru=
ct cpu_spec *spec);
> > > >    void __setup_cpu_7400(unsigned long offset, struct cpu_spec *spe=
c);
> > > >    void __setup_cpu_7410(unsigned long offset, struct cpu_spec *spe=
c);
> > > >    void __setup_cpu_745x(unsigned long offset, struct cpu_spec *spe=
c);
> > > > +void __setup_cpu_g2(unsigned long offset, struct cpu_spec *spec);
> > > >=20
> > > >    void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec *s=
pec);
> > > >    void __setup_cpu_ppc970MP(unsigned long offset, struct cpu_spec =
*spec);
> > > > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/=
asm/reg.h
> > > > index 4ae4ab9090a2d..f5641fcd1da85 100644
> > > > --- a/arch/powerpc/include/asm/reg.h
> > > > +++ b/arch/powerpc/include/asm/reg.h
> > > > @@ -617,6 +617,8 @@
> > > >    #endif
> > > >    #define SPRN_HID2      0x3F8           /* Hardware Implementatio=
n Register 2 */
> > >=20
> > > Should that HID2 be renamed to SPRN_HID2_750 to avoid confusion ?
> >=20
> > Makes sense (should the suffix be "750GX"?). I can also add a FIXME com=
ment to lite5200_sleep.S as
> > part of the rename.
> >=20
> >=20
> > >=20
> > > >    #define SPRN_HID2_GEKKO        0x398           /* Gekko HID2 Reg=
ister */
> > > > +#define SPRN_HID2_G2   0x3F3           /* G2 HID2 Register */
> > > > +#define  HID2_HBE_G2   (1<<18)         /* High BAT Enable (G2) */
> > > >    #define SPRN_IABR      0x3F2   /* Instruction Address Breakpoint=
 Register */
> > > >    #define SPRN_IABR2     0x3FA           /* 83xx */
> > > >    #define SPRN_IBCR      0x135           /* 83xx Insn Breakpoint C=
ontrol Reg */
> > > > diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/ker=
nel/cpu_setup_6xx.S
> > > > index f29ce3dd6140f..c67d32e04df9c 100644
> > > > --- a/arch/powerpc/kernel/cpu_setup_6xx.S
> > > > +++ b/arch/powerpc/kernel/cpu_setup_6xx.S
> > > > @@ -81,6 +81,20 @@ _GLOBAL(__setup_cpu_745x)
> > > >           bl      setup_745x_specifics
> > > >           mtlr    r5
> > > >           blr
> > > > +_GLOBAL(__setup_cpu_g2)
> > > > +       mflr    r5
> > > > +BEGIN_MMU_FTR_SECTION
> > > > +       li      r10,0
> > > > +       mtspr   SPRN_SPRG_603_LRU,r10           /* init SW LRU trac=
king */
> > > > +END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
> > >=20
> > > MMU_FTR_NEED_DTLB_SW_LRU is dedicated to e300 core. You should also
> > > remove it from __setup_cpu_603
> >=20
> > Will do, thanks.
>=20
> Thinking about it once more, can we do even more simple ?
>=20
> Why do we need that __setup_cpu_g2() at all ?
>=20
> You could just add the following into __set_cpu_603()
>=20
> diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S=20
> b/arch/powerpc/kernel/cpu_setup_6xx.S
> index c67d32e04df9..7b41e3884866 100644
> --- a/arch/powerpc/kernel/cpu_setup_6xx.S
> +++ b/arch/powerpc/kernel/cpu_setup_6xx.S
> @@ -21,6 +21,11 @@ BEGIN_MMU_FTR_SECTION
>   	li	r10,0
>   	mtspr	SPRN_SPRG_603_LRU,r10		/* init SW LRU tracking */
>   END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
> +BEGIN_MMU_FTR_SECTION
> +	mfspr	r11,SPRN_HID2_G2
> +	oris	r11,r11,HID2_HBE_G2@h
> +	mtspr	SPRN_HID2_G2,r11
> +END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
>=20
>   BEGIN_FTR_SECTION
>   	bl	__init_fpu_registers
> ---
>=20
> By the way, as your register is named SPRN_HID2_G2, the bit would better=
=20
> be named HID2_G2_HBE instead of HID2_HBE_G2 I think.

My intention was to keep this consistent with the SPRN_HID2_GEKKO define.

Regards,
Matthias




>=20
> Christophe
>=20
> >=20
> > >=20
> > > > +
> > > > +BEGIN_FTR_SECTION
> > > > +       bl      __init_fpu_registers
> > > > +END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
> > > > +       bl      setup_common_caches
> > > > +       bl      setup_g2_hid2
> > > > +       mtlr    r5
> > > > +       blr
> > > >=20
> > > >    /* Enable caches for 603's, 604, 750 & 7400 */
> > > >    SYM_FUNC_START_LOCAL(setup_common_caches)
> > > > @@ -115,6 +129,16 @@ SYM_FUNC_START_LOCAL(setup_604_hid0)
> > > >           blr
> > > >    SYM_FUNC_END(setup_604_hid0)
> > > >=20
> > > > +/* Enable high BATs for G2 (G2_LE, e300cX) */
> > > > +SYM_FUNC_START_LOCAL(setup_g2_hid2)
> > > > +       mfspr   r11,SPRN_HID2_G2
> > > > +       oris    r11,r11,HID2_HBE_G2@h
> > > > +       mtspr   SPRN_HID2_G2,r11
> > > > +       sync
> > > > +       isync
> > > > +       blr
> > > > +SYM_FUNC_END(setup_g2_hid2)
> > > > +
> > > >    /* 7400 <=3D rev 2.7 and 7410 rev =3D 1.0 suffer from some
> > > >     * erratas we work around here.
> > > >     * Moto MPC710CE.pdf describes them, those are errata
> > > > @@ -495,4 +519,3 @@ _GLOBAL(__restore_cpu_setup)
> > > >           mtcr    r7
> > > >           blr
> > > >    _ASM_NOKPROBE_SYMBOL(__restore_cpu_setup)
> > > > -
> > > > diff --git a/arch/powerpc/kernel/cpu_specs_book3s_32.h b/arch/power=
pc/kernel/cpu_specs_book3s_32.h
> > > > index 3714634d194a1..83f054fcf837c 100644
> > > > --- a/arch/powerpc/kernel/cpu_specs_book3s_32.h
> > > > +++ b/arch/powerpc/kernel/cpu_specs_book3s_32.h
> > > > @@ -69,7 +69,7 @@ static struct cpu_spec cpu_specs[] __initdata =3D=
 {
> > > >                   .mmu_features           =3D MMU_FTR_USE_HIGH_BATS=
,
> > > >                   .icache_bsize           =3D 32,
> > > >                   .dcache_bsize           =3D 32,
> > > > -               .cpu_setup              =3D __setup_cpu_603,
> > > > +               .cpu_setup              =3D __setup_cpu_g2,
> > > >                   .machine_check          =3D machine_check_generic=
,
> > > >                   .platform               =3D "ppc603",
> > > >           },
> > > > @@ -83,7 +83,7 @@ static struct cpu_spec cpu_specs[] __initdata =3D=
 {
> > > >                   .mmu_features           =3D MMU_FTR_USE_HIGH_BATS=
,
> > > >                   .icache_bsize           =3D 32,
> > > >                   .dcache_bsize           =3D 32,
> > > > -               .cpu_setup              =3D __setup_cpu_603,
> > > > +               .cpu_setup              =3D __setup_cpu_g2,
> > > >                   .machine_check          =3D machine_check_83xx,
> > > >                   .platform               =3D "ppc603",
> > > >           },
> > > > @@ -96,7 +96,7 @@ static struct cpu_spec cpu_specs[] __initdata =3D=
 {
> > > >                   .mmu_features           =3D MMU_FTR_USE_HIGH_BATS=
 | MMU_FTR_NEED_DTLB_SW_LRU,
> > > >                   .icache_bsize           =3D 32,
> > > >                   .dcache_bsize           =3D 32,
> > > > -               .cpu_setup              =3D __setup_cpu_603,
> > > > +               .cpu_setup              =3D __setup_cpu_g2,
> > > >                   .machine_check          =3D machine_check_83xx,
> > > >                   .platform               =3D "ppc603",
> > > >           },
> > > > @@ -109,7 +109,7 @@ static struct cpu_spec cpu_specs[] __initdata =
=3D {
> > > >                   .mmu_features           =3D MMU_FTR_USE_HIGH_BATS=
 | MMU_FTR_NEED_DTLB_SW_LRU,
> > > >                   .icache_bsize           =3D 32,
> > > >                   .dcache_bsize           =3D 32,
> > > > -               .cpu_setup              =3D __setup_cpu_603,
> > > > +               .cpu_setup              =3D __setup_cpu_g2,
> > > >                   .machine_check          =3D machine_check_83xx,
> > > >                   .num_pmcs               =3D 4,
> > > >                   .platform               =3D "ppc603",
> > > > @@ -123,7 +123,7 @@ static struct cpu_spec cpu_specs[] __initdata =
=3D {
> > > >                   .mmu_features           =3D MMU_FTR_USE_HIGH_BATS=
 | MMU_FTR_NEED_DTLB_SW_LRU,
> > > >                   .icache_bsize           =3D 32,
> > > >                   .dcache_bsize           =3D 32,
> > > > -               .cpu_setup              =3D __setup_cpu_603,
> > > > +               .cpu_setup              =3D __setup_cpu_g2,
> > > >                   .machine_check          =3D machine_check_83xx,
> > > >                   .num_pmcs               =3D 4,
> > > >                   .platform               =3D "ppc603",
> > > > --
> > > > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefe=
ld, Germany
> > > > Amtsgericht M=C3=BCnchen, HRB 105018
> > > > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, St=
efan Schneider
> > > > https://www.tq-group.com/
> >=20
> > --
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > https://www.tq-group.com/

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

