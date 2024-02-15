Return-Path: <linux-kernel+bounces-67436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A3E856B81
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351742864E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78F137C5D;
	Thu, 15 Feb 2024 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4FOpQuM"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379F139560
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019247; cv=none; b=YsNstYjF3GFdEQrD5+QeUkGFVkVkFxyu3XwUAjNpiuYsz+bqQozMhadDqAy5vqgWOPMC1fFsCBSg28cnbeVN0Sd2koGH8449vDIPSoCTSYhPfMOm9mIuG8Eiaxhxpuf2W+ntRs5Z1GxgbDYF26ZVaksNF/GGkBNLWVg8IgK3XjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019247; c=relaxed/simple;
	bh=ajmUHFUBbOZfizj8pnDDtY5izZYI3pCtjemyKv14bKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQ6bIqxqpGAxFBdjURaozamB/gHHVX2o6UHvByCwvcJOZR7trhOPYQtY+3CEuXZAcuukZUDNR9OCu/jczsMcB5EXJQwenDnqNYmRsSSdSFirLLnjoNi4tyFLgcercAoIeQ6zNA6X+OXXBfABxg91a4ciH3li0fSBkx4qgORHErs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D4FOpQuM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d11d17dddeso13643761fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708019242; x=1708624042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HquKZRHBV00ju6jdGp8jpiRgiVO9YKBQxry6Lkp4DJM=;
        b=D4FOpQuMXbykR8B1nhzpDcPZLu9pj2zkbC+ImSXezWoEepcGuWf8P7CH7hMfOewZxU
         3k5RtWEAFuS7EItUJZNZQvnKbp2V+mO+Z8EUM9XDk+42WJi4QF/ey8JJJuuMPS+olpSH
         peHgppBU6BP5Ox5iK3gDSaOPtqgqmTu+ABvvGvTb1PJlD3JBBn7bwKU6UtfPvgqF+sL4
         sHCTvxiDYBHIOEgG9wdqH1L+nVhQF2MrdPg4f0sZEz70BiLYuGWZ+pLy1ZQe6lXajmpQ
         stFhKESkfSA0wP5t87qiL+GKF5pn2FNJQJeobnQokna1mqtR9ctJ6i0J5xgnuqYZlJmp
         frBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019242; x=1708624042;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HquKZRHBV00ju6jdGp8jpiRgiVO9YKBQxry6Lkp4DJM=;
        b=tgHILZ3jTGdOzjna5iMS/bkvzHPEF2/qL2p4gIlsGZ8aqSL+N4Dybxjz17AscFDoV4
         7+UhlpDIFP2YlbWSBvVr1rAsluglBRKbSYDcvpYXUP44y49fG305YrQQfNHNrkJUAh6s
         hUGiUwWwR1Ra3l7Um/RP7NERrqYZh7VIbL8uxw6i4gH4ygimPaK6ByS8iWxnRbLdIGsk
         gzPHa90QXCYIdJgXm6qLg9quo/MDfIzlsuYi6KWm69C++t10oivN/9ghdVkiqdPVpGFP
         1LUuPG8o8duuVhFqUH8KmLxhqTxCP7OviqbzljlzCMNvlXLyaJEMXIOcKAOeNLEqNHrB
         QcEA==
X-Forwarded-Encrypted: i=1; AJvYcCW+w4xQYgeeXwKSFT4FlTc1mLNJYKLPQ50N3n0sGRPbChYakaIQqxL8NB9WZIBduIZlR8N/lYqzA+DLN3+4xNxzsK0z7/S8/3uG1AZo
X-Gm-Message-State: AOJu0YzfYBMwlkXCK6UfzsBrP68hm7qkdwbE9pqznQ5m1jdvEnAeeFA0
	Dyqz1rjmTSATNjfdppkXfmQO934WXQYKnqKstsuDDYtrUEKMJHpeNWnO/HLD+zc=
X-Google-Smtp-Source: AGHT+IFERZ44xaYPBBfUXSJJdhg24mt6A8dr16jL8jz3RGIC4bJ3AndEqdZvHfG8Fdqg+vZuaJcrsA==
X-Received: by 2002:a05:6512:1152:b0:511:7ebe:b160 with SMTP id m18-20020a056512115200b005117ebeb160mr2306326lfg.45.1708019242290;
        Thu, 15 Feb 2024 09:47:22 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id r1-20020a50d681000000b005638f04c122sm790193edi.14.2024.02.15.09.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 09:47:21 -0800 (PST)
Message-ID: <cbc0606c-604b-4236-a063-77e081f01250@linaro.org>
Date: Thu, 15 Feb 2024 18:47:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Use the correct sleep function in wait_for_link
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
References: <20240215-topic-pci_sleep-v1-1-7ac79ac9739a@linaro.org>
 <buqxbxlsngec2iz4oag7mfgva5cozk66ljfa6aatao6liepnzu@zlmtq2v2ib3m>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <buqxbxlsngec2iz4oag7mfgva5cozk66ljfa6aatao6liepnzu@zlmtq2v2ib3m>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.02.2024 15:17, Serge Semin wrote:
> On Thu, Feb 15, 2024 at 11:39:31AM +0100, Konrad Dybcio wrote:
>> According to [1], msleep should be used for large sleeps, such as the
>> 100-ish ms one in this function. Comply with the guide and use it.
>>
>> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> Tested on Qualcomm SC8280XP CRD
>> ---
>>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 250cf7f40b85..abce6afceb91 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -655,7 +655,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>>  		if (dw_pcie_link_up(pci))
>>  			break;
>>  
>> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>> +		msleep(LINK_WAIT_MSLEEP_MAX);
>>  	}
>>  
>>  	if (retries >= LINK_WAIT_MAX_RETRIES) {
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 26dae4837462..3f145d6a8a31 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -63,8 +63,7 @@
>>  
>>  /* Parameters for the waiting for link up routine */
>>  #define LINK_WAIT_MAX_RETRIES		10
>> -#define LINK_WAIT_USLEEP_MIN		90000
>> -#define LINK_WAIT_USLEEP_MAX		100000
> 
>> +#define LINK_WAIT_MSLEEP_MAX		100
> 
> Why do you use the _MAX suffix here? AFAICS any the timers normally
> ensures the lower boundary value of the wait-duration, not the upper
> one. So the more correct suffix would be _MIN. On the other hand, as
> Alexander correctly noted, using fsleep() would be more suitable at
> least from the maintainability point of view. Thus having a macro name
> like LINK_WAIT_USLEEP_MIN or just LINK_WAIT_SLEEP_US would be more
> appropriate. The later version is more preferable IMO.

Agree with SLEEP_US

Konrad

