Return-Path: <linux-kernel+bounces-149077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6F48A8B88
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0548328373A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E9424B33;
	Wed, 17 Apr 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSHNArYJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE937208D6;
	Wed, 17 Apr 2024 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379722; cv=none; b=W+sMr8X6uw2nxphQPi41en1jSV00XGgigi1bq1tjM/9cmh2JIHqwMqqFVJFVU29gar58e4+YIX1iidy5I/B6Lt9OByCH/4gH3MQpGbwsalkPhvuhdYK2ctmDVdUeGx7OPw6wIXf68mj0pP0BCvIpz6Kgm3bnP1q8JQvS+0ZyMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379722; c=relaxed/simple;
	bh=vQJuYu8n6tKRsxdPMUC68Q9FqABjhqR4vGFq0S3iuzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pd+yoRv4VaKdnfXwUPxKfeIHP8Dx69sD5pcUJ1XN4+431tcFDtUQzQ0EdMipG/j3oz5NpyUEgXLFJct4fNPu+K7yZ4CO/4S2FzC+SJ7uaNTWLVCP3cwi8kl7QwILBe0MrCyvQZvg+2Le1beckZwOJ83NPvUvyc2DobVzo8mdUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSHNArYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ECDC32781;
	Wed, 17 Apr 2024 18:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713379722;
	bh=vQJuYu8n6tKRsxdPMUC68Q9FqABjhqR4vGFq0S3iuzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fSHNArYJs5xOZGB0K0u7Tpp3XYM0KQpcIr8ol9MM0hAKFrG6mp1bcx/JpDfvdqYoQ
	 l0yGgmbsUzw9xMZW2i61pR+pFfs8kpXWexlx6KReXrAwvAgJaPaemXxhrnNh34YWSY
	 QUQLvhkqEczRD3cP+tIGCjYm1JzozVAj2YN6oc9giSdYLTP16ocmbXVtzvKORjrrM4
	 KNYk/Re9IRy8RR0ygmPkxj2i1oOjFzmEwqfHZp8Lwe9CDUXVQZ0au0u3Kr92lVWDTk
	 XvXaiZZmEwtRlvDRx9kfv7DGnbHFXaJ20+EMv/Yt1hQA7dRO9z52evtibPPfc5wPxo
	 dZZqIjE0y+sDA==
Date: Wed, 17 Apr 2024 13:48:40 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-clk@vger.kernel.org, Will Deacon <will@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, linux-pwm@vger.kernel.org,
	David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
	Jitao Shi <jitao.shi@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	Maxime Ripard <mripard@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	CK Hu <ck.hu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 10/18] dt-bindings: display: mediatek: rdma: add
 compatible for MT8365 SoC
Message-ID: <171337955722.3078087.17269259484648392876.robh@kernel.org>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-10-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v2-10-33ce8864b227@baylibre.com>


On Tue, 16 Apr 2024 17:53:11 +0200, Alexandre Mergnat wrote:
> Document the display Data Path Read DMA on MT8365, which is compatible
> with that of the MT8183.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


