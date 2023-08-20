Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A16781FB5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 22:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjHTU23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 16:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjHTU21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 16:28:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8561FED
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 13:25:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99cdb0fd093so361437866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692563140; x=1693167940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StjW9zVJDg/it/2Zx4uZor89taRslW2dT/6diASww+4=;
        b=vci9yDnl+yyQhiHYI3CMfFxQx7T5f94503EtOwkkLJtDvyORUMezQkNjPxBXYG0+c8
         1tqiwwDupiRkVCzmvK2ATAiqb5p129sMDGXo3OEbhj14bEv6JXvKo7buPP9PHdnbXKVa
         xHjSlRpiludjqpyp9CpmF+LIKqMrO1XFDmEtQyMQrTxDtVZVorooYOCVOyWpPV1bbMz/
         THa5ldcxuDMuE3J8E/qVbqKdR2sG+kodhNT4Cc/hfIcFwZhZHRI28t72ieCGLqWkqrko
         mxkLgshVAhG4kE8ss1j+DQUS0SLDDDRHrrbltYbk6niHWE+lPpqntcTERnZ1QANv0aay
         mntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692563140; x=1693167940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StjW9zVJDg/it/2Zx4uZor89taRslW2dT/6diASww+4=;
        b=L/oX7Ho5kiX9s7hTpciAK/4Kg6RkFKf/Z1rCHxYfMXjNVlPfacdRG3/0a/zQbu2gU9
         x6e8z1AfAPNetoKhiFRQTbSexFGKjflAb60mRYrDzwchHJ+LJbLXLCeV4Q3vjR34vqXR
         0Fm3w3E4WsztAKyruu48L6+ggwrTuvSMuvm8ESIvjsFUcmyfEFAin8tYZ04RGAS74jNj
         uTQnkFIiyxs/2KJDVAY9PuCckfceth05yahtNG5MJFHV2grNp46bEEPusFvaLOCk+Cl8
         xHkmSQYHzLuxJXpZqYl+4Bg7pbK/sL/EivTPXO6haz5bfRhPo1ylvRU0rWt8vf4dYEWB
         rMnA==
X-Gm-Message-State: AOJu0YzuJywyMOY9HLS3gFDar8IzrWy8wmTcZodfvmUONAKThxvXZc7h
        /Z7gZqKMrKS9vBadkwv8YVMdAw==
X-Google-Smtp-Source: AGHT+IG+6nkBP8ESNEiuPFXeg/GVvn41vSGT+I9KbN6KuNmzanEMYwxjP4S2vVKuDBGNIppz79oNiQ==
X-Received: by 2002:a17:906:23e9:b0:99b:de31:6666 with SMTP id j9-20020a17090623e900b0099bde316666mr3521212ejg.22.1692563140210;
        Sun, 20 Aug 2023 13:25:40 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id qh10-20020a170906ecaa00b0099caf5bed64sm5211110ejb.57.2023.08.20.13.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 13:25:39 -0700 (PDT)
Message-ID: <879f8bf7-db08-0add-9bff-a56ae07ffc67@linaro.org>
Date:   Sun, 20 Aug 2023 22:25:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/4] dt-bindings: media: Add bindings for Imagination
 E5010 JPEG Encoder driver
To:     Devarsh Thakkar <devarsht@ti.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, eugen.hristev@collabora.com,
        ezequiel@vanguardiasur.com.ar, u.kleine-koenig@pengutronix.de,
        sakari.ailus@linux.intel.com, praneeth@ti.com, nm@ti.com,
        vigneshr@ti.com, a-bhatia1@ti.com, j-luthra@ti.com,
        b-brnich@ti.com, detheridge@ti.com, p-mantena@ti.com, vijayp@ti.com
References: <20230816152210.4080779-1-devarsht@ti.com>
 <20230816152210.4080779-2-devarsht@ti.com>
 <7a9bcd78-b544-524c-e944-5fbb0c60e600@linaro.org>
 <530306bc-174e-c75d-40c5-6fa42d69af31@ti.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <530306bc-174e-c75d-40c5-6fa42d69af31@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2023 18:46, Devarsh Thakkar wrote:
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - const: ti,e5010-jpeg-enc
>>
>> TI did not make e5010. Use SoC-based compatible.
>>
>>> +          - const: img,e5010-jpeg-enc
>>> +      - const: img,e5010-jpeg-enc
>>
>> img,e5010-jpeg-enc cannot be compatible with img,e5010-jpeg-enc. It does
>> not make sense. I guess I did not expect you are going to use what you
>> wrote in v1 directly... I thought it is just about syntax.
>>
> 
> Sorry but I did not understand this fully, the possible compatibles are:
> 
> 1) "ti,am62a-jpeg-enc", "img,e5010-jpeg-enc"
> or
> 2)  "img,e5010-jpeg-enc"
> 
> anything else will not comply during dtbs_check as shown below :

Ah, you are right, ENOTENOUGHCOFFEE or some other issue on my side.

> 
> For e.g. If I use below compatible :
> "img,e5010-jpeg-enc", "img,e5010-jpeg-enc"
> 
> and run dtbs_check, it throw below error  :
> 
> make CHECK_DTBS=y DT_SCHEMA_FILES=media/img,e5010-jpeg-enc.yaml 
> ti/k3-am62a7-sk.dtb
>    LINT    Documentation/devicetree/bindings
>    CHKDT   Documentation/devicetree/bindings/processed-schema.json
>    SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>    DTC_CHK arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb
> /home/devarsht/ti/linux-next2/linux-next/arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb: 
> jpeg-encoder@fd20000: compatible: 'oneOf' conditional failed, one must 
> be fixed:
>          ['img,e5010-jpeg-enc', 'img,e5010-jpeg-enc'] is too long
>          'ti,am62a-jpeg-enc' was expected
>          From schema: 
> /home/devarsht/ti/linux-next2/linux-next/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
> 
> 
> Similarly, if I use below compatible :
> 
> "ti,am62a-jpeg-enc",
> It throw below error :
> 
> make CHECK_DTBS=y DT_SCHEMA_FILES=media/img,e5010-jpeg-enc.yaml 
> ti/k3-am62a7-sk.dtb
>    DTC_CHK arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb
> /home/devarsht/ti/linux-next2/linux-next/arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb: 
> jpeg-encoder@fd20000: compatible: 'oneOf' conditional failed, one must 
> be fixed:
>          ['ti,am62a-jpeg-enc'] is too short
>          'img,e5010-jpeg-enc' was expected
>          From schema: 
> /home/devarsht/ti/linux-next2/linux-next/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
> 
> 
> But If I use either 1) or 2) it does not throw any error.
> Please let me know if I missed to understand your point.

Yes, you are right, sorry for that.

However it still should be "ti,am62a-jpeg-enc", not ti,e5010...


Best regards,
Krzysztof

