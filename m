Return-Path: <linux-kernel+bounces-155352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B48AE93F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B61D1B24962
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A2913B2AC;
	Tue, 23 Apr 2024 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mK6eVn0+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE76A03F;
	Tue, 23 Apr 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881753; cv=none; b=tgpzpFLD5J4yIlmSr5wBVUNQmztZKJcP/MvmIz+MSBz/cCImHbZsnnzrHuMvWAEIDBPfhMIURf4OuB3yrHOUDeBJquhirRKZ673GuoQubFj6jh2uaUcpBgHJRDQhhHLehfgM7Qx4PAeSY9TGod8g0xVGv7/3AMDm2ALGyZhXAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881753; c=relaxed/simple;
	bh=/3WljR8aW/V0E1v3Brj7is8RAe3UfhXQE6tTikPtqC0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=EhK7ILk7ALBVdx5vQygUPWGyoZdpJc3354oY3PJlsKT+pU7HgoALRCHvfDt75LP8xfrzsuGPO6YicZ5OaR1jX9bCQDHJ7DDQsNc8A4QH2u1ZZANNIFPctAoOUTAYU+zivQw6Oerns/r22gqW7oJNYCSdOgwWWOa73EJY1Ftig08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mK6eVn0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED76DC116B1;
	Tue, 23 Apr 2024 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713881753;
	bh=/3WljR8aW/V0E1v3Brj7is8RAe3UfhXQE6tTikPtqC0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mK6eVn0+DrbeOuUV5FEYf3gVV1pdsJWJ44jDyFpN5LG0XOrkPVaHns1hxOZdRpnfD
	 TVScMEj/gfBwDReV7KKIMdxKDP1sPELnA93+c2uB6Jl4BAX7sOuzV4791gXxVp3xzl
	 diBZ4aIGtXgRrNWgNdh+UIFDCW42yA8u4suDEw0y/e5v4su23hrvtb5i3ULM0ujn21
	 utOgZs1y/I6uGKooe+Av3Fh84Y3mqv+qPIxLYS7gyA2tGXj9S0Drjxim5I9mWUHuv6
	 S+6cmneB/TkgLN2rmYJLYT5Vnd3j9aX9pSweof8bDBWF26BHetkf1Ib/4YEuGFeqwG
	 06SITbLjzHV8A==
Date: Tue, 23 Apr 2024 09:15:52 -0500
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org, 
 andrew@lunn.ch, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 linux-arm-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20240422230733.1284055-1-florian.fainelli@broadcom.com>
References: <20240422230733.1284055-1-florian.fainelli@broadcom.com>
Message-Id: <171388152698.138785.3152955834733360539.robh@kernel.org>
Subject: Re: [PATCH v2] arm: dts: bcm2711: Describe Ethernet LEDs


On Mon, 22 Apr 2024 16:07:31 -0700, Florian Fainelli wrote:
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


New warnings running 'make CHECK_DTBS=y broadcom/bcm2711-rpi-4-b.dtb broadcom/bcm2711-rpi-400.dtb broadcom/bcm2711-rpi-cm4-io.dtb' for 20240422230733.1284055-1-florian.fainelli@broadcom.com:

arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dtb: ethernet-phy@0: leds: 'leds@1', 'leds@2' do not match any of the regexes: '^led@[a-f0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/ethernet-phy.yaml#
arch/arm/boot/dts/broadcom/bcm2711-rpi-400.dtb: ethernet-phy@1: leds: 'leds@0', 'leds@1' do not match any of the regexes: '^led@[a-f0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/ethernet-phy.yaml#
arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dtb: ethernet-phy@1: leds: 'leds@0', 'leds@1' do not match any of the regexes: '^led@[a-f0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/ethernet-phy.yaml#






