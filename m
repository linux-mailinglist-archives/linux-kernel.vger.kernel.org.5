Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89AA77A6AD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjHMOBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHMOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:01:33 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B37F9D;
        Sun, 13 Aug 2023 07:01:36 -0700 (PDT)
Received: from p200300cf17418700333267be2b9ea1d1.dip0.t-ipconnect.de ([2003:cf:1741:8700:3332:67be:2b9e:a1d1]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qVBew-0004K3-Nm; Sun, 13 Aug 2023 16:01:34 +0200
Message-ID: <e884f944-a933-2a9c-49f1-86dbe463d18f@leemhuis.info>
Date:   Sun, 13 Aug 2023 16:01:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] IRQ override revert breaks keyboard on Lenovo Yoga 7
 14ARB7
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     regressions@lists.linux.dev
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <596b9c4a-fb83-a8ab-3a44-6052d83fa546@augustwikerfors.se>
 <73310d78-914b-7200-0fb7-073b52324aaf@leemhuis.info>
In-Reply-To: <73310d78-914b-7200-0fb7-073b52324aaf@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691935296;358eec36;
X-HE-SMSGID: 1qVBew-0004K3-Nm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.07.23 18:53, Linux regression tracking #update (Thorsten Leemhuis)
wrote:
> On 27.07.23 00:54, August Wikerfors wrote:
>>
>> Since v6.5-rc1 the keyboard on this laptop no longer works. This problem
>> also existed before v6.0-rc1 commit 9946e39fe8d0 ("ACPI: resource: skip
>> IRQ override on AMD Zen platforms"), so I suspected the cause to be
>> a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
>> which reverted that commit. Reverting a9c4a912b7dc confirmed this theory.
>>
>> #regzbot introduced: a9c4a912b7dc
> 
> Point regzbot to the fix:
> 
> #regzbot monitor:
> https://lore.kernel.org/linux-acpi/20230728183921.17230-1-mario.limonciello@amd.com/
> #regzbot fix: ACPI: resource: Add a quirk for Lenovo Yoga 7 14ARB7
> #regzbot ignore-activity

Things changed:

#regzbot ignore-activity
#regzbot fix: 9728ac221160c5ea111879125a7694bb81364

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

#regzbot ignore-activity
