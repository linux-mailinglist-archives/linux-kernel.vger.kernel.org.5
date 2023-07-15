Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C2D754833
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 12:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjGOKbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 06:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGOKbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 06:31:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E4835AA;
        Sat, 15 Jul 2023 03:31:06 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qKcYJ-0003rW-7A; Sat, 15 Jul 2023 12:31:03 +0200
Message-ID: <bb8c6476-283c-3bc6-710b-5a8602ccd40e@leemhuis.info>
Date:   Sat, 15 Jul 2023 12:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH docs] docs: maintainer: document expectations of small
 time maintainers
Content-Language: en-US, de-DE
To:     Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     corbet@lwn.net, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20230713223432.1501133-1-kuba@kernel.org>
 <6f1014cd-f8c5-f935-dcc7-4f5a6b85e473@kernel.org>
 <20230714101028.337fb39a@kernel.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230714101028.337fb39a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689417066;f991f5f3;
X-HE-SMSGID: 1qKcYJ-0003rW-7A
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing other people in the thread]

On 14.07.23 19:10, Jakub Kicinski wrote:
> On Fri, 14 Jul 2023 06:36:41 +0200 Krzysztof Kozlowski wrote:
>> On 14/07/2023 00:34, Jakub Kicinski wrote:
> [...]
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
> 
> IDK. 
> 
> The doc would be incomplete without mentioning that bug reports are
> part of maintainers' life :(

How about something like this:

```
Bug reports
-----------

Maintainers must ensure severe problems in their code reported to them
are resolved in a timely manner: security vulnerabilities, regressions,
compilation errors, data loss, kernel crashes, and bugs of similar scope.

Maintainers furthermore should respond to reports about other kind of
bugs as well, if the report is of reasonable quality or indicates a
problem that might be severe -- especially if they have *Supported*
status of the codebase in the MAINTAINERS file.
```

Ciao, Thorsten
