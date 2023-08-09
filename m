Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02584776019
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjHINAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjHINAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:00:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFDE2103
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:00:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99357737980so981332766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691586045; x=1692190845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkQfk41wpqfjz+mLvTVXwnfN3tFzJusZiA/ZzblZA/c=;
        b=JOt/neGsXumf2WLwlF0maWpAxYugaJRAPqX2QsPsvyHfvEorQnvr2rifTBwv0cxtYt
         OK/482mz0avRMRrBF7JmOgcLMPsmGgRPTB5plHb+b1/whOCnWs5CAf++wq3rCa9F6k3L
         XMXUEu+L85QAl34800PQFNkBIB+OiX0duWdMqPg2UUBVigdodRQphjXlXpJYZyhDKX8r
         k5Sg24NFQb8BL9eTraIpLvpYqzOCmDE1nIIgOIpt/T+DuF0VosMneN4Hx6sY8LKhM+pT
         QPMdzI9YPaDPkFCFLHV2wtnam9AVovJuKgZHI226oYAhei4exylUorWsXSLTku0TBS6M
         J7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691586045; x=1692190845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkQfk41wpqfjz+mLvTVXwnfN3tFzJusZiA/ZzblZA/c=;
        b=eFXRwS1eP1Kq4523fmtSeod4DpJI13xSyABr56nQijN9xm1Y6m3b3sJoN31dxuneXI
         IoKNvk2oNRINPY2iuYGy20Qu/HV0N2MNfN615Kf7Odh9+tfoi2tDCdMgsgTEPV98JV1c
         xNDhBaPXNrfv0Zf8Pvr//BYyDFR5/JYZEyzZMvHzz4AO/kl0xykgNpSh0L4Zlcj20YHN
         Z1Sr/n0bJo3rRovgW0OpQ/SDgAqspFIrwqjZfzpQWhXSxoXDYVOb8DZWvCdoHjBf8rnB
         zGg8NUUmEENzZhpPDuzSzg766nvN0J8zGuN+iyFN8+J8CSCb6NGvdkAVkhiJB0Ks/8Mr
         67vA==
X-Gm-Message-State: AOJu0Yz2T7DI7TxZqnc4sfRnHUWks74AjIDl1wYqPRwb6V05Vw5NHmtB
        R/uJMysIaOVRxNcFoNeY0/4b0w==
X-Google-Smtp-Source: AGHT+IG/xFtqsZIi/wA1IMhYIyCrPe8A6tlho6R+B+aFuU7npNcg9qbHmJn2OSrG0KdQ6W7qc2IZ4g==
X-Received: by 2002:a17:907:77c8:b0:99b:f8e7:130f with SMTP id kz8-20020a17090777c800b0099bf8e7130fmr2114166ejc.15.1691586045471;
        Wed, 09 Aug 2023 06:00:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id bw5-20020a170906c1c500b00988f168811bsm8049495ejb.135.2023.08.09.06.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 06:00:45 -0700 (PDT)
Message-ID: <f9a8897e-301e-9d69-be59-a5aa9290f01b@linaro.org>
Date:   Wed, 9 Aug 2023 15:00:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-2-zhuyinbo@loongson.cn>
 <91f57b0d-a6e9-c039-40b6-0a1a9af5f7a0@linaro.org>
 <78c5a043-3e2a-48d6-88bd-2f91cc6d1347@loongson.cn>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <78c5a043-3e2a-48d6-88bd-2f91cc6d1347@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 09:28, Yinbo Zhu wrote:
>>
>>>     - gpio-ranges
>>>     - interrupts
>>>   
>>> @@ -49,11 +82,16 @@ examples:
>>>       #include <dt-bindings/interrupt-controller/irq.h>
>>>   
>>>       gpio0: gpio@1fe00500 {
>>> -      compatible = "loongson,ls2k-gpio";
>>> +      compatible = "loongson,ls2k1000-gpio";
>>>         reg = <0x1fe00500 0x38>;
>>>         ngpios = <64>;
>>>         #gpio-cells = <2>;
>>>         gpio-controller;
>>> +      loongson,gpio-conf-offset = <0>;
>>> +      loongson,gpio-in-offset = <0x20>;
>>> +      loongson,gpio-out-offset = <0x10>;
>>> +      loongson,gpio-ctrl-mode = <0>;
>>> +      loongson,gpio-inten-offset = <0x30>;
>>
>> I still think that you just embed the programming model into properties,
>> instead of using dedicated compatible for different blocks. It could be
>> fine, although I would prefer to check it with your DTS
> 
> Okay, I got it,  and if I understand correctly, you seem to agree with
> me adding attributes like this.
> 
> And, if using this method that programming model into dts properites,
> then when adding a new platform's GPIO,  there is no longer a need to
> modify the driver because gpio controller is compatible and different
> platform can use a same compatible.

Uhu, so there we are. You use this method now to avoid new compatibles.
No, therefore I do not agree.

> 
>>
>> Where is your DTS?
> 
> 
> Sorry, the dts containing gpio nodes are only available in the product
> code and have not been sent to the community yet.

Does not help to convince us, but it is your right. With this and above
explanation, my answer is no - NAK.

Best regards,
Krzysztof

