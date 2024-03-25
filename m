Return-Path: <linux-kernel+bounces-118064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F69B88B339
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825AF1F64A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B23E6FE15;
	Mon, 25 Mar 2024 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLVQ5GoF"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF56F525
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403646; cv=none; b=K7E4uy45DFo29t/jIC/ZZ5POr0cckg2TncGf41MTFJrJqUMXMVwpMiLwapD7qaLuSWuCmrU9iJqwCuuZN0/f2CSroYszc5IWXvQHq/0HGxUIjB9cARa37WEM5gRl7wK+txldvmwx81MqtBy3AjUPFngzzE5kgshnZOQlCyH2YrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403646; c=relaxed/simple;
	bh=nL+Uzlfw/AaAFx1mcC0U5lbqyulPaq575q6dcQpJgK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8lyvdJH5O0zMDzoatlZ9hNZZg64KzVfriRwQhP2HizkGYugrKTcAOq/385Rh4qI2AD+fQgOIz6MFIPr/l8c2XQ+kmJdc/hmHbDFe4y5WkghVkX+rDKoDTV6Y2Gh9g0iLBxlgtMb6RgYUzvJ4oZd9aFu4tSs0WS0jVCgyjIFhiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eLVQ5GoF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a45f257b81fso566832066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711403643; x=1712008443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rWkdxwCEceF+/Lm+DvMTGD7B4AzBOLQ6FiIdwSXTWbs=;
        b=eLVQ5GoFPkbs5YsHPE0BhyGz8X5YFfjebmwjv4l17nOsg7VMxdAObpHteeYUgcLOn+
         QGDLo2k5gZBs5/v/Ui28Qw5tmOIjAtuQdYsmdkHOjyPA1sh71Vk0Is14ZEtRQIrWATBZ
         7CPYlHZuvOWDcBkWs0EsFwWTXZAt/F+3XPP0xwAFl4smWUauYQAsdQ30z6AMLlZE5OSh
         38pvvudIh6zQzCaKpo5xINSlke1h+/A4ZzjbzKQyDjm5Qi5OIF8kZqBh450/hhFcSK3w
         Rzxh+4vLPzkL++m+lBS8KO2yA99mNQCrUQ/NqK4xBhT1iY0sz7aRj/Bjmoo0P0DztOVE
         aFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711403643; x=1712008443;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWkdxwCEceF+/Lm+DvMTGD7B4AzBOLQ6FiIdwSXTWbs=;
        b=EAsyj01H9g9XPxr4BC+vz9jBGUA2ccsgGatY25UJ4+4esd81nizcl3VNc0h2BzPLzP
         Bj20zQxyyWuzMeC/VZq0EbruiGReCxXL+Fs0l4icIBEGQ3WmGHXX5NlBbgSiymYWId9T
         N7oh6/05eP9qjj4FjYHigz3img/LKSLApaJkjWaGHc27uXbVqh3+/zTrKJyMU5Il4lVd
         gw+IWA1FJ0+uaHAfDMRClu+FpfxsMCfJIfLXKMng3hvnNSEJLF14IMuhllFmoeMhy/9b
         B1qLwgjUECU1jKPHOtRRMYwEP8f6ox6I7gtnvfZqGAIlbCQcKlQgnHRLB9r2zKYCLKAL
         vk+A==
X-Forwarded-Encrypted: i=1; AJvYcCUzQr7vIww+gXE2fqQSfEJrhCFCYS2/cxVsZfVB6fUWcYSERXIMFKBeY/5LgezBBsVOgknyKUZSGRt3sjIJFvaqbdQE1hLBhknFb+wS
X-Gm-Message-State: AOJu0YxDJaFEVAmtVnUQFL6QYgDisOU9JfNCy5QOMToD9IkYgJ3gzkZZ
	L/V9ayj/URso7g1XjoeC+u/SSkHqbcSnZH5UIM9vJ0JluHgvRpRCgDqtwElaUdk=
X-Google-Smtp-Source: AGHT+IG7qNlR1X29KZcs7p5CEho85/VXgcbCXQHPb8ot+hckQCdkCOZRVe5k1lbC2ZMrN36t5Wv0Fg==
X-Received: by 2002:a17:906:4a1a:b0:a46:aed5:2552 with SMTP id w26-20020a1709064a1a00b00a46aed52552mr5578519eju.45.1711403642692;
        Mon, 25 Mar 2024 14:54:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id h4-20020a1709060f4400b00a4628cacad4sm3445416ejj.195.2024.03.25.14.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 14:54:02 -0700 (PDT)
Message-ID: <de4c8f93-b688-4607-9aa5-bb061c947963@linaro.org>
Date: Mon, 25 Mar 2024 22:54:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] virt: vmgenid: change implementation to use a
 platform driver
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com,
 dan.j.williams@intel.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: graf@amazon.de, dwmw@amazon.co.uk, bchalios@amazon.es,
 xmarcalx@amazon.co.uk
References: <20240325195306.13133-1-sudanl@amazon.com>
 <20240325195306.13133-3-sudanl@amazon.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240325195306.13133-3-sudanl@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 20:53, Sudan Landge wrote:
> Re-implement vmgenid as a platform driver in preparation
> for adding devicetree bindings support in next commits.
> 
> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> ---
>  drivers/virt/vmgenid.c | 101 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 74 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> index ea956df02874..d5394c706bd9 100644
> --- a/drivers/virt/vmgenid.c
> +++ b/drivers/virt/vmgenid.c
> @@ -11,6 +11,8 @@
>  #include <linux/module.h>
>  #include <linux/acpi.h>
>  #include <linux/random.h>
> +#include <acpi/actypes.h>
> +#include <linux/platform_device.h>

Do not add headers to the end of lists.

>  
>  ACPI_MODULE_NAME("vmgenid");
>  

..

>  
> -static struct acpi_driver vmgenid_driver = {
> -	.name = "vmgenid",
> -	.ids = vmgenid_ids,
> -	.owner = THIS_MODULE,
> -	.ops = {
> -		.add = vmgenid_add,
> -		.notify = vmgenid_notify
> -	}
> +static struct platform_driver vmgenid_plaform_driver = {
> +	.probe      = vmgenid_add,
> +	.driver     = {
> +		.name   = "vmgenid",
> +		.acpi_match_table = ACPI_PTR(vmgenid_ids),

ACPI_PTR does not make sense. If this can be compile tested !ACPI, then
this is wrong. If this cannot be compile tested, then this is redundant
and confusing so... also wrong.

> +		.owner = THIS_MODULE,
> +	},
>  };
>  
> -module_acpi_driver(vmgenid_driver);
> +static int vmgenid_platform_device_init(void)
> +{
> +	return platform_driver_register(&vmgenid_plaform_driver);
> +}
> +
> +static void vmgenid_platform_device_exit(void)
> +{
> +	platform_driver_unregister(&vmgenid_plaform_driver);
> +}
> +
> +module_init(vmgenid_platform_device_init)
> +module_exit(vmgenid_platform_device_exit)

Why this cannot be module_platform_driver?



Best regards,
Krzysztof


