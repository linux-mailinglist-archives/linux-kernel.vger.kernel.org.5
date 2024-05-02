Return-Path: <linux-kernel+bounces-166712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE5F8B9E73
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453142831F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE6215E200;
	Thu,  2 May 2024 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPshHAw+"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBFF14A634;
	Thu,  2 May 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667040; cv=none; b=kDwe3wv0wRCGYyIVwG+LUlvmNSjEvKvqpmCjt3Lf9XkUoX5Tug4sug4UD7WXTwhTLzhdLiHg32s27lh7cMchH8tutgmkPVbtDCDOXaiRhMKIIrQ7KAeyC6zlrEOtJKcDXR5gSpVQFQJnGZ9toKjJ/jlQcHb3Dm3tEtvEwOkCy5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667040; c=relaxed/simple;
	bh=66YOgsmohBXvJp4T81vSLjeFlQrvgZ5on0WeVnORq7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6d0DRFSzWwj+KWAIqIpI3meaKZQEMyJKlp3gjqJuTZihcOs9mcxDO/PRVXGDEgIy+QtYNhua9cltxYm98Hl/qRhVWqsz66w1O5PIq2IiC4Zwve7R02zGciHL0glqq0aC14ulbhJlucSHjkdLzHbRDmsXDzIvifNG5Mzzq3zflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPshHAw+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecddf96313so9793415ad.2;
        Thu, 02 May 2024 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714667038; x=1715271838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ByJlhiDFaKaaD0s+HlejNv3NTGIXQ86sKjMQDl0Lm/c=;
        b=IPshHAw+ztNKz5AhdI76bpYzYfOoCSVbZ95/JIlLIulaA0qRPRiK+AuX7/gcXfNqM9
         yr28UDui3nrMHuXQoDU4hpCVRYvYqh7LBlbOQtIilvZ5kDtuU5LmgpUwMWRdstrjbSkG
         AJk2hc0NtQC8WAZAzY2Z4hOm2fU8n/Sskc90zeHWL3rnBycvxR5cPPhEg339Q7Jsv0dd
         nYwUk/ds8cJdOg9eAfPhUpcHtym4o2lvX+c0IMbN31OryKRTiWnlK50A0hOgjWySgSDJ
         fYQ5W+I4YozlioNgP2AOTKg2ac4+h4RiQn27Hp1T5QbTP/dBZn+1LaehOrnmuozlNqxJ
         Jobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714667038; x=1715271838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByJlhiDFaKaaD0s+HlejNv3NTGIXQ86sKjMQDl0Lm/c=;
        b=a03oSYt/mn9oFbAwP95dp5i/l43XDDeX3m75yzamMvqHj1EqK9ooT+D1NzS2qdmyy6
         hbL+MKRtwzKK+sarnqcK7yBzh1aHIgCatRNg85WwaN8Bv3XozGPUy/PHD3tsE2Lm+zhV
         zhHZ0vqr3ykpjR/DQIuxhGd/6Z7tuPOMhubNgchlL9ruJ4Ri/m1uSoQz8TXEnYL7pxW3
         FqH4YvI6/HgHqHYJXhLaXUipMJPwpB/VqM24socRoeFPWAI8dKd/dWtrUdXHL9qvbn/d
         cY/2TmGZowA+34Q6GHMISmcRJwWZXuYvwdMGJkj7zG7s5i155i2b7kuVFaFLV+nYq2s4
         V2qg==
X-Forwarded-Encrypted: i=1; AJvYcCU8kZxQO+VG6BLAjBCLd9+apEOkfU/WG9i6bI3G3FhwtpHQGl2nX8AEy8odwtHKJRSkUZ0VKHzHZWDMmLnZ8ZNp+sJZ1jSPkEOmVRUX
X-Gm-Message-State: AOJu0YwNm9aNky8bQEKRI81y6cJyiK6I5c76Sjegj6EvVJUP/70Blz1T
	K/Y16iPPYDVINNwz7VdBmVXOdGV0ItTK/VTiEeS9ajzX8JWO+XQNuxxnoCX8
X-Google-Smtp-Source: AGHT+IFrI/3bevqRuEF2wvquGRLwRPi+UlnbLOjftb29T5BL0MhuPczQYXex0T9fCT7A3p22wjg+oA==
X-Received: by 2002:a17:903:2284:b0:1eb:2f02:cd0d with SMTP id b4-20020a170903228400b001eb2f02cd0dmr269664plh.0.1714667038027;
        Thu, 02 May 2024 09:23:58 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:622d:192:3faf:5ac1? ([2402:e280:214c:86:622d:192:3faf:5ac1])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902d4c200b001e45c0d6be6sm1496530plg.246.2024.05.02.09.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 09:23:57 -0700 (PDT)
