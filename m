Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBED7AD835
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjIYMps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYMpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:45:46 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C589C0;
        Mon, 25 Sep 2023 05:45:36 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RvMzd5wzczydx;
        Mon, 25 Sep 2023 15:45:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1695645934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sOPSJoeX7lk4kXBOKjD/0wfOKeVMRnEcwVPmunfpKUY=;
        b=etTO8CaUtGre4HA13jKDvEibGyIkV/g2M7wfUnKJj/piX4+IYLB8kqnD8f5aY64HCFkV0+
        m8Ojoy3o+9y+7HpvjgYLy3ngjXHxAUoaRhXppuYyYaL/gMpvoBymYdrGdCZ1XIXJTjuSik
        MExHosh9GHI27eCs5TDCAxgeCkP210A=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1695645934; a=rsa-sha256; cv=none;
        b=RmLO0wjM5kKI727YC8aF5MeHLcROGLg+t1HUp6NCkmHhyJUizdGj/+bvfMl2S12xW3/Wvm
        T/Ncd2j75rON+IeiYqJ2AXcVQ3zmy1TjOf7fi8rwiRwRgq56wCLJq2pXEZfF/h5hjd509R
        Go+cqnfXn2xL5YnoqpyvixcIBZD5vTM=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1695645934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sOPSJoeX7lk4kXBOKjD/0wfOKeVMRnEcwVPmunfpKUY=;
        b=jhL//sv6B8BrmUUrCl+JChbWnzCcrV90pxHZAHTJvyZU9xFySDZBAJhjYSClOreoLfhq5f
        qzGdnjM0vPIOkkznY1jSVdZkuvGv2r2rHAq0G5fETHxrN/9AUEamRIFR9iKlc3cgqdR30y
        +SZ/W3UVnfqG7rJiDZ5s+HLwJ8k6B6w=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 2D10B634C93;
        Mon, 25 Sep 2023 15:45:33 +0300 (EEST)
Date:   Mon, 25 Sep 2023 12:45:32 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        laurent.pinchart@ideasonboard.com, jacopo.mondi@ideasonboard.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH WIP RFC v2 1/2] media: uapi: Add V4L2_CID_{V,H}TOTAL
 controls
Message-ID: <ZRGA7DLdHDc07ztS@valkosipuli.retiisi.eu>
References: <20230609-v4l2-vtotal-v2-0-cf29925f4517@skidata.com>
 <20230609-v4l2-vtotal-v2-1-cf29925f4517@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609-v4l2-vtotal-v2-1-cf29925f4517@skidata.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thank you for the patchset and my apologies for reviewing this so late.

On Thu, Jun 22, 2023 at 09:12:23AM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Currently, V4L2_CID_{V,H}BLANK can be used to control the frame duration
> of a stream. However, camera sensors usually have a register for the
> total size (image data + blanking), e.g. {V,H}MAX on the imx290. As the
> user space also typically wants to set a frame size, both sides
> currently have to calculate with values they actually don't care about.
> 
> The dependency between format height and vertical blanking also results
> to a change of the vertical blanking value and limits whenever the
> format of the frame is changed and therefore makes it harder for user
> space to do calculations, e.g. the frame duration.
> V4L2_CID_{V,H}TOTAL do not depend on the format and therefore simplify
> calculations. Additionally, they represent the hardware "better" and
> therefore also simplify calculations on the driver side.
> 
> Add additional documentation about V4L2_CID_HTOTAL to have a control
> which enables the user space to express its intends to the driver. The
> driver can then update its controls and limits accordingly, and can do
> possible re-calculations during mode switches in a defined behaviour.
> This increases compatibility between different camera sensors.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
> v2:
> - add HTOTAL
> - add documentation about expectations
> ---
>  Documentation/driver-api/media/camera-sensor.rst         | 11 +++++++++--
>  .../userspace-api/media/v4l/ext-ctrls-image-source.rst   | 16 ++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c                |  2 ++
>  include/uapi/linux/v4l2-controls.h                       |  2 ++
>  4 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/media/camera-sensor.rst b/Documentation/driver-api/media/camera-sensor.rst
> index c7d4891bd24e..3ddeb0533728 100644
> --- a/Documentation/driver-api/media/camera-sensor.rst
> +++ b/Documentation/driver-api/media/camera-sensor.rst
> @@ -85,12 +85,14 @@ a result of the configuration of a number of camera sensor implementation
>  specific parameters. Luckily, these parameters tend to be the same for more or
>  less all modern raw camera sensors.
>  
> -The frame interval is calculated using the following equation::
> +The frame interval is calculated using one of the following equations::
>  
>  	frame interval = (analogue crop width + horizontal blanking) *
>  			 (analogue crop height + vertical blanking) / pixel rate
>  
> -The formula is bus independent and is applicable for raw timing parameters on
> +	frame interval = horizontal total size * vertical total size / pixel rate
> +
> +The formulas are bus independent and are applicable for raw timing parameters on

