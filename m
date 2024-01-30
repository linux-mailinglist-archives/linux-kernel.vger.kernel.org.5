Return-Path: <linux-kernel+bounces-44515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D0584232B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A5CB2497F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5146367727;
	Tue, 30 Jan 2024 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFlqCFfS"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4EB66B3D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614353; cv=none; b=PfufWPmUbTcMhnL9diLSY90IVwlCpZHjm/6DCqtxVPZptXLzqGmxSfkD4M3yAUZH3boEue2FJeGPr6CaYzQ4fFV68ma7H8+dUf5H4KMd7wuDt1ILGk+NW2yrcddPUUenou7SX+KmDkfuruQ6qZRPoZi5VHUNdplZbI0tQDIANyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614353; c=relaxed/simple;
	bh=Bn2KseLZiMV7JmBETGjflJRBarj7KKGyI1GvvCM9Ipg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoMHKNJq9mWi2s02tg1m1fSeOE1SEGZLTpGR5VFT96327EO8B3lYuU94/nxtNYqSX9HaxOufAHjs4WHttlNvEfOm1U2x+lnxwTWhQFDjMqnyZXmpRm2KtB6oYa+B44xKBEO1+1BQqg8vIA6PAdZ0T3HrMkpOIZnu6WSdylPRIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bFlqCFfS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ae7ae9ec5so1445786f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706614350; x=1707219150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=laX+zVQ0JeX1iYIF+ozrcB3O0fvC+QLc43rRyFFSh1Y=;
        b=bFlqCFfSHf5aMZ82cOCZ/LXusp4uoLw84iYSEuxxSCriuINWLb2VSSz473aCIr+c5/
         2BB32+mOy0LNcpGZgCR7u20bWZCL3wj4GLehGDgPrRf0kr65wdO5bOwspBJ46VkmZF27
         w5BmGj/7bTbSPlHZUEIjMkYiLsw9EXBlvkr75pfdYlBfDrKIAa3axDkooxnHA4F5UH7k
         T2Pim+Riadqj9sxYvTQwCPS1mAeV/h9byBm+DPB8L8nyAhoyhvXXUKjxX2Lzkr2MHlY+
         Qu+nPJFoM7Nfnhrcgi3vFK3Stlmx9b1El70SkdYV0E7x6Dv/BpAXHlk/oZZFp5dwDMyZ
         eYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614350; x=1707219150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laX+zVQ0JeX1iYIF+ozrcB3O0fvC+QLc43rRyFFSh1Y=;
        b=P/ljZ6fkPwoVRFSVrMhQofgB39Lq4cA0IXQT/rMsNihWzMAjqkdtCHAjaj358QHHt1
         lHWMpv43Of3XadzUUqejv5lUAgJcpr3d9N5PDqXF8S6nnnY/E10eM7RkDs9dIyC6a5oS
         7jimsjVj4iCw2JFm4QgyvKRqQLO4MM+XfFcXiI3mTqgW4M/TYkGqn0O7ZEvrY5b4gKNI
         QXO59hPmJt1gkHqEWi6C+uzv4k+auCHCqzPgV3+wHOMpPUQE9E62+hvC5cUE4ByO1fI3
         ntXJq0nGBnbXTloey2LF1bCcVBrc+ttOkL2ETCkSxHrUXG6JcZIEC1989qC8C0QHqgnz
         o5Gw==
X-Gm-Message-State: AOJu0YzDR/sQDpSo1UWSUhxpo4B5i9VrKSsm1yS4isvterZNqcluqeJH
	CWwP9uRQK5l08t+OJnVIkRfFojxoFRzH4YnMXtpVqAi+8Kwj3LV7y85ViaTdJUA=
X-Google-Smtp-Source: AGHT+IHHR61aG96A031gxNqWAYp6M2nUQQdUVVN077ez9Hfg9g3qti9Fgg4fj8G1l7DwSU/LIcjq0A==
X-Received: by 2002:a05:6000:1f9b:b0:33a:eecc:c1a7 with SMTP id bw27-20020a0560001f9b00b0033aeeccc1a7mr4550445wrb.65.1706614350015;
        Tue, 30 Jan 2024 03:32:30 -0800 (PST)
