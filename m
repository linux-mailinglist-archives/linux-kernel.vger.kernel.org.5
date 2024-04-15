Return-Path: <linux-kernel+bounces-145729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2308A5A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D401F21442
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A023315572C;
	Mon, 15 Apr 2024 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PREhNZwF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B2276033;
	Mon, 15 Apr 2024 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206813; cv=none; b=hEuomq+iqlLN/0j9RUJR6w7x/ylyIJDVyFRwQdH5ZDOXFtpGPi/fXNqpzS/tlzCHt0s+GW1GKAiB8JC41PNevgGNr7cR3BlhW08CWUlQE9PHAOQ+5K3KopYnrp5koKh4Fyg+Kzx+Nq21EHLkcZczsf6uEL1dhGhf1kEy7bWkBYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206813; c=relaxed/simple;
	bh=1YakDkc62HbppF5hPJRp9P9V4kvV6LCi/TJjFT8VYl8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=fhybPvoJlXJpReXETCJMdtJuxjoHoSYpvGS/tPkwbty1MxqA4eStwH0n1A1qNzQ7pCFTfCO6qpQRj+Q5uuvZaI4CLlCF0QsYlZi0wBiDsIEL7rtM8by6hGsYHHgBGWZD0D2CoOXx66d0KgCRuMxvwMFyz+l/xXSa7tfqaYRJddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PREhNZwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81728C113CC;
	Mon, 15 Apr 2024 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713206812;
	bh=1YakDkc62HbppF5hPJRp9P9V4kvV6LCi/TJjFT8VYl8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PREhNZwFjvg56f/iJMjGfnzW/D8fqourfHVqRT+d8lbcGSCv5cWm4X2rLKA5UQ/VE
	 EgDOEtJllOYI+F2AT2WWVnFNkjnLmck+buQQmLoL0mMQKX3q2tF+7ziVYc0py3EkvB
	 goFY0Gq62Av2ZVnMAjxtmnbyjKElM9xZfOtIhQj9MGfCEn78wRvNz3G5c3blZgAWJy
	 +RrHhJUUUcOQ8a9MY75wSQKjEkSoh02R6aZkH8ouP3kuU+FuQxS2DLq1IGdw2ZShlR
	 OKl9cdmaP/7aRe7GGNRTDEtiIrQRi+RT8GlNgYj+CkedStfL5/Hd0eur378vfDzBcb
	 IxakXwOZInICw==
Date: Mon, 15 Apr 2024 13:46:49 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: linux-rockchip@lists.infradead.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, heiko@sntech.de, sfr@canb.auug.org.au, 
 linux-arm-kernel@lists.infradead.org, weizhao.ouyang@arm.com
In-Reply-To: <20240413032328.784142-1-liujianfeng1994@gmail.com>
References: <20240413032328.784142-1-liujianfeng1994@gmail.com>
Message-Id: <171320634163.4714.8795054686718423617.robh@kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Add ArmSom Sige7 board


On Sat, 13 Apr 2024 11:23:27 +0800, Jianfeng Liu wrote:
> Specification:
>         Rockchip Rk3588 SoC
>         4x ARM Cortex-A76, 4x ARM Cortex-A55
>         8/16/32GB Memory LPDDR4/LPDDR4x
>         Mali G610MP4 GPU
>         2× MIPI-CSI Connector
>         1× MIPI-DSI Connector
>         1x M.2 Key M (PCIe 3.0 4-lanes)
>         2x RTL8125 2.5G Ethernet
>         Onboard AP6275P for WIFI6/BT5
>         32GB/64GB/128GB eMMC
>         MicroSD card slot
>         1x USB2.0, 1x USB3.0 Type-A, 1x US3.0 Type-C
>         1x HDMI Output, 1x type-C DP Output
> 
> Functions work normally:
>         USB2.0 Host
>         USB3.0 Type-A Host (depend on just applied USBDP driver[1])
>         M.2 Key M (PCIe 3.0 4-lanes)
>         2x RTL8125 2.5G Ethernet
>         eMMC
>         MicroSD card
> 
> More information can be obtained from the following website
>         https://docs.armsom.org/armsom-sige7
> 
> [1] https://lore.kernel.org/all/20240408225109.128953-1-sebastian.reichel@collabora.com/
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588-armsom-sige7.dts | 725 ++++++++++++++++++
>  2 files changed, 726 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3588-armsom-sige7.dtb' for 20240413032328.784142-1-liujianfeng1994@gmail.com:

arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb: pcie@fe150000: 'pinctrl-0' is a dependency of 'pinctrl-names'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb: leds: led_rgb_r:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
	'default-off' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'disk-read', 'disk-write', 'timer', 'pattern', 'audio-micmute', 'audio-mute', 'bluetooth-power', 'flash', 'kbd-capslock', 'mtd', 'nand-disk', 'none', 'torch', 'usb-gadget', 'usb-host', 'usbport']
	'default-off' does not match '^cpu[0-9]*$'
	'default-off' does not match '^hci[0-9]+-power$'
	'default-off' does not match '^mmc[0-9]+$'
	'default-off' does not match '^phy[0-9]+tx$'
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb: leds: led_rgb_r: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#






