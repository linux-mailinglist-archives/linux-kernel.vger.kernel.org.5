Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894DE7985D1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243015AbjIHK0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIHK0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:26:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870531FC9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:25:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a6190af24aso237209866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 03:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694168692; x=1694773492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Diwki1H3nMBa2gbVYpcyQqgxJDZVKLGgip1PT183HVw=;
        b=BfOcuMpbR2Mt6aUvdo7WrHrY7UEE3N5goO/4hEbpDLTsDe7AH3vMX6j8hhg2DCHVUB
         kpUXm95l4WghRtMv4IVusMQIY6cIYbd9cOEDrKMNgLkV1MyY32fI1ZdqvO9wEUIWc/QT
         fKEzDsxfQ5YbhQjkWtC6pVNbibQm7L7IH1vT8dI/GaHWbwFe0tw+LUZqVgDaE8SxE1IZ
         VT+SbvLXRYzKTfCqSZcRArMOdFgUW5BujwZMZeE8CNYbaAqCbpnZbJCR+eVINf9JawNl
         S7sSJqYNyN2IEsmsX1uajcmHIA1ab65ppF/DC+li648efcpX15eCKZz4EhXyizKBizIK
         btoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694168692; x=1694773492;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Diwki1H3nMBa2gbVYpcyQqgxJDZVKLGgip1PT183HVw=;
        b=fql3v7UyJZSt5oxRDlLYuWpLQ/j5PIiYfUDu37D9QlinOzDJt7/KPPOsKU6OqbyQR7
         ReS1ziRj9FHFQFZelBu4gOTu52gJD8vAtdh3HHYTRCn6eIi/dSv7FlaSoBZxyGD/jNWh
         6THMFgJ2kXV1Spw/3c0e+vtvsY8xFo+seFe3REGSdr+gx6EeBgN4JI7toPpz4N5rrbq4
         kmehhzzMDhJUbnKyfK3G1yuqiIk8G23yfyMNT2YXexP0JoqL4ibUTFWtcKPLr9Xhfmo+
         a+UW1L2K6MMmRf0zDmYQhXs8pDZLApoufE4+sn7W56SOJsKhAU5kJwjaX8WBn82Vsy9S
         m0tA==
X-Gm-Message-State: AOJu0YzAeDpRfxeV7AvoaDhF+tY4JqEN15Dk/6el7sEhNcKcuXggjBWa
        7qEW+67mC19237Vl0t0uPkuZ1A==
X-Google-Smtp-Source: AGHT+IGHC6qdHCJ7eOqx4QHsciaxsECTd5T20mMKi4nbUh4CzU0XmJaRQWBYllJmgG1S0nnP6iLMuQ==
X-Received: by 2002:a17:906:1011:b0:9a2:2635:daa8 with SMTP id 17-20020a170906101100b009a22635daa8mr1527802ejm.56.1694168691864;
        Fri, 08 Sep 2023 03:24:51 -0700 (PDT)
Received: from [192.168.37.232] (178235177197.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.197])
        by smtp.gmail.com with ESMTPSA id sb5-20020a170906edc500b009a1be9c29d7sm835530ejb.179.2023.09.08.03.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 03:24:51 -0700 (PDT)
Message-ID: <c5d64d12-668a-4d70-85ee-e4111d85a1be@linaro.org>
Date:   Fri, 8 Sep 2023 12:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] media: qcom: camss: Move vfe_disable into a
 common routine where applicable
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
 <20230907164410.36651-16-bryan.odonoghue@linaro.org>
 <8b424303-09c9-4270-abfd-4f209f5c41e0@linaro.org>
 <41d1e364-40a4-48b2-97ef-6c76d238002e@linaro.org>
 <c9570c8e-c9a5-43f5-8b69-d5c38d214061@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <c9570c8e-c9a5-43f5-8b69-d5c38d214061@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.09.2023 12:21, Bryan O'Donoghue wrote:
> On 08/09/2023 11:04, Konrad Dybcio wrote:
>> On 8.09.2023 12:02, Konrad Dybcio wrote:
>>> On 7.09.2023 18:44, Bryan O'Donoghue wrote:
>>>> We can move vfe_disable() into a common routine in the core VFE file
>>>> provided we make wm_stop() a VFE specific callback.
>>>>
>>>> The callback is required to capture the case where VFE 17x currently isn't
>>>> VC enabled where as VFE 480 is.
>>>>
>>>> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>> ---
>>> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>
>>> Konrad
>> Actually there's
>>
>> ret = vfe_reset(vfe);
>>
>> return ret;
>>
>>
>> which could just be
>>
>> return vfe_reset(vfe);
>>
>>
>> Konrad
> 
> On purpose.
> 
> I prefer the ret = ; return ret; pattern since it makes it easier / less work to
> 
> ret = fn();
> if (ret)
>     goto error;
> 
> error:
>     return ret;
There's no error label in vfe_disable_output

Konrad
