Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8117CD28C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjJRDLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJRDLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:11:46 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C3110D;
        Tue, 17 Oct 2023 20:11:44 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 68D3A24E277;
        Wed, 18 Oct 2023 11:11:41 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 11:11:41 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 11:11:40 +0800
Message-ID: <c255e215-b1ed-7397-0534-8d6ebda86350@starfivetech.com>
Date:   Wed, 18 Oct 2023 11:11:40 +0800
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



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

Could you please tell me the code check command? This way I can use it to check
my next commit.

> And I also notice that there is no TODO file: staging drivers should have a
> TODO file explaining what needs to be done to get them out of staging.
> 

OK, I'll add it to my next commit. I previously misunderstood that it was submitted
when moving out of staging.

> I'm curious to know that as well :-)
> 
> It looks like there is a lot of additional development that can be done, since
> most of the ISP parameters appear to be hardcoded.
> 

Part is the module initialization configuration. In the next stage, we will use
incremental development to implement 3A functions.

-- 
Regards,

Jack Zhu
