Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71497E37E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjKGJ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGJ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:29:15 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAB9106;
        Tue,  7 Nov 2023 01:29:11 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E61BA80D3;
        Tue,  7 Nov 2023 17:29:08 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Nov
 2023 17:29:08 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Nov
 2023 17:29:08 +0800
Message-ID: <48b93e44-6cd3-03a5-0eb2-4123b3790877@starfivetech.com>
Date:   Tue, 7 Nov 2023 17:29:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v11 0/9] Add StarFive Camera Subsystem driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <changhuang.liang@starfivetech.com>
References: <20231025031422.3695-1-jack.zhu@starfivetech.com>
 <15ef0a70-734e-280a-f014-41914a55d8cf@starfivetech.com>
 <a3a2c179-2cbe-5a55-a21e-b45abfb6d494@starfivetech.com>
 <2023110745-tableful-trapezoid-4206@gregkh>
 <2023110730-thousand-skyrocket-d6ba@gregkh>
 <a2dbb182-2573-4c86-7e18-319d26a6593c@starfivetech.com>
 <2023110756-alto-stream-eb92@gregkh>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <2023110756-alto-stream-eb92@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/7 16:27, Greg Kroah-Hartman wrote:
> On Tue, Nov 07, 2023 at 04:05:11PM +0800, Jack Zhu wrote:
>> > Also, while you wait, why not just finish off the last 3 items on the
>> > TODO list which would make your code not be required to go into the
>> > staging portion of the tree at all?  You've had a few weeks now, what is
>> > preventing that from happening, and when will that work actually be
>> > done?
>> > 
>> 
>> One of my colleagues is doing related development, but he also has other
>> projects at the same time, so he cannot devote all his efforts to this
>> development. And we expect to use libcamera, which may take some time.
> 
> So that means there is no real plan at all to get this out of the
> staging directory?  If so, why should we take it at all as obviously
> this means that the code is now abandoned?
> 

Hi Greg,

It's not like that, we won't give up on this code. We just want to make
development easier using incremental development. Our developers are already
working on development, but I can't give you an accurate time. There should
be a preliminary version in about 3 months.

-- 
Regards,

Jack Zhu
