Return-Path: <linux-kernel+bounces-74926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72B085E01B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1621F2501B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B869E8005A;
	Wed, 21 Feb 2024 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Tyx+Lg7G"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650AD7C098;
	Wed, 21 Feb 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526526; cv=none; b=PgN42h3Qo7NSF2prmq73azTy8LgAvzQZYNFUP2ptDTFxqYqT0AimS9asYabkLGFDxe4s/xknsCibr9YjcJ70Hgr3i/MmCy80f/t1i/0ImPcyO2+wv6735g0xOr0uNrOBUyDGz/awepPnr3Skf2CnmOT2p2kZEDW1n4OIM0sskBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526526; c=relaxed/simple;
	bh=qfmyZSJgxNHQKChzfs713W6+r1H1kW/lMOe8B8MNPuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5dnCK/Uc2KshSfrAbiHjJzLXy05E4s/yHDN99in4Zih1Gpi13tkezXuCSD6Oe6Qvn3v/MQTMYSDyMbDcMhjPmDMhpbDXr1xvmRO1QaohTzU+wXHaZ7503vANLZjDCfUpu7eIXxE/UZWVQYs0ZPdcXegmfIzK2g0Pr+ONAbMbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Tyx+Lg7G; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708526523; x=1740062523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FZAuBeWNVe7S926YYHfB+88G6fnv3frBjDDyTaf2+Wc=;
  b=Tyx+Lg7GPmAtAvz+XVYIAZeQgMCIWh6X957kunGrrBUNWYqewfJvb4Ss
   Yqh+hZcnwaMZVOj8TuKsqNvCJIMgREVx8NTcE8s0R4JCh9FQpih6+RfbK
   J7IOl6XbE/eE5JuLnJo1IWiURlGm0l4eshkh6KdxAfF49gh03Bs6CV36i
   z96qN6uZUS24I0D6dOIE2nBMYUXlbVrbROO0ndY/EjRrlIryXyaZ8cJDl
   55+noFaxohXylgyJYA8skSamyFnRe4IDyM2xuj7jiLTqj7wfjbkorulkd
   FAQYmoWlNGD9wTB08J8F5Fj3FFrg/tjDgVNpN6QmIWKiuhwErI5cOJLxO
   g==;
X-IronPort-AV: E=Sophos;i="6.06,175,1705359600"; 
   d="scan'208";a="35525870"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Feb 2024 15:42:01 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1400B280075;
	Wed, 21 Feb 2024 15:42:01 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Rob Herring <robh@kernel.org>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the arm-soc-fixes tree
Date: Wed, 21 Feb 2024 15:42:00 +0100
Message-ID: <13457561.uLZWGnKmhe@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAL_Jsq+2ri0JsmuU184YGj=p53jSxn+8EZq_FuBbMjsVyNLvtw@mail.gmail.com>
References: <20240221092826.748e70c4@canb.auug.org.au> <20240221163010.5f81813a@canb.auug.org.au> <CAL_Jsq+2ri0JsmuU184YGj=p53jSxn+8EZq_FuBbMjsVyNLvtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

Am Mittwoch, 21. Februar 2024, 14:58:32 CET schrieb Rob Herring:
> On Tue, Feb 20, 2024 at 10:30=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.=
org.au> wrote:
> >
> > Hi all,
> >
> > On Wed, 21 Feb 2024 09:28:26 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
> > >
> > > After merging the arm-soc-fixes tree, today's linux-next build (arm
> > > multi_v7_defconfig) produced this warning:
> > >
> > > arch/arm/boot/dts/renesas/r8a7790-lager.dts:444.11-458.5: Warning (in=
terrupt_provider): /i2c-mux4/pmic@58: Missing '#interrupt-cells' in interru=
pt provider
> > > arch/arm/boot/dts/renesas/r8a7790-lager.dtb: Warning (interrupt_map):=
 Failed prerequisite 'interrupt_provider'
> > > arch/arm/boot/dts/renesas/r8a7792-blanche.dts:376.10-392.4: Warning (=
interrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' =
in interrupt provider
> > > arch/arm/boot/dts/renesas/r8a7792-blanche.dtb: Warning (interrupt_map=
): Failed prerequisite 'interrupt_provider'
> > > arch/arm/boot/dts/renesas/r8a7790-stout.dts:344.10-362.4: Warning (in=
terrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in=
 interrupt provider
> > > arch/arm/boot/dts/renesas/r8a7790-stout.dtb: Warning (interrupt_map):=
 Failed prerequisite 'interrupt_provider'
> > > arch/arm/boot/dts/renesas/r8a7791-koelsch.dts:816.10-830.4: Warning (=
interrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' =
in interrupt provider
> > > arch/arm/boot/dts/renesas/r8a7791-koelsch.dtb: Warning (interrupt_map=
): Failed prerequisite 'interrupt_provider'
> > > arch/arm/boot/dts/renesas/r8a7791-porter.dts:410.10-420.4: Warning (i=
nterrupt_provider): /soc/i2c@e60b0000/pmic@5a: Missing '#interrupt-cells' i=
n interrupt provider
> > > arch/arm/boot/dts/renesas/r8a7791-porter.dtb: Warning (interrupt_map)=
: Failed prerequisite 'interrupt_provider'
> > > arch/arm/boot/dts/renesas/r8a7794-alt.dts:450.10-464.4: Warning (inte=
rrupt_provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in i=
nterrupt provider
> > > arch/arm/boot/dts/renesas/r8a7794-alt.dtb: Warning (interrupt_map): F=
ailed prerequisite 'interrupt_provider'
> > > arch/arm/boot/dts/renesas/r8a7794-silk.dts:436.10-454.4: Warning (int=
errupt_provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in =
interrupt provider
> > > arch/arm/boot/dts/renesas/r8a7794-silk.dtb: Warning (interrupt_map): =
=46ailed prerequisite 'interrupt_provider'
> > > arch/arm/boot/dts/renesas/r8a7793-gose.dts:756.10-770.4: Warning (int=
errupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in =
interrupt provider
> > > arch/arm/boot/dts/renesas/r8a7793-gose.dtb: Warning (interrupt_map): =
=46ailed prerequisite 'interrupt_provider'
> > >
> > > Introduced/exposed by commit
> > >
> > >   78b6f8e7379b ("dtc: Enable dtc interrupt_provider check")
> > >
> > > I guess you missed some :-(
> >
> > Also these from the arm64 defconfig build:
> >
> > arch/arm64/boot/dts/freescale/mba8xx.dtsi:233.20-249.4: Warning (interr=
upt_provider): /bus@5a000000/i2c@5a810000/gpio@70: Missing '#interrupt-cell=
s' in interrupt provider
> > arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dtb: Warning (int=
errupt_map): Failed prerequisite 'interrupt_provider'
> > arch/arm64/boot/dts/freescale/mba8xx.dtsi:233.20-249.4: Warning (interr=
upt_provider): /bus@5a000000/i2c@5a810000/gpio@70: Missing '#interrupt-cell=
s' in interrupt provider
> > arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dtb: Warning (int=
errupt_map): Failed prerequisite 'interrupt_provider'
>=20
> Looks like a new platform in next.
>=20
> Alexander, Can you fix these?

Thanks for reminding me. This was already fixed on my queue.
Just send the patch, you are on CC as well.

Thanks and best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



