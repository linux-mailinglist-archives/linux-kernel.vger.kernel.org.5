Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEE57A45EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbjIRJbF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjIRJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:30:26 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14D0118;
        Mon, 18 Sep 2023 02:30:13 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 30AB824E2BA;
        Mon, 18 Sep 2023 17:30:09 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 18 Sep
 2023 17:30:09 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 18 Sep
 2023 17:30:08 +0800
Message-ID: <41370a5d-ffa3-f85b-aa2a-b6dd9cc570f6@starfivetech.com>
Date:   Mon, 18 Sep 2023 17:30:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v9 0/8] Add StarFive Camera Subsystem driver
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <changhuang.liang@starfivetech.com>
References: <20230914031607.34877-1-jack.zhu@starfivetech.com>
 <11735008-1adf-4b84-9023-d295371caed5@xs4all.nl>
Content-Language: en-US
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <11735008-1adf-4b84-9023-d295371caed5@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans，

Thanks for your comment.

On 2023/9/15 17:26, Hans Verkuil wrote:
> On 14/09/2023 05:15, Jack Zhu wrote:
>> Hi,
>> 
>> This series is the v9 series that attempts to support the Camera Subsystem
>> found on StarFive JH7110 SoC.
>> 
>> This series is based on top of the master branch of media_stage repository.
>> 
>> The following are the media graph for the device and the v4l2-compliance
>> output.
>> 
>> ===========================================================================
>> [the media graph]:
>> 
>> digraph board {
>> 	rankdir=TB
>> 	n00000001 [label="{{<port0> 0} | stf_isp\n/dev/v4l-subdev0 | {<port1> 1}}", shape=Mrecord, style=filled, fillcolor=green]
>> 	n00000001:port1 -> n00000008 [style=dashed]
>> 	n00000004 [label="capture_raw\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
>> 	n00000008 [label="capture_yuv\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
>> 	n0000000e [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
>> 	n0000000e:port1 -> n00000001:port0 [style=dashed]
>> 	n0000000e:port1 -> n00000004 [style=dashed]
>> 	n00000018 [label="{{} | imx219 6-0010\n/dev/v4l-subdev1 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
>> 	n00000018:port0 -> n0000000e:port0 [style=bold]
>> }
>> 
>> [the device topology]:
>> 
>> Media controller API version 6.5.0
>> 
>> Media device information
>> ------------------------
>> driver          starfive-camss
>> model           Starfive Camera Subsystem
>> serial          
>> bus info        platform:19840000.camss
>> hw revision     0x0
>> driver version  6.5.0
>> 
>> Device topology
>> - entity 1: stf_isp (2 pads, 2 links)
>>             type V4L2 subdev subtype Unknown flags 0
>>             device node name /dev/v4l-subdev0
>> 	pad0: Sink
>> 		[fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb
>> 		 crop.bounds:(0,0)/1920x1080
>> 		 crop:(0,0)/1920x1080]
>> 		<- "cdns_csi2rx.19800000.csi-bridge":1 []
>> 	pad1: Source
>> 		[fmt:YUYV8_1_5X8/1920x1080 field:none colorspace:srgb
>> 		 crop.bounds:(0,0)/1920x1080
>> 		 crop:(0,0)/1920x1080]
>> 		-> "capture_yuv":0 []
>> 
>> - entity 4: capture_raw (1 pad, 1 link)
>>             type Node subtype V4L flags 0
>>             device node name /dev/video0
>> 	pad0: Sink
>> 		<- "cdns_csi2rx.19800000.csi-bridge":1 []
>> 
>> - entity 8: capture_yuv (1 pad, 1 link)
>>             type Node subtype V4L flags 0
>>             device node name /dev/video1
>> 	pad0: Sink
>> 		<- "stf_isp":1 []
>> 
>> - entity 14: cdns_csi2rx.19800000.csi-bridge (5 pads, 3 links)
>>              type V4L2 subdev subtype Unknown flags 0
>> 	pad0: Sink
>> 		<- "imx219 6-0010":0 [ENABLED,IMMUTABLE]
>> 	pad1: Source
>> 		-> "stf_isp":0 []
>> 		-> "capture_raw":0 []
>> 	pad2: Source
>> 	pad3: Source
>> 	pad4: Source
>> 
>> - entity 24: imx219 6-0010 (1 pad, 1 link)
>>              type V4L2 subdev subtype Sensor flags 0
>>              device node name /dev/v4l-subdev1
>> 	pad0: Source
>> 		[fmt:SRGGB10_1X10/3280x2464 field:none colorspace:srgb xfer:srgb ycbcr:601 quantization:full-range
>> 		 crop.bounds:(8,8)/3280x2464
>> 		 crop:(8,8)/3280x2464]
>> 		-> "cdns_csi2rx.19800000.csi-bridge":0 [ENABLED,IMMUTABLE]
>> 
>> ===========================================================================
>> [the v4l2-compliance output]:
>> 
>> v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
> 
> This v4l2-compliance version is from a distro. For driver acceptance you
> must test with a v4l2-compliance compiled from the git repo (git://linuxtv.org/v4l-utils.git).
> 

It is compiled from buildroot, but its source code is also downloaded from the repo tag v4l-utils-1.24.1.
Do you mean I should use the latest stable version (stable-1.24) on the repo?

-- 
Regards,

Jack Zhu
