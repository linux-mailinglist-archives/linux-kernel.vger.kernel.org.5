Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1905D79C9EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjILI2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjILI2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:28:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EF310D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:28:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso679692566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694507318; x=1695112118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLzVKDkkOXZ4N+LBDosJ9GVpBHoDNwCkMSqFqUtTQYE=;
        b=k05Fut8SZZhfOZCGrJWS67uS2Ds6FSAe1pKxHRv9IGa8WWE7+vjNRy96xwFzcSI9cS
         csEXgGvDDMc8h7DFXcjPczudApzEv9LfpBKAVEYLHpzAOYLVYGVt1hqGG57xVc+RlJsu
         mswPiXPpvysGAKELdoVPZwzKZMSJu8eo6j99QH1/gtqAEvJMEBWehRhBG44cquXikjxg
         9avinRHgS/KxTuXpsic4OhwEc+Gc4CbwD1KLBMYIzG1g0QiuZcEV4soWpSVsnvmcU9qg
         O+gTmOCsTa3w8s5EA8SaxLVd+XiqcA2XPTkDFcfecFKKxuL/59PMLffu+6NzPqed7Edl
         pyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694507318; x=1695112118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLzVKDkkOXZ4N+LBDosJ9GVpBHoDNwCkMSqFqUtTQYE=;
        b=Zy84IkC92F6cMEnGh0BNL112ps0XdHxPpcevCExIscZN1bXzwBoqHmtIZv6vz/5vyo
         sOYHu27qxljhzq0SSshCmo1ubZZVqpTNJyjGICiszbgvMDsR0kNMw81Efk2J46/9ob+z
         q2vWcJnt98b5BcHCTiHZken9HpsnKjaCoG70izfuUu8rl0/BcmwpuFo+3Cl1DA7KPejX
         V93XbIs7+PqAxJwFcjPvSGZcoclfDoXZA8OaVdwgq38ZmLWN8vdHqlq3mPugxkfkiQBN
         MhSuO4vEo+x/SqiLQZqfHQseKaQLRr4J0XKHCQVbapSJD1QQe1wv/LE+B/xHRhYLLtbZ
         bGNw==
X-Gm-Message-State: AOJu0YwI6OEmxlsoADXytJ3YsusZ6jjJp08uWBhJqZTeTIwx4G4SMAdc
        RKtDXAPFRAUgs0G9NCt2zO8WCQ==
X-Google-Smtp-Source: AGHT+IHki0HI2dzDOWH07bBWQQqpwLHYoRHu3OffIZhdj/Y17PLOWS/fEeXHSa+TXIl8iuit84dkTA==
X-Received: by 2002:a17:907:2ccb:b0:9a9:ee3d:48e3 with SMTP id hg11-20020a1709072ccb00b009a9ee3d48e3mr9692911ejc.12.1694507318462;
        Tue, 12 Sep 2023 01:28:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906a09200b0099b8234a9fesm6507600ejy.1.2023.09.12.01.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 01:28:37 -0700 (PDT)
Message-ID: <c62a7ed8-d80a-3a82-040a-d4c74a71285a@linaro.org>
Date:   Tue, 12 Sep 2023 10:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 8/9] dt-bindings: reserved-memory: MediaTek: Add reserved
 memory for SVP
Content-Language: en-US
To:     =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        "robh@kernel.org" <robh@kernel.org>
Cc:     "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jstultz@google.com" <jstultz@google.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
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
 <20230911023038.30649-9-yong.wu@mediatek.com>
 <20230911154448.GA1279317-robh@kernel.org>
 <c2f1df12cc2dc25b342029e49c6d3f120d380b47.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c2f1df12cc2dc25b342029e49c6d3f120d380b47.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 08:16, Yong Wu (吴勇) wrote:
> Hi Rob,
> 
> Thanks for your review.
> 
> On Mon, 2023-09-11 at 10:44 -0500, Rob Herring wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On Mon, Sep 11, 2023 at 10:30:37AM +0800, Yong Wu wrote:
>>> This adds the binding for describing a CMA memory for MediaTek
>> SVP(Secure
>>> Video Path).
>>
>> CMA is a Linux thing. How is this related to CMA?
> 
>>>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>  .../mediatek,secure_cma_chunkmem.yaml         | 42
>> +++++++++++++++++++
>>>  1 file changed, 42 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/reserved-
>> memory/mediatek,secure_cma_chunkmem.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/reserved-
>> memory/mediatek,secure_cma_chunkmem.yaml
>> b/Documentation/devicetree/bindings/reserved-
>> memory/mediatek,secure_cma_chunkmem.yaml
>>> new file mode 100644
>>> index 000000000000..cc10e00d35c4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/reserved-
>> memory/mediatek,secure_cma_chunkmem.yaml
>>> @@ -0,0 +1,42 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: 
>> http://devicetree.org/schemas/reserved-memory/mediatek,secure_cma_chunkmem.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek Secure Video Path Reserved Memory
>>
>> What makes this specific to Mediatek? Secure video path is fairly 
>> common, right?
> 
> Here we just reserve a buffer and would like to create a dma-buf secure
> heap for SVP, then the secure engines(Vcodec and DRM) could prepare
> secure buffer through it.
>  
> But the heap driver is pure SW driver, it is not platform device and

All drivers are pure SW.

> we don't have a corresponding HW unit for it. Thus I don't think I
> could create a platform dtsi node and use "memory-region" pointer to
> the region. I used RESERVEDMEM_OF_DECLARE currently(The code is in 
> [9/9]). Sorry if this is not right.

If this is not for any hardware and you already understand this (since
you cannot use other bindings) then you cannot have custom bindings for
it either.

> 
> Then in our usage case, is there some similar method to do this? or
> any other suggestion?

Don't stuff software into DTS.

Best regards,
Krzysztof

