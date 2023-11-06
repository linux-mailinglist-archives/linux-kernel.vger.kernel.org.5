Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCB97E1C95
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjKFIqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjKFIqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:46:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C484383;
        Mon,  6 Nov 2023 00:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699260360; x=1730796360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ir4YTPIfr1j4DIKNSzioONONldEnRAkdPcJaPnz9zYY=;
  b=jpBMUJnZtLuoi8PYp13Iql6Qh7Dgd0vOLbO2k07rvE+a2b4OKW+oo9Pk
   3Ol5Wx01iGRd0Cq+GvDV/v9dSxn4ZPwjkT7kr3hUTdeqoLgVaniikMMSI
   GgXaBR8T7w7AJFbZ+LOusjuTamYxRJNYqMNN/OuS7Mo9TqIwgonWpp07i
   BDMVLy1z41MM8gysqOibFqfK3AokSTMnB1ifAbsg+EGMjOE/Fqc1p31H6
   INBC8O6MDyG06CfDLTWrUYlcFMCsAvBIoAgKDRKUMH5hG0xazlJ37DxiU
   Fk8PT6WWp+eddPXdGLJsN2rRCQx+NXhnhiGfpwTKUl6AhNGoQwDvtZxpv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="369440107"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="369440107"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 00:46:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="765886877"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="765886877"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 00:45:58 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id AE0FE11FB8D;
        Mon,  6 Nov 2023 10:45:55 +0200 (EET)
Date:   Mon, 6 Nov 2023 08:45:55 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] media: i2c: gc0308: new driver
Message-ID: <ZUinwwRVwqnIuueJ@kekkonen.localdomain>
References: <20231027011417.2174658-1-sre@kernel.org>
 <20231027011417.2174658-5-sre@kernel.org>
 <zcei5x4omoqamuap42imybtbsax4bw43juymald4l7ccq766lb@2wknnhmawdbt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zcei5x4omoqamuap42imybtbsax4bw43juymald4l7ccq766lb@2wknnhmawdbt>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo, Sebastian,

On Mon, Oct 30, 2023 at 09:37:08AM +0100, Jacopo Mondi wrote:
> > +static bool gc0308_is_valid_format(u32 code)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(gc0308_formats); i++) {
> > +		if (gc0308_formats[i].code == code)
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static int gc0308_enum_frame_size(struct v4l2_subdev *subdev,
> > +				  struct v4l2_subdev_state *sd_state,
> > +				  struct v4l2_subdev_frame_size_enum *fse)
> > +{
> > +	if (fse->index >= ARRAY_SIZE(gc0308_frame_sizes))
> > +		return -EINVAL;
> > +
> > +	if (!gc0308_is_valid_format(fse->code))
> > +		return -EINVAL;
> > +
> > +	fse->min_width = gc0308_frame_sizes[fse->index].width;
> > +	fse->max_width = gc0308_frame_sizes[fse->index].width;
> > +	fse->min_height = gc0308_frame_sizes[fse->index].height;
> > +	fse->max_height = gc0308_frame_sizes[fse->index].height;
> > +
> > +	return 0;
> > +}
> > +
> > +static void gc0308_update_pad_format(const struct gc0308_frame_size *mode,
> > +				     struct v4l2_mbus_framefmt *fmt, u32 code)
> > +{
> > +	fmt->width = mode->width;
> > +	fmt->height = mode->height;
> > +	fmt->code = code;
> > +	fmt->field = V4L2_FIELD_NONE;
> > +	fmt->colorspace = V4L2_COLORSPACE_SRGB;
> > +}
> > +
> > +static int gc0308_set_format(struct v4l2_subdev *sd,
> > +			     struct v4l2_subdev_state *sd_state,
> > +			     struct v4l2_subdev_format *fmt)
> > +{
> > +	struct gc0308 *gc0308 = to_gc0308(sd);
> > +	const struct gc0308_frame_size *mode;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(gc0308_formats); i++) {
> > +		if (fmt->format.code == gc0308_formats[i].code)
> > +			break;
> > +	}
> > +
> > +	if (i >= ARRAY_SIZE(gc0308_formats)) {
> > +		dev_warn(gc0308->dev, "unsupported format code: %08x\n",
> > +			 fmt->format.code);

This isn't supposed to generate a kernel log message. I'd drop it
altogether.

> > +		i = 0;
> > +	}
> 
> This looks very similar to gc0308_is_valid_format()

Could gc0308_is_valid_format() return a pointer to the format array or
NULL? Then you could check for NULL here and use the first entry in that
case.

> 
> > +
> > +	mode = v4l2_find_nearest_size(gc0308_frame_sizes,
> > +				      ARRAY_SIZE(gc0308_frame_sizes), width,
> > +				      height, fmt->format.width,
> > +				      fmt->format.height);
> > +
> > +	gc0308_update_pad_format(mode, &fmt->format, gc0308_formats[i].code);
> > +	*v4l2_subdev_get_pad_format(sd, sd_state, fmt->pad) = fmt->format;
> > +
> > +	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY)
> > +		return 0;
> > +
> > +	gc0308->mode.out_format = gc0308_formats[i].regval;
> > +	gc0308->mode.subsample = mode->subsample;
> > +	gc0308->mode.width = mode->width;
> > +	gc0308->mode.height = mode->height;
> > +
> > +	return 0;
> > +}

...

> > +	ret = v4l2_async_register_subdev(&gc0308->sd);
> > +	if (ret) {
> > +		dev_err_probe(dev, ret, "failed to register v4l subdev\n");
> > +		goto fail_power_off;
> > +	}
> > +
> > +	pm_runtime_set_active(dev);
> > +	pm_runtime_enable(dev);
> > +	pm_runtime_set_autosuspend_delay(&client->dev, 1000);
> > +	pm_runtime_use_autosuspend(&client->dev);
> > +	pm_runtime_idle(dev);

This will effective power off the device immediately, without a delay. But
I guess that's ok.

Note that enabling runtime PM needs to take place before registering the
sub-device. I'd move all these calls before that.

> > +
> > +	return 0;
> > +
> > +fail_power_off:
> > +	gc0308_power_off(dev);
> > +fail_subdev_cleanup:
> > +	v4l2_subdev_cleanup(&gc0308->sd);
> > +fail_media_entity_cleanup:
> > +	media_entity_cleanup(&gc0308->sd.entity);
> > +fail_ctrl_hdl_cleanup:
> > +	v4l2_ctrl_handler_free(&gc0308->hdl);
> > +	return ret;
> > +}
> > +
> > +static void gc0308_remove(struct i2c_client *client)
> > +{
> > +	struct gc0308 *gc0308 = i2c_get_clientdata(client);
> > +	struct device *dev = &client->dev;
> > +
> > +	pm_runtime_get_sync(dev);
> 
> Uh, I've never seen this call in a _remove before. Is it intentional ?

I think disabling runtime PM and marking the device suspended are enough
here runtime PM-wise.

> 
> Apart these two nits the rest is good! thanks for addressing the
> comments received on the previous version.
> 
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> 
> Thanks
>   j
> 
> > +
> > +	v4l2_async_unregister_subdev(&gc0308->sd);
> > +	v4l2_ctrl_handler_free(&gc0308->hdl);
> > +
> > +	pm_runtime_disable(dev);
> > +	pm_runtime_set_suspended(dev);
> > +	pm_runtime_put_noidle(dev);
> > +	gc0308_power_off(dev);
> > +}

-- 
Regards,

Sakari Ailus
