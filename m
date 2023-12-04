Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDEB802E98
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjLDJad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjLDJa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:30:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C13FD6;
        Mon,  4 Dec 2023 01:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701682233; x=1733218233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o0v8o+XtHGMscrSv359utGlA1pDAUKnyad14ly7KCOM=;
  b=eawrxYmVZrBqn0rtbH8C/gJGUATHibyD4jmc5kdJFeP3mhVYIdDOBop0
   sH29xKZbFZC11CMNXulzSWG19tWVb26UNmLL3UwAZBYjKLJkd6kJt8lEs
   qhUk0rMqr4y9kvrUTWol8LzIeH+nDQbI+PG7gQ4wzcdjmdHDKrZhqOuU0
   i51uKMFNuH7QLUecZcGXJ7+AuTqbi5Zc3gpeC6u+O5KRF/Xv5HO8UgX7S
   xmsWxSf3BUPbvMv7lq0GsI1NNvt0qWf3UXvJbIpOf082mW/XG8WhHHsHP
   ZK2AGm7+pe06J0jP6mtUjIelRcrIJPmERdETSVt3MXBsJpSW0qkfvFOes
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="397594306"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="397594306"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 01:30:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="943819114"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="943819114"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 01:30:27 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 658F91206B4;
        Mon,  4 Dec 2023 11:30:24 +0200 (EET)
Date:   Mon, 4 Dec 2023 09:30:24 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        mhecht73@gmail.com, christophe.jaillet@wanadoo.fr,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v14 3/3] media: i2c: Add support for alvium camera
Message-ID: <ZW2cMPpbDN8xrOM9@kekkonen.localdomain>
References: <20231124093011.2095073-1-tomm.merciai@gmail.com>
 <20231124093011.2095073-4-tomm.merciai@gmail.com>
 <ZWpJcS7aJmnRm1CB@kekkonen.localdomain>
 <ZWr5my7SVKE2HPTZ@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWr5my7SVKE2HPTZ@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Sat, Dec 02, 2023 at 10:32:11AM +0100, Tommaso Merciai wrote:
> Hi Sakari,
> Thanks for your comments.
> 
> On Fri, Dec 01, 2023 at 09:00:33PM +0000, Sakari Ailus wrote:
> > Hi Tommaso,
> > 
> > A few more comments below...
> > 
> > On Fri, Nov 24, 2023 at 10:30:07AM +0100, Tommaso Merciai wrote:
> > 
> > ...
> > 
> > > +static int alvium_get_bcrm_vers(struct alvium_dev *alvium)
> > > +{
> > > +	struct device *dev = &alvium->i2c_client->dev;
> > > +	struct alvium_bcrm_vers *v;
> > > +	u64 val;
> > > +	int ret;
> > > +
> > > +	ret = alvium_read(alvium, REG_BCRM_VERSION_R, &val, NULL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	v = (struct alvium_bcrm_vers *)&val;
> > 
> > You're still reading the entire struct using a single read. :-( This won't
> > work on a BE machine as while the struct fields are in the same memory
> > locations, the respective data in a single 64-bit value is not.
> 
> What about splitting REG_BCRM_VERSION_R in:
> 
> #define REG_BCRM_MINOR_VERSION_R			CCI_REG16(0x0000)
> #define REG_BCRM_MAJOR_VERSION_R			CCI_REG16(0x0002)
> 
> and REG_BCRM_DEVICE_FIRMWARE_VERSION_R in:
> 
> #define REG_BCRM_DEVICE_FW_SPEC_VERSION_R		REG_BCRM_V4L2_8BIT(0x0010)
> #define REG_BCRM_DEVICE_FW_MAJOR_VERSION_R		REG_BCRM_V4L2_8BIT(0x0011)
> #define REG_BCRM_DEVICE_FW_MINOR_VERSION_R		REG_BCRM_V4L2_16BIT(0x0012)
> #define REG_BCRM_DEVICE_FW_PATCH_VERSION_R		REG_BCRM_V4L2_32BIT(0x0014)
> 
> 
> Then reading those values as a single values as you suggest:
> 
> static int alvium_get_bcrm_vers(struct alvium_dev *alvium)
> {
> 	struct device *dev = &alvium->i2c_client->dev;
> 	u64 min, maj;
> 	int ret = 0;
> 
> 	ret = alvium_read(alvium, REG_BCRM_MINOR_VERSION_R, &min, &ret);
> 	ret = alvium_read(alvium, REG_BCRM_MAJOR_VERSION_R, &maj, &ret);
> 	if (ret)
> 		return ret;
> 
> 	dev_info(dev, "bcrm version: %llu.%llu\n", min, maj);
> 
> 	return 0;
> }
> 
> static int alvium_get_fw_version(struct alvium_dev *alvium)
> {
> 	struct device *dev = &alvium->i2c_client->dev;
> 	u64 spec, maj, min, pat;
> 	int ret = 0;
> 
> 	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_SPEC_VERSION_R, &spec, &ret);
> 	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_MAJOR_VERSION_R, &maj, &ret);
> 	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_MINOR_VERSION_R, &min, &ret);
> 	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_PATCH_VERSION_R, &pat, &ret);
> 	if (ret)
> 		return ret;
> 
> 	dev_info(dev, "fw version: %llu.%llu.%llu.%llu\n", spec, maj, min, pat);
> 
> 	return 0;
> }
> 
> Then I'm going to remove alvium_bcrm_vers and alvium_fw_vers.
> And alvium_is_alive became: 
> 
> static int alvium_is_alive(struct alvium_dev *alvium)
> {
> 	u64 bcrm, hbeat;
> 	int ret = 0;
> 
> 	alvium_read(alvium, REG_BCRM_MINOR_VERSION_R, &bcrm, &ret);
> 	alvium_read(alvium, REG_BCRM_HEARTBEAT_RW, &hbeat, &ret);
> 	if (ret)
> 		return ret;
> 
> 	return hbeat;
> }
> 
> What do you think? Let me know.
> (Maybe is this that you are trying to explain me but I haven't catch,
> sorry) :)

