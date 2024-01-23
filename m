Return-Path: <linux-kernel+bounces-35228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B9D838E24
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56C21F226F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD55A5D91B;
	Tue, 23 Jan 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="KnVGmoN+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B15C61A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011542; cv=none; b=iv1PlIRmKuParRRocGS+sfVWE6ZTGJclkxmCf+f1+2a2rXeQlRn7vOOVHklZlBsjip0FP3HOy8v6a0e4gs3F16mTLTvzQzxA6oOojfOJhcD3tUKi8YgcpJjtVqUKH8NNgoT3xKPJY4VMder90Zaf2P64+YSSAQhr14a00vYwYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011542; c=relaxed/simple;
	bh=W8vtg2/UqbJFkSl9gks8oPIFwKx3vzj5iYyGfCEpmwU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYymRGXjMCj2wJGlwgTZZWZT9+abifm10ifC62MbJ766XD28MWYQzXfmWSicUuUGrOmOwCv24mCN9rFxOOCExlork+wondqkLOFR1uaah2O0tSKqC1tJLwYCICwfw4Ier0/sCOJbPTgnhsxCmOI13t4PFN84WY1Ucc3OJ/U78Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=KnVGmoN+; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1706011539; x=1737547539;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QyowHaKSq5r48J0lIW2adI/3JjSI0PpbZix4J7mH2Dw=;
  b=KnVGmoN+NwnR3hyfwDeu6qG82+6ZAV5Ssg29X1EiqONCAF7NMWaIuKNP
   yIxgPioytIa0pXl66ZHPJZkTMkXsl0/qjRrrx4jl8n6s546dEeOJsffLe
   1J73jTpr9qMj3V2AYGcoWf/n0FvUOuRj+o2zIzna2SH9uGrRv7lSTJ4mX
   C/KzQavGVqY/LL4ZNNMGpbax5zQg0n+wBw+P37EB//+eHq8d/1Cb7TRlO
   zPAfHWfj3UHl3XmFzhZ0LgscEGe99hw/FfKiz0nRfdUua4xEQvbDVUeYK
   gynOChjpQwQB8jSJDIsmepz96DRXz0PXkNzEZEJj8lratAP6tZxBQ+fM3
   Q==;
X-IronPort-AV: E=Sophos;i="6.05,214,1701126000"; 
   d="scan'208";a="35030276"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Jan 2024 13:05:31 +0100
Received: from [192.168.153.128] (SCHIFFERM-M3.tq-net.de [10.121.49.135])
	by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3CBFC280075;
	Tue, 23 Jan 2024 13:05:31 +0100 (CET)
Message-ID: <effe9e2c56baca76cbef09b0262c246478670bc2.camel@ew.tq-group.com>
Subject: Re: [PATCH] powerpc/6xx: set High BAT Enable flag on G2 cores
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux@ew.tq-group.com" <linux@ew.tq-group.com>,  Michael Ellerman
 <mpe@ellerman.id.au>
Date: Tue, 23 Jan 2024 13:05:30 +0100
In-Reply-To: <f8c2f1c8-0b43-47c6-9359-9aeeb14863eb@csgroup.eu>
References: <20231221124538.159706-1-matthias.schiffer@ew.tq-group.com>
	 <2fad9563-09ee-4017-8a67-5958475d56c8@csgroup.eu>
	 <b4eae5a8f451a3d253521a61b9625e3d7634f430.camel@ew.tq-group.com>
	 <ad3d0d4d-f63b-4704-b829-e630a69a6cf3@csgroup.eu>
	 <5610a6223b54a845185f28f54999ad72269b72f5.camel@ew.tq-group.com>
	 <f8c2f1c8-0b43-47c6-9359-9aeeb14863eb@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-19 at 13:53 +0000, Christophe Leroy wrote:
