Return-Path: <linux-kernel+bounces-149070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA658A8B61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E581F24F05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A18A182C5;
	Wed, 17 Apr 2024 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diCizyun"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC72914293;
	Wed, 17 Apr 2024 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379444; cv=none; b=FgjsUFHmVhREtTOWWRtRrdHitY8dIl3bdizYmhnMXpF7zkMN+1m35oznQAz1gp3qQszwkCzOUiVji1PtSV41+LE1HXjEMpLmsVhh549fQdeWyPaTYhnNYMpTlre6vHkgfrbYfRrDRqc3gmOCY4P6VybmLrjmDgpFHCrY7kKDESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379444; c=relaxed/simple;
	bh=cQST7HPvWoOjxq2pzYUfgRSGfNDWwl0ha9HmVsKgmTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKD3Pge4Ya43Dd48slSVpa95yD+dz1N22tR0YN/DcSUbGzvqk24ei+qe8PVKkmqmIU70+eUgK+lPFktO1Xeyf+SEAg9DvWTdKEjIdlccjE18pKIgtGk9d5jLSKUuz54E5NPrLo8+hWEiNDAJCaCZ8x+SEjjwJQ4BCLllCqdo7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diCizyun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BC8C072AA;
	Wed, 17 Apr 2024 18:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713379444;
	bh=cQST7HPvWoOjxq2pzYUfgRSGfNDWwl0ha9HmVsKgmTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diCizyuni9BFuQ5Mtl4gw8SQkycTRzAcDrxgwfRisn4x2wf2DanzFiA+NMQpIwt9k
	 lmpEyQr6sm1m0sK8Vj9cFlUbvDhJGG5yOezsD5RKfvNzz9hZRhpwM8dR4HyqQ60jIt
	 PVusK1hYBEo513llnWPS/atnNtyUEKBY9I+/4mGmdRDhgn30jOwEYfCDSrHWxsl+mh
	 X49X+eTU0KHwT4HF/UPiO54LpnPR6nzUNsRzqpkYnAkentfXgPl4UNMMvrHII8rDb7
	 fYm5yRHlAzQBjaVIqpjEsr/oAJBr8CF478TqIJ8ulMrr2+nS9u3U8mJS6fJfwT/gz3
	 aIB/hETSz048A==
Date: Wed, 17 Apr 2024 13:44:02 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Maxime Ripard <mripard@kernel.org>,
	Jitao Shi <jitao.shi@mediatek.com>,
	Thomas Zimmermann <tzimmermann@suse.de>, linux-clk@vger.kernel.org,
	linux-mediatek@lists.infradead.org, Will Deacon <will@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-pwm@vger.kernel.org, CK Hu <ck.hu@mediatek.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 05/18] dt-bindings: display: mediatek: dsi: add
 compatible for MT8365 SoC
Message-ID: <171337931828.3072886.17211632669109957166.robh@kernel.org>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-5-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v2-5-33ce8864b227@baylibre.com>


On Tue, 16 Apr 2024 17:53:06 +0200, Alexandre Mergnat wrote:
> Document the Display Serial Interface on MT8365, which is compatible
> with that of the MT8183.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


