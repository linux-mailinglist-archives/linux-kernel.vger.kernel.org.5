Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64324786F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbjHXMgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbjHXMg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:36:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0556C1711;
        Thu, 24 Aug 2023 05:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692880584; x=1724416584;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=h2/3qkQJA1p3QI2y816NduJfSiyRPzj4RaZqFsPLusM=;
  b=Eop8YOC7Na5q6WxoYr4JStie27r6xvPnhz51mcG6NQnn4vIoObMqQJsc
   TuJd8V2L5DgTHhxl3M8u3QKONlEWSrAnZg1RsIFw/aEikb0jxKiAbNVyb
   cRfYKS6Jh7iEOB7mpG4c+fgOO6jbkovdEGYyHTiEUuf1zno7htQd4iL3R
   PMEyUeAk78bINAEjKpzHvIW17EZ3lxwwwJwHWgfQoXeegqW8+by7dLmJh
   OQJiO9Q0NoRKx8oB7bKBR5yoM5vC/VUul4tbcQW3ErosoMC0a5nV32ua9
   GAj6J6piQpALHw/4birPft1R2UACZ4tA/uwrBXPUgepPAlNkwH4HK6jIK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="378181006"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="378181006"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880788602"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:36:24 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 2AA1011FAB1;
        Thu, 24 Aug 2023 15:26:42 +0300 (EEST)
Date:   Thu, 24 Aug 2023 12:26:42 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Philippe CORNU <philippe.cornu@foss.st.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v1 3/5] media: stm32-dcmipp: STM32 DCMIPP camera
 interface driver
Message-ID: <ZOdMghQXfNgKZ6cN@kekkonen.localdomain>
References: <20220910144010.34272-1-hugues.fruchet@foss.st.com>
 <20220910144010.34272-4-hugues.fruchet@foss.st.com>
 <ZNC5k3PynnEWL/ou@kekkonen.localdomain>
 <20230824110934.GA18226@gnbcxd0016.gnb.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824110934.GA18226@gnbcxd0016.gnb.st.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alanin,

On Thu, Aug 24, 2023 at 01:09:34PM +0200, Alain Volmat wrote:
> Hi Sakari,
> 
> thanks a lot for the review.  I've already taken care of the comments I got
> from Dan and will also add fixes for your comments as well before
> pushing the v2.  Before going into that I thought I'd better clarify the
> framerate part which seems the most tricky part.
> 
> On Mon, Aug 07, 2023 at 09:29:55AM +0000, Sakari Ailus wrote:

...

> > > +static int dcmipp_byteproc_g_frame_interval(struct v4l2_subdev *sd,
> > > +					    struct v4l2_subdev_frame_interval *fi)
> > > +{
> > > +	struct dcmipp_byteproc_device *byteproc = v4l2_get_subdevdata(sd);
> > > +
> > > +	if (IS_SINK(fi->pad))
> > > +		fi->interval = byteproc->sink_interval;
> > > +	else
> > > +		fi->interval = byteproc->src_interval;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int dcmipp_byteproc_s_frame_interval(struct v4l2_subdev *sd,
> > > +					    struct v4l2_subdev_frame_interval *fi)
> > > +{
> > > +	struct dcmipp_byteproc_device *byteproc = v4l2_get_subdevdata(sd);
> > > +
> > > +	mutex_lock(&byteproc->lock);
> > > +
> > > +	if (byteproc->streaming) {
> > > +		mutex_unlock(&byteproc->lock);
> > > +		return -EBUSY;
> > > +	}
> > > +
> > > +	if (fi->interval.numerator == 0 || fi->interval.denominator == 0)
> > > +		fi->interval = byteproc->sink_interval;
> > > +
> > > +	if (IS_SINK(fi->pad)) {
> > > +		/*
> > > +		 * Setting sink frame interval resets frame skipping.
> > > +		 * Sink frame interval is propagated to src.
> > > +		 */
> > > +		byteproc->frate = 0;
> > > +		byteproc->sink_interval = fi->interval;
> > > +		byteproc->src_interval = byteproc->sink_interval;
> > 
> > Is this used for anything else than configure skipping?
> > 
> > I think I'd just have a control for it in that case.
> > 
> > I don't think exposing frame interval configuration is necessarily even
> > meaningful for a device that just processes data but does not produce it.
> 
> The DCMIPP is able to perform frame drop, 1/2, 1/4, 1/8 basically.
> As Dan pointed me out, indeed setting frame interval as we did on both
> sink and source pad isn't a defined behavior.  I first thought that
> using the frame interval was the proper way to do that but that is
> indeed only used on producers such as sensors ....
> Which ctrl would you propose in such case ?

We don't have one, AFAIK, and I think it may be unlikely this will be
needed elsewhere. So I'd use a private control.

I wonder what others think. Cc Laurent as well.

-- 
Regards,

Sakari Ailus
