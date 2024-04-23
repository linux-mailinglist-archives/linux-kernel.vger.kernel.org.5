Return-Path: <linux-kernel+bounces-155353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449048AE941
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECD01F223BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0A813B7A9;
	Tue, 23 Apr 2024 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKSj4c8k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56213B5A4;
	Tue, 23 Apr 2024 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881755; cv=none; b=Zbh4RS+zNOED0svfto+34w4BSuea0OZG2i3ev5V2hRzBqk8Xyf5csBZGkcHzKlmp4sEIArxPHzZBXUgj7enJiZLaPOaHe96W54qEeGB2cvaOPIPKZB/9wB1Jcawc+qiCy8lj738/DDkf7W0zcQY41TTKEPQUT/c1OYqqTSsQd84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881755; c=relaxed/simple;
	bh=sy6+MN/HmczK32MDWL+VslqDTqofr2HRdozz7AQQSKg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=VbNgULOeg+NZqCUCfjMyPL6e1NZpvf/ObD/9b7E3iiP82Q2LRYZ5HMxnRhVYl4fnnz8CSxu6RQIiuaP+21i6xei4hRxbj4vG7s+pqVzabhWxF6x3qeSKpoPqMTbC0uQhIqukqMGiHHwC/02WOWGwa4xlu0htMPQgli0+wuOsqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKSj4c8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612BFC3277B;
	Tue, 23 Apr 2024 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713881755;
	bh=sy6+MN/HmczK32MDWL+VslqDTqofr2HRdozz7AQQSKg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BKSj4c8kbrOVCcUaNsRJi2LCLRkdFP3JJwvFbbdGqJkWNsDxYcYm9hpXjMQL1084v
	 WjzQqs2nJhVTzgJRjNbcCd6175icqt5giIOwZuVofXtzCZkg6ZWikdcwLyLgDXbtyA
	 pdKm/Gv00w4tS01XgQV8RMrVCCBtnixes1Kps7zlfLXXFrDVgGFljRyPkoFdXSEKmK
	 tiqlOMwT6rpMdDrtMCVhyNnp8zDu9/tmClNs1XGaMzm3zaYgNCZYPpfzhTk0c3qexS
	 fG9WX4IGy9y2MYBG7/YtRDlW32fpe5bf0qYA/7QA4VhKJP6oLAjDWgr0yy7aIF28Sm
	 EAI1KaipI2zSw==
Date: Tue, 23 Apr 2024 09:15:54 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Baruch Siach <baruch@tkos.co.il>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Shawn Guo <shawnguo@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
 Andre Przywara <andre.przywara@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-rpi-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Barker <paul.barker@sancloud.com>, andrew@lunn.ch, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
In-Reply-To: <20240422230811.1284092-1-florian.fainelli@broadcom.com>
References: <20240422230811.1284092-1-florian.fainelli@broadcom.com>
Message-Id: <171388152725.138806.6602476145439174983.robh@kernel.org>
Subject: Re: [PATCH v2] arm: dts: bcm2711: Describe Ethernet LEDs


On Mon, 22 Apr 2024 16:08:09 -0700, Florian Fainelli wrote:
> Describe the Ethernet LEDs for the Raspberry Pi 4 model B board as well
> as the Raspberry Pi 4 CM board. The Raspberry Pi 400 board does not
> include RJ45 connector LEDs so the 'leds' node is deleted accordingly.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> Changes in v2:
> 
> - added "function = LED_FUNCTION_LAN"
> 
>  .../arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts | 20 +++++++++++++++++
>  .../arm/boot/dts/broadcom/bcm2711-rpi-400.dts |  1 +
>  .../boot/dts/broadcom/bcm2711-rpi-cm4-io.dts  | 22 +++++++++++++++++++
>  3 files changed, 43 insertions(+)
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


New warnings running 'make CHECK_DTBS=y broadcom/bcm2711-rpi-4-b.dtb broadcom/bcm2711-rpi-400.dtb broadcom/bcm2711-rpi-cm4-io.dtb' for 20240422230811.1284092-1-florian.fainelli@broadcom.com:

arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dtb: ethernet-phy@1: leds: 'leds@0', 'leds@1' do not match any of the regexes: '^led@[a-f0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/ethernet-phy.yaml#
arch/arm/boot/dts/broadcom/bcm2711-rpi-400.dtb: ethernet-phy@1: leds: 'leds@0', 'leds@1' do not match any of the regexes: '^led@[a-f0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/ethernet-phy.yaml#
arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dtb: ethernet-phy@0: leds: 'leds@1', 'leds@2' do not match any of the regexes: '^led@[a-f0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/ethernet-phy.yaml#