I think we should continue to have a single formula, but that the values
could be obtained different ways, depending on the driver.

For the user space it should be easier to use the controls you're
proposing but existing drivers will still continue to use the existing
controls.

In particular, you should add something like:

``V4L2_CID_VTOTAL`` value equals to analogue crop height + value of the
``V4L2_CID_VBLANK``. Similarly, ``V4L2_CID_HTOTAL`` value equals to
analogue crop width + value of the ``V4L2_CID_HBLANK``.

New drivers shall and existing drivers should implement ``V4L2_CID_VTOTAL``
and ``V4L2_CID_HTOTAL`` whereas existing drivers shall continue to
implement ``V4L2_CID_VBLANK`` and ``V4L2_CID_HBLANK``.

Implementing both in drivers can be a little bit painful. It'd be good to
add driver support for this and use this as an example (e.g. CCS). I'll see
if I could provide a patch, this will take some time still though.

I wonder what Laurent thinks.

>  large variety of devices beyond camera sensors. Devices that have no analogue
>  crop, use the full source image size, i.e. pixel array size.
>  
> @@ -100,6 +102,11 @@ is pixels and the unit of the ``V4L2_CID_VBLANK`` is lines. The pixel rate in
>  the sensor's **pixel array** is specified by ``V4L2_CID_PIXEL_RATE`` in the same
>  sub-device. The unit of that control is pixels per second.
>  
> +Additionally, the horizontal and vertical total sizes are specified by
> +``V4L2_CID_HTOTAL`` and ``V4L2_CID_VTOTAL``, respectively. The unit of the
> +``V4L2_CID_HTOTAL`` control is pixels and the unit of the ``V4L2_CID_VTOTAL`` is
> +lines, analogous to the blanking.

Add "controls" before the period.

> +
>  Register list based drivers need to implement read-only sub-device nodes for the
>  purpose. Devices that are not register list based need these to configure the
>  device's internal processing pipeline.
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
> index 71f23f131f97..5451fa0223cd 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
> @@ -59,6 +59,22 @@ Image Source Control IDs
>      non-sensitive.
>      This control is required for automatic calibration of sensors/cameras.
>  
> +``V4L2_CID_VTOTAL (integer)``
> +    Number of total lines per frame, including data and idle lines (blanking).
> +    The unit of the vertical total size is a line. Every line has length of the
> +    image width plus horizontal blanking at the pixel rate defined by
> +    ``V4L2_CID_PIXEL_RATE`` control in the same sub-device.
> +
> +``V4L2_CID_HTOTAL (integer)``
> +    Number of total pixels per line, including data and idle pixels (blanking).
> +    The unit of the horizontal total size is pixels. The default value of this
> +    control is set to a value which allows a constant total size for every
> +    supported mode of the sensor. The control can be used to indicate the driver
> +    if a high frame rate (value < default) or a high exposure (value > default)
> +    should be achieved. With value = default, a constant frame size across the
> +    different modes is targeted. Note that the actual frame rate depends on the
> +    ``V4L2_CID_PIXEL_RATE`` control, which might vary between mode switches.
> +
>  .. c:type:: v4l2_area
>  
>  .. flat-table:: struct v4l2_area
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index 564fedee2c88..34e17e1faa7a 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1112,6 +1112,8 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_TEST_PATTERN_BLUE:	return "Blue Pixel Value";
>  	case V4L2_CID_TEST_PATTERN_GREENB:	return "Green (Blue) Pixel Value";
>  	case V4L2_CID_NOTIFY_GAINS:		return "Notify Gains";
> +	case V4L2_CID_VTOTAL:			return "Vertical Total Size";
> +	case V4L2_CID_HTOTAL:			return "Horizontal Total Size";
>  
>  	/* Image processing controls */
>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 5e80daa4ffe0..a4bbd91b8aef 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -1117,6 +1117,8 @@ enum v4l2_jpeg_chroma_subsampling {
>  #define V4L2_CID_TEST_PATTERN_GREENB		(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 7)
>  #define V4L2_CID_UNIT_CELL_SIZE			(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 8)
>  #define V4L2_CID_NOTIFY_GAINS			(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 9)
> +#define V4L2_CID_VTOTAL				(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 10)
> +#define V4L2_CID_HTOTAL				(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 11)
>  
>  
>  /* Image processing controls */
> 

-- 
Kind regards,

Sakari Ailus
