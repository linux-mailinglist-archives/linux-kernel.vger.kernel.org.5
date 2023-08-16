Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FAD77E0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244993AbjHPMA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244959AbjHPMAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:00:16 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636542112
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:00:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so60182065e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692187214; x=1692792014;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JXusQSBkKgzmVX0cQPtu5qS7/vO7l9owbd70EUmEIf0=;
        b=BO0hYI+W5qp8L20ACZN9H5+4SPrMLXinnG5qBz5wd2WDyBHSsUVNdQIJreJUSNu9Bd
         SsoxPP15yROXQXoR5IRKazEK/gZraQRJQLEPhNY/+nW2dIQp6jFAcNEsc7wKg/QmoLUE
         KCp+v6YHUOHa3Nfq3F1R4qtaWDyZyCOnWJWSASqX2+aHBe6U20MFadhLoeeVsAVrTwTN
         yWz3WTWT03e+ERzJFEak6tGARjzYVGw04Db47Q5uArI1Tu1QqtUJLEeAeNHoaC/h1MaT
         Vjo2K3KdFuOvmUq5bV04lHp1ssmhuX/uNafuTGYFVQYTLekj1JKN7VI0gYkzUtRQ4bdw
         ws0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692187214; x=1692792014;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXusQSBkKgzmVX0cQPtu5qS7/vO7l9owbd70EUmEIf0=;
        b=jgdyGtjnkABG/9R3WgrpY7mhb1ZDVO6Vf+XZGTpH1EuhkYbp/j4/SAs/4BqbUuRhvT
         4LizuI0Gy/PE8a5ZJgvZqHyIXgaXQVHzU64eVDtZxojcjKjpBGllEOuZQRrsQwaerxKI
         c4rHRIVSIJfRjmCvNN87c5WOG+hHyxmgeKESYVt11YdD6CjNWynV0LyFUHGps0aRtbu3
         N2IC+S9qIRUdB6BiSo05Lv7c1bqXD+TLm+wx0/nx7O+jqxESCbz0zn7uFQ1tfUe3ZrnQ
         a7jNvgQPgB5dgmLn5XbSwoNfmMMuN+aYBbXidIMDyvRdQxq6SilJxTG8STstV71uqYRk
         17vg==
X-Gm-Message-State: AOJu0YzqfDCkTcFbz7Cvw56jOusqMF33BA4immDkvhYwj9or7LHrv5GY
        gCuBVCQUNaNG0+cK19o5VqlPIw==
X-Google-Smtp-Source: AGHT+IEkAgTt7hKMOaQ6eYP4JU/vbFh5Hmk8g6lwro0vswB6yuqUEdRn3DD5J4Aav2PMognFo3JdPQ==
X-Received: by 2002:adf:e3c1:0:b0:317:73d3:441a with SMTP id k1-20020adfe3c1000000b0031773d3441amr1268070wrm.46.1692187213814;
        Wed, 16 Aug 2023 05:00:13 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b2-20020adfde02000000b0031416362e23sm21092572wrm.3.2023.08.16.05.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 05:00:13 -0700 (PDT)
Message-ID: <540b263a-3a1e-fd09-c6c2-18371e460e5e@linaro.org>
Date:   Wed, 16 Aug 2023 13:00:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/33] MAINTAINERS: Add Qualcomm Iris video accelerator
 driver
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-2-git-send-email-quic_vgarodia@quicinc.com>
 <c29d5e28-5b9d-1327-0feb-e5ed27afcd3a@infradead.org>
 <b4de638e-9cab-2662-92b0-e2d1a18018a1@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <b4de638e-9cab-2662-92b0-e2d1a18018a1@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 19:44, Dikshita Agarwal wrote:
> 
> 
> On 7/29/2023 4:18 AM, Randy Dunlap wrote:
>>
>>
>> On 7/28/23 06:23, Vikash Garodia wrote:
>>> Add an entry for Iris video encoder/decoder accelerator driver.
>>>
>>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>>> ---
>>>   MAINTAINERS | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 3be1bdf..ea633b2 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -17671,6 +17671,16 @@ T:	git git://linuxtv.org/media_tree.git
>>>   F:	Documentation/devicetree/bindings/media/*venus*
>>>   F:	drivers/media/platform/qcom/venus/
>>>   
>>> +QUALCOMM IRIS VIDEO ACCELERATOR DRIVER
>>
>> This entry should immediately follow:
>> QUALCOMM IPQ4019 VQMMC REGULATOR DRIVER
>>
>> to keep the file in alphabetical order.
>>
> Sure, will fix this in next version.

I think TBH before we see a next version, there needs to be a conclusive 
argument on why a new driver - instead of an update to the existing 
venus - is the way to go.

We have an ongoing corpus of working code that people use. The attempt 
to at least _try_ to integrate 8550 and beyond to upstream venus should 
be made.

If it fails, then we can discuss a branched driver.

Its not up to me but, that's certainly my honest and unvarnished input.

Instead of investing time in V2 - please invest time in upstream venus 
or make the technical argument conclusively _prior_ to V2 as to why V2 
and beyond is the "only" way forward for 8550 and beyond.

---
bod

