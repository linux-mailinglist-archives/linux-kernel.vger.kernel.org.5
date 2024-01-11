Return-Path: <linux-kernel+bounces-23744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A5482B107
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D152864D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED680495D5;
	Thu, 11 Jan 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLpoCwJs"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D39495CC;
	Thu, 11 Jan 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbd99c08cd6so4564804276.0;
        Thu, 11 Jan 2024 06:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704984687; x=1705589487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5Djge+IjvrNE9Lo0xIlsTNMy8bmtGShPiX/Odnhew6M=;
        b=dLpoCwJsRfqNh2P9mTiSva19nWDzRWVHf4lzZxgS/nKFUft+y+hHwpDntYe4GeEKc1
         ileGb1RAuWe+shfanTMrXX+FWPU5qZ8N/CVeJ0VJZtqNqcs34SMnhyj9a3D3hpnycXdc
         rcBecMS1kKjaxxRJ58oFO7RYLUs4+NPe4ZUz66uckLe0mTPqeZkCJFwVKOD7E56zZ4AK
         F6vDH1qM/DJ3g3mtcBYiBFp+nNcJVG8I/jnDqqBj5zyuHYdHamFnHNDXiqSNR4itrieI
         851sEy1IY3cnfilw010XptHzxvqajgnnoBVTMVjIvQH2AT/7qJSYbVZjgtd4mRjlfbrO
         HkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704984687; x=1705589487;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Djge+IjvrNE9Lo0xIlsTNMy8bmtGShPiX/Odnhew6M=;
        b=eX5AjPu227+5Bumem1u1sps4OWqO2DIUzBj7JVba6r/DIUrINs5N561UWz1DYmrWS4
         qdYPVw0w6m7EiNEgPFVHuXTW3BPNOkm4aLOmp540L0+QPkLdtB5vTHbDKwpGh2yk42/r
         wm9LLlDWaIJqV2DAZjetTyXLgon1DFrQ3fH0NqlphUZ8EgoTMmhfqn0kp1FoXz8YBWVK
         c8NKwyqmOnd+srq+6NrPbVkCRvZQjPv/cyR0LnoYiuwGGBpgxV2YNQIaeR9OzfSheCl6
         iDSRRK/fz/y0U2LvxrDFTCYh3H8hDKDEHvuyasEwHJbi7JNKreCL8n52zqFIyhv0Ba9L
         o5Fg==
X-Gm-Message-State: AOJu0Ywk9wutT2heYjo26QRuDauwN6XHr8UELm8KkFYmAzuoK+oYSkS/
	DISqeBkfLuqRzynb42H7cIk=
X-Google-Smtp-Source: AGHT+IHBBpD/WTVpM0Esme9Z9pLLOcpi3G8JgCtEUVCCCVtaAJDq9xpu/6xRyyg1EXAWSj+6rCacdQ==
X-Received: by 2002:a05:6902:2192:b0:db5:4bb1:36df with SMTP id dl18-20020a056902219200b00db54bb136dfmr1449747ybb.57.1704984687251;
        Thu, 11 Jan 2024 06:51:27 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 20-20020a250b14000000b00dbf335494e2sm414589ybl.34.2024.01.11.06.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 06:51:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <73eda412-18cf-4c1e-8764-8341c2254659@roeck-us.net>
Date: Thu, 11 Jan 2024 06:51:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: qcom: fine tune the max timeout value
 calculation
Content-Language: en-US
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111-wdt-v1-1-28c648b3b1f3@quicinc.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240111-wdt-v1-1-28c648b3b1f3@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/24 01:49, Kathiravan Thirumoorthy wrote:
> To determine the max_timeout value, the below calculation is used.
> 
> 	max_timeout = 0x10000000 / clk_rate
> 
> cat /sys/devices/platform/soc@0/b017000.watchdog/watchdog/watchdog0/max_timeout
> 8388
> 
> However, this is not valid for all the platforms. IPQ SoCs starting from
> IPQ40xx and recent Snapdragron SoCs also has the bark and bite time field
> length of 20bits, which can hold max up to 32 seconds if the clk_rate is
> 32KHz.
> 
> If the user tries to configure the timeout more than 32s, then the value
> will be truncated and the actual value will not be reflected in the HW.
> 
> To avoid this, lets add a variable called max_tick_count in the device data,
> which defines max counter value of the WDT controller. Using this, max-timeout
> will be calculated in runtime for various WDT contorllers.
> 
> With this change, we get the proper max_timeout as below and restricts
> the user from configuring the timeout higher than this.
> 
> cat /sys/devices/platform/soc@0/b017000.watchdog/watchdog/watchdog0/max_timeout
> 32
> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

[ ... ]

> @@ -268,11 +271,11 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>   		wdt->wdd.bootstatus = WDIOF_CARDRESET;
>   
>   	/*
> -	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second
> -	 * default, unless the max timeout is less than 30 seconds, then use
> +	 * If 'timeout-sec' unspecified in devicetree, assume a 32 second
> +	 * default, unless the max timeout is less than 32 seconds, then use
>   	 * the max instead.
>   	 */
> -	wdt->wdd.timeout = min(wdt->wdd.max_timeout, 30U);
> +	wdt->wdd.timeout = min(wdt->wdd.max_timeout, 32U);

This is an unrelated change which would have to be discussed separately,
in a separate patch. But I really don't see the point of it.

Guenter


