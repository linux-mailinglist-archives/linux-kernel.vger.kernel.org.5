Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2B77CD558
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjJRHMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjJRHMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:12:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE83B6;
        Wed, 18 Oct 2023 00:12:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F33C433C8;
        Wed, 18 Oct 2023 07:12:16 +0000 (UTC)
Message-ID: <61617735-c196-43e1-a4c6-539f348978e0@xs4all.nl>
Date:   Wed, 18 Oct 2023 09:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/8] Add StarFive Camera Subsystem driver
Content-Language: en-US, nl
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev,
        changhuang.liang@starfivetech.com
References: <20231008085154.6757-1-jack.zhu@starfivetech.com>
 <98297bfc-ab81-4bb5-acc3-619fdf879276@xs4all.nl>
 <c255e215-b1ed-7397-0534-8d6ebda86350@starfivetech.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <c255e215-b1ed-7397-0534-8d6ebda86350@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2023 05:11, Jack Zhu wrote:
> 
> 
> On 2023/10/16 19:40, Hans Verkuil wrote:
>> Hi Jack,
>>
>> On 08/10/2023 10:51, Jack Zhu wrote:
>>> Hi,
>>>
>>> This series is the v10 series that attempts to support the Camera Subsystem
>>> found on StarFive JH7110 SoC.
>>>
>>> This series is based on top of the master branch of media_stage repository,
>>> which is tested with a v4l2-compliance compiled from the git repo
>>> (git://linuxtv.org/v4l-utils.git).
>>
>> I get one smatch warning:
>>
>> drivers/staging/media/starfive/camss/stf-isp.c:122 isp_enum_mbus_code() warn: unsigned 'code->index' is never less than zero.
>>
> 
> Could you please tell me the code check command? This way I can use it to check
> my next commit.

See https://repo.or.cz/smatch.git/blob/HEAD:/Documentation/smatch.txt

FYI: you can use the same build scripts that I use to verify patches. It is
described here:

https://lore.kernel.org/linux-media/18989016-6392-a77b-6cf7-1223c9161def@xs4all.nl/

See the README for detailed instructions.

Regards,

	Hans

> 
>> And I also notice that there is no TODO file: staging drivers should have a
>> TODO file explaining what needs to be done to get them out of staging.
>>
> 
> OK, I'll add it to my next commit. I previously misunderstood that it was submitted
> when moving out of staging.
> 
>> I'm curious to know that as well :-)
>>
>> It looks like there is a lot of additional development that can be done, since
>> most of the ISP parameters appear to be hardcoded.
>>
> 
> Part is the module initialization configuration. In the next stage, we will use
> incremental development to implement 3A functions.
> 

