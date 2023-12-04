Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F012802E9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjLDJch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDJcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:32:35 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05027B3;
        Mon,  4 Dec 2023 01:32:41 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a18f732dc83so718768466b.1;
        Mon, 04 Dec 2023 01:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701682359; x=1702287159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+mtN4zmAzznOjzMpPi9qTzxvuIeR/3N1bXJ5e9qBl8=;
        b=VeJIbdQ/tvOGL8okdFkFL5FyO+oo52VF/ODG+RgDIyg8yYYhZWxAP3MhLQ8duB8E+P
         7MS4Is5bKyXvPma7s3uEGR2xmjabBqfFVz0R6dHlFb8Ad6PMi1EBODRJHuTQ2MA5kjKR
         w6Rww4nQKWhGwqy6+ZTLEIM06pG53LkVnb93g4snSQZae4LlVhetgRxpKvrMxYDtWIqh
         qsgJ13tjoezoLB0g3g68Gg3qHXq8tbDt2gTdOZpEOVJFRoCwDkDkuVvx0S/D/cLRolJq
         U8/EcbNvItYh5F3CxmFVrp4+YGZz7G+COdJWWP80O7cLJVrA+vSgTKLBKMcJym8GVaEY
         jz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682359; x=1702287159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+mtN4zmAzznOjzMpPi9qTzxvuIeR/3N1bXJ5e9qBl8=;
        b=Y3XKoilzXy+m56u8V+IccwDzSMXS5M8JH0s4DBb5n4KwmfNJatyzTb9nt1DhTn35zd
         pS+y8fK0f/zv7kWku50/9+o/huGZVMDXRANKYv6IzHKxcYmCssdjTqYpNq6lTDq7HQfo
         b3ftQjo6siBauuErcPscHCrvc8sMJvg5mkUId/+4KAuwm+CPhbkVT3UpqhTS6X1L4BBl
         z2lOCTP4vECb4eeP9ylBXM//KG4n9wsOzpoxoPOb3GXxV87VN7IDixg1+5F/4LMn+x2O
         BoBOEf28987D45zycx5SE81X9cQ6amFys7v6e3cYrIBeeXfRP5qBHONKLs9Cq2/lOTZe
         R/rw==
X-Gm-Message-State: AOJu0YwAhutbLvK8VDRpBaKOFXeamBKGKTVs0LiuOC8lvGiJ4sIhSFWw
        TdcwvrROiWZzRjUT30BN6CQ=
X-Google-Smtp-Source: AGHT+IHO/c0ZrNLFnXubriLD085HuqUOILRq3dzqyVISFYae0dOGfFJkejkrr8bLPsASybUH4dKZzg==
X-Received: by 2002:a17:907:174d:b0:9b2:be2f:e31a with SMTP id lf13-20020a170907174d00b009b2be2fe31amr5758276ejc.31.1701682358997;
        Mon, 04 Dec 2023 01:32:38 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-48-100.cust.vodafonedsl.it. [188.217.48.100])
        by smtp.gmail.com with ESMTPSA id q20-20020a170906145400b009fc927023bcsm5113943ejc.34.2023.12.04.01.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:32:38 -0800 (PST)
Date:   Mon, 4 Dec 2023 10:32:35 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
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
Message-ID: <ZW2cs8iJD+FyHHVt@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231124093011.2095073-1-tomm.merciai@gmail.com>
 <20231124093011.2095073-4-tomm.merciai@gmail.com>
 <ZWpJcS7aJmnRm1CB@kekkonen.localdomain>
 <ZWr5my7SVKE2HPTZ@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <ZW2cMPpbDN8xrOM9@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW2cMPpbDN8xrOM9@kekkonen.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Mon, Dec 04, 2023 at 09:30:24AM +0000, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Sat, Dec 02, 2023 at 10:32:11AM +0100, Tommaso Merciai wrote:
