Return-Path: <linux-kernel+bounces-48336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E9B845A8F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199E91F2AF59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E75F496;
	Thu,  1 Feb 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vU6MqjtV"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84A53377
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798894; cv=none; b=nAdeFL1EbK0+Qmw1XsPYiDF5c6eB26S/ArY6o7Lf8LoMy2XKZoqaUBvnWbKL/R2pgpL7bGPtas70z7ZAvd5LVB0mZ4gEhuUJPMLdz0Yi5vMBEDhF5IeJHKRM43eO9/UoNaRO7FFe9aNDMqtSvUEAG/wvml6CWGt+kl/XPvZpHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798894; c=relaxed/simple;
	bh=mK97ie5YLL+fqeQnnQzAUqC2DKpdGQJEpMDOdPcRnGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpPnIcqc8dU0yYFTEt/x1XbglyHUnlpGodrbKpwRnqfdiKd5utKVdg/sHI6DiA8WS77b2+FHQD6RC2ZFXvDLyIs4vixN1BEvQohreZr58Tjh49bEbGyg91+67aovyq1Zre/xTDku3e1qrOAfUAxuD0AAboEbLbEUNbVaGcfdKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vU6MqjtV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so147118766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706798891; x=1707403691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JaeUWQBo39YQw7TnGkNstV1RNP7hJ9nNtv5eES9h18w=;
        b=vU6MqjtVKmoAyuW1NzOOTKZfk3l9xbJW2yOS9C8KqmDan3uvuOGriZ9SoAMnOb+8aa
         koyBBrpdIgm1XZEyyaayyvmS0SkXWsoOtApMFfIG86/NxcWYzFujPE6W4TB8aOET/6Qc
         7GrK5JNo2pq2NJELUhik1PPsZq4FwNm/rD75dLMpvSmP6KyfCQM90hRCbWCMXkQeoR7G
         AM7Uwy76sU2nL2d7tIRegZwsZ9YKFkbj5sQq2+7VEI5jSpR7EPtGRnJJJPS56/Y3bQkS
         R4PQQAxx6Viu8U+lMGMxl57Z3k+jZ4gt73jaq4mnZTmY2S+tYeGoWjEHjSzxA3kPjYTj
         NXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706798891; x=1707403691;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaeUWQBo39YQw7TnGkNstV1RNP7hJ9nNtv5eES9h18w=;
        b=OauWEp5nLhsRp6qBzzlSVMQgPTl6leU9cTcaEkEh7p8k0wDp9f122ac2SVit/+zYyi
         QsCSJiH22Fv5jksHansXJXR1wGHeXl156ok41Vpyw/aS0+BORSwi3P0ZnCA0/6HaW4GX
         o1fefJWcZcYVCBzLvwxysmOXYujAM1blETm65aAINqq26mDgDvTt4nzVUkwyBx7x07Wj
         cd5DDSiE0gs2KcAmSGQWRtUi6QFPPj5wPSlT5m2wWs/K5K1fANvVi7wXtUD9jOzyxPgF
         yZA+0yhuwQplRPrBx26nvNDg3DNl8iK6Hbx0H4pO0t1yrAKa25+3LNM/q6dIIwj3kTqm
         Tqng==
X-Gm-Message-State: AOJu0Yy6WQfzMIfG9w7UiBM2/y3mnsP/NwceteCdGshkFFmdUuTHZnDS
	i4xRZ0CuJBGX436rHSFTcFKEzywKb/16Tn+LERNkNXJ2jFE47/Qin5cXlV/df9M=
X-Google-Smtp-Source: AGHT+IGfG6b8ppybeVsLudJjiukMQRs0AH31C7e0LWJSajpF7r975BFWWR8DjZUnrO6sJHwEnfzDVQ==
X-Received: by 2002:a17:907:110d:b0:a36:915e:5ff7 with SMTP id qu13-20020a170907110d00b00a36915e5ff7mr1881338ejb.45.1706798890783;
        Thu, 01 Feb 2024 06:48:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW+hlq7EvEcX7YBHkXcPINu2XNW9q+ljsrNAs4PbHjSJ8qlQMy6A7cBnY81ySeeSrHous4BsM/TsqE6rlyovvrrGg7uGzJpZGrW8rrL/tiF9X3leoJFX7KB/esSKNf4hjF8B1GwuRBM9PbUWM79Cv5L4b8Lohv21D8E+SqzeCAbVo9gr6DYlZf6d82EsIcMTQVi6pPHgvcG9j/+mm6xMrEuOg/XESGCA+gxN0M80b6ii3ZBziqgCWljClL9
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090652cf00b00a2e81e4876dsm7232365ejn.44.2024.02.01.06.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:48:10 -0800 (PST)
Message-ID: <226874eb-18c0-4834-aca5-46396b8a07e6@linaro.org>
Date: Thu, 1 Feb 2024 15:48:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: amba-pl011: Remove QDF2xxx workarounds
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240122-topic-qdf_cleanup_tty-v1-1-0415503184be@linaro.org>
 <baf69674-7c69-4658-94ad-9b39fbb9924d@sirena.org.uk>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <baf69674-7c69-4658-94ad-9b39fbb9924d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31.01.2024 14:44, Mark Brown wrote:
> On Mon, Jan 22, 2024 at 03:27:20PM +0100, Konrad Dybcio wrote:
>> This SoC family was destined for server use, featuring Qualcomm's very
>> interesting Kryo cores (before "Kryo" became a marketing term for Arm
>> cores with small modifications). It did however not leave the labs of
>> Qualcomm and presumably some partners, nor was it ever productized.
>>
>> Remove the workarounds, as they are long obsolete.
> 
> There's one in Linaro's test lab which gets used by KernelCI:
> 
>    https://lkft.validation.linaro.org/scheduler/device_type/qcom-qdf2400
> 
> While the platform is pretty old it works well enough and provides
> coverage of server platforms, ideally more server vendors would arrange
> for their boards to be available but that's not actually the case yet.
> The fact that it's a unique implementation of the architecture is also
> interesting from a test point of view.  Given how trivial the workaround
> here is it seems more useful to keep the support, could we revert this
> commit please?

Right, sorry for the mess. It actually turned out that Qualcomm is apparently
still using some of these internally and was interested in still keeping it
alive, at least for the time being.. I mentioned this on another similarly-
themed patch threads, but forgot this one.

Should I submit a revert, or can this be dropped?

Konrad

