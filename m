Return-Path: <linux-kernel+bounces-51267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2780A848884
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5C61F239B2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE1E5FBA9;
	Sat,  3 Feb 2024 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TG61Sebl"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBCF5EE6C
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706988339; cv=none; b=jqxitqVu5F6oK30F5TGVGareS9smd9d5URW+lqgSiv+Dt6kLThQkBozlTa+Ntlax/64UNlRH71bgTtTC3oJx8DBJIIXRIgVTjclJCj+TvQD/7LIarocNivC7tF5Iqj1rFxZUbW+E/S2vX4uz1SEnSdtGuap30KxSpFaCNyDaugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706988339; c=relaxed/simple;
	bh=WZuW+i9I0SbhN74JIp5ooyGufqf923Ax0b/yXy/pogw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFt2mEW3qCkpDkj9WRxhYQXle/vklixcpsu2e+dTZj9ThfsjVuTuzEOaAj0FisfaukNHw4WIvfzFMUHN7Ate7BwPw4wIfMH4/lCu3jhhWrYVhGdwqjI5g4WzPl8vlaGfKfNSwjkZpVpbSA+6msw+CcnoUF/t9sM1GKAVZJcRnjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TG61Sebl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so3962300a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 11:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706988335; x=1707593135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEML+AOM+rv/5aZrMlAah3f4OGCAU/KDw6eugc8miJE=;
        b=TG61SeblhEAHzBBxRGKSkf9FJgNEj4yqm5y5LLmqy5ZYmL4oG/Oq8kHgJt8/LEX+k/
         /R2KEc3kWiUpmZN7mAp0fn+apnR19WxWRgbRPmIHwzNxAGTHC+DKXd6Hck+PELE3/Sz3
         hk47npjHF6vkYX2uM2zTGgQ5i3EHNGdEub0YYdCRO36jCUOPimZhwUuePNRSYt9roFri
         KK5i9+aZhzNAPraYEQ/E38SLvSjHZ9Gx4hL8MQsD12PpaXkv/rOUEHnVI3wklsJtdpy/
         XlA3KZA7gWpGRWFxLHNPddusz4Q6V5IQ7mXCbg/oCAklY3aDJKTQCdTvpNawxiiGlSy0
         QW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706988335; x=1707593135;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEML+AOM+rv/5aZrMlAah3f4OGCAU/KDw6eugc8miJE=;
        b=u85U/CR2zpDUsQb3vWxS5wuQr2P9JvpuPq89X0wJqEtECnr/Nk7z4ByTqrjZW4m3tg
         HKRLvQVDYDU1/9CMFjMTq/yRhMCzDDZg4hFS/K5+Z6soMogHg1sdefskja3GP10IDp7P
         +hirngMv9wNS5HXaW3HoehYnMYXktGtPHUvg4lY5/qKel1cGvElbRi64Wey+nBO/g1YT
         UnklEqsHR7UOwe321ktUS19S21kFNkKSPw0gu/W2tIokKhOghae1cIwk87BfZEF4ryoY
         Dbqs1hoGxMcFnyqyMZGmYrqLXtSCV2YSXnd/dc8J80as1zsjVqfDk58+ZrO0s9xq8Fan
         1+KQ==
X-Gm-Message-State: AOJu0YzQdagJkVMBvqH/MF7JrtW8IB/cT6r8MWq67/ZFKfTz4VP5PHAz
	1MovtMEJYL/hT+jIQ/CAtU0vlPhP2WSGjl8nRaO+9ba52kVqwmg22QylfE0Sy2U=
X-Google-Smtp-Source: AGHT+IHGndbrFj74i4kASgzVXdEPH7tSWXYN2tnwmTOEl8FmjUKlszk2RL/MmK0W4XJNxF8eOB1FPA==
X-Received: by 2002:a17:906:19b:b0:a36:fd11:3f98 with SMTP id 27-20020a170906019b00b00a36fd113f98mr3934343ejb.17.1706988334706;
        Sat, 03 Feb 2024 11:25:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVxM946bFfssIgtIHzYj7lq97yueIzD1LqLA14uMf1g50QzWVHT4Dao1F4ZmQF+rBDUIkw94fOUCISvJTH6xhQg7fvx9bSe9lWcmiZyESYVO4ok7tijGoX5I4cBPh3iUImHr/rZ+SneSo0tzfaTpDTseySa1Jp+kndSx1iCTM3lRNr3pA6GvhNBTmu/slc0h6d9cbn9+IFUqpUSGXy2KV1XBRcwGsgnd6sosiaFHSPAhZCV1DZ/Ce1KKzkWSheuyuvNqvBn8E56Olp4
Received: from [192.168.159.104] ([37.8.245.233])
        by smtp.gmail.com with ESMTPSA id gx2-20020a1709068a4200b00a35ed4fd4cesm2296206ejc.115.2024.02.03.11.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 11:25:34 -0800 (PST)
Message-ID: <9f3a2850-6a4d-4521-94a1-3e1853a22815@linaro.org>
Date: Sat, 3 Feb 2024 20:25:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: move
 pinctrl to appropriate nodes
Content-Language: en-US
To: Anton Bambura <jenneron@postmarketos.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240203191200.99185-1-jenneron@postmarketos.org>
 <20240203191200.99185-4-jenneron@postmarketos.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240203191200.99185-4-jenneron@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3.02.2024 20:11, Anton Bambura wrote:
> Split keyboard and touchpad pinctrl nodes since they are for different
> devices and move keyboard, touchpad and touchscreen pinctrl references to
> appropriate nodes.
> 
> Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

