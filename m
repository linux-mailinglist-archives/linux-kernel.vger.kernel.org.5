Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2191E77472D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjHHTKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjHHTKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:10:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A96B30A40;
        Tue,  8 Aug 2023 09:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42BDB6242E;
        Tue,  8 Aug 2023 08:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7D8C433C8;
        Tue,  8 Aug 2023 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691482231;
        bh=S2XJDdh0DarfOWU0otgnt+QQKAmvWNfqK2c/4JVKZ1o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=q7YVjgYHCPEvv9Mgunx2m9+gZ8OZEE/udTwzkebBLO3w4e11UgTWdA134OtMlyNVk
         VEq0hsRs2KL5R1WfHxBMbg4BPHSL4OX0poTmNLFBogaO0lCSONPtWr3hqFFGa96NZD
         +k12kmSI9JuPPeyTBqMFx5S/txOhKF7MRWfd1g9jxJN6oWm7f8ZsoiIItJ3FI76aGq
         XtVwMzclF7Moinrik4wRG6j3Xx6bFI07YFDtmh0F/gFrlpPxzGapZ2woPOVLPPC13V
         sbbG84GC1XclyzWrQNC9X4oh1BWC88sPT6n5pgfxYuR5E/WOxqGzdr2HNLb+E1v1qz
         KUWQKjFmkzOYA==
Message-ID: <4c682c3d-7066-108f-4e40-8127adf160e0@kernel.org>
Date:   Tue, 8 Aug 2023 10:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] hwmon: Add driver for EMC181x temperature sensors
Content-Language: en-US
To:     Mathew McBride <matt@traverse.com.au>,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20230808013157.80913-1-mark.tomlinson@alliedtelesis.co.nz>
 <0248d597-b72a-5b7c-63a4-6d72384f9854@kernel.org>
 <b84c2fba-1bbe-4842-a861-525784d8a361@app.fastmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <b84c2fba-1bbe-4842-a861-525784d8a361@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 09:54, Mathew McBride wrote:
> Hi Krzysztof,
> 
> On Tue, Aug 8, 2023, at 5:38 PM, Krzysztof Kozlowski wrote:
>> On 08/08/2023 03:31, Mark Tomlinson wrote:
>>> This patch adds a HWMON driver for the EMC1812, EMC1813, EMC1814,
>>> EMC1815 and EMC1833 temperature sensor chips from microchip. Does not
>>> currently support the alert outputs.
>>>
>>> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
>>> Co-developed-by: Mathew McBride <matt@traverse.com.au>
>>> Signed-off-by: Mathew McBride <matt@traverse.com.au>
>>
>> The order of these tags is clearly not correct. It says Mathew is
>> sending, but you are not Mathew?
> 
> Just to clarify, Mark has developed this version based off something I wrote a while ago:
> 
> https://gitlab.com/traversetech/ls1088firmware/traverse-sensors/-/blob/master/emc181x/emc181x.c?ref_type=heads
> 
> Hence my copyright is listed in the header.
> 
> I advised him to list the authors in that order following the example in the kernel's "submitting patches" guide [2] which provides an example of such a situation:
> 
> https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

The last entry is:
Signed-off-by: From Author <from@author.example.org>

So it is expected to be Mark.

Best regards,
Krzysztof

