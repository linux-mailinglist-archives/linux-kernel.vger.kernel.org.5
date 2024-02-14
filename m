Return-Path: <linux-kernel+bounces-64967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCD785453F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489ED1F2C9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DCB18028;
	Wed, 14 Feb 2024 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fE2jHZlp"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8241642C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902981; cv=none; b=UdlNCIOY6MhFHgJRkHe+N4tP00wOj/e6oP7a+nSwjKMZEZ/Jb/LsR2uq2xoEqWKIMFxeo39OOcvTW2SMM4E62YfiyBBPKlQFWjNlr+ZnMatXfbPr3wp+/F/nCdwKxiLITHEcGjsSuniLWNfe/DgCFjYgym3dHxPQznX4PI0Lugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902981; c=relaxed/simple;
	bh=EQalAKDLMQ7i1XcshRX2Not5YF+7MqvcYpRLQ7QRYyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4SQo1rGJSXkh1yfDyF78EWKWnoFpTIAKpN4zOAj0VCi4SWJotQGTk1mqX4eviWIY+QMeNH5RrFvZ3/NvJnyODhi3C2/Lvay0VlFurYwZ/NfAOrQ5KH7+8c/5c8NFoHtdbhu5mUYukmffl7Qyb0feoiKRNNa+c+N+AsLcPDiXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fE2jHZlp; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51182ece518so4487663e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707902976; x=1708507776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaIiFR3On41h6tc9o9ZJheGqRmPrIZwysG2Ikqlaz3A=;
        b=fE2jHZlpQKWp5jeL7CYtp/JJVxabu8jThxk6xYdzva2CjVSBMuoWsijwN716HQuudC
         SF2rlb6D99fbb83ovJQLuF7S1shem25L3WOwMW3RDD+sbVRF6U2l1X/abEgzJOoNZNw4
         pb52m4U4ODm3TfejuDtwu3i5ftUWr1/ZC2ld/cUpbl8qh7Ys6UqYH/Jpv/u3srSfcvAt
         KEyw3PYnRiWALCMdWSHLS+DDqBSSoFEUWi2Tohs4j0zTwN5nZkNvZaFQ81b6JmL8jG6t
         BbMBhI8aO25JLBgUlzhbErkZyRhcvuI2V/g745LYsBr/xvAvyb9/ko3ciGOS8yuZd6vh
         IUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902976; x=1708507776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaIiFR3On41h6tc9o9ZJheGqRmPrIZwysG2Ikqlaz3A=;
        b=SLalhqbPE6kl3i9ljypbnGOcMgyWhtewz3aCIlyJaLi9bCaPR/RVS3CXMpDjifuuYY
         aBzs1R2+CvZm3jXyXh56c2611j0R9dDqnOjqY9FLQ61DkG69rW4xwCXicBf3FcQd+r4H
         oGLOHjD0cA7kJzfYnP7gTYMNhbZ/PfS/i7YQYoISKpp0HWAJAmA93B3YWnYQXQR0p5gv
         88XmQLeid+SpEYcKZ2LGUQHjm023xs6wt/haptc2RGPa7G5j0onBw1v07CN9HSxLrGgP
         2wcJbz32/nJdQueblYQ+VONjdi1uU6q42BA+0WQM9rp1P3CgtfyXHpkW38o6GE4kvUua
         SYMw==
X-Forwarded-Encrypted: i=1; AJvYcCXeC6BAlaKThza/JE08hj3yHnVFoXe/CkxnuYb6Y+ZpOcDC4/JGbUlL2Jkl4KoKhLFWdwiUUa1ngUbu5hPd2rbqyYOiUdrRGdKLB71V
X-Gm-Message-State: AOJu0Yx33uw9yOhNrOjmYQGDjkwKUqPPBzz+tg+5YYxmsjIKSMyICxFX
	tBudWXVqOl7hRftz1WWbdWFUlVm/I3/fKytbGoL7RegVEatDNmKWxxIzogHRH0I=
