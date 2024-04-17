Return-Path: <linux-kernel+bounces-149066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085C88A8B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680F5B259DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEAE14273;
	Wed, 17 Apr 2024 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdeHnHu5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C850C101C8;
	Wed, 17 Apr 2024 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379389; cv=none; b=Nu2MdL7X+Akcc9JVCqF1vkZlZGMG/bdB3Tjqn5f8xJuqEElmlZc9wG67YEHxsnw/KxqhAmkZyRm89ghekN0C4ICY12ly1EIaZttNh/m/wJeVfBm2oTb+0i+K1M+b+oXTfSY7+1L1cofogeFK/zAF1AXh+6h4pWTenr/L+GCAUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379389; c=relaxed/simple;
	bh=U0liresN6pKXHe9eKATPDUeQXUBQNGAGywFu8BJYKr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Leedb5csZpcQEvuqb9LYRyYh8R0C+yVtmNbt7+cvjVwjiw9RPAqw5a518Xjm3P3ICMtVmK6f+C23SK4kVTPuL8SaGZN7LVt8FgL0Hfm98KSWpBo1Xg4muf6OuFXOhWEyRPwFSI5UFDdrkS14jzP2GBZ+P6aHG7gSMXeZyHGvtyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdeHnHu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D83C072AA;
	Wed, 17 Apr 2024 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713379388;
	bh=U0liresN6pKXHe9eKATPDUeQXUBQNGAGywFu8BJYKr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdeHnHu5sNTo+q5ZUU2sw0JiYLeNIDlaZrgw4qZYb8vIUm1o9T8K2MWN8G2BY6UIy
	 Xzeu+15mlMk2tqBRHBvt8SippFORLXhC/TEBo2W5DI28mBu0URNoJwtJrZYG5H/Jbq
	 1vMA7uoIn1ePHDBDad8sk+ULPXT+rdi0kPXNxDXdIn3pECBvg1h8nR++Ss62z7Rh0E
	 n2HYoH4ddR0Ib4DvPiY6thyvWW4jFBL4vCKRR2nqzh/HyMcd2t7HWcR9keFNmNTWwC
	 sOfguIQC3WIHjAm8o6izrxZCKBupP9jTgzsIvSIa7EvfZu3Fotkl8Rg+vuXwXZEuZi
	 Q0GrC71bMgRgA==
Date: Wed, 17 Apr 2024 13:43:05 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, CK Hu <ck.hu@mediatek.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, linux-pwm@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	devicetree@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Jitao Shi <jitao.shi@mediatek.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-clk@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 01/18] dt-bindings: display: mediatek: aal: add
 compatible for MT8365 SoC
Message-ID: <171337923835.3070962.10313309897836151730.robh@kernel.org>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-1-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v2-1-33ce8864b227@baylibre.com>


On Tue, 16 Apr 2024 17:53:02 +0200, Alexandre Mergnat wrote:
> Document the display Adaptive Ambient Light on MT8365, which is compatible
> with that of the MT8183.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


