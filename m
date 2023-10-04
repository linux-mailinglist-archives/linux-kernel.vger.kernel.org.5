Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5DF7B782A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbjJDGv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjJDGv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:51:28 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EBF9E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 23:51:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso295293166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 23:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696402280; x=1697007080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Mk4bYYH9dc7V+7DBoYeL/sMRgWjkA5cLv5a6gT9/5g=;
        b=fJBPWm/p71wCx0XCAYmIolDCS+6dSyb79TqwuWl9wbSwOgpUTT08eyIKUuamJiUEyg
         FFnmx+F1z7S8+f4mrpmMxFfeG6G/Nsm//ep+tCjtZoh5H5TpbGj94qFoH8bZcskIa6N2
         U3PRGOYh5jSmVd0ZlFPrqnOhHsrTJdV5OnCi/KRv0PaH0U68UjoPPWkQB5jLTD8jZeJF
         1KhnzgOLfcKP/xYx2263IeK4VU4K6tAbvp/x/LLopyDc5R8tfJUrj4KXjTzdrNGY6d+V
         6xOQIKvonaht8Ib090KjobSPaNPc8kwp3fWJyZU+WXxCPdef+j4beGx3Pb44GPLFeFvm
         CP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696402280; x=1697007080;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Mk4bYYH9dc7V+7DBoYeL/sMRgWjkA5cLv5a6gT9/5g=;
        b=TBKU2VcW+wT+cUO+XqaF0IyoVhZJoFAQiE5QUDBJTt+yudkbFNdATnhKKKC94hp3gU
         QNrq4juyzQ+LaXPcb2BfJPOQbm4bSnxWBuIkOaKdsCiEVpR7Qrsc84FyNduiU6mr1/tw
         jV8y1g5rGIPK6SCbB+VmOwKSIRInONaJZrBqmZcUeiTzr/qDFt+xcai1Ldw9jeR896nm
         76UoRzz2x4L11cB7xnejXEyK6Nx28rb15kXxJBTQjWRdhJ3/qIvNNQpAdd/AXvdVCieb
         4QZi/aA7AWBLg6tJpe5cR6ttMv/7y87MPmVZ6xlOKz6qWLsxIUQvaPgK/f1SABYJDxXe
         3jxA==
X-Gm-Message-State: AOJu0Yx91FuSvgBGw57WM58Ort9+8mPeQ+FEiuhDx9nwdRy6QVebwDOm
        G3UcEoWQd1xE/2GFXZN6O7MQNA==
X-Google-Smtp-Source: AGHT+IGXfDHPsDpfR1bfQNWb/TJeXEFZoTymWZlmGIZV2KdzQgtX/JdwbEzT0eo5BT4OJWnZJm08aA==
X-Received: by 2002:a17:906:7496:b0:9ae:72c7:73e6 with SMTP id e22-20020a170906749600b009ae72c773e6mr1250267ejl.10.1696402279819;
        Tue, 03 Oct 2023 23:51:19 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id r19-20020a170906365300b00985ed2f1584sm2220768ejb.187.2023.10.03.23.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 23:51:19 -0700 (PDT)
Message-ID: <8a936a54-9c20-4a3b-ac2c-ae65cd22698f@linaro.org>
Date:   Wed, 4 Oct 2023 08:51:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/5] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface
Content-Language: en-US
To:     yuji2.ishikawa@toshiba.co.jp, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230925232806.950683-1-yuji2.ishikawa@toshiba.co.jp>
 <20230925232806.950683-2-yuji2.ishikawa@toshiba.co.jp>
 <c58ffc72-59d9-49f5-be22-18588f7df1e3@linaro.org>
 <TYAPR01MB6201C2E34B969197C9E9DFB492C4A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <TYAPR01MB6201C2E34B969197C9E9DFB492C4A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 01:10, yuji2.ishikawa@toshiba.co.jp wrote:
>>> +    properties:
>>> +      endpoint:
>>> +        $ref: video-interfaces.yaml#
>>> +        additionalProperties: false
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my feedback
>> got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all requested
>> changes or keep discussing them.
>>
>> Thank you.
> 
> I'm very sorry that I misunderstood the intent of the last conversion.
> https://lore.kernel.org/all/0aa471ce-da83-172d-d870-1ec7a562baf7@linaro.org/
> I thought "additionalProperties: false" can be used and "xxx:true" should stay.
> 
> Let me confirm your intentions:
>   - "unevaluatedProperties: false" should be used instead of "additionalProperties: false"
>   - All of "xxx: true" should be removed
> Are these two correct understandings?

Ah, true, I missed that. It is indeed fine, apologies.

> 
>>
>>> +
>>> +        required:
>>> +          - clock-noncontinuous
>>> +          - link-frequencies
>>> +          - remote-endpoint
>>> +          - data-lanes
>>
>> Not much improved here. required goes after properties, always. I pointed you
>> last time the file which you should use as an example.
> 
> I'll check the overall structure of renesas,rzg2l-csi2.yaml.

This needs to be fixed.

> 
>>> +
>>> +        properties:
>>> +          data-lanes:
>>> +            description: VIIF supports 1, 2, 3 or 4 data lanes
>>> +            minItems: 1
>>> +            items:
>>> +              - const: 1
>>> +              - const: 2
>>> +              - const: 3
>>> +              - const: 4
>>> +
>>> +          clock-noncontinuous: true
>>
>> Drop

This and further can be ignored.

Best regards,
Krzysztof

