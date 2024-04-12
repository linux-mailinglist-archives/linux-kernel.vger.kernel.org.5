Return-Path: <linux-kernel+bounces-142759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F278A2FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CE1286429
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39AF84DF6;
	Fri, 12 Apr 2024 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Agi5RIou"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8685948;
	Fri, 12 Apr 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929606; cv=none; b=BLfuvWgOoylCdn3GlIHUq4k9qd87EllJjlctSMKQ6s4/1vK6EzhQF2hdSmU9xLMF094///tfx8R3TZOJ5um+hiQd+H3lmwtRaftZ7lHAdnlyML2rnXqOfzAlvZ4tWVBr2KNuQQqIVhaogBIhAzceo/W8JdRpVh+2sS3mdrdI6jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929606; c=relaxed/simple;
	bh=5ivn1LTngEi9jI1EUyOdYRjaU0KgEyu/d/l2sKiMgUA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=rU7yUVbJo6cyIObXjoFet6q3Gn/KebohUZXAUasebRYUlBWpdsqfxsy0X9OEGq+Sn9wZ8ww3EyxUZBd/O1bmjc5sEsWcK75y4LdDb1P3kSIyI0N5gGBje+pWcWFtcaZpqEtinW1RZMhtDl8LggM9TYrGQH0e5Yy5L1YIZCqax2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Agi5RIou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DA7C113CC;
	Fri, 12 Apr 2024 13:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929605;
	bh=5ivn1LTngEi9jI1EUyOdYRjaU0KgEyu/d/l2sKiMgUA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Agi5RIoutvjwmQZAHre0zH3b8jGh81P+IR8LGNvWbeAOGqgyplNR6kOXdUQOVPcXH
	 nEmZ11hIg+mrmOGJaf/kT3Lb1TLnpMnPtwhHtfjaXpkGuXkjytHi4GYOoCp+kJzcV+
	 KT6agPPOM9Ysvo8hf4/imkKuy5jlZcDKrSNFXEL+e8ySL0thlGar1+VwpqHOypfpZg
	 AhCWX/q1O5R1H/mxwyZ6TdxAf6YzMY7FCu8+uQurd/MDyVoXGyWK7g0FKvJVvyy8YG
	 Xz18iRHYWWEBVRoqe2NM4xAYnM71NZJN0o1mm2j9xNNGo4LBw++uOktTtKpPEW6bz/
	 3qPiHscVOMTeQ==
Date: Fri, 12 Apr 2024 08:46:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Judith Mendez <jm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Dasnavis Sabiya <sabiya.d@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Bhavya Kapoor <b-kapoor@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240411225257.383889-1-jm@ti.com>
References: <20240411225257.383889-1-jm@ti.com>
Message-Id: <171292930732.2308726.6017899720480568050.robh@kernel.org>
Subject: Re: [PATCH 0/7] MMC updates for TI K3 platforms


On Thu, 11 Apr 2024 17:52:50 -0500, Judith Mendez wrote:
> This patch series includes MMC updates for various TI K3 platforms.
> 
> It includes support for enabling UHS/SDR104 bus modes or removing
> HS400 support due to CQE errors seen during boot.
> 
> For AM62ax, add missing UHS support.
> 
> For AM65x, fix ITAP delay and OTAP delay and clkbuf-sel properties
> in SDHCI nodes.
> 
> Bhavya Kapoor (1):
>   arm64: dts: ti: k3-j721s2-main: Enable support for SDR104 speed mode
> 
> Dasnavis Sabiya (2):
>   arm64: dts: ti: k3-j784s4-main: Enable support for UHS mode
>   arm64: dts: ti: k3-am69-sk: Remove HS400 mode support for eMMC
> 
> Judith Mendez (2):
>   arm64: dts: ti: k3-am65-main: Update sdhci properties
>   arm64: dts: ti: k3-am65-main: Remove unused properties in sdhci nodes
> 
> Udit Kumar (1):
>   arm64: dts: ti: k3-j784s4-evm: Remove HS400 mode support for eMMC
> 
> Vignesh Raghavendra (1):
>   arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards
> 
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi  |  2 --
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts    | 21 +++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 26 +++++++++-------------
>  arch/arm64/boot/dts/ti/k3-am69-sk.dts      |  1 +
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi |  2 --
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   |  1 +
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi |  2 --
>  7 files changed, 34 insertions(+), 21 deletions(-)
> 
> 
> base-commit: 534ad093bb80f19c20b251a89f09ce1a0e3d4f2d
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


New warnings running 'make CHECK_DTBS=y ti/k3-am62a7-sk.dtb ti/k3-am69-sk.dtb ti/k3-j784s4-evm.dtb' for 20240411225257.383889-1-jm@ti.com:

arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb: pinctrl@f4000: 'vddshv-sdio-pins-default' does not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#






