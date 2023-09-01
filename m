Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF23C790103
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348359AbjIAQ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjIAQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:57:44 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5022410F2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:57:41 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 381FPVXt019321;
        Fri, 1 Sep 2023 11:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=KwEEcNXPoNBme8Xe9ZwnezDCtC82awuFHsuTW7TsY+A=; b=
        XQBybDC/lsZf5B830yoNOAiuOdJ0l3BpLZINrzbT0PFF9iIgbwEcJ2gU7+WXEl/A
        HQlRwgMoAnJT0Q+Wje+4ibIgj7I7qFYUGEPnxAYP1TFHnWMgkwSmZZfhaKWpF0ed
        GYWrOvYruyIg1VsCqdDtKL/a1GoqBmym/NA2qzLO1ct9LA1RL/CH6vHrl6Ij94Tu
        g9aMuKaIHl4rPkFnip0qrcRCkV6m30rJ4P7wuoMTtsY7Xx+7sB9HXyIyuQtTa4qy
        UwoxqXynYdgfyTJHFEp7AtaVs6gs3c1TSJL7cmMX+7w8d7/6wwVAxsfn1FNQzEyD
        TbRN31mGRPx3EDmRCztLhA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesygtwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 11:57:04 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 1 Sep
 2023 17:57:02 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Fri, 1 Sep 2023 17:57:01 +0100
Received: from [198.61.65.225] (LONN2DGDQ73.ad.cirrus.com [198.61.65.225])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AF5CA45D;
        Fri,  1 Sep 2023 16:57:01 +0000 (UTC)
Message-ID: <d2e86701-0377-c4ae-2718-efdee5d3677d@opensource.cirrus.com>
Date:   Fri, 1 Sep 2023 17:57:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 00/11] Fix support for System Suspend for CS35L41 HDA
To:     Waldek Andrukiewicz <waldek.social@pm.me>,
        Takashi Iwai <tiwai@suse.de>
CC:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <03a70489-3a68-4c37-8f72-569bcd7463c4@pm.me>
From:   Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <03a70489-3a68-4c37-8f72-569bcd7463c4@pm.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pxOdAidwzg1H4bjjrOAc3cBPFvumGU6s
X-Proofpoint-GUID: pxOdAidwzg1H4bjjrOAc3cBPFvumGU6s
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/09/2023 17:48, Waldek Andrukiewicz wrote:
> On 28.07.23 15:55, Stefan Binding wrote:
>> On 28/07/2023 12:10, Takashi Iwai wrote:
>>> On Mon, 24 Jul 2023 11:00:38 +0200,
>>> Takashi Iwai wrote:
>>>> On Fri, 21 Jul 2023 17:18:05 +0200,
>>>> Stefan Binding wrote:
>>>>> There have been a couple of customer reports of intermittant issues
>>>>> after
>>>>> system resume, where sometimes the DSP firmware stops responding.
>>>>> Investigations into this issue show that there is a race between
>>>>> receiving
>>>>> a prepare from the HDA core, and the firmware reload which is
>>>>> started by
>>>>> the system resume. This can causes the Global Enable on the CS35L41
>>>>> to be
>>>>> enabled during the firmware load, which can sometimes cause issues
>>>>> in the
>>>>> DSP.
>>>>>
>>>>> The existing system resume behaviour also did not resume the audio, if
>>>>> audio was previously playing when it was suspended.
>>>>> In addition, during investigation, it was found there were additional
>>>>> problems in the System Resume sequence, as well as the Playback
>>>>> sequence
>>>>> with External Boost, where the driver does not correctly follow its
>>>>> enable sequence for this mode. This can cause additional issues
>>>>> such as
>>>>> pops and clicks.
>>>>>
>>>>> This chain intends to correct the sequences for playback and system
>>>>> suspend/resume so that the driver: obeys the external boost enable
>>>>> sequence;
>>>>> resumes audio on system resume; and avoids the race condition on
>>>>> firmware
>>>>> load and playback during system resume.
>>>>>
>>>>> Changes since v1:
>>>>> - Split patch 1 into 2 separate patches
>>>>> - Combine Patches 6 and 9
>>>>>
>>>>> Stefan Binding (11):
>>>>>     ALSA: cs35l41: Use mbox command to enable speaker output for
>>>>> external
>>>>>       boost
>>>>>     ALSA: cs35l41: Poll for Power Up/Down rather than waiting a fixed
>>>>>       delay
>>>>>     ALSA: hda: cs35l41: Check mailbox status of pause command after
>>>>>       firmware load
>>>>>     ALSA: hda: cs35l41: Ensure we correctly re-sync regmap before
>>>>> system
>>>>>       suspending.
>>>>>     ALSA: hda: cs35l41: Ensure we pass up any errors during system
>>>>>       suspend.
>>>>>     ALSA: hda: cs35l41: Move Play and Pause into separate functions
>>>>>     ALSA: hda: hda_component: Add pre and post playback hooks to
>>>>>       hda_component
>>>>>     ALSA: hda: cs35l41: Use pre and post playback hooks
>>>>>     ALSA: hda: cs35l41: Rework System Suspend to ensure correct call
>>>>>       separation
>>>>>     ALSA: hda: cs35l41: Add device_link between HDA and cs35l41_hda
>>>>>     ALSA: hda: cs35l41: Ensure amp is only unmuted during playback
>>>> Applied all patches now to for-next branch.
>>> It seems that this patch set causes occasional freeze at suspend:
>>>     https://bugzilla.suse.com/show_bug.cgi?id=1213745
>>>
>>> Could you take a look?
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>> Hi Takashi,
>>
>> The initial bug report shows one of the original issues that this patch
>> chain was trying to fix.
>>  From what I can tell from the second issue, something has caused the
>> CS35L41 to stop responding,
>> which in turn caused the system suspend call to fail, and the error is
>> passed up. Since system suspend
>> failed, there was no corresponding system resume, which means the
>> CS35L41 was stuck broken.
>>
>> I'm not sure what was meant by "freeze" and "overheating" in the bug
>> report, since the log seems to
>> indicate the laptop is still responsive, even if audio is broken.
>>
>> There is some oddity in the log, since one of the errors that was
>> printed should only be printed when
>> the CS35L41 is using External Boost, but I think this laptop is supposed
>> to use Internal Boost.
>> We'll investigate further.
>>
>> Thanks,
>>
>> Stefan Binding
>
> Hello,
>
> I would like to inform you that (one of) those patches is probably
> breaking sound on Lenovo Legion 7 16ACHg6. They were applied in Manjaro
> Linux kernel here:
>
> https://gitlab.manjaro.org/packages/core/linux64/-/commit/742e66f525170fe02dec42e47aedf53d3dc85195
>
> and when I install this kernel, there is no sound anymore. There is
> nothing more than those patches in this commit. A kernel compiled from
> the previous commit works fine.
>
> Sound used to work fine from 5.17 if I remember correctly.
>
> I hope I replied correctly to this thread, if not, apologies.
>
> Best Regards,
>
> Waldek Andrukiewicz
>
>
Hi,

This is a different issue that we have been able to reproduce.
It only affects that particular laptop, and is unrelated to the other issue.
We are currently working on a fix for this.

Thanks,

Stefan

