Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA3E76BCDC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjHASqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjHASqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:46:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE852698;
        Tue,  1 Aug 2023 11:45:48 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 349848D;
        Tue,  1 Aug 2023 20:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690915483;
        bh=X6Z9dROheZMRqOSaTMkT68TI3brpeZO9mR1sRPIFCcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=csdQq+JqFul5p6+JKxqlsE2xXtJMwZ5nYMTh2rXGYbDMnRoLCst7BJ/uhuyFI5JAq
         I4+44LLzopkKOYbyiOsNf5KUNq4fxkTTLl2ltvT0ra4p+bbeMpxdO/5kI+84LBYCAt
         CEPy6oo3rL2uHPAj7x3m0wDkqZW4JYpk+3Q3l8Kg=
Date:   Tue, 1 Aug 2023 21:45:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v7 3/6] media: starfive: camss: Add basic driver
Message-ID: <20230801184552.GA30382@pendragon.ideasonboard.com>
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-4-jack.zhu@starfivetech.com>
 <20230727113315.GH25174@pendragon.ideasonboard.com>
 <e8a1b30a-af1b-692b-f5e6-5fe4ba13da93@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e8a1b30a-af1b-692b-f5e6-5fe4ba13da93@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

On Tue, Aug 01, 2023 at 11:24:22AM +0800, Jack Zhu wrote:
> On 2023/7/27 19:33, Laurent Pinchart wrote:
> > On Mon, Jun 19, 2023 at 07:28:35PM +0800, Jack Zhu wrote:
> >> Add basic platform driver for StarFive Camera Subsystem.
> >> 
> >> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> >> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> >> ---
> >>  MAINTAINERS                                   |   1 +
> >>  drivers/media/platform/Kconfig                |   1 +
> >>  drivers/media/platform/Makefile               |   1 +
> >>  drivers/media/platform/starfive/Kconfig       |   5 +
> >>  drivers/media/platform/starfive/Makefile      |   2 +
> >>  drivers/media/platform/starfive/camss/Kconfig |  16 +
> >>  .../media/platform/starfive/camss/Makefile    |   8 +
> >>  .../media/platform/starfive/camss/stf_camss.c | 338 ++++++++++++++++++
> >>  .../media/platform/starfive/camss/stf_camss.h | 146 ++++++++
> >>  9 files changed, 518 insertions(+)
> >>  create mode 100644 drivers/media/platform/starfive/Kconfig
> >>  create mode 100644 drivers/media/platform/starfive/Makefile
> >>  create mode 100644 drivers/media/platform/starfive/camss/Kconfig
> >>  create mode 100644 drivers/media/platform/starfive/camss/Makefile
> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_camss.c
> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_camss.h

[snip]

> >> diff --git a/drivers/media/platform/starfive/camss/Kconfig b/drivers/media/platform/starfive/camss/Kconfig
> >> new file mode 100644
> >> index 000000000000..dafe1d24324b
> >> --- /dev/null
> >> +++ b/drivers/media/platform/starfive/camss/Kconfig
> >> @@ -0,0 +1,16 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only
> >> +config VIDEO_STARFIVE_CAMSS
> >> +	tristate "Starfive Camera Subsystem driver"
> >> +	depends on V4L_PLATFORM_DRIVERS
> >> +	depends on VIDEO_DEV && OF
> >> +	depends on HAS_DMA
> > 
> > You need to depend on PM, otherwise the runtime PM operations will be
> > no-ops and the driver won't work as clocks won't be enabled.
> 
> OK, I will add dependency.

By the way, if it makes it easier for you, you don't need to acknowledge
every single review comment. You can reply to comments you disagree
with, or comments that you find unclear. Anything that you agree with
and will address in the next version can be left unanswered in your
e-mail replies. It's entirely up to you.

> >> +	select MEDIA_CONTROLLER
> >> +	select VIDEO_V4L2_SUBDEV_API
> >> +	select VIDEOBUF2_DMA_CONTIG
> >> +	select V4L2_FWNODE
> >> +	help
> >> +	   Enable this to support for the Starfive Camera subsystem
> >> +	   found on Starfive JH7110 SoC.
> >> +
> >> +	   To compile this driver as a module, choose M here: the
> >> +	   module will be called stf-camss.

[snip]

> >> diff --git a/drivers/media/platform/starfive/camss/stf_camss.c b/drivers/media/platform/starfive/camss/stf_camss.c
> >> new file mode 100644
> >> index 000000000000..dc2b5dba7bd4
> >> --- /dev/null
> >> +++ b/drivers/media/platform/starfive/camss/stf_camss.c
> >> @@ -0,0 +1,338 @@

[snip]

