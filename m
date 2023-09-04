Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC57916B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352887AbjIDMAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352881AbjIDMAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:00:53 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A645DCD3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:00:49 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3846MTdr025299;
        Mon, 4 Sep 2023 07:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=xktY9esea8iLpj8prmL3lc/OChXQqmpWC/2D/wVnM/c=; b=
        SIj2RYqrZTVgbx5bTsNQFKuuKpW9LwcjfL3FgVmc6Z3KaXIiw52gIzzp90wd2BtV
        sjVS8S7O2f+ldgWAhyFWbuZhohmvLK1ADZFh7XHNPa1c9NIQjAmzuPwDpTLoilVM
        0n4ccbUoqYREXBH/kfTUfkaOX7pqax568NIj+BFWcaGCvwrf5fSlUvwFamZ5kudL
        MDdUljSJ+5zHO+VzlFdxGDx/NfRS+LVR+NhtWkZJ4JkIakP8CwdOwLzKbO79vyff
        f6dHOwLAZjGbKVsBWtllHijx9gbfnUdkfjzqodhWf1h36Y7+AObAOLJGvSKIZi+x
        ZI5EhKOgAO6s/Kbll42c/w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sv2ex29ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 07:00:22 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 4 Sep
 2023 13:00:20 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Mon, 4 Sep 2023 13:00:20 +0100
Received: from [198.61.65.243] (LONN2DGDQ73.ad.cirrus.com [198.61.65.243])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3CF75B06;
        Mon,  4 Sep 2023 12:00:20 +0000 (UTC)
Message-ID: <71808adb-bf54-a34b-5a63-70d454e3d426@opensource.cirrus.com>
Date:   Mon, 4 Sep 2023 13:00:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] ALSA: hda: cs35l41: Support mute notifications for
 CS35L41 HDA
To:     Takashi Iwai <tiwai@suse.de>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
References: <20230825120525.1337417-1-sbinding@opensource.cirrus.com>
 <87edjr7218.wl-tiwai@suse.de>
 <32a62c2f-5000-132c-255c-8ccd135ba60f@opensource.cirrus.com>
 <87h6oisz9c.wl-tiwai@suse.de>
From:   Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <87h6oisz9c.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gVL-CyIEc5wk9PdN0VBZnQmTLAM-GyS7
X-Proofpoint-GUID: gVL-CyIEc5wk9PdN0VBZnQmTLAM-GyS7
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/08/2023 15:23, Takashi Iwai wrote:
> On Tue, 29 Aug 2023 16:18:12 +0200,
> Stefan Binding wrote:
>>
>> On 25/08/2023 13:13, Takashi Iwai wrote:
>>> On Fri, 25 Aug 2023 14:05:25 +0200,
>>> Stefan Binding wrote:
>>>> From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
>>>>
>>>> Some laptops require a hardware based mute system, where when a hotkey
>>>> is pressed, it forces the amp to be muted.
>>>>
>>>> For CS35L41, when the hotkey is pressed, an acpi notification is sent
>>>> to the CS35L41 Device Node. The driver needs to handle this notification
>>>> and call a _DSM function to retrieve the mute state.
>>>>
>>>> Since the amp is only muted during playback, the driver will only mute
>>>> or unmute if playback is occurring, otherwise it will save the mute
>>>> state for when playback starts.
>>>>
>>>> Only one handler can be registered for the acpi notification, but all
>>>> amps need to receive that notification, we can register a single handler
>>>> inside the Realtek HDA driver, so that it can then notify through the
>>>> component framework.
>>>>
>>>> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
>>>> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
>>> We don't do normally in this way.  The ACPI hot key handling is done
>>> via user-space, and user-space daemon triggers the mute of the
>>> system.
>>>
>>> Can't the ACPI notify the key event on those machines?
>> This feature is not the "normal" mute button on a keyboard, it is a
>> custom request
>> from a manufacturer which only mutes the audio on the speakers.
>> On previous generations, this was achieved using a GPIO controlled by
>> the BIOS/EC.
>> However, since CS35L41 does not have such GPIO, we must control it by
>> other means.
>>
>> Our solution, which we have to share with the Windows driver, it to use ACPI
>> notifications to tell the driver to mute the amps when the shortcut is
>> pressed.
>>
>> Does this seem like a valid exception to the typical approach?
> It's still the question whether we have to do this inevitably in the
> kernel in a way like that.  It sounds quite unusual.  Why this must be
> handled directly?  IOW, what's the difference from the "normal" mute
> button?
>
> And, even if we take this approach, it leaves the device muted without
> exposing it to user-space.  Then user wouldn't know what happens.
>
>
> thanks,
>
> Takashi
We spoke to the ODM for this system to get a more detailed explanation 
of this feature.
The keyboard shortcut enables something called "Unobtrusive Mode". 
According to their explanation:

- Unobtrusive mode is distinct to normal mute, as it only mutes the speakers
- There is no requirement to update the volume controls, as the screen 
backlight will be off anyway in this mode
- All other unobtrusive mode functions are enabled without user-space 
dependencies, and they would prefer not to make speaker mute an exception

Thanks,

Stefan

