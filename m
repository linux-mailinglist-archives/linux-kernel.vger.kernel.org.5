Return-Path: <linux-kernel+bounces-152401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 675A48ABDDD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 02:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9911F21005
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 00:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34FC29AF;
	Sun, 21 Apr 2024 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uutnxb2U"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29E38C;
	Sun, 21 Apr 2024 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713660756; cv=none; b=dXZzGDcT3bXTv0w1s6cJqfKQJsFRJrlTasrqXfS1XyKICdroArYVd8OK3PFLEhvgdu23VNDhbXHdk/Fknmam3NpJvjstXz6J/e+tweDqlPnmDAbSfj9VkSGNKF27s7oVobzdobPigBWhzvhmulb/XGpYKNMbkvSsWB33JQyiNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713660756; c=relaxed/simple;
	bh=kltL7WY9gysVRwFonfEBaD1Sdt2tE1k3lWQtkRMHR2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONS20y7mwG5i+5si7gRCqLcoPc52bQdTYudd+viCUeVqvs7BlDQStZ4EKKaWH1oFjpvxpILYh02FoSTDXbDmq2iP+6UISnIS5ts0pVHxDRptloe+hG58vjHKeeU59KJGCM3Hs4yBV0aFDpw4R/tx3ThmFwfPJ+T4490/ncxxQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uutnxb2U; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed112c64beso2859369b3a.1;
        Sat, 20 Apr 2024 17:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713660754; x=1714265554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmTndY/6V+l9GSOwkbZ4WVLq9rAPWNK6WqHx8cTBU4U=;
        b=Uutnxb2UpTPMM81WWFrba6xDaj9k4BzTyGDKUN0vH7qVA/ecTjU+CO0DdlKb+mw3Oo
         PHSVzxyfkS1vHlwNS6jMRX3YkOTM4Yr5yiskHIFTwodoyV8o8vw9w0V0hhqPO/VpBfG1
         aQS2BRYiL6C5i3R696wwDqzSOW+GmmsJ/TCnxby6+IdVH5FVkNrDjAq+hLVacqgTkQr0
         2ORj8F7SmJJc90OmpWgvN6rd1Cyyd+f2kQaFW97OEYQax96JmBbKlZvfzJm9D/cYQ65J
         FDUp4N4Fh959s7SuFU9iyUsnlxkIEefReMDcyfPAzSNRxF2B8psoKIBYvL/ODQcCkA1s
         pulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713660754; x=1714265554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmTndY/6V+l9GSOwkbZ4WVLq9rAPWNK6WqHx8cTBU4U=;
        b=ORVFluAKTI7GQoNrR7SblzE8XcNBqZc/DIXB1KZn9wZLXGXxevoi9Lg5bBSMbD6S4h
         JbRDwmUGXdmzFv92UzpomREPkhI6Ojdf3d0nKYVb3qCOIF93OIBlWQjh858iE/WlJYgY
         HrnzypH/4CTjgIqggSlyMpyeaODJV+fYhYtnBFhXhM+e5qD1U4INwBCC6Q4VG/IMrWkt
         cVK20eQWe2dtOviqeUhbbMywjRM10S5jc5pdbPEWosYH98ur/N6P2sZWMi8HJZZUeF6+
         xztzaITbHc/ujQxB52waQXLQBf866mNMI5YatfhxHfaa0oWqKo/DYYxBOJMVNLciWkSY
         zjUA==
X-Forwarded-Encrypted: i=1; AJvYcCU7oPKoGMXrgBq8K6pTumf0cXeDIbDp3wMLFWhO1TE0ke54fOa3qP0jk4FVnaN6pZ5slUaDxMmGd4Iv+GVGadLMCmrkX/5liQQKoJnXAOsTaR5vBan9KTeUUBY3jjAxXQkCURaU57Jf
X-Gm-Message-State: AOJu0YynW/z6Y25qnfxsgA6BNHZkEkZ/VViGYINcygXt4Fhi/GY5QqO7
	etbFLTpOeDxbMcX/l171Tdz4bUy9GTXBsEvbgk/adcsBqav37H6N
X-Google-Smtp-Source: AGHT+IFnY0SlAhergrNWNaiebeggz3lwQN0VLm8ZAoGhgXvTRogEbANht5sjtTkC2vWdszbM5QrTbg==
X-Received: by 2002:a05:6a00:8806:b0:6ed:de70:5ef8 with SMTP id ho6-20020a056a00880600b006edde705ef8mr4766994pfb.6.1713660754612;
        Sat, 20 Apr 2024 17:52:34 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:f91:84f5:d87e:d36d? ([2402:e280:214c:86:f91:84f5:d87e:d36d])
        by smtp.gmail.com with ESMTPSA id 13-20020a056a00070d00b006e69a142458sm5381470pfl.213.2024.04.20.17.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 17:52:34 -0700 (PDT)
