Return-Path: <linux-kernel+bounces-166678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8578B9E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5847287806
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA2115AAC5;
	Thu,  2 May 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgHcTmTr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A049315B97B;
	Thu,  2 May 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665721; cv=none; b=JO+tCJUPxHIxWT3bqZnIXOItKcEZmepldAHp/L1KhIY/7eHVYEUyU08X/1T2PTMuVYuyR73gJ8zKMdLZ66ev9L2OmO5Ylq/R7Sk7mSVWoDA9HDVwEVHotREG0Bxa38p9jyR4adYOFXxS80dJOLym5CpobjlPo+jVWkM2xgLqf2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665721; c=relaxed/simple;
	bh=ObIQatXLy+J9dMb/aQHo04fdKZEbIx2wJbwo8cGX7+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5A/KIw31/QZbwxgILwb7bMePa/lzJ329RIhyuc4avH4nrHklW2jTIRvHxQubgPmXRFozVswFIPMHinWvB0GDx5vbbipfqzGB4GKDURXAqfhP07SSigDjLhj54I7YNCY8sDl2y2nEEnq7IB5DnZRqGESORVC9u8GsomMGfxcJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgHcTmTr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714665720; x=1746201720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ObIQatXLy+J9dMb/aQHo04fdKZEbIx2wJbwo8cGX7+4=;
  b=CgHcTmTrbc5c7qQEHcEwcfWaU4iG3NBU7mI91RVxb/t37thaEo4AiRig
   /Sptg7/cJGrvCdfNO3D/IAQde7e7i7425vqtyE9TnRy8IrPGeceLgm69G
   P8u5+gORmkV2a9xnM1OcVqaswQVylAgO/+n0pY5SeBVE0nlfkZwBbip9u
   MzFkLvieSYfYMr8i1jBLW8DCA64kfRg6YIhnDVZsKamTQNqLgretr9Kd9
   7E9ZJCKNP+YQNsbMYDvZeDJ5mWhA6tLCbKGV1Jhuuh59LBXUj+9Gy/sZX
   L82dR5LxLelkFODpnL6YiNbm7Vm2WaE+nTufWbSIBS50WgPkeXZt8Cd4g
   A==;
X-CSE-ConnectionGUID: c80ohLDmSsWTPBh4KZT6Nw==
X-CSE-MsgGUID: ELkn2uIhQu2RZNjPkkupZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="14249275"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14249275"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 09:01:58 -0700
X-CSE-ConnectionGUID: DwJEOuh6RxCXX9j4YfsK9w==
X-CSE-MsgGUID: JXeJGl7FR16JncEZC10HRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31831298"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 09:01:48 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 1C4E111FA94;
	Thu,  2 May 2024 19:01:45 +0300 (EEST)
Date: Thu, 2 May 2024 16:01:45 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Julien Massot <julien.massot@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Yong Zhi <yong.zhi@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
	Dan Scally <djrscally@gmail.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Maxime Ripard <mripard@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Robert Foss <rfoss@kernel.org>,
	Todor Tomov <todor.too@gmail.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yong Deng <yong.deng@magewell.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Benoit Parrot <bparrot@ti.com>, Jai Luthra <j-luthra@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, linux-staging@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/2] Introduce v4l2_async_nf_unregister_cleanup
Message-ID: <ZjO46Uo_tVcRTdA0@kekkonen.localdomain>
References: <20240502-master-v1-0-8bd109c6a3ba@collabora.com>
 <20240502155626.GD15807@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502155626.GD15807@pendragon.ideasonboard.com>

Hi Laurent,

On Thu, May 02, 2024 at 06:56:26PM +0300, Laurent Pinchart wrote:
> Hi Julien,
> 
> On Thu, May 02, 2024 at 05:22:20PM +0200, Julien Massot wrote:
> > Many drivers has
> >   v4l2_async_nf_unregister(&notifier);
> >   v4l2_async_nf_cleanup(&notifier);
> > 
> > Introduce a helper function to call both functions in one line.
> 
> Does this really go in the right direction ? For other objects (video
> devices, media devices, ...), the unregistration should be done at
> .remove() time, and the cleanup at .release() time (the operation called
> when the last reference to the object is released). This is needed to
> ensure proper lifetime management of the objects, and avoid a
> use-after-free for objects that can be reached from userspace.
> 
> It could be argued that the notifier isn't exposed to userspace, but can
> we guarantee that no driver will have a need to access the notifier in a
> code path triggered by a userspace operation ? I think it would be safer
> to adopt the same split for the nofifier unregistration and cleanup. In
> my opinion using the same rule across different APIs also make it easier
> for driver authors and for reviewers to get it right.
> 
> As shown by your series, lots of drivers call v4l2_async_nf_cleanup()
> and .remove() time instead of .release(). That's because most drivers
> get lifetime management wrong and don't even implement .release().
> That's something Sakari is addressing with ongoing work. This patch
> series seems to go in the opposite direction.

This still avoids the driver authors feeling they need to implement wrapper
functions for v4l2_async_nf_{unregister,cleanup}. I'd be in favour merging
this.

I don't see this getting in the way of adding use counts as the code will
need to be changed in any case.

-- 
Regards,

Sakari Ailus

