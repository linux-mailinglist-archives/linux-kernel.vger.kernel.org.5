Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D812C7EBCD8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 06:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjKOFuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 00:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOFuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 00:50:35 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5A6D8;
        Tue, 14 Nov 2023 21:50:31 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r38nD-0004Iu-Md; Wed, 15 Nov 2023 06:50:27 +0100
Message-ID: <0f97acf9-012d-4bb2-a766-0c2737e32b2c@leemhuis.info>
Date:   Wed, 15 Nov 2023 06:50:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sr-iov related bonding regression (two regressions in one report)
Content-Language: en-US, de-DE
To:     Jay Vosburgh <jay.vosburgh@canonical.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andy Gospodarek <andy@greyhouse.net>,
        Ivan Vecera <ivecera@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Anil Choudhary <anilchabba@gmail.com>
References: <986716ed-f898-4a02-a8f6-94f85b355a05@gmail.com>
 <32716.1700009673@famine>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <32716.1700009673@famine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700027432;16248afe;
X-HE-SMSGID: 1r38nD-0004Iu-Md
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.23 01:54, Jay Vosburgh wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
>> I come across LACP bonding regression on Bugzilla [1].

Side note: Stephen forwards some (all?) network regressions to the right
people:
https://lore.kernel.org/all/20231113083746.5e02f8b0@hermes.local/

Would be best to check for that, no need to forward things twice, that
just results in a mess.

>> The reporter
>> (Cc'ed) has two regressions. The first is actual LACP bonding
>> regression (but terse):
>>
>>> Till linkx kernel 6.5.7 it is working fine, but after upgrading to 6.6.1 ping stop working with LACP bonding.
>>> When we disable SR-IOV from bios , everything working fine

Makes me wonder if things have been working with or without the OOT
module on 6.5.7, as strictly speaking it's only considered a kernel
regression if thing worked with a vanilla kernel (e.g. without OOT
modules) beforehand and broke when switching to a newer vanilla kernel.
If that's the case it would be okay to add to regzbot.

>> And the second is out-of-tree module FTBFS:
> [... skip OOT stuff ...]
> 
>> Should I add the first regression to regzbot (since the second one
>> is obviously out-of-tree problem), or should I asked detailed regression
>> info to the reporter?
> 
> 	My vote is to get additional information.  Given the nature of
> the workaround ("When we disable SR-IOV from bios , everything working
> fine"), it's plausible that the underlying cause is something
> platform-specific.

Maybe, but when it comes to the "no regressions" rule that likely makes
no difference from Linus perspective.

But I guess unless the intel folks or someone else has an idea what
might be wrong here we likely need a bisection (with vanilla kernels of
course) to get anywhere.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