Received: from [192.168.100.86] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id ay12-20020a5d6f0c000000b0033ad47d7b86sm10583513wrb.27.2024.01.30.03.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 03:32:29 -0800 (PST)
Message-ID: <56f08eaf-079c-4076-b900-710884db6ca5@linaro.org>
Date: Tue, 30 Jan 2024 11:32:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] i2c: i2c-qcom-geni: Correct I2C TRE sequence
Content-Language: en-US
To: Andi Shyti <andi.shyti@kernel.org>,
 Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, vkoul@kernel.org, quic_bjorande@quicinc.com,
 manivannan.sadhasivam@linaro.org, quic_msavaliy@quicinc.com,
 quic_vtanuku@quicinc.com
References: <20240129061003.4085-1-quic_vdadhani@quicinc.com>
 <lib6m2bty4uilvvu544sjlezeux7ne4cx5i25j6yndicx7miaw@tvxpuekiczwh>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <lib6m2bty4uilvvu544sjlezeux7ne4cx5i25j6yndicx7miaw@tvxpuekiczwh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/01/2024 23:24, Andi Shyti wrote:
> Hi Viken,
> 
> as Bryan has done some comments in version 1, please, Cc him to
> this patch.
> 
> On Mon, Jan 29, 2024 at 11:40:03AM +0530, Viken Dadhaniya wrote:
>> For i2c read operation, we are getting gsi mode timeout due
>> to malformed TRE(Transfer Ring Element). Currently we are
>> configuring incorrect TRE sequence in gpi driver
>> (drivers/dma/qcom/gpi.c) as below
>>
>> - Sets up CONFIG
>> - Sets up DMA tre
>> - Sets up GO tre
>>
>> As per HPG(Hardware programming guide), We should configure TREs in below
>> sequence for any i2c transfer
>>
>> - Sets up CONFIG tre
>> - Sets up GO tre
>> - Sets up DMA tre
>>
>> For only write operation or write followed by read operation,
>> existing software sequence is correct.
>>
>> for only read operation, TRE sequence need to be corrected.
>> Hence, we have changed the sequence to submit GO tre before DMA tre.
>>
>> Tested covering i2c read/write transfer on QCM6490 RB3 board.
>>
>> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
>> Fixes: commit d8703554f4de ("i2c: qcom-geni: Add support for GPI DMA")
> 
> The format is:
> 
> Fixes: d8703554f4de ("i2c: qcom-geni: Add support for GPI DMA")
> 
> and goes above the SoB.
> 
>> ---
>> v1 -> v2:
>> - Remove redundant check.
>> - update commit log.
>> - add fix tag.
>> ---
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
>> index 0d2e7171e3a6..da94df466e83 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -613,20 +613,20 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
>>   
>>   		peripheral.addr = msgs[i].addr;
>>   
>> +		ret =  geni_i2c_gpi(gi2c, &msgs[i], &config,
>> +				    &tx_addr, &tx_buf, I2C_WRITE, gi2c->tx_c);
>> +		if (ret)
>> +			goto err;
>> +
>>   		if (msgs[i].flags & I2C_M_RD) {
>>   			ret =  geni_i2c_gpi(gi2c, &msgs[i], &config,
>>   					    &rx_addr, &rx_buf, I2C_READ, gi2c->rx_c);
>>   			if (ret)
>>   				goto err;
>> -		}
>> -
>> -		ret =  geni_i2c_gpi(gi2c, &msgs[i], &config,
>> -				    &tx_addr, &tx_buf, I2C_WRITE, gi2c->tx_c);
>> -		if (ret)
>> -			goto err;
>>   
>> -		if (msgs[i].flags & I2C_M_RD)
>>   			dma_async_issue_pending(gi2c->rx_c);
>> +		}
>> +
> 
> Bryan, could you please check here?
> 
> Thanks for your review!
> 
> Andi

Assuming the Fixes tag is fixed.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # qrb5165-rb5

---
bod