>=20
> Le 19/01/2024 =C3=A0 14:41, Matthias Schiffer a =C3=A9crit=C2=A0:
> > >=20
> > > Thinking about it once more, can we do even more simple ?
> > >=20
> > > Why do we need that __setup_cpu_g2() at all ?
> > >=20
> > > You could just add the following into __set_cpu_603()
> > >=20
> > > diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S
> > > b/arch/powerpc/kernel/cpu_setup_6xx.S
> > > index c67d32e04df9..7b41e3884866 100644
> > > --- a/arch/powerpc/kernel/cpu_setup_6xx.S
> > > +++ b/arch/powerpc/kernel/cpu_setup_6xx.S
> > > @@ -21,6 +21,11 @@ BEGIN_MMU_FTR_SECTION
> > >        li      r10,0
> > >        mtspr   SPRN_SPRG_603_LRU,r10           /* init SW LRU trackin=
g */
> > >    END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
> > > +BEGIN_MMU_FTR_SECTION
> > > +     mfspr   r11,SPRN_HID2_G2
> > > +     oris    r11,r11,HID2_HBE_G2@h
> > > +     mtspr   SPRN_HID2_G2,r11
> > > +END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
> > >=20
> > >    BEGIN_FTR_SECTION
> > >        bl      __init_fpu_registers
> > > ---
> > >=20
> > > By the way, as your register is named SPRN_HID2_G2, the bit would bet=
ter
> > > be named HID2_G2_HBE instead of HID2_HBE_G2 I think.
> >=20
> > My intention was to keep this consistent with the SPRN_HID2_GEKKO defin=
e.
>=20
> I don't understand what you mean. I can't see any bits defined for=20
> HID2_GEKKO.
>=20
> What I see which is simitar is the definition of TSC register for CELL CP=
U.
>=20
> #define SPRN_TSC_CELL	0x399	/* Thread switch control on Cell */
> #define   TSC_CELL_DEC_ENABLE_0	0x400000 /* Decrementer Interrupt */
> #define   TSC_CELL_DEC_ENABLE_1	0x200000 /* Decrementer Interrupt */
> #define   TSC_CELL_EE_ENABLE	0x100000 /* External Interrupt */
> #define   TSC_CELL_EE_BOOST	0x080000 /* External Interrupt Boost */
>=20
>=20
> They don't call it TSC_EE_BOOST_CELL or TSC_EE_ENABLE_CELL

Ah sorry, I got things mixed up. Will change the define to HID2_G2_HBE (or =
maybe HID_G2_LE_HBE?)
in v2.

Regards,
Matthias


