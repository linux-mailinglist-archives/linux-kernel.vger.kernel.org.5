Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A058055FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442151AbjLENce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345403AbjLENcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:32:33 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3321B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:32:39 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1rAVXK-0005dK-0Y; Tue, 05 Dec 2023 14:32:30 +0100
Message-ID: <670a7310-8098-4083-9f30-96987cc5d0aa@leemhuis.info>
Date:   Tue, 5 Dec 2023 14:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops support
 for acp pci driver"
Content-Language: en-US, de-DE
To:     syed saba kareem <ssabakar@amd.com>,
        Marian Postevca <posteuca@mutex.one>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <87a5v8szhc.fsf@mutex.one> <ZUQssoD2rUHSYQ2v@debian.me>
 <610d562f-0bbc-485c-ad63-9534fa4ba937@amd.com>
 <d002ad6f-d908-4cf6-afcf-bf0989418e72@leemhuis.info>
 <6085d2e3-f28e-4d1d-9863-8275931430e6@amd.com> <87fs0x4fn7.fsf@mutex.one>
 <ac9d4f7b-c7af-4d21-b0b8-d0f188b94b0f@amd.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ac9d4f7b-c7af-4d21-b0b8-d0f188b94b0f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701783159;92328950;
X-HE-SMSGID: 1rAVXK-0005dK-0Y
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.23 14:58, syed saba kareem wrote:
> 
> On 11/23/23 03:25, Marian Postevca wrote:
>> syed saba kareem <ssabakar@amd.com> writes:
>>
>>> Hi , We have up streamed the patch it is in review.
>>>
>>> Please find the below link for the patch details.
>>>
>>> https://patchwork.kernel.org/project/alsa-devel/patch/20231113123345.2196504-2-Syed.SabaKareem@amd.com/
>>>
>> Sorry maybe I'm not understanding here something, when you are saying
>> that the patch is in review, where is this review being done?
>>
>> As far as I can tell Mark Brown only pulled the first patch from your
>> series:
> 
> We got comments for the second patch and we addressed them.
> 
> It seems it may be stuck at review stage as one patch got merged.
> 
> Will resend the patch again.
> 
> You can find the received review comments for the patch in the below link.

Any news? From a quick look it seems this didn't make any progress at
all, but I might be missing something.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>>> Applied to
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>>> for-next
>>>
>>> Thanks!
>>>
>>> [1/2] ASoC: amd: acp: add Kconfig options for acp7.0 based platform
>>> driver
>>>        commit: d3534684ada99ef8c0899eb28c62b4462483ee19
>>> [2/2] ASoC: amd: acp: add pm ops support for renoir platform
>>>        (no commit info)
>>>
>> I don't see the second patch in for-next.
> 
> 