Message-ID: <2231ae20-05ff-4292-861a-4d90a07fc50a@gmail.com>
Date: Sun, 21 Apr 2024 06:22:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] remove indentation for common path [linux-next]
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
 neil.armstrong@linaro.org, u.kleine-koenig@pengutronix.de,
 christophe.jaillet@wanadoo.fr, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
References: <20240420164927.15290-1-prosunofficial@gmail.com>
 <CAA8EJpqnZPVG6swW6T3YjG-ekinyYeif6SqardH0O_0puJn8Xg@mail.gmail.com>
Content-Language: en-US
From: sundar <prosunofficial@gmail.com>
In-Reply-To: <CAA8EJpqnZPVG6swW6T3YjG-ekinyYeif6SqardH0O_0puJn8Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/04/24 02:17, Dmitry Baryshkov wrote:
> On Sat, 20 Apr 2024 at 19:49, sundar <prosunofficial@gmail.com> wrote:
>>
>> Added check if pointer is null and removed indentation for common path
>>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: sundar <prosunofficial@gmail.com>
>> ---
>>
>> Fixed nitpicks in code according to comments received on other patch.
>>
>> https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/
>>
>> goal is to get rid of of_node_put,but sending this patch first to do one
>> thing at a time.
>>
>> Changes since v1 - fixed the typo error for spell from identation to
>> indentation
>>
>> v1 patch link - https://lore.kernel.org/all/20240420145522.15018-1-prosunofficial@gmail.com/
>>
>>   drivers/usb/typec/mux/nb7vpq904m.c | 49 +++++++++++++++---------------
>>   1 file changed, 25 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
>> index b17826713753..fe0257840dd5 100644
>> --- a/drivers/usb/typec/mux/nb7vpq904m.c
>> +++ b/drivers/usb/typec/mux/nb7vpq904m.c
>> @@ -321,35 +321,37 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
>>
>>          ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
>>
>> -       if (ep) {
>> -               ret = of_property_count_u32_elems(ep, "data-lanes");
>> -               if (ret == -EINVAL)
>> -                       /* Property isn't here, consider default mapping */
>> -                       goto out_done;
>> -               if (ret < 0)
>> -                       goto out_error;
>> -
>> -               if (ret != DATA_LANES_COUNT) {
>> -                       dev_err(&nb7->client->dev, "expected 4 data lanes\n");
>> -                       ret = -EINVAL;
>> -                       goto out_error;
>> -               }
>> +       if (!ep)
>> +               return 0;
>>
>> -               ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
>> -               if (ret)
>> -                       goto out_error;
>> +       ret = of_property_count_u32_elems(ep, "data-lanes");
>> +       if (ret == -EINVAL)
>> +               /* Property isn't here, consider default mapping */
>> +               goto out_done;
>> +       if (ret < 0)
>> +               goto out_error;
>> +
>> +       if (ret != DATA_LANES_COUNT) {
>> +               dev_err(&nb7->client->dev, "expected 4 data lanes\n");
>> +               ret = -EINVAL;
>> +               goto out_error;
>> +       }
>>
>> -               for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
>> -                       for (j = 0; j < DATA_LANES_COUNT; j++) {
>> -                               if (data_lanes[j] != supported_data_lane_mapping[i][j])
>> -                                       break;
>> -                       }
>> +       ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
>> +       if (ret)
>> +               goto out_error;
>>
>> -                       if (j == DATA_LANES_COUNT)
>> +       for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
>> +               for (j = 0; j < DATA_LANES_COUNT; j++) {
>> +                       if (data_lanes[j] != supported_data_lane_mapping[i][j])
>>                                  break;
>>                  }
>>
>> -               switch (i) {
>> +               if (j == DATA_LANES_COUNT)
>> +                       break;
>> +       }
>> +
>> +       switch (i) {
>>                  case NORMAL_LANE_MAPPING:
> 
> switch-cases should also be shifted one level to the left, see
> Documentation/process/coding-style.rst
> 
>>                          break;
>>                  case INVERT_LANE_MAPPING:
>> @@ -360,7 +362,6 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
>>                          dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
>>                          ret = -EINVAL;
>>                          goto out_error;
>> -               }
>>          }
>>
>>   out_done:
>> --
>> 2.34.1
>>
> 
> 
Hi Dmitry,

Thanks for the review.will fix my code.

Thanks,
Sundar

