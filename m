Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86317DE1FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbjKAONc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjKAONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:13:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E4883;
        Wed,  1 Nov 2023 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698848006; x=1730384006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wGBu3/j706WJmrxU7xAqNyUmg5FN/DVlyjcIaMJULUM=;
  b=EGs4eVu7assSGMJlYEqaQqF37wpyzXuKQpBhLyNCDNRxNrHVv06xwLpF
   K98U3MiJocvbWf6w54ywwrLYyboh7ORhh7ASv9pkGw2GCR3BtBsxT6blS
   Hc7FUK2SYkOyh/o3JQJq7j4irz1RUImyKV5l7gdqmyS9iP/9dn9QrDcMk
   Rg3KZW8AGWwI4V1zuNz8S7QQ2GgpZ9XG1CVv0XjoIr1DOWHMuU3wd72qp
   k/7+Oe+Z94mWHpDovygo+apsrwJI5xZFTDGpbc6vHfHZRmkc1Kf+7iKbp
   gSsQmsyzAQYq5UiOkWOUx5CxRztFZWwkrxp5i3p7DSw5QLu7j+n4+3hMX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="7122329"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="7122329"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 07:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="826783310"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="826783310"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 07:13:17 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 405DB1207A3;
        Wed,  1 Nov 2023 16:13:14 +0200 (EET)
Date:   Wed, 1 Nov 2023 14:13:14 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu, mhecht73@gmail.com,
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
        linux-kernel@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [PATCH v10 3/3] media: i2c: Add support for alvium camera
Message-ID: <ZUJc-p_i4JjqkM9i@kekkonen.localdomain>
References: <20231020141354.2500602-1-tomm.merciai@gmail.com>
 <20231020141354.2500602-4-tomm.merciai@gmail.com>
 <a98bca80-944c-493b-9872-75b94cd24eea@wanadoo.fr>
 <ZUDpAR3ZyBVrUyat@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUDpAR3ZyBVrUyat@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Tue, Oct 31, 2023 at 12:46:09PM +0100, Tommaso Merciai wrote:
> > > +static int alvium_get_dt_data(struct alvium_dev *alvium)
> > > +{
> > > +	struct device *dev = &alvium->i2c_client->dev;
> > > +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > +	struct fwnode_handle *endpoint;
> > > +	int ret = -EINVAL;
> > > +
> > > +	if (!fwnode)
> > > +		return -EINVAL;
> > > +
> > > +	/* Only CSI2 is supported for now: */
> > > +	alvium->ep.bus_type = V4L2_MBUS_CSI2_DPHY;
> > > +
> > > +	endpoint = fwnode_graph_get_endpoint_by_id(fwnode, 0, 0, 0);
> > > +	if (!endpoint) {
> > > +		dev_err(dev, "endpoint node not found\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (v4l2_fwnode_endpoint_alloc_parse(endpoint, &alvium->ep)) {
> > > +		dev_err(dev, "could not parse endpoint\n");
> > > +		goto error_out;
> > 
> > This could go to another label to be less confusing, but
> > v4l2_fwnode_endpoint_free() looks to be a no-op here, so good enough.
> 
> Thanks for the comment.
> To be honest right now this is clear to me
> I prefere to stay on the following :)
> Prefer to keep just only one path.

You can safely call v4l2_fwnode_endpoint_free() on an unparsed endpoint (or
on and endpoint the parsing of which failed). I prefer this too.

> > > +		ret = -ENODEV;
> > > +		goto err_powerdown;
> > > +	}
> > > +
> > > +	ret = alvium_get_hw_info(alvium);
> > > +	if (ret) {
> > > +		dev_err(dev, "get_hw_info fail %d\n", ret);
> > > +		goto err_powerdown;
> > > +	}
> > > +
> > > +	ret = alvium_hw_init(alvium);
> > > +	if (ret) {
> > > +		dev_err(dev, "hw_init fail %d\n", ret);
> > > +		goto err_powerdown;
> > > +	}
> > > +
> > > +	ret = alvium_setup_mipi_fmt(alvium);
> > > +	if (ret) {
> > > +		dev_err(dev, "setup_mipi_fmt fail %d\n", ret);
> > > +		goto err_powerdown;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Enable runtime PM without autosuspend:
> > > +	 *
> > > +	 * Don't use pm autosuspend (alvium have ~7s boot time).
> > > +	 * Alvium has been powered manually:
> > > +	 *  - mark it as active
> > > +	 *  - increase the usage count without resuming the device.
> > > +	 */
> > > +	pm_runtime_set_active(dev);
> > > +	pm_runtime_get_noresume(dev);
> > > +	pm_runtime_enable(dev);
> > > +
> > > +	/* Initialize the V4L2 subdev. */
> > > +	ret = alvium_subdev_init(alvium);
> > > +	if (ret)
> > > +		goto err_pm;
> > > +
> > > +	ret = v4l2_async_register_subdev(&alvium->sd);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "Could not register v4l2 device\n");
> > > +		goto err_subdev;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +err_subdev:
> > > +	alvium_subdev_cleanup(alvium);
> > 
> > Should this also be called by the remove function?
> > Or is it already handled by an un-register mechanism?
> 
> Right, I miss this.
> Thanks.
> I put this to remove function like:
> 
> static void alvium_remove(struct i2c_client *client)
> {
> 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> 	struct alvium_dev *alvium = sd_to_alvium(sd);
> 	struct device *dev = &alvium->i2c_client->dev;
> 
> 	/*
> 	 * Disable runtime PM. In case runtime PM is disabled in the kernel,
> 	 * make sure to turn power off manually.
> 	 */
> 	pm_runtime_disable(dev);
> 	if (!pm_runtime_status_suspended(dev))
> 		alvium_power_on(alvium, false);
> 	pm_runtime_set_suspended(dev);
> 
> 	alvium_subdev_cleanup(alvium);
> 	i2c_unregister_device(alvium->i2c_client);

This doesn't belong here (as you didn't register it). It was missed in the
review earlier.

> }
> 
> 
> If for you Cristophe, Sakari, Laurent,
> it's ok I prefer to skip v11 that I sent this morning too early.
> I collected hints from Cristophe right now and I plan to send v12
> this afternoon/evening if for you all is ok.
> 
> https://github.com/avs-sas/linux/blob/tm/media_stage/v6.6.0-rc3/alvium_drv/v12/drivers/media/i2c/alvium-csi2.c
> 
> Please let me know.
> 
> Thanks again to all! :)

-- 
Regards,

Sakari Ailus
