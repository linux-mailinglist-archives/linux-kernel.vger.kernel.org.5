Return-Path: <linux-kernel+bounces-45801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5858984365F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6158285FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11173E477;
	Wed, 31 Jan 2024 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab/IJojY"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3180C3E46B;
	Wed, 31 Jan 2024 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680881; cv=none; b=TQUZbywfKUMGvLDNGf0rG9jhCEYRVHZMK3Uwc2X5yEQiwtmP9d/JgewoqZDMne+G7uyUes0AEnGdCCWj8q4dxiuuD6jDNU1OYWMHsaEUC2vejKd5oqptG1uOMX4dTscSpI0MD4uATY1YBdHet/2JqbMEzM81uYTCvmSbFZ+Gg3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680881; c=relaxed/simple;
	bh=NEnY0eMPOlLKjUxvivCMOJQhrAWo3oDLZhH5bmOUHQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EC0Iksil/he+y3wncGt2qJD595Vhgy3G5Fi8cFZdNGu/6WRE+3FEviVyE6pUYGFCRw3+9BBH+mJq/9Fjs0bqi13eRiidQT8BWrBL6AQ0f27mNFUPYgOAe96SGupzkNI5axPlXPUKOj1Tyj9Z2niqyOWdRYmAeXmEhZlw7bMbYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab/IJojY; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e1352dd653so1458291a34.2;
        Tue, 30 Jan 2024 22:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706680878; x=1707285678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3d59pSZFrotxa5OB09tA6yrFpKxzayWubKgHGCJEqP0=;
        b=Ab/IJojYXqC8NzrXPOsQctVPYUVhQEWDKdZ9w44HC43qmGKsaYa9dwJ4ikDC4fNHbX
         v1+qgQ8ek3JBnecP+80Bz3hzSTLeo3xQotchgkewr0GvJTFzpt5RL7nk2zg1yNPoq3Wu
         Ot5rjVWcIL/LaVRP1YJQ+qhiGYEtLwEGJmHGVzo718U1tElxjFR94QBAZYBblk1fJyVA
         +iHu7lPLU3WkpelycEVpwRzWHoRNNjqsYpGwAqFcHlXMMb7zw9vUZkljiGOx3xiOO636
         pV2tbGTfblOrsCZMRT2YABAkZJ8KQcnFqp56itOp9TBNCbzcsIaulQGaArzvxS4bEr6a
         JNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706680878; x=1707285678;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3d59pSZFrotxa5OB09tA6yrFpKxzayWubKgHGCJEqP0=;
        b=rQoZfFN9uEr7L/oLPkit5aqOvd/ZGG3WK5qubUl+46gxMUsiTGHx21NagUvJGuxysL
         LP5aWo0JmE55VM/DatfJKA8knT3l4lXKzU31Zx9efb2QeGp7oAgEXas7SJ5vMI+XGLTu
         HVVLeB8MlK3TkgvOGij9JEJpnY6x1xVKCgTnNX3POo5wJz5EREcuk1SgNzxgrMkDPKeX
         Y6/B37Q/GwyoYtYstdi6IHMEtGZcR98MtlER17eKP3sKrsNaX0rtHqSfed68EoUYvQVE
         FOHI/KR9c1wi3rx5nj0tTttGrF7u2c8B1yKmujwBmm7QTtkH9EIPMRRV6Y35W67xIRlj
         AoEw==
X-Gm-Message-State: AOJu0Yxx8pqCE9YV5hoSuQ1/OxOcyPkCj7M6VL6vR83HctDC6MsoWt2/
	5HFWA/VsyFg293osqqYgkPUmuB7JPxLIOyakpbzdzV9ndRfY8tzt
X-Google-Smtp-Source: AGHT+IFen+FDfjlBIeidg23Urvr88JScP5kLZW1IYd4CA5oBP1lCslXPTD2pKl7tL3WrbAEkIMOXQA==
X-Received: by 2002:a05:6358:60cc:b0:178:6d3d:4cc1 with SMTP id i12-20020a05635860cc00b001786d3d4cc1mr543296rwi.24.1706680878039;
        Tue, 30 Jan 2024 22:01:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n26-20020aa78a5a000000b006ddc87c1780sm8916401pfa.63.2024.01.30.22.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 22:01:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1a996038-bcc7-4c0f-8f27-ca36a2eb9d3d@roeck-us.net>
Date: Tue, 30 Jan 2024 22:01:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: qcom: Start the watchdog in probe
Content-Language: en-US
To: Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
References: <20240131-qcom-wdt-start-probe-v1-1-bee0a86e2bba@quicinc.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240131-qcom-wdt-start-probe-v1-1-bee0a86e2bba@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/24 20:15, Pavankumar Kondeti wrote:
> When CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is enabled, kernel can pet the
> watchdog until user space takes over. Make use of this feature and
> start the watchdog in probe.
> 
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> ---
>   drivers/watchdog/qcom-wdt.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 9e790f0c2096..4fb5dbf5faee 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -276,12 +276,16 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>   	watchdog_init_timeout(&wdt->wdd, 0, dev);
>   
>   	/*
> +	 * Kernel can pet the watchdog until user space takes over.
> +	 * Start the watchdog here to make use of this feature.
> +	 

No, that is not what CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is about.
Please see its description.

NACK.

Guenter

>   	 * If WDT is already running, call WDT start which
>   	 * will stop the WDT, set timeouts as bootloader
>   	 * might use different ones and set running bit
>   	 * to inform the WDT subsystem to ping the WDT

>   	 */
> -	if (qcom_wdt_is_running(&wdt->wdd)) {
> +	if (IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED) ||
> +	    qcom_wdt_is_running(&wdt->wdd)) {
>   		qcom_wdt_start(&wdt->wdd);
>   		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
>   	}
> 
> ---
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> change-id: 20240131-qcom-wdt-start-probe-b8e0560aef7d
> 
> Best regards,


