Return-Path: <linux-kernel+bounces-157554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F88B12CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03EC1C25324
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105FE2E636;
	Wed, 24 Apr 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LyWtD7Hh"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3CC2C6BD;
	Wed, 24 Apr 2024 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984374; cv=none; b=F0DXXeS6Y1PIcNA2iW2rV4pa0tPZ6paIc6NWDvjFqTJtxZOJIwbLLttwLdt9RMLaLnkio6h5p9WX2tVe+C33N2VSDFSLXTz/Uf6hwXsBnBDxkeIAHKGZfrqpo927FQbQZkSKwM9YSsWjJSVTl1rZmiZDGskzmnyGQW+D3E2avFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984374; c=relaxed/simple;
	bh=s3FyBov567J2QGOwzCsWd6sbv2/5L8BTtQKZYmfBE4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA83Z3VnZ+ltasfyYkxXEUrTOmPIjBkCcPYsPj1D+FCHvjzjNXQYOYplxl/Ctu4gfzbwvfSLZuCRYHKDGEfZmBh30BqsmTQVBnbez3kIsPPOWVZOHypGY19lyvou14Khqt2NcKfACvkkX44j+l8z9NtELBJPKShZi65o7z+On28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LyWtD7Hh; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E133B1;
	Wed, 24 Apr 2024 20:45:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713984318;
	bh=s3FyBov567J2QGOwzCsWd6sbv2/5L8BTtQKZYmfBE4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LyWtD7HhQFhNcsJLXImxTlEO9zSrnA0XXnPz447uiAF/Ub8UwT4XZ+hvcyDUMkod9
	 TdsIHxHej3MnvOv6+cPx44pYbMUETYoC3ESpbOJODQu+8+i6ZJdk+ZjLuVIbDD+Fvz
	 VrWw2zwvUmUkCU8m2caH9M+pJwe1tu3zoTtTA6F4=
Date: Wed, 24 Apr 2024 21:46:03 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
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
Message-ID: <20240424184603.GA6282@pendragon.ideasonboard.com>
References: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
 <20240419-fix-cocci-v2-9-2119e692309c@chromium.org>
 <40b9c015-8ccf-4313-800a-ecae9aa8cc27@xs4all.nl>
 <ZilMu614pUAzEGTa@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZilMu614pUAzEGTa@kekkonen.localdomain>

On Wed, Apr 24, 2024 at 06:17:31PM +0000, Sakari Ailus wrote:
> On Wed, Apr 24, 2024 at 12:55:20PM +0200, Hans Verkuil wrote:
> > On 19/04/2024 11:47, Ricardo Ribalda wrote:
> > > Return 0 without checking IS_ERR or PTR_ERR if CONFIG_MEDIA_CONTROLLER
> > > is not enabled.
> > > 
> > > This makes cocci happier:
> > > 
> > > drivers/media/v4l2-core/v4l2-async.c:331:23-30: ERROR: PTR_ERR applied after initialization to constant on line 319
> > > 
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/v4l2-core/v4l2-async.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
> > > index 4bb073587817..915a9f3ea93c 100644
> > > --- a/drivers/media/v4l2-core/v4l2-async.c
> > > +++ b/drivers/media/v4l2-core/v4l2-async.c
> > > @@ -316,9 +316,10 @@ v4l2_async_nf_try_all_subdevs(struct v4l2_async_notifier *notifier);
> > >  static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
> > >  					     struct v4l2_subdev *sd)
> > >  {
> > > -	struct media_link *link = NULL;
> > > +	struct media_link *link;
> > >  
> > > -#if IS_ENABLED(CONFIG_MEDIA_CONTROLLER)
> > > +	if (!IS_ENABLED(CONFIG_MEDIA_CONTROLLER))
> > > +		return 0;
> > >  
> > >  	if (sd->entity.function != MEDIA_ENT_F_LENS &&
> > >  	    sd->entity.function != MEDIA_ENT_F_FLASH)
> > > @@ -326,8 +327,6 @@ static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
> > >  
> > >  	link = media_create_ancillary_link(&n->sd->entity, &sd->entity);
> > >  
> > > -#endif
> > > -
> > >  	return IS_ERR(link) ? PTR_ERR(link) : 0;
> > >  }
> > 
> > I think I would prefer:
> > 
> > static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
> > 					     struct v4l2_subdev *sd)
> > {
> > #if IS_ENABLED(CONFIG_MEDIA_CONTROLLER)
> > 	struct media_link *link;
> > 
> > 	...
> > 
> > 	return IS_ERR(link) ? PTR_ERR(link) : 0;
> > #else
> > 	return 0;
> > #endif
> > }
> > 
> 
> Me, too.

I actually prefer Ricardo's proposal :-)

-- 
Regards,

Laurent Pinchart

