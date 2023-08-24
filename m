Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7BB7874E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbjHXQGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242379AbjHXQFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:05:43 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374031996;
        Thu, 24 Aug 2023 09:05:41 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37O9XXte014368;
        Thu, 24 Aug 2023 18:05:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=selector1; bh=eLiR4Yrg36nAV4ckmGB/w
        PqPu3zC6LLXLH1wrY+CNaU=; b=h2xwuEgTlLpBZLHDUaSTHwZaDlK7vH1OD82I4
        JyjnAbVQWc/q2mIgUNm7PT6BUemn7EbWduZ0f+Yg98mtuA/NzvID3P/2gB0M9vAb
        LBJ1e49L6XMVvzAJM2jiE4B74Yxyq0roj+uv3vKr77KneJf+Xl3AiXDJSzH2Kpeg
        Aqj14FSIlp6cZq8wwk8gXchg7HSAcL2y6wB1Z8tNr44Ezx+svkYg8yk+LpeWvhkd
        Pp6NHAQJRZpS265j1t6LSlbMGZzbuqdgZqyhZh3v5Ji5ba8Enyu0p8l+dbPdb2m1
        Pl4dU6wgXIiujhQmE7b8WCxFhdF7KuvTUjdI5ixvgi16TS7kg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sn1y5rhjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 18:05:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DBBAE100059;
        Thu, 24 Aug 2023 18:05:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CA001252239;
        Thu, 24 Aug 2023 18:05:13 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 24 Aug
 2023 18:05:13 +0200
Date:   Thu, 24 Aug 2023 18:05:06 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        <devicetree@vger.kernel.org>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Dan Scally <dan.scally@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>
Subject: Re: [Linux-stm32] [PATCH v1 3/5] media: stm32-dcmipp: STM32 DCMIPP
 camera interface driver
Message-ID: <20230824160506.GA21560@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        devicetree@vger.kernel.org,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Dan Scally <dan.scally@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
References: <20220910144010.34272-1-hugues.fruchet@foss.st.com>
 <20220910144010.34272-4-hugues.fruchet@foss.st.com>
 <ZNC5k3PynnEWL/ou@kekkonen.localdomain>
 <20230824110934.GA18226@gnbcxd0016.gnb.st.com>
 <ZOdMghQXfNgKZ6cN@kekkonen.localdomain>
 <20230824130432.GB27092@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824130432.GB27092@pendragon.ideasonboard.com>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_12,2023-08-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Thu, Aug 24, 2023 at 04:04:32PM +0300, Laurent Pinchart wrote:
> On Thu, Aug 24, 2023 at 12:26:42PM +0000, Sakari Ailus wrote:
> > On Thu, Aug 24, 2023 at 01:09:34PM +0200, Alain Volmat wrote:
> > > Hi Sakari,
> > > 
> > > thanks a lot for the review.  I've already taken care of the comments I got
> > > from Dan and will also add fixes for your comments as well before
> > > pushing the v2.  Before going into that I thought I'd better clarify the
> > > framerate part which seems the most tricky part.
> > > 
> > > On Mon, Aug 07, 2023 at 09:29:55AM +0000, Sakari Ailus wrote:
> > 
> > ...
> > 
> > > > > +static int dcmipp_byteproc_g_frame_interval(struct v4l2_subdev *sd,
> > > > > +					    struct v4l2_subdev_frame_interval *fi)
> > > > > +{
> > > > > +	struct dcmipp_byteproc_device *byteproc = v4l2_get_subdevdata(sd);
> > > > > +
> > > > > +	if (IS_SINK(fi->pad))
> > > > > +		fi->interval = byteproc->sink_interval;
> > > > > +	else
> > > > > +		fi->interval = byteproc->src_interval;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int dcmipp_byteproc_s_frame_interval(struct v4l2_subdev *sd,
> > > > > +					    struct v4l2_subdev_frame_interval *fi)
> > > > > +{
> > > > > +	struct dcmipp_byteproc_device *byteproc = v4l2_get_subdevdata(sd);
> > > > > +
> > > > > +	mutex_lock(&byteproc->lock);
> > > > > +
> > > > > +	if (byteproc->streaming) {
> > > > > +		mutex_unlock(&byteproc->lock);
> > > > > +		return -EBUSY;
> > > > > +	}
> > > > > +
> > > > > +	if (fi->interval.numerator == 0 || fi->interval.denominator == 0)
> > > > > +		fi->interval = byteproc->sink_interval;
> > > > > +
> > > > > +	if (IS_SINK(fi->pad)) {
> > > > > +		/*
> > > > > +		 * Setting sink frame interval resets frame skipping.
> > > > > +		 * Sink frame interval is propagated to src.
> > > > > +		 */
> > > > > +		byteproc->frate = 0;
> > > > > +		byteproc->sink_interval = fi->interval;
> > > > > +		byteproc->src_interval = byteproc->sink_interval;
> > > > 
> > > > Is this used for anything else than configure skipping?
> > > > 
> > > > I think I'd just have a control for it in that case.
> > > > 
> > > > I don't think exposing frame interval configuration is necessarily even
> > > > meaningful for a device that just processes data but does not produce it.
> > > 
> > > The DCMIPP is able to perform frame drop, 1/2, 1/4, 1/8 basically.
> > > As Dan pointed me out, indeed setting frame interval as we did on both
> > > sink and source pad isn't a defined behavior.  I first thought that
> > > using the frame interval was the proper way to do that but that is
> > > indeed only used on producers such as sensors ....
> > > Which ctrl would you propose in such case ?
> > 
> > We don't have one, AFAIK, and I think it may be unlikely this will be
> > needed elsewhere. So I'd use a private control.
> > 
> > I wonder what others think. Cc Laurent as well.
> 
> What are the use cases for this feature ?

This is basically to allow reducing the framerate of the
captured stream when this is not possible at the producer
(sensor) level and we need to lower down the stress on elements down the
pipeline.

Regards,
Alain

> 
> -- 
> Regards,
> 
> Laurent Pinchart
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
