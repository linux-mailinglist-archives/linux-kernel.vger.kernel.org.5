Return-Path: <linux-kernel+bounces-53812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572D684A6CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FF91C249E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B71056B65;
	Mon,  5 Feb 2024 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtKVLMrt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652BB5577F;
	Mon,  5 Feb 2024 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160759; cv=none; b=EUZlKqb3cMEre0JSsGWy0FQ6G6FbN0Z1kJh45Tej5f54yzziQ5CszOohAPDRTIXrU9WQSOaOAEFzTPrmO7UrceI+1y1/F3io/nBaagC2YhcSJjaoTsFPigPdOCprTh+dtWsLeJcGdeN3SKgMdjPeuZDFi/qJkNFCgoos513Ac9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160759; c=relaxed/simple;
	bh=IQgAhNiM9Q3k0p3uoVL7JBB79afL2zsOoVNpWvCcKl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It12AArVKiPGul/hgUEUFaesRwu1IyjhLuXNgE3UVV6Z5XXY6+rlsWO9LQpj/UcyGz6rghZnzAYWtkEn+USua0tFM+ml37lJRvq31i6mYiix0KijA25jMgaV/N7mEhNkDFu/VAvlbyp3bzIOlCZhdf82HNEyKKIap+Slc53irIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtKVLMrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B54C433C7;
	Mon,  5 Feb 2024 19:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707160758;
	bh=IQgAhNiM9Q3k0p3uoVL7JBB79afL2zsOoVNpWvCcKl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qtKVLMrtkrK2hMUJn94uioxTjvRe0KKC3dIcgh4mWv/uMQK3iM7kyMimKmR0kBweM
	 2VyhcNFlxjudSEn7ZKDga6Mtcj1PmYaCjnQFrlqWdldeavwXGpUYuoDcwR4yBaNjiy
	 Vzadv3oNb0ObugFg5PT+JoDxRMND8EDRg7B5lwsMO46Hk6UHv2DjiL4MxyrpoRIn6q
	 By68DuMz4rjTBxnWm8gPnpvcEAUo/aihoZ1X+SRyNWC2OPCZWE6k5XiZoULWw41D6Y
	 ovLAm/Bievxa7cZT8ZStH2zGyjQkg3JLZMFlG62kCiyCS/cdypB2ZQ5vFFk3cqqcyR
	 uze7Hi4MG6BQg==
Date: Mon, 5 Feb 2024 19:19:15 +0000
From: Rob Herring <robh@kernel.org>
To: Adam Ford <aford173@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	David Airlie <airlied@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	frieder.schrempf@kontron.de, alexander.stein@ew.tq-group.com,
	Maxime Ripard <mripard@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Lucas Stach <l.stach@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, marex@denx.de,
	Robert Foss <rfoss@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Liu Ying <victor.liu@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 03/12] dt-bindings: soc: imx: add missing clock and
 power-domains to imx8mp-hdmi-blk-ctrl
Message-ID: <170716075503.138486.15196612878281167365.robh@kernel.org>
References: <20240203165307.7806-1-aford173@gmail.com>
 <20240203165307.7806-4-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203165307.7806-4-aford173@gmail.com>


On Sat, 03 Feb 2024 10:52:43 -0600, Adam Ford wrote:
> Per guidance from the NXP downstream kernel, if the clock is
> disabled before HDMI/LCDIF probe, LCDIF will not get pixel
> clock from HDMI PHY and throw an error:
> 
> [CRTC:39:crtc-2] vblank wait timed out
>     WARNING: CPU: 2 PID: 9 at drivers/gpu/drm/drm_atomic_helper.c:
>         1634 drm_atomic_helper_wait_for_vblanks.part.0+0x23c/0x260
> 
> Fix this by adding the fdcc clock to the hdmi_blk_ctrl.  This
> should be safe, since neither this power domain nor the dependent
> HDMI and LCDIF drivers been enabled or added to the SoC device
> tree yet.
> 
> According to Sandor Yu from NXP, "the FDCC clock is not for HDMITX
> in desgin, but it is part of HDMI domain that needed by HDMITX.
> So I think it is reasonable added it to the power domain driver."
> 
> The driver also supports two power domains which are missing from the binding
> that also fix an issue with resuming from suspend.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Update commit message to both show error and give a bit more
>      background.
>      Add missing power domains hdcp and hdrv as pointed out by Marek Vasut
> ---
>  .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


