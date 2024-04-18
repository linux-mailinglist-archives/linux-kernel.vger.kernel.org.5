Return-Path: <linux-kernel+bounces-150598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5B48AA177
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4231C224D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D74F179650;
	Thu, 18 Apr 2024 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHRL8t7H"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52E178CD2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462686; cv=none; b=T+ZxhTSr0G9h1O27Rxyihiel9iSvHGSbjNIxTkVFPNixNunLUMMXFObpq7kJVPLX+fAoD+E3BXKui/+6A2yAVZPqdj+69RF+2+CFvdcd//5Iuhqk/pMg9YJfpgyR+YBJPfe/VvyG8kd4NxTFdqBUEgTWWcvpD94X0ZBYz2kua5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462686; c=relaxed/simple;
	bh=KdBXRsvK2CVr4aB7wlqRzi1vOez4nde2qg+3HRaBgTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6lzzY9GRutSF3FfMRQPP0ndaS7ZynEB9u0nWvvQBWzlHY0L3qQfmpjUnVPJ+nYQRDAQ55rmIlKg+7uCUKwEmaUsuQphlp5apoZNgMm/ZqPgWjE07td6xOKbbUEOSP493KZp0x7qjyGq2jpmJ5NiE8LKTT3gOCtz5QZwhpXD/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iHRL8t7H; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a52c544077so941537a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713462685; x=1714067485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bEWmndW1cSbjh0xIBdu/vAc29pKfsBmdXaqbFNxBkMQ=;
        b=iHRL8t7Hf05DxlN4zLvnU8Ud/zeWCA/Zk5tU2pQmE9jqTV6OnvHuPp5iELJWTP2hca
         7MEOpTQhsUdqwA+LMJb+Bs1KrdZhbOsiW2AfMHBqguCDtXt5sEi9bBUXvzQVJOUhDEB0
         lV1dYptMRiHmzJZX0cA+9kp5UbsCWhHRFv4opk7O2fwdX0NdnvL4t1XmrhswCR6nH/Ph
         lUBNJjSFQ+eFh3+9beLkFnyd9CuXCCHWiaYc5kMYubc//oA0ixbn4b5a6gpU/yHimqHe
         Krk/XffuxaKVMuBsQTtkW1h9xy/XLfgwS9zzV5E4VZqYGIYOa4tdF/CwA3jf+XsxGtAH
         HAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713462685; x=1714067485;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEWmndW1cSbjh0xIBdu/vAc29pKfsBmdXaqbFNxBkMQ=;
        b=hLG9kCREvwpw9USPNAIJW+pTM8xCLb6yKkYDvquLda7K9fm+RLmKtD5xMtNcxfW4c4
         q1w1Et44B7aY1gOa4xf7rFIYU3NIBHLLq9DfJIiR5GDP/qXKDrTHx+dDc1+XWwd/HWOZ
         /o43QaX3Njk+Kqa4y7/iI7izrei5wlHFsXsGugeCxnQmRnpVYRwEkbbL1IDvz4pOb4Fa
         Rt13hqth58c+KBvYcdTAdhbfh/5Z5UnRo5d4GOeEDPgzso9tHN+ObfnMCDOGmKlSId/c
         TD1GxyX91WZ9upoA+zPYsFeqiiALdWqQj/6Ztj6opIX1gGHON8VgkNKpBt3EPiRHjJgo
         1apQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVihfYc0yZNcgEp35lk9aW9ZlLMhWosROuhtKWWTRebZP6rhTJv9tFOL45O0loVPilqm1UWffzhlTTZMgwmHkZlFOcJXnG+e/NKjuJ
X-Gm-Message-State: AOJu0Yze4gQs7wz7GbBiT4L0x2Idk6jVZ/tEsWajRrGNJcBpWdou5gjg
	b8OQTR84F+Uy4Dn7bnsuYO6/GOS/sawTw0zo+kivelbUsUiZkn3ITIVoBFEULXk=
X-Google-Smtp-Source: AGHT+IHZvQc3Wsnv6HkiSUAv0ENsPEUsNwKlIvIpcc7XeSn2lY9Yfuvze8jZeChmnCTNukdKRxylLA==
X-Received: by 2002:a17:90a:d507:b0:2a5:d979:8eb2 with SMTP id t7-20020a17090ad50700b002a5d9798eb2mr3152834pju.19.1713462684682;
        Thu, 18 Apr 2024 10:51:24 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.151])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a828300b002abf2057cefsm1324332pjn.0.2024.04.18.10.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 10:51:24 -0700 (PDT)
Message-ID: <16a4a58c-cae6-4b62-859b-3661c052468a@linaro.org>
Date: Thu, 18 Apr 2024 19:51:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] spi: cadence: Allow to read basic xSPI
 configuration from ACPI
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, pthombar@cadence.com,
 Piyush Malgujar <pmalgujar@marvell.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
 <20240418011353.1764672-5-wsadowski@marvell.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240418011353.1764672-5-wsadowski@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2024 03:13, Witold Sadowski wrote:
> From: Piyush Malgujar <pmalgujar@marvell.com>
> 
> These changes enables to read the configs from ACPI tables as required
> for successful probing in ACPI uefi environment.
> In case of ACPI disabled/dts based environment, it will continue to
> read configs from dts as before
> 

..

>  	}
> @@ -924,6 +989,21 @@ static int cdns_xspi_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id cdns_xspi_acpi_match[] = {
> +	{
> +		.id = "cdns,xspi-nor",
> +		.driver_data = (kernel_ulong_t) &cdns_driver_data,
> +	},
> +	{
> +		.id = "mrvl,xspi-nor",
> +		.driver_data = (kernel_ulong_t) &mrvl_driver_data,

UEFI provides compatibles for ACPI? I think that's first such format in
the kernel.

Best regards,
Krzysztof


