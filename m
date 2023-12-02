Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE218801AF4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 07:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjLBGHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 01:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBGHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 01:07:50 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57E01A6;
        Fri,  1 Dec 2023 22:07:56 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r9JAL-0004CP-41; Sat, 02 Dec 2023 07:07:49 +0100
Message-ID: <af62295b-b757-49ec-83ce-9d3ef93e24af@leemhuis.info>
Date:   Sat, 2 Dec 2023 07:07:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: iwlwifi: rfkill locking up kernel 6.5.12, 6.6.2
Content-Language: en-US, de-DE
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Eliad Peller <eliad@wizery.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Linus Lotz <register+kernelbugzilla@lotz.li>,
        Darrell Enns <darrell@darrellenns.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>
References: <5ef14fe7-84a5-407f-b514-1527f7279ecd@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <5ef14fe7-84a5-407f-b514-1527f7279ecd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701497276;b17a3993;
X-HE-SMSGID: 1r9JAL-0004CP-41
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 30.11.23 09:23, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> Rfkilling the iwlwifi can lock up my machine, rfkill will not
>> respond and other networking related things (e.g. ip a or ip r) I
>> see this on 6.5.12 and 6.6.2 (fedora kernel). On 6.5.11 it does not
>> lockup AFAICT, but also shows kernel oops. WiFi Hardware: AC 8265
> 
> [...]
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218206

TWIMC: More people that seem to be affected by the same problem joined
the report. And one user performed a bisection on 6.6.y. According to
that the problem is caused by a 6.6.y-backport of 37fb29bd1f90f1 ("wifi:
iwlwifi: pcie: synchronize IRQs before NAPI") [v6.7-rc1] from Johannes.

Another reported user also stated that the same problem happens on
6.7-rc3 as well. No confirmation yet that 37fb29bd1f90f1 causes it
there, but it seems likely.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: Due to the above I'll wrt to regression tracking for now assume
that 37fb29bd1f90f1 causes the problem.

#regzbot introduced: 37fb29bd1f90f1




