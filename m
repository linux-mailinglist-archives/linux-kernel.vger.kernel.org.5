Return-Path: <linux-kernel+bounces-145734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757268A5A28
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CDD284130
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060E2156251;
	Mon, 15 Apr 2024 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3sk12O1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712D155A4E;
	Mon, 15 Apr 2024 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206854; cv=none; b=sa1JefNctcfZmq+HhW5MMrC8WO6qwmVKuxF8HHPdLVolc8uLm81xqvlZ5yRqOjHxu1ePQOp/LmH8q2pzaCExm+wXd2lRy4G3OwfbT+/9Pv64PNMRvOfvtLYZ60YRjYklaVp0cVDXcVRsnvnbwtgXm+IGnFvvHMHIpM+7fgWsa/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206854; c=relaxed/simple;
	bh=rV4vumlD5sNk0OfLAqgD11a4eTS4oTmbL+qXO4bP6Rs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=WBc12HsbyDAZkbg6wJaMmOlKx9f6vuRU67Uo++NkIbe2JRELxOxkzsUteocqBE2yOVhVF6zC38sf4NWrnBUp0cWtg8YxwkkoTbLvG7vz7kLbnaWiAYE9gvOr7M2txr1yW39nSPHHdxSOaU2TPoLLWvqMRmGB6Sg+h85LZlP9/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3sk12O1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B28C113CC;
	Mon, 15 Apr 2024 18:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713206854;
	bh=rV4vumlD5sNk0OfLAqgD11a4eTS4oTmbL+qXO4bP6Rs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=O3sk12O1vNISu6JoCLhLE38ZrJWjsGDTXqpKMoWt7iCkqvjwE8YQq/HuZ8uIeB8xD
	 VrH1rYn7KLBMQrS/hIH8izpK6lYWSCAQ9yqQikREpywIso/QdyIK90n3mA9s9VaVBe
	 jNRd2mhID8LHACuK76b9LK5AOBL8QrS1M6QRtoOOBUgZ31wqIjYvD0nK0KPyTr+tEd
	 BnuA0wIwOi/QoEi+PWgsdvd4CrvD0UPeiEjtHzgadHteCrh9Ck+cdj17ThFzT7l1sP
	 dQh6rMMtqo1+Lg/V9zrih3sWqEKDKdzyoJUiZonNvhKhk4yjltm3/lcOG355g5MgES
	 i257yjYc2/zqw==
Date: Mon, 15 Apr 2024 13:47:32 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-rockchip@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240415150349.2207075-1-jonas@kwiboo.se>
References: <20240415150349.2207075-1-jonas@kwiboo.se>
Message-Id: <171320635363.5131.4762067826853746147.robh@kernel.org>
Subject: Re: [PATCH v3 0/2] arm64: dts: rockchip: Add Radxa ZERO 3W/3E


On Mon, 15 Apr 2024 15:03:42 +0000, Jonas Karlman wrote:
> This series adds initial support for the Radxa ZERO 3W/3E boards.
> 
> The Radxa ZERO 3W/3E is an ultra-small, high-performance single board
> computer based on the Rockchip RK3566, with a compact form factor and
> rich interfaces.
> 
> Schematic for ZERO 3W and ZERO 3E can be found at:
> https://dl.radxa.com/zero3/docs/hw/3w/radxa_zero_3w_v1110_schematic.pdf
> https://dl.radxa.com/zero3/docs/hw/3e/radxa_zero_3e_v1200_schematic.pdf
> 
> Changes in v2:
> - Collect acked-by tag
> - Add to Makefile
> - Add patch to fix #sound-dai-cells warning
> 
> Changes in v3:
> - Fix devicetree spelling
> - Sort hdmi-con, leds, pmic@20 and regulator@40 nodes
> - Change to regulator-off-in-suspend for vdd_logic
> - Drop patch to fix #sound-dai-cells warning, similar patch [1] already
>   exists
> 
> [1] https://lore.kernel.org/linux-rockchip/3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com/
> 
> Jonas Karlman (2):
>   dt-bindings: arm: rockchip: Add Radxa ZERO 3W/3E
>   arm64: dts: rockchip: Add Radxa ZERO 3W/3E
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   7 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
>  .../dts/rockchip/rk3566-radxa-zero-3e.dts     |  41 ++
>  .../dts/rockchip/rk3566-radxa-zero-3w.dts     |  26 +
>  .../boot/dts/rockchip/rk3566-radxa-zero3.dtsi | 443 ++++++++++++++++++
>  5 files changed, 519 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3e.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3w.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero3.dtsi
> 
> --
> 2.43.2
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y rockchip/rk3566-radxa-zero-3e.dtb rockchip/rk3566-radxa-zero-3w.dtb' for 20240415150349.2207075-1-jonas@kwiboo.se:

arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3e.dtb: hdmi@fe0a0000: Unevaluated properties are not allowed ('#sound-dai-cells' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3w.dtb: hdmi@fe0a0000: Unevaluated properties are not allowed ('#sound-dai-cells' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#






