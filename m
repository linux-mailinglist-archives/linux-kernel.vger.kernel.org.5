Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A9D76DE62
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjHCClX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjHCClT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:41:19 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009DFE0;
        Wed,  2 Aug 2023 19:41:11 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8ABAF7FDC;
        Thu,  3 Aug 2023 10:41:09 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 3 Aug
 2023 10:41:09 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 3 Aug
 2023 10:41:08 +0800
Message-ID: <45879269-e72b-b13a-00bc-2d10e9f90c2c@starfivetech.com>
Date:   Thu, 3 Aug 2023 10:41:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 5/6] media: starfive: camss: Add ISP driver
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
 <20230619112838.19797-6-jack.zhu@starfivetech.com>
 <20230727204103.GJ25174@pendragon.ideasonboard.com>
 <2504080f-86af-161f-5c0d-284e89e33ce1@starfivetech.com>
 <20230802104840.GC5269@pendragon.ideasonboard.com>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <20230802104840.GC5269@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 2023/8/2 18:48, Laurent Pinchart wrote:
> Hi Jack,
> 
> On Wed, Aug 02, 2023 at 05:57:57PM +0800, Jack Zhu wrote:
>> On 2023/7/28 4:41, Laurent Pinchart wrote:
>> > On Mon, Jun 19, 2023 at 07:28:37PM +0800, Jack Zhu wrote:
>> >> Add ISP driver for StarFive Camera Subsystem.
>> >> 
>> >> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> >> ---
>> >>  .../media/platform/starfive/camss/Makefile    |   2 +
>> >>  .../media/platform/starfive/camss/stf_camss.c |  76 ++-
>> >>  .../media/platform/starfive/camss/stf_camss.h |   3 +
>> >>  .../media/platform/starfive/camss/stf_isp.c   | 519 ++++++++++++++++++
>> >>  .../media/platform/starfive/camss/stf_isp.h   | 479 ++++++++++++++++
>> >>  .../platform/starfive/camss/stf_isp_hw_ops.c  | 468 ++++++++++++++++
>> >>  6 files changed, 1544 insertions(+), 3 deletions(-)
>> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_isp.c
>> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_isp.h
>> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_isp_hw_ops.c
> 
> [snip]
> 
>> >> diff --git a/drivers/media/platform/starfive/camss/stf_isp.c b/drivers/media/platform/starfive/camss/stf_isp.c
>> >> new file mode 100644
>> >> index 000000000000..933a583b398c
>> >> --- /dev/null
>> >> +++ b/drivers/media/platform/starfive/camss/stf_isp.c
>> >> @@ -0,0 +1,519 @@
>> >> +// SPDX-License-Identifier: GPL-2.0
>> >> +/*
>> >> + * stf_isp.c
>> >> + *
>> >> + * StarFive Camera Subsystem - ISP Module
>> >> + *
>> >> + * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
>> >> + */
>> >> +#include <linux/firmware.h>
>> > 
>> > This doesn't seem needed.
>> > 
>> >> +#include <media/v4l2-event.h>
>> >> +
>> >> +#include "stf_camss.h"
>> >> +
>> >> +#define SINK_FORMATS_INDEX    0
>> >> +#define UO_FORMATS_INDEX      1
>> > 
>> > What does "UO" stand for ?
>> 
>> "UO" is Usual Out, just represents output. :-)
> 
> Maybe "out", "output" or "source" would make the code easier to read
> then ?
> 
>> >> +
>> >> +static int isp_set_selection(struct v4l2_subdev *sd,
>> >> +			     struct v4l2_subdev_state *state,
>> >> +			     struct v4l2_subdev_selection *sel);
>> >> +
>> >> +static const struct isp_format isp_formats_sink[] = {
>> >> +	{ MEDIA_BUS_FMT_SRGGB10_1X10, 10 },
>> >> +	{ MEDIA_BUS_FMT_SGRBG10_1X10, 10 },
>> >> +	{ MEDIA_BUS_FMT_SGBRG10_1X10, 10 },
>> >> +	{ MEDIA_BUS_FMT_SBGGR10_1X10, 10 },
>> >> +};
> 
> [snip]
> 
>> >> diff --git a/drivers/media/platform/starfive/camss/stf_isp.h b/drivers/media/platform/starfive/camss/stf_isp.h
>> >> new file mode 100644
>> >> index 000000000000..1e5c98482350
>> >> --- /dev/null
>> >> +++ b/drivers/media/platform/starfive/camss/stf_isp.h
>> >> @@ -0,0 +1,479 @@
> 
> [snip]
> 
>> >> +/* The output line of ISP */
>> > 
>> > What is an ISP "line" ?
>> 
>> A pipeline contains ISP.
> 
> Patch 6/6 uses STF_ISP_LINE_MAX to iterate over the ISP lines. This
> makes the code somehow generic, but you only support a single line at
> the moment. Does this or other SoCs in your product line integrate the
> same ISP with multiple lines ? If so, would it be possible to share a
> block diagram, to better understand the other hardware architectures
> that this driver will need to support in the future ?
> 

