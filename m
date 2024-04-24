Return-Path: <linux-kernel+bounces-157637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852C98B13E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFE61F245E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05C313BC19;
	Wed, 24 Apr 2024 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDcyreCe"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35ED134A8;
	Wed, 24 Apr 2024 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988850; cv=none; b=iyKSMl1kUAKA8maViUNMXJRflltIEOhBjO8grHs9cYH53yqjKf8pCYaEhr3Ijnx27W0RKOh/eJ9BjUvf/pDIT/y4GYPVKSE9mysm3x5RA9A75cCRQtNeQ4KohLTIwD0pndeENlaM7s9svs40hv3Y7+yGqpxIMA/E+yOyqFvYrwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988850; c=relaxed/simple;
	bh=vtAPjlWlcBGTRf8Hs0iaIMYlThoupqnIr67GAokTmTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sclt8BCSicfLq6eGpzTANvRINhvJN0rtXW8VJpTV7cBogk/zkaeIRITsZZl//3xQsbYapchna5yxWWqAH56Q/MXTQIUymxQlqjILo5su3aCp92QQNtYnET4+S2Vcu6G4rsCGUgQTAlFT+Ym4SPlKHvFNLZvsRvwRR1Lf7g5Enmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDcyreCe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6001399f22bso197198a12.0;
        Wed, 24 Apr 2024 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713988847; x=1714593647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jV6MUXeyQ8mtFanrkE7vNSEtzBB22JlN0e9Q4p3iGe0=;
        b=EDcyreCe838k3yqGDE8pH23TeoEESEr6r+CZyO+EOZi8pbd0R3jY5/GmsZoyP7mShI
         3xhJ7x5S+Vp/eKhdHPet/Y8nlFnYx0W8RmueUbc91ElInJs9SqkhJLwE+prEtPwvsLB7
         G9csp7tG2fVqKuzkKadQrPtnQhLLTGccKTAXk0FIpSg4jXD62rg+XPugzT35R4/22FOM
         xl2oEvAAw8jVkOt8p/E4mX7FbJdYqc1EujadEFp13479LCuS/AP0jDvn5y7+P/qlDYP3
         prvLItpa/6V51Qvn7LXoBRv53YsH/l6D9sJlYArKX8/g1mRWR+kJgP8oW+TomYeDHqi2
         +mxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713988847; x=1714593647;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jV6MUXeyQ8mtFanrkE7vNSEtzBB22JlN0e9Q4p3iGe0=;
        b=L+hf65MnvbQKsEkiwSenSgQoh8w1q+/7FQDouhPXTiiSJfU5p17uVrj8gBRHVDD/ok
         x8YW+2Bo/7bp1KlFoIpYy3li70FIQLmT3qomBRxovZJ9AsCXqA0Xbv4VaybStVKGNTP2
         PTeDKAikXUSCxi9xItWb71eQS3jTbUnoCrbuUVMJTMa3r4PlDctg1sYsUEpari+NewYy
         /epW83tRmTYC2m24pR71u0tC11edbn6a7XK06X7LBVif5SVJKFmW97fVbJWL3mZsLljI
         I09rm/ahbfuOIFEmz/ItBoCouP0gBneW5xjqiHSXqkGddfsrYbytoiyiDlyEK0SwdM4a
         kjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS/r0kOEBXEaXd+A/e9/vvT6daEu/YMjAZAdVrxWEAzoXUx3wp+/4yqDW7Grj/2DV/m7c+bLxSZVyXth7BDu5r4lGDMBaVWgAoc/fZVBwcJ4GdZOIGj2B6Ytn9oEEPu/8vmJ4LiJ19Y1U=
X-Gm-Message-State: AOJu0YxwxIjI1W7kqjBNUadPQtaeH+qYc+SwZ5yRTO16+YGsQdLM6C4x
	IOuJ+qwxxpKg0UHanGWeR6dn0/yA3Cmvyhc/dzpEBv/HMLPpPT6q
X-Google-Smtp-Source: AGHT+IF3tdT+Voe6FbyaDgPeESawKMwvuQSHi/XWYYqQ0IKRmNnkRDZlpZ1JDs1UUq4fy+Trdw+XXg==
X-Received: by 2002:a17:90b:4d88:b0:2a5:c3a7:39d9 with SMTP id oj8-20020a17090b4d8800b002a5c3a739d9mr3315119pjb.45.1713988847192;
        Wed, 24 Apr 2024 13:00:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a5-20020a1709027d8500b001e3c77db2aesm12349458plm.88.2024.04.24.13.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 13:00:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8b138aec-9565-4847-8c7c-8a1fe6972a04@roeck-us.net>
Date: Wed, 24 Apr 2024 13:00:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 55/71] hwmon: (peci/cputemp) Switch to new Intel CPU
 model defines
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Jean Delvare <jdelvare@suse.com>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181534.42216-1-tony.luck@intel.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240424181534.42216-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 11:15, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/peci/cputemp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
> index a812c15948d9..e8dafa748a41 100644
> --- a/drivers/hwmon/peci/cputemp.c
> +++ b/drivers/hwmon/peci/cputemp.c
> @@ -361,9 +361,9 @@ static int init_core_mask(struct peci_cputemp *priv)
>   
>   	/* Get the RESOLVED_CORES register value */
>   	switch (peci_dev->info.model) {
> -	case INTEL_FAM6_ICELAKE_X:
> -	case INTEL_FAM6_ICELAKE_D:
> -	case INTEL_FAM6_SAPPHIRERAPIDS_X:
> +	case VFM_MODEL(INTEL_ICELAKE_X):
> +	case VFM_MODEL(INTEL_ICELAKE_D):
> +	case VFM_MODEL(INTEL_SAPPHIRERAPIDS_X):
>   		ret = peci_ep_pci_local_read(peci_dev, 0, reg->bus, reg->dev,
>   					     reg->func, reg->offset + 4, &data);
>   		if (ret)


