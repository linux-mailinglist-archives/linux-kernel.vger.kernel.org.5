Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F5F7F43D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjKVK1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbjKVK1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:27:22 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F24198
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:27:18 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r5kRm-0005zh-7d; Wed, 22 Nov 2023 11:27:06 +0100
Message-ID: <5124589d-81b9-42ae-a4af-d16590477b66@leemhuis.info>
Date:   Wed, 22 Nov 2023 11:27:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops support
 for acp pci driver"
To:     syed saba kareem <ssabakar@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Marian Postevca <posteuca@mutex.one>,
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
 <6085d2e3-f28e-4d1d-9863-8275931430e6@amd.com>
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <6085d2e3-f28e-4d1d-9863-8275931430e6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700648838;c63cc4cd;
X-HE-SMSGID: 1r5kRm-0005zh-7d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.23 10:32, syed saba kareem wrote:
> On 11/22/23 14:25, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 03.11.23 14:30, syed saba kareem wrote:
>>> On 11/3/23 04:41, Bagas Sanjaya wrote:
>>>> On Thu, Aug 03, 2023 at 10:22:07PM +0300, Marian Postevca wrote:
>>> [...]
>>>>> Some help here would be welcome. Is there something missing in my
>>>>> machine driver code, or
>>>>> is the runtime pm handling in acp pci driver wrong?
>>> We were working on some other priority tasks, will upstream the changes
>>>
>>> by next week.
>> Hi syed saba kareem! Did that happen? From here it looks like it did
>> not, so I assume the regression was not yet addressed. But it's easy to
>> miss something, hence this mail.
> 
> Hi , We have up streamed the patch it is in review.
> Please find the below link for the patch details.
> https://patchwork.kernel.org/project/alsa-devel/patch/20231113123345.2196504-2-Syed.SabaKareem@amd.com/

Ahh, great. Has to Fixes: tag and no Link:/Closes: tag to this thread,
otherwise I would have noticed that change myself, but whatever.

Thx!

#regzbot monitor:
https://lore.kernel.org/all/20231113123345.2196504-2-Syed.SabaKareem@amd.com/
#regzbot fix: ASoC: amd: acp: add pm ops support for renoir platform
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
