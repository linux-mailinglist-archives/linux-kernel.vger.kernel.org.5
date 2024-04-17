Return-Path: <linux-kernel+bounces-149074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E388A8B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF221F25056
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853EC18026;
	Wed, 17 Apr 2024 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUBYNmDO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6258F54;
	Wed, 17 Apr 2024 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379660; cv=none; b=FIeckSvR1J/a15Fx9+YmiJugZt4UlW9bzfOWFL7UF22OF/ldbL1zfki+NJZ/3yTjuILQUfb/Y8EfEk4PamsfxtNb07if4WxUOIuyaWwBF8Vw91yEu4B8ZoTexXf2MVI3bH6NQJzKsLYoqA8XVZw4qj/OVGtFgyoUYh0pXYeFsmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379660; c=relaxed/simple;
	bh=ObeGcJLBE+oOTwuDf0gmIllSwIgs3VjK5sPj+MWo/6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCaamc8w1kof+l//SbFwdbVVWDnFsaI0O/FKoD0OoVzHZCX2gakOwW0IVAcriiRG6qk45WpEQWhWuOZl32YDkUCskB0iAEeFjAXTIEdlu/uRrS1ExhnwH6Xfw+zsziZ4q8jmehyV+yGBAJoPKZtXtxlVIyZyZx61Znd38NEkvYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUBYNmDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D785C072AA;
	Wed, 17 Apr 2024 18:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713379660;
	bh=ObeGcJLBE+oOTwuDf0gmIllSwIgs3VjK5sPj+MWo/6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUBYNmDOHVR9aG0bfxb7PRFesARBFNmYyCFy6pzgSrZmAe8ueprUBCzTbebIkbgOn
	 mrlxOz7gxyv33lCKgKUily2GNr+ayCg9q1G2naEi7uUdMFGomXBybbbwrmlfTwTnfy
	 59ubGQwCR1H2T1jvDX5qLMz5WdHMJV+MvzkfvMvJ5iOqqZyBd6EYmmIrfQeHPzlEKt
	 8xe01Wx3LSBqBQTgwzPhBBcfz6gEmnIRBZ5+oHdxJHkFXN4nphc4uY//7qzCPRff1w
	 kLTGjA7AQgtwV7ZVGyk2nsL03LXEVYKRh1VsD6nx8FjvMWtgt28ah72li8BFZiECEO
	 eMmyLxrwAXrmw==
Date: Wed, 17 Apr 2024 13:47:38 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Will Deacon <will@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-pwm@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	CK Hu <ck.hu@mediatek.com>, Maxime Ripard <mripard@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jitao Shi <jitao.shi@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>, Stephen Boyd <sboyd@kernel.org>,
	David Airlie <airlied@gmail.com>
Subject: Re: [PATCH v2 08/18] dt-bindings: display: mediatek: gamma: add
 compatible for MT8365 SoC
Message-ID: <171337953454.3077398.11466593614240146510.robh@kernel.org>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-8-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v2-8-33ce8864b227@baylibre.com>


On Tue, 16 Apr 2024 17:53:09 +0200, Alexandre Mergnat wrote:
> Document the display Gamma on MT8365, which is compatible
> with that of the MT8183.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


