Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB18B7E52A6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbjKHJ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbjKHJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:28:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA9E92
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:28:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97557C433C8;
        Wed,  8 Nov 2023 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699435734;
        bh=Slh6F7wmwz4OhdLRrILiLeaxuOyCs+pgESUIHeXm8qY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m5dBSPOklCkkO/Tfs4uH4TpZHRjeeKOckgPjUT5Ruz2Ahi36RpC5tXioMx8Md0IAo
         iJwTqgfifAlMqeUgkO2+fnGYFZGDXFxJWJipH6T7vPNc1NIT8v2EAff5DvYFHCA+gz
         00xteEN+ScYcQhUyQEJsH/ZeaIxo7nJIk0S5nQ3RzlPh2ODHBI7JBBH+8FXFLObqFc
         AMh/9hCCsjK4gOB7uZJUl/0QFaYOJSowTke7U36eQEcHMyiVOnmeIBGXwR+EmQ5l+y
         S7oES8gTRpMiv9yTmlRkIgwODusPwgO1s2BvDEZiluzo88jrxmgXp5ycmj/evrhUPS
         zg1ZCceN07Xzg==
Message-ID: <59913b7c-dec9-4097-b38c-6991c4b48153@kernel.org>
Date:   Wed, 8 Nov 2023 10:28:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: stm32: add clocks and reset binding for
 stm32mp25 platform
Content-Language: en-US
To:     Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231106141845.102648-1-gabriel.fernandez@foss.st.com>
 <20231106141845.102648-2-gabriel.fernandez@foss.st.com>
 <a0231a23-89be-4b44-aae0-ee0bb332f2ae@kernel.org>
 <fbd4e006-606c-456a-97de-f74e69e90f3b@foss.st.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <fbd4e006-606c-456a-97de-f74e69e90f3b@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2023 10:13, Gabriel FERNANDEZ wrote:
> Hi Krzysztof,
> 
> Thank you very much for your review.
> 
> 
> On 11/7/23 08:27, Krzysztof Kozlowski wrote:
>> On 06/11/2023 15:18, gabriel.fernandez@foss.st.com wrote:
>>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>>
>>> Adds clock and reset binding entries for STM32MP25 SoC family
>>>
>>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> This was based on some very old tree. Please work on latest release,
>> maintainer's tree or linux-next. Otherwise we need to point the same
>> issues we already fixed. This would be quite a waste of time, don't you
>> think?
> 
> To make sure I understood the problem and wouldn't repeat it, I pushed 
> my series starting from the tag 'next-20231031.
> 
> Or is it related to the content of the YAML file?

I meant that you:
1. Worked on old tree and used old files as starting template,
2. Worked on old tree, used get_maintainers.pl and send it.

This could be any combination of above. All of them are not the way you
should do. And you should notice it through bounces of incorrect emails.
Very old emails.


>>> @@ -0,0 +1,167 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
>>> +/*
>>> + * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
>>> + * Author(s): Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>> + */
>>> +
>>> +#ifndef _DT_BINDINGS_STM32MP25_RESET_H_
>>> +#define _DT_BINDINGS_STM32MP25_RESET_H_
>>> +
>>> +#define SYS_R		8192
>> NAK, don't put register values into the bindings. There is no single
>> need of it. Use IDs (which start from 0 and are incremented by 1) or
>> drop it.
>>
> My STM32MP25 driver is based on the same binding as the STM32MP13, which 
> is already upstreamed last year.
> 
> I will update also  the YAML file of the STM32MP13 for the above remarks.
> 
> But should I update the binding values of the STM32MP13 and try a 
> solution about backward compatible ?

You cannot change existing binding. I should have given you the same
comments for STM32MP13 year ago, but that time I was too busy with all
the reviews to enforce also the register constants in the bindings.

> 
> The idea was to have the same reset driver for all STM32MP platforms
> 

You can keep the driver, I care less how it is written. What I oppose is
to add new register values as binding IDs. Why? Because these are not
IDs and your driver is not using them. If these were IDs, your driver
would use them and I would expect them to start from 0. Just like your
clock driver is doing.

So just drop this reset binding header changes. You don't need them.
Feel free to store such register values in a header in /boot/dts/
directory, to make it clear these are only helpers for DTS, not
bindings. This will also allow you in the future to change them, unlike
bindings.

Best regards,
Krzysztof

