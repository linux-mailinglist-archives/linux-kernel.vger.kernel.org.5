Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518287DC7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjJaINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjJaINi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:13:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE426BD;
        Tue, 31 Oct 2023 01:13:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5409bc907edso8310452a12.0;
        Tue, 31 Oct 2023 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698740014; x=1699344814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUSjPd9JDelxayHLoaKrsl8RYjyIQSTE5q0zW+6XXnI=;
        b=fpm0K05iCPS618aAqxTo2tAwsd6N+Rpt3XXNaUMRGd/QX2HucBMQCDBHwjYPUsJykV
         9HVfe87q8FrkEa19839mzc0W1sKLUXLPqJ6aB/JRV30p7TXjtTAeeFmMfDlNNSdo5iiF
         4m2Zw3gLbvjrr8M6nKlbQFrq3uiiV/DQoXqv+Qw23QNu/n3mY/hVQiARUtz0E6KcGjGs
         Z/Sj7wt9OJuCiGKxa2vqZQeHdybAIeiV9VJ4cxjUcEsX3g1pdF1PxBsG6v24xk209jiy
         tiVVDkosfjPEQ7R7PIhLprKry4Z99Zp3t0Rr3p7Of960zHXVKmRWVaO0LdOMBIdwe3md
         PE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698740014; x=1699344814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUSjPd9JDelxayHLoaKrsl8RYjyIQSTE5q0zW+6XXnI=;
        b=evCIg858RMvvlaQzCtWEH7aW33OY4JtgIPlCOkTHWRECqTTeuuAt7Ui3VT4Kevnh6C
         UubMZz3amtlznEVROJGnGrlrx81HpKdWC7jif9eR3mOdDKidphyKzA2pSGCf50UEJ5E9
         rD8XPqaoltLeeC6ulmLDyYDGwHrdmUflS1nkNUadLN9ec5MuCSs/ew2+PUO8/qsuUbo5
         QL1bSYSB//VrxFN8MUkkV2NFZSK5+5DlJR+3DJCSxEwk8on3etxccxnpDg1GiLbz+9Bt
         0wgctsfKLJ4mNgbirRiec8YVZqx0nXxI8+IxvPn7AFxs/rC5ePgGXPL2MJtyc/4LAGOP
         xndA==
X-Gm-Message-State: AOJu0YzO4323ncSyd/ptwaQNQIBKFVCyYgxkNRNTdnppnZztFr0487qO
        0UJddxyXX5qBGQVYJKWnxnI=
X-Google-Smtp-Source: AGHT+IGXHNJ1xJ5AaZ5QeGdx4lK2BcHbEIPBRlWpzvgcS2lWFzAVpJjfoNIFh/XffpFG5sKxWRF32g==
X-Received: by 2002:a17:907:7f92:b0:9bd:f155:eb54 with SMTP id qk18-20020a1709077f9200b009bdf155eb54mr11872826ejc.6.1698740014038;
        Tue, 31 Oct 2023 01:13:34 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-109.cust.vodafonedsl.it. [188.217.59.109])
        by smtp.gmail.com with ESMTPSA id rp16-20020a170906d97000b009ae57888718sm530859ejb.207.2023.10.31.01.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 01:13:33 -0700 (PDT)
Date:   Tue, 31 Oct 2023 09:13:30 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     martin.hecht@avnet.eu, michael.roeder@avnet.eu, mhecht73@gmail.com,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v10 3/3] media: i2c: Add support for alvium camera
Message-ID: <ZUC3KpmB6ZzLkxDw@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231020141354.2500602-1-tomm.merciai@gmail.com>
 <20231020141354.2500602-4-tomm.merciai@gmail.com>
 <ZTpnHdpTgRNll3TC@kekkonen.localdomain>
 <ZT+hEg7WqkQBnLV5@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <ZUAxoy2cRR6Rm9ig@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUAxoy2cRR6Rm9ig@kekkonen.localdomain>
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
Thanks for your comments.