> > Hi Sakari,
> > Thanks for your comments.
> > 
> > On Fri, Dec 01, 2023 at 09:00:33PM +0000, Sakari Ailus wrote:
> > > Hi Tommaso,
> > > 
> > > A few more comments below...
> > > 
> > > On Fri, Nov 24, 2023 at 10:30:07AM +0100, Tommaso Merciai wrote:
> > > 
> > > ...
> > > 
> > > > +static int alvium_get_bcrm_vers(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	struct alvium_bcrm_vers *v;
> > > > +	u64 val;
> > > > +	int ret;
> > > > +
> > > > +	ret = alvium_read(alvium, REG_BCRM_VERSION_R, &val, NULL);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	v = (struct alvium_bcrm_vers *)&val;
> > > 
> > > You're still reading the entire struct using a single read. :-( This won't
> > > work on a BE machine as while the struct fields are in the same memory
> > > locations, the respective data in a single 64-bit value is not.
> > 
> > What about splitting REG_BCRM_VERSION_R in:
> > 
> > #define REG_BCRM_MINOR_VERSION_R			CCI_REG16(0x0000)
> > #define REG_BCRM_MAJOR_VERSION_R			CCI_REG16(0x0002)
> > 
> > and REG_BCRM_DEVICE_FIRMWARE_VERSION_R in:
> > 
> > #define REG_BCRM_DEVICE_FW_SPEC_VERSION_R		REG_BCRM_V4L2_8BIT(0x0010)
> > #define REG_BCRM_DEVICE_FW_MAJOR_VERSION_R		REG_BCRM_V4L2_8BIT(0x0011)
> > #define REG_BCRM_DEVICE_FW_MINOR_VERSION_R		REG_BCRM_V4L2_16BIT(0x0012)
> > #define REG_BCRM_DEVICE_FW_PATCH_VERSION_R		REG_BCRM_V4L2_32BIT(0x0014)
> > 
> > 
> > Then reading those values as a single values as you suggest:
> > 
> > static int alvium_get_bcrm_vers(struct alvium_dev *alvium)
> > {
> > 	struct device *dev = &alvium->i2c_client->dev;
> > 	u64 min, maj;
> > 	int ret = 0;
> > 
> > 	ret = alvium_read(alvium, REG_BCRM_MINOR_VERSION_R, &min, &ret);
> > 	ret = alvium_read(alvium, REG_BCRM_MAJOR_VERSION_R, &maj, &ret);
> > 	if (ret)
> > 		return ret;
> > 
> > 	dev_info(dev, "bcrm version: %llu.%llu\n", min, maj);
> > 
> > 	return 0;
> > }
> > 
> > static int alvium_get_fw_version(struct alvium_dev *alvium)
> > {
> > 	struct device *dev = &alvium->i2c_client->dev;
> > 	u64 spec, maj, min, pat;
> > 	int ret = 0;
> > 
> > 	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_SPEC_VERSION_R, &spec, &ret);
> > 	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_MAJOR_VERSION_R, &maj, &ret);
> > 	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_MINOR_VERSION_R, &min, &ret);
> > 	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_PATCH_VERSION_R, &pat, &ret);
> > 	if (ret)
> > 		return ret;
> > 
> > 	dev_info(dev, "fw version: %llu.%llu.%llu.%llu\n", spec, maj, min, pat);
> > 
> > 	return 0;
> > }
> > 
> > Then I'm going to remove alvium_bcrm_vers and alvium_fw_vers.
> > And alvium_is_alive became: 
> > 
> > static int alvium_is_alive(struct alvium_dev *alvium)
> > {
> > 	u64 bcrm, hbeat;
> > 	int ret = 0;
> > 
> > 	alvium_read(alvium, REG_BCRM_MINOR_VERSION_R, &bcrm, &ret);
> > 	alvium_read(alvium, REG_BCRM_HEARTBEAT_RW, &hbeat, &ret);
> > 	if (ret)
> > 		return ret;
> > 
> > 	return hbeat;
> > }
> > 
> > What do you think? Let me know.
> > (Maybe is this that you are trying to explain me but I haven't catch,
> > sorry) :)
> 
> Yes. The above code looks good to me.

I'm going to send v15 then.
Thanks.

Regards,
Tommaso

