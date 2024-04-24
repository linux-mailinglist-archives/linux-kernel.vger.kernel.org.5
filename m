Return-Path: <linux-kernel+bounces-157522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45198B124F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BD628D189
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB7B16DEAD;
	Wed, 24 Apr 2024 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ib1fefbo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5FF16D9D6;
	Wed, 24 Apr 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982665; cv=none; b=uE9ZmPTqPXGTTJcFTffrm0IIjCz9+Crrlh7AaljJHpEdQLNRzZEEBwV7PpB6Lp2mm9WUa6CKtbrBIOUfS42Bdk+qchh0SvB0C4M6h6oXHYQEEeU3txDekJuwB2c+VWQowYxf6/y9wBy+gt4mQHHGpU9nFzn+ZelF2HuyAFu709o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982665; c=relaxed/simple;
	bh=7xkLBBaXS/ts3U0e/eGzzgm9XxfKNOK2obmaTlvSKJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3B2dZ/axpBUDas3i50+aMtqeWrbZVwDnaGqLwTR6DBaskcZiuAZ8RloErP1OGfZ01srxeEO+cDca0xl3V78JrxcAYiNxm8XPCrSzz/v9VkgabXwAA7nEvZtV7VOKAJtP22zn+mGneq29PLG34BTe3ZIqLhHMZx6Xf0SRlcGryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ib1fefbo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982662; x=1745518662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7xkLBBaXS/ts3U0e/eGzzgm9XxfKNOK2obmaTlvSKJQ=;
  b=ib1fefboxOUDctCIpib9X8Z415agBUtMpBakRAWHeejxqL6RA4/sr6va
   H0FldPjtVQm/jvxL0cpTJrt2l/uP6kuD0QghxLYMiLfngh5UlG0ocDejz
   h11MInOfUAlsutuSid97fMgRBJpmQET2HPkTjDLqnpw0Sg75rh/YyVRl8
   ajlNBWcHjqvlHRsON88WmlG/j/jwE0TaRp1GmzLiroRTKlm5tK+G/K1EE
   5gwfBtJmy3CuehTl7l66/KEEwRZ+VWzCqLy9n82ZN2Xg9e6ilz6RINA/4
   Xolu8sZNEhFookdW/JF+o2oAMcTpWe2Rl876sGblACFn3LPfobV+GFO3c
   g==;
X-CSE-ConnectionGUID: DUkMIiiwR2GJvRV1vlUZAA==
X-CSE-MsgGUID: 0fHHtLllQTOv0rkFFurkBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="10169224"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="10169224"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:17:41 -0700
X-CSE-ConnectionGUID: kTFwy/phR+KWMlgyOhnMww==
X-CSE-MsgGUID: 8tONyMQGRoWni1myd2XIFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24864024"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:17:33 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7403011F855;
	Wed, 24 Apr 2024 21:17:31 +0300 (EEST)
Date: Wed, 24 Apr 2024 18:17:31 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
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
	Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>,
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
Subject: Re: [PATCH v2 09/26] media: v4l: async: refactor
 v4l2_async_create_ancillary_links
Message-ID: <ZilMu614pUAzEGTa@kekkonen.localdomain>
References: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
 <20240419-fix-cocci-v2-9-2119e692309c@chromium.org>
 <40b9c015-8ccf-4313-800a-ecae9aa8cc27@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40b9c015-8ccf-4313-800a-ecae9aa8cc27@xs4all.nl>

Hi Hans,

On Wed, Apr 24, 2024 at 12:55:20PM +0200, Hans Verkuil wrote:
> On 19/04/2024 11:47, Ricardo Ribalda wrote:
> > Return 0 without checking IS_ERR or PTR_ERR if CONFIG_MEDIA_CONTROLLER
> > is not enabled.
> > 
> > This makes cocci happier:
> > 
> > drivers/media/v4l2-core/v4l2-async.c:331:23-30: ERROR: PTR_ERR applied after initialization to constant on line 319
> > 
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/v4l2-core/v4l2-async.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
> > index 4bb073587817..915a9f3ea93c 100644
> > --- a/drivers/media/v4l2-core/v4l2-async.c
> > +++ b/drivers/media/v4l2-core/v4l2-async.c
> > @@ -316,9 +316,10 @@ v4l2_async_nf_try_all_subdevs(struct v4l2_async_notifier *notifier);
> >  static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
> >  					     struct v4l2_subdev *sd)
> >  {
> > -	struct media_link *link = NULL;
> > +	struct media_link *link;
> >  
> > -#if IS_ENABLED(CONFIG_MEDIA_CONTROLLER)
> > +	if (!IS_ENABLED(CONFIG_MEDIA_CONTROLLER))
> > +		return 0;
> >  
> >  	if (sd->entity.function != MEDIA_ENT_F_LENS &&
> >  	    sd->entity.function != MEDIA_ENT_F_FLASH)
> > @@ -326,8 +327,6 @@ static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
> >  
> >  	link = media_create_ancillary_link(&n->sd->entity, &sd->entity);
> >  
> > -#endif
> > -
> >  	return IS_ERR(link) ? PTR_ERR(link) : 0;
> >  }
> 
> I think I would prefer:
> 
> static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
> 					     struct v4l2_subdev *sd)
> {
> #if IS_ENABLED(CONFIG_MEDIA_CONTROLLER)
> 	struct media_link *link;
> 
> 	...
> 
> 	return IS_ERR(link) ? PTR_ERR(link) : 0;
> #else
> 	return 0;
> #endif
> }
> 

Me, too.

-- 
Regards,

Sakari Ailus

