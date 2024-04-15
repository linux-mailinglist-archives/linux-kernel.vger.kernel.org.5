Return-Path: <linux-kernel+bounces-145731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631348A5A22
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180521F21436
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0481E877;
	Mon, 15 Apr 2024 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9IfzMpC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E121553B9;
	Mon, 15 Apr 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206834; cv=none; b=U1ZRb9jCWLly29h7LJ2NV1ONnp318GRf5ZiM/cwzEbEBlAnUSTTrBc/SNWKd75DuYVxeNIaOTV+UeuO43WVM7E9ZJswatLgyPFbplkmXvO3GBoPpReiwbfc58DVxUcEZT7a/8kjrNSfX+39ihF5V/4COZw2HCKyLU8N3Pwiuj04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206834; c=relaxed/simple;
	bh=C2qyiGADw+gC+Ft/ZZHJ29hdNBa1l7Td5WbuGlH9vpg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=KD+/4vzG49HSG+y10WX/imaAAJvIciK3UtiL12RDfy+1fvW/d4qyQgrvxGAzIOYF0k13nPEHvyqVbKaDoHOKLSIynsUdRyemNH5Igvz0ucz/S6/U/I3LMuWBPDcg69Qykwdj7LQEDIcpaTN/e3LZt7L/zWJ33Wu+CMlZMsnG6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9IfzMpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933C2C2BD11;
	Mon, 15 Apr 2024 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713206833;
	bh=C2qyiGADw+gC+Ft/ZZHJ29hdNBa1l7Td5WbuGlH9vpg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=A9IfzMpCmrBPoM0NqB4VTba0T3/IBkWc6VWPapKECLtZko/XloDRryQxIFfKq8O6Q
	 WNRpa0O5w1+JRRXCTGDf+5Cr0lXPf76kDf2Ix5bo7TziOyYDJFLfHpsWMjcdgTxf4u
	 5KLoM3bthozHti+qovaMGqaIP0he7HZQu1syN0uHNBe5lQhxZavAlqKjpJ1Q2GII5U
	 VPqGqvs4TkdLt1pFJDRf1QzJcTmWnvbD7HpwboKee9/oOoKUb7gRWpkLytahqwZKaa
	 7FEhzNKlrb2xKFdyGpv8NkF40Jdk3mMoF/JJYN0VcnwjcKbjRJA52V6rDPSs+VGdQB
	 W8Y5jG5RnaV5Q==
Date: Mon, 15 Apr 2024 13:47:10 -0500
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
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20240414151135.1774981-1-jonas@kwiboo.se>
References: <20240414151135.1774981-1-jonas@kwiboo.se>
Message-Id: <171320634867.4962.13146446067412634937.robh@kernel.org>
Subject: Re: [PATCH v2 0/3] arm64: dts: rockchip: Add Radxa ZERO 3W/3E


On Sun, 14 Apr 2024 15:11:26 +0000, Jonas Karlman wrote:
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
> Jonas Karlman (3):
>   dt-bindings: arm: rockchip: Add Radxa ZERO 3W/3E
>   arm64: dts: rockchip: Add Radxa ZERO 3W/3E
>   dt-bindings: display: rockchip,dw-hdmi: Fix #sound-dai-cells warning
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   7 +
>  .../display/rockchip/rockchip,dw-hdmi.yaml    |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
>  .../dts/rockchip/rk3566-radxa-zero-3e.dts     |  41 ++
>  .../dts/rockchip/rk3566-radxa-zero-3w.dts     |  26 +
>  .../boot/dts/rockchip/rk3566-radxa-zero3.dtsi | 443 ++++++++++++++++++
>  6 files changed, 523 insertions(+)
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3566-radxa-zero-3e.dtb rockchip/rk3566-radxa-zero-3w.dtb' for 20240414151135.1774981-1-jonas@kwiboo.se:

arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3w.dtb: hdmi@fe0a0000: Unevaluated properties are not allowed ('#sound-dai-cells' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3e.dtb: hdmi@fe0a0000: Unevaluated properties are not allowed ('#sound-dai-cells' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#






