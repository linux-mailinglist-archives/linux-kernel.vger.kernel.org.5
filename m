Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68107DE63E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 20:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344881AbjKAS7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbjKAS7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:59:39 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9113D124;
        Wed,  1 Nov 2023 11:59:32 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qyGR3-0006uz-32; Wed, 01 Nov 2023 19:59:25 +0100
Message-ID: <635eb180-0dea-4dc7-a092-be453bf80023@leemhuis.info>
Date:   Wed, 1 Nov 2023 19:59:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: dwc3: regression in USB DWC3 driver in kernel 5.15 branch
Content-Language: en-US, de-DE
To:     Tomasz Rostanski <tomasz.rostanski@thalesgroup.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
References: <bfee63a3-16ee-0061-94c0-9c9af5318634@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <bfee63a3-16ee-0061-94c0-9c9af5318634@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698865172;c25a29ef;
X-HE-SMSGID: 1qyGR3-0006uz-32
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.23 13:03, Bagas Sanjaya wrote:
> 
> I notice a stable-specific regression on Bugzilla [1]. Quoting from it:
> 
>> The backport commit to 5.15 branch:
>> 9d4f84a15f9c9727bc07f59d9dafc89e65aadb34 "arm64: dts: imx8mp: Add snps,gfladj-refclk-lpm-sel quirk to USB nodes"  (from upstream commit 5c3d5ecf48ab06c709c012bf1e8f0c91e1fcd7ad)
>> switched from "snps,dis-u2-freeclk-exists-quirk" to "snps,gfladj-refclk-lpm-sel-quirk".
>> [...]
>> When the commit is reverted the USB 3.x drives works fine.
> 
> See Bugzilla for the full thread and attach dmesgs.
> 
> Anyway, I'm adding it to regzbot:
> 
> #regzbot introduced: 9d4f84a15f9c97 https://bugzilla.kernel.org/show_bug.cgi?id=217670
> #regzbot title: regression in USB DWC3 driver due to missing gfladj-refclk-lpm-sel-quirk quirk
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217670

Tomasz, it looks like you were really close at resolving this regression
when you submitted the required patches for the 5.15.y branch a few
weeks ago:
https://lore.kernel.org/all/2023090417-silk-parting-36d8@gregkh/

What happened? Did you loose interest? Did you not understand what Greg
asked for? Do you need help?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
