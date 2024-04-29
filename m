Return-Path: <linux-kernel+bounces-162463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE68B5B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841CD1F227B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D030C7EEF2;
	Mon, 29 Apr 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvdPOYQ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2CE7E11E;
	Mon, 29 Apr 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401697; cv=none; b=NDVScw1vTsIYYf1rgRYkEncnbxEUgJi0XhVE6GiYKayKGDDr3aIm5YrFECAXL18zzcvQX+JcA/YLJSvNLuDc+z71h2E4s7TN8PSS2oR1F/Dyb5BoKW1Slt8BBRy7RmwwvsHIxkwEiTdcfgkthGkJjT3QxbRDnTE1syxRjaUMpX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401697; c=relaxed/simple;
	bh=JEfYMeBJOiHNAWe4+hJZqGxv7XM4utWyxu6aJe0ctqM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=lislRm5UTzOjuGawODeoFpJw6D9RKZ7TLTgIGttJ6GK13dK4YaduGJ7QDBPaMTXuEymsC5ayIvRpzfs4d/pJSpxWI7HkKcwAtk6JrQYFy9cvGCqzcH3fhvWZzHz9C8Sqcqki188eHXz4DIrt775NC+djfLaKRjN9t7XPEe0kPVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvdPOYQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7307CC113CD;
	Mon, 29 Apr 2024 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714401696;
	bh=JEfYMeBJOiHNAWe4+hJZqGxv7XM4utWyxu6aJe0ctqM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mvdPOYQ2lylbTa663fLAJVJeNVyOjkeFmUH3B97UTHaqDr/w9U+Vc4Dr82Uvz+7/k
	 QkbEKQmgAsCP+lQIO2O26JQ8cf/SSzmWqu+Ma8fQPY1esjGT9/W8tuZh/pgfC/0D6Z
	 5iHthO5ZeqBdOEwD4sk6tceN1aCtmkUdtCuL2LYgaXQ+r1HT7xpz5z16rnMQxEFphJ
	 UWMHVnAPyd8JxXIQS/2CPSaSdAmdpsEU3vTw4WsEE5BGWzAnqUjkFrrW8okqT0Y1K6
	 /Zfpcpwt+FEnW02X34meBl1CULNDw/YPVnu8bIcEEwS9GGYMX7s5utVwMHBIBBMLVS
	 gcusE43a0ipqg==
Date: Mon, 29 Apr 2024 09:41:34 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20240428123618.72170-1-amadeus@jmu.edu.cn>
References: <20240428123618.72170-1-amadeus@jmu.edu.cn>
Message-Id: <171440141099.1676491.7602268087983618249.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: rockchip: Add Radxa ROCK 3C


On Sun, 28 Apr 2024 20:36:16 +0800, Chukun Pan wrote:
> Changes in v2:
>   Collected Acked-by.
>   Drop cd-gpios for sdhci.
>   Add mmc-hs200-1_8v to eMMC.
>   Correct the spi max frequency.
>   Update model name and compatible.
>   Update regulator according to the schematic.
> 
> Chukun Pan (2):
>   dt-bindings: arm: rockchip: add Radxa ROCK 3C
>   arm64: dts: rockchip: Add Radxa ROCK 3C
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3566-rock-3c.dts      | 750 ++++++++++++++++++
>  3 files changed, 756 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
> 
> --
> 2.25.1
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3566-rock-3c.dtb' for 20240428123618.72170-1-amadeus@jmu.edu.cn:

arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks', 'codec' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#






