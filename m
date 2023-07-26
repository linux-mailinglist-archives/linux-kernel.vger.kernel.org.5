Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A8E76421C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjGZW0b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 18:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjGZW02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:26:28 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07154270F;
        Wed, 26 Jul 2023 15:26:25 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3472924E275;
        Thu, 27 Jul 2023 06:26:18 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 27 Jul
 2023 06:26:18 +0800
Received: from [192.168.60.107] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 27 Jul
 2023 06:26:17 +0800
Message-ID: <c7aaf817-3504-e325-c29b-5cf1834ae72f@starfivetech.com>
Date:   Thu, 27 Jul 2023 06:26:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 2/6] media: admin-guide: Add starfive_camss.rst for
 Starfive Camera Subsystem
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-3-jack.zhu@starfivetech.com>
 <a108084b-8044-fe6f-9cb8-df1f3fc6fdfe@linaro.org>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <a108084b-8044-fe6f-9cb8-df1f3fc6fdfe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

Thank you for your comments.

On 2023/7/26 19:26, Bryan O'Donoghue wrote:
> On 19/06/2023 12:28, Jack Zhu wrote:
>> Add starfive_camss.rst file that documents the Starfive Camera
>> Subsystem driver which is used for handing image sensor data.
>>
>> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> ---
>>   .../admin-guide/media/starfive_camss.rst      | 57 +++++++++++++++++++
>>   .../media/starfive_camss_graph.dot            | 16 ++++++
>>   .../admin-guide/media/v4l-drivers.rst         |  1 +
>>   MAINTAINERS                                   |  1 +
>>   4 files changed, 75 insertions(+)
>>   create mode 100644 Documentation/admin-guide/media/starfive_camss.rst
>>   create mode 100644 Documentation/admin-guide/media/starfive_camss_graph.dot
>>
>> diff --git a/Documentation/admin-guide/media/starfive_camss.rst b/Documentation/admin-guide/media/starfive_camss.rst
>> new file mode 100644
>> index 000000000000..a6378849384f
>> --- /dev/null
>> +++ b/Documentation/admin-guide/media/starfive_camss.rst
>> @@ -0,0 +1,57 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +.. include:: <isonum.txt>
>> +
>> +================================
>> +Starfive Camera Subsystem driver
>> +================================
>> +
>> +Introduction
>> +------------
>> +
>> +This file documents the driver for the Starfive Camera Subsystem found on
>> +Starfive JH7110 SoC. The driver is located under drivers/media/platform/
>> +starfive.
>> +
>> +The driver implements V4L2, Media controller and v4l2_subdev interfaces.
>> +Camera sensor using V4L2 subdev interface in the kernel is supported.
>> +
>> +The driver has been successfully used on the Gstreamer 1.18.5 with
>> +v4l2src plugin.
>> +
>> +
>> +Starfive Camera Subsystem hardware
>> +----------------------------------
>> +
>> +The Starfive Camera Subsystem hardware consists of:
>> +
>> +- MIPI DPHY Receiver: receives mipi data from a MIPI camera sensor.
> 
> Feels like a terribe nit-pick but you have "mipi" and "MIPI" here. I'd be consistent with one - recommend MIPI throughout your documentation.
> 

Okay, I will keep a consistent description.

>> +- MIPI CSIRx Controller: is responsible for handling and decoding CSI2 protocol
>> +  based camera sensor data stream.
>> +- ISP: handles the image data streams from the MIPI CSIRx Controller.
> 
> Maybe you've done this elsewhere but, it would be worthwhile describing what the ISP does. Debayering ? 3As ? Just raw dumps ?
> 

Ok, I will add more descriptions in the next version.

>> +- VIN(Video In): a top-level module, is responsible for controlling power
>> +  and clocks to other modules, dumps the input data to memory or transfers the
>> +  input data to ISP.
>> +
>> +
>> +Topology
>> +--------
>> +
>> +The media controller pipeline graph is as follows:
>> +
>> +.. _starfive_camss_graph:
>> +
>> +.. kernel-figure:: starfive_camss_graph.dot
>> +    :alt:   starfive_camss_graph.dot
>> +    :align: center
>> +
>> +The driver has 2 video devices:
>> +
>> +- stf_vin0_wr_video0: capture device for images directly from the VIN module.
> 
> OK so you can get the raw images.
> 
>> +- stf_vin0_isp0_video1: capture device for images without scaling.
>> +
>> +The driver has 3 subdevices:
>> +
>> +- stf_isp0: is responsible for all the isp operations.
>> +- stf_vin0_wr: used to dump RAW images to memory.
>> +- stf_vin0_isp0: used to capture images for the stf_vin0_isp0_video1 device.
> 
> But what is being output here ? RGB, jpeg, YUV ?
> It would be worth adding a few bits of text to describe that so you don't have to dive into code to understand it.
> 

Ok, I will add more descriptions.

> ---
> bod

-- 
Regards,

Jack Zhu
