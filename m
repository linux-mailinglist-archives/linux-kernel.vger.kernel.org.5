Return-Path: <linux-kernel+bounces-83337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B210869381
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB1E1F21975
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2441714534B;
	Tue, 27 Feb 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo5xc8md"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CAF14532D;
	Tue, 27 Feb 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041500; cv=none; b=hcsnOTSlvWYVGm/bWb/v2jpcGyaZoO0uQfbCvTofWmUH+dLwK2OiEHi7mLoSNSrVbBz9V015n5KvrjDkc6QoK5+CSCSJkyyuIVVOAuu6g3R25iYwJ49yilG+2s7JjWgBbzF2I+kqT8pwjNF0/mkpWhTNj4DrdhQn2gNrErsM3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041500; c=relaxed/simple;
	bh=ivQtRnQnwE8q1Hvdyp6+ecq3htSCZ8MTLUruMfvV5Is=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Alnb78RgjjxHLfWRj0Rq2uSdZOOsx2p7g7dDLQwn38yVCeveQ/06Ixfl3vQTLEDBwO7lCs0fTG2/vdMMVpdCUO9mKe6gHDNh+iuGZQUtzsrCFut/J1hhZTUnB9b7yF5ln1PRTQVFdrnB75JB//relHM/ny+jHLWWzEG54/rtB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo5xc8md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B92C433C7;
	Tue, 27 Feb 2024 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709041500;
	bh=ivQtRnQnwE8q1Hvdyp6+ecq3htSCZ8MTLUruMfvV5Is=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qo5xc8mditP8KRO+O7n4jnJNB0gmxbnGJp4V0fAuVp/ihyEeOgdJaW/DPt5IFRwaL
	 nrSk353JLNwEi/d6xeVX0LUZR22/RBEPw4ybhiGk8SmHSRdom/1SH3P7WZ91+Ul1wo
	 +I7zPglMleQ8nqVhcpv8jT8XYOJVb8HJPMItmH4JLd+ilebayUYhjfQa3dqkCyDzgp
	 VjZlNEKtFbAG8U4yiAY3mpI0ZA4BraOA7tgWYXbtgjoCtYVtHiXHtmht4x0ec29TX+
	 nv0TTbe4g64khsiLEXkNB70wGhMJyjvRSkIDrF15ugS6/6qPpMEVECqFo8f8/Lbm1b
	 OZYUBJSZZJD4Q==
Date: Tue, 27 Feb 2024 07:44:58 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, 
 imx@lists.linux.dev, Shawn Guo <shawnguo@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20240226203358.275986-1-Frank.Li@nxp.com>
References: <20240226203358.275986-1-Frank.Li@nxp.com>
Message-Id: <170904127295.3703756.16287428647628202898.robh@kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: imx8qm-mek: add adc0 support


On Mon, 26 Feb 2024 15:33:55 -0500, Frank Li wrote:
> Add adc0 for imx8qm-mek board.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 


My bot found new DT warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y freescale/imx8qm-mek.dtb' for 20240226203358.275986-1-Frank.Li@nxp.com:

arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: system-controller: pinctrl: 'lpspi2cs' does not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/firmware/fsl,scu.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: pinctrl: 'lpspi2cs' does not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/fsl,scu-pinctrl.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: spi@5a020000: Unevaluated properties are not allowed ('fsl,spi-num-chipselects' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/spi-fsl-lpspi.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: spi@5d120000: Unevaluated properties are not allowed ('nxp,fspi-dll-slvdly' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/spi-nxp-fspi.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: mt35xu512aba@0: $nodename:0: 'mt35xu512aba@0' does not match '^(flash|.*sram|nand)(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: mt35xu512aba@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#






