Return-Path: <linux-kernel+bounces-61531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E16C851352
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18041F24192
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DB639FC3;
	Mon, 12 Feb 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9USiGBC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849D3B783;
	Mon, 12 Feb 2024 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740044; cv=none; b=shTuFlU/qyxgZj1eOBmAgiU6F4uYQcGjARw8p/7K8xzGMo2dfY0k2KRQNHvd/VCTvwWSQMcLGlD30VnFHH8NzExigCYUJ+gteYqbU5retLNe2egnIDYCSAzekTuciJAY0EFYtHP/8mP8Y3qeAd8MyrRPIq9/67VI1+2jrSIXcYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740044; c=relaxed/simple;
	bh=95Tz2nLS8qGhsUQIbqsSqYKNRqEfqdnfgnY+bZCrxs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TsUdTv1mUXeqLYgeix15xRrU3d4J1DDMqn6O71iJNg14hWKWvZJ7I4n7noAq86WjeDAyvf22cak0ObEZzqTeelGFq3mKq0G7zbcZBufxAE/EQig7xM4CCten9FjNs976kL2uklky2pjQ5u4so7fFeUfJ82mR3ERfaOg/i8K/uGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9USiGBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FE0C433C7;
	Mon, 12 Feb 2024 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707740043;
	bh=95Tz2nLS8qGhsUQIbqsSqYKNRqEfqdnfgnY+bZCrxs8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m9USiGBCVZPxf3gJRTfe3AFevQ6PQp7alHf2Q8N/alAGW/eQ1EHbr8KPsk0D8uWCA
	 a2sPmLvwQHuixvlZZG64saCMjqtDLlgZUJUJT+62TWJn73VOZ6xz7w52AXtAe0UxYW
	 rdtLc0uYkGpWhdC5PV/PvOyP/HeIBppS4HaWgtvq7YakzsE901QBHXHnSVL0oPFX8g
	 //DdhB3il4cedvMYlOPSvyy1oTcDgkZt1hUWnWKru6ZMGJ4buxaxg/MX2+7OWx6PQF
	 mnS6Qh0zQhYqblpeNOxFjLORif8Hm+OOGOVYgvELt5YRZW13SEJGh8eH1pDZs9VX5u
	 tqI4o+CWMYgNQ==
Message-ID: <2629cd30-23aa-4f03-8452-ae13297fd6b6@kernel.org>
Date: Mon, 12 Feb 2024 14:13:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-main: disable usb lpm
Content-Language: en-US
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Bin Liu [EP]" <b-liu@ti.com>,
 "Gunasekaran, Ravi" <r-gunasekaran@ti.com>
References: <20240209130213.38908-1-andrejs.cainikovs@gmail.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240209130213.38908-1-andrejs.cainikovs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrejs,

On 09/02/2024 15:02, Andrejs Cainikovs wrote:
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> 
> AM62 USB works with some devices, while failing to operate with others.

Could you please share which devices failed to work for you?

> 
> [  560.189822] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
> [  560.195631] xhci-hcd xhci-hcd.4.auto: new USB bus registered, assigned bus number 2
> [  574.388509] xhci-hcd xhci-hcd.4.auto: can't setup: -110
> [  574.393814] xhci-hcd xhci-hcd.4.auto: USB bus 2 deregistered
> [  574.399544] xhci-hcd: probe of xhci-hcd.4.auto failed with error -110
> 
> This seems to be related to LPM (Link Power Management), and disabling it
> turns USB into reliable working state.
> 
> As per AM62 reference manual:
> 
>> 4.8.2.1 USB2SS Unsupported Features
>>
>> The following features are not supported on this family of devices:
>> ...
>> - USB 2.0 ECN: Link Power Management (LPM)
>> ...
> 
> Fixes: 2240f96cf3cd ("arm64: dts: ti: k3-am62-main: Add support for USB")
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 464b7565d085..c49fbce5cb70 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -640,6 +640,8 @@ usb0: usb@31000000 {
>  			interrupt-names = "host", "peripheral";
>  			maximum-speed = "high-speed";
>  			dr_mode = "otg";
> +			snps,usb2-gadget-lpm-disable;
> +			snps,usb2-lpm-disable;
>  		};
>  	};
>  
> @@ -663,6 +665,8 @@ usb1: usb@31100000 {
>  			interrupt-names = "host", "peripheral";
>  			maximum-speed = "high-speed";
>  			dr_mode = "otg";
> +			snps,usb2-gadget-lpm-disable;
> +			snps,usb2-lpm-disable;
>  		};
>  	};
>  

Instead of this could you please check if this series fixes the issue for you?
https://lore.kernel.org/all/20240205141221.56076-1-rogerq@kernel.org/

-- 
cheers,
-roger

