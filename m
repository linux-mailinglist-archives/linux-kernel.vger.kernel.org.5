Return-Path: <linux-kernel+bounces-139975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8718A09DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9071C21C41
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B3F13E3E5;
	Thu, 11 Apr 2024 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VHttC232"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16213DDC7;
	Thu, 11 Apr 2024 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820846; cv=none; b=aRCR0VQry1oyYc4nlCdIV8ZR2km6U+wPABMX+hfxHtjE0OSN0ggM3yZ5MdR5CO86+sJxhQhwvBe7M6d3ZyKmOL60XIWodUM/XcLzNKG5sFGYpo1qcuo2KRWtHcd/hNRJZCjF/I5MKrWp+KtEy5HZUKXNJ8l8Jf2wqqrcHWYE1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820846; c=relaxed/simple;
	bh=tt7/MyGPZ0CA5pVeuDeyftgQL+6ly8sZZrwn39jMglk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGa/cSIzntWEpdUJww/WTiLGe7g0YjTR9vrkYt0kGCP8e9I+ze9l2S55RP6Vb4cY2x6SfdDeCod/I+avt15ZTyDEA8hYzwZN1tSddMpPyQKLlvEmUpbsKQyqTCnbo+DCOZ9+xHN3k70Z4sRkNEQ0VLfHaA7h1CBU5ycKaCVOi4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VHttC232; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712820842;
	bh=tt7/MyGPZ0CA5pVeuDeyftgQL+6ly8sZZrwn39jMglk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VHttC232BqZgFZ0+jXr4HdgW5VlZoJvf0lClSpWMspk5QJXcWMknVOPTUv8fJkVBq
	 67KLm2FZIVrGTny5FOu+QVxNNZqGd4I8FulfplU22U7uWF6jaSbb9z9ZH7ON+Kbdfr
	 AIQacg9RcGXjYY10eEREzCxtDeLVAOpX2uBJY1nunWMQuGCTzwjOQ56cU+C7BVeLt/
	 qnRu1Ap8HIJPsJc3b0Rxp6nwYGWGnv9WNyboDCCq8ViWzgh5x+jR3tHb41bB4vdYyk
	 2uq/AzPSujtvV9Un+IXjQcIh/olMxCUP1x2p3eDRmcVddiU39gZ6pFevth1JADk5aO
	 svdwINhZcuBIA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 96EC93781107;
	Thu, 11 Apr 2024 07:34:01 +0000 (UTC)
Message-ID: <5cf005b9-d737-4509-a9fb-f0e59465482c@collabora.com>
Date: Thu, 11 Apr 2024 09:34:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: mediatek: Support MT8188
 dual-core SCP
To: "olivia.wen" <olivia.wen@mediatek.com>,
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
References: <20240411033750.6476-1-olivia.wen@mediatek.com>
 <20240411033750.6476-2-olivia.wen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240411033750.6476-2-olivia.wen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/04/24 05:37, olivia.wen ha scritto:
> Under different applications, the MT8188 SCP can be used as single-core
> or dual-core.
> 
> Signed-off-by: olivia.wen <olivia.wen@mediatek.com>
> ---
>   Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> index 507f98f..7e7b567 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> @@ -22,7 +22,7 @@ properties:
>         - mediatek,mt8192-scp
>         - mediatek,mt8195-scp
>         - mediatek,mt8195-scp-dual
> -

Don't remove the blank line, it's there for readability.

> +      - mediatek,mt8188-scp-dual

After addressing that comment,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>     reg:
>       description:
>         Should contain the address ranges for memory regions SRAM, CFG, and,
> @@ -195,6 +195,7 @@ allOf:
>           compatible:
>             enum:
>               - mediatek,mt8195-scp-dual
> +            - mediatek,mt8188-scp-dual
>       then:
>         properties:
>           reg:



