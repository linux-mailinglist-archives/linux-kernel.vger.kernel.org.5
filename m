Return-Path: <linux-kernel+bounces-145730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C708A5A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A862819E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91032155A2F;
	Mon, 15 Apr 2024 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozmr5t7/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC976033;
	Mon, 15 Apr 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206816; cv=none; b=EnjHNsf4c5qUflUc34+1B8t57ewrptLK1ohQJcVbFMh0q5bSuDx0Uq851xbyVZPMBW1obf2zjBhX50oe7N8tvSJWQWhHD5CaFAnHFtFb5dIqXmnJyhv/3gm2GgSQ29fAltPUmxIqlsaDkTaDoEcHjZsfo/UtwLPdsJyeEViA8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206816; c=relaxed/simple;
	bh=VYwFK93QWXnZOcZLYRf1I9Noj1pc0NPj5LchFP/04ew=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=aR/v8slJQZImuwxce4co1YPIKr/+ipobAkCgUtacA8V33tmAmtXbCZ2gf0rlqNKZjeJWUCUEcVT0NPvcMJWXm1j5yfrQ1YBR8llhin/4u+JfZ+VAUQocdLVMSGymxHP9ErXXX9OjE/1aBwUbe6/qWnG0apmYZqIlEvGvVg00Xc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozmr5t7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A29C2BD11;
	Mon, 15 Apr 2024 18:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713206816;
	bh=VYwFK93QWXnZOcZLYRf1I9Noj1pc0NPj5LchFP/04ew=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ozmr5t7/BCBCWudh8SkridVru1QV8uBd9kDymgyP7D7km1kql9ofW0akhJyqCE+/5
	 hHiRkrQ6AuP6xTa4MXNge6H+IZ+wro7obz0xbHsVakx+wsvBlSVb0LhTeNplZZFfea
	 TCpinkVY8HR3Tx//EETbkwHJn5Yz3tw3PaKQxtO1tRg4aceLD7ENwsmNmVNOpRwDvq
	 ApyEOfkXXJ6GvL7nLVnD2B8UAJ3jIC1uksx9fiCycAFBu+toCj9sd2LWAREj9GSwQZ
	 60XUw5uJjTzxN7b/VpUOgPlwUH7E8U1SqzZ1Bh+7BcmRcXdToeQOUAroQRh0Qdq3Rm
	 vcJAMZ/arIbvg==
Date: Mon, 15 Apr 2024 13:46:53 -0500
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
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 krzk+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, sfr@canb.auug.org.au, heiko@sntech.de, 
 weizhao.ouyang@arm.com, conor+dt@kernel.org
In-Reply-To: <20240413153633.801759-1-liujianfeng1994@gmail.com>
References: <20240413153633.801759-1-liujianfeng1994@gmail.com>
Message-Id: <171320634254.4749.2865905152184927129.robh@kernel.org>
Subject: Re: [PATCH v2 0/3] Add ArmSom Sige7 board


On Sat, 13 Apr 2024 23:36:30 +0800, Jianfeng Liu wrote:
> Changes in v2:
>  - Add ArmSoM to vendor-prefixes
>  - Commit dt-bindings change first
>  - Fix commit message for dt-bindings
>  - Fix wrong devicetree node name "led_rgb_g" and "led_rgb_r"
>  - Link to v1: https://lore.kernel.org/all/20240413032328.784142-1-liujianfeng1994@gmail.com/
> 
> Jianfeng Liu (3):
>   dt-bindings: vendor-prefixes: add ArmSoM
>   dt-bindings: arm: rockchip: Add ArmSoM Sige7
>   arm64: dts: rockchip: Add ArmSom Sige7 board
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588-armsom-sige7.dts | 725 ++++++++++++++++++
>  4 files changed, 733 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
> 
> --
> 2.34.1
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3588-armsom-sige7.dtb' for 20240413153633.801759-1-liujianfeng1994@gmail.com:

arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts:44.20-49.5: ERROR (duplicate_label): /leds/led-0: Duplicate label 'led_rgb_g' on /leds/led-0 and /pinctrl/leds/led-rgb-g
arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts:51.20-56.5: ERROR (duplicate_label): /leds/led-1: Duplicate label 'led_rgb_r' on /leds/led-1 and /pinctrl/leds/led-rgb-r
ERROR: Input tree has errors, aborting (use -f to force output)
make[3]: *** [scripts/Makefile.lib:427: arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dtb] Error 2






