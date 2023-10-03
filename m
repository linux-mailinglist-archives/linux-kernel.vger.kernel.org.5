Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D007B6CA1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbjJCPHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjJCPHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:07:09 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3952CA1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:07:03 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 393Aj2Ak011385;
        Tue, 3 Oct 2023 10:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=DqYfrVUY9VaYs8HHfvryu5P4ymwHpqGgKtcasalbNEs=; b=
        e8KNv0uQljlURyiPTt8Dmtpb5p/U4XLXgPB9oJJOr9xpMfzZOejL7iOKKV73Igzo
        jjDk1CMhbedGVNxc+unkygA/UEVcuiCY0xowbWyFuYeHYVQOpdpl/w2YuW0+ofUE
        M9R4UU/wJtpA3+n67xpSPWlgsIis3P1gMEpLaURkTPI+eADbvZA9gwVFyeFoSzqL
        Pt0khCbKpw21pts1VvzcReGq/j8BG9n14vg1N0rMcf8vCTPFJNUUqiVFl0WHFKAD
        oforAeaINuP/5LJiAMUe6Izk8vLpMi5/1OlM53L38i47UGmgbZIz03rXRM3lgWQC
        Wt0x9rsZwe4WfdjTOCTXxw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tghfn0dk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 10:06:48 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 3 Oct
 2023 16:06:46 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 3 Oct 2023 16:06:46 +0100
Received: from [198.61.65.185] (LONN2DGDQ73.ad.cirrus.com [198.61.65.185])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 09AF411AC;
        Tue,  3 Oct 2023 15:06:46 +0000 (UTC)
Message-ID: <3f3e554a-6551-e384-313d-77edf8ae316c@opensource.cirrus.com>
Date:   Tue, 3 Oct 2023 16:06:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ALSA: hda: cs35l41: Support ASUS 2023 laptops with
 missing DSD
To:     Luke Jones <luke@ljones.dev>
CC:     'Takashi Iwai' <tiwai@suse.de>, <tiwai@suse.com>,
        <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <rf@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        'Jonathan LoBue' <jlobue10@gmail.com>,
        <patches@opensource.cirrus.com>
References: <20230823011008.13146-1-luke@ljones.dev>
 <87v8d6cm30.wl-tiwai@suse.de> <R32UZR.6AQKQL1J6UQI3@ljones.dev>
 <87lee2ciqj.wl-tiwai@suse.de> <NN3UZR.VNYA824H66Q8@ljones.dev>
 <87il96cfnb.wl-tiwai@suse.de>
 <000601d9d5b0$8d6817f0$a83847d0$@opensource.cirrus.com>
 <UB2VZR.B7HP6HUMGFA03@ljones.dev> <8OJY1S.X7HJ24U4D5AG2@ljones.dev>
From:   Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <8OJY1S.X7HJ24U4D5AG2@ljones.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: k6ACHBl9D6Kwh0tEi5LNM-rfZcG9tApl
X-Proofpoint-GUID: k6ACHBl9D6Kwh0tEi5LNM-rfZcG9tApl
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/10/2023 15:45, Luke Jones wrote:
>
>
> On Thu, Aug 24 2023 at 08:31:06 AM +12:00:00, Luke Jones 
> <luke@ljones.dev> wrote:
>>
>>>
>>> The second member variable in cs35l41_prop_model_table is the SSID to
>>> match against.
>>> The Lenovo laptops in the initial patch didn't have different SSIDs so
>>> the entry was set to NULL for those.
>>> Future entries using CSC3551 MUST always have an accompanying SSID
>>> with this entry.
>>> Takashi was correct, the implementation is intended to also be used to
>>> patch incorrect DSD.
>>>
>>> We have a potential solution to workaround the SPI cs-gpios issue
>>> inside here,
>>> though the drawback for that is that it only works for laptops with 2
>>> SPI amps.
>>
>> Can you provide me this so I can test? I have laptops with SPI 2 and 
>> 4 speaker setups.
>
> Hi Stefan,
>
> Do you have any further information about the status of this in 
> regards to the 2023 laptops?

