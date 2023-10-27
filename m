Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD177D95ED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345637AbjJ0LEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345713AbjJ0LEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:04:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4558A1A7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:04:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-508126afc88so2888217e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698404641; x=1699009441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ePMRR6gKT2qAmqNubGPkKYHMZgdO9O2UH8V3Kfzh3AA=;
        b=Y8WlwwOLTw7Ho15mB3SIHTQvluxpTNOllnIZJDU5zJXD+O2BGCDgeZCfQQJNUPigk7
         fEXrG9iqK5VXRXi2qAlaQMFKrRJNDkzmcD8nilLFjc3+bIZKqFjIntcVpOeBgHbvCu1T
         dPZUhJNTVfA4l/c3pb3yvrYuT7sZkOW3p1Cx871AqVcyM8i1aHOYX7puPfX4hSOEOew6
         6TyOelV+4GZ62w/2nbEwJi86peevRfegv6rKUuNlXovk5DK9v0sH6n28T4xGrRKFggz6
         6WR8fnghxdnx+XFOJv3CmoLLaT12yt/T3CP5R1TkgGWRDOZqz20go/Mqjh+Uy+H6faVC
         v+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698404641; x=1699009441;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePMRR6gKT2qAmqNubGPkKYHMZgdO9O2UH8V3Kfzh3AA=;
        b=Y4kIMTobxkh5BlGHuouV3rh27TrYD4gY+ix1RWjfCgP3AVq4ST8lJLfBO6BjaYFMJP
         ympfvnWfzaDVtg10hUtuYuNLucs3Ys8pp7ncqGeQEQvQMA69JzueqybS4wq5yHLwTXPv
         Wy4E4PKVJfseLbScD4XltQySXGfmF2Tjm6B7kWGb1RVDfuOy1jhAX7rKYbzyDq4LPXvJ
         RKpApBS/xL0m98HiKzycNp2ojtU8zAHrb9dub5nVWNCN9HwyLxfV4vUMO0MTeCmba0nJ
         AjB8A8CmMBOoEGW1WTCyKps5Ae4dZmpXMdOy1BDUvQ04cMYHYccpYYf/kFNDIVkorP6S
         7XlA==
X-Gm-Message-State: AOJu0YwQEPcXuRFtvScvbGHO833wCfYVEvoeDM2L6mDl7PDm6009nuze
        sp4dG6nzithCIMC/3kI6Zi7nFA==
X-Google-Smtp-Source: AGHT+IFilOyHIxXzN1HvOKpZROnJ3vHdEFCYa+hJODchPPnZvYWCEjjen5yTk48QdcMKIHvkNSBiQw==
X-Received: by 2002:a05:6512:753:b0:507:a78a:9420 with SMTP id c19-20020a056512075300b00507a78a9420mr1490561lfs.62.1698404641015;
        Fri, 27 Oct 2023 04:04:01 -0700 (PDT)
Received: from [192.168.0.22] ([78.10.206.168])
        by smtp.gmail.com with ESMTPSA id m28-20020ac24adc000000b00507d478c211sm237468lfp.76.2023.10.27.04.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 04:04:00 -0700 (PDT)
Message-ID: <22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org>
Date:   Fri, 27 Oct 2023 13:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: Avago APDS9306
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>
Cc:     Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-2-subhajit.ghosh@tweaklogic.com>
 <b030cb0a-7a15-4497-9b0f-75615694dc04@linaro.org>
 <c71d095b-cd39-4c4d-a985-7032a1da49d9@tweaklogic.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c71d095b-cd39-4c4d-a985-7032a1da49d9@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2023 10:55, Subhajit Ghosh wrote:
> 
>>>   
>>>   properties:
>>>     compatible:
>>> -    const: avago,apds9300
>>> +    oneOf:
>>
>> Drop
> Sorry, do you mean I should not use the "oneOf"?

Yep. You do not need it - you do not have more than one item.


>>
>>> +      - enum:
>>> +          - avago,apds9300
>>> +          - avago,apds9306
>>> +          - avago,apds9960
>>
>> I don't understand what is happening here. At all. Some compatibles are
>> moved, some are added, nothing explains why you are doing it.
>>
>>
>> Best regards,
>> Krzysztof
>>
> I have formatted the commit message wrongly, it will be fixed at once.
> I am trying to add the support for all the three sensors in the same schema file.

One commit does one logical thing. Moving things is one thing. Adding
things is another.

Best regards,
Krzysztof

