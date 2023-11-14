Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E2B7EB101
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjKNNjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjKNNjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:39:05 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777C51B9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:39:01 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r2td4-0007TS-U2; Tue, 14 Nov 2023 14:38:58 +0100
Message-ID: <2053f011-3c85-41e2-8685-1f46a2bc5fb8@leemhuis.info>
Date:   Tue, 14 Nov 2023 14:38:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NULL pointer dereference regression when running `chmod -R
 root:tracing /sys/kernel/debug/tracing`
Content-Language: en-US, de-DE
To:     Milian Wolff <milian.wolff@kdab.com>, rostedt@goodmis.org
Cc:     akaher@vmware.com, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mhiramat@kernel.org
References: <20231105160139.660634360@goodmis.org>
 <20231112104158.6638-1-milian.wolff@kdab.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20231112104158.6638-1-milian.wolff@kdab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1699969141;060555f2;
X-HE-SMSGID: 1r2td4-0007TS-U2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 12.11.23 11:41, Milian Wolff wrote:
> 
> this patch seems to have introduced a kernel bug causing
> a NULL pointer dereference when one runs:
> 
>     sudo chown -R root:tracing /sys/kernel/debug/tracing/
> 
> See the archlinux bug report I created initially for some more information:
> https://bugs.archlinux.org/task/80230
> 
> With 6.6.1 and 9aaee3eebc91dd9ccebf6b6bc8a5f59d04ef718b reverted,
> the above `chmod` command works. With a normal 6.6.1 build, or re-applying
> the patch again, the command fails and `dmesg` shows:

Steven is already working on this, but to ensure the issue doesn't fall
through the cracks unnoticed, I'm adding it to regzbot, the Linux kernel
regression tracking bot (and from the context I assume it happens in
mainline as well)

#regzbot ^introduced 28e12c09f5aa081b2
#regzbot title eventfs: NULL pointer dereference regression when running
`chmod -R root:tracing /sys/kernel/debug/tracing`
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
