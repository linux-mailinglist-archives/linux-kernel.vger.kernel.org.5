Return-Path: <linux-kernel+bounces-14187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D760C8218E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737EF1F21F73
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68C3748A;
	Tue,  2 Jan 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nPgXO884"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5386AA7;
	Tue,  2 Jan 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704187707;
	bh=gn5FpuH9CD4cUJLZXPICGs3i6tDEmWT7HtO3PfLeCgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nPgXO884a+Eq0z4hmL++VX1/Z7gHK4mqbGOWWtBUKM14g7nEmlHwqdEit8GZIZ2Rv
	 pNv6IFOdRH3iCg8Q4lzHUlpfv3V4DBbtr3+BMJe+3voFUhXIq2+yDMXGPDu4YjSqPN
	 aj9ExNclKXsReyrqbE0W7FZ8K1JpLFHySrbLrS/MRWrtQ5hZxParUbjbokUjIUUlEp
	 TnAJ1M3gSGiodthnO2d1QWOo3HyIN3RygaD8fPeCedPokPUCX/dJIOcxHr3AmP/Z1Y
	 Lr3OLY22zZmPhDT2w2dgocdYqvNnv+nEOswkadZJJrjnTxQUzuyPo3tvY23D1GwsUb
	 otaPuoKMDxvfQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D7B8037813DB;
	Tue,  2 Jan 2024 09:28:26 +0000 (UTC)
Message-ID: <39d7a40b-3618-4746-9229-c9dbe1e19d2e@collabora.com>
Date: Tue, 2 Jan 2024 10:28:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8186: Add jpgenc node
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, bin.liu@mediatek.com,
 matthias.bgg@gmail.com, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Max Staudt <mstaudt@chromium.org>,
 Ricardo Ribalda <ribalda@chromium.org>
References: <20231227130812.148914-1-eugen.hristev@collabora.com>
 <20231227130812.148914-2-eugen.hristev@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231227130812.148914-2-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/12/23 14:08, Eugen Hristev ha scritto:
> From: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> 
> Add JPEG encoder node.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Max Staudt <mstaudt@chromium.org>
> Tested-by: Max Staudt <mstaudt@chromium.org>
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> [eugen.hristev@collabora.com: minor cleanup]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index e451b6c8cd9e..ef1b269f9184 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -2054,6 +2054,19 @@ venc: video-encoder@17020000 {
>   			mediatek,scp = <&scp>;
>   		};
>   
> +		jpgenc: jpgenc@17030000 {

Can we please call this jpeg-encoder@17030000 instead?

> +			compatible = "mediatek,mt8186-jpgenc", "mediatek,mtk-jpgenc";
> +			reg = <0 0x17030000 0 0x10000>;
> +			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&vencsys CLK_VENC_CKE2_JPGENC>;
> +			clock-names = "jpgenc";

clock-names ...
iommus ....
power-domains ...

Cheers,
Angelo



