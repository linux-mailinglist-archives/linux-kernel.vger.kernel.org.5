Return-Path: <linux-kernel+bounces-59687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF4884FA6D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE0D1C25276
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BD57E77F;
	Fri,  9 Feb 2024 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+mpLagT"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B517C0AB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497952; cv=none; b=JQ8AlZQN5B0jI4negn89IP99f61WGidcPqgteA8kFXegOOhbcFoahe35LiNWGonx3H2G7Dh1vfJyyCkkvomiYqtPGNuhEjES/J4ZL57iIYMbGikRkdapvERceXrV8IaTSXdwZtqvmXrtFXkz9Y1Moz30lBiWd7t1lp73WHGeZ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497952; c=relaxed/simple;
	bh=HSkd3gG6bfww/nT3M6MV7Xc8AQ9F1ffmK1r1nTA7oqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bbx0EwxOtH/L0AulyXpUDwKH5GKtjSLqkg1ta0DI6aTvI07024JHQm5DxsMTn77f5kHNlMUJqKb8X/rgSx3k0lhtIwz3VEkMpmWpuSa7MaI31VZ/V5VYtj0ldhjiZOGCmZo/VDnBpbK++8JaWcSJ/n0gMVJb/UUaW4BNCV8mf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K+mpLagT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56001d49cc5so1495837a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707497949; x=1708102749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qjAZJUl692p6CGKzzwOgIgdtmA0+IsSLhcfPdiLRgGc=;
        b=K+mpLagTkOYxj49Sosph9ST6JU4kzEy1gpUAhTmK7OAmK5Re0QqG2z4wOUUISUA7hn
         ehyzad46q0H+O+nfmODCPFEk965IaXYdz9RWtevUmThq1H9b6xcH0PtAPudtRVxbQN06
         keyXxd43ACZVN3arLtzzoqcc0UgWUQvpfjBtieGAf5NSbE4Wq2e3kmTKsZy0HHnH2JvX
         3XN9QuW5H2KALoONhlWkK15SC7C+zoFHYyvCRXqdq4xvcfOc72fxVqifWUns2LnY6i5V
         HD3gdMS8HkAg+5d0jgS2iqalsNabG2TCEkxdUBUDM97yXMjzD9umB/MRyOEMLo4sEoMo
         0jRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497949; x=1708102749;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjAZJUl692p6CGKzzwOgIgdtmA0+IsSLhcfPdiLRgGc=;
        b=XpmjCkPhNOhQ7+bELIXCMFuoDlnL+qQKWDr4EF6xAqIzh0DCCN+H4bYPnjUIliw8FS
         rK1KyEiQHWQ6cquKW74UBxmL0CP/NYOAM0gNB4v7VoR9n5Ri16z18BQijauEjZ4Fu8k7
         VbbrRJFnFR6qLfpovnz+6z/anzElxfXLFkbEa1ZHZU7H5YqWBeFHWVkGykE1q8AWBVHh
         5mxJkoHTZcxSYeiDinNz7qPYme8KCUMl8ytsWJNop8mtUxubLs8D2M3MNAKa+DZ9J/mv
         V8EJs+Cu3Ew35hYRQSgik5EqI1THRdRtISezbIftMtXFuZYO1aEBYtN3ZLIeNLeEd2Zb
         l1Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXk8dMI43A56duIGzuxo230EiytuJHqyvWMKq8RThNPDLIGMXmUciMetYJnKZRzGjsjb57Oxkl9R1IlosLzU5s2r6Ouw6ofa2Ufk2OU
X-Gm-Message-State: AOJu0YyqEzrj5GLOAaVSFuJQa5xiWGqNHMdcT87JwnonF1ygsW7REHfA
	hdN/MeQJ9N8j/9BXofHFoYUV15AdGZ8OaHv+MO4xjkf98k2TSk4aV1p3hCoBLY4=
