Return-Path: <linux-kernel+bounces-74833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A22C85DCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA848B25559
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C46979DAB;
	Wed, 21 Feb 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxmkNcwB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3276C99;
	Wed, 21 Feb 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523926; cv=none; b=IKsIRd5BdlNJa6sEmuDa2Ttqa6shMGKhVqL3/8rGbSrmWI7DIGs0A5jCG4CZZY7rcm/ireWlkk2PAVTdsB+wT9B04y/6shjs0ShXlugQorW/MHFbzEThEbpoVpL+cuuchfyFAX405Z+kC/Kbmi1anpo2sFQ+1rvOjV/PJdGKuYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523926; c=relaxed/simple;
	bh=teJ7pXqSdAToziyul/1Ti6hujfnZZLjYbygcA9TNKKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8T6cTUgS62kyUk3JvNrqz0hdcT2yNh0bA3BLLWeaf3MeF1FpSnMUz/EVjSX5cVp/P73tsGyZJTHxcuBV6VrYtYhZnI1rkT14PoSo+7ikEym8zLdRUZr/D2qDcbZ1eqQwTnXbjg0zpVxmQZsUFj6BLu9WA2UZXmPSE5BWTLNMp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxmkNcwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5094BC43390;
	Wed, 21 Feb 2024 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708523926;
	bh=teJ7pXqSdAToziyul/1Ti6hujfnZZLjYbygcA9TNKKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oxmkNcwBkogUNWxz7hT4gEUhGP6mgJZ8kA+PtDJrJo8CoEizH6Ra0pAZuB5Euy4tE
	 +IxQ5GTrc19sHG+ji/uxbW8RGv51o+YD+yhYicWbDmjUZT+2dwDA9k/T4gOXY7I/DQ
	 QOMwQ972mkUR32OQKjIqdZGZVSsOvaj+WUWAY2jieVaxi/vDIlmiN/RwU70LDWHrVR
	 qkfWkb3xHzoGkmeALpAVm/kRA0W1FgDDNaAMjiqzvaYXj6c7yykb53NPQhxiXpSK8H
	 J+uJIJcK8j+l24jkwwTL3N0r2lYvlLREvFSUCPIlgxKHYlL8TR6Bjp2RslhFBagWex
	 yhg4TAw2Cu9fg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d2531294faso11559121fa.2;
        Wed, 21 Feb 2024 05:58:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVk4YmcG5/PK7zpDezLdBQqX2a7Y9pQsnvwm+zF8eRHXm1OpuUUhueen82rpFGpdYuky/lAoFMZJRZLABAxudqt6eBahy8EAlPFqy0cQNWfGpDUukVBbtEaOAhD0zIy1AiNc8+RLhx8Ng==
X-Gm-Message-State: AOJu0YwoLV7vWESBYYostnEHtxZkd2oIycFAB7EDs+VVv28Q5gCCpsQQ
	ENmBl5S9TbgXM/ly+5Nn3ovuJ1SzVVfi8I5DCKYBGC4fy3ObQy96tfEJn3p8H7H+bVkKUtk9T6/
	kOZ3iDn0kPYXw5uOXyGFISbCHuQ==
X-Google-Smtp-Source: AGHT+IFfYxwetv16vXXURQANSHDR29q5IWSpQmkFIROiXUwQeOWA0DE7B9LbakxxZJ8ILroSEqQpC1Cf4DxsVtHzHhY=
X-Received: by 2002:a05:651c:9:b0:2d2:555f:b4ae with SMTP id
 n9-20020a05651c000900b002d2555fb4aemr1169907lja.51.1708523924540; Wed, 21 Feb
 2024 05:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092826.748e70c4@canb.auug.org.au> <20240221163010.5f81813a@canb.auug.org.au>
In-Reply-To: <20240221163010.5f81813a@canb.auug.org.au>
From: Rob Herring <robh@kernel.org>
Date: Wed, 21 Feb 2024 06:58:32 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+2ri0JsmuU184YGj=p53jSxn+8EZq_FuBbMjsVyNLvtw@mail.gmail.com>
Message-ID: <CAL_Jsq+2ri0JsmuU184YGj=p53jSxn+8EZq_FuBbMjsVyNLvtw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm-soc-fixes tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, 
	ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 10:30=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi all,
>
> On Wed, 21 Feb 2024 09:28:26 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the arm-soc-fixes tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> >
> > arch/arm/boot/dts/renesas/r8a7790-lager.dts:444.11-458.5: Warning (inte=
rrupt_provider): /i2c-mux4/pmic@58: Missing '#interrupt-cells' in interrupt=
 provider
> > arch/arm/boot/dts/renesas/r8a7790-lager.dtb: Warning (interrupt_map): F=
ailed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7792-blanche.dts:376.10-392.4: Warning (in=
terrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in=
 interrupt provider
> > arch/arm/boot/dts/renesas/r8a7792-blanche.dtb: Warning (interrupt_map):=
 Failed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7790-stout.dts:344.10-362.4: Warning (inte=
rrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in i=
nterrupt provider
> > arch/arm/boot/dts/renesas/r8a7790-stout.dtb: Warning (interrupt_map): F=
ailed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7791-koelsch.dts:816.10-830.4: Warning (in=
terrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in=
 interrupt provider
> > arch/arm/boot/dts/renesas/r8a7791-koelsch.dtb: Warning (interrupt_map):=
 Failed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7791-porter.dts:410.10-420.4: Warning (int=
errupt_provider): /soc/i2c@e60b0000/pmic@5a: Missing '#interrupt-cells' in =
interrupt provider
> > arch/arm/boot/dts/renesas/r8a7791-porter.dtb: Warning (interrupt_map): =
Failed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7794-alt.dts:450.10-464.4: Warning (interr=
upt_provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in int=
errupt provider
> > arch/arm/boot/dts/renesas/r8a7794-alt.dtb: Warning (interrupt_map): Fai=
led prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7794-silk.dts:436.10-454.4: Warning (inter=
rupt_provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in in=
terrupt provider
> > arch/arm/boot/dts/renesas/r8a7794-silk.dtb: Warning (interrupt_map): Fa=
iled prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7793-gose.dts:756.10-770.4: Warning (inter=
rupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in in=
terrupt provider
> > arch/arm/boot/dts/renesas/r8a7793-gose.dtb: Warning (interrupt_map): Fa=
iled prerequisite 'interrupt_provider'
> >
> > Introduced/exposed by commit
> >
> >   78b6f8e7379b ("dtc: Enable dtc interrupt_provider check")
> >
> > I guess you missed some :-(
>
> Also these from the arm64 defconfig build:
>
> arch/arm64/boot/dts/freescale/mba8xx.dtsi:233.20-249.4: Warning (interrup=
t_provider): /bus@5a000000/i2c@5a810000/gpio@70: Missing '#interrupt-cells'=
 in interrupt provider
> arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dtb: Warning (inter=
rupt_map): Failed prerequisite 'interrupt_provider'
> arch/arm64/boot/dts/freescale/mba8xx.dtsi:233.20-249.4: Warning (interrup=
t_provider): /bus@5a000000/i2c@5a810000/gpio@70: Missing '#interrupt-cells'=
 in interrupt provider
> arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dtb: Warning (inter=
rupt_map): Failed prerequisite 'interrupt_provider'

Looks like a new platform in next.

Alexander, Can you fix these?

Rob