> 
> > 
> > 
> > > 
> > > > +
> > > > +	dev_info(dev, "bcrm version: %u.%u\n", v->minor, v->major);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int alvium_get_fw_version(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	struct alvium_fw_vers *fw_v;
> > > > +	u64 val;
> > > > +	int ret;
> > > > +
> > > > +	ret = alvium_read(alvium, REG_BCRM_DEVICE_FIRMWARE_VERSION_R, &val, NULL);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	fw_v = (struct alvium_fw_vers *)&val;
> > > 
> > > Same here.
> > > 
> > > > +
> > > > +	dev_info(dev, "fw version: %u.%u.%u.%u\n", fw_v->special, fw_v->major,
> > > > +		 fw_v->minor, fw_v->patch);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int alvium_get_bcrm_addr(struct alvium_dev *alvium)
> > > > +{
> > > > +	u64 val;
> > > > +	int ret;
> > > > +
> > > > +	ret = alvium_read(alvium, REG_BCRM_REG_ADDR_R, &val, NULL);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	alvium->bcrm_addr = val;
> > > > +
> > > > +	return 0;
> > > > +}
> > > 
> > > ...
> > > 
> > > > +static int alvium_setup_mipi_fmt(struct alvium_dev *alvium)
> > > > +{
> > > > +	unsigned int avail_fmt_cnt = 0;
> > > > +	unsigned int fmt = 0;
> > > > +	size_t sz = 0;
> > > > +
> > > > +	alvium->alvium_csi2_fmt = NULL;
> > > 
> > > This seems to be unnnecessary: the field is assigned below without using it
> > > (obviously).
> > 
> > Ok, I will remove this in v15.
> > 
> > > 
> > > > +
> > > > +	/* calculate fmt array size */
> > > > +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> > > > +		if (!alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit])
> > > > +			continue;
> > > > +
> > > > +		if ((!alvium_csi2_fmts[fmt].is_raw) ||
> > > > +		    (alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]))
> > > > +			sz++;
> > > > +	}
> > > > +
> > > > +	/* init alvium_csi2_fmt array */
> > > > +	alvium->alvium_csi2_fmt_n = sz;
> > > > +	alvium->alvium_csi2_fmt =
> > > > +		kmalloc_array(sz, sizeof(struct alvium_pixfmt), GFP_KERNEL);
> > > > +	if (!alvium->alvium_csi2_fmt)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	/* Create the alvium_csi2 fmt array from formats available */
> > > > +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> > > > +		if (!alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit])
> > > > +			continue;
> > > > +
> > > > +		if ((!alvium_csi2_fmts[fmt].is_raw) ||
> > > > +		    (alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit])) {
> > > > +			alvium->alvium_csi2_fmt[avail_fmt_cnt] = alvium_csi2_fmts[fmt];
> > > > +			avail_fmt_cnt++;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > 
> > > ...
> > > 
> > > > +static const struct alvium_pixfmt *
> > > > +alvium_code_to_pixfmt(struct alvium_dev *alvium, u32 code)
> > > > +{
> > > > +	const struct alvium_pixfmt *formats = alvium->alvium_csi2_fmt;
> > > 
> > > I'd use alvium->alvium_csi2_fmt and not add a local variable. Up to you.
> > 
> > Ok also for me.
> > 
> > > 
> > > > +	unsigned int i;
> > > > +
> > > > +	for (i = 0; formats[i].code; ++i)
> > > > +		if (formats[i].code == code)
> > > > +			return &formats[i];
> > > > +
> > > > +	return &formats[0];
> > > > +}
> > > > +
> > > > +static int alvium_set_mode(struct alvium_dev *alvium,
> > > > +			   struct v4l2_subdev_state *state)
> > > > +{
> > > > +	struct v4l2_mbus_framefmt *fmt;
> > > > +	struct v4l2_rect *crop;
> > > > +	int ret;
> > > > +
> > > > +	crop = v4l2_subdev_state_get_crop(state, 0);
> > > > +	fmt = v4l2_subdev_state_get_format(state, 0);
> > > > +
> > > > +	v4l_bound_align_image(&fmt->width, alvium->img_min_width,
> > > > +			      alvium->img_max_width, 0,
> > > > +			      &fmt->height, alvium->img_min_height,
> > > > +			      alvium->img_max_height, 0, 0);
> > > > +
> > > > +	/* alvium don't accept negative crop left/top */
> > > > +	crop->left = clamp((u32)max(0, crop->left), alvium->min_offx,
> > > > +			   (u32)(alvium->img_max_width - fmt->width));
> > > > +	crop->top = clamp((u32)max(0, crop->top), alvium->min_offy,
> > > > +			  (u32)(alvium->img_max_height - fmt->height));
> > > > +
> > > > +	ret = alvium_set_img_width(alvium, fmt->width);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = alvium_set_img_height(alvium, fmt->height);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = alvium_set_img_offx(alvium, crop->left);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = alvium_set_img_offy(alvium, crop->top);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	return 0;
> > > > +}
> > 
> > I'm going to rebase v15 on top of your master branch.
> > My plan is moving alvium_init_cfg now alvium_init_state into
> > v4l2_subdev_internal_ops.
> 
> Ack, thanks!
> 
> -- 
> Regards,
> 
> Sakari Ailus
