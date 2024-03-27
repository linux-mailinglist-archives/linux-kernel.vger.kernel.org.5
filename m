Return-Path: <linux-kernel+bounces-121701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0463088ECB7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD17DB21B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB15014E2CB;
	Wed, 27 Mar 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HswMO7Dh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B901304A6;
	Wed, 27 Mar 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560811; cv=none; b=uIKRGhGd7cI2l7qiJs831VMiegvf4AeyDlNUwZSyGFVI2RJ5pjm4k1tiW0limgUq0+kfmt/ZKQ6VMZ8BHVEjSBcBC0h3eOu+DZQEFvYRTZVsYdYno1ylbW5QyTRCyWZ3rKLp0G6sR1tU3cD8QxP9qskWvpyhtPUUuTAaJus4fRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560811; c=relaxed/simple;
	bh=XcISWJmiP1jYqJUIUhyT8r1VsuUqiY1gK8gvy6LLjU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqbKV+bNEdwIJ0gRhvReZmTtE8/WCtRV8pVEhncl6MA3yPHiABWq/VMZpE6pAnFslSTkfhxszPav2AU6pPNo1GZi3EpASO32OOray41Zrr1oryfmZRDdUyWD7so4+iXpPwr+KBd491K6/gIGKFIH7IZjftUyFnGIZThyLaf7Yyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HswMO7Dh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1591C433F1;
	Wed, 27 Mar 2024 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711560811;
	bh=XcISWJmiP1jYqJUIUhyT8r1VsuUqiY1gK8gvy6LLjU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HswMO7Dh++iQsFShyRLIWJ8dAKKMGV9SwB+Zkp8RfWzkNV/aksMVeBechXf6+yGAm
	 nxGO0uBjsWVRcTYD4w8T9aZ0/R4ofuWlkdzJIVwV5Q1R4wmIZbSTD/hslco8t0e8Pe
	 jqsFrYGwleZia8Fx8QlspHSX1UpTvNstm7AG3DHR5cbsttX4HsjURyOUZkwAyaq4uy
	 Lqc3qeSOQ5j+vwXRSB1tF43QFM4pqIgJn2YyHJZ3+ul1fs3N8KR6/8oA6eAKs/YYg7
	 0MddWO3+wbOq1nkQUsg9FCDZqrIUvK+ABoLxABGS3sFLIaRNywvYbNXTRZnovtKbMF
	 8Z6VdhHo1N2Jg==
Date: Wed, 27 Mar 2024 12:33:28 -0500
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Daniel Vetter <daniel@ffwll.ch>, Robert Foss <rfoss@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2] dt-bindings: display: bridge: it6505: Add
 #sound-dai-cells
Message-ID: <171156080808.3681700.13600868771478432605.robh@kernel.org>
References: <20240327085250.3427496-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327085250.3427496-1-wenst@chromium.org>


On Wed, 27 Mar 2024 16:52:48 +0800, Chen-Yu Tsai wrote:
> The ITE IT6505 display bridge can take one I2S input and transmit it
> over the DisplayPort link.
> 
> Add #sound-dai-cells (= 0) to the binding for it.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1 [1]:
> - Reference /schemas/sound/dai-common.yaml
> - Change "additionalProperties: false" to "unevaluatedProperties: false"
> 
> The driver side changes [2] are still being worked on.
> 
> [1] https://lore.kernel.org/dri-devel/20240126073511.2708574-1-wenst@chromium.org/
> [2] https://lore.kernel.org/linux-arm-kernel/20230730180803.22570-4-jiaxin.yu@mediatek.com/
> ---
>  .../devicetree/bindings/display/bridge/ite,it6505.yaml    | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


