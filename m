Return-Path: <linux-kernel+bounces-73603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB61085C4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8E21F228DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC8814A0A3;
	Tue, 20 Feb 2024 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggV7LQ0D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135A36135
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458094; cv=none; b=T61jWqT9gN0u+MpzcNORHnKeF17MHn2HcaY5B1tZlCkBN5R2CuXHQ0XxZVVsjQmVqAGrh5D2/4JnPdEW0AGvmxpHOrhvUv7wlGsXdFRy/AZjSEyGUBmAc0RYAhI1cRG0q9KCB+Bq3yfHkFtdRqHgLb+kjNszcHLeh6QlFv6kt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458094; c=relaxed/simple;
	bh=DfJFKhyZQ/N2e0vgOg52j7ksnYxhMPQZuRpCjJttMhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mduADZISCXREj/4g9z3BuFuCiVGJGYLMdvnwXLnWgOY+Su7g9iF7MKsQPqevp0D3iU+khaWXj7F3pGoxKbsg2BxmqG8VpvTX98r2bIDwTA6zgorLWaMeFbpDWDLsrqHVEakIwGFUBbCNS7xS/Mys9iro8+XBukjo9RcCwd+kG94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggV7LQ0D; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708458092; x=1739994092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DfJFKhyZQ/N2e0vgOg52j7ksnYxhMPQZuRpCjJttMhE=;
  b=ggV7LQ0Dlt3vMjLe2epik6xPouEUWjucd3K1PWMmCxlwq3M4iioAz/je
   EfnvhDB+HJZuFF/SybO2t+gazC3/Mp11HOFQx+xppw3ROmLlQp+VU46Pp
   FG6/FHIonAQ2Rht1SKqm/2v8f3qi+aNZqOZUNBFJNd2a6zsnGXQ9iObVS
   r/vGGfgnvB5qNPK7HO51Uzhw3i/iL1Mo46NYPyPN7xKg9SRyWQYzKm/c9
   RFAMM7s2e6ecsf2jrgVZtAbk7P11W0oRuFdh/wE8IMeHfhrlba0YGMjwB
   cCV6F+m1DMxjQg+gQDBW94ch8pArNi49hfNTMZ6IBGh+3i7apk7RbAiLu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13704387"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="13704387"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 11:41:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="827202660"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="827202660"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 20 Feb 2024 11:41:26 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 20 Feb 2024 21:41:25 +0200
Date: Tue, 20 Feb 2024 21:41:25 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	robdclark@gmail.com, freedreno@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, quic_jesszhan@quicinc.com,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/dp: move intel_dp_vsc_sdp_pack() to generic helper
Message-ID: <ZdUAZZIO5Zk2Y8Wm@intel.com>
References: <20240215190834.3222812-1-quic_abhinavk@quicinc.com>
 <CAA8EJppQquHgSgCrxKZHPHk248Pxg7Q8mvmmjbcpUxpreQkcuA@mail.gmail.com>
 <d3674c10-5c29-d917-44f5-758d90d9e679@quicinc.com>
 <CAA8EJpqaG+fBA_FO-L7Bimtjqqg3ZDQtyJL0oPFEueb-1WxjUw@mail.gmail.com>
 <CAA8EJpoeb63QRddxawm2J0s8O0XrLQBrDuYXOB=ZtzDG7mu2PQ@mail.gmail.com>
 <ec5ee910-469e-4224-28ca-336c9f589057@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec5ee910-469e-4224-28ca-336c9f589057@quicinc.com>
X-Patchwork-Hint: comment

On Tue, Feb 20, 2024 at 11:27:18AM -0800, Abhinav Kumar wrote:
> 
> 
> On 2/20/2024 11:20 AM, Dmitry Baryshkov wrote:
> > On Tue, 20 Feb 2024 at 21:05, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> >>
> >> On Tue, 20 Feb 2024 at 20:53, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2/20/2024 10:49 AM, Dmitry Baryshkov wrote:
> >>>> On Thu, 15 Feb 2024 at 21:08, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>>>>
> >>>>> intel_dp_vsc_sdp_pack() can be re-used by other DRM drivers as well.
> >>>>> Lets move this to drm_dp_helper to achieve this.
> >>>>>
> >>>>> changes in v2:
> >>>>>           - rebased on top of drm-tip
> >>>>>
> >>>>> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>
> >>>> v1 had an explicit comment before the ack:
> >>>>
> >>>
> >>> Yes, I remember the comment. I did not make any changes to v2 other than
> >>> just rebasing it on drm-tip to get the ack from i915 folks.
> >>>
> >>>>>      From my side, with the promise of the size fixup.
> >>>>
> >>>> However I observe neither a second patch removing the size argument
> >>>> nor it being dropped as a part of this patch.
> >>>>
> >>>
> >>> Yes, now that in v2 we got the ack for this patch, I can spin a v3 with
> >>> the addition of the next patch to remove the size OR as another series
> >>> so as to not block the main series which needs this patch.
> >>>
> >>> I would prefer the latter.
> >>
> >> It doesn't work this way. The comment should have been fixed for v2.
> > 
> > This probably deserves some explanation. Currently there is only one
> > user of this function. So it is easy to fix it. Once there are several
> > users, you have to fix all of them at the same time, patching
> > different drm subtrees. That complicates the life of maintainers.
> > 
> 
> Yes, understood. Its easier to fix it now if its really needed.
> 
> Actually, I think the reason the size was passed was to make sure
> a valid struct dp_sdp *sdp was being passed.

The size is supposed to be the size of *hardware* buffer where this
gets written into. But looks like this wasn't done correctly when
the code was copy-pasted from the HDMI inforframe code.

-- 
Ville Syrjälä
Intel

