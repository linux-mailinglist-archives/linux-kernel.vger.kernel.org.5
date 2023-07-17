Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31761756318
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGQMtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQMtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:49:22 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2259FB1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:49:21 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36HA8gZw025271;
        Mon, 17 Jul 2023 07:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=nmMNFV73wNm/2ZjsT4mSlg2YLZJ1Hz1dydlb4bhlksM=; b=
        aYxUplsb3f2Ejh0CJaBzLuAHRPoVJcA2J8QizG8hNrHqipTTD/PcUFNYyB1dV/uD
        DUJTx8yZy6fl2d9l8IYN7CUaI1Raef1qB7xjzTGjcA+TYnZDruM6NNatxISlPYLN
        xkgqiAPGlEIPI9kHRTwIi0MboUtr8pQjcyZQtV3YTWJnnsImjPQvRiLDWuqX+SL8
        d9BVMK803MMJnwHtU/lYcppI64J1GQGBsPNYNTxR1CKc658lwJcqIzL3g6mmqWZB
        0xwY4GHE1clglKQC52v3MxaZB/LZfBjReFhs7iF6tUNRZsgc0IpMweKVrhlkaLZ/
        QQdRl7OSmM67wEzCbFeOEw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3rus62t1ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 07:48:31 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 17 Jul
 2023 13:48:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Mon, 17 Jul 2023 13:48:29 +0100
Received: from [198.90.251.45] (EDIN6T9W333.ad.cirrus.com [198.90.251.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6902C458;
        Mon, 17 Jul 2023 12:48:29 +0000 (UTC)
Message-ID: <6a5d7b94-4762-5e71-dc39-c9f10ee98c6f@opensource.cirrus.com>
Date:   Mon, 17 Jul 2023 13:48:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] Fix CSC3551 speaker sound problem for machines
 without a valid ACPI _DSD
To:     Takashi Iwai <tiwai@suse.de>, David Xu <xuwd1@hotmail.com>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Andy Chi <andy.chi@canonical.com>,
        Tim Crawford <tcrawford@system76.com>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        =?UTF-8?Q?Kacper_Michaj=c5=82ow?= <kasper93@gmail.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <SY4P282MB18352D4FD343A2E8290EA9BEE037A@SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM>
 <87zg3waunl.wl-tiwai@suse.de>
From:   Stuart Henderson <stuarth@opensource.cirrus.com>
In-Reply-To: <87zg3waunl.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PfznXB3bkg-U3D8PeACQKqOyT2PUsCYN
X-Proofpoint-ORIG-GUID: PfznXB3bkg-U3D8PeACQKqOyT2PUsCYN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/07/2023 13:49, Takashi Iwai wrote:
> On Thu, 13 Jul 2023 18:29:53 +0200,
> David Xu wrote:
>>
>> As the comments added in commit 4d4c4bff4f8ed79d95e05 ("ALSA: hda:
>> cs35l41: Clarify support for CSC3551 without _DSD Properties"), CSC3551
>> requires a valid _DSD to work and the current implementation just
>> fails when no _DSD can be found for CSC3551. However it is a fact
>> that many OEMs hardcoded the configurations needed by CSC3551 into their
>> proprietary software for various 2022 and later laptop models,
>> and this makes the Linux installations on these models cannot make
>> any speaker sound. Meanwhile, at this point of time, we see no hope
>> that these OEMs would ever fix this problem via a BIOS update.
>>
>> To address the problem, this patch series contains two patches:
>>
>> Patch 1 for cs35l41 hda driver: a fixup mechanism is introduced that
>> when the driver found there is no valid _DSD that contains the
>> configurations, a fixup function would try to find a fixup entry that
>> contains a proper cs35l41 configuration from a pre-defined fixup table
>> by matching the CSC3551 ACPI _SUB id. If found, the fixup function
>> would apply the cs35l41 configurations retrived from the entry.
>> In this patch the fixup table only contains some entries for three
>> Lenovo laptop models: namely 16IAH7, 16IAX7 and 16ARHA7. However
>> as is known, several other laptop models from ASUS and HP also suffer
>> from this no valid _DSD problem and could have it addressed with this
>> fixup mechanism when proper fixup entries are inserted.
>>
>>
>> Patch 2 for realtek hda driver: add quirks for Lenovo 16IAH7, 16IAX7
>> and 16ARHA7 so that cs35l41 playback hook could be registered. Please
>> note that for these quirks to work patch 1 has to be applied.
> Thanks for the patches.
>
> I've seen the lots of pains with CS35L41 codec stuff on the recent
> machines.  But, first of all, it still needs to be agreed by Cirrus
> people whether this approach is acceptable.  Judging from the current
> situation, such workaround appears inevitable, but we need a
> consensus.
>
> So, Cirrus people, please check this.
>
>
> Also, some ideas about the current patch set:
>
> - Do we need yet another listing and check of each ID in another
>    place?  The existing entry in the SSID quirk table is already unique
>    enough to identify which configuration is taken, I suppose.
>
> - The quirk entries can be gathered in patch_realtek.c, and the hw_cfg
>    and other items are overwritten in cs35l41_no_acpi_dsd() when no
>    _DSD is found.  In that way, we can avoid fixing two places for each
>    update.
>
> - The workaround is a workaround, and it's fundamentally dangerous.
>    We should warn it in a kernel message.
>
>
> Takashi

Hi David, Takashi,
We're looking into supporting some of these older devices at the moment, 
and have a patch chain in development at the moment.
The approach we've taken is a lot closer to the one taken by the github 
Luke links through to elsewhere in this chain, which we think might be a 
cleaner approach.  We do have concerns about the current approach of 
identifying the SPI device though, as we've seen "spi1" become "spi2" as 
additional devices become supported in the kernel and more SPI 
controllers come into use.  We'll look into this more and hopefully get 
a patch chain up in the coming weeks.
This patch chain looks like it might also be missing support for 
different boost configurations.
I wouldn't recommend this patch be merged.
Thanks,
Stu