>=20
>=20
> Christophe
>=20
> >=20
> > Regards,
> > Matthias
> >=20
> >=20
> >=20
> >=20
> > >=20
> > > Christophe
> > >=20
> > > >=20
> > > > >=20
> > > > > > +
> > > > > > +BEGIN_FTR_SECTION
> > > > > > +       bl      __init_fpu_registers
> > > > > > +END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
> > > > > > +       bl      setup_common_caches
> > > > > > +       bl      setup_g2_hid2
> > > > > > +       mtlr    r5
> > > > > > +       blr
> > > > > >=20
> > > > > >     /* Enable caches for 603's, 604, 750 & 7400 */
> > > > > >     SYM_FUNC_START_LOCAL(setup_common_caches)
> > > > > > @@ -115,6 +129,16 @@ SYM_FUNC_START_LOCAL(setup_604_hid0)
> > > > > >            blr
> > > > > >     SYM_FUNC_END(setup_604_hid0)
> > > > > >=20
> > > > > > +/* Enable high BATs for G2 (G2_LE, e300cX) */
> > > > > > +SYM_FUNC_START_LOCAL(setup_g2_hid2)
> > > > > > +       mfspr   r11,SPRN_HID2_G2
> > > > > > +       oris    r11,r11,HID2_HBE_G2@h
> > > > > > +       mtspr   SPRN_HID2_G2,r11
> > > > > > +       sync
> > > > > > +       isync
> > > > > > +       blr
> > > > > > +SYM_FUNC_END(setup_g2_hid2)
> > > > > > +
> > > > > >     /* 7400 <=3D rev 2.7 and 7410 rev =3D 1.0 suffer from some
> > > > > >      * erratas we work around here.
> > > > > >      * Moto MPC710CE.pdf describes them, those are errata
> > > > > > @@ -495,4 +519,3 @@ _GLOBAL(__restore_cpu_setup)
> > > > > >            mtcr    r7
> > > > > >            blr
> > > > > >     _ASM_NOKPROBE_SYMBOL(__restore_cpu_setup)
> > > > > > -
> > > > > > diff --git a/arch/powerpc/kernel/cpu_specs_book3s_32.h b/arch/p=
owerpc/kernel/cpu_specs_book3s_32.h
> > > > > > index 3714634d194a1..83f054fcf837c 100644
> > > > > > --- a/arch/powerpc/kernel/cpu_specs_book3s_32.h
> > > > > > +++ b/arch/powerpc/kernel/cpu_specs_book3s_32.h
> > > > > > @@ -69,7 +69,7 @@ static struct cpu_spec cpu_specs[] __initdata=
 =3D {
> > > > > >                    .mmu_features           =3D MMU_FTR_USE_HIGH=
_BATS,
> > > > > >                    .icache_bsize           =3D 32,
> > > > > >                    .dcache_bsize           =3D 32,
> > > > > > -               .cpu_setup              =3D __setup_cpu_603,
> > > > > > +               .cpu_setup              =3D __setup_cpu_g2,
> > > > > >                    .machine_check          =3D machine_check_ge=
neric,
> > > > > >                    .platform               =3D "ppc603",
> > > > > >            },
> > > > > > @@ -83,7 +83,7 @@ static struct cpu_spec cpu_specs[] __initdata=
 =3D {
> > > > > >                    .mmu_features           =3D MMU_FTR_USE_HIGH=
_BATS,
> > > > > >                    .icache_bsize           =3D 32,
> > > > > >                    .dcache_bsize           =3D 32,
> > > > > > -               .cpu_setup              =3D __setup_cpu_603,
> > > > > > +               .cpu_setup              =3D __setup_cpu_g2,
> > > > > >                    .machine_check          =3D machine_check_83=
xx,
> > > > > >                    .platform               =3D "ppc603",
> > > > > >            },
> > > > > > @@ -96,7 +96,7 @@ static struct cpu_spec cpu_specs[] __initdata=
 =3D {
> > > > > >                    .mmu_features           =3D MMU_FTR_USE_HIGH=
_BATS | MMU_FTR_NEED_DTLB_SW_LRU,
> > > > > >                    .icache_bsize           =3D 32,
> > > > > >                    .dcache_bsize           =3D 32,
> > > > > > -               .cpu_setup              =3D __setup_cpu_603,
> > > > > > +               .cpu_setup              =3D __setup_cpu_g2,
> > > > > >                    .machine_check          =3D machine_check_83=
xx,
> > > > > >                    .platform               =3D "ppc603",
> > > > > >            },
> > > > > > @@ -109,7 +109,7 @@ static struct cpu_spec cpu_specs[] __initda=
ta =3D {
> > > > > >                    .mmu_features           =3D MMU_FTR_USE_HIGH=
_BATS | MMU_FTR_NEED_DTLB_SW_LRU,
> > > > > >                    .icache_bsize           =3D 32,
> > > > > >                    .dcache_bsize           =3D 32,
> > > > > > -               .cpu_setup              =3D __setup_cpu_603,
> > > > > > +               .cpu_setup              =3D __setup_cpu_g2,
> > > > > >                    .machine_check          =3D machine_check_83=
xx,
> > > > > >                    .num_pmcs               =3D 4,
> > > > > >                    .platform               =3D "ppc603",
> > > > > > @@ -123,7 +123,7 @@ static struct cpu_spec cpu_specs[] __initda=
ta =3D {
> > > > > >                    .mmu_features           =3D MMU_FTR_USE_HIGH=
_BATS | MMU_FTR_NEED_DTLB_SW_LRU,
> > > > > >                    .icache_bsize           =3D 32,
> > > > > >                    .dcache_bsize           =3D 32,
> > > > > > -               .cpu_setup              =3D __setup_cpu_603,
> > > > > > +               .cpu_setup              =3D __setup_cpu_g2,
> > > > > >                    .machine_check          =3D machine_check_83=
xx,
> > > > > >                    .num_pmcs               =3D 4,
> > > > > >                    .platform               =3D "ppc603",
> > > > > > --
> > > > > > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 S=
eefeld, Germany
> > > > > > Amtsgericht M=C3=BCnchen, HRB 105018
> > > > > > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl=
, Stefan Schneider
> > > > > > https://www.tq-group.com/
> > > >=20
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
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

