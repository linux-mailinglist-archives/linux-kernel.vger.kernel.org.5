Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C387DC0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjJ3Tih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjJ3Tif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:38:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15DDDB;
        Mon, 30 Oct 2023 12:38:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so7482019a12.1;
        Mon, 30 Oct 2023 12:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694711; x=1699299511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDlCveOzfrtYuSzhJicUknBESAxGt/aXJl0pyL4TPSI=;
        b=KptD38l25NleTb5xbOtu1ng1sR4bJxOjBk21ppubGPVkLRsFFWRQtZ6lNSXc0KYl/v
         kAcETberWTCVlAa0uP/JRPZlrMf7RjSqLybWo7suLJcRRDkC+pS/EItWtzznlYXrylel
         sKSm9Kr/ZXvj9ug2SKoC8wypXWQ6Pq4wTpiihNa1Ssgj8ZG4mDwXvIDpBU8TzS00kHQF
         415wbIAELwkievDNrg1XoJ2S7Huwq0Ta9MqKNWPCOk8s8y9ibI791QpPYD51gbnU1YnS
         Ykbw79h83no/5Zjg3jWY+ZH1E0j8kfHwoVMDTkj9qwBYIlQ5311M8VC2Qn7V9v4Z6+Gt
         85Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694711; x=1699299511;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDlCveOzfrtYuSzhJicUknBESAxGt/aXJl0pyL4TPSI=;
        b=FtteJsV9TCxqzKWujTB1ALTwaD7fHlGDbs8JlegoGzpyEl9m3mYGsHMjZJ9Wg7qgTq
         Z/o2mr/ZTuEBshVNnylIA4vgHDjBCvov7Y76mNkcRKrbF4AUDyNcsVDLz6ZgMzVUZ/Qa
         RGw66yCw1mYfdRTfvxqt2VSrR/zIxTsSfwod+oginvrkcQkrpiqli2k+Hs6HOKvsSINE
         tj8dKK6/JB5iwoouN+2CYOTIzkVkx+fWcVYNZrMwmzKxI5OP3JTQGRtF6KHcFC6rZ4Zx
         MwEfMs0WE3PcuPMtrjYQA/FpuHhEfFJJqjBKEMqZTHJxf4Fx+/5QtWt3WgAY2A/JE4/z
         +zzA==
X-Gm-Message-State: AOJu0YyPNhivr/1WnP9iyI0PKXV2avfyTK+j5nwbJdjrGHKQa+tUdptx
        qQjmEOoIpdkb7d/rfjA/WOs=
X-Google-Smtp-Source: AGHT+IGLbtw6rlrMWPU9BL6guP43c3VsuX1B5+KyM08H+eiqimKmKRTPi8stOq8pUaaKCLepZUDlkQ==
X-Received: by 2002:a50:fb82:0:b0:540:346c:7b2f with SMTP id e2-20020a50fb82000000b00540346c7b2fmr7520057edq.40.1698694710923;
        Mon, 30 Oct 2023 12:38:30 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc31:8900:c490:292e:2164:5dcb? (dynamic-2a01-0c23-bc31-8900-c490-292e-2164-5dcb.c23.pool.telefonica.de. [2a01:c23:bc31:8900:c490:292e:2164:5dcb])
        by smtp.googlemail.com with ESMTPSA id a12-20020aa7d74c000000b0053dd8898f75sm6467989eds.81.2023.10.30.12.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 12:38:30 -0700 (PDT)
Message-ID: <cd23aed9-a792-4baa-ba1a-701e6512ce30@gmail.com>
Date:   Mon, 30 Oct 2023 20:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: r8169: Disable multicast filter for
 RTL_GIGA_MAC_VER_46
To:     Patrick Thompson <ptf@google.com>
Cc:     netdev@vger.kernel.org, Chun-Hao Lin <hau@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        nic_swsd@realtek.com
References: <20231027213059.3550747-1-ptf@google.com>
 <415e0355-7d71-4b82-b4fc-37dad22486a9@gmail.com>
 <CAJs+hrEi8oo1q5mMfNbaUi8x1H-sBGmYToTkRfVXs=ga9LPupQ@mail.gmail.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CAJs+hrEi8oo1q5mMfNbaUi8x1H-sBGmYToTkRfVXs=ga9LPupQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.2023 17:52, Patrick Thompson wrote:
> I wouldn't trust the mc filter, the eap packet being filtered is not a
> multicast packet so I wonder what else could be erroneously filtered.
> I do agree that it would be nice to be able to override it for testing
> purposes.
> 

I'm not an EAP(OL) expert, just read that EAPOL can use unicast,
broadcast , and ethernet multicast (01:80:C2:00:00:03).
What's that target MAC and IP4 address of the packet being
filtered out in your case?

> Would you like me to add MAC_VER_48 to the patch? I would not be able
> to test and confirm that it affects it in the same way I have for
> VER_46.
> 
Yes, VER_48 should be included because it has the same MAC as VER_46.

> It is unfortunate that the naming doesn't quite line up.
> 
> On Sat, Oct 28, 2023 at 4:38 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 27.10.2023 23:30, Patrick Thompson wrote:
>>> MAC_VER_46 ethernet adapters fail to detect eapol packets unless
>>> allmulti is enabled. Add exception for VER_46 in the same way VER_35
>>> has an exception.
>>>
>> MAC_VER_48 (RTL8107E) has the same MAC, just a different PHY.
>> So I would expect that the same quirk is needed for MAC_VER_48.
>>
>> MAC_VER_xx is a little misleading, actually it should be NIC_VER_xx
>>
>>> Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
>>> Signed-off-by: Patrick Thompson <ptf@google.com>
>>> ---
>>>
>>> Changes in v2:
>>> - add Fixes tag
>>> - add net annotation
>>> - update description
>>>
>>>  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 361b90007148b..a775090650e3a 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -2584,7 +2584,8 @@ static void rtl_set_rx_mode(struct net_device *dev)
>>>               rx_mode |= AcceptAllPhys;
>>>       } else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
>>>                  dev->flags & IFF_ALLMULTI ||
>>> -                tp->mac_version == RTL_GIGA_MAC_VER_35) {
>>> +                tp->mac_version == RTL_GIGA_MAC_VER_35 ||
>>> +                tp->mac_version == RTL_GIGA_MAC_VER_46) {
>>>               /* accept all multicasts */
>>>       } else if (netdev_mc_empty(dev)) {
>>>               rx_mode &= ~AcceptMulticast;
>>

