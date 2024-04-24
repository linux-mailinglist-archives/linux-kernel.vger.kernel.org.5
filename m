Return-Path: <linux-kernel+bounces-156689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9A58B06D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CAE1F24892
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7348715991A;
	Wed, 24 Apr 2024 10:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gVnxQX4W"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57C159908;
	Wed, 24 Apr 2024 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952957; cv=none; b=lF/N6TV5nVhE/X1mcTxp+aq3QOtE2HH96vMSwk2GpLYHHYHAu6t3JXQee/gheA1IPyA2Y00V3t+Z6dRQhICx+hVHplzsLFdOBKRe9kAnfOBZyUeax0Tdtzs3Wo++E//f11SAHi5qC7jZlCykAqbAFKWZkRpHVpMCWHcsddDGMTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952957; c=relaxed/simple;
	bh=nZK5irVR2uIXCl1fxQYGDrvG2jZj3KlZwFclmsGUUjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cW1l0cylXWsDYeRK83BedaI0AfYfKIo/bFc2nMe+LzIzaRf2WeOWvrksAKs5JpDTgwDbhkrIjR9Uu5EmhNFj7rlhwlwTpxTDN9tORmzE3whlxG9KreBkJen8fq/H2SkRGc+4bHfqMHGpLkTBzEal52PtPWLe40wfdxwHzhTnBvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gVnxQX4W; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713952951;
	bh=nZK5irVR2uIXCl1fxQYGDrvG2jZj3KlZwFclmsGUUjc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gVnxQX4WvAFaZyHnI8bBEmo2M9V/VUoMmCAW3Cc5O4TwdKHj9MWP7NYjYUZ5lz+fP
	 kKatbrN/7bWiU4Q9PKnbF3Et76Ap8sNkU3tvEC3MOoaVpo5OJeWJu1NcNnzAndvncF
	 ftAgwckMUrv0CGW6fX6umdmHqhRYFmgZ4Y0tS+OvZ8Spfo3u5PfOdDtKDIOP5ZBvsC
	 r/9ckIvPj0LXx3mxB5alDGGt57uvbwn4ocNFpIrFfFpWk380kv/Lb0CWiA1tPbZZMW
	 +zQH4+Ng++PXuA4jNOH7gvT4rsmjQee/MQRxSGnpwUv/SMj42hKroHiR8ZhORmwo+u
	 Ch33dWBiH77Kg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 263D2378107C;
	Wed, 24 Apr 2024 10:02:30 +0000 (UTC)
Message-ID: <ba25cb7b-ff93-4fcb-b943-154e960d45a0@collabora.com>
Date: Wed, 24 Apr 2024 12:02:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] media: mediatek: imgsys: Support image processing
To: Olivia Wen <olivia.wen@mediatek.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Tinghan Shen <tinghan.shen@mediatek.com>,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 jason-ch.chen@mediatek.com, yaya.chang@mediatek.com, teddy.chen@mediatek.com
References: <20240424030351.5294-1-olivia.wen@mediatek.com>
 <20240424030351.5294-5-olivia.wen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240424030351.5294-5-olivia.wen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/04/24 05:03, Olivia Wen ha scritto:
> Integrate the imgsys core architecture driver for image processing on
> the MT8188 platform.
> 
> Signed-off-by: Olivia Wen <olivia.wen@mediatek.com>

This should be reordered before introducing the 8188 scp core 1 support commit,
but let's check with Mathieu before sending a v4.

With that reordered,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   include/linux/remoteproc/mtk_scp.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/remoteproc/mtk_scp.h b/include/linux/remoteproc/mtk_scp.h
> index 7c2b7cc9..344ff41 100644
> --- a/include/linux/remoteproc/mtk_scp.h
> +++ b/include/linux/remoteproc/mtk_scp.h
> @@ -43,6 +43,7 @@ enum scp_ipi_id {
>   	SCP_IPI_CROS_HOST_CMD,
>   	SCP_IPI_VDEC_LAT,
>   	SCP_IPI_VDEC_CORE,
> +	SCP_IPI_IMGSYS_CMD,
>   	SCP_IPI_NS_SERVICE = 0xFF,
>   	SCP_IPI_MAX = 0x100,
>   };


