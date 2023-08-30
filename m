Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5C878DF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbjH3TRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242384AbjH3IU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:20:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEA7113;
        Wed, 30 Aug 2023 01:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693383654; x=1724919654;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=qCGMFtQfgwR1F9QTDNMJxmJP2VuKJ61eRyS0eGjsPSY=;
  b=Jt0rTajMwlMmJH8d4HWDdR/d1zwoT2NqXmJqgpj8sCsAGvkdcgc+TGVM
   5HEcRnPd9JtwPlAzNzOTXQch24dAWLl75Swh3eumjqqpkYKGaV0zvLWLp
   KjRtYWKz2ttVlChh8mA05Ip44aC78ze8Rn895sha6jQZkPM31Ect3WfNG
   CtD3vUdULV55jQ6dO9YTLgR75hJ8x+gMtXmCaLxTqwcEqtNDH/2Ztk98D
   3zPwyRzIt9ghDelUhTho6syKSaVS0rNY0emfh8UVbrexC+YO1u0C9Olq7
   AHVeyWtx+dM6718jljVRDVk2+ewLM2DbjRUE7vvYG2fw8bbCBVDTfVmkj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="374488114"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="374488114"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853643153"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="853643153"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:20:40 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 4CA1111FAB1;
        Wed, 30 Aug 2023 11:20:37 +0300 (EEST)
Date:   Wed, 30 Aug 2023 08:20:37 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Philippe CORNU <philippe.cornu@foss.st.com>
Subject: Re: [PATCH v1 3/5] media: stm32-dcmipp: STM32 DCMIPP camera
 interface driver
Message-ID: <ZO771VvxPREnoyOY@kekkonen.localdomain>
References: <20220910144010.34272-1-hugues.fruchet@foss.st.com>
 <20220910144010.34272-4-hugues.fruchet@foss.st.com>
 <ZNC5k3PynnEWL/ou@kekkonen.localdomain>
 <20230825110903.GA30381@gnbcxd0016.gnb.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825110903.GA30381@gnbcxd0016.gnb.st.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

On Fri, Aug 25, 2023 at 01:09:03PM +0200, Alain Volmat wrote:
...
> > > +static int dcmipp_pipeline_s_stream(struct dcmipp_bytecap_device *vcap,
> > > +				    int state)
> > > +{
> > > +	struct media_entity *entity = &vcap->vdev.entity;
> > > +	struct v4l2_subdev *subdev;
> > > +	struct media_pad *pad;
> > > +	int ret;
> > > +
> > > +	/* Start/stop all entities within pipeline */
> > > +	while (1) {
> > > +		pad = &entity->pads[0];
> > > +		if (!(pad->flags & MEDIA_PAD_FL_SINK))
> > > +			break;
> > > +
> > > +		pad = media_pad_remote_pad_first(pad);
> > > +		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
> > > +			break;
> > > +
> > > +		entity = pad->entity;
> > > +		subdev = media_entity_to_v4l2_subdev(entity);
> > > +
> > > +		ret = v4l2_subdev_call(subdev, video, s_stream, state);
> > 
> > Does this driver handle multiple sub-devices in the same pipeline?
> > 
> > If not, then you don't need a loop here.
> 
> The idea was to enable one after the other each subdevs part of the
> pipeline (aka: sensor -> bridge -> parallel -> byteproc -> bytecap)
> however following a discussion with Laurent in Prague I changed that
> so that each subdev call each other in cascade, quite like I already did
> the following patch for the dcmi driver:

Ack!

> 
> commit 525011d84a3f547d0643c10bbfc01d32e26a9963
> Author: Alain Volmat <alain.volmat@foss.st.com>
> Date:   Fri Jul 21 14:03:15 2023 +0200
> 
>     media: stm32: dcmi: only call s_stream on the source subdev
> 
>     Avoid calling s_stream on each subdev until reaching the sensor and
>     instead call s_stream on the source subdev only (which will in turn
>     do whatever needed to start the stream).
> 
>     Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
>     Reviewed-by: Hugues FRUCHET <hugues.fruchet@foss.st.com>
>     Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

...

> > > +#define STOP_TIMEOUT_US 1000
> > > +#define POLL_INTERVAL_US  50
> > > +static int dcmipp_byteproc_s_stream(struct v4l2_subdev *sd, int enable)
> > > +{
> > > +	struct dcmipp_byteproc_device *byteproc = v4l2_get_subdevdata(sd);
> > > +	int ret = 0;
> > > +
> > > +	mutex_lock(&byteproc->lock);
> > > +	if (enable) {
> > > +		dcmipp_byteproc_configure_framerate(byteproc);
> > > +
> > > +		ret = dcmipp_byteproc_configure_scale_crop(byteproc);
> > > +		if (ret)
> > > +			goto err;
> > 
> > This does nothing.
> 
> Not sure to understand your point here.  The s_stream callback of this
> subdev is used to configure the registers (here the ones controlling
> decimation and cropping) of the byteproc subdev.

I was referring to the last two lines --- you're jumping to essentially the
same location here.

> 
> > 
> > > +	}
> > > +
> > > +err:
> > > +	mutex_unlock(&byteproc->lock);
> > > +
> > > +	return ret;
> > > +}

...

> > > diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
> > > new file mode 100644
> > > index 000000000000..aa7ae9a5b1a8
> > > --- /dev/null
> > > +++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
> > > @@ -0,0 +1,682 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Driver for STM32 Digital Camera Memory Interface Pixel Processor
> > > + *
> > > + * Copyright (C) STMicroelectronics SA 2022
> > > + * Authors: Hugues Fruchet <hugues.fruchet@foss.st.com>
> > > + *          Alain Volmat <alain.volmat@foss.st.com>
> > > + *          for STMicroelectronics.
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/component.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/init.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/of_graph.h>
> > 
> > #include <linux/property.h> instead of these three.
> 
> Added linux/property.h however kept of_graph.h which is still necessary.
> 

You should switch to fwnode graph API as you're already using fwnodes in
the driver --- due to V4L2 fwnode.

...

> > > +static int dcmipp_graph_notify_bound(struct v4l2_async_notifier *notifier,
> > > +				     struct v4l2_subdev *subdev,
> > > +				     struct v4l2_async_subdev *asd)
> > > +{
> > > +	struct dcmipp_device *dcmipp = notifier_to_dcmipp(notifier);
> > > +	unsigned int ret;
> > > +	int src_pad;
> > > +	struct dcmipp_ent_device *sink;
> > > +	struct device_node *np = dcmipp->dev->of_node;
> > > +	struct v4l2_fwnode_endpoint ep = { .bus_type = 0 };
> > 
> > Please set bus_type explicitly (DPHY)?
> 
> My understanding is that I cannot set the bus_type here to have the
> framework check for me since we support both V4L2_MBUS_PARALLEL and
> V4L2_MBUS_BT656.

Ah, I missed this was using a parallel bus.

As you have a default in bindings, then you'll need to parse this assuming
that bus-type first. I.e. set the bus type to the default and if parsing
fails, try the other one.

-- 
Kind regards,

Sakari Ailus
