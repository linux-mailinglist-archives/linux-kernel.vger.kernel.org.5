Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EBA799DDB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 13:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346642AbjIJLUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 07:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjIJLUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 07:20:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FCACD5;
        Sun, 10 Sep 2023 04:20:19 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qfIUD-0005Bf-DQ; Sun, 10 Sep 2023 13:20:17 +0200
Message-ID: <f8ca4666-1a64-49fe-afa7-47e72c82ef9e@leemhuis.info>
Date:   Sun, 10 Sep 2023 13:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Fix static memory detection even more
Content-Language: en-US, de-DE
To:     Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <ZNep5EcYskP9HtGD@p100>
 <b7526bf6-886f-457a-beba-84ae9f75bc77@roeck-us.net>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <b7526bf6-886f-457a-beba-84ae9f75bc77@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694344819;376fddac;
X-HE-SMSGID: 1qfIUD-0005Bf-DQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[side notes:
* mail has a reduced set of recipients
* fix is in the works, but add it to the tracking, as rc1 is due
* just in case it was missed: culprit made it to various stable series]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 03.09.23 21:36, Guenter Roeck wrote:
> 
> On Sat, Aug 12, 2023 at 05:48:52PM +0200, Helge Deller wrote:
>> On the parisc architecture, lockdep reports for all static objects which
>> are in the __initdata section (e.g. "setup_done" in devtmpfs,
>> "kthreadd_done" in init/main.c) this warning:
>>
>> 	INFO: trying to register non-static key.
>>
> [...]
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Fixes: bac59d18c701 ("x86/setup: Fix static memory detection")
> 
> On loongarch, this patch results in the following backtrace.
> [...]> # first bad commit: [0a6b58c5cd0dfd7961e725212f0fc8dfc5d96195]
lockdep: fix static memory detection even more

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 0a6b58c5cd0dfd7961e725212f0fc8dfc5d961
#regzbot title lockdep: backtrace on loongarch
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
