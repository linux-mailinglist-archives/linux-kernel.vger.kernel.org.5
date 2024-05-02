Return-Path: <linux-kernel+bounces-166613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7828B9D10
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7727D1C21B46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED7315AAD8;
	Thu,  2 May 2024 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUYj8Af3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A9155323;
	Thu,  2 May 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662517; cv=none; b=qjgBymSNoScoYvyEGSn+2lepMqdfjvsrOh5wlelTkpzE9WnCMFEGtJv5Lf1a1hYzjBLAzEKxrxxMEp/lutc+QBX1m5tCWggGQslj6dCxBNmVPuIBXthFr1gdSz6kE08nqItpadp7sA0b00Laqazs/5AhkrMUm8f2SrC5CUSivb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662517; c=relaxed/simple;
	bh=dcNa0ETf3HLFdrzcPrc9U+CH6XCRPQLNNrx+zNJntNo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=EAfDxuKPEd2bB8R/3jgNddRDwoANJxQlloz+IX2YnbJL5HXMvF3nOnfYHz4fIGD/zTKu5HWA+hzCkjSATM8R6zGJFyQ+Q8E8kEv2VHU3sjODL5VTKsS7rDcl+SESQNDppH0VFa0FLxSdTSiVwZx7eraMGfG6fZ5gMdghrFPUeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUYj8Af3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2518DC113CC;
	Thu,  2 May 2024 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714662516;
	bh=dcNa0ETf3HLFdrzcPrc9U+CH6XCRPQLNNrx+zNJntNo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nUYj8Af3hfzTsnB/nLAJ5nOZA51v43WbPOqY2kLDTRlcilSKfOeWIF12ntIITPCLa
	 BTBMf4FKJ7C1/2OZrRjeO37UkzyZyvnL+TJ0ftE6mjln6z2XT7egBTKacZ1a1xyJB3
	 TWsRD4J53DbWEdWphQYPJJPSoGnm/8GbKuxKqMdXr9U/4gDpfRliFi3oz3/XTtfPdR
	 hz5PX8HDBX2b1hX3UNts9jgCM2H3zilx+CThITArcEyHCIk8xqAVYgRDidwgqc1Yem
	 3mVZFwv3FxSSN2iKajyJf+Vvm8DsInXvikB6yFa0lGcaoXXMD6laJ12c88wrlFECzK
	 nqrSScSZTyoVQ==
Date: Thu, 02 May 2024 10:08:35 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: krzk+dt@kernel.org, linux-kernel@vger.kernel.org, srk@ti.com, 
 kristo@kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@kernel.org, 
 devicetree@vger.kernel.org, nm@ti.com, conor+dt@kernel.org, vigneshr@ti.com
In-Reply-To: <20240502053615.29514-1-r-gunasekaran@ti.com>
References: <20240502053615.29514-1-r-gunasekaran@ti.com>
Message-Id: <171466230679.2213225.6233997103191921836.robh@kernel.org>
Subject: Re: [PATCH 0/2] Add USB 3.0 support for J784S4


On Thu, 02 May 2024 11:06:13 +0530, Ravi Gunasekaran wrote:
> J784S4 has one USB sub system.
> This series adds and enables support for USB 3.0 for
> J784S4 EVM.
> 
> Matt Ranostay (2):
>   arm64: dts: ti: k3-j784s4-main: Add support for USB
>   arm64: dts: ti: k3-j784s4-evm: Enable USB3 support
> 
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 41 ++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 39 ++++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> 
> base-commit: f68868ba718e30594165879cc3020607165b0761
> --
> 2.17.1
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


New warnings running 'make CHECK_DTBS=y ti/k3-j784s4-evm.dtb' for 20240502053615.29514-1-r-gunasekaran@ti.com:

arch/arm64/boot/dts/ti/k3-j784s4-evm.dtb: pinctrl@11c000: 'main-usbss0-pins-default' does not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#






