Return-Path: <linux-kernel+bounces-6786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD7F819D85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A91B1C25C95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E7120DFC;
	Wed, 20 Dec 2023 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ODu4dDxB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF820DCE;
	Wed, 20 Dec 2023 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703070155;
	bh=EGB6IunSYKe5necECFgzR0TUvJSKdb7pFA99X6tZ+O8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ODu4dDxBiEpJ7o3medRtHagTfn2WjgaI9rYdqVP0Pc0DNtcC0d0UMlVxHWQaHYv4F
	 quBhj4n9zoANOkcCBv3EaDZ2G5sEVqhr6jdKy1W0ztHSq7aJdd92N6kjzs5LWP9kjv
	 F/Dioy2NMq9MfoipYpGFLyZLSZv+amtX9xDtQz3cr0rKW6Q39/ez5Ty5DdP9cYkXhM
	 gBzs0C442XCm+RDiI7KK4t2Voph+1M5Bc5N0BhV/hif/W/aE7PNCqNbR8dTaks+1yd
	 wdYR1FeostmeZd1D6KRDQmpX5qRl2bugim4nJbpdb0UmfxOoeUFL5Y+Gc4xEZZn/YQ
	 EzFRrwuzLLaXQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A55A43781FC9;
	Wed, 20 Dec 2023 11:02:34 +0000 (UTC)
Message-ID: <81c4789d-e7b3-46c4-876c-954e8db9a7e2@collabora.com>
Date: Wed, 20 Dec 2023 12:02:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: dts: Add node for chip info driver
Content-Language: en-US
To: William-tw Lin <william-tw.lin@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231220103901.22180-1-william-tw.lin@mediatek.com>
 <20231220103901.22180-2-william-tw.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231220103901.22180-2-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/12/23 11:38, William-tw Lin ha scritto:
> Add dts node for socinfo retrieval for the following projects:
> MT8173, MT8183, MT8186, MT8192, MT8195
> 

arm64: dts: mediatek: Add socinfo efuses to MT8173/83/96/92/95 SoCs

Add efuse nodes for socinfo retrieval for MT8173, MT8183, MT8186,
MT8192 and MT8195.



...because you're not adding a chipinfo node, but efuse nodes :-)


> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 9 +++++++++
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 9 +++++++++
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 4 ++++
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 8 ++++++++
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 3 +++
>   5 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index c47d7d900f28..06916e60679a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -590,6 +590,15 @@
>   			reg = <0 0x10206000 0 0x1000>;
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> +
> +			socinfo_data1: socinfo-data1@40 {

Also, you don't need the phandles as those nodes will never be modified from
board specific devicetree, nor assigned to any devicetree node.

This means that you can go with just

			socinfo-data1@40 {
				reg ...
			}

same for data2 and for all SoCs.

Apart from that, looks good to me.

Cheers,
Angelo

