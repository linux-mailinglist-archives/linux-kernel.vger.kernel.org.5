Return-Path: <linux-kernel+bounces-157525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508878B1259
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DA21C23A62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76E616FF37;
	Wed, 24 Apr 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fo3++ylS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928016EBFF;
	Wed, 24 Apr 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982946; cv=none; b=UMQ4Nj1SvoR89q3Xbs0d2rQTkD3Sh/NBbRYhljt1oFX2JjaEIUbQNU5Mb7BllfBB337Je+OL5ok8p7vEtze118D7yITg2l2KdgN3dsu6eyN09lhArL9Vcxbess1/YoY/rT47v87R7Z08lA4EiuYVaBWOzWRI/H685Lv102dQD58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982946; c=relaxed/simple;
	bh=9dqTFNekjq83nuq4A5WxGVHQROMd+6+bp42VQddKZ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTmLZSy/OgNLOj1Nd0O2qlsJTezDRuxAlyil+W7UrKpNRXAjdEry1dTaRG6BGtRBGNk/o8Bg6SPGT3svwAxCcOvTyiClfk711PG+4wnI3wdNmrdSCLH9Oz6bZBmDXG+wJQbRQp31G46vhGYsfrOlee4fBXDyzR8LN46pNMC6rHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fo3++ylS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982945; x=1745518945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9dqTFNekjq83nuq4A5WxGVHQROMd+6+bp42VQddKZ4k=;
  b=fo3++ylSefi/dy2kpifjOlO5XrbHsGCKJHdWBES9BcVHq1mNwgCy8ajL
   2mIX5jm0OyI/VVunl5LsqQ0hUKO0EfIzvlx5iir4ArjiLcA3hg7djk2T8
   jvm36yGEB/XqK++KKzrL/fSeWYqll2kiruNpYD5uw8ZWVkZUmJ3Rh52dB
   YhCDFwm1BRs/WTLOims2Da1CrzLymko0RGxXLMXAt0y4EQkUy/lJAx7dN
   8fP6vbBfxTa6CDtxueNVG1NaybGWyuvj60jeBMCIkg+n9/W4smAjWl4h+
   Ocz0xAruRSUY9oUXegrUYngeWl8dR2bg82Lk8B7TI1j4mdAcbFyVxcZ7c
   g==;
X-CSE-ConnectionGUID: SCrhgoVTSJmtVRvF6asnew==
X-CSE-MsgGUID: ZoaNxE8yTWSRp3nTTxKXhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9756854"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9756854"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:22:24 -0700
X-CSE-ConnectionGUID: nPsWMScFSZuFDn8N5RVk9Q==
X-CSE-MsgGUID: xyDd/+6JTdurYNniUF5Glg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24751858"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:22:16 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 2C82E11F855;
	Wed, 24 Apr 2024 21:22:13 +0300 (EEST)
Date: Wed, 24 Apr 2024 18:22:13 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>,
	Abylay Ospan <aospan@netup.ru>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Dmitry Osipenko <digetx@gmail.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 21/26] media: i2c: st-mipid02: Use the correct div
 function
Message-ID: <ZilN1VBduFcqNBbr@kekkonen.localdomain>
References: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
 <20240419-fix-cocci-v2-21-2119e692309c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419-fix-cocci-v2-21-2119e692309c@chromium.org>

Hi Ricardo,

On Fri, Apr 19, 2024 at 09:48:07AM +0000, Ricardo Ribalda wrote:
> link_freq does not fit in 32 bits.
> 
> Found by cocci:
> drivers/media/i2c/st-mipid02.c:329:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_s64 instead.
> 
> Reviewed-by: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/i2c/st-mipid02.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
> index f250640729ca..93a40bfda1af 100644
> --- a/drivers/media/i2c/st-mipid02.c
> +++ b/drivers/media/i2c/st-mipid02.c
> @@ -326,7 +326,7 @@ static int mipid02_configure_from_rx_speed(struct mipid02_dev *bridge,
>  	}
>  
>  	dev_dbg(&client->dev, "detect link_freq = %lld Hz", link_freq);
> -	do_div(ui_4, link_freq);
> +	ui_4 = div64_s64(ui_4, link_freq);

These are positive numbers and ui_4 is unsigned. I'd use div64_u64()
instead. With that,

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

>  	bridge->r.clk_lane_reg1 |= ui_4 << 2;
>  
>  	return 0;
> 

-- 
Regards,

Sakari Ailus

