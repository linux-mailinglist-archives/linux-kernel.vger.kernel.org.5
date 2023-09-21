Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408457A9D90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjIUTlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjIUTlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:41:19 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE3B19E;
        Thu, 21 Sep 2023 12:41:12 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qjFad-0002mp-KL; Thu, 21 Sep 2023 11:03:15 +0200
Message-ID: <e3647a0a-e946-44e3-90b2-f02aec69d1c0@leemhuis.info>
Date:   Thu, 21 Sep 2023 11:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Fix static memory detection even more
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <ZNep5EcYskP9HtGD@p100>
 <b7526bf6-886f-457a-beba-84ae9f75bc77@roeck-us.net>
 <f8ca4666-1a64-49fe-afa7-47e72c82ef9e@leemhuis.info>
In-Reply-To: <f8ca4666-1a64-49fe-afa7-47e72c82ef9e@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695325272;3f254ce9;
X-HE-SMSGID: 1qjFad-0002mp-KL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux regression tracking. A
change or fix related to the regression discussed in this thread was
posted or applied, but it did not use a Closes: tag to point to the
report, as Linus and the documentation call for. Things happen, no
worries -- but now the regression tracking bot needs to be told manually
about the fix. See link in footer if these mails annoy you.]

On 10.09.23 13:20, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 03.09.23 21:36, Guenter Roeck wrote:
>>
>> On Sat, Aug 12, 2023 at 05:48:52PM +0200, Helge Deller wrote:
>>> On the parisc architecture, lockdep reports for all static objects which
>>> are in the __initdata section (e.g. "setup_done" in devtmpfs,
>>> "kthreadd_done" in init/main.c) this warning:
>>>
>>> 	INFO: trying to register non-static key.
>>>
>> [...]
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> Fixes: bac59d18c701 ("x86/setup: Fix static memory detection")
>>
>> On loongarch, this patch results in the following backtrace.
>> [...]> # first bad commit: [0a6b58c5cd0dfd7961e725212f0fc8dfc5d96195]
> lockdep: fix static memory detection even more
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 0a6b58c5cd0dfd7961e725212f0fc8dfc5d961
> #regzbot title lockdep: backtrace on loongarch
> #regzbot ignore-activity

Fix fow in next (as 68ffa230daa0d35b7cce476098433d763d5fd42f)

#regzbot fix: LoongArch: Fix lockdep static memory detection
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
