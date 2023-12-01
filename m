Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DCC8009FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378587AbjLALhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378541AbjLALhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:37:04 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1F3CF;
        Fri,  1 Dec 2023 03:37:10 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r91pU-0007HQ-To; Fri, 01 Dec 2023 12:37:08 +0100
Message-ID: <da0efb19-c883-40c8-b284-7eb7f4d3640b@leemhuis.info>
Date:   Fri, 1 Dec 2023 12:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Thinkpad X13 AMD: Problems with external monitor wake up
 after suspend
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Cc:     Wayne Lin <wayne.lin@amd.com>, Stylon Wang <stylon.wang@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Schmidt <oliver@luced.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <8da256ea-b069-44f0-9cc2-93482c2f5eec@gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <8da256ea-b069-44f0-9cc2-93482c2f5eec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701430630;1fb9bb59;
X-HE-SMSGID: 1r91pU-0007HQ-To
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing stable list and Mario, who submitted this to 6.1.y]

On 01.12.23 01:30, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> Since kernel version 6.1.57 I have problems with external monitor
>> wakeup after suspend on Thinkpad X13 AMD Gen2 Notebook.
>> 
>> Notebook is in docking station with closed lid. Suspend & Resume.
>> The external monitor gets no signal. After randomly typing
>> Ctrl+Alt+Fn for switchung consoles, the monitor at some point gets
>> signal and is usable again.
>> 
>> It worked with kernel 6.1.56.
>> 
>> I managed to compile a 6.1.57 kernel and also a 6.1.64 kernel by
>> reverting the changes from commit ec5fa9 "drm/amd/display: Adjust
>> the MST resume flow"
>> (https://github.com/torvalds/linux/commit/ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a?diff=split&w=1?diff=split&w=1)
>> and with this suspend & resume worked like before without any
>> problems.
> [...]
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218211

We have a small problem here: that error might happen because
ec5fa9fcdeca69 ("drm/amd/display: Adjust the MST resume flow")
[v6.6-rc2] contains a bug or because something it needs was not
backported to 6.1.y.

Maybe one of the developers among the recipients has a idea. Oliver, but
if none of them replies any time soon, it would be best if you'd check
if 6.6 (and/or 6.7-rc) is affected as well; and if reverting it there
fixes it, too.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
