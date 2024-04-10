Return-Path: <linux-kernel+bounces-138385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C389F085
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0736B1F22181
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8A31598EC;
	Wed, 10 Apr 2024 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezlcjtmD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7615957C;
	Wed, 10 Apr 2024 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712747847; cv=none; b=qN6yI+AqQOSVowOydKxwoRL5NZ7mePVs8MEGK1zts+0XTOrQE86DmMQnycmU95jCCTlLv+2EcKC0AYpQHFow9UENsxfDblxdDdukMgw/ujCWg9DuFoRUWxafIkS3Jzdhxu0JjtJB8qAd1uUi3EJYglsREL/edgRT19GtXMjtXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712747847; c=relaxed/simple;
	bh=pER0NM4vYBrvd5XYubWKnRCsZIKjQJ16u1XGT5yrFT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me942siNDx7SkVnUqlxxZ9v+qmASqNx/0gw1pue7DjjnfPnzPTiBUJfC09tBITp1rj7ngY8bqkZSiaL0YV9nQIxTnWNNG2dZjm6zTuUffCVJ/BCqaSu4FbHRt6XjZoY4HeZTrncS+rPnDr3LlbjJFxj5T2m30hZFUtC3igE9gis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezlcjtmD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712747846; x=1744283846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pER0NM4vYBrvd5XYubWKnRCsZIKjQJ16u1XGT5yrFT4=;
  b=ezlcjtmD/ktM6A92Py7vXB7YFnk1c6cdDfeOBpHDfbA+wwGqPx9W8qta
   6zcTrCwQGG8oPzEewnKcnbkmgUKJTEqVlcfVuWjoZgsfIP3CqRUEo/9kY
   vR8L2BbkyRRg8qFzCX58ZvqPJLWi7iQLG694Ah1F+fk1OlSW26NDxQO1g
   JOqmKhI76pBighwbRjpqrkicDWoriHADgX7zW6kT5rX8y7SDMAQGifs9J
   8pBNVbrptXfDnBbAEYbU/jz1lj3sAqFgwuCx1nXcIS7kY6Ktf9rKQpJJV
   fF82IlVyiM1pZTwjsMTLroW7iBeGqR9thp3S8poamNqxaHpZOCpDzDn4S
   A==;
X-CSE-ConnectionGUID: xXbGhC6MSze6amyX8fKQTA==
X-CSE-MsgGUID: MrYdJLMeRXuqA6InNhIaDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18816381"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18816381"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:17:25 -0700
X-CSE-ConnectionGUID: C7AjCQ9rTfCAdoyAp2k11Q==
X-CSE-MsgGUID: 3r34T1WgR5imCm5yu/AUJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20414713"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:17:23 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 4FAAC1203E6;
	Wed, 10 Apr 2024 14:17:20 +0300 (EEST)
Date: Wed, 10 Apr 2024 11:17:20 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] media: subdev: Refactor
 v4l2_subdev_enable/disable_streams()
Message-ID: <ZhZ1QNAaRtplcero@kekkonen.localdomain>
References: <20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com>
 <20240405-enable-streams-impro-v2-8-22bca967665d@ideasonboard.com>
 <ZhZmNC4hQv1leL-y@kekkonen.localdomain>
 <ec113029-bf85-44c7-9e56-d242e5eecba0@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec113029-bf85-44c7-9e56-d242e5eecba0@ideasonboard.com>

On Wed, Apr 10, 2024 at 01:35:41PM +0300, Tomi Valkeinen wrote:
> On 10/04/2024 13:13, Sakari Ailus wrote:
> > Moi,
> > 
> > Thank you for working on this.
> > 
> > On Fri, Apr 05, 2024 at 12:14:26PM +0300, Tomi Valkeinen wrote:
> > > Add two internal helper functions, v4l2_subdev_collect_streams() and
> > > v4l2_subdev_set_streams_enabled(), which allows us to refactor
> > > v4l2_subdev_enable/disable_streams() functions.
> > > 
> > > This (I think) makes the code a bit easier to read, and lets us more
> > > easily add new functionality in the helper functions in the following
> > > patch.
> > > 
> > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > ---
> > >   drivers/media/v4l2-core/v4l2-subdev.c | 111 +++++++++++++++++++---------------
> > >   1 file changed, 62 insertions(+), 49 deletions(-)
> > > 
> > > diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> > > index 015f2fb423c9..6c3c9069f1e2 100644
> > > --- a/drivers/media/v4l2-core/v4l2-subdev.c
> > > +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> > > @@ -2099,6 +2099,44 @@ int v4l2_subdev_routing_validate(struct v4l2_subdev *sd,
> > >   }
> > >   EXPORT_SYMBOL_GPL(v4l2_subdev_routing_validate);
> > > +static void v4l2_subdev_collect_streams(struct v4l2_subdev *sd,
> > > +					struct v4l2_subdev_state *state,
> > > +					u32 pad, u64 streams_mask,
> > > +					u64 *found_streams,
> > > +					u64 *enabled_streams)
> > > +{
> > > +	*found_streams = 0;
> > > +	*enabled_streams = 0;
> > > +
> > > +	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
> > > +		const struct v4l2_subdev_stream_config *cfg;
> > > +
> > > +		cfg = &state->stream_configs.configs[i];
> > 
> > You can do the assignment in declaration.
> 
> I can, but you want the lines to be split at 80, so that'll end up being in
> two lines, which, I think, looks messier than the one above.
> 
> Usually I think doing initialization when declaring the variable is best
> done if it fits into one line.

I don't consider a line break being an issue here (or almost anywhere else,
except possibly for arrays of definitions).

-- 
Sakari Ailus

