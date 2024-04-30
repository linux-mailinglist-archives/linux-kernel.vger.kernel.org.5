Return-Path: <linux-kernel+bounces-164321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508388B7C48
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8411C22731
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F304175570;
	Tue, 30 Apr 2024 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ek2Xr3go"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C53175551
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492366; cv=none; b=jLDh2R9HRaWXvykGaFZq47Eu0OZTdGwx9ZF2Y/G0CNpLi7noozVKDL1LOMttYQMUcMXrLVcVnZvu8qBWmWK11G04e2020tr9KcQcFTM60sbstwqPRMweSTLRdVGyzcp8XyfehgRi+brS0uUsZpWncnsxgi4stol6tKV8zepnBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492366; c=relaxed/simple;
	bh=Mkpq73gjTR73XctiXfrax6+J2t85xFnNqnCf3gtMt8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcvnACyCD+2ykBCEERmD4NOs82UhybjVoYNYuHjl0EoeXcMqG82L/d990GJcadDcGrcM5CGMm+V2r2af7CGODaI9U4A8iHRuL7bs2yfFdGhvKZvnULQYuv5LLBTmuW2vOTWgYOlhwv2mNfIrQfvSHBE7wTGkN/xdA3kp+EKydp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ek2Xr3go; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so9150504a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714492362; x=1715097162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9KfFTLch5XOI/EXaMHo6LvMOjKJ+8XzavvpoQj96RFg=;
        b=Ek2Xr3golc9WphS9Tn65KPQLQfXjxsJXDhvdgUjn3k0aCeB4jSaITGEnkNr/1v85PN
         5y4ypd4radS9WoCSTs3Je1hXsEfMEejUQTHsA8lV5QMBBsguAM6gcdPnDUzK73yFjT44
         7IGkUJWDjXs5eur4My3RC8oxKC2xgGHyUpdktnExlPQ2ietPdpUTS5LOrq9cZ1F4jVvS
         ibe2SzgsFgUD0k1wS7baNu7wN0OssBRpZ+maFTfnpTAG4VQcrLPHlR2X/M+Pdze7CWy1
         n1A/v71deurLX2/F+1Gq4crMNcY2aaYYQMywBLOqEeLZ1W+Fg+33CNjnq6dpd6sBLcre
         nY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714492362; x=1715097162;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KfFTLch5XOI/EXaMHo6LvMOjKJ+8XzavvpoQj96RFg=;
        b=xRb9n+9S6M+UrZOD4srRCba2nj4JL3fixWtGJn7MDnP2uowMv41/O2qLOZxKJC4AWC
         UzWv2c+7578mXBnr9uhbLDeReamnQ29BPviZs4EAe4lN7FKuusAsu5keIBRwv2M6NlJU
         iUbaT/tQfrf4+BqqDFzgfF7z0LT/C92DKFFbnQee6kCFg8t7jcrC1tw4AOiamy1EZCmL
         TPYSdAQHU2f7p4NxndxsnSoSXs/GzBrxpi54gSm3l7UebLvNgOwbFk+W/JBul2kbiy91
         btoyRo9DV4HptwKjSz4Du43OuhOq8MN9sDuJIRGrem9ecDK7R0NgFkzsvilLNB9YUNbe
         by9g==
X-Forwarded-Encrypted: i=1; AJvYcCV4Ae20U99tiHiWPC3PYoOmR+bE8G/2VQB8/G9njETQLWNCkwcBEGRJ1IWPx9xEbdXF6pXEfB6T5QqZGNkWsiC78YVtJMvXQ9vLPn8v
X-Gm-Message-State: AOJu0YyBDg881sw91VSGOlnuowGdUdrSiXXzY8Qus1S3e3Flutcsw1hU
	hOXMyO1QDfK1fdUPdNyD0lvUgrCy497Weut0Lo6g35jbebXd3uoQ2oz1zFRNFyE=
X-Google-Smtp-Source: AGHT+IHFTyIexNzvxZiGhhOcmFLgu03pKkJlmVV0dJGT012IkIEX0JCk3Mjl5RDo92gsR+zbugN9MA==
X-Received: by 2002:a50:9f45:0:b0:568:cdd8:cf60 with SMTP id b63-20020a509f45000000b00568cdd8cf60mr167719edf.8.1714492362588;
        Tue, 30 Apr 2024 08:52:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id c7-20020a0564021f8700b0057000ecadb0sm14368961edc.8.2024.04.30.08.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 08:52:42 -0700 (PDT)
Message-ID: <41e2ac7b-3f24-493d-a244-1848ec8b079e@linaro.org>
Date: Tue, 30 Apr 2024 17:52:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: use inline function for type safety in
 snd_soc_substream_to_rtd()
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240430140938.328088-1-krzysztof.kozlowski@linaro.org>
 <ZjEGrnlQfFeDyLUc@finisterre.sirena.org.uk>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZjEGrnlQfFeDyLUc@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 16:56, Mark Brown wrote:
> On Tue, Apr 30, 2024 at 04:09:38PM +0200, Krzysztof Kozlowski wrote:
> 
>> -#define snd_soc_substream_to_rtd(substream) \
>> -	(struct snd_soc_pcm_runtime *)snd_pcm_substream_chip(substream)
>> +
>> +static inline struct snd_soc_pcm_runtime *
>> +snd_soc_substream_to_rtd(const struct snd_pcm_substream *substream)
>> +{
>> +	return substream->private_data;
>> +}
> 
> This is not an obvious direct substitution, we've skipped the
> snd_pcm_subsystem_chip() (which is also a macro, but that just suggests
> it could do with it's own cleanup) and the commit log didn't mention it.

Yes, you're right. I should keep snd_pcm_substream_chip().

Best regards,
Krzysztof


