Return-Path: <linux-kernel+bounces-13087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1C581FF89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF241C21255
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A963111BD;
	Fri, 29 Dec 2023 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="J4OxaaYK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF35111AB;
	Fri, 29 Dec 2023 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rJCU2-00032e-BJ; Fri, 29 Dec 2023 08:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=L8E+uQiPVMJl0Ysub+xW5uqgmBXvPg/3AXYx0vVI4oY=; b=J4OxaaYKYjofgxnJb3Nv
	tVd3oqHfbaSAmzfAyeUJunKTWpdGkinSyIf2N0YeZ4UEHd+BU0eEOcOufCUzsHL/7LQqRaaI4JVl8
	Az4Nf4LoCujD+C/JfXOFB6HtklDNtNOZiGBcYzubqHst/YcIx3npVqewU6PBOOXURdSLyKVkEG0XV
	sSJ7STzOpwCXR4F691CtalFSebzoaGSFQagCURT//Uov0TUwmJcSRG64E8gkEtg1r6h6fg86duiMg
	z5vjif5MIlXPxuXPHDy7mWqSByjQqbXKVm9DEjxgiT0NtXJoKX3rQhTPA/j9683zBfyIy78L1kL5D
	FZhOhynw+Q+mOw==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  NXP Linux Team <linux-imx@nxp.com>,  Li Yang
 <leoyang.li@nxp.com>,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/2] arm64: dts: imx93-var-som: Add Variscite
 VAR-SOM-MX93
In-Reply-To: <d378ad67-2a75-4a14-a131-7eb91de9ad3d@gmx.net> (Stefan Wahren's
	message of "Thu, 28 Dec 2023 21:46:08 +0100")
References: <20231227170919.8771-1-othacehe@gnu.org>
	<20231227170919.8771-3-othacehe@gnu.org>
	<d378ad67-2a75-4a14-a131-7eb91de9ad3d@gmx.net>
Date: Fri, 29 Dec 2023 14:00:58 +0100
Message-ID: <87plypqi2d.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello Stefan,

> there are neither gpio-line-names defined for this GPIO expander nor the
> SOC. Are there no GPIOs which can be accessed from userspace?

The carrier board schematic is here:
https://www.variscite.com/wp-content/uploads/2023/01/symphony-board_VAR-SOM-MX93.pdf

All the pin headers are mapped to specific functions. On the other,
already mainlined device-trees, that are based on the same "Symphony"
carrier board, there are however gpio-keys for three buttons:


	gpio-keys {
		compatible = "gpio-keys";

		key-back {
			label = "Back";
			gpios = <&pca9534 1 GPIO_ACTIVE_LOW>;
			linux,code = <KEY_BACK>;
		};

		key-home {
			label = "Home";
			gpios = <&pca9534 2 GPIO_ACTIVE_LOW>;
			linux,code = <KEY_HOME>;
		};

		key-menu {
			label = "Menu";
			gpios = <&pca9534 3 GPIO_ACTIVE_LOW>;
			linux,code = <KEY_MENU>;
		};
	};

I can add that in v5.

Thanks,

Mathieu

