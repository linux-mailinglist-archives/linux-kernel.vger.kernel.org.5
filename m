Return-Path: <linux-kernel+bounces-65976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBE985549C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408151C22875
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107C13F001;
	Wed, 14 Feb 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E88bNEtL"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03213DB8A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945661; cv=none; b=dG8m6WzRTKecsYg3sH+0NAOsYkwBCBlAzxkRd15kx896UGHcox9q1bp1yAJd8mVQz2HvhuXk0/xjMNnfbLIEkNRGpwN4fNHb01QyQNxNPRr5Cr5+l4OI2g5AGEwsX2otO2BT067AD38+7UyitAs3nK1y9SY07h6v69CkiAms0P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945661; c=relaxed/simple;
	bh=UH20tkUJPZTtnE+bVLwhS0oDXXvWrOablcK+6ybpZF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afD07rYE7frTtnfCcrPs2b+QxMsdCt+K5tLXqekD8mkqR/YaUW7yUTcfONcZ7zkHGpetXZ5rLMKtnzGIqUeou1pojaogCBE/6COpp5ia3QBWRIZAlbXF93YtN8CRLQfcrKf3u2pU3UxVLvYGMfD4+BotTgAYi3hW2FZX0pzkk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E88bNEtL; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-511a04c837bso198766e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707945658; x=1708550458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOS2B7sbqxhq5r87RRG1TrTI32jzxgx2gbxZryh0k5k=;
        b=E88bNEtL97yVZVZz8p+PQ7XWCH4i6plpMWfAlyDVX35zqJVlHQUq/pklvZvW7o7QDW
         flG0flAZU+38fmy3jePSLUqyiTPEoeL9PkDBbm/NDwvsekzmBLLVACk9wZmFPyf0N2hw
         GQpJBI3v0LBefbxo3IbNsLl5AbKTAR04Mk3SxbcojwtwJpk8QLAjTEyHagEfqzAAu3ow
         faqnzJK10h8sY2vApYfUfJ4XeRgvK8tsEL3OVCaM3FiZa0276f4j1fkq72KHuRv7jcrJ
         fBADUWjMetJugX7fLIc8Oo013zn2wyrpT6X1Ij6QC4nuf9QbwMmrbR0tY9WNNE5vmERj
         KMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707945658; x=1708550458;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOS2B7sbqxhq5r87RRG1TrTI32jzxgx2gbxZryh0k5k=;
        b=naMHScmihY3KMJNwJ5jGCuwKppUj9IVrAqSsQXKuJ/5xM9hIj/gsrhfBAPmFuaCbMX
         vp7LS7ewd3NREBMAGlaJtuHtbNFxP371DFZ0bE6WqnUxKCIyfLyK5x68he45CxlLplDa
         2A5NIRSxUOezF3kQ0Nh/GTlcfiak3lfJP201WxytZ6WCdCTtuHck04BZtQ/HTX3Zi7kA
         rkrFOCABd1IabC7h3SIz7z3RUArWruhhebiQRzm9iYGKGUs9uNxUcQXXMcNqOL7+5JWm
         zJzc8EM9U+/mw/vwQpoexShs089vEELs1Tc7NXcgF3G4mAuY/C1N11ItsSJ+BAAWMTYW
         DwSw==
X-Forwarded-Encrypted: i=1; AJvYcCWa3vJCL1tWeroM7hxIRM4qx08AIWSUqoR1DCv8GU99CEIS0wQ+o2rIepYqIe+8yoMfueXdZVwTdsCo8HxaXRi1o6DIArTZkPjeaFhR
X-Gm-Message-State: AOJu0YwzAp3wWPXrMfDsyusge9fGDZO5/jP2OjSm+wtTBGowNt5hqhx9
	1qGJzNt66VWNIQ32ZipvzvinJXBVExm9vC35N3Wa6M+oKXNUJUU4SpSNpO429oQ=
X-Google-Smtp-Source: AGHT+IESSnAcoYGoUyHNkZHb6JzZCxOglkyOOBU1GX+rmYmsiuzPmbFGDYr5lywvK7ZqTp+8RlXZYA==
X-Received: by 2002:a05:6512:2354:b0:511:940b:fc62 with SMTP id p20-20020a056512235400b00511940bfc62mr27362lfu.1.1707945658283;
        Wed, 14 Feb 2024 13:20:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpvVKqGEGGnhNvXeluHoQkMPQaJN6hxC2jAk15VH9Gua3GJH/JM21CZRj07Hi1c4NzVC6baHex9pWOcG+YMKMCwcnf4njUApyuUS7olSB0BHtSPvq6rR3ZudCE5qtQM/MkZlN+Gh8DEhkr9dvCzXOLdOs9rMJeg62UOvRPDifj7T4HNCJIr+rCjtGay6b3qg/oFO4A3aETiIrfciJD5hE3ZM/eJRf8dGi26pcBkEYxsi4HbydC5h6R0ZABUkS/T0V6DeRuAd8RdbrXd0wODs6WUfwUYP813cuhXumb3Cvz8R/HCRFT/J2wIpVzWxlwzq4A1zPJt57ESL9SaHZ3F5e+ILy1JPfXQaTC0KUGkQgEc11RKPVigY3I8Md1YbEI9AxrVLPQa+juP+QnWkNZlsVBtvwA8ZuXzse689jmrSAqCB1eQoOOG9/JckadZiRG5KpVS+wReXo1EsT7uaFPyLjLWCyUGxvWFsfnmI19Zh6O
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id vw7-20020a170907a70700b00a3d73e6b2f9sm294407ejc.46.2024.02.14.13.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 13:20:57 -0800 (PST)
Message-ID: <ad20b872-0b50-4a16-b342-582d2f33eeca@linaro.org>
Date: Wed, 14 Feb 2024 22:20:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/20] media: venus: pm_helpers: Use reset_bulk API
Content-Language: en-US
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
 <20230911-topic-mars-v2-20-3dac84b88c4b@linaro.org>
 <a25224f5d28aa65e8bfd14fe0a8f599b9f9e3f40.camel@pengutronix.de>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <a25224f5d28aa65e8bfd14fe0a8f599b9f9e3f40.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.02.2024 14:31, Philipp Zabel wrote:
> Hi Konrad,
> 
> On Fr, 2024-02-09 at 22:10 +0100, Konrad Dybcio wrote:
>> All of the resets are toggled together. Use the bulk api to save on some
>> code complexity.
>>
>> The delay between resets is now correctly determined by the reset
>> framework.
> 
> If this is a recent change, could you reference the commit?

It's a series that recently landed in -next [1]

[...]

> 
> Since VIDC_RESETS_NUM_MAX is only 2, I don't think a separate
> allocation is worth it.

It's 2 today, anyway. I wanted to keep it flexible

[...]

>> +	ret = reset_control_bulk_reset(res->resets_num, core->resets);
>> +	if (ret)
>> +		dev_err(core->dev, "Failed to toggle resets: %d\n", ret);
>>  
>> -err:
>>  	return ret;
> 
> Could be simplified to:
> 
> 	return reset_control_bulk_reset(res->resets_num, core-
>> resets);

I intentionally kept the if (ret) to print a specific error message
in case the call fails, this driver doesn't go a good job of telling
the user/developer what went wrong.

Konrad

