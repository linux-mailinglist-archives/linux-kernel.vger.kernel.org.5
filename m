Return-Path: <linux-kernel+bounces-29213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B2E830B07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160751C2417A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521DF2233E;
	Wed, 17 Jan 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/9mCfPS"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14222325
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508811; cv=none; b=r+t6mVphJit2LtDCM5vnQHDWZi2YMbnb5c+1gtm4Pv1bMGSwm7fuB+LizbPwak2iaQ9ELHgfpoCRmND2Bq8aD3Ve2bxWANOW7crBYuQ89N+JVFJ886w/f4a+Zdsums88LAzLeWaNkPlhy874jmvGpf8qboaVkpo4lpw/WAOuI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508811; c=relaxed/simple;
	bh=wn2goDlX6S6RW+PrLeUKz99JPVluWUJtJkc40G1Gv3M=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=Hs4wNwDiJ5Vtc3dWj4WQHG04/IJXPdreIIBfukDafOZw5FQYX9hbt7qDYyRtCDQLb79ykINKaKDTq7mGsOBSzOY8R7MzWbZ48Ga6Vdf05iLtaNnXufzmFsT6HMDCsM7rksB+LuyALfIuJz9YL32W2qRiEnJw1IdpTDz3Ro/x9sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A/9mCfPS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2c67be31edso752202566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705508808; x=1706113608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ha7p2Qq9XUTjNwoHLIVXXPbHNGR1+vSuwUvn+P96Mv8=;
        b=A/9mCfPSa+Ah0tKmeeEi2WRSJS4tIlRnPjjPTD/YrWu+RcjLq52gEDxw9WT3CG1Cyc
         4NRV8TjwFOJbotNK8YbMjX6XNWR/Qf3xVBmbStb3bu5ctHSyps7XrGim/uetutJ9Bc7A
         tXNxpchjWe3XJY2eegAiPoJKnqRBMQlue67LTh9291gV/R1KqWK9f7z5F4RR1qACOB9y
         IZxQOzkNKwy7SQaU5DN/rLkG0zcvcSyI708In7dySmQsafsmktx9UV6IvoM+r+BAGvw9
         tmRJngRtx7qlf8Xix6JpcGiJnenfbXWjNtqIVzcGx9TTfKNbbChHBgai5fqz13HrqFdh
         kFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705508808; x=1706113608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha7p2Qq9XUTjNwoHLIVXXPbHNGR1+vSuwUvn+P96Mv8=;
        b=IvUGtKqFmz3y2GYrhU6YiWEQTU/ZjOhWHVrVDZSK8/0T41iIM90wlKxcKmhLOLtlVK
         5lVAMbj0ypiw0ijbxuWh1+dsSm6gzlq6U+VoqhxWKRz2Y952ELT0XpkCcHELgqFhPnhT
         cDCezIXr+s7ZvSYlna5nFLjkZ4FYaPebSfHt60pUVG5Ponz7U0sVR2vyQAZ0hE6OPfz0
         rBSVCb2ZQfSjI5ImaGrEUZIPllSTf1M/zGSeHMxoTNK7G/E93u33HL9KStaoPCqyp24S
         Ha8jbC886q0/XeOK9SDgU6tcfLOaUvvEd6HQTsXi30KHEBUx29iNPd/4xvjitKxVa0x7
         Hjsw==
X-Gm-Message-State: AOJu0YwGrIpqoG993Z0e3gLOhDIz0mrti/GfT2aCtIqIzV4nU7mzDqUx
	Ts7kiCixCXAJ3c7fjbIiHKlB7+eePLXH9Q==
X-Google-Smtp-Source: AGHT+IElkE4KWYTyzo+tzw+6f53yBD77CCps5VnfW7klmmTb5pGmIRo/cJUPFxFV/rs+fOgzau1VAg==
X-Received: by 2002:a17:906:fe44:b0:a27:8fa0:b3ea with SMTP id wz4-20020a170906fe4400b00a278fa0b3eamr2894620ejb.3.1705508808392;
        Wed, 17 Jan 2024 08:26:48 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id tj14-20020a170907c24e00b00a2eb3d1aecdsm1205705ejc.65.2024.01.17.08.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 08:26:47 -0800 (PST)
Message-ID: <40d66ddc-8293-4213-a0bd-321262a1a3ef@linaro.org>
Date: Wed, 17 Jan 2024 16:26:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] tty: serial: samsung: shrink the clock selection to
 8 clocks
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com,
 willmcvicker@google.com
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
 <20240110102102.61587-17-tudor.ambarus@linaro.org>
 <CAPLW+4kndXo9Ab2PL3fts9pJNhhitX3Sr=V2b8mS4cArov4Tog@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4kndXo9Ab2PL3fts9pJNhhitX3Sr=V2b8mS4cArov4Tog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/16/24 19:09, Sam Protsenko wrote:
> On Wed, Jan 10, 2024 at 4:25 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> <linux/serial_s3c.h> provides a clock selection pool of maximum 4 clocks.
> 
> Then maybe it makes sense to turn those two field into 4-bit bit
> fields? More importantly, what particular problem does this patch
> solve, is this optimization really needed, and why? I'm not saying
> it's not needed, just that commit message might've been more verbose
> about this.
> 

I guess I could have been more verbose in the phrase from below and said
that for arm64 ``struct s3c24xx_uart_info`` spans through 2 cachelines
and contains 2 holes, and with a bit of love it can fit a single
cacheline with no holes. The end goal is to reduce the memory footprint
of that struct.

I chose u8 and allowed a max of 8 clocks simple because it's large
enough to allow more clocks than are supported by the driver now, and
not too big to cause spanning of the structure through 2 cachelines.


>> Update the driver to consider a pool selection of maximum 8 clocks. The
>> final scope is to reduce the memory footprint of
>> ``struct s3c24xx_uart_info``.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/tty/serial/samsung_tty.c | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index 436739cf9225..5df2bcebf9fb 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -81,11 +81,11 @@ struct s3c24xx_uart_info {
>>         unsigned long           tx_fifomask;
>>         unsigned long           tx_fifoshift;
>>         unsigned long           tx_fifofull;
>> -       unsigned int            def_clk_sel;
>> -       unsigned long           num_clks;
>>         unsigned long           clksel_mask;
>>         unsigned long           clksel_shift;
>>         unsigned long           ucon_mask;
>> +       u8                      def_clk_sel;
>> +       u8                      num_clks;
>>         u8                      iotype;
>>

