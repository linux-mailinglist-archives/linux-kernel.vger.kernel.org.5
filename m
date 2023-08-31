Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463C678ECCE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbjHaMK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjHaMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:10:26 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826AFE47;
        Thu, 31 Aug 2023 05:10:23 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qbgVA-0000Zg-WF; Thu, 31 Aug 2023 14:10:21 +0200
Message-ID: <e48a555b-46ec-9f6e-f548-94dbe0577e03@leemhuis.info>
Date:   Thu, 31 Aug 2023 14:10:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: in linux 6.3.7-200.fc38.x86_64 goes vlc in time to switch tv
 channels to zombie-process
Content-Language: en-US, de-DE
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media <linux-media@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>
References: <a7f997fc-e7cc-cf67-3ac0-80ed30346511@gmail.com>
 <cdacb249-9d1d-cad9-44a9-ffa7b4b5b887@leemhuis.info>
 <150a5670-8220-5c2f-351c-181ceeddf307@xs4all.nl>
 <c362089e-8cdb-c735-762f-7a56552b68c2@leemhuis.info>
 <3ca18d1d-c286-183b-10fe-f7e9fc42c41a@xs4all.nl>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <3ca18d1d-c286-183b-10fe-f7e9fc42c41a@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693483823;d121534d;
X-HE-SMSGID: 1qbgVA-0000Zg-WF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.23 13:47, Hans Verkuil wrote:
> On 31/08/2023 13:00, Thorsten Leemhuis wrote:
>> On 31.08.23 12:35, Hans Verkuil wrote:
>>> On 31/08/2023 11:26, Linux regression tracking #update (Thorsten Leemhuis) wrote:
>>>> [TLDR: This mail in primarily relevant for Linux kernel regression
>>>> tracking. See link in footer if these mails annoy you.]
>>>>
>>>> On 19.06.23 02:24, Bagas Sanjaya wrote:
>>>>>
>>>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>>> [...]
>>>>>
>>>>> #regzbot introduced: v6.3.5..v6.3.7 https://bugzilla.kernel.org/show_bug.cgi?id=217566
>>>>> #regzbot title: switching TV channel causes VLC and firmware loading hang
>>>>
>>>> #regzbot fix: 7cfab4c9dc09ca3a9d57c187894055a22bdcd
>>>> #regzbot ignore-activity
>>>>
>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>> --
>>>> Everything you wanna know about Linux kernel regression tracking:
>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>> That page also explains what to do if mails like this annoy you.
>>>
>>> >From what I can gather from the bugzilla report, whatever the issue was appears
>>> to be resolved or at least improved in later kernels.
>>
>> I'm pretty (but not 100%) sure the initial report in that ticket were
>> issues caused by a backport of a patch that was reverted later:
>> https://lore.kernel.org/all/20230609082238.3671398-1-mchehab@kernel.org/
> 
> Ah, you have a better memory than I have. That might well be the culprit.
> I didn't check for changes in the dvb core, I should have done that.
> 
> That patch was introduced in 6.3.7 and reverted in 6.3.9.
> 
> That doesn't quite match the "#regzbot introduced: v6.3.5..v6.3.7" report,
> though. I wonder if fedora backported that problematic patch to their v6.3.5
> release?

Nope, as it matches (I'd say). The reporter never bisected this and just
claimed that 6.3.5 was fine and 6.3.7 was broken (and 6.3.6 iirc was
never tested). In that case we tell regzbot that the culprit is
somewhere in that range (which is was[1]), as that's the important thing
to know in the context of the 6.3.y regression (that it also happened in
mainline is a different story).

Is this too confusing? Would it be better to handle things differently
somehow?

Ciao, Thorsten

[1] $ git rev-list v6.3.5..v6.3.7 --oneline | grep "Fix use-after-free
on race condition at dvb_frontend"
8994830135b3 media: dvb-core: Fix use-after-free on race condition at
dvb_frontend
