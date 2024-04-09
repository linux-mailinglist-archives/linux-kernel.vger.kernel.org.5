Return-Path: <linux-kernel+bounces-137070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C189DBED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F931F24BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056C412FF6D;
	Tue,  9 Apr 2024 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lfWTI8h6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28CA12F5BD;
	Tue,  9 Apr 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672065; cv=none; b=J5srMC4jQmAmWkAug+jeuhwTpXqx18YA5Mzpf9+RKq5g32m27GSPxaXIwNu208sOO+WUVqVQEJ9YxIMfgZ1DuErDghO0M2RMT4oVns6X5QLPGu7GFSCpsIu+2lO27ZvK5fDhJ7ZsMcft631nG1z5KChG7bc/Ldm537YkHrI++dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672065; c=relaxed/simple;
	bh=bbFHu+W7pWwQce2qu4sFi0y/kXqqRKu/Ciran2Y9Ivo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqZtNZYTKxrD3t+EFK6b79bb96XQlULoXWDc97GYb9HO/pnrTCz1RJtaqMCFsBCTFN9f9GuJcuQTbpcPbOG7uqc0q+ZscU+X4HlFtxNPvTpdpACq5eIA2sDEJQwNZVDQY0Qw/v7GYpw/MvoRS2Pm/ucLa38Av6XySRIrkNg6TvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lfWTI8h6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712672061;
	bh=bbFHu+W7pWwQce2qu4sFi0y/kXqqRKu/Ciran2Y9Ivo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lfWTI8h6fwpFNiuvvllOEkLLZIusfm7UhW1Iw9+IB8wvuS6tQMHGWOUySLCjwnWOw
	 cpGsOTXoghKjMZOTPM2fAKRRAqMU8Zh5Z0jwH6aZdDfHBwk6jAiOKD+Y1Ts/rcww0R
	 1FVwx6tc1SwWh4UcfTTgFy/kg0TxTebdAd7rR53S86pdrO58S+Egu+cEAIA2wod/xl
	 IRuydABjy3CNE+CL3Sh01a+S05gWfyNB5wiiT+BRzTbxpBkiOdx2tw+knuoWbW72Oc
	 BDusFRXDfrohrpdwamfLcgIhD2zzvQu9cU+8ULxOYq4nBEH3cCs6qRxrNcRhdOFEQb
	 zkL60p9zYxlDQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 293333780480;
	Tue,  9 Apr 2024 14:14:21 +0000 (UTC)
Message-ID: <cf58846c-687c-46c4-b041-c944cab78dce@collabora.com>
Date: Tue, 9 Apr 2024 16:14:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: mediatek: mt8395-nio-12l: Fix MT6360
 regulator nodes names
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
References: <20240409114211.310462-1-angelogioacchino.delregno@collabora.com>
 <20240409114211.310462-2-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240409114211.310462-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/04/24 13:42, AngeloGioacchino Del Regno ha scritto:
> The regulators' node names for mt6360-regulator are supposed to be
> uppercase. Also, drop "-regulator" from the usb-otg-vbus node name
> to make all vregs to probe correctly.
> 
> The alternative would've been to use regulator-compatible, but that's
> a deprecated property.
> Now all regulators are probing fine.
> 
> Fixes: 96564b1e2ea4 ("arm64: dts: mediatek: Introduce the MT8395 Radxa NIO 12L board")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../boot/dts/mediatek/mt8395-radxa-nio-12l.dts | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> index e5d9b671a405..18182cf073fb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> @@ -216,7 +216,7 @@ charger {
>   			compatible = "mediatek,mt6360-chg";
>   			richtek,vinovp-microvolt = <14500000>;
>   
> -			otg_vbus_regulator: usb-otg-vbus-regulator {
> +			otg_vbus_regulator: usb-otg-vbus {

Reviewing and NACK'ing my own patch, I just noticed that everything apart the
usb-otg-vbus renaming is wrong.

The MT6360 regulator node names should not be capitalized as the bindings are
correct in this regard, and there already is one user (genio-1200-evk) apart
from NIO-12L declaring the wrong ones - so, the driver must be fixed, not the
other way around.

This patch will be cleaned up in v2.

Cheers


