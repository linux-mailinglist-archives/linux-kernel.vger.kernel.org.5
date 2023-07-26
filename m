Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64F7763F24
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjGZS7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGZS7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:59:47 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1236E271C;
        Wed, 26 Jul 2023 11:59:46 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77acb04309dso4255139f.2;
        Wed, 26 Jul 2023 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690397985; x=1691002785;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8y5YvDZr0jjiu3/y0974ovQSLFkCl5NQeYqNXCpGzXo=;
        b=oK5BXokR9oSfhTRm6EdvIIlfjCVAgBhIuH/a/9AFGISI058T6VlNIRSbcReVX9j2el
         ar1vyJ73Fd6bDTvuPS0ZFrD+4EsXMqc7ccezjYgrOdTbDPEH8vK2ziyTDg1bnKQUye/8
         XGsiNpppAtxN4RNTBV1v3iMLfNUJ000gZhSUPS2QpRPx2hgby1JjVW9Fdyu6ApFkGADj
         cEEDDY94fDHl2TBpC5sJvfZBriFRRGy5JEo8f4vv0MHfrEXkneB7qGe6XuddDrvekOns
         4Ei0XWdpaTG761546F0w69yFYVVznNYIWSZCWqK2eqYsdWiS3DsyKs5vZDJoUMzpsBPu
         IKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690397985; x=1691002785;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8y5YvDZr0jjiu3/y0974ovQSLFkCl5NQeYqNXCpGzXo=;
        b=H2WVBQkps9La6Lc2cOEa2rNmnCxqfT7Y2eTmE7qaLSvFSmEl9VWdHon1sueCnYQhhm
         wpCURxmKYYT2+h/OnCn7JuTh9uunTI6eAKFJ7AH/zLGrxbN6pT9JJp6Q5mZLxDOrfrxF
         X39wGaAoO9Rn3yZBd8Yyy8S6/oYOx/g51iKDDvYIw+3LqhxBPgwk7lyIC7rf1NsihAd4
         Vzc0baMSas2ZYZSzBUGNJt+gJTltuX32lWTGl+qFppEbDoGKLnFlB3bDP7SOCVxfIadO
         s6o5sXYcoFmHeg3mcAm5bEnFaTFS7H3JFYb85C9by0FcVraaYH0JG32mBjmEFQnOn57x
         2vDw==
X-Gm-Message-State: ABy/qLYx+9dCl+H/Vhobtngz5HaC9Asdy2sGP5u6ld+sjyj96klda3Th
        7Bn4Bg2HGt+0uZbUdwGbb64=
X-Google-Smtp-Source: APBJJlHAQDJ+gcWVgI/owV13GKJvkOdPS2rkMbRnxiGpmVgE5m/Uj9Y2os1VFKbhndp1omz8tk4LaQ==
X-Received: by 2002:a5d:8701:0:b0:787:1557:3834 with SMTP id u1-20020a5d8701000000b0078715573834mr2899551iom.20.1690397985267;
        Wed, 26 Jul 2023 11:59:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f23-20020a6be817000000b0078b9d1653a8sm3860522ioh.42.2023.07.26.11.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 11:59:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7091e719-4d9f-246c-262a-02ad91fd790d@roeck-us.net>
Date:   Wed, 26 Jul 2023 11:59:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Carsten_Spie=c3=9f?= <mail@carsten-spiess.de>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-3-mail@carsten-spiess.de>
 <82628237-e087-269e-9673-cf3873fe4b35@linaro.org>
 <4105d77e-e011-8df7-35bf-bbfca0b640da@roeck-us.net>
 <7a44e513-2b6b-aed3-3d71-e56bd0be2417@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add renesas,isl28022
In-Reply-To: <7a44e513-2b6b-aed3-3d71-e56bd0be2417@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 11:27, Krzysztof Kozlowski wrote:
> On 26/07/2023 20:19, Guenter Roeck wrote:
>>>
>>>> +    enum: [1, 2, 4, 8]
>>>> +
>>>> +  average:
>>>> +    description: |
>>>> +      Number of samples to be used to report voltage, current and power values.
>>>> +      defaults to <0> when not set
>>>> +    enum: [0, 1, 2, 4, 8, 16, 32, 64, 128]
>>>
>>> I am sure hwmon has some property for this. Are you sure it is called
>>> "average"?
>>>
>>
>> Something with samples. adi,power-sample-average is similar. Others
>> use average-samples, qcom,avg-samples, touchscreen-average-samples.
> 
> So probably it's a time to come with something generic, e.g.:
> average-samples in some hwmon.yaml
> 

Maybe, but that is going to take a lot of time. Many configuration options
of hardware monitoring chips (such as the thermal sensor type, the ideality
factor of a thermal diode, or the number of pulses per revolution reported
by fans) are actually properties of the connected device, and Rob has made
clear that he expects such properties to be associated with the actual
device (fan, thermal sensor, etc). I don't even know how to model that,
and I really don't have the time (nor, really, the expertise) to come up
with acceptable generic bindings.

Guenter

