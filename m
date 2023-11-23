Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2587B7F632A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346151AbjKWPi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346072AbjKWPiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:38:54 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38279C1;
        Thu, 23 Nov 2023 07:39:01 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c8880f14eeso12646121fa.3;
        Thu, 23 Nov 2023 07:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700753939; x=1701358739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5QTDN/COfbPh5hWo0S55LVkpF8OpC4D7Gn+kAsnVaM=;
        b=FLRWlJ4YycqQmX/t9mb9H0MYg5bSdDOwFevPr43+Ddy92WWRxaUCVMLn21OSa5to6s
         uBLOPOwdIKPetbruNM/l1t1TFuPZtTlpB8CL9YH5tod0otI9N8ZTHintYfl3NFTXeK2Q
         q0IbyMXBr7fDDk3icH6wJkHnAJ3J9aUjhP86XHTxzo9sT38SBJf+vCl6tt04Et4TmkNO
         oygF4SUHBlRUPki/8nrATwsVMonvBESn6m+1Zqz8ATNoNRJLMpya80V2O22Efa/LG6X3
         F9PjU8ekLCKNcGJ4zVsK7f1RAR1XwJ1Ke8zUutY+DZ5+HRIANvC7gUo4sf820FyE4IAT
         M0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700753939; x=1701358739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5QTDN/COfbPh5hWo0S55LVkpF8OpC4D7Gn+kAsnVaM=;
        b=irOXZ17kF5e/ro+lUE0zg+MJ/6bIhFDGKSil+LPXoth9kwAUwiwkzvICII/slQj/+E
         O9u909htwAX6okJiKj3gLZgVO5ZmW+3aEYLSr6hLFmADvT1lQsmOMBf+rhbD+RYDwY6c
         ztD2T/RMSISOYQ7K9KWr0vWrrYF7K8+ttILq3yLFcoPXHOMZ7l0IWE/HZIG9KTGOaYyj
         p5gNvcgi8FffAEn93D8RH354jU9hI06vMCDCwTFZm5D4Y+G/QmessdyErR3ytzI1oNJx
         r1mAwKhwsD5UbhurXzZuHZY8eRAUYg/SZT5ZlnyWr9LMYAggF1YPq0VgSFL6u/pVtnap
         DIEA==
X-Gm-Message-State: AOJu0YwzcU72EmCQVbBgjIspjlkL7I7RGho4Bwb8Brb2K2e7DvCVpkmR
        PXr4OOfxCIg8HqkeKedQItI=
X-Google-Smtp-Source: AGHT+IHomSdQ+41Hjzo6i7Clcyf/5GQNw82lEcTgP30RpuqoAvf3sXxd02xrsS0dBSM2Qe4A8z/Zjg==
X-Received: by 2002:a2e:9e55:0:b0:2c5:70f:614a with SMTP id g21-20020a2e9e55000000b002c5070f614amr3380967ljk.17.1700753938803;
        Thu, 23 Nov 2023 07:38:58 -0800 (PST)
Received: from ?IPV6:2001:999:251:b686:cec4:d552:2937:637c? ([2001:999:251:b686:cec4:d552:2937:637c])
        by smtp.gmail.com with ESMTPSA id y35-20020a2ebba3000000b002bcedacd726sm244401lje.25.2023.11.23.07.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 07:38:58 -0800 (PST)
Message-ID: <74b0b808-7b97-4e53-a1a4-6e2e1274ecff@gmail.com>
Date:   Thu, 23 Nov 2023 17:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: twl6030-irq: Revert to use of_match_device()
To:     Lee Jones <lee@kernel.org>
Cc:     tony@atomide.com, robh@kernel.org, wens@csie.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231029114843.15553-1-peter.ujfalusi@gmail.com>
 <20231123103756.GD1184245@google.com> <20231123104108.GF1184245@google.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20231123104108.GF1184245@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/2023 12:41, Lee Jones wrote:
>>> @@ -368,10 +368,10 @@ int twl6030_init_irq(struct device *dev, int irq_num)
>>>  	int			nr_irqs;
>>>  	int			status;
>>>  	u8			mask[3];
>>> -	const int		*irq_tbl;
>>> +	const struct of_device_id *of_id;
>>>  
>>> -	irq_tbl = device_get_match_data(dev);
>>> -	if (!irq_tbl) {
>>> +	of_id = of_match_device(twl6030_of_match, dev);
>>
>> I think you just dropped support for ACPI.
> 
> Ah, scrap that.  I was looking at the wrong part of 1e0c866887f4.
> 
> So what about the other drivers changed in the aforementioned commit?

Looking back at it again, I think only this patch is needed.
This is not a real driver, it is using the twl core's device.
The twl6030 is for sure broken, let me reply to the twl4030-power in a sec.

> Ideally we'd have a call that covers all of the various probing APIs.
> 
>> Rob, care to follow-up?
> 
> I'd still like Rob to comment.
> 

-- 
Péter
