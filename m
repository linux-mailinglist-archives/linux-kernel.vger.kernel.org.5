Return-Path: <linux-kernel+bounces-27488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8942F82F0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7E21F2433A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2AE1BF48;
	Tue, 16 Jan 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q93afQY/"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83801BC31;
	Tue, 16 Jan 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d542701796so52807055ad.1;
        Tue, 16 Jan 2024 07:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705417370; x=1706022170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kc8D52p6VWEioVoqD1qBkWwkmzVf2ZP4HXJmc9aOVzg=;
        b=Q93afQY/Na8i4gFmGjRWMyTBhs1cwpmtV9bLgVfGHjEjJC/uPEU4z/1NrQKLhP6mLt
         vOJgetZ4x5TaOIkAc3Xpp/Fhpvbcdu571/DDeeCumfGW4jMWo+9jkkLLEnEm1zRjeQq+
         W7BzTQPeAR9+4Fl0lJEbCuwDP7hhg9M8Cy0m/icgQi/H9iFT9g68iGazx+Sq2ZSjxCwW
         M1mejZ8wo+VU1HWTdGMhrmDqGArGBp3YleVlX2NkWfzPGZcpGfFPSqH4wPAkftzCtn+J
         nMGobmZj1rRcb0UL99sKnF05Y7JPlC3DaSTtpYtA72Ju3oebEb5T/OynnCtaff2zj0NJ
         FMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705417370; x=1706022170;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kc8D52p6VWEioVoqD1qBkWwkmzVf2ZP4HXJmc9aOVzg=;
        b=t8tN4qhx32Bw3G7fg+nDJtLAxqnbj/LVYKOzCfRp1xrO8MQcZNbWQ8UUS+9i7R/GWL
         slTwvZadByw1xAz8QeMSeDREH+jfeoshGY3TJrAuvPB/2fFtBz4esx6zjraRKEbC0x/b
         WlMQfnlbh3ecicG63L5ljfv9E8gQlX/c7xB0GOaaIfZ4Z1HKuMIAHiyLxVlfyrz3XCaH
         drDL2tEEpVTHrbRsumzBaPjQOflOWOQLmWzuu6vaASSVEsDGUEu6svk/p/Pl2xWxShzk
         QHo+/t9fKwpLwtviQ/rKkMSUo3gDvsLBh14mrMd6NBPNdXdaCQmBqQLr/COfFw8vaHm3
         owMg==
X-Gm-Message-State: AOJu0Ywa4Rp7xoXxFtUyxulheMphxgd+1h2FUNN3H6SUAbCxCctJpqC+
	2t6heQUUEVkFtDRebCvJ2l8=
X-Google-Smtp-Source: AGHT+IGhSWY6lzeqy6rIXZJdscPDUDTBk3QAvuoEoEgn5yB0vJSb/q6qe2jAlDe1bjplKVjVMi1Msg==
X-Received: by 2002:a17:902:d504:b0:1d4:caea:5fb5 with SMTP id b4-20020a170902d50400b001d4caea5fb5mr4807096plg.32.1705417369696;
        Tue, 16 Jan 2024 07:02:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902788800b001d5a17ee237sm8013094pll.155.2024.01.16.07.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 07:02:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2c4f9829-138d-41a5-8810-d13cf749fded@roeck-us.net>
Date: Tue, 16 Jan 2024 07:02:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: qcom: fine tune the max timeout value
 calculation
Content-Language: en-US
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240116-wdt-v2-1-501c7694c3f0@quicinc.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240116-wdt-v2-1-501c7694c3f0@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/24 00:22, Kathiravan Thirumoorthy wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
> - drop the minimum timeout change from 30s to 32s
> - Link to v1: https://lore.kernel.org/r/20240111-wdt-v1-1-28c648b3b1f3@quicinc.com
> ---
>   drivers/watchdog/qcom-wdt.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 9e790f0c2096..006f9c61aa64 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -41,6 +41,7 @@ static const u32 reg_offset_data_kpss[] = {
>   struct qcom_wdt_match_data {
>   	const u32 *offset;
>   	bool pretimeout;
> +	u32 max_tick_count;
>   };
>   
>   struct qcom_wdt {
> @@ -177,11 +178,13 @@ static const struct watchdog_info qcom_wdt_pt_info = {
>   static const struct qcom_wdt_match_data match_data_apcs_tmr = {
>   	.offset = reg_offset_data_apcs_tmr,
>   	.pretimeout = false,
> +	.max_tick_count = 0x10000000U,
>   };
>   
>   static const struct qcom_wdt_match_data match_data_kpss = {
>   	.offset = reg_offset_data_kpss,
>   	.pretimeout = true,
> +	.max_tick_count = 0xFFFFFU,
>   };
>   
>   static int qcom_wdt_probe(struct platform_device *pdev)
> @@ -236,7 +239,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>   	 */
>   	wdt->rate = clk_get_rate(clk);
>   	if (wdt->rate == 0 ||
> -	    wdt->rate > 0x10000000U) {
> +	    wdt->rate > data->max_tick_count) {
>   		dev_err(dev, "invalid clock rate\n");
>   		return -EINVAL;
>   	}
> @@ -260,7 +263,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>   
>   	wdt->wdd.ops = &qcom_wdt_ops;
>   	wdt->wdd.min_timeout = 1;
> -	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
> +	wdt->wdd.max_timeout = data->max_tick_count / wdt->rate;
>   	wdt->wdd.parent = dev;
>   	wdt->layout = data->offset;
>   
> 
> ---
> base-commit: 9e21984d62c56a0f6d1fc6f76b646212cfd7fe88
> change-id: 20240111-wdt-5bd079ecf14d
> 
> Best regards,


