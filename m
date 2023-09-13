Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7210C79E221
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbjIMIa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbjIMIa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:30:57 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AE710E6;
        Wed, 13 Sep 2023 01:30:52 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so105524371fa.3;
        Wed, 13 Sep 2023 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694593851; x=1695198651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26teksENA+dQQO6m1YUj6nkAa9mPqWw8dabp0DqJ9V8=;
        b=lRVAqpX2pEVukg52DaBFEtyaloNDsgRhYLYkhft1IP8dy+d0/913W0w8UP7omj0dfd
         a89+TKNwY1pwjSE+JJKoNGi3utEWit9OPTDDImLix9SPSrLCqLtNA1V2kpNXACImYhSp
         FY93RLLfgg5pZli/hikLVUu/YC3TQYklRRAI+95AjJlAA7NerR5QjfRkPveuKwGNIbBG
         TBUMo9S0U9a/IPGAF72rTNitV/26keZuFC6Ml1gisDw2kr1K9gjQV2+phst8UZhqz+kM
         RqzP4zKq/QJO/CFsRFW2Djv1jFuQ8PBUeS23bpsxaP8FS9DuDzb+TzINg76Tkj2Yt8HY
         QioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593851; x=1695198651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26teksENA+dQQO6m1YUj6nkAa9mPqWw8dabp0DqJ9V8=;
        b=jvHl5sEW57SxAPuLhvPNpPdUa8w87IHGHTuEaTEMiNXvxmTVLwYBiGTCU1cktCb4J9
         B86l6Y0pPYE6NDC9xwUbhZuXVcVQoZU2KZ2FpecznjuByYjpaf/hCC49t5mmoU89zqb+
         OKzQUh3aRrsw+LLlcuhJxF5VJ3CMikL7fXSPRlTSWd0eB1RQL3p2V1p7IxuitXWTM/x3
         mqQ1uBp3DqjjJ/ckCI2ulpOyDTHXtRusUg7ZvJzan1boaqdwHUy/wCaOUJa5zrgQcbjv
         TpUPhtSNoqypNhVFKuccNAikpu39On/84tvNzQrpBeHDYS2yuEp3PifCy0T2ywMSSevZ
         v4PQ==
X-Gm-Message-State: AOJu0YznlABLd3HPQkJJqIY5JziO9UJ76iAC/FV7e098aBGRUao0RUba
        O7VAi+Fswe4Gkz/ZuiEcFSQ=
X-Google-Smtp-Source: AGHT+IH2/KxD8HRd+/8D+6uqgFhSyd8oI5b2Jvm/JVpo0uqkvk9+3wNdGqJvpbQmoSGuz0Cu9iLiSg==
X-Received: by 2002:a2e:9f4e:0:b0:2bc:b75e:b88 with SMTP id v14-20020a2e9f4e000000b002bcb75e0b88mr2019335ljk.18.1694593850754;
        Wed, 13 Sep 2023 01:30:50 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bcb8a000000b003fed7fa6c00sm1341375wmi.7.2023.09.13.01.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:30:50 -0700 (PDT)
Message-ID: <82b4b49a-1893-ea4d-3856-693a7824e939@gmail.com>
Date:   Wed, 13 Sep 2023 10:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/9] dma-heap: Provide accessors so that in-kernel drivers
 can allocate dmabufs from specific heaps
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        "jstultz@google.com" <jstultz@google.com>
Cc:     "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        =?UTF-8?B?S3VvaG9uZyBXYW5nICjnjovlnIvptLsp?= 
        <kuohong.wang@mediatek.com>,
        "Brian.Starkey@arm.com" <Brian.Starkey@arm.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
References: <20230911023038.30649-1-yong.wu@mediatek.com>
 <20230911023038.30649-4-yong.wu@mediatek.com>
 <803846bc-fd1d-d2ec-2855-456af22c82f8@amd.com>
 <CANDhNCrQyiFZ+8DnG0iyKBXC0H1698K1a9d2AxOq4whDsZBn+Q@mail.gmail.com>
 <23e71d1f-08c1-3834-5b1f-2b5714c7bfaa@gmail.com>
 <255ae6b9ac1b6bea9262069747824b8461475e70.camel@mediatek.com>
 <95797f3d-65bf-1bd9-9e19-6de42605cfe3@gmail.com>
 <8140975aa1f5c3cbdfa2e6f42aecebe3701f29da.camel@ndufresne.ca>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <8140975aa1f5c3cbdfa2e6f42aecebe3701f29da.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.09.23 um 16:58 schrieb Nicolas Dufresne:
> Le mardi 12 septembre 2023 à 16:46 +0200, Christian König a écrit :
>> Am 12.09.23 um 10:52 schrieb Yong Wu (吴勇):
>>> [SNIP]
>>>> But what we should try to avoid is that newly merged drivers provide
>>>> both a driver specific UAPI and DMA-heaps. The justification that
>>>> this
>>>> makes it easier to transit userspace to the new UAPI doesn't really
>>>> count.
>>>>
>>>> That would be adding UAPI already with a plan to deprecate it and
>>>> that
>>>> is most likely not helpful considering that UAPI must be supported
>>>> forever as soon as it is upstream.
>>> Sorry, I didn't understand this. I think we have not change the UAPI.
>>> Which code are you referring to?
>> Well, what do you need this for if not a new UAPI?
>>
>> My assumption here is that you need to export the DMA-heap allocation
>> function so that you can server an UAPI in your new driver. Or what else
>> is that good for?
>>
>> As far as I understand you try to upstream your new vcodec driver. So
>> while this change here seems to be a good idea to clean up existing
>> drivers it doesn't look like a good idea for a newly created driver.
> MTK VCODEC has been upstream for quite some time now. The other patchset is
> trying to add secure decoding/encoding support to that existing upstream driver.
>
> Regarding the uAPI, it seems that this addition to dmabuf heap internal API is
> exactly the opposite. By making heaps available to drivers, modification to the
> V4L2 uAPI is being reduced to adding "SECURE_MODE" + "SECURE_HEAP_ID" controls
> (this is not debated yet has an approach). The heaps is being used internally in
> replacement to every allocation, user visible or not.

Thanks a lot for that explanation, I was really wondering what the use 
case for this is if it's not to serve new UAPI.

In this case I don't see any reason why we shouldn't do it. It's indeed 
much cleaner.

Christian.

>
> Nicolas
>
>> Regards,
>> Christian.
>>
>>>>> So I think this patch is a little confusing in this series, as I
>>>> don't
>>>>> see much of it actually being used here (though forgive me if I'm
>>>>> missing it).
>>>>>
>>>>> Instead, It seems it get used in a separate patch series here:
>>>>>      
>>>> https://lore.kernel.org/all/20230911125936.10648-1-yunfei.dong@mediatek.com/
>>>>
>>>> Please try to avoid stuff like that it is really confusing and eats
>>>> reviewers time.
>>> My fault, I thought dma-buf and media belonged to the different tree,
>>> so I send them separately. The cover letter just said "The consumers of
>>> the new heap and new interface are our codecs and DRM, which will be
>>> sent upstream soon", and there was no vcodec link at that time.
>>>
>>> In the next version, we will put the first three patches into the
>>> vcodec patchset.
>>>
>>> Thanks.
>>>