Yes. The above code looks good to me.

> 
> 
> > 
> > > +
> > > +	dev_info(dev, "bcrm version: %u.%u\n", v->minor, v->major);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int alvium_get_fw_version(struct alvium_dev *alvium)
> > > +{
> > > +	struct device *dev = &alvium->i2c_client->dev;
> > > +	struct alvium_fw_vers *fw_v;
> > > +	u64 val;
> > > +	int ret;
> > > +
> > > +	ret = alvium_read(alvium, REG_BCRM_DEVICE_FIRMWARE_VERSION_R, &val, NULL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	fw_v = (struct alvium_fw_vers *)&val;
> > 
> > Same here.
> > 
> > > +
> > > +	dev_info(dev, "fw version: %u.%u.%u.%u\n", fw_v->special, fw_v->major,
> > > +		 fw_v->minor, fw_v->patch);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int alvium_get_bcrm_addr(struct alvium_dev *alvium)
> > > +{
> > > +	u64 val;
> > > +	int ret;
> > > +
> > > +	ret = alvium_read(alvium, REG_BCRM_REG_ADDR_R, &val, NULL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	alvium->bcrm_addr = val;
> > > +
> > > +	return 0;
> > > +}
> > 
> > ...
> > 
> > > +static int alvium_setup_mipi_fmt(struct alvium_dev *alvium)
> > > +{
> > > +	unsigned int avail_fmt_cnt = 0;
> > > +	unsigned int fmt = 0;
> > > +	size_t sz = 0;
> > > +
> > > +	alvium->alvium_csi2_fmt = NULL;
> > 
> > This seems to be unnnecessary: the field is assigned below without using it
> > (obviously).
> 
> Ok, I will remove this in v15.
> 
> > 
> > > +
> > > +	/* calculate fmt array size */
> > > +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> > > +		if (!alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit])
> > > +			continue;
> > > +
> > > +		if ((!alvium_csi2_fmts[fmt].is_raw) ||
> > > +		    (alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]))
> > > +			sz++;
> > > +	}
> > > +
> > > +	/* init alvium_csi2_fmt array */
> > > +	alvium->alvium_csi2_fmt_n = sz;
> > > +	alvium->alvium_csi2_fmt =
> > > +		kmalloc_array(sz, sizeof(struct alvium_pixfmt), GFP_KERNEL);
> > > +	if (!alvium->alvium_csi2_fmt)
> > > +		return -ENOMEM;
> > > +
> > > +	/* Create the alvium_csi2 fmt array from formats available */
> > > +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> > > +		if (!alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit])
> > > +			continue;
> > > +
> > > +		if ((!alvium_csi2_fmts[fmt].is_raw) ||
> > > +		    (alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit])) {
> > > +			alvium->alvium_csi2_fmt[avail_fmt_cnt] = alvium_csi2_fmts[fmt];
> > > +			avail_fmt_cnt++;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > 
> > ...
> > 
> > > +static const struct alvium_pixfmt *
> > > +alvium_code_to_pixfmt(struct alvium_dev *alvium, u32 code)
> > > +{
> > > +	const struct alvium_pixfmt *formats = alvium->alvium_csi2_fmt;
> > 
> > I'd use alvium->alvium_csi2_fmt and not add a local variable. Up to you.
> 
> Ok also for me.
> 
> > 
> > > +	unsigned int i;
> > > +
> > > +	for (i = 0; formats[i].code; ++i)
> > > +		if (formats[i].code == code)
> > > +			return &formats[i];
> > > +
> > > +	return &formats[0];
> > > +}
> > > +
> > > +static int alvium_set_mode(struct alvium_dev *alvium,
> > > +			   struct v4l2_subdev_state *state)
> > > +{
> > > +	struct v4l2_mbus_framefmt *fmt;
> > > +	struct v4l2_rect *crop;
> > > +	int ret;
> > > +
> > > +	crop = v4l2_subdev_state_get_crop(state, 0);
> > > +	fmt = v4l2_subdev_state_get_format(state, 0);
> > > +
> > > +	v4l_bound_align_image(&fmt->width, alvium->img_min_width,
> > > +			      alvium->img_max_width, 0,
> > > +			      &fmt->height, alvium->img_min_height,
> > > +			      alvium->img_max_height, 0, 0);
> > > +
> > > +	/* alvium don't accept negative crop left/top */
> > > +	crop->left = clamp((u32)max(0, crop->left), alvium->min_offx,
> > > +			   (u32)(alvium->img_max_width - fmt->width));
> > > +	crop->top = clamp((u32)max(0, crop->top), alvium->min_offy,
> > > +			  (u32)(alvium->img_max_height - fmt->height));
> > > +
> > > +	ret = alvium_set_img_width(alvium, fmt->width);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = alvium_set_img_height(alvium, fmt->height);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = alvium_set_img_offx(alvium, crop->left);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = alvium_set_img_offy(alvium, crop->top);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return 0;
> > > +}
> 
> I'm going to rebase v15 on top of your master branch.
> My plan is moving alvium_init_cfg now alvium_init_state into
> v4l2_subdev_internal_ops.

Ack, thanks!

-- 
Regards,

Sakari Ailus
