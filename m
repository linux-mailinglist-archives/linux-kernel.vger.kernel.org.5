Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4537EFFF7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjKRNoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjKRNoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:44:03 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AFED58;
        Sat, 18 Nov 2023 05:43:58 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r4Lc4-0004jA-If; Sat, 18 Nov 2023 14:43:56 +0100
Message-ID: <932a34b2-b1b8-43f9-8a1e-3707147a271a@leemhuis.info>
Date:   Sat, 18 Nov 2023 14:43:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: platform/x86/intel/pmc: regression found in commit
 804951203aa541ad6720c9726c173d18aeb3ab6b
Content-Language: en-US, de-DE
To:     Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAD+OKUp=MA6VahvoM0cXgrM1uSwGtqaTV80-+x2VBLgN1RPzag@mail.gmail.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAD+OKUp=MA6VahvoM0cXgrM1uSwGtqaTV80-+x2VBLgN1RPzag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700315038;8ce82a23;
X-HE-SMSGID: 1r4Lc4-0004jA-If
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

On 13.11.23 16:42, James Hutchinson wrote:
> Running here on an Intel NUC 8i3BEH Coffee Lake machine under Arch Linux.
> 
> Connected to this machine I have 4x USB DVB Cards (2xDVBSky S960
> DVB-S2 adapters & 2xGeniatech T230 DVB-T2 adapters), and I stream TV
> Channels around the house via Tvheadend.
> 
> Since linux kernel v6.5 onwards I noticed a bad performance regression
> whereby the streams are basically unstable. There are tons of
> continuity errors in the Tvheadend logfile, and the picture and sound
> are badly broken up as though the system is throttled or does not have
> the bandwidth to cope with the streams.
> 
> Sometimes the stream will work for a minute or so after reboot, before
> then becoming unstable, and then seems to remain unstable until the
> next cold reboot.
> 
> I dropped back to v6.1 LTS (where everything is fine) and re-tested
> following the release of v6.6...
> ...the problem had not gone away so I performed a git bisect to
> identify the culprit and found this to be:
> 
> 804951203aa541ad6720c9726c173d18aeb3ab6b: platform/x86:intel/pmc:
> Combine core_init() and core_configure()
> 
> I can work around the issue by either reverting this commit or by
> disabling CONFIG_INTEL_PMC_CORE and rebuilding the kernel manually,
> either of which results in perfect DVB streaming once more.
> 
> Happy to test any potential patches or otherwise provide further
> information as required.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 804951203aa541ad6720c9726
https://bugzilla.kernel.org/show_bug.cgi?id=218143
#regzbot title platform/x86/intel/pmc: bad performance regression
whereby the TV streams are basically unstable
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
