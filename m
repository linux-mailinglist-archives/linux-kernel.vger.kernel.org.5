Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4610763307
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjGZKB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjGZKBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:01:24 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441D897;
        Wed, 26 Jul 2023 03:01:21 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id B614B80F8;
        Wed, 26 Jul 2023 18:01:13 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Jul
 2023 18:01:13 +0800
Received: from [192.168.60.107] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Jul
 2023 18:01:13 +0800
Message-ID: <5f4733e4-9bda-3381-ada5-3a495a079e5f@starfivetech.com>
Date:   Wed, 26 Jul 2023 18:01:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 5/6] media: starfive: camss: Add ISP driver
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-6-jack.zhu@starfivetech.com>
 <6936fa89-af4a-6518-972b-693691f8e78a@xs4all.nl>
Content-Language: en-US
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <6936fa89-af4a-6518-972b-693691f8e78a@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
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

Hi Hans,

Thank you for your comment.

On 2023/7/26 17:11, Hans Verkuil wrote:
> Hi Jack,
> 
> On 19/06/2023 13:28, Jack Zhu wrote:
>> Add ISP driver for StarFive Camera Subsystem.
>> 
>> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> ---
>>  .../media/platform/starfive/camss/Makefile    |   2 +
>>  .../media/platform/starfive/camss/stf_camss.c |  76 ++-
>>  .../media/platform/starfive/camss/stf_camss.h |   3 +
>>  .../media/platform/starfive/camss/stf_isp.c   | 519 ++++++++++++++++++
>>  .../media/platform/starfive/camss/stf_isp.h   | 479 ++++++++++++++++
>>  .../platform/starfive/camss/stf_isp_hw_ops.c  | 468 ++++++++++++++++
>>  6 files changed, 1544 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/media/platform/starfive/camss/stf_isp.c
>>  create mode 100644 drivers/media/platform/starfive/camss/stf_isp.h
>>  create mode 100644 drivers/media/platform/starfive/camss/stf_isp_hw_ops.c
> 
> Just a quick note:
> 
> When I compile this I get the following warnings:
> 
> drivers/media/platform/starfive/camss/stf_camss.c: In function 'stfcamss_subdev_notifier_bound':
> drivers/media/platform/starfive/camss/stf_camss.c:217:23: warning: 'pad[0]' may be used uninitialized [-Wmaybe-uninitialized]
>   217 |                 ret = v4l2_create_fwnode_links_to_pad(subdev, pad[i], 0);
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/media/platform/starfive/camss/stf_camss.c:202:27: note: 'pad[0]' was declared here
>   202 |         struct media_pad *pad[STF_PADS_NUM];
>       |                           ^~~
> drivers/media/platform/starfive/camss/stf_isp.c: In function 'isp_try_format.isra':
> drivers/media/platform/starfive/camss/stf_isp.c:105:40: warning: 'formats' may be used uninitialized [-Wmaybe-uninitialized]
>   105 |         const struct isp_format_table *formats;
>       |                                        ^~~~~~~
> drivers/media/platform/starfive/camss/stf_isp.c:105:40: note: 'formats' was declared here
>   105 |         const struct isp_format_table *formats;
>       |                                        ^~~~~~~
> drivers/media/platform/starfive/camss/stf_isp.c:106:30: warning: 'rect' may be used uninitialized [-Wmaybe-uninitialized]
>   106 |         struct stf_isp_crop *rect;
>       |                              ^~~~
> drivers/media/platform/starfive/camss/stf_isp.c:106:30: note: 'rect' was declared here
>   106 |         struct stf_isp_crop *rect;
>       |                              ^~~~
> 
> That's when I build with: make W=1 KCFLAGS=-Wmaybe-uninitialized
> 

OK, I will fix these warnings.

> Regards,
> 
> 	Hans
> 
>> 

-- 
Regards,

Jack Zhu
