Return-Path: <linux-kernel+bounces-65238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C5B8549D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358ED1F28874
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9725C52F86;
	Wed, 14 Feb 2024 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pzpkcr3I"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F400B3FB06
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915577; cv=none; b=BwakOvnbjhggvR8Y2DPNCkAYnmKgMw7ps4x2Y1QaDp4NO+A7Z0RTrbR1YVIUa4iAJZoO5rgmy2pH4SutNSLdrx62ouxntI2U7s22Ta5NVMQx7vkSL24L3MvAXOKHVuctAwWZNzA7PTNTO5qp0vNMfcKD0bNa5BEk+SBHO6up64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915577; c=relaxed/simple;
	bh=61lA6H3YHOGwam7RJiFhOY4LEq8Z2pxNREg2/X8wxOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omX7ufWs+aXgeD6qdlJQZVPn9Wp7aG2Aa4717NB+PdpPXG3tUZa2NKhhoyE/zeCMZuJiMg+0MObl1RsaDbJUbr2CiqWTx418z36d6sMxjD5J2DFi1I5fJ0Rci0w0XjE8AfTVzjWS23PHcUUs2uDv4kg8ZDyF62eMQfo/3gKfH+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pzpkcr3I; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-411ef179d2eso3419185e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707915574; x=1708520374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4nzZce/GEXlHrGVLwwLi35yncyVeHeTBvhdjAodvFVg=;
        b=Pzpkcr3IN37kTMKrEPUlHm20YX8ADyLOeTpKMrLlZ0z/m2xwMCmw3eAHOb8byVPncP
         Z8wAkQJy8jzUJtE4RL9pOPE9fFU35DD78ej2fnG3aNl/ygS6NTBmC7XLRcRYR0ubTH4i
         RQJafPWufPlRazFLhz1f5spn4uO5OD50FwEMWpRcGpX/jGLm8lIXFFsnOH2fL0icosm3
         zDnTTBDARVC+Y0CXHrv1ae8qqprxK0pTtng7ZDX9MFX6uS7PTC9/b905jwChou6E9Gvz
         4M+2HSTLwEuPTomjjziHrSEzEZ0ZBahZunv2c1WnaaKC1+QmuwPYXKSXu+B96b9f1V9q
         Ub+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707915574; x=1708520374;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nzZce/GEXlHrGVLwwLi35yncyVeHeTBvhdjAodvFVg=;
        b=s0r/Qrzn6SJal4hvrQzTAits3HfVn+G4QYW2JWAv2pp0x5zgTu32BN7dNlQneqasWM
         39RvkjQXJ6GKizruGjH9J9ywIODM0peQesweOhvqvqiPu1x47fLKCpYUjw7dth1/Y/a5
         q9NhaWs8/6NAMs36KC8r5BfUpP6B/K4lmrqXWNmJT2SZ2jp/zMK72GbKN1nErbDgpSeg
         TxOEKSSiPKCD8I6tMeTBNzhnHAqO5iu8TfpgmCoUgeUVbu27PoIgX+9bkMg8R8nAFTi/
         +Rmt7u3Md9qCRltxD57FckiKrltfpoP2GuW/jEyT3GX8MbHXXTX7FLXaw54wwu9z5EwV
         7naw==
X-Forwarded-Encrypted: i=1; AJvYcCX0b5LWNbW5fMUlpHlQJi7q+gymXTfTZPnfF1l6EMJFLju8pMeIkIB9k50NaauUkogyejMajmOpWzdmV5vu8/gKUwuKNhArdsk7qAML
X-Gm-Message-State: AOJu0Yw6NeUSEpYJ9kGM3Pv4Ycom1m2/gODU/S2jUdKPanu3trPh79QQ
	NGk7rKw749ENE7nrw4SiSQk+ntMPLN4iADtdQGEhjFz6OFjGwso7jkQFH1Tjdmo=
