Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A72C7F3277
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjKUPio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjKUPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:25:36 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B89B122;
        Tue, 21 Nov 2023 07:25:32 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r5Sd0-00060V-Ud; Tue, 21 Nov 2023 16:25:30 +0100
Message-ID: <f7d315b1-f43d-4573-81f0-a4014f3ac0bb@leemhuis.info>
Date:   Tue, 21 Nov 2023 16:25:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: dwc3: regression in USB DWC3 driver in kernel 5.15 branch
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Tomasz Rostanski <tomasz.rostanski@thalesgroup.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sasha Levin <sashal@kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <bfee63a3-16ee-0061-94c0-9c9af5318634@gmail.com>
 <635eb180-0dea-4dc7-a092-be453bf80023@leemhuis.info>
In-Reply-To: <635eb180-0dea-4dc7-a092-be453bf80023@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700580332;f09828cc;
X-HE-SMSGID: 1r5Sd0-00060V-Ud
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Top-posting for once, to make this easily accessible to everyone.

To Greg and everyone that might care: apparently Tomasz lost interest in
fixing this 5.15.y regression. Kinda sad, as the patches are mostly
there, but lack a S-o-b tag -- which means we are stuck here, unless
somebody else attempts a backport.

https://lore.kernel.org/all/20230904071432.32309-1-tomasz.rostanski@thalesgroup.com/

I'll thus stop tracking this regression.

#regzbot inconclusive: unfixed afaic, as patches to fix this got stuck
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

On 01.11.23 19:59, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 15.07.23 13:03, Bagas Sanjaya wrote:
>> I notice a stable-specific regression on Bugzilla [1]. Quoting from it:
>>> The backport commit to 5.15 branch:
>>> 9d4f84a15f9c9727bc07f59d9dafc89e65aadb34 "arm64: dts: imx8mp: Add snps,gfladj-refclk-lpm-sel quirk to USB nodes"  (from upstream commit 5c3d5ecf48ab06c709c012bf1e8f0c91e1fcd7ad)
>>> switched from "snps,dis-u2-freeclk-exists-quirk" to "snps,gfladj-refclk-lpm-sel-quirk".
>>> [...]
>>> When the commit is reverted the USB 3.x drives works fine.
>>
>> See Bugzilla for the full thread and attach dmesgs.
>>
>> Anyway, I'm adding it to regzbot:
>>
>> #regzbot introduced: 9d4f84a15f9c97 https://bugzilla.kernel.org/show_bug.cgi?id=217670
>> #regzbot title: regression in USB DWC3 driver due to missing gfladj-refclk-lpm-sel-quirk quirk
>>
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217670
> 
> Tomasz, it looks like you were really close at resolving this regression
> when you submitted the required patches for the 5.15.y branch a few
> weeks ago:
> https://lore.kernel.org/all/2023090417-silk-parting-36d8@gregkh/
> 
> What happened? Did you loose interest? Did you not understand what Greg
> asked for? Do you need help?
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke
