Return-Path: <linux-kernel+bounces-139249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A728A0067
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FDC286BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894B5181304;
	Wed, 10 Apr 2024 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6D/MyhR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866417F370;
	Wed, 10 Apr 2024 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776527; cv=none; b=BfJZnbt2Z5sDAXnIrmUt3HlJkwW4z/X6n9OPG66FbZUEhjLiky2fwsjrBrZ4Aob9HGmVaOKo0fA2w79rz/qXU0Qc2FKAWV24gJAqMviKEdzFXyUl6rGQirMZlg37i/XhAcAb+yMWhEjB2Ssq0WeoFX8nlgLaAxu9BKjtF5IruQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776527; c=relaxed/simple;
	bh=Y8HrYr9N2X54zlXcRSCoc2hhNScMqkdWP9FAh9Krwpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A084uA4dNvH4idQ6Z5B4G+hJKsct0gr1DEg08JZxh6+5TATgYtZgwg0l0jYjE3w+RQ/lCMahLvvv6y7LAod/Iq0iAzjmZDdduKOVZn+47wev+4UsJNQLODr0hFj9wRONRdd2O8WK7qTCeoIatCdkwi87QaYxklDqEeVRx47twpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6D/MyhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F79C433C7;
	Wed, 10 Apr 2024 19:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712776527;
	bh=Y8HrYr9N2X54zlXcRSCoc2hhNScMqkdWP9FAh9Krwpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6D/MyhRjX4ilUEZ8v2TxELy3AD7IFMbhHI+0f3QYn6legTjbs42EOHPa6Zy/N1Cv
	 8YdZnZW13beNY1N/uwPLTXi/TBR2m5pfJzQ48FsByqAFNfWGKYGXjP3lH8eU47iMcN
	 CSB/bud3Vs5fHAeuVXp7i9I4vmDpFB5W2U1iP6Z8oHNACDu9ZoGsmH7b8xVMCdLRjm
	 giGQSJMdm9AAKD2Q+Mar3iE5l6Pq7TiMnEkuHcnLw+Xl8E8yOeEpYeAO4VuVf0msiJ
	 CDs7PTm8dmFC/Pzq/Jg8gMPDsu6+wGfX2fqBHzQvlC4gxjU8Lrg0WmgZQrSfZDqG3+
	 92LTTQTuF6w+g==
Date: Wed, 10 Apr 2024 14:15:24 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, matthias.bgg@gmail.com,
	shawn.sung@mediatek.com, yu-chang.lee@mediatek.com,
	ck.hu@mediatek.com, jitao.shi@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
	kernel@collabora.com
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
Message-ID: <20240410191524.GA903053-robh@kernel.org>
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com>
 <20240409120211.321153-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409120211.321153-3-angelogioacchino.delregno@collabora.com>

On Tue, Apr 09, 2024 at 02:02:10PM +0200, AngeloGioacchino Del Regno wrote:
> Document OF graph on MMSYS/VDOSYS: this supports up to three DDP paths
> per HW instance (so potentially up to six displays for multi-vdo SoCs).
> 
> The MMSYS or VDOSYS is always the first component in the DDP pipeline,
> so it only supports an output port with multiple endpoints - where each
> endpoint defines the starting point for one of the (currently three)
> possible hardware paths.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index b3c6888c1457..4e9acd966aa5 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -93,6 +93,29 @@ properties:
>    '#reset-cells':
>      const: 1
>  
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      Output port node. This port connects the MMSYS/VDOSYS output to
> +      the first component of one display pipeline, for example one of
> +      the available OVL or RDMA blocks.
> +      Some MediaTek SoCs support up to three display outputs per MMSYS.

I'm have a hard time understanding this, but is it 3 outputs 
simultaneously or connect mmsys to 1 of 3. Generally it's multiple ports 
for the former and endpoints for the latter.

> +    properties:
> +      endpoint@0:
> +        $ref: /schemas/graph.yaml#/properties/endpoint
> +        description: Output to the primary display pipeline
> +
> +      endpoint@1:
> +        $ref: /schemas/graph.yaml#/properties/endpoint
> +        description: Output to the secondary display pipeline
> +
> +      endpoint@2:
> +        $ref: /schemas/graph.yaml#/properties/endpoint
> +        description: Output to the tertiary display pipeline
> +
> +    required:
> +      - endpoint@0
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.44.0
> 