X-Google-Smtp-Source: AGHT+IEPaPev8mq9yNex0xMT7oLMK9BzcFk5HoZ1wPT+Wy0i/qNKreBpHshf/CiK8BITXXvvgk0A8Q==
X-Received: by 2002:a19:7717:0:b0:511:54f2:df07 with SMTP id s23-20020a197717000000b0051154f2df07mr1263243lfc.11.1707902976082;
        Wed, 14 Feb 2024 01:29:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXS5Vr5UuX5BNKS8v/mi5XV9iNfELUz/NPEeFedP2cthhm3vMwChbKrggQZDb81efYi1eOHQUMz8PoVugv2gQPxUYybXLgnJNrmDWS1c2RHjFy95NW0Im0NBoXSsZeGaEuZTdKp7qWM8eZ61F4sDAVYr4ftlYMF59I8/yR98dW9VLygwOmkc4lPJNqcfpeiJbLGxtTuTfhsKQpAajLvGavFtLvifoHatSMGycYLPRr8h75k1jIKulYLZ5drccjY8g/kKKvNhoPvYaTfYCBa/7d+g6ueVVuxUBJD+KV4HBkWexaS5FYKl6QU
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05600c524a00b00411e1782d33sm1367616wmb.23.2024.02.14.01.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 01:29:35 -0800 (PST)
Message-ID: <c5230e6b-b988-4fdb-a8d6-543c3e9cda23@linaro.org>
Date: Wed, 14 Feb 2024 09:29:34 +0000
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
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CZ4O9QACM45B.2HA0L2O4QL5PL@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/14/24 08:51, Théo Lebrun wrote:
> Hello,

Hi, Théo,
> 
> On Wed Feb 14, 2024 at 9:00 AM CET, Tudor Ambarus wrote:
>> On 2/13/24 15:00, Théo Lebrun wrote:
>>> On Tue Feb 13, 2024 at 1:39 PM CET, Tudor Ambarus wrote:
>>>>>  /**
>>>>>   * spi_mem_exec_op() - Execute a memory operation
>>>>>   * @mem: the SPI memory
>>>>> @@ -339,8 +383,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>>>>  		 * read path) and expect the core to use the regular SPI
>>>>>  		 * interface in other cases.
>>>>>  		 */
>>>>> -		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP)
>>>>> +		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
>>>>> +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
>>>>> +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
>>>>> +
>>>>
>>>> Would be good to be able to opt out the statistics if one wants it.
>>>>
>>>> SPI NORs can write with a single write op maximum page_size bytes, which
>>>> is typically 256 bytes. And since there are SPI NORs that can run at 400
>>>> MHz, I guess some performance penalty shouldn't be excluded.
>>>
>>> I did my testing on a 40 MHz octal SPI NOR with most reads being much
>>> bigger than 256 bytes, so I probably didn't have the fastest setup
>>> indeed.
>>
>> yeah, reads are bigger, the entire flash can be read with a single read op.
>>
>>>
>>> What shape would that take? A spi-mem DT prop? New field in the SPI
>>> statistics sysfs directory?
>>>
>>
>> I think I'd go with a sysfs entry, it provides flexibility. But I guess
>> we can worry about this if we have some numbers, and I don't have, so
>> you're fine even without the opt-out option.
> 
> Some ftrace numbers:
> - 48002 calls to spi_mem_add_op_stats();
> - min 1.053000µs;
> - avg 1.175652µs;
> - max 16.272000µs.
> 
> Platform is Mobileye EyeQ5. Cores are Imagine Technologies I6500-F. I
> don't know the precision of our timer but we might be getting close to
> what is measurable.
> 
Thanks.

I took a random SPI NOR flash [1], its page program typical time is 64µs
according to its SFDP data. We'll have to add here the delay the
software handling takes.

If you want to play a bit more, you can write the entire flash then
compare the ftrace numbers of spi_mem_add_op_stats() with spi_nor_write().

Cheers,
ta

[1] https://ww1.microchip.com/downloads/en/DeviceDoc/20005119G.pdf