X-Google-Smtp-Source: AGHT+IFX8x+RZNJfUhDBAZS0uwBbshJEhHmpKgn1gYNDdH7f74qT3t/7aYKnMAF0sPu2Ny5idKa6/Q==
X-Received: by 2002:a50:ee12:0:b0:55f:957b:132f with SMTP id g18-20020a50ee12000000b0055f957b132fmr1635919eds.25.1707497949099;
        Fri, 09 Feb 2024 08:59:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWo6xk1rvwiotz67poG6T4ZQR2YaGisl06Qa4xGVI4jMpvV8dtLEQ5aB1BKhhH1hWWQqEq0+Lj8q035d/aBNSb5Fa6MhPrg4I5LQU27Y8KQhrZ4NacFi6es6BbcvvQZGLDkV1SWHWva78unDGrua0HV+3wjWJAX9U6M9J/VAWelgvV/AwNMfAb7f4JKCUd+sRmSG7S79FY9DcG/S5caJ/GqiKsJTVaSwEy0A3UwB9k63Px/oCMbjpxEQxwClAaHJa6bnmCm7u+5eANI4yn2k20jBnXxbG+l1AA6GB5TAEH/UBXwmdE9gs4W0z1kCaZ+WI4LaQl2HzQUP5f9C4syfyWSBtkftXHS6Fph2WisBCKsrAnFnlb8k1/sMOi7ZH+iypBPQ9XM+FhdFFOtNBQftCfH4Y4LTZcmDEomKazqMgSo92c7pdw7Ujmn1qW1BVtnsb/63Azyeq5Of9CXfEYFuyNpIpyKrSvz7A0N8xwJwIVluXgpu69URIwMF8H0VAsPVZILI8B04B4PTZFcHl6num6l5xPh
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7cfd4000000b00560fa14c0b7sm937112edy.33.2024.02.09.08.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:59:08 -0800 (PST)
Message-ID: <e660af3f-60ed-4386-b00e-98db61ee84c4@linaro.org>
Date: Fri, 9 Feb 2024 17:59:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: msm8976: Declare and use SDC1
 pins
Content-Language: en-US
To: Marijn Suijten <marijn.suijten@somainline.org>, g@somainline.org
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Luca Weiss <luca@z3ntu.xyz>, Adam Skladowski <a39.skl@gmail.com>,
 Martin Botka <martin.botka@somainline.org>,
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240121-msm8976-dt-v2-0-7b186a02dc72@somainline.org>
 <20240121-msm8976-dt-v2-4-7b186a02dc72@somainline.org>
 <808bd239-6a61-4932-ab91-3dcbe10a7a05@linaro.org>
 <tz3vwpcpbctxfx22rbhdnpy7fljijtpbdlmq6jwtw3jcvcwpka@3mnyq5h5h7bb>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <tz3vwpcpbctxfx22rbhdnpy7fljijtpbdlmq6jwtw3jcvcwpka@3mnyq5h5h7bb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6.02.2024 23:36, Marijn Suijten wrote:
> On 2024-02-06 19:58:50, Konrad Dybcio wrote:
>> On 21.01.2024 23:33, Marijn Suijten wrote:
>>> Add the pinctrl states for SDC1 and use them on sdhc_1.
>>>
>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>> ---
>>
>> [...]
>>
>>
>>> @@ -840,6 +890,11 @@ sdhc_1: mmc@7824900 {
>>>  				 <&gcc GCC_SDCC1_APPS_CLK>,
>>>  				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>>>  			clock-names = "iface", "core", "xo";
>>> +
>>> +			pinctrl-names = "default", "sleep";
>>> +			pinctrl-0 = <&sdc1_on_state>;
>>> +			pinctrl-1 = <&sdc1_off_state>;
>>
>> -names should go last
> 
> Per the cover letter:
> 
>     - Moved pinctrl-names before pinctrl-N (Konrad);
> 
> You explicitly requested this in https://lore.kernel.org/linux-arm-msm/60a40ace-d4e9-df74-88f9-4354d80efaac@linaro.org/#t
> but we also backtracked on it somewhat for consistency with other -names, and the general state of this file.

Agreed, but we made up our minds since 2022-12-15 ;)

Konrad

