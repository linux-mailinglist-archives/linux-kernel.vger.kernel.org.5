Return-Path: <linux-kernel+bounces-6744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45681819CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD90EB22687
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163D420B1C;
	Wed, 20 Dec 2023 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RMqNigBv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0363208CC;
	Wed, 20 Dec 2023 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703068240;
	bh=n/zmS7VaIkLVY/5N1cyUJFCFW5xVaPkF4+goSBWq9cM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RMqNigBv8VHDwSINqU0L6N899DFky+1/+lQq33I3OqX38HUalwuvuhDVXnwsqUQiI
	 Q7skFkjLBCFruk/gyTDQrU1LufFQe8TgcFkhgTo+R5Y+rVyE5mTEJwxDxveZqJGEZw
	 ravUH5zW4p220IFJ5QLx5mEV+3JAdfeMm4TsrEXfgP+gdjZjOnW1bOiDTiYXEgVzbC
	 lgGNfdavd9YEMdhxRg+yYe0iB3o5xvq3gYcUkoFR9xXmOfGVllVzNCEfu2vrnyHaaI
	 vL0Dxdn1QfK+tj0CtLoFxdeRwAPfKUClI7VHsPvklpEQ4lnG8PJAvAT2Y5fcb91itt
	 sY6PK7uKV+DWA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 150E83781FC8;
	Wed, 20 Dec 2023 10:30:39 +0000 (UTC)
Message-ID: <d1767b1d-0b80-4ece-8a35-18eed52a3f6e@collabora.com>
Date: Wed, 20 Dec 2023 11:30:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: mediatek: mt8195: Add 'rx-fifo-depth'
 for cherry
Content-Language: en-US
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eddie Hung <eddie.hung@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>
References: <20231220025842.7082-1-chunfeng.yun@mediatek.com>
 <20231220025842.7082-3-chunfeng.yun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231220025842.7082-3-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/12/23 03:58, Chunfeng Yun ha scritto:
> Add the quirk property "rx-fifo-depth" to work around Gen1 isoc-in
> transfer issue which send out unexpected ACK even after device
> already finished the burst transfer with a short patcket, specially
> for a 4K camera device.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3: change value according to binding
> v2: use 'rx-fifo-depth' property
> ---
>   arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index dd5b89b73190..58593348b810 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -1185,6 +1185,7 @@
>   

Can you please place rx-fifo-depth before power supplies?

after which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thanks,
Angelo

>   	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>   	vbus-supply = <&usb_vbus>;
> +	rx-fifo-depth = <3>;
>   };
>   
>   &xhci1 {
> @@ -1192,6 +1193,7 @@
>   
>   	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>   	vbus-supply = <&usb_vbus>;
> +	rx-fifo-depth = <3>;
>   };
>   
>   &xhci2 {