On Mon, Oct 30, 2023 at 10:43:47PM +0000, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Mon, Oct 30, 2023 at 01:26:58PM +0100, Tommaso Merciai wrote:
> 
> ...
> 
> > > > +static int alvium_get_host_supp_csi_lanes(struct alvium_dev *alvium)
> > > > +{
> > > > +	u64 val;
> > > > +	int ret = 0;
> > > > +
> > > > +	alvium_read(alvium, REG_BCRM_CSI2_LANE_COUNT_RW, &val, &ret);
> > > 
> > > Missing error checking before the use of the value. The same pattern
> > > remains prevalent throughout the driver.
> > > 
> > > I think it'd be easier if you didn't use a temporary variable for reading,
> > > but instead had a register width specific access function. You could even
> > > introduce a helper macro to read this information as I suggested in an
> > > earlier review.
> > 
> > oks.
> > We are moving to use the following macros:
> > 
> > #define alvium_read_check(alvium, reg, value) \
> > { \
> > 	int ret = alvium_read(alvium, reg, value, NULL); \
> > 	if (ret) \
> > 		return ret; \
> > }
> > 
> 
> You could do something like (entirely untested):
> 
> #define ALVIUM_DECLARE_READ(sign, bits) \
> 	static int
> 	alvium_read_ ## sign ## bits(struct alvium_dev *alvium, u32 reg, \
> 				     sign ## bits *val, int *err) \
> 	{ \
> 		u64 val64; \
> 		int ret; \
> 			\
> 		if (err && *err < 0) \
> 			return *err; \
> 			\
> 		alvium_read(alvium, reg, &val64, &ret); \
> 		if (ret < 0) { \
> 			if (err) \
> 				*err = ret; \
> 			return ret; \
> 		}	\
> 			\
> 		*val = val64; \
> 			\
> 		return 0; \
> 	}
> 
> ALVIUM_DECLARE_READ(u, 32);
> 
> And then, e.g. instead of (and failing to check ret):
> 
> 	u64 val;
> 
> 	alvium_read(alvium, REG_BCRM_CONTRAST_VALUE_RW, &val, &ret);
> 	alvium->dft_contrast = val;
> 
> you'd have a single call:
> 
> 	alvium_read_u32(alvium, REG_BCRM_CONTRAST_VALUE_RW,
> 		        &alvium->dft_contrast, &ret);
> 
> And so on.
> 
> You can drop sign if you don't need signed reads but some of the struct
> fields you're writing something appear to be signed.
> 
> It'd be good to check the register size matches with the size of *val, too.
> Maybe something like:
> 
> WARN_ON((CCI_REG ## bits(0) && CCI_REG_WIDTH_MASK) >> CCI_REG_WIDTH_SHIFT
> 	!= sizeof(sign ## bits));

Laurent suggest me also a good way.
I switched to the Laurent suggested implementation in v11.
I think now is clear. Thanks to both again.
Let me know what do you think about :)

> 
> > > > +static int alvium_get_csi_clk_params(struct alvium_dev *alvium)
> > > > +{
> > > > +	u64 val;
> > > > +	int ret = 0;
> > > > +
> > > > +	alvium_read(alvium, REG_BCRM_CSI2_CLOCK_MIN_R, &val, &ret);
> > > > +	alvium->min_csi_clk = val;
> > > > +
> > > > +	alvium_read(alvium, REG_BCRM_CSI2_CLOCK_MAX_R, &val, &ret);
> > > > +	alvium->max_csi_clk = val;
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int alvium_set_csi_clk(struct alvium_dev *alvium)
> > > > +{
> > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > +	u64 csi_clk;
> > > > +	int ret;
> > > > +
> > > > +	csi_clk = (u32)alvium->ep.link_frequencies[0];
> > > 
> > > Why casting to u32? Shouldn't csi_clk be u32 instead?
> > 
> > Ok we fix this in v11.
> > Change to use u64 for calculation because type of ep.link_frequencies[0]
> > Plan is to clamp csi_clk between min/max instead of returning error.
> 
> I think I would keep it as-is: this isn't V4L2 UAPI.
> 
> > 
> > > 
> > > > +
> > > > +	if (csi_clk < alvium->min_csi_clk || csi_clk > alvium->max_csi_clk)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ret = alvium_write_hshake(alvium, REG_BCRM_CSI2_CLOCK_RW, csi_clk);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Fail to set csi lanes reg\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	alvium->link_freq = alvium->ep.link_frequencies[0];
> > > > +
> > > > +	return 0;
> > > > +}
> 
> ...
> 
> > > > +			goto out;
> > > > +
> > > > +		ret = alvium_set_mode(alvium, state);
> > > > +		if (ret)
> > > > +			goto out;
> > > > +
> > > > +		fmt = v4l2_subdev_get_pad_format(sd, state, 0);
> > > > +		ret = alvium_set_framefmt(alvium, fmt);
> > > > +		if (ret)
> > > > +			goto out;
> > > > +
> > > > +		ret = alvium_set_stream_mipi(alvium, enable);
> > > > +		if (ret)
> > > > +			goto out;
> > > > +
> > > > +	} else {
> > > > +		alvium_set_stream_mipi(alvium, enable);
> > > > +		pm_runtime_mark_last_busy(&client->dev);
> > > > +		pm_runtime_put_autosuspend(&client->dev);
> > > 
> > > pm_runtime_put() here, too.
> > 
> > Here is not needed we already have pm_runtime_put_autosuspend.
> > I'm missing something?
> 
> Ah, I missed that while reviewing. Please ignore that comment then.

No problem, update in v11.

> 
> > 
> > > 
> > > > +	}
> > > > +
> > > > +	alvium->streaming = !!enable;
> > > > +	v4l2_subdev_unlock_state(state);
> > > > +
> > > > +	return 0;
> > > > +
> > > > +out:
> > > > +	v4l2_subdev_unlock_state(state);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int alvium_init_cfg(struct v4l2_subdev *sd,
> > > > +			   struct v4l2_subdev_state *state)
> > > > +{
> > > > +	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > +	struct alvium_mode *mode = &alvium->mode;
> > > 
> > > Init_cfg() is expected to be configuration independent (as much as
> > > possible). Therefore you should use defaults here, not current mode.
> > 
> > Defaults alvium mode already used here.
> 
> Ah, indeed. Please ignore.

No problem.

Thanks & Regards,
Tommaso

> 
> -- 
> Kind regards,
> 
> Sakari Ailus
