Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5759A81304D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573085AbjLNMjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573055AbjLNMjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:39:17 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B66115;
        Thu, 14 Dec 2023 04:39:24 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b9e7f4a0d7so5547925b6e.1;
        Thu, 14 Dec 2023 04:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702557563; x=1703162363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2CpqYu2Yz1Ozrx0CUYVWM6SPUKyooHq2Zq4S2qE3CE=;
        b=SNU1xSFpBtsbK2qHGzt+aVA05B5PnOOzezdmdppw5jRgQkH+nFyxApDu8bZDpYY8sI
         TJiD1QvkNX7XsKAETBe/f6DqP16GBpn/b7iI4ttYc11INORgbctDJZI0l6jRBjsOwDY4
         oISYR+yrfrmKg0agj5a4qiMuQh6KJQfi1BR0tjdDyFzdgvFFhDCxhUq4kCVpTr39dgNp
         JwAuGvQRstIUflZMb9HHDUeUTCW1jSY0RcvgOZQ2zC7Mp7qvVscK2IqzPl+i99jRf4Qh
         P/lNrQHNtiGFYu6JzQXGhDKCaOukf/9+nNRFiSWF2BrY2lQ4lUWg/idi9tMzCH5gCSIb
         FgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557563; x=1703162363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2CpqYu2Yz1Ozrx0CUYVWM6SPUKyooHq2Zq4S2qE3CE=;
        b=LAaS7wDLy+7oFuW176qlHm9ecju7XKlwk/OvBK+BVauF0ouhU200WxsF4pAPtIuyxe
         8hW9U50QQVYUPgynJJOmUIuzTGlyfSZ6MjurPBYNbXojC2MwT2s4b1rz/XYg0tI55zuW
         ctCGDmx2Rd2qW0Fx8r1bfVvfSpbgVSHuASi0TgR//ddODbxVLDoPY68VSuS6CMOpOpM5
         TjtZNA4bM1K7hjh9KD2JHpge2A9pGme8CFF0wVAxCPOgAQMeGXvMy3vZ+dyHObyzrrrU
         THfmXMKVAQgPYWBUHoEvdRFIWYLPmfA8C9Su1Sj/n9S/G0NjOaRVNOYJ7/QCjfFj9FSK
         oHHA==
X-Gm-Message-State: AOJu0YwNAhN0QrZNDdXWy9oJzn2glYmGflyjv4I0iG09ZMWTpOI7lDFc
        LLx63G1fsm45CBB+ju0PoHg=
X-Google-Smtp-Source: AGHT+IGPMLwm24ar1acxnS3uJOwx1vCUvY364Zwt7fHWyytA0SrFUbX3usGL3teXpIfhBy+VQwBCpw==
X-Received: by 2002:a05:6808:bc7:b0:3b8:b063:5048 with SMTP id o7-20020a0568080bc700b003b8b0635048mr11757906oik.73.1702557563334;
        Thu, 14 Dec 2023 04:39:23 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id or15-20020a05620a618f00b0077da7a46b0fsm5250357qkn.69.2023.12.14.04.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 04:39:23 -0800 (PST)
Message-ID: <e0fbe9cb-22de-462f-9123-14a220d5a9c6@gmail.com>
Date:   Thu, 14 Dec 2023 04:39:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mt76: mt7921: Disable powersaving by default
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Ben Greear <greearb@candelatech.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        "open list:MEDIATEK MT76 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
References: <20231212090852.162787-1-mario.limonciello@amd.com>
 <874jgmnud8.fsf@kernel.org> <ZXmxD1foASMaCDIe@lore-desk>
 <d92c081e-47dd-5c57-a6f1-bd72b2748141@candelatech.com>
 <1ef12773-74ca-489c-b36b-d3cf7da22c43@amd.com>
Content-Language: en-US
From:   James Prestwood <prestwoj@gmail.com>
In-Reply-To: <1ef12773-74ca-489c-b36b-d3cf7da22c43@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/23 11:27, Mario Limonciello wrote:
> On 12/13/2023 08:45, Ben Greear wrote:
>> On 12/13/23 5:26 AM, Lorenzo Bianconi wrote:
>>>> Mario Limonciello <mario.limonciello@amd.com> writes:
>>>>
>>>>> Several users have reported awful latency when powersaving is enabled
>>>>> with certain access point combinations.
>>>>
>>>> What APs are these exactly? In the past 802.11 Power Save Mode was
>>>> challenging due to badly behaving APs. But nowadays with so many 
>>>> mobile
>>>> devices in the market I would assume that APs work a lot better. It
>>>> would be best to investigate the issues in detail and try to fix 
>>>> them in
>>>> mt76, assuming the bugs are in mt76 driver or firmware.
>>>>
>>>>> It's also reported that the powersaving feature doesn't provide an
>>>>> ample enough savings to justify being enabled by default with these
>>>>> issues.
>>>>
>>>> Any numbers or how was this concluded?
>>>>
>>>>> Introduce a module parameter that would control the power saving
>>>>> behavior.  Set it to default as disabled. This mirrors what some 
>>>>> other
>>>>> WLAN drivers like iwlwifi do.
>>>>
>>>> We have already several ways to control 802.11 power save mode:
>>>>
>>>> * NL80211_CMD_SET_POWER_SAVE (for example used by 'iw set power_save')
>>>>
>>>> * CONFIG_CFG80211_DEFAULT_PS (for kernel level default)
>>>>
>>>> * WIPHY_FLAG_PS_ON_BY_DEFAULT (for the driver to control the 
>>>> default setting)
>>>>
>>>> Adding module parameters as a fourth method sounds confusing so not
>>>> really a fan of this. And the bar is quite high for adding new module
>>>> parameters anyway.
>>>
>>> agree, I think we do not need a new parameter for this, just use the 
>>> current
>>> APIs.
>>
>> Is there a convenient way for a user to make any of those options 
>> above stick through
>> reboots?
>>
>> To me, the ability to set system defaults through reboots is a nice 
>> feature of
>> module options.
>>
>> Thanks,
>> Ben
>>
>
> Some userspace has the ability to do this.  For example in Network 
> Manager:
>
> https://unix.stackexchange.com/questions/595116/wi-fi-powersaving-in-networkmanager 
>

And recently added to IWD for this very reason, there are no decent ways 
to persist between reboots (except when using NM).

https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=29edb1626d88bb713db71f7b374d8f24832fd94f

Thanks,

James