Yes, OK, I will add a block diagram and a more detailed description in
the starfive_camss.rst file in the next version.

>> >> +enum isp_line_id {
>> >> +	STF_ISP_LINE_INVALID = -1,
>> >> +	STF_ISP_LINE_SRC = 1,
>> >> +	STF_ISP_LINE_MAX = STF_ISP_LINE_SRC
>> >> +};
> 
> [snip]
> 
>> >> +void stf_isp_init_cfg(struct stf_isp_dev *isp_dev)
>> >> +{
>> >> +	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_DC_CFG_1, DC_AXI_ID(0x0));
>> >> +	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_DEC_CFG,
>> >> +			  DEC_V_KEEP(0x0) |
>> >> +			  DEC_V_PERIOD(0x0) |
>> >> +			  DEC_H_KEEP(0x0) |
>> >> +			  DEC_H_PERIOD(0x0));
>> >> +
>> >> +	stf_isp_config_obc(isp_dev->stfcamss);
>> >> +	stf_isp_config_oecf(isp_dev->stfcamss);
>> >> +	stf_isp_config_lccf(isp_dev->stfcamss);
>> >> +	stf_isp_config_awb(isp_dev->stfcamss);
>> >> +	stf_isp_config_grgb(isp_dev->stfcamss);
>> >> +	stf_isp_config_cfa(isp_dev->stfcamss);
>> >> +	stf_isp_config_ccm(isp_dev->stfcamss);
>> >> +	stf_isp_config_gamma(isp_dev->stfcamss);
>> >> +	stf_isp_config_r2y(isp_dev->stfcamss);
>> >> +	stf_isp_config_y_curve(isp_dev->stfcamss);
>> >> +	stf_isp_config_sharpen(isp_dev->stfcamss);
>> >> +	stf_isp_config_dnyuv(isp_dev->stfcamss);
>> >> +	stf_isp_config_sat(isp_dev->stfcamss);
>> > 
>> > All these parameters are hardcoded, why are they not exposed to
>> > userspace ?
>> 
>> Here is a basic startup configuration for the ISP registers. The
>> function name is confusing, as if it is configuring a specific
>> function. In fact, it is just a basic init configuration.
> 
> Did I miss a place in the patch series where all these parameters can be
> configured by userspace, or is that not possible at the moment ? If it
> isn't possible, do you plan to implement that ?
> 

Yes, we are doing related development internally.

>> >> +
>> >> +	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_CSI_MODULE_CFG,
>> >> +			  CSI_DUMP_EN | CSI_SC_EN | CSI_AWB_EN |
>> >> +			  CSI_LCCF_EN | CSI_OECF_EN | CSI_OBC_EN | CSI_DEC_EN);
>> >> +	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_ISP_CTRL_1,
>> >> +			  CTRL_SAT(1) | CTRL_DBC | CTRL_CTC | CTRL_YHIST |
>> >> +			  CTRL_YCURVE | CTRL_BIYUV | CTRL_SCE | CTRL_EE |
>> >> +			  CTRL_CCE | CTRL_RGE | CTRL_CME | CTRL_AE | CTRL_CE);
>> >> +}
> 
> [snip]
> 

Regards,

Jack Zhu