> >> +/*
> >> + * stfcamss_probe - Probe STFCAMSS platform device
> >> + * @pdev: Pointer to STFCAMSS platform device
> >> + *
> >> + * Return 0 on success or a negative error code on failure
> >> + */
> >> +static int stfcamss_probe(struct platform_device *pdev)
> >> +{
> >> +	struct stfcamss *stfcamss;
> >> +	struct device *dev = &pdev->dev;
> >> +	int ret, num_subdevs;
> >> +	unsigned int i;
> >> +
> >> +	stfcamss = devm_kzalloc(dev, sizeof(*stfcamss), GFP_KERNEL);
> >> +	if (!stfcamss)
> >> +		return -ENOMEM;
> >> +
> >> +	for (i = 0; i < ARRAY_SIZE(stfcamss->irq); ++i) {
> >> +		stfcamss->irq[i] = platform_get_irq(pdev, i);
> >> +		if (stfcamss->irq[i] < 0)
> >> +			return dev_err_probe(&pdev->dev, stfcamss->irq[i],
> >> +					     "Failed to get irq%d", i);
> >> +	}
> >> +
> >> +	stfcamss->nclks = ARRAY_SIZE(stfcamss->sys_clk);
> >> +	for (i = 0; i < stfcamss->nclks; ++i)
> >> +		stfcamss->sys_clk[i].id = stfcamss_clocks[i];
> >> +	ret = devm_clk_bulk_get(dev, stfcamss->nclks, stfcamss->sys_clk);
> >> +	if (ret) {
> >> +		dev_err(dev, "Failed to get clk controls\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	stfcamss->nrsts = ARRAY_SIZE(stfcamss->sys_rst);
> >> +	for (i = 0; i < stfcamss->nrsts; ++i)
> >> +		stfcamss->sys_rst[i].id = stfcamss_resets[i];
> >> +	ret = devm_reset_control_bulk_get_shared(dev, stfcamss->nrsts,
> >> +						 stfcamss->sys_rst);
> >> +	if (ret) {
> >> +		dev_err(dev, "Failed to get reset controls\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = stfcamss_get_mem_res(pdev, stfcamss);
> >> +	if (ret) {
> >> +		dev_err(dev, "Could not map registers\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	stfcamss->dev = dev;
> > 
> > Move this right after allocating stfcamss, and drop the pdev argument to
> > stfcamss_get_mem_res(). The platform device can be retrieved in the
> > function using to_platform_device().
> 
> OK, I will modify.
> 
> >> +	platform_set_drvdata(pdev, stfcamss);
> >> +
> >> +	v4l2_async_nf_init(&stfcamss->notifier);
> >> +
> >> +	num_subdevs = stfcamss_of_parse_ports(stfcamss);
> >> +	if (num_subdevs < 0) {
> >> +		ret = -ENODEV;
> > 
> > An error message would be useful, silent errors are hard to debug.
> 
> OK, will add error printing information.
> 
> >> +		goto err_cleanup_notifier;
> >> +	}
> >> +
> >> +	stfcamss_mc_init(pdev, stfcamss);
> >> +
> >> +	ret = v4l2_device_register(stfcamss->dev, &stfcamss->v4l2_dev);
> >> +	if (ret < 0) {
> >> +		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
> >> +		goto err_cleanup_notifier;
> >> +	}
> >> +
> >> +	ret = media_device_register(&stfcamss->media_dev);
> >> +	if (ret) {
> >> +		dev_err(dev, "Failed to register media device: %d\n", ret);
> >> +		goto err_unregister_device;
> >> +	}
> >> +
> >> +	pm_runtime_enable(dev);
> > 
> > Would it be useful to enable autosuspend too, to avoid expensive
> > suspend/resume cycles when userspace wants to briefly stop capture and
> > restart it immediately ?
> 
> It seems rare to use autosuspend in the Linux camera system.

It's a relatively recent practice, and is more common in sensor drivers
than ISP drivers, but I think it's a good practice nonetheless. It makes
stop-reconfigure-start cycles much faster.

> >> +
> >> +	stfcamss->notifier.ops = &stfcamss_subdev_notifier_ops;
> >> +	ret = v4l2_async_nf_register(&stfcamss->v4l2_dev, &stfcamss->notifier);
> >> +	if (ret) {
> >> +		dev_err(dev, "Failed to register async subdev nodes: %d\n",
> >> +			ret);
> >> +		goto err_unregister_media_dev;
> > 
> > You need to disable runtime PM in this error path.
> 
> OK, will fix it.
> 
> >> +	}
> >> +
> >> +	return 0;
> >> +
> >> +err_unregister_media_dev:
> >> +	media_device_unregister(&stfcamss->media_dev);
> >> +err_unregister_device:
> >> +	v4l2_device_unregister(&stfcamss->v4l2_dev);
> >> +err_cleanup_notifier:
> >> +	v4l2_async_nf_cleanup(&stfcamss->notifier);
> >> +	return ret;
> >> +}

[snip]

-- 
Regards,

Laurent Pinchart
