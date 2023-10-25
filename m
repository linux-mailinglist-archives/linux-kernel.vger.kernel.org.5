Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCCD7D6210
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjJYHDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjJYHDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:03:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391D7CE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:03:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9b9faf05f51so762535266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698217389; x=1698822189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHpuJC4KgncbTnsWB4mHH6PpjZeiPTQ6BhQqKXvyuiA=;
        b=i3kK1bGZd/EOxsySRjPe/AvJ6kctzL/DhTKGdlU8C9v2A6IvMqsxqcDg3a9xnMUIBo
         f7SDArdW4pAuAu1eZX8nyOtnfNWquwbPC64qJbtj9gKbSwuwZrYu3/Kmu9zDC0hQlriQ
         3CusiiOTSkSlSKXuVdPk7V4VSHq2PJYFldqviUq5oZjy3waog/QGhw9dH/HLuKthaT2x
         wHyag8wuHLVktHE7rwxbNgykJ5g+feEANEvSJN84QUUmOyUyCBaD4kwP1pYMFL/bTKuz
         ENIgJC79VGPMYXUIMrV53sqHZMIpFYzZY2cZpQlTpghYUh5DF56DqPJCrdd2tcYrnG/H
         AWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698217389; x=1698822189;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHpuJC4KgncbTnsWB4mHH6PpjZeiPTQ6BhQqKXvyuiA=;
        b=srL+75A7uKpXaYTbc7zFXZ1AqvRQWbgdvq4HxvOkRMBG/QDKfnubc350lFSiYrRgug
         MZwp3pE5tPgB3AoW65qRNW5cpBYQ3JBxwBOP+XBlLTYzWebC1L7ejJm4aHkNefXuYp7D
         wj4oyJm8Ljw7BLorpEKDM3B3x8D2mUvM/mpRteWnng2tJiTwed0jmh91GS3btDY7eS/c
         KQQrikWV9ju7fBgzm95HEfBxHMlmPaYj3ICfwvMk5QfzAh8DYZbJFaOdYn72GhkDACQT
         MsvWDJzVPsd8zPz18c+SBXj6VPLM0U9nlUvX3ofhoT3l4hVQqGAXM7Ky5/wyenjjf8Jv
         nvMw==
X-Gm-Message-State: AOJu0YwQXejqF5ISKKqzueE42KpNnrVjHL9TIYMfaK6D2TtKn3UIKtOg
        oxbkWrC0CuIT5/20lUdhIx7zRA==
X-Google-Smtp-Source: AGHT+IFUxATVYWFN3qO7Bliy7ziR/WMZTEq4tllbr3spD1f1gG3joZOBgiVTFreXZQChyPhT4sTruw==
X-Received: by 2002:a17:907:ea7:b0:9b2:8c37:eb2b with SMTP id ho39-20020a1709070ea700b009b28c37eb2bmr10991861ejc.58.1698217389658;
        Wed, 25 Oct 2023 00:03:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709065a9400b009786c8249d6sm9576921ejq.175.2023.10.25.00.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 00:03:09 -0700 (PDT)
Message-ID: <1ecf2bb2-6f3e-41e1-b01d-988f0a9f2846@linaro.org>
Date:   Wed, 25 Oct 2023 09:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: gce: mt8195: Add
 CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
Content-Language: en-US
To:     =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?UTF-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?UTF-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
 <20231023043751.17114-2-jason-jh.lin@mediatek.com>
 <d93ff8f4-984a-4a20-9b81-5c088baf12e8@linaro.org>
 <53d8f44f485cbcd45a1910418dc0049909371682.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <53d8f44f485cbcd45a1910418dc0049909371682.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 08:26, Jason-JH Lin (林睿祥) wrote:
> Hi Krzysztof,
> 
> Thanks for the reviews.
> 
> On Mon, 2023-10-23 at 09:47 +0200, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 23/10/2023 06:37, Jason-JH.Lin wrote:
>>> CMDQ_SYNC_TOKEN_SECURE_THR_EOF is used as secure irq to notify CMDQ
>>> driver in the normal world that GCE secure thread has completed a
>> task
>>> in thee secure world.
>>
>> s/thee/the/
>>
>>>
>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>>> ---
>>
>> This is a new patch, so you must mention it in the changelog. There
>> is
>> nothing in the changelog saying about this new patch.
>>
>>
>>>  include/dt-bindings/gce/mt8195-gce.h | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/include/dt-bindings/gce/mt8195-gce.h b/include/dt-
>> bindings/gce/mt8195-gce.h
>>> index dcfb302b8a5b..9f99da3363b9 100644
>>> --- a/include/dt-bindings/gce/mt8195-gce.h
>>> +++ b/include/dt-bindings/gce/mt8195-gce.h
>>> @@ -809,4 +809,10 @@
>>>  /* end of hw event */
>>>  #define CMDQ_MAX_HW_EVENT1019
>>>  
>>> +/*
>>> + * Notify normal CMDQ there are some secure task done,
>>> + * this token sync with secure world.
>>> + */
>>> +#define CMDQ_SYNC_TOKEN_SECURE_THR_EOF980
>>
>> Why is this below 1019? Your driver calls it also even, so is this an
>> event or not?
>>
>> Your driver does not use this value, so does it mean FW uses it?
> 
> I just want to separate this kind of event (sw token) from the HW
> event. So I define it after CMDQ_MAX_HW_EVENT.

SW event? Then why is it in the bindings?

Best regards,
Krzysztof

