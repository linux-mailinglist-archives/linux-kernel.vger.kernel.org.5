Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0BB78FCE8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjIAMGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjIAMGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:06:12 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBAC91;
        Fri,  1 Sep 2023 05:06:07 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 381BPsDF013382;
        Fri, 1 Sep 2023 14:05:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=selector1; bh=NdSlHIHqa5tMok/K2U+U9
        v+r1JijepolsIc0T+IbFQ4=; b=ejU/A+57BLWOJdbX0rDTGXH7bpUvLf5c3Gitr
        lHWbqUuJkFpEYOhDqMTA5HzPKc5io4kyfTAECheP/TFtHZvSWAM1wUVFsj03csiO
        85tWlzxzgGOC4BaOkMzTiR9Q3P8G8kwrKEzfks8aT5bTiDp1D2EEjicB3uc8KUXy
        hZq4WZipRvw9YJsBx5htSZy+ttmm2bN2ibHD96/Lii8uwFPC2Ddwg1I11cdJle6/
        era68FaMWsQwMH+nyUoaLXpK8BxeUnLQsMgi5I1swJwnTpdj4cA6AK3U/p5qy2Bh
        EmN/P0nbE1/kgYKP8Vrvue9lxHI/WW2VloB9xo73W+4j5gBzg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sq6tg1td9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 14:05:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 816CB100056;
        Fri,  1 Sep 2023 14:05:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 619A22291C9;
        Fri,  1 Sep 2023 14:05:44 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 1 Sep
 2023 14:05:44 +0200
Date:   Fri, 1 Sep 2023 14:05:35 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>
Subject: Re: [Linux-stm32] [PATCH v1 3/5] media: stm32-dcmipp: STM32 DCMIPP
 camera interface driver
Message-ID: <20230901120535.GA247208@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Philippe CORNU <philippe.cornu@foss.st.com>
References: <20220910144010.34272-1-hugues.fruchet@foss.st.com>
 <20220910144010.34272-4-hugues.fruchet@foss.st.com>
 <ZNC5k3PynnEWL/ou@kekkonen.localdomain>
 <20230825110903.GA30381@gnbcxd0016.gnb.st.com>
 <ZO771VvxPREnoyOY@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZO771VvxPREnoyOY@kekkonen.localdomain>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_10,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Thank you for your comments.  I made corrections on top of the
v2 I already pushed and will push this into a v3 shortly.

On Wed, Aug 30, 2023 at 08:20:37AM +0000, Sakari Ailus wrote:

...

> > > > +#define STOP_TIMEOUT_US 1000
> > > > +#define POLL_INTERVAL_US  50
> > > > +static int dcmipp_byteproc_s_stream(struct v4l2_subdev *sd, int enable)
> > > > +{
> > > > +	struct dcmipp_byteproc_device *byteproc = v4l2_get_subdevdata(sd);
> > > > +	int ret = 0;
> > > > +
> > > > +	mutex_lock(&byteproc->lock);
> > > > +	if (enable) {
> > > > +		dcmipp_byteproc_configure_framerate(byteproc);
> > > > +
> > > > +		ret = dcmipp_byteproc_configure_scale_crop(byteproc);
> > > > +		if (ret)
> > > > +			goto err;
> > > 
> > > This does nothing.
> > 
> > Not sure to understand your point here.  The s_stream callback of this
> > subdev is used to configure the registers (here the ones controlling
> > decimation and cropping) of the byteproc subdev.
> 
> I was referring to the last two lines --- you're jumping to essentially the
> same location here.

Ok.  Fixed with the s_stream calls rework.

...

> > > > diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
> > > > new file mode 100644
> > > > index 000000000000..aa7ae9a5b1a8
> > > > --- /dev/null
> > > > +++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
> > > > @@ -0,0 +1,682 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Driver for STM32 Digital Camera Memory Interface Pixel Processor
> > > > + *
> > > > + * Copyright (C) STMicroelectronics SA 2022
> > > > + * Authors: Hugues Fruchet <hugues.fruchet@foss.st.com>
> > > > + *          Alain Volmat <alain.volmat@foss.st.com>
> > > > + *          for STMicroelectronics.
> > > > + */
> > > > +
> > > > +#include <linux/clk.h>
> > > > +#include <linux/component.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/of_device.h>
> > > > +#include <linux/of_graph.h>
> > > 
> > > #include <linux/property.h> instead of these three.
> > 
> > Added linux/property.h however kept of_graph.h which is still necessary.
> > 
> You should switch to fwnode graph API as you're already using fwnodes in
> the driver --- due to V4L2 fwnode.

Done as well.

> ...
> 
> > > > +static int dcmipp_graph_notify_bound(struct v4l2_async_notifier *notifier,
> > > > +				     struct v4l2_subdev *subdev,
> > > > +				     struct v4l2_async_subdev *asd)
> > > > +{
> > > > +	struct dcmipp_device *dcmipp = notifier_to_dcmipp(notifier);
> > > > +	unsigned int ret;
> > > > +	int src_pad;
> > > > +	struct dcmipp_ent_device *sink;
> > > > +	struct device_node *np = dcmipp->dev->of_node;
> > > > +	struct v4l2_fwnode_endpoint ep = { .bus_type = 0 };
> > > 
> > > Please set bus_type explicitly (DPHY)?
> > 
> > My understanding is that I cannot set the bus_type here to have the
> > framework check for me since we support both V4L2_MBUS_PARALLEL and
> > V4L2_MBUS_BT656.
> 
> Ah, I missed this was using a parallel bus.
> 
> As you have a default in bindings, then you'll need to parse this assuming
> that bus-type first. I.e. set the bus type to the default and if parsing
> fails, try the other one.

Ok

Regards,
Alain
