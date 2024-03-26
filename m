Return-Path: <linux-kernel+bounces-119768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB188CCCC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7329B21B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A1D13CF80;
	Tue, 26 Mar 2024 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9CY6W7v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC96713CC69;
	Tue, 26 Mar 2024 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480319; cv=none; b=Y4Y2uDWokcSsc6koBGU/JwPlgI522bqrApITV01dn5D1rJNo+uUc0q9IdQshBZM+wli2i1ydgmH7lT77y/qsE35mxKotWRiqIz02OqkIH77pJ9fA6Q5qsgxBge3QcHS401aZIUuwDb460Z9DQtF4fVG2R4YeX9MZHk5JIU67fHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480319; c=relaxed/simple;
	bh=LvKhXJn8EIr5UGVEKeNBvYJUx5NfV4+q0X4F7qJluac=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=M8/gaQQUxPdTpYoUf4ROoe921KHKg05oa6p8qGOEREkT4+SEAsuKSOSNXAwVAUCc6n6m58NhFSUVFZjFYCFpTxPOKtZpLvfIUt9mP13LcXWE76+cGHUOknvmfe7XfhQdCcshvcUoURajBg47JcaHyHxh0QqOzoO7BWiTWoeOv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9CY6W7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD05C433C7;
	Tue, 26 Mar 2024 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711480319;
	bh=LvKhXJn8EIr5UGVEKeNBvYJUx5NfV4+q0X4F7qJluac=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=F9CY6W7vwuaBw6n/k3jXgLRRU6zg87VuJJj4rHj94X/+YXtg0cU3xuoS8Tn9gZoJf
	 +KYew4/UAMwqEZQ4Ust/1AycXvF2Wg9cSM0DQdx6QHvqyf3r8S4S0t0jmzkr47eyGw
	 XfVfa4mRCEeGJXE6JErktD+X0I15wVflHnGbj8xEhH/w5EKnKInP+PHDb2EPznJWkH
	 9B+1LzRvXvX2laLjHyp+btFUtlb/sgNY1kWeQIm1GlhhRlEyaa1I1KZeo7d/v8qREw
	 wJfsFIVrZ1pv9ZWCssCOsvAkkHDC1YtVX160VJGCGRuCXkXy+4thhZnB0ffwi9t8Ct
	 kSKlDl6tveVgQ==
Date: Tue, 26 Mar 2024 14:11:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240325-feature-wolfvision-pf5-v1-0-5725445f792a@wolfvision.net>
References: <20240325-feature-wolfvision-pf5-v1-0-5725445f792a@wolfvision.net>
Message-Id: <171148006579.3222626.4177463381080253015.robh@kernel.org>
Subject: Re: [PATCH 0/4] arm64: dts: rockchip: add wolfvision pf5 mainboard


On Mon, 25 Mar 2024 15:22:30 +0100, Michael Riesch wrote:
> Habidere,
> 
> This series adds the device tree for the WolfVision PF5 mainboard, which
> serves as base for recent WolfVision products. It features the Rockchip
> RK3568 and can be extended with several different extension boards.
> 
> The WolfVision PF5 IO Expander is one example of such an extension board.
> The corresponding device tree overlay is also included in this series.
> 
> May this be the beginning of a beautiful friendship :-)
> 
> Looking forward to your comments!
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
> Michael Riesch (4):
>       dt-bindings: add wolfvision vendor prefix
>       dt-bindings: arm: rockchip: add wolfvision pf5 mainboard
>       arm64: dts: rockchip: add wolfvision pf5 mainboard
>       arm64: dts: rockchip: add wolfvision pf5 io expander board
> 
>  .../devicetree/bindings/arm/rockchip.yaml          |   5 +
>  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   2 +
>  .../rk3568-wolfvision-pf5-io-expander.dtso         | 137 ++++++
>  .../boot/dts/rockchip/rk3568-wolfvision-pf5.dts    | 528 +++++++++++++++++++++
>  5 files changed, 674 insertions(+)
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240325-feature-wolfvision-pf5-5c1924c0389c
> 
> Best regards,
> --
> Michael Riesch <michael.riesch@wolfvision.net>
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3568-wolfvision-pf5.dtb' for 20240325-feature-wolfvision-pf5-v1-0-5725445f792a@wolfvision.net:

arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dtb: hdmi@fe0a0000: Unevaluated properties are not allowed ('#sound-dai-cells' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#