Message-ID: <97b8fabe-2bc9-4d14-a3b3-bb1356a7e642@gmail.com>
Date: Thu, 2 May 2024 21:53:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 linux-next] usb:typec:mux: remove indentation for
 common path
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
 neil.armstrong@linaro.org, dmitry.baryshkov@linaro.org,
 u.kleine-koenig@pengutronix.de, christophe.jaillet@wanadoo.fr
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
References: <20240426164705.2717-1-prosunofficial@gmail.com>
Content-Language: en-US
From: R Sundar <prosunofficial@gmail.com>
In-Reply-To: <20240426164705.2717-1-prosunofficial@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/04/24 22:17, R Sundar wrote:
> Nitpick, Mostly common path will not be indented.  so rewritten this
> function to check device_node pointer is null and removed common path
> indentation.
> 
> Signed-off-by: R Sundar <prosunofficial@gmail.com>
> ---
> 
> Fixed nitpicks in code according to comments received on other patch as
> below:
> 
> [ Nit, this function should be rewritten to not work like this, the
> "common" path should not be indented, but only the exception (i.e. bail
> if ep is not allocated properly.) ]
> https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/
> 
> Goal is to get rid of of_node_put,but sending this patch first to do one
> thing at a time.
> 
> Changes since v1 - fixed the typo error for spell from identation to
> indentation
> 
> Changes since v2 - Shifted the indentation to one level left for the
> switch cases as per coding style.
> 
> Changes since v3 - Added descriptive subject for the patch and checked
> from and sign-off having same name.
> 
> Changes since v4 - Fixed name in signed-off-by as in documents.
> 
> Patches link:
> ------------
> v1  - https://lore.kernel.org/all/20240420145522.15018-1-prosunofficial@gmail.com/
> v2  - https://lore.kernel.org/linux-usb/20240420164927.15290-1-prosunofficial@gmail.com/
> v3  - https://lore.kernel.org/all/20240421011647.3027-1-prosunofficial@gmail.com/
> v4  - https://lore.kernel.org/all/20240424150718.5006-1-prosunofficial@gmail.com/
> 
>   drivers/usb/typec/mux/nb7vpq904m.c | 68 +++++++++++++++---------------
>   1 file changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
> index b17826713753..f7a00b388876 100644
> --- a/drivers/usb/typec/mux/nb7vpq904m.c
> +++ b/drivers/usb/typec/mux/nb7vpq904m.c
> @@ -320,47 +320,47 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
>   	int ret, i, j;
>   
>   	ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
> +	if (!ep)
> +		return 0;
>   
> -	if (ep) {
> -		ret = of_property_count_u32_elems(ep, "data-lanes");
> -		if (ret == -EINVAL)
> -			/* Property isn't here, consider default mapping */
> -			goto out_done;
> -		if (ret < 0)
> -			goto out_error;
> -
> -		if (ret != DATA_LANES_COUNT) {
> -			dev_err(&nb7->client->dev, "expected 4 data lanes\n");
> -			ret = -EINVAL;
> -			goto out_error;
> -		}
> -
> -		ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
> -		if (ret)
> -			goto out_error;
> +	ret = of_property_count_u32_elems(ep, "data-lanes");
> +	if (ret == -EINVAL)
> +		/* Property isn't here, consider default mapping */
> +		goto out_done;
> +	if (ret < 0)
> +		goto out_error;
> +
> +	if (ret != DATA_LANES_COUNT) {
> +		dev_err(&nb7->client->dev, "expected 4 data lanes\n");
> +		ret = -EINVAL;
> +		goto out_error;
> +	}
>   
> -		for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
> -			for (j = 0; j < DATA_LANES_COUNT; j++) {
> -				if (data_lanes[j] != supported_data_lane_mapping[i][j])
> -					break;
> -			}
> +	ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
> +	if (ret)
> +		goto out_error;
>   
> -			if (j == DATA_LANES_COUNT)
> +	for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
> +		for (j = 0; j < DATA_LANES_COUNT; j++) {
> +			if (data_lanes[j] != supported_data_lane_mapping[i][j])
>   				break;
>   		}
>   
> -		switch (i) {
> -		case NORMAL_LANE_MAPPING:
> -			break;
> -		case INVERT_LANE_MAPPING:
> -			nb7->swap_data_lanes = true;
> -			dev_info(&nb7->client->dev, "using inverted data lanes mapping\n");
> +		if (j == DATA_LANES_COUNT)
>   			break;
> -		default:
> -			dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
> -			ret = -EINVAL;
> -			goto out_error;
> -		}
> +	}
> +
> +	switch (i) {
> +	case NORMAL_LANE_MAPPING:
> +		break;
> +	case INVERT_LANE_MAPPING:
> +		nb7->swap_data_lanes = true;
> +		dev_info(&nb7->client->dev, "using inverted data lanes mapping\n");
> +		break;
> +	default:
> +		dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
> +		ret = -EINVAL;
> +		goto out_error;
>   	}
>   
>   out_done:

Hi,

Any feedback for this patch?

Regards,
Sundar

