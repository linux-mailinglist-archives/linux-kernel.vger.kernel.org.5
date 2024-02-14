Return-Path: <linux-kernel+bounces-66077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DC6855650
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6977FB25D05
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D286127453;
	Wed, 14 Feb 2024 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wHhTRsyh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9AE1DDC1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950834; cv=none; b=gsg94wVbccByBlTA36jPI4RkVOB3MeY7pVoHAXGFLlDKlc/Npgmy9wPTy+jfdgOeF9rdwywvXaGnBpzM7XPrM2y3ezExpoEpQ6+WKSY3910lYiChoSTU15qFBESjZsQk3SIxrxlvbRZOeKZpYtHkIjnrShALQp4XRBhXbpxt8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950834; c=relaxed/simple;
	bh=Gf2q2LoXaXMedPaMD4X5vryBQGidRU+F1fsY7xn3vTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4gDuUONBkCfU92Qsdqrrm7u4gPSyo71wn5Gy1/Ntdm6kcbIBxbTe/uowH9XT75ApKSw7KAFYXSSPZdAX9agHph8nCnI3h2kU7V64huMVe/75x6zSvf9nuPtlk+Y82X+vaa/xF03BvPmGcMlyugxouxrtv6TFCq66Nfb90Il/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wHhTRsyh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso2057225e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707950830; x=1708555630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUrf1CdULtCm842OixJA1hbkk0S+s8Yppy8hugAej3Y=;
        b=wHhTRsyhWKbkbJb1jAznBCSr82OFQhg46rxYP1NByAfnYIbmAOq/HCNWqNWImc+g11
         18KjXh1kkzlUWo68CvG5XtS+vzMOMKAkiub3bOaYVLr0MoURWKFa9Lf1EgClnDAs88V3
         qyQTjVQgf9WEaxET4Lrmyr7tFZh9JYOuh+HalsKBSpDVFf5of0mJGcAMRrOs1XUznCU/
         5CnP/myf4Aii9jxw42aiAXH049wQ86fJupvEtMUfPvUlUSBdlGlaEPY9Gh8OCMH76/Ur
         WsJscL+k/ghjdWqvEVedHgUZi89IX7HTI7oOkIVXclg0zuumvFwLIxI27r0Pc27kCHmr
         3/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950830; x=1708555630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUrf1CdULtCm842OixJA1hbkk0S+s8Yppy8hugAej3Y=;
        b=jm71p2l+lh6dVsUDn+jPluOabTbXYpxtOqIev6R9ID17aZxbXR6yri0JJNn4rGNGea
         YQfWF02FVRn5nioA8Ilk5Lpm/E+bwdG055DvFKqK/mEhS4IvS2VjIzzNa46+rS/6dfPM
         hpKwLjqdSRcDrf3Hh7+2p9hBZKdV8LlhCa8Q84DiBbjYYl2reKle2LvD986BT7qLafnu
         MY7C0r//M7wpQOMrjtL1nO83Q/t8/hyhWXN2+j6ixcCRTi9izkhKLSKnfoB4pomNIgMA
         53jybDU8nRzLSxlIdaOpZ5ORkQoRdgFy3vVmKfbRVos1bNzOu//cGJ5QoUF002TetmPB
         xG1A==
X-Forwarded-Encrypted: i=1; AJvYcCWSct7PQgYUX8pjjglfT0TqHfyDka4keSe6eK4NcrmuD1aeptnRA3WscvSEE530nPKm+JJIk8gemeQUnN/LUlhpH7aupaiZdy+hTbHW
X-Gm-Message-State: AOJu0YxJulNLe0YHYtBwIJ6fo58aQaWymZZ/yM+hnJRmVJytZDFkJNxF
	iA858IEIX7SknS8ki2MDHIGbvE068/74B6YY2BwAucMxmGkcGDdBzg0AXF0Xv4I=
X-Google-Smtp-Source: AGHT+IEF0Q3O2U6SodhFam8u8dA5/7RjyuClhUhZCXtOazYRLN454yBVCp8fjcPNIkGRrG2GrW3qqw==
X-Received: by 2002:a05:600c:46d0:b0:410:3ffb:87dc with SMTP id q16-20020a05600c46d000b004103ffb87dcmr21608wmo.35.1707950830657;
        Wed, 14 Feb 2024 14:47:10 -0800 (PST)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id t4-20020a1c7704000000b0040ef0e26132sm1786389wmi.0.2024.02.14.14.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 14:47:09 -0800 (PST)
Message-ID: <df6a49f3-88e9-46b4-b7c3-e5419fd01eca@linaro.org>
Date: Wed, 14 Feb 2024 22:47:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix pm8010 pmic5_pldo502ln minimum
 voltage
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, lgirdwood@gmail.com,
 quic_fenglinw@quicinc.com, quic_collinsd@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240214121614.2723085-1-bryan.odonoghue@linaro.org>
 <13baed68-1014-4a48-874a-94027a6dd061@sirena.org.uk>
 <f38468b4-8b16-4180-9738-0a2b557651a1@linaro.org>
 <dcce3fa9-ecf3-42be-adf6-ca653a79ba2e@sirena.org.uk>
 <3851e21f-f8cb-487b-9ed4-9975949ff922@linaro.org>
 <a09d6450-95e7-4ed6-a0ad-5e7bb661533a@sirena.org.uk>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <a09d6450-95e7-4ed6-a0ad-5e7bb661533a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/02/2024 14:52, Mark Brown wrote:
> On Wed, Feb 14, 2024 at 02:44:56PM +0000, Bryan O'Donoghue wrote:
>> On 14/02/2024 14:13, Mark Brown wrote:
> 
>>> Not just that but also note that every voltage step in the range will
>>> have the 8mV offset added.
> 
>> The documents I have just show sensors attached to ldo3, ldo4 and ldo6 fixed
>> at 1.808.
> 
>> I don't think there's any better or different information than a +200000uV
>> increment TBH.
> 
> This seems like a very surprising and unusual hardware design, the
> 1.808V voltage is already unusual.  Note that this may break systems
> that are trying to set a range of say 1.8-2.0V if they actually need to
> set 2V.

Hmm. I'm sure the rail value should be 1.808 its all over the 
documentation for example when we get to index 3 we hit 2608000

REGULATOR_LINEAR_RANGE(1808000, 0,  2,  200000),
1808000 0
2008000 1
2208000 2
2408000 x
REGULATOR_LINEAR_RANGE(2608000, 3,  28, 16000),

And there are other rails @ 1v8 if 1v8

The one thing I can't easily verify is index 0 = 1808000 and not say 
1800000 or indeed that the increment is 200000 and not say 8000.

I'll see if I can ask around with the hw people and get a more complete 
answer.

Similarly now that you've gotten me digging into this problem, it's not 
clear to me why this regulator isn't just a linear regulator with an 8mv 
increment over a range of indexes.

At least the documentation I'm looking at doesn't elucidate.

I'll dig some more.

---
bod


