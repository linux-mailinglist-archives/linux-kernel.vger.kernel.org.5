Return-Path: <linux-kernel+bounces-122765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FD288FCD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C67129876E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45037CF1F;
	Thu, 28 Mar 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmT/LzuK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134435FB8B;
	Thu, 28 Mar 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621336; cv=none; b=rYqMWzbp4OzUZplsxER526DqLnc9ljRwfEmA7UpCoUw7U01+0AJLlhXg6E+qtGyswBmbs/FOJPUmkqOJHiApRCViPLkWhHZ4ZXwftWo970XRz4W0D293VpX/gZXIzM8z80UDB2Vd7wNsRUbptrS2DNJqYBHWtKq5nOYqlMrXGdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621336; c=relaxed/simple;
	bh=SKKICtTKjPR9yyFA9IuYbQmFcXbc8Pa5AvB15RTwNp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCZ8DwEe74IFG5P/IM9kzm9de1DdJq3O6vbpyjVWrwUL/bO22qd5DLTH3iyKgNhmxBGHIrH40+MDUEB/3dfLHUquGB6gxMC8J9+c5zkRCc8yLgXqgt4/VqxNvpwX16guDr3HZhtOlzFj/UCPoGD1nnstYSvp6VSQ9Zi44OXrLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmT/LzuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B0EC433F1;
	Thu, 28 Mar 2024 10:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711621335;
	bh=SKKICtTKjPR9yyFA9IuYbQmFcXbc8Pa5AvB15RTwNp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmT/LzuK8Fhxhn89z1WozrQ/vfZaBQGm57L9S0wsjaPNyYz6AQO3EqPfXp8TuADjJ
	 KnCLjXcivr/1Hr8aM3VmUtioJMSoavC1Nube1XBSrhmISzzMJg30vz7+iqmWvHBC8X
	 sxKFI1uxKzbv6cqT9PpjkYWl8Pqb1L1Uw256dz0SgFReghmPCs/XV5sBs2P1dtah75
	 GeAWD+sPu0cPRAVKf2kCsjqWBlVZtmUgDQ7ONtaa8mA10usHQd8zOIuz0HMY9Omtou
	 83F2BWfm4T2roHfl/obPuBRkV3dq3WjYeRaoBNRT5+gf47zl6zlQhf96tBmLF1t3Kz
	 QuG1Vm4/TF4Hg==
Date: Thu, 28 Mar 2024 18:08:58 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] riscv: dts: starfive: add Milkv Mars board device
 tree
Message-ID: <ZgVBurohYRDzFjgb@xhacker>
References: <20240131132600.4067-1-jszhang@kernel.org>
 <20240131132600.4067-7-jszhang@kernel.org>
 <20240206-magma-deem-2c88e45a545a@spud>
 <20240327-cotton-fang-37f6d8fde0e5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240327-cotton-fang-37f6d8fde0e5@spud>

On Wed, Mar 27, 2024 at 06:06:58PM +0000, Conor Dooley wrote:
> Yo,
> 
> On Tue, Feb 06, 2024 at 07:13:48PM +0000, Conor Dooley wrote:
> > On Wed, Jan 31, 2024 at 09:26:00PM +0800, Jisheng Zhang wrote:
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
> > > Add the devicetree file describing the currently supported features,
> > > namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > 
> > Got a dtbs_check issue in the patchwork CI:
> > 
> >   +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rgmii-rxin-clock: 'clock-frequency' is a required property
> >   +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> >   +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rmii-refin-clock: 'clock-frequency' is a required property
> >   +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> > 
> > Can you fix that please? Also, I applied some patches the other day that
> > seem to conflict quite a bit with the common board dts patch. Would you
> > please do a rebase on top of that please?
> 
> Been going through stuff on my todo list now that the merge window is
> closed. Could you please resend this with the rebase done?

Thanks for the reminding, I will rebase on 6.9-rc1 then send out the
patches.

> 
> Thanks,
> Conor.



