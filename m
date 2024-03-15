Return-Path: <linux-kernel+bounces-104596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291287D0AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A4B282CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E312481DE;
	Fri, 15 Mar 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhJj+8Mz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE14655D;
	Fri, 15 Mar 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517845; cv=none; b=lcIHbCTxG19JQgyLbReLNBM8sRR/CFsWKeqkXipW2Je79QFEwWz/UJA4Jf6PYmBPbOpk5yYqpYIyJd8XfGP5xViq3XRwGPczE2iuegIIVWwUpwzEFZqQUE4vCfgYSLIvA0XzdRSmDFuLpIylO8wxB7XnWcwOTZkdH8+MJDg5rGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517845; c=relaxed/simple;
	bh=xfj7j+GQ7Sti6p2hkBc1aWmo4ct/8hye3RvIl4hZFm0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=BaQNORXSb+rLAVm3Pu8dhMnjwnJbPyUFushB6BloOI0aOHhroggIkh88I1lcic4RE5tHKvTRYT4ocNgkbieJWkkCvgTOzFRUbgC9CTCKfgLxJ8hY6o/uenVgw7AJoOYmMj8vMFpWToZHyr6P6S+3OsjRg8J3ybuv95eYNJikWaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhJj+8Mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F289C433F1;
	Fri, 15 Mar 2024 15:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710517844;
	bh=xfj7j+GQ7Sti6p2hkBc1aWmo4ct/8hye3RvIl4hZFm0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BhJj+8Mz9M5llBMgScSn5YkUAL9cdLRZZK4M7g3TMwhydFXsljRartldKhqIH4oXS
	 +Pb5xHX8QFdYnIfRcMrJAI268RIA4Iwh4PzMsreetLxFuxQaZj4dS7AGFWY2OTmB6Z
	 1ZlXEuJG9dZgAoawaaeadIC+oylkntnHdZBvkV//cKmfKjlJ4DE6Ufr5CxNG+L27Sr
	 KwlSpMZ8gJkaNPMg6Tj0QJ08kOmUa1I7QF+sPDtuZJiW3E115soMJ2YOhJoo1kPXsn
	 hFKG+M6lURjtzItHub+LV18gUPUWQKo2svYXiixPg+2d6tmVeQe/cS5i62B9tSyr8W
	 Wwg4xRusTj5IQ==
Date: Fri, 15 Mar 2024 09:50:43 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-mediatek@lists.infradead.org, 
 mithat.guner@xeront.com, Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 erkin.bozoglu@xeront.com, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com>
References: <20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com>
Message-Id: <171051664188.1380050.5483720270155658124.robh@kernel.org>
Subject: Re: [PATCH 0/2] Set PHY address of MT7531 switch to 0x1f on
 MediaTek arm64 boards


On Thu, 14 Mar 2024 15:20:03 +0300, Arınç ÜNAL wrote:
> Hello.
> 
> This is a small patch series setting the PHY address of MT7531 to 0x1f on
> all boards that have the switch.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> Arınç ÜNAL (2):
>       arm64: dts: mediatek: mt7622: set PHY address of MT7531 switch to 0x1f
>       arm64: dts: mediatek: mt7986: set PHY address of MT7531 switch to 0x1f
> 
>  arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
>  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 4 ++--
>  arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 4 ++--
>  arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts             | 4 ++--
>  arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts             | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
> ---
> base-commit: ba90af39ba57b3fe3ecfdba0c87a80d20c7b788d
> change-id: 20240314-for-mediatek-mt7531-phy-address-9d0b4cfeca21
> 
> Best regards,
> --
> Arınç ÜNAL <arinc.unal@arinc9.com>
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


New warnings running 'make CHECK_DTBS=y mediatek/mt7622-bananapi-bpi-r64.dtb mediatek/mt7622-rfb1.dtb mediatek/mt7986a-bananapi-bpi-r3.dtb mediatek/mt7986a-rfb.dtb mediatek/mt7986b-rfb.dtb' for 20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com:

arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: switch@1f: 'interrupts' is a dependency of 'interrupt-controller'
	from schema $id: http://devicetree.org/schemas/net/dsa/mediatek,mt7530.yaml#
arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dtb: switch@1f: 'interrupts' is a dependency of 'interrupt-controller'
	from schema $id: http://devicetree.org/schemas/net/dsa/mediatek,mt7530.yaml#






