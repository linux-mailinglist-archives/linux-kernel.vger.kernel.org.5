Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A376C220
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjHBBWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjHBBWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:22:36 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088731FD6;
        Tue,  1 Aug 2023 18:22:31 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A7D907FD3;
        Wed,  2 Aug 2023 09:22:28 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Aug
 2023 09:22:28 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Aug
 2023 09:22:28 +0800
Message-ID: <fed8f81b-b07d-2f38-54ce-0e6dcaf8c300@starfivetech.com>
Date:   Wed, 2 Aug 2023 09:22:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 3/6] media: starfive: camss: Add basic driver
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-4-jack.zhu@starfivetech.com>
 <20230727113315.GH25174@pendragon.ideasonboard.com>
 <e8a1b30a-af1b-692b-f5e6-5fe4ba13da93@starfivetech.com>
 <20230801184552.GA30382@pendragon.ideasonboard.com>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230801184552.GA30382@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/2 2:45, Laurent Pinchart wrote:
> Hi Jack,
> 
> On Tue, Aug 01, 2023 at 11:24:22AM +0800, Jack Zhu wrote:
>> On 2023/7/27 19:33, Laurent Pinchart wrote:
>> > On Mon, Jun 19, 2023 at 07:28:35PM +0800, Jack Zhu wrote:
>> >> Add basic platform driver for StarFive Camera Subsystem.
>> >> 
>> >> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> >> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> >> ---
>> >>  MAINTAINERS                                   |   1 +
>> >>  drivers/media/platform/Kconfig                |   1 +
>> >>  drivers/media/platform/Makefile               |   1 +
>> >>  drivers/media/platform/starfive/Kconfig       |   5 +
>> >>  drivers/media/platform/starfive/Makefile      |   2 +
>> >>  drivers/media/platform/starfive/camss/Kconfig |  16 +
>> >>  .../media/platform/starfive/camss/Makefile    |   8 +
>> >>  .../media/platform/starfive/camss/stf_camss.c | 338 ++++++++++++++++++
>> >>  .../media/platform/starfive/camss/stf_camss.h | 146 ++++++++
>> >>  9 files changed, 518 insertions(+)
>> >>  create mode 100644 drivers/media/platform/starfive/Kconfig
>> >>  create mode 100644 drivers/media/platform/starfive/Makefile
>> >>  create mode 100644 drivers/media/platform/starfive/camss/Kconfig
>> >>  create mode 100644 drivers/media/platform/starfive/camss/Makefile
>> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_camss.c
>> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_camss.h
> 
> [snip]
> 
>> >> diff --git a/drivers/media/platform/starfive/camss/Kconfig b/drivers/media/platform/starfive/camss/Kconfig
>> >> new file mode 100644
>> >> index 000000000000..dafe1d24324b
>> >> --- /dev/null
>> >> +++ b/drivers/media/platform/starfive/camss/Kconfig
>> >> @@ -0,0 +1,16 @@
>> >> +# SPDX-License-Identifier: GPL-2.0-only
>> >> +config VIDEO_STARFIVE_CAMSS
>> >> +	tristate "Starfive Camera Subsystem driver"
>> >> +	depends on V4L_PLATFORM_DRIVERS
>> >> +	depends on VIDEO_DEV && OF
>> >> +	depends on HAS_DMA
>> > 
>> > You need to depend on PM, otherwise the runtime PM operations will be
>> > no-ops and the driver won't work as clocks won't be enabled.
>> 
>> OK, I will add dependency.
> 
> By the way, if it makes it easier for you, you don't need to acknowledge
> every single review comment. You can reply to comments you disagree
> with, or comments that you find unclear. Anything that you agree with
> and will address in the next version can be left unanswered in your
> e-mail replies. It's entirely up to you.
> 

Hi Laurent,

Your suggestion is very useful for me. Thanks!

