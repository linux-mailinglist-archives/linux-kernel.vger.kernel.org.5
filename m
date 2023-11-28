Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CA07FC234
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346237AbjK1OXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346155AbjK1OXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:23:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 473C1B7;
        Tue, 28 Nov 2023 06:23:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C434C15;
        Tue, 28 Nov 2023 06:24:28 -0800 (PST)
Received: from [10.57.2.117] (unknown [10.57.2.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07CAF3F6C4;
        Tue, 28 Nov 2023 06:23:39 -0800 (PST)
Message-ID: <95757bf5-a7c3-48ac-86b8-62e28680d903@arm.com>
Date:   Tue, 28 Nov 2023 14:24:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powercap: DTPM: Fix unneeded conversion to micro-Watts
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, stable@vger.kernel.org
References: <20231127092819.2019744-1-lukasz.luba@arm.com>
 <CAJZ5v0hun3D29w0DMgaSoaGpLNLP4dWN-mYpRHYESdFwP6iRsQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0hun3D29w0DMgaSoaGpLNLP4dWN-mYpRHYESdFwP6iRsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 14:17, Rafael J. Wysocki wrote:
> On Mon, Nov 27, 2023 at 10:27 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The Power values coming from the Energy Model are already in uW.
>> The PowerCap and DTPM framework operate on uW, thus all places should
>> just use the values from EM. Fix the code which left and still does
>> the unneeded conversion.
>>
>> Fixes: ae6ccaa65038 (PM: EM: convert power field to micro-Watts precision and align drivers)
>> Cc: <stable@vger.kernel.org> # v5.19+
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>> Hi Daniel,
>>
>> I have found an issue due to the uW in the EM. My apologies for that.
> 
> No need to apologize, you are making the code better.

I apologize because I introduced this uW change in the EM fwk :)
although I missed those DTPM bits which are now fixed.

Daniel told me last week that I can easily test the DTPM using
the rockpi code (because it was a pain for me in some hacks
trying to test DTPM).

> 
>> I have check those with the Rockpi dev board with your DTPM module there.
>> BTW, if you like to check the DTPM_devfreq there, you can apply that
>> patch. It should create EM for your GPU there and setup DTPM GPU:
>> https://lore.kernel.org/all/20231127081511.1911706-1-lukasz.luba@arm.com/
>>

[snip]

> 
> Applied as 6.7-rc material, thanks!

thanks Rafael!
