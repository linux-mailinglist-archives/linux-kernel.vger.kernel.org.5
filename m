Return-Path: <linux-kernel+bounces-15608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42287822EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19601F245F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AEE19BDE;
	Wed,  3 Jan 2024 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="cpu0Ye8I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5991B270;
	Wed,  3 Jan 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1704289233; bh=vv+J84aXLGq+PleY0UyhFYxaeGAaLPX+RfeAkhXQ200=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpu0Ye8IMdGiDBxzyzZoReAEfROyEgoo9iUD2E/KCtoinzklkZ2EY2k8LlfjMkdO1
	 khHcsTIaAOby6KzxVGlv35+5nM2QAdsEuaCXw6pDtBQNgblFEAnaRq29gNpf3heJzn
	 Tbi4yLOOHPKyAJ5M++PCe/6zsgafjtf5Kg+uc4XOOKIMn/xdit+j56ptkieFCrLKfH
	 twHm50FJdGRXndg5wYG7lRhubiwrcMHcIPrBcotnVbl6ufke16NNEE8v0SMhNsVT0i
	 SSJuX8QV2UYgDdg+KFGXAAcon4Vfo7MZAtb95DKNqmcC6jJXnCc9nHjV/81MHLV/DG
	 soQrY8N8pO/JQ==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 6BF8E379D1E;
	Wed,  3 Jan 2024 14:40:32 +0100 (CET)
Date: Wed, 3 Jan 2024 14:40:31 +0100
From: Manuel Traut <manut@mecka.net>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
	Mark Yao <markyao0591@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Segfault <awarnecke002@hotmail.com>,
	Arnaud Ferraris <aferraris@debian.org>,
	Danct12 <danct12@riseup.net>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: Add devicetree for Pine64
 PineTab2
Message-ID: <ZZVjzwgANJMdHnuo@mecka.net>
References: <20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net>
 <20240102-pinetab2-v3-4-cb1aa69f8c30@mecka.net>
 <775vjfucu2g2s6zzeutj7f7tapx3q2geccpxvv4ppcms4hxbq7@cbrdmlu2ryzp>
 <903e9d0c-a00c-4214-9f0e-dd676b13b428@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <903e9d0c-a00c-4214-9f0e-dd676b13b428@kwiboo.se>

Hi Jonas and Ondřej,

> >> +&sfc {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&fspi_dual_io_pins>;
> >> +	status = "okay";
> >> +	#address-cells = <1>;
> >> +	#size-cells = <0>;
> >> +
> >> +	flash@0 {
> >> +		compatible = "jedec,spi-nor";
> >> +		reg = <0>;
> >> +		spi-max-frequency = <24000000>;
> > 
> > That's a bit on the low side. The flash chip should work for all commands up to
> > 80MHz https://megous.com/dl/tmp/b428ad9b85ac4633.png and SGM3157YC6 switch
> > for the FSPI-CLK should have high enough bandwidth, too.
> 
> I agree that this is a little bit on the low side, it was a safe rate
> that I used for U-Boot. U-Boot required an exact rate of the supported
> sfc clk rates: 24, 50, 75, 100, 125 or 150 MHz.
> 
> Please also note that the SPI NOR flash chip used in PineTab2 is not a
> GigaDevice GD25LQ128E, it should be a SiliconKaiser SK25LP128, same as
> found in the Pine64 PinePhone Pro.

The schematics for v2.0 reference a GD25LQ128EWIGR. I never checked the jedec
id. How did you retrieve this information, or is it maybe a difference in v0.1
and 2.0?

> >> +		spi-rx-bus-width = <2>;
> > 
> > GD25LQ128E supports quad I/O. Maybe try 4 if it will work.
> 
> The schematic only shows fspi D0 and D1 connected, and use the D2 line
> for eMMC_RSTn, so spi-rx-bus-width = <2> should be correct.

ack

Since it is only needed for bootloader updates and environment its maybe better
to stay on the safe side?

But I can test faster frequency if you want me to do..

Regards
Manuel

