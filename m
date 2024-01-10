Return-Path: <linux-kernel+bounces-22324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D735D829C32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655DAB27E83
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AE84E1BF;
	Wed, 10 Jan 2024 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRycpO1R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A604C60B;
	Wed, 10 Jan 2024 14:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C4EC433F1;
	Wed, 10 Jan 2024 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704895840;
	bh=eY10UxSczupCveV5wCR/tuzRKmbvyyPqzGr7zHPzSe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRycpO1REDWemAYzGCy71bi5syZzypvnGLZFml/7L23ZdPXbJpGrpExWnEYXVnhCO
	 3QIukT2p021LLY324GJ0hpNzicFUCNt93DPJKDfrlS2EMhc/QEvtZIEZAHHnkYh/Sa
	 QfnbtplBKkJCY+DN876SM5sljL9/BzO6tzfDg0KFozNjo+86DDQ/TTJehbcVXbyWBo
	 IVx77egR2tIh6V+zn7nZL2IP1k2fHe4brbrsBL9f0PeZwTqE2xKI3mfmnwsp2YfiwA
	 puIskItzVWI6OT27l2oRmyFe+IFvFOzRa7Kd2BMlQUN4YBnEQXeSaZ+5eSekV+kAz9
	 CCHIBlaYc3TUw==
Date: Wed, 10 Jan 2024 21:57:50 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] riscv: dts: starfive: add Milkv Mars board device
 tree
Message-ID: <ZZ6iXsDJVs3FIrOl@xhacker>
References: <20231202153353.635-1-jszhang@kernel.org>
 <CAJM55Z-9Y=QitvAX+z=XTTMM0CGRzGMD5z0H_Bzv=Q85b49rpQ@mail.gmail.com>
 <20240110-eternal-proofing-8a33201ff727@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240110-eternal-proofing-8a33201ff727@spud>

On Wed, Jan 10, 2024 at 01:53:11PM +0000, Conor Dooley wrote:
> On Sat, Dec 02, 2023 at 02:07:50PM -0800, Emil Renner Berthing wrote:
> > Jisheng Zhang wrote:
> > > The Milkv Mars is a development board based on the Starfive JH7110 SoC.
> > > The board features:
> > >
> > > - JH7110 SoC
> > > - 1/2/4/8 GiB LPDDR4 DRAM
> > > - AXP15060 PMIC
> > > - 40 pin GPIO header
> > > - 3x USB 3.0 host port
> > > - 1x USB 2.0 host port
> > > - 1x M.2 E-Key
> > > - 1x eMMC slot
> > > - 1x MicroSD slot
> > > - 1x QSPI Flash
> > > - 1x 1Gbps Ethernet port
> > > - 1x HDMI port
> > > - 1x 2-lane DSI and 1x 4-lane DSI
> > > - 1x 2-lane CSI
> > >
> > > patch1 adds 'cpus' label
> > > patch2 adds "milkv,mars" board dt-binding
> > > patch3 adds the devicetree file describing the currently supported
> > > features:
> > > Namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.
> > >
> > > Since v1:
> > >  - add two new patches which add "cpus" label and board dt-binding
> > >  - adopt Krzysztof's suggestions, thanks
> > >
> > > Hi Conor,
> > >
> > > I see you have sent a patch which moves the timebase-frequency property
> > > to soc dtsi, but this series doesn't rebase on that. I can update it
> > > once your patch is merged.
> > 
> > Hi Jisheng,
> > 
> > Thanks for working on this! On the JH7110 the mtime derives almost directly
> > from the external oscillator like this:
> > 
> > osc (24MHz) -> rtc_toggle (div 6) -> mtime (4MHz)
> > 
> > So to me it makes sense to define the timebase-frequency in the same file as
> > the frequency of the external oscillator.
> > 
> > In general it looks good, but if you do
> > 
> >   diff -Naur jh7110-{starfive-visionfive-2.dtsi,milkv-mars.dts}
> > 
> > you'll see that those two files are almost identical. Even external clock
> > speeds and all the pin configuration are the same. I'd strongly prefer to have
> > all that factored out in a common .dtsi so fixes don't get out of sync.
> 
> I'm gonna mark this as changes requested on patchwork because of this
> comment. LMK if you don't think this is worth another version Emil.

Yeah a new version is needed. And I think it's a bit late for this
window, so the new version will be out once v6.8-rc1 is out.

Thanks


