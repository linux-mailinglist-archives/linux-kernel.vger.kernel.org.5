Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF607CD25F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 04:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjJRChm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 22:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjJRChl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 22:37:41 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349BBAB;
        Tue, 17 Oct 2023 19:37:38 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6AC1724E025;
        Wed, 18 Oct 2023 10:37:30 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 10:37:30 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 10:37:29 +0800
Message-ID: <bb5b776c-f1dd-f53e-079c-8048af2e73f1@starfivetech.com>
Date:   Wed, 18 Oct 2023 10:37:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v10 0/8] Add StarFive Camera Subsystem driver
Content-Language: en-US
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
References: <20231008085154.6757-1-jack.zhu@starfivetech.com>
 <98297bfc-ab81-4bb5-acc3-619fdf879276@xs4all.nl>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <98297bfc-ab81-4bb5-acc3-619fdf879276@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thank you for your comments.

On 2023/10/16 19:40, Hans Verkuil wrote:
> Hi Jack,
> 
> On 08/10/2023 10:51, Jack Zhu wrote:
>> Hi,
>> 
>> This series is the v10 series that attempts to support the Camera Subsystem
>> found on StarFive JH7110 SoC.
>> 
>> This series is based on top of the master branch of media_stage repository,
>> which is tested with a v4l2-compliance compiled from the git repo
>> (git://linuxtv.org/v4l-utils.git).
> 
> I get one smatch warning:
> 
> drivers/staging/media/starfive/camss/stf-isp.c:122 isp_enum_mbus_code() warn: unsigned 'code->index' is never less than zero.
> 
> And I also notice that there is no TODO file: staging drivers should have a
> TODO file explaining what needs to be done to get them out of staging.
> 
> I'm curious to know that as well :-)
> 
> It looks like there is a lot of additional development that can be done, since
> most of the ISP parameters appear to be hardcoded.
> 
> I also notice something weird in the compliance test output for v4l-subdev0 vs
> v4l-subdev1:
> 
>> Compliance test for starfive-camss device /dev/v4l-subdev0:
>> 
>> Driver Info:
>> 	Driver version   : 6.6.0
>> 	Capabilities     : 0x00000000
>> Media Driver Info:
>> 	Driver name      : starfive-camss
>> 	Model            : Starfive Camera Subsystem
>> 	Serial           : 
>> 	Bus info         : platform:19840000.camss
>> 	Media version    : 6.6.0
>> 	Hardware revision: 0x00000000 (0)
>> 	Driver version   : 6.6.0
>> Interface Info:
>> 	ID               : 0x0300001c
>> 	Type             : V4L Sub-Device
>> Entity Info:
>> 	ID               : 0x00000001 (1)
>> 	Name             : stf_isp
>> 	Function         : Image Signal Processor
>> 	Pad 0x01000002   : 0: Sink
>> 	  Link 0x02000014: from remote pad 0x1000010 of entity 'cdns_csi2rx.19800000.csi-bridge' (Video Interface Bridge): Data, Enabled
>> 	Pad 0x01000003   : 1: Source
>> 	  Link 0x0200000c: to remote pad 0x1000009 of entity 'capture_yuv' (V4L2 I/O): Data, Enabled
> 
> Here it shows the Media Driver Info for v4l-subdev0.
> 
> <snip>
> 
>> --------------------------------------------------------------------------------
>> Compliance test for device /dev/v4l-subdev1:
>> 
>> Driver Info:
>> 	Driver version   : 6.6.0
>> 	Capabilities     : 0x00000000
> 
> But this does not appear for v4l-subdev1.
> 
> I can't really tell why it doesn't show that. Can you debug a little bit?
> The code is in v4l2-compliance.cpp, line 1086:
> 
> ent_id = mi_media_info_for_fd(media_fd, node.g_fd(), &is_invalid, &node.function);
> 
> The mi_media_info_for_fd() function calls ioctl(media_fd, MEDIA_IOC_DEVICE_INFO, &mdinfo),
> and that fails for some reason. It could be that media_fd is invalid (would be weird).
> 
> This could well be a v4l2-compliance bug that you hit with this driver.
> 

On the test board, /dev/v4l-subdev1 is imx219, and the corresponding directory is
/sys/dev/char/81:3/device. Media0 does not exist in this directory. Therefore, the media_fd
obtained through mi_get_media_fd(node.g_fd(), node.bus_info) is invalid.

I don't know why media0 does not exist in /sys/dev/char/81:3/device?

-- 
Regards,

Jack Zhu
