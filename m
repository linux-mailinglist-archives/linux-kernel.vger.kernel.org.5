Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD49B78852A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjHYKpH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Aug 2023 06:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjHYKo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:44:59 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1232E54;
        Fri, 25 Aug 2023 03:44:55 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 649C724E236;
        Fri, 25 Aug 2023 18:44:54 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Aug
 2023 18:44:54 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Aug
 2023 18:44:53 +0800
Message-ID: <a0c023e0-e145-f6f7-3a84-ac6045a6c495@starfivetech.com>
Date:   Fri, 25 Aug 2023 18:44:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v8 3/8] media: staging: media: starfive: camss: Add core
 driver
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <changhuang.liang@starfivetech.com>
References: <20230824080109.89613-1-jack.zhu@starfivetech.com>
 <20230824080109.89613-4-jack.zhu@starfivetech.com>
 <74183f7b-6e53-ba3d-2160-1e526d61073b@wanadoo.fr>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <74183f7b-6e53-ba3d-2160-1e526d61073b@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thank you for your comment!

On 2023/8/25 2:31, Christophe JAILLET wrote:
> Le 24/08/2023 à 10:01, Jack Zhu a écrit :
>> Add core driver for StarFive Camera Subsystem. The code parses
>> the device platform resources and registers related devices.
>>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> ---
> 
> ...
> 
>> diff --git a/drivers/staging/media/starfive/camss/Kconfig b/drivers/staging/media/starfive/camss/Kconfig
>> new file mode 100644
>> index 000000000000..8d20e2bd2559
>> --- /dev/null
>> +++ b/drivers/staging/media/starfive/camss/Kconfig
>> @@ -0,0 +1,17 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config VIDEO_STARFIVE_CAMSS
>> +    tristate "Starfive Camera Subsystem driver"
>> +    depends on V4L_PLATFORM_DRIVERS
>> +    depends on VIDEO_DEV && OF
>> +    depends on HAS_DMA
>> +    depends on PM
>> +    select MEDIA_CONTROLLER
>> +    select VIDEO_V4L2_SUBDEV_API
>> +    select VIDEOBUF2_DMA_CONTIG
>> +    select V4L2_FWNODE
>> +    help
>> +       Enable this to support for the Starfive Camera subsystem
>> +       found on Starfive JH7110 SoC.
>> +
>> +       To compile this driver as a module, choose M here: the
>> +       module will be called stf-camss.
> 
> stf_camss? (s/-/_)
> 

Refer to the writing method of other media drivers, most of them use hyphen. It
may be better to use ‘starfive-camss'？

>> diff --git a/drivers/staging/media/starfive/camss/Makefile b/drivers/staging/media/starfive/camss/Makefile
>> new file mode 100644
>> index 000000000000..f53c5cbe958f
>> --- /dev/null
>> +++ b/drivers/staging/media/starfive/camss/Makefile
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Makefile for StarFive Camera Subsystem driver
>> +#
>> +
>> +starfive-camss-objs += \
>> +        stf_camss.o
>> +
>> +obj-$(CONFIG_VIDEO_STARFIVE_CAMSS) += starfive-camss.o
> 
> I'm not an expert in Makefile files, but this stf_camss.o and starfive-camss.o look strange to me.
> 

Is it better to replace 'stf_camss.o' with 'stf-camss.o', which is consistent
with the driving style of other media drivers?

>> diff --git a/drivers/staging/media/starfive/camss/stf_camss.c b/drivers/staging/media/starfive/camss/stf_camss.c
>> new file mode 100644
>> index 000000000000..75ebc3a35218
>> --- /dev/null
>> +++ b/drivers/staging/media/starfive/camss/stf_camss.c
> 
> ...
> 
>> +static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
>> +{
>> +    struct device_node *node = NULL;
>> +    int ret, num_subdevs = 0;
>> +
>> +    for_each_endpoint_of_node(stfcamss->dev->of_node, node) {
>> +        struct stfcamss_async_subdev *csd;
>> +
>> +        if (!of_device_is_available(node))
>> +            continue;
>> +
>> +        csd = v4l2_async_nf_add_fwnode_remote(&stfcamss->notifier,
>> +                              of_fwnode_handle(node),
>> +                              struct stfcamss_async_subdev);
>> +        if (IS_ERR(csd)) {
>> +            ret = PTR_ERR(csd);
>> +            dev_err(stfcamss->dev, "failed to add async notifier\n");
>> +            v4l2_async_nf_cleanup(&stfcamss->notifier);
> 
> having it here, looks strange to me.
> It is already called in the error handling path of the probe.
> 
> Should there be a "of_node_put(node);" if we return here?
> 

We do not call a 'get' interface, is it necessary to use the 'put' interface?

>> +            return ret;
>> +        }
>> +
>> +        ret = stfcamss_of_parse_endpoint_node(stfcamss, node, csd);
>> +        if (ret)
>> +            return ret;
>> +
>> +        num_subdevs++;
>> +    }
>> +
>> +    return num_subdevs;
>> +}
> 
> ...
> 
>> +static int stfcamss_remove(struct platform_device *pdev)
>> +{
>> +    struct stfcamss *stfcamss = platform_get_drvdata(pdev);
>> +
>> +    v4l2_device_unregister(&stfcamss->v4l2_dev);
>> +    media_device_cleanup(&stfcamss->media_dev);
> 
> Is a "v4l2_async_nf_cleanup(&stfcamss->notifier);" missing to match the error handling path of the probe?
> 
>> +    pm_runtime_disable(&pdev->dev);
>> +
>> +    return 0;
>> +}
>> +
> 
> ...