>> >> +	select MEDIA_CONTROLLER
>> >> +	select VIDEO_V4L2_SUBDEV_API
>> >> +	select VIDEOBUF2_DMA_CONTIG
>> >> +	select V4L2_FWNODE
>> >> +	help
>> >> +	   Enable this to support for the Starfive Camera subsystem
>> >> +	   found on Starfive JH7110 SoC.
>> >> +
>> >> +	   To compile this driver as a module, choose M here: the
>> >> +	   module will be called stf-camss.
> 
> [snip]
> 
>> >> diff --git a/drivers/media/platform/starfive/camss/stf_camss.c b/drivers/media/platform/starfive/camss/stf_camss.c
>> >> new file mode 100644
>> >> index 000000000000..dc2b5dba7bd4
>> >> --- /dev/null
>> >> +++ b/drivers/media/platform/starfive/camss/stf_camss.c
>> >> @@ -0,0 +1,338 @@
> 
> [snip]
> 
>> >> +/*
>> >> + * stfcamss_probe - Probe STFCAMSS platform device
>> >> + * @pdev: Pointer to STFCAMSS platform device
>> >> + *
>> >> + * Return 0 on success or a negative error code on failure
>> >> + */
>> >> +static int stfcamss_probe(struct platform_device *pdev)
>> >> +{
>> >> +	struct stfcamss *stfcamss;
>> >> +	struct device *dev = &pdev->dev;
>> >> +	int ret, num_subdevs;
>> >> +	unsigned int i;
>> >> +
>> >> +	stfcamss = devm_kzalloc(dev, sizeof(*stfcamss), GFP_KERNEL);
>> >> +	if (!stfcamss)
>> >> +		return -ENOMEM;
>> >> +
>> >> +	for (i = 0; i < ARRAY_SIZE(stfcamss->irq); ++i) {
>> >> +		stfcamss->irq[i] = platform_get_irq(pdev, i);
>> >> +		if (stfcamss->irq[i] < 0)
>> >> +			return dev_err_probe(&pdev->dev, stfcamss->irq[i],
>> >> +					     "Failed to get irq%d", i);
>> >> +	}
>> >> +
>> >> +	stfcamss->nclks = ARRAY_SIZE(stfcamss->sys_clk);
>> >> +	for (i = 0; i < stfcamss->nclks; ++i)
>> >> +		stfcamss->sys_clk[i].id = stfcamss_clocks[i];
>> >> +	ret = devm_clk_bulk_get(dev, stfcamss->nclks, stfcamss->sys_clk);
>> >> +	if (ret) {
>> >> +		dev_err(dev, "Failed to get clk controls\n");
>> >> +		return ret;
>> >> +	}
>> >> +
>> >> +	stfcamss->nrsts = ARRAY_SIZE(stfcamss->sys_rst);
>> >> +	for (i = 0; i < stfcamss->nrsts; ++i)
>> >> +		stfcamss->sys_rst[i].id = stfcamss_resets[i];
>> >> +	ret = devm_reset_control_bulk_get_shared(dev, stfcamss->nrsts,
>> >> +						 stfcamss->sys_rst);
>> >> +	if (ret) {
>> >> +		dev_err(dev, "Failed to get reset controls\n");
>> >> +		return ret;
>> >> +	}
>> >> +
>> >> +	ret = stfcamss_get_mem_res(pdev, stfcamss);
>> >> +	if (ret) {
>> >> +		dev_err(dev, "Could not map registers\n");
>> >> +		return ret;
>> >> +	}
>> >> +
>> >> +	stfcamss->dev = dev;
>> > 
>> > Move this right after allocating stfcamss, and drop the pdev argument to
>> > stfcamss_get_mem_res(). The platform device can be retrieved in the
>> > function using to_platform_device().
>> 
>> OK, I will modify.
>> 
>> >> +	platform_set_drvdata(pdev, stfcamss);
>> >> +
>> >> +	v4l2_async_nf_init(&stfcamss->notifier);
>> >> +
>> >> +	num_subdevs = stfcamss_of_parse_ports(stfcamss);
>> >> +	if (num_subdevs < 0) {
>> >> +		ret = -ENODEV;
>> > 
>> > An error message would be useful, silent errors are hard to debug.
>> 
>> OK, will add error printing information.
>> 
>> >> +		goto err_cleanup_notifier;
>> >> +	}
>> >> +
>> >> +	stfcamss_mc_init(pdev, stfcamss);
>> >> +
>> >> +	ret = v4l2_device_register(stfcamss->dev, &stfcamss->v4l2_dev);
>> >> +	if (ret < 0) {
>> >> +		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
>> >> +		goto err_cleanup_notifier;
>> >> +	}
>> >> +
>> >> +	ret = media_device_register(&stfcamss->media_dev);
>> >> +	if (ret) {
>> >> +		dev_err(dev, "Failed to register media device: %d\n", ret);
>> >> +		goto err_unregister_device;
>> >> +	}
>> >> +
>> >> +	pm_runtime_enable(dev);
>> > 
>> > Would it be useful to enable autosuspend too, to avoid expensive
>> > suspend/resume cycles when userspace wants to briefly stop capture and
>> > restart it immediately ?
>> 
>> It seems rare to use autosuspend in the Linux camera system.
> 
> It's a relatively recent practice, and is more common in sensor drivers
> than ISP drivers, but I think it's a good practice nonetheless. It makes
> stop-reconfigure-start cycles much faster.
> 

Yes, I agree with you, but the existing applications on our platform are
relatively simple, and I want to keep this usage for now.

>> >> +
>> >> +	stfcamss->notifier.ops = &stfcamss_subdev_notifier_ops;
>> >> +	ret = v4l2_async_nf_register(&stfcamss->v4l2_dev, &stfcamss->notifier);
>> >> +	if (ret) {
>> >> +		dev_err(dev, "Failed to register async subdev nodes: %d\n",
>> >> +			ret);
>> >> +		goto err_unregister_media_dev;
>> > 
>> > You need to disable runtime PM in this error path.
>> 
>> OK, will fix it.
>> 
>> >> +	}
>> >> +
>> >> +	return 0;
>> >> +
>> >> +err_unregister_media_dev:
>> >> +	media_device_unregister(&stfcamss->media_dev);
>> >> +err_unregister_device:
>> >> +	v4l2_device_unregister(&stfcamss->v4l2_dev);
>> >> +err_cleanup_notifier:
>> >> +	v4l2_async_nf_cleanup(&stfcamss->notifier);
>> >> +	return ret;
>> >> +}
> 
> [snip]
> 
