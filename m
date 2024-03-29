Return-Path: <linux-kernel+bounces-124065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E79E08911BC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881B6B22070
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA37347B6;
	Fri, 29 Mar 2024 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxK43KrP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED01E51F;
	Fri, 29 Mar 2024 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711680352; cv=none; b=DGcUEs0hRfYYDSrVGdgEOuen5cdae9MXgOjMqxCU278RR1xfPXmVk+ZTcvQ/sEqKYyMxeAoVVm1WkVE8XJvBpmZr+5MfuQ2ADZY3DvTvWgewfUW/wqz1JtvaBrm29wKjLPJtipJHDU2NcWM1trFIwtkSHeOwECM0cphAuVOhK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711680352; c=relaxed/simple;
	bh=j1YUfVQ6ICunpsAc5+qQcNo3yWuaSiK42DIxxNqCOBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLSUrScmRyX3ZvL0UFNrHzoPlSVNN2tei684uCmhtwL+Dcep8VXvI2tH3C9p3uHY0bDQ+r/et5iA6PQO5V5QexdljAXtYjpzPcnLC8MDAufU9bqx+WdwjSh7LGXmsCqIWB38QlMUZ2y8RD5D2o0eWphxA7k8nX8Qmc7cJ+e/Xkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxK43KrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F0FC433C7;
	Fri, 29 Mar 2024 02:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711680351;
	bh=j1YUfVQ6ICunpsAc5+qQcNo3yWuaSiK42DIxxNqCOBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxK43KrPlx5P5kYFjlxotb1ClA1QKLmPe1CgdbhWdn+kUd1XZFBmiTR6tk7h2kV13
	 ACtIZgwAJEYjzSY1deB/KdG0t6nt5vdJHimhlZ6FGXathzYqs/S9Dojkc3F9NJSC20
	 ByEZ85yNoKT8/66OxG6BYd/WFtPCyoXBXQAFt1LXOmDaBmXnwoUiodCVP15W3Zq44b
	 /Jg4dS4+NhoBorWqwDY36hORNRXOXraMBIsh8bvfBFa3ICsCJIPhMuoSD+LKXC+xZW
	 Scu/xvIsuHtgEfntHASzxx/MZBWIPiSE7ych6jW4UHw/V0iwqiIIAOE2XpfvEmpgTw
	 wYjbQPvlhuTQg==
Date: Fri, 29 Mar 2024 10:32:34 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] riscv: dts: starfive: add Milkv Mars board device
 tree
Message-ID: <ZgYoQnn6ef29F7xt@xhacker>
References: <20240131132600.4067-1-jszhang@kernel.org>
 <20240131132600.4067-7-jszhang@kernel.org>
 <20240206-magma-deem-2c88e45a545a@spud>
 <20240327-cotton-fang-37f6d8fde0e5@spud>
 <ZgVBurohYRDzFjgb@xhacker>
 <CAJM55Z8O20qjYmbjwOOE2CDCrWhCDGJ-jXY9TsR2hMSn-gEFtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJM55Z8O20qjYmbjwOOE2CDCrWhCDGJ-jXY9TsR2hMSn-gEFtQ@mail.gmail.com>

On Thu, Mar 28, 2024 at 05:45:21AM -0700, Emil Renner Berthing wrote:
> Jisheng Zhang wrote:
> > On Wed, Mar 27, 2024 at 06:06:58PM +0000, Conor Dooley wrote:
> > > Yo,
> > >
> > > On Tue, Feb 06, 2024 at 07:13:48PM +0000, Conor Dooley wrote:
> > > > On Wed, Jan 31, 2024 at 09:26:00PM +0800, Jisheng Zhang wrote:
> > > > > The Milkv Mars is a development board based on the Starfive JH7110 SoC.
> > > > > The board features:
> > > > >
> > > > > - JH7110 SoC
> > > > > - 1/2/4/8 GiB LPDDR4 DRAM
> > > > > - AXP15060 PMIC
> > > > > - 40 pin GPIO header
> > > > > - 3x USB 3.0 host port
> > > > > - 1x USB 2.0 host port
> > > > > - 1x M.2 E-Key
> > > > > - 1x eMMC slot
> > > > > - 1x MicroSD slot
> > > > > - 1x QSPI Flash
> > > > > - 1x 1Gbps Ethernet port
> > > > > - 1x HDMI port
> > > > > - 1x 2-lane DSI and 1x 4-lane DSI
> > > > > - 1x 2-lane CSI
> > > > >
> > > > > Add the devicetree file describing the currently supported features,
> > > > > namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.
> > > > >
> > > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > >
> > > > Got a dtbs_check issue in the patchwork CI:
> > > >
> > > >   +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rgmii-rxin-clock: 'clock-frequency' is a required property
> > > >   +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> > > >   +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rmii-refin-clock: 'clock-frequency' is a required property
> > > >   +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> > > >
> > > > Can you fix that please? Also, I applied some patches the other day that
> > > > seem to conflict quite a bit with the common board dts patch. Would you
> > > > please do a rebase on top of that please?
> > >
> > > Been going through stuff on my todo list now that the merge window is
> > > closed. Could you please resend this with the rebase done?
> >
> > Thanks for the reminding, I will rebase on 6.9-rc1 then send out the
> > patches.
> 
> Hi Jisheng,

Hi,

> 
> A rebase would be great. It looks good to me, but could you maybe call the
> common .dtsi something more generic like jh7110-common.dtsi like the
> jh7100-common.dtsi. If we'll see other boards based on the jh7110 upstreamed

make sense, will do in v4 series.

> (eg. Star64) I suspect they'll also be heavily based on^M^M^M similar to the
> VF2 schematics.
> 
> /Emil
> 
> >
> > >
> > > Thanks,
> > > Conor.
> >
> >

