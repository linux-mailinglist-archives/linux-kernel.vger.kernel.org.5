Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F3D7F44AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343849AbjKVLEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbjKVLEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:04:43 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97390D8;
        Wed, 22 Nov 2023 03:04:39 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AM7JoId001441;
        Wed, 22 Nov 2023 05:04:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=121+3MVz3eMpEMpVEtJbEi4kTmMcYLW1eMvklU6Z7ds=; b=
        UNbxEmkwDn6ji65dxLuZm//weuAaU157F8H78EHVCnuULbTRrfj10t4WPOa6mKOu
        ReCFECP2l5Zz0dPWItyMi7eAeAuscVn+Sh9/vHHqvsGrG8R1cqBNRfsIgFFFHFU+
        6LnMoe+i+uTiVnyuVt81KkNb/r8yauuaUCk9RKFy1mdma5LnOhT09bKXoOlmuBYl
        9U4t73jIBC9mLUxjLCWHokVEpsR175mzvtdS3nUYUAGgIzvwdjzScBMmKOj/9lOL
        ErU/7P8MWOzqhHS/7SbTdoZOBkAHgjmL3AUQSMP2Bm+YdWvgd+Lb/9Z/zx19roUU
        5IInGHbrnBX1/zIOxFoPEQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ueuj2cbu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 05:04:30 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 22 Nov
 2023 11:04:28 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Wed, 22 Nov 2023 11:04:28 +0000
Received: from [198.61.65.98] (EDIN4L06LR3.ad.cirrus.com [198.61.65.98])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C7D7A458;
        Wed, 22 Nov 2023 11:04:27 +0000 (UTC)
Message-ID: <1528da8b-4ca3-4f12-be17-a3222039fa20@opensource.cirrus.com>
Date:   Wed, 22 Nov 2023 11:04:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: cs35l56: Enable low-power hibernation mode on
 SPI
To:     Takashi Iwai <tiwai@suse.de>
CC:     <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20231121154419.19435-1-rf@opensource.cirrus.com>
 <87h6lealos.wl-tiwai@suse.de>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <87h6lealos.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rWo-Y9C1_vdAV05ubqd49_-IO5aAZzMQ
X-Proofpoint-GUID: rWo-Y9C1_vdAV05ubqd49_-IO5aAZzMQ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/23 20:36, Takashi Iwai wrote:
> On Tue, 21 Nov 2023 16:44:19 +0100,
> Richard Fitzgerald wrote:
>>
>> SPI hibernation is now supported with the latest hibernation/wake
>> sequences in the shared ASoC code.
>>
>> This has a functional dependency on two commits:
>>
>> commit 3df761bdbc8b ("ASoC: cs35l56: Wake transactions need to be issued
>> twice")
>>
>> commit a47cf4dac7dc ("ASoC: cs35l56: Change hibernate sequence to use
>> allow auto hibernate")
>>
>> To protect against this, enabling hibernation is conditional on
>> CS35L56_WAKE_HOLD_TIME_US being defined, which indicates that the new
>> hibernation sequences are available.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> Is this expected to be merged for 6.7?  Or it can be post 6.7?
> I guess the former, but just to make sure.
>

It would be good to get it into 6.7 because it reduces the power
consumption in runtime-suspend and suspend-to-RAM. But it's not
critical (it's not a bugfix).

> 
> thanks,
> 
> Takashi

