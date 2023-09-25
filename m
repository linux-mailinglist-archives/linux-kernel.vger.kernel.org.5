Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69317AD731
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjIYLq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIYLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:46:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43B6DA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:46:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-323168869daso3606489f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695642409; x=1696247209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYcYzGFcPcFNcdhLbqvhHN6qFJ0rWufHOTyltNhdpfs=;
        b=Po/PTE9m421E34P1xNXRDqjHeGT0Wi/c1sGrj8sJwY0C+nGZyV/mszIlLslSD0Y23e
         VHZSfvJBwimRqfnGyNykgY9QOLzQ8JoD/ktup/dNcwtMdXA9f4WTSKV1Uxekm05Xp2wP
         m+36mrhhpUdlUDyRI5xBy5aJeq3IMVf/i51jTOr/d69scZFWAdy8r6IIDj9GYahAutcr
         qAZa2eb4ME76Ng6zPQnO6X4S93BfBe6iCjhjmVeRtRNk2o7RS1JhIYC/ICRkrbyDx/Jt
         UJu4cPVenssu+TVNfYyS8C4Zw/PoLMNXc5E/VyXmymHaZGPRh9g5qS0ENUKdDl3VZHq4
         6GmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695642409; x=1696247209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYcYzGFcPcFNcdhLbqvhHN6qFJ0rWufHOTyltNhdpfs=;
        b=hTvjAmNWiUpMCf9lOGdw9fB+Z09LzoUHfke8ZDI44PCp+lDqd/jl7eeiM0WVV2dc9a
         EWK/dVBloXCM31HxkdPpI1jnC7mda69qiWDZ9erKwHGEvpCaq7I+fc14dOZkBmlyQ0qW
         7hXGdh06KZMqQ/9tqYgQXPO2IPrT8InKs4thE9s4o2y9Bv9GlAuLCXE9lN3PNsX22mwB
         1PRn1R/yISde6EELaSYqm2wpDQzgknKJlN6xukhLZ7EpZfXL8aBQgqwctMY30eSZeIx4
         HcbfH1AAa1qICCxu7B6wcMqEgC6S7ksMsG0taCTGCVQpWy7RVMCEBWlRcYFVE8x6VKyM
         Fw1w==
X-Gm-Message-State: AOJu0YxFaG6XGiP5aUveJr73hcvg95yh4tl8R5s2W2xQHlDxDVl64lpX
        UObklJmvsKwp1pRnLO/5x0D7/g==
X-Google-Smtp-Source: AGHT+IFd7UcxLS+BU737pcEMWDnXE2kMVHbJQsEDBwkeKmw9iGCTaTmwo7ZTsBKSegHPVhG544O+UA==
X-Received: by 2002:a5d:4903:0:b0:322:5251:d798 with SMTP id x3-20020a5d4903000000b003225251d798mr5427540wrq.70.1695642409326;
        Mon, 25 Sep 2023 04:46:49 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g10-20020adffc8a000000b003176c6e87b1sm11703603wrr.81.2023.09.25.04.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 04:46:48 -0700 (PDT)
Message-ID: <22a7562e-53cb-40f9-a922-cf840c178506@linaro.org>
Date:   Mon, 25 Sep 2023 12:46:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] media: qcom: camss: Allow clocks vfeN vfe_liteN
 or vfe_lite
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911131411.196033-1-bryan.odonoghue@linaro.org>
 <20230911131411.196033-12-bryan.odonoghue@linaro.org>
 <936acf18-b961-40e3-b68b-f1c679961d67@xs4all.nl>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <936acf18-b961-40e3-b68b-f1c679961d67@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2023 08:10, Hans Verkuil wrote:
> On 11/09/2023 15:14, Bryan O'Donoghue wrote:
>> The number of Video Front End - VFE or Image Front End - IFE supported
>> with new SoCs can vary both for the full and lite cases.
>>
>> For example sdm845 has one vfe_lite and two vfe interfaces with the vfe
>> clock called simply "vfe_lite" with no integer postfix. sc8280xp has four
>> vfe and four vfe lite blocks.
>>
>> At the moment we declare vfe_lite0 and vfe_lite1 for sm8250 but never set
>> those clocks because we don't match the strings.
>>
>> We need to support the following clock name formats
>>
>> - vfeN
>> - vfe_liteN
>> - vfe_lite
>>
>> with N being any reasonably sized integer.
>>
>> There are two sites in this code which need to do the same thing,
>> constructing and matching strings with the pattern above, so encapsulate
>> the logic in one function.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   drivers/media/platform/qcom/camss/camss-vfe.c | 22 ++++++++++++++-----
>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
>> index db8f68819ded9..f3cf387e4907e 100644
>> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
>> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
>> @@ -431,6 +431,20 @@ void vfe_isr_reset_ack(struct vfe_device *vfe)
>>   	complete(&vfe->reset_complete);
>>   }
>>   
>> +static int vfe_match_clock_names(struct vfe_device *vfe,
>> +				 struct camss_clock *clock)
>> +{
>> +	char vfe_name[6]; /* vfeXX\0 */
>> +	char vfe_lite_name[11]; /* vfe_liteXX\0 */
>> +
>> +	snprintf(vfe_name, sizeof(vfe_name), "vfe%d", vfe->id);
>> +	snprintf(vfe_lite_name, sizeof(vfe_lite_name), "vfe_lite%d", vfe->id);
>> +
>> +	return (!strcmp(clock->name, vfe_name) ||
>> +		!strcmp(clock->name, vfe_lite_name) ||
>> +		!strcmp(clock->name, "vfe_lite"));
>> +}
> 
> I'm getting this compiler warning:
> 
> drivers/media/platform/qcom/camss/camss-vfe.c: In function 'vfe_match_clock_names':
> drivers/media/platform/qcom/camss/camss-vfe.c:483:52: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
>    483 |         snprintf(vfe_name, sizeof(vfe_name), "vfe%d", vfe->id);
>        |                                                    ^
> 
> Since vfe->id is a u8 I would just increase both the vfe_name and vfe_lite_name
> sizes by 1.
> 
> Regards,
> 
> 	Hans
> 

Hmm. True.

Maximum value of VFE id is 255 @ u8

---
bod

