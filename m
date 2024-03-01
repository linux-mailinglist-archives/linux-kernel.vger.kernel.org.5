Return-Path: <linux-kernel+bounces-88521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B627386E2D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5A1B21C79
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37BB6EB7C;
	Fri,  1 Mar 2024 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkIbbKag"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A16D1D8;
	Fri,  1 Mar 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301258; cv=none; b=TWXxFktTabKxRiGVbZCh4R6xSblZ//KLSAqA5NI2yYVQNBPYVyPm26dBZaLurd+Td8fRg5BCwfN+ytvk+3ZL7Hh89a+3EaBs7PVH2ZLIe7RMdE+A9aUidOUT9nNA1kSp2vKdOmzecY5W71k4FM/2BHGywhUwmx3qartIvFhaAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301258; c=relaxed/simple;
	bh=/OaGiLJtrULdsIFtAqm8m7gXWB3q0oZKx+xJ7Drw82w=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=AcksUr7Bw1WV+sSDpgGvMyhQfvoNqr4sfgnGK17Oo/exWtZvKt+u+2TX/x8aIl4KvGfdHUcl16kuIFeWxxJVfniQ0dQ6lIh8WEiJJucpbUDSuC7A0/19f+XJ6vZbcFkqreO3ACrJHrOgJCVzWInWr8MGi3Grn5Qiez52KA8nWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkIbbKag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B250C433F1;
	Fri,  1 Mar 2024 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709301257;
	bh=/OaGiLJtrULdsIFtAqm8m7gXWB3q0oZKx+xJ7Drw82w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HkIbbKagH9iaMIX9jJ79WqOKt++6DwSUwKeDinv2zEv9lechl0hJW9KIBDWASW0Ro
	 JtknL2zMZYX5rhJKXYR4X58vpOnpsBcH+ODg/NHOZEpJsqA+IYlB9n1z33QbxVResH
	 FA5Rs6DSXBIwq3gTw1v/Jky+bGgYTPPIoG5OfcyTAS/ALgKIxy8nLrzYma+a9kPGXk
	 ga10OGlFBBjiumNLDsNg6/tzctk9eADMzQb0PZ1DGTGznaDh5jGRod5Hl8dZhV2G7P
	 NYBvwgjnPj9S4GKUFxKTdhifqdn5xKmX7S1NutNDEEP6ybdOkJY4xzZ8spf4YdFGuo
	 QbbJhx/K34+GQ==
Date: Fri, 01 Mar 2024 07:54:16 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Adam Ford <aford173@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 aford@beaconembedded.com, imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20240229233556.116944-1-aford173@gmail.com>
References: <20240229233556.116944-1-aford173@gmail.com>
Message-Id: <170930076224.1938438.16034343987415144490.robh@kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp-beacon-kit: Move sai3 to
 Audio_PLL1


On Thu, 29 Feb 2024 17:35:54 -0600, Adam Ford wrote:
> The Beacon board has an LVDS display that cannot get a proper clock rate
> from Video_PLL if the DSI is operational due to the way the clock divides
> the pixel clocks from video_pll.  To make the LVDS work, the LVDS needs
> to use an alternative clock.
> 
> Because the clock rated needed for the LDB driving the LVDS display
> isn't divisible by the clock rate needed by SAI3, move SAI3 to use
> Audio_PLL1, and reconfigure the CODEC to use a 12MHz fixed clock.
> 
> Because these clocks are no longer in sync with each other, the sound
> generated as the wrong pitch, so reconfigure the SAI3 to be the master
> since the CODEC can internally compensate when fed a fixed clock
> reference, even if it is not an even multiple of the desired rate.
> 
> This now leaves AUDIO_PLL2 completely free for the LDB without
> compromising the audio sound from the codec.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 


My bot found new DT warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-beacon-kit.dtb' for 20240229233556.116944-1-aford173@gmail.com:

arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dtb: lvds-1: panel-timing:vsync-active:0:0: 3 is not one of [0, 1]
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dtb: lvds-1: compatible:0: 'panel-lvds' is not one of ['admatec,9904379', 'auo,b101ew05', 'chunghwa,claa070wp03xg', 'edt,etml0700z9ndha', 'hannstar,hsd101pww2', 'hydis,hv070wx2-1e0', 'tbs,a711-panel']
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dtb: lvds-1: compatible: ['panel-lvds'] is too short
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dtb: lvds-1: Unevaluated properties are not allowed ('backlight', 'compatible', 'height-mm', 'panel-timing', 'port', 'power-supply', 'width-mm' were unexpected)
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#






