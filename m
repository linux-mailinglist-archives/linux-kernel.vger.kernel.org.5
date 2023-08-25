Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C5078842C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbjHYJ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbjHYJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:58:03 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAF91B9;
        Fri, 25 Aug 2023 02:58:00 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C026F24E269;
        Fri, 25 Aug 2023 17:57:59 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Aug
 2023 17:57:59 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Aug
 2023 17:57:59 +0800
Message-ID: <109d69d1-bd64-9157-da6b-a099dbe700fe@starfivetech.com>
Date:   Fri, 25 Aug 2023 17:57:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v8 0/8] Add StarFive Camera Subsystem driver
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
References: <20230824080109.89613-1-jack.zhu@starfivetech.com>
 <2023082436-spendable-reshuffle-878d@gregkh>
 <a6f60dfc-ffbf-da4d-a81c-06caf92955d6@starfivetech.com>
 <2023082416-flanking-requisite-a8ed@gregkh>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <2023082416-flanking-requisite-a8ed@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/24 21:08, Greg Kroah-Hartman wrote:
> On Thu, Aug 24, 2023 at 08:23:33PM +0800, Jack Zhu wrote:
>> Hi Greg,
>> 
>> On 2023/8/24 19:37, Greg Kroah-Hartman wrote:
>> > On Thu, Aug 24, 2023 at 04:01:01PM +0800, Jack Zhu wrote:
>> >> Hi,
>> >> 
>> >> This series is the v8 series that attempts to support the Camera Subsystem
>> >> found on StarFive JH7110 SoC.
>> > 
>> > I don't see anything here about why this is in drivers/staging/media/
>> > now and not just in drivers/media/.  What is preventing this to be put
>> > into the correct place to start with?  What needs to be done to the code
>> > to get it out of drivers/staging/media/ and who is going to do that
>> > work?
>> > 
>> 
>> The series does not contain 3A interface. According to Laurent's suggestion,
>> we put the driver in the staging directory first. In the next stage, we will
>> continue to submit the 3A interface in the way of incremental development,
>> and finally expect the code to be placed in the drivers/media/.
> 
> Can you please say that in the changelog text for when you are adding
> the driver so that we know this?
> 

Yes, will do it. Thank you for your suggestion!

> thanks,
> 
> greg k-h