Hi,

We are currently working on adding support for 2023 ASUS laptops without 
_DSD.

>
>>
>>> I also took a look at the function for applying DSD properties for the
>>> 2023 ROG laptops.
>>> Unfortunately the one-size-fits-all approach will not work, some of
>>> these laptops are i2c
>>> and some are SPI, meaning the GPIO indexes are different for different
>>> laptops.
>>
>> Do you mean "spk-id-gpios"? For all the laptops I know of this seems 
>> to be
>> Package () { "spk-id-gpios", Package () {
>>    SPK1, 0x02, Zero, Zero,
>>    SPK1, 0x02, Zero, Zero
>> } },
>>
>> There is one laptop where it is One not 0x02 (the GA402N)
>>
>>> Some of the laptops do no have Speaker IDs.
>>> Also, no laptop other than the 2 I added already should ever use
>>> CS35L41_EXT_BOOST_NO_VSPK_SWITCH (in fact I believe all these laptops
>>> are internal
>>> boost anyway).
>>
>> Grazie.
>>
>>>
>>> We are currently working internally on adding support for the 2023 ROG
>>> laptops, so we
>>> ask for you guys to hold off on trying to upstream support for these
>>> laptops.
>>
>> Ah great. Thank you. I apologise for trying to rush things, but I do 
>> have a discord server of over 4000 people, many of whom have laptops 
>> with cirrus amps.
>>
>> For now I'm including a patch in my kernel builds with this mapping:
>>
>> const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
>>     { "CLSA0100", NULL, lenovo_legion_no_acpi },
>>     { "CLSA0101", NULL, lenovo_legion_no_acpi },
>>     { "CSC3551", "10431433", asus_rog_2023_no_acpi }, // ASUS GS650P 
>> - i2c
>>     { "CSC3551", "10431463", asus_rog_2023_no_acpi }, // ASUS GA402X 
>> - i2c
>>     { "CSC3551", "10431473", asus_rog_2023_no_acpi }, // ASUS GU604V 
>> - spi
>>     { "CSC3551", "10431483", asus_rog_2023_no_acpi }, // ASUS GU603V 
>> - spi
>>     { "CSC3551", "10431493", asus_rog_2023_no_acpi }, // ASUS GV601V 
>> - spi
>>     { "CSC3551", "10431573", asus_rog_2023_no_acpi }, // ASUS GZ301V 
>> - spi
>>     { "CSC3551", "104317F3", asus_rog_2023_no_acpi }, // ASUS ROG 
>> ALLY - i2c
>>     { "CSC3551", "10431B93", asus_rog_2023_no_acpi }, // ASUS G614J - 
>> spi
>>     { "CSC3551", "10431CAF", asus_rog_2023_no_acpi }, // ASUS G634J - 
>> spi
>>     { "CSC3551", "10431C9F", asus_rog_2023_no_acpi }, // ASUS G614JI 
>> -spi
>>     { "CSC3551", "10431D1F", asus_rog_2023_no_acpi }, // ASUS G713P - 
>> i2c
>>     { "CSC3551", "10431F1F", asus_rog_2023_no_acpi }, // ASUS H7604JV 
>> - spi
>>     {}
>> };
>>
>> These are the machines I have verified the gpios and such for.
>
> I have a new version of this patch with all listed models confirmed as 
> working, and with slightly different settings for some. The only thing 
> missing in a solution to the gpio-cs issue.
>
> Can you please provide an update on where you are with ASUS support in 
> particular so that I may consider if it is worth my time submitting 
> the updated patch.
We would prefer for you to wait, as we are looking to push up this 
support in the coming weeks.
>
>>
>> Cheers,
>> Luke.
>>
>>
>
>
