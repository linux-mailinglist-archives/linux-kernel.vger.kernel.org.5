Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8101770FF7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 15:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjHENhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 09:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHENhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 09:37:35 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B067F3AB2;
        Sat,  5 Aug 2023 06:37:33 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qSHTH-0002eL-Pb; Sat, 05 Aug 2023 15:37:31 +0200
Message-ID: <7d9a6d94-af49-b8f4-cb50-4665cb6ff272@leemhuis.info>
Date:   Sat, 5 Aug 2023 15:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: 6.5 - 6.4.7 Regression : ASUS UM5302TA Keyboard don't work
Content-Language: en-US, de-DE
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Linux Input Devices <linux-input@vger.kernel.org>,
        ACPI Asus <acpi4asus-user@lists.sourceforge.net>,
        Linux x86 Platform Drivers 
        <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Guilhem Lettron <guilhem@lettron.fr>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        August Wikerfors <git@augustwikerfors.se>
References: <bdc6cb4d-a853-72b2-b132-989b64740ad9@gmail.com>
 <8ee87fe1-684f-ad59-21c7-4401a4e70bee@leemhuis.info>
 <b7df9a02-3b81-4f8c-aeba-222c298180d4@augustwikerfors.se>
 <cc9e37b4-b5cb-fd4d-84b8-5b824afe710a@redhat.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <cc9e37b4-b5cb-fd4d-84b8-5b824afe710a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691242653;a1a73d35;
X-HE-SMSGID: 1qSHTH-0002eL-Pb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.23 15:09, Hans de Goede wrote:
> On 8/4/23 17:26, August Wikerfors wrote:
>> On 2023-07-30 06:49, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> Lo!
>>>
>>> On 30.07.23 04:41, Bagas Sanjaya wrote:
>>>>
>>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>>
>>>>> On a kernel 6.4.5 and less, the keyboard is working fine.
>>>>>
>>>>> Beginning with 6.5 rc1 and 6.4.7 any key don't respond.
>>>
>>> That is a AMD Ryzen Laptop. And if that really started from
>>> v6.4.6..v6.4.7 then I guess there is a decent chance that this is caused
>>> by ```ACPI: resource: Remove "Zen" specific match and quirks``` from
>>> Mario. Hence adding him to the list of recipients.
>>
>> Confirmed now, see https://bugzilla.kernel.org/show_bug.cgi?id=217726#c9
>>
>> #regzbot introduced: a9c4a912b7dc7ff922d4b9261160c001558f9755
> 
> We just have received 2 bug reports for Fedora which I believe are also
> this issue (not confirmed yet):
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2229165
> https://bugzilla.redhat.com/show_bug.cgi?id=2229317

Interesting, thx for sharing! I just asked people there to share
dmidecode and acpidump to check if those are different machines.

> I'm going to create a Fedora 6.4.y test-kernel with a9c4a912b7dc7ff
> reverted.
> 
> IMHO we really should revert a9c4a912b7dc7ff upstream,
> at least for the 6.4.y series

That is unlikely to be a option, because as explained in
Documentation/process/handling-regressions.rst Greg's stance in cases
like this usually is "fix it in mainline, and then I'll pick up the fix".

> where it seems to be doing more harm then good.
> 
> And propably also for 6.5-rc# for now until we figure out
> a better solution.

Hmmm, looks like the issue and the fix for one of the machines[1] didn't
make much progress this week, so I tend to agree. Mario?

[1]
https://lore.kernel.org/all/20230728191408.18141-1-mario.limonciello@amd.com/

Ciao, Thorsten
