Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB117B1BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjI1MLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1MLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:11:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13B711F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:11:06 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qlprE-0007pQ-IG; Thu, 28 Sep 2023 14:11:04 +0200
Message-ID: <e8388057-9a85-45c6-902e-de1a13bc88d8@leemhuis.info>
Date:   Thu, 28 Sep 2023 14:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: what to do on magically fixed case? (was Fwd: Kernel 6.6-rc1
 fails to reboot or shutdown Ryzen 5825U)
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <2bc62c07-2195-e378-c057-f28e8d4a6034@gmail.com>
 <ZRVgAzNLhk90nAwX@debian.me>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ZRVgAzNLhk90nAwX@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695903066;5f1d7698;
X-HE-SMSGID: 1qlprE-0007pQ-IG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.23 13:14, Bagas Sanjaya wrote:
> [addressing to Thorsten]
> 
> On Thu, Sep 14, 2023 at 02:03:00PM +0700, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>> The Kernel stalls at boot very long with a drm-amdgpu message, but fails to restart or shutdown with secure boot enabled or not. Magic key works to exit. Nothing wrong in the Kernel 6.5 cycle.
>>
>> Later, the reporter (Cc'ed) described the regression:
>>
>>> Let me be clearer, it does not shutdown at all: magic key for shut down has no effect (o or b). The keyboard is dead. Plus, $ shutdown -r now hangs too. Restart works when using Alt+PrtSc+b. Same when booting stalls for long.
>>>
>>> We started bisecting with 20230903 daily kernel, the bug was there. 6.6-rc1 has been removed. Take good note that next boot log after shutdown may or may not be the same log. Plus, booting requires now and then magic key to restart, because the Kernel hangs.  In this case, we must click enter twice + Esc to boot in desktop. 
>
> [...]
>
>> See Bugzilla for the full thread and links to complete journalctl log.
>>
>> Anyway, I'm adding this regression to regzbot:
>>
>> #regzbot introduced: v6.5..v6.6 https://bugzilla.kernel.org/show_bug.cgi?id=217905
>> #regzbot title: shutdown/reboot hang on Ryzen 5825U (stuck on amdgpu initialization)
> 
> On Bugzilla, the reporter said that this regression was fixed in linux-next
> tree without specifying the exact commit that do it. He also did not bisect
> as I asked, nor even culprit commit range. Should I mark this regression as 
> fixed?

You ideally might want to ask the report to maybe test -rc4 on Monday,
as the fix by then should have made it to mainline if it was in next a
fwe days ago. If rc4 doesn't fix the problem it might motivate the
reporter to check which patch helps in next, so we could ensure that
it's backported.

But if the reporter isn't motivated there is nothing much we can do
(expect asking the maintainer what commit might need to be mainlined to
fix this; but for a complex subsystem like this I guess that's not worth
the trouble, as I guess the maintainer is unlikely to know).

Hence let's mark this as resolved in regzbot and better spend
everybody's time elsewhere:

#regzbot resolved: fixed in -next according to reporter (and hopefully
in mainline, too)

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
