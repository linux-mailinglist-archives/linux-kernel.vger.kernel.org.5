Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6D079D3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbjILOqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjILOqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:46:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF87115;
        Tue, 12 Sep 2023 07:46:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so64904565e9.2;
        Tue, 12 Sep 2023 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694529993; x=1695134793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8sFu0+D3E77YJ4z9rbydrUcmzYi8cL1xr3GzlsZe4w=;
        b=ETyPkG12J1anB4ZBgBf5EYsrYqG109YBS2map2UV8rkE6kplKy4hS+NPQuPEDYmPSL
         AhSzZHqfytMV6h4BAkfl8LxzxU7QuditBKzokS/jy1wbdqeQ4i2fpXHS/wOx9Ttcwzi2
         6F1Xh4FNaBEvfZkMYSyLpAyL9sn9RQNcE5Mcze0alGpi1sg5dZkYSVlwoQ0hs3/xWMoK
         4rryuFiQGpFny/RDdNf+vFb4v2NvldNai9Z3grN/AI4Qq+EgpPXMnxO8Be+uS1QvJOhO
         VOJkDNwnjOZPnfAtfj1kb0ncQ+afCP4PtA56v5H9fkZyoqc8i5TWG+EusDodprXqD9Q9
         gG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694529993; x=1695134793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8sFu0+D3E77YJ4z9rbydrUcmzYi8cL1xr3GzlsZe4w=;
        b=l8+fRH1ChLV7nu2AouB3IzBWZk7VnVQu5USWoZRs8oFI1ILJMXI6MQQaas4tyqel15
         2pcJEKRxxaP4Zq/XKKbBgG7rYnydjd1S3D5HqpW1FGvCdBgFKr85eaZ4y7Cg00JGWMMb
         BbiIdGoRADNwjH/KDNyyuz3KBNYoRkjDhmFmIq/Ip73ZgcL80mwpY2lxt5fCJt7Xf2x2
         NXajazz6S97VYR8rLlaHj5Da9uroztzkPH2OiWZbKOknWaiahtPThQ7zSfZRBj5VblhI
         A+RMgCpdJvweK9v19JH8toyxT4JfwCaWyNm/Kh42E667qGGdcoZAbUDtDO9x5UJPQLyf
         vQNA==
X-Gm-Message-State: AOJu0Yxks9++aDSs1s0VJgkwa/9uukxeh9NNUBnYcgy7kvJgDLg0vJVi
        +7uUQVko0o9sEgccs9kqLcI=
X-Google-Smtp-Source: AGHT+IGHXQb8saBAd6H+9uYnotfhWfZV5PqBMgupUePv5+BNFjR2MQXXacKt9iDypQAL5TYLBL9epA==
X-Received: by 2002:a05:600c:3b1e:b0:402:f536:41c5 with SMTP id m30-20020a05600c3b1e00b00402f53641c5mr10911758wms.3.1694529992631;
        Tue, 12 Sep 2023 07:46:32 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id t15-20020a7bc3cf000000b00402be2666bcsm16448614wmj.6.2023.09.12.07.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 07:46:32 -0700 (PDT)
Message-ID: <95797f3d-65bf-1bd9-9e19-6de42605cfe3@gmail.com>
Date:   Tue, 12 Sep 2023 16:46:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/9] dma-heap: Provide accessors so that in-kernel drivers
 can allocate dmabufs from specific heaps
Content-Language: en-US
To:     =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <255ae6b9ac1b6bea9262069747824b8461475e70.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.09.23 um 10:52 schrieb Yong Wu (吴勇):
> [SNIP]
>> But what we should try to avoid is that newly merged drivers provide
>> both a driver specific UAPI and DMA-heaps. The justification that
>> this
>> makes it easier to transit userspace to the new UAPI doesn't really
>> count.
>>
>> That would be adding UAPI already with a plan to deprecate it and
>> that
>> is most likely not helpful considering that UAPI must be supported
>> forever as soon as it is upstream.
> Sorry, I didn't understand this. I think we have not change the UAPI.
> Which code are you referring to?

Well, what do you need this for if not a new UAPI?

My assumption here is that you need to export the DMA-heap allocation 
function so that you can server an UAPI in your new driver. Or what else 
is that good for?

As far as I understand you try to upstream your new vcodec driver. So 
while this change here seems to be a good idea to clean up existing 
drivers it doesn't look like a good idea for a newly created driver.

Regards,
Christian.

>>> So I think this patch is a little confusing in this series, as I
>> don't
>>> see much of it actually being used here (though forgive me if I'm
>>> missing it).
>>>
>>> Instead, It seems it get used in a separate patch series here:
>>>     
>> https://lore.kernel.org/all/20230911125936.10648-1-yunfei.dong@mediatek.com/
>>
>> Please try to avoid stuff like that it is really confusing and eats
>> reviewers time.
> My fault, I thought dma-buf and media belonged to the different tree,
> so I send them separately. The cover letter just said "The consumers of
> the new heap and new interface are our codecs and DRM, which will be
> sent upstream soon", and there was no vcodec link at that time.
>
> In the next version, we will put the first three patches into the
> vcodec patchset.
>
> Thanks.
>

