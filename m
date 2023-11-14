Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8210C7EB301
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjKNPGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKNPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:06:48 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B715310D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:06:43 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r2uzv-0007D6-1O; Tue, 14 Nov 2023 16:06:39 +0100
Message-ID: <c6212bcb-e2d8-4bb8-bef9-0a0f29c8726e@leemhuis.info>
Date:   Tue, 14 Nov 2023 16:06:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NULL pointer dereference regression when running `chmod -R
 root:tracing /sys/kernel/debug/tracing`
Content-Language: en-US, de-DE
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Milian Wolff <milian.wolff@kdab.com>, akaher@vmware.com,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org
References: <20231105160139.660634360@goodmis.org>
 <20231112104158.6638-1-milian.wolff@kdab.com>
 <2053f011-3c85-41e2-8685-1f46a2bc5fb8@leemhuis.info>
 <20231114085529.77099439@rorschach.local.home>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20231114085529.77099439@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1699974404;bcf27ff2;
X-HE-SMSGID: 1r2uzv-0007D6-1O
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.11.23 14:55, Steven Rostedt wrote:
> On Tue, 14 Nov 2023 14:38:57 +0100
> "Linux regression tracking #adding (Thorsten Leemhuis)" <regressions@leemhuis.info> wrote:
> 
>> [TLDR: I'm adding this report to the list of tracked Linux kernel
>> regressions; the text you find below is based on a few templates
>> paragraphs you might have encountered already in similar form.
>> See link in footer if these mails annoy you.]
>>
>> On 12.11.23 11:41, Milian Wolff wrote:
>>>
>>> this patch seems to have introduced a kernel bug causing
>>> a NULL pointer dereference when one runs:
>>>
>>>     sudo chown -R root:tracing /sys/kernel/debug/tracing/
>>>
>>> See the archlinux bug report I created initially for some more information:
>>> https://bugs.archlinux.org/task/80230
>>>
>>> With 6.6.1 and 9aaee3eebc91dd9ccebf6b6bc8a5f59d04ef718b reverted,
>>> the above `chmod` command works. With a normal 6.6.1 build, or re-applying
>>> the patch again, the command fails and `dmesg` shows:  
>>
>> Steven is already working on this, but to ensure the issue doesn't fall
>> through the cracks unnoticed, I'm adding it to regzbot, the Linux kernel
>> regression tracking bot (and from the context I assume it happens in
>> mainline as well)
> 
> Note, the code in question was rewritten in 6.7 and the bug does not
> exist there. It only exists in 6.6 and I already sent Greg the patch,
> and he told me that it's in his queue.
> 
> It's only a regression in 6.6 and not in mainline.

Ahh, sorry fot getting this wrong and thx for letting me know.

#regzbot introduced 9aaee3eebc91dd9ccebf6b6bc8a5f59d04ef718b
#regzbot fix: eventfs: Check for NULL ef in eventfs_set_attr()

Ciao, Thorsten

P.S.: Enjoy LPC, hope to be there again next year.
