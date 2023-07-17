Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D1755D45
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGQHpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjGQHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D5E171C;
        Mon, 17 Jul 2023 00:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E20860F99;
        Mon, 17 Jul 2023 07:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC5CC433C7;
        Mon, 17 Jul 2023 07:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689579880;
        bh=Jkd84nE5R3TaLVNwXO673x0RBPwyNCoKfZf2MRJiVKg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T0zN+ab3PsuKv+u/5fxNvWiijHF8BILGM8r9lyHoR58ee2SrxP9jx1CfKZ03kHP4q
         2EJIiKxzW4XoRyBIEc+wBosZ0j5K+2lQUPwe4RkuppCJWQ6ahkdMjtAUwORbyrtl91
         5lmYO0Or+cTXKSQCqk5F/sbp7cAHHuV41JcxJ0QpW5CSpjSSM9phuflh2X+NUo6DbI
         D8Zx2v3ZF+FftoTG5Ui7C4vRQTF2Z2og2AiCg4ylGkE9Ufu27ei35Q4ldm/xmsz8dr
         9pT9OYiZfUp7n7w8XN0fIhFodFiiRXjnl4ty/mc9yPYznU1ACvk87YOsVA3FvBcy6h
         nFgKblZnbo5xw==
Message-ID: <1da16601-dc03-4b65-252f-3925f2a83705@kernel.org>
Date:   Mon, 17 Jul 2023 09:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH docs] docs: maintainer: document expectations of small
 time maintainers
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     corbet@lwn.net, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20230713223432.1501133-1-kuba@kernel.org>
 <6f1014cd-f8c5-f935-dcc7-4f5a6b85e473@kernel.org>
 <20230714101028.337fb39a@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230714101028.337fb39a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 19:10, Jakub Kicinski wrote:
>>> +
>>> +Maintainers must review *all* patches touching exclusively their drivers,  
>>
>> I don't agree with this as a small driver maintainer. Several subsystem
>> maintainers take the patches much faster than I am able to check the
>> inbox. I can provide names if you need some proves. With such criteria I
>> should be removed from maintainers, because I am not able to review
>> within 24h.
>>
>> Either give reasonable time, like two weeks, or don't require driver
>> maintainers to be 24/7 for subystem maintainer disposal. This is very
>> unfair rule.
> 
> I think your concern is more about the timeline than what's quoted here,
> so I rephrased that:

My concerns are for both timeline and for wording which makes it
obligatory. I think we should not have stale maintainers in MAINTAINERS
file, thus if someone repeatedly does not match criteria, should be
dropped and moved to CREDITS. However I felt here your wording quite
strong, thus I would assume we will start dropping a lot, a lot of
driver maintainers. I am not sure if we really want it, because from
time to time, such maintainer might be actually active and helpful.

> 
> -The exact expectations on the review time will vary by subsystem
> -from 1 day (e.g. networking) to a week in smaller subsystems.
> 
> +The exact expectations on the response time will vary by subsystem.
> +The patch review SLA the subsystem had set for itself can sometimes
> +be found in the subsystem documentation. Failing that as a rule of thumb
> +reviewers should try to respond quicker than what is the usual patch
> +review delay of the subsystem maintainer. The resulting expectations
> +may range from two working days for fast-paced subsystems to two weeks
> +in slower moving parts of the kernel.

Sounds good. Thank you.

> 
> 
> To the point of reviewing "all" patches, I want to keep this. When 
> I ping vendors they often reply with "oh I didn't know I'm supposed
> to respond, the change looks good". People confuse the review process
> with a veto process, if they don't want to outright reject the change
> they stay quiet :|

OK, I understand. That's the good point.

> 
>>> +no matter how trivial. If the patch is a tree wide change and modifies
>>> +multiple drivers - whether to provide a review is left to the maintainer.
>>> +
>>> +There should be multiple maintainers for any piece of code, an ``Acked-by``
>>> +or ``Reviewed-by`` tag (or review comments) from a single maintainer is
>>> +enough to satisfy this requirement.
>>> +
>>> +If review process or validation for a particular change will take longer
>>> +than the expected review timeline for the subsystem, maintainer should
>>> +reply to the submission indicating that the work is being done, and when
>>> +to expect full results.
>>> +
>>> +Refactoring and core changes
>>> +----------------------------
>>> +
>>> +Occasionally core code needs to be changed to improve the maintainability
>>> +of the kernel as a whole. Maintainers are expected to be present and
>>> +help guide and test changes to their code to fit the new infrastructure.
>>> +
>>> +Bug reports
>>> +-----------
>>> +
>>> +Maintainers must respond to and address bug reports. The bug reports  
>>
>> This is even more unreasonable than previous 1 day review. I don't have
>> capabilities to address bug reports for numerous drivers I am
>> maintaining. I don't have hardware, I don't have time, no one pays me
>> for it. I still need some life outside of working hours, so expecting
>> both reviews in 1 day and addressing bugs is way too much.
>>
>>> +range from users reporting real life crashes, thru errors discovered
>>> +in fuzzing to reports of issues with the code found by static analysis
>>> +tools and new compiler warnings.
>>> +
>>> +Volunteer maintainers are only required to address bugs and regressions.  
>>
>> "Only required"? That's not "only" but a lot.

Thanks.

> 
> I was trying to soften the paragraph for volunteers let me try to
> soften it.. harder?
> 
>>> +It is understood that due to lack of access to documentation and
>>> +implementation details they may not be able to solve all problems.  
>>
>> So how do I address? Say "Oh, that's bad"?
> 
> How about:
> 
>   Bug reports
>   -----------
> 
>   Maintainers must respond to bug reports of reasonable quality. The bug reports
>   range from users reporting real life crashes, thru errors discovered
>   in fuzzing to reports of issues with the code found by static analysis
>   tools and new compiler warnings.
> 
>   It is understood that the hands of volunteer maintainers can often be tied
>   by the lack of access to documentation, implementation details, hardware
>   platforms, etc.
> 
> 
> I don't know how to phrase it better :( Obviously maintainers are
> expected to look at bug reports. At the same time we all know the
> feeling of being a maintainer of some crappy HW which sometimes 
> doesn't work and all we can do is say "thoughts and prayers". 

Yes, sounds better.

> 
> IDK. 
> 
> The doc would be incomplete without mentioning that bug reports are
> part of maintainers' life :(
> 
>> Jakub, with both of your criteria - reviewing and addressing - I should
>> be dropped from all the driver maintainership. If this document passes,
>> I will do it - drop myself - because:
>> 1. No one pays me for it,
>> 2. I barely have hardware,
>> 3. I want to live a life and I am already working much more than 8h per day.
> 
> It's really hard to codify the rules. I hope we can start somewhere
> and chisel at the rules if/as we start getting feedback/complaints.
> 
> I can give you examples of bad vendor behavior or people who stopped
> participating 10 years ago yet they still figure in MAINTAINERS all day.

Yep, I understand and I was cleaning such entries as well... :)

> Next time I see a rando manager added as a maintainer I want to be able
> to point them at a document. If the document is too "soft" they will
> just wave it off :(

Best regards,
Krzysztof