X-Google-Smtp-Source: AGHT+IHE+JF/Li3F9lvJ78Ag+CdVgWvl6ZqqcKunp4gT3Br4f4dwnRxIrKxDpHzPWSMjx51I2u2Q9w==
X-Received: by 2002:a05:600c:1386:b0:410:84b9:b9fc with SMTP id u6-20020a05600c138600b0041084b9b9fcmr1858467wmf.15.1707915574177;
        Wed, 14 Feb 2024 04:59:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWd8rKvRi3uH3xm2x+Jn6hMbNTU2ule+Gpo6QcY7OFZcQHp2ARHF7HWYnlgaBlGYjH6GG8zzMwE9xH7kgeBJ+J26cenqmlZh+1BAxXLbauaIrQ+44rw1hhFlivS5rwzfiyQqCuXgAy+ETuOkDwQPjvEmoNAJBEsTQc+CnB81EiWJNXqqIqHHnOM6IWgDa78Jnlsy0GzQSKAF1366dR3y5a60jgd4SZE3dNkn6yRGvQbeVf0KpGhRrWrrDy2XDLqjh5ddFR8cFBl812hLftSVT+BN5nWwLRmysF/8FH0GqXg+bMZZoLQ8HPj
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c4f4a00b00411e6243e70sm1909500wmq.12.2024.02.14.04.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 04:59:33 -0800 (PST)
Message-ID: <a09b8118-71e9-4ca6-9729-f902e37ab68d@linaro.org>
Date: Wed, 14 Feb 2024 12:59:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-mem: add statistics support to ->exec_op() calls
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
 <b0844e5a-ee4b-4608-99a1-877660e01d57@linaro.org>
 <CZ41HDHS7WX6.6MJL1O2PBVW1@bootlin.com>
 <7b3c08b0-80ed-4409-96d4-d55b938df6f4@linaro.org>
 <CZ4O9QACM45B.2HA0L2O4QL5PL@bootlin.com>
 <c5230e6b-b988-4fdb-a8d6-543c3e9cda23@linaro.org>
 <CZ4QZUSQXV4Q.3QRIRM4V0SYF8@bootlin.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CZ4QZUSQXV4Q.3QRIRM4V0SYF8@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/14/24 10:59, Théo Lebrun wrote:
> On Wed Feb 14, 2024 at 10:29 AM CET, Tudor Ambarus wrote:
>> On 2/14/24 08:51, Théo Lebrun wrote:
>>> On Wed Feb 14, 2024 at 9:00 AM CET, Tudor Ambarus wrote:
>>>> On 2/13/24 15:00, Théo Lebrun wrote:
>>>>> On Tue Feb 13, 2024 at 1:39 PM CET, Tudor Ambarus wrote:
>>>>>>>  /**
>>>>>>>   * spi_mem_exec_op() - Execute a memory operation
>>>>>>>   * @mem: the SPI memory
>>>>>>> @@ -339,8 +383,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>>>>>>  		 * read path) and expect the core to use the regular SPI
>>>>>>>  		 * interface in other cases.
>>>>>>>  		 */
>>>>>>> -		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP)
>>>>>>> +		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
>>>>>>> +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
>>>>>>> +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
>>>>>>> +
>>>>>>
>>>>>> Would be good to be able to opt out the statistics if one wants it.
>>>>>>
>>>>>> SPI NORs can write with a single write op maximum page_size bytes, which
>>>>>> is typically 256 bytes. And since there are SPI NORs that can run at 400
>>>>>> MHz, I guess some performance penalty shouldn't be excluded.
>>>>>
>>>>> I did my testing on a 40 MHz octal SPI NOR with most reads being much
>>>>> bigger than 256 bytes, so I probably didn't have the fastest setup
>>>>> indeed.
>>>>
>>>> yeah, reads are bigger, the entire flash can be read with a single read op.
>>>>
>>>>>
>>>>> What shape would that take? A spi-mem DT prop? New field in the SPI
>>>>> statistics sysfs directory?
>>>>>
>>>>
>>>> I think I'd go with a sysfs entry, it provides flexibility. But I guess
>>>> we can worry about this if we have some numbers, and I don't have, so
>>>> you're fine even without the opt-out option.
>>>
>>> Some ftrace numbers:
>>> - 48002 calls to spi_mem_add_op_stats();
>>> - min 1.053000µs;
>>> - avg 1.175652µs;
>>> - max 16.272000µs.
>>>
>>> Platform is Mobileye EyeQ5. Cores are Imagine Technologies I6500-F. I
>>> don't know the precision of our timer but we might be getting close to
>>> what is measurable.
>>>
>> Thanks.
>>
>> I took a random SPI NOR flash [1], its page program typical time is 64µs
>> according to its SFDP data. We'll have to add here the delay the
>> software handling takes.
>>
>> If you want to play a bit more, you can write the entire flash then
>> compare the ftrace numbers of spi_mem_add_op_stats() with spi_nor_write().
> 
> It is unclear to me why you are focusing on writes? Won't reads be much

It's easier to test as the SPI NOR core will issue a new page program
operation, thus a new exec_op() call, for each page size.

> faster in the common case, and therefore where stats overhead would
> show the most? For cadence-qspi, only issuing command reads (reads below
> 8 bytes) would be a sort of pathological case.

If you can serialize the reads and do small 8 bytes requests, then yes,
small reads are the critical case. Not sure how common it is and how to
test it.

Again, opting out is not a hard requirement from my side, you're fine
with how the patch is now. But if you want to measure the impact, you
can either compare with small reads, as you suggested, and with full
flash write, where the exec_op() calls will be split by the core on a
page_size basis.

Cheers,
ta

