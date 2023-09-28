Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCE57B11E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjI1FAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjI1FAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:00:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E70136
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:00:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a1bcc540c0so322383566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695877239; x=1696482039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xm1G3DvjTPNMs8CaRtbq59OpemJU/fBRS7beruUP0HQ=;
        b=NpzzH/xQdnwrmmD4j2lZXrM1daKaMWPs4Dn0z8boC/nmYJA0LhBvPXl5OPGQqAqovT
         ycrFsKi9GAr2BPQTz4gC5XxmLjiu9I+mrDqHOLvjVVP/NEQZMpbgzQN6O3DkPd8ckYXj
         EOn12nc5Q5QlpncX4MHjWLgLRjCipdEnVJbA8Zrp6KGermqw2qDx2n7ydVygV7FO3wl0
         PBIrC5fUCZ/Gw6J5mJOm3yoba53TAyLNHNmSOWOUmaFkmOXGD3U8j9MXgwFfqIICnf1c
         dWhO/AQ3/3O/dWlC4m3AW5quwwPzAQNHW9aHRxMwprQV1uVG8eZgVCdz6NljxWB95igZ
         dLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695877239; x=1696482039;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xm1G3DvjTPNMs8CaRtbq59OpemJU/fBRS7beruUP0HQ=;
        b=PvZf7PKdq8GA4BbBDDt7kU+KXoPOHOPL2qrfi1dx5Vd8WzmbButN0vbCmKKiTs0Atw
         RKsIBlSsG93BKVWSSMugRtcr8VgsSXZJaTad4akdrVh13HlkHyPVfG1Iqq5xJ7FlhAya
         ZAHJIOOg++q0vFvHoCH/w5e4/xWO6PP4Mh1Ki5lM2z8keucx0IyPubV/rbFHm/aaE5Lu
         HZbHKHiJBdGx6Zp9UYzX7rw5prmXx5MdZXCQ2hYlZoZCE81fRMiDC73IF9lF5cOaOF+1
         9oqzgsc+J6LdG8cO9Np5TtMvMEwCl5z4oGFELEFFeRMzZCnKgsd45Qei2QFPzmnMHXT/
         6eRw==
X-Gm-Message-State: AOJu0Yw+nfhVG2MH1z2mu8YGVJZYYlFrEdOkQhVCCrnxqOdYQO0snicw
        d3D0mfNUb/jbenjyAICfHEosgiDaAOQ=
X-Google-Smtp-Source: AGHT+IHdYT/Fl1fz6xwU3ypHWI9rdN7yXdYZZ199/9bgje8Iy6Nr0bhkyyvy82y+xy/OcHD+04fS0A==
X-Received: by 2002:a17:906:530b:b0:9ae:4492:df34 with SMTP id h11-20020a170906530b00b009ae4492df34mr143814ejo.6.1695877238888;
        Wed, 27 Sep 2023 22:00:38 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm10233713ejc.153.2023.09.27.22.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 22:00:38 -0700 (PDT)
Message-ID: <2cfa5c9b-f053-5832-4249-950250660339@gmail.com>
Date:   Thu, 28 Sep 2023 07:00:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] staging: rtl8192e: renamed (3) variables
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230928000225.27912-1-garyrookard@fastmail.org>
 <d9a089f9-c439-97bd-5abc-18390c3ec0cb@gmail.com>
In-Reply-To: <d9a089f9-c439-97bd-5abc-18390c3ec0cb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 06:40, Philipp Hortmann wrote:
> On 9/28/23 02:02, Gary Rookard wrote:
>> This patch renames the vaiable in staging/rtl8192e
>> HTUpdateDefaultSetting -> ht_update_default_setting
>> in (3) files of rtl8192e:
>> 1) rtl819x_HTProc.c
>> 2) rtllib.h
>> 3) rtllib_module.c >
>> Linux Kernel Coding Style "cleanup", no change in runtime,
>> staging/rtl8192e builds before and after.
>>
>> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> 
> Hi Gary,
> 
> your subject is to general and also wrong as you change just one 
> variable. Please find good examples in the in the kernel log.
> Or here:
> https://lore.kernel.org/linux-staging/20230921032515.96152-2-tdavies@darkphysics.net/T/#u
> 
> Omit the file names in the description as this is redundant.
> 
> You need a version history for all four versions of your patch.
> See example:
> https://lore.kernel.org/linux-staging/ZQGiqA2GoDp%2FWiPK@ubuntu.myguest.virtualbox.org/T/#u
> 
> Bye Philipp
> 

Hi Gary,

this is not a variable. It is a function name. To keep the namespace 
clean it is required to add a rtllib_ in front of the function name.

Bye Philipp

> 
>> ---
>>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
>>   drivers/staging/rtl8192e/rtllib.h         | 2 +-
>>   drivers/staging/rtl8192e/rtllib_module.c  | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c 
>> b/drivers/staging/rtl8192e/rtl819x_HTProc.c
>> index a7e356e90d0e..832f595d36c2 100644
>> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
>> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
>> @@ -67,7 +67,7 @@ static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
>>   static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
>> -void HTUpdateDefaultSetting(struct rtllib_device *ieee)
>> +void ht_update_default_setting(struct rtllib_device *ieee)
>>   {
>>       struct rt_hi_throughput *ht_info = ieee->ht_info;
>> diff --git a/drivers/staging/rtl8192e/rtllib.h 
>> b/drivers/staging/rtl8192e/rtllib.h
>> index bdbd27e382b9..ec1eef7486a2 100644
>> --- a/drivers/staging/rtl8192e/rtllib.h
>> +++ b/drivers/staging/rtl8192e/rtllib.h
>> @@ -1785,7 +1785,7 @@ int rtllib_wx_get_rts(struct rtllib_device 
>> *ieee, struct iw_request_info *info,
>>   void HTSetConnectBwMode(struct rtllib_device *ieee,
>>               enum ht_channel_width bandwidth,
>>               enum ht_extchnl_offset Offset);
>> -void HTUpdateDefaultSetting(struct rtllib_device *ieee);
>> +void ht_update_default_setting(struct rtllib_device *ieee);
>>   void HTConstructCapabilityElement(struct rtllib_device *ieee,
>>                     u8 *posHTCap, u8 *len,
>>                     u8 isEncrypt, bool bAssoc);
>> diff --git a/drivers/staging/rtl8192e/rtllib_module.c 
>> b/drivers/staging/rtl8192e/rtllib_module.c
>> index abd6bfd4dfa3..859241af617c 100644
>> --- a/drivers/staging/rtl8192e/rtllib_module.c
>> +++ b/drivers/staging/rtl8192e/rtllib_module.c
>> @@ -126,7 +126,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>>       if (!ieee->ht_info)
>>           goto free_softmac;
>> -    HTUpdateDefaultSetting(ieee);
>> +    ht_update_default_setting(ieee);
>>       HTInitializeHTInfo(ieee);
>>       rtllib_ts_init(ieee);
>>       for (i = 0; i < IEEE_IBSS_MAC_HASH_SIZE; i++)
> 

