Return-Path: <linux-kernel+bounces-39998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2C983D92A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F83AB3FDEA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E0018626;
	Fri, 26 Jan 2024 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4LynXlD"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9810A3F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706265083; cv=none; b=WvmK8mXtRC/3ZZolN5FqutKmwJnlXIo7tPjDmR6Lu+qjPcTm1ZTZtiZq8QRHsWvnqvDFPy7Y0vBdPc5iDnGB0XtkAvPenEvLWdYTEJyz8D60f5JBupfxwVe/wlHg93M0jlWQM2aij5b1eSvrLIyqvUhagi5BRiUEfMMgqelNo04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706265083; c=relaxed/simple;
	bh=mA9FzBR11+sFbyfvmeV378MlNoQCygN7NGjc2tj0RfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mb1TNiX7yit2jhQjmm1UAdt5gdiG1gVMTIx8tQb/dOqLi/Quk6xUzRROpWh/KVFa9gSwobfM1nwJSUlYIokDhN7ufZiojsY+ZLAVCilieG3a9/iwuAtLekiIuPNu+Izo69EvOEEvekek/JYqWbniOwqRD9czeZFhLZUtsLDYNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A4LynXlD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e76626170so2930265e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706265077; x=1706869877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xY/olUuP45FR3IVgjtkQ5gkoq4C4DXL1vFc8k8OcvMQ=;
        b=A4LynXlDt+TMBpwxeUxZYQ4jT3gpzznUAWJV8nthzuh7KHjzj8ZWxnVn/vH/StZw5D
         knMqAduANcf8QmL82y8XfFCk1xUjcVslZ6JQfK5kg6LueFcthg8r0+MdLhGzDXdNVCu6
         Slgouf4MHlxDi5FNVJa2N95TK6hb1qA9ZG1Fj422qyJ53Ui0QTtLHL5lIVr4kRSr13Jq
         bvLWvrK2BhG8RkEt+GeygNeChPEh6/wHCr+FRV7wsdXE0bzwl+CrEHzg72T3DHRZKp33
         2qVAo4PaT6Dt4OvWJUv5dwZqxUXBYE59Ra7MA4UMXeC2yLXolCQ3aY7Dnvew7PrruLDW
         zDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706265077; x=1706869877;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY/olUuP45FR3IVgjtkQ5gkoq4C4DXL1vFc8k8OcvMQ=;
        b=mNKpY5RGhRrZqR5ozBh3bs3jBjVliP37DqQyaLvLWDdoLJu5kUa1/v/nfS+MwZIWQv
         mT1xKzggWiaN36/xq2zKIIDgS/cnQUC8DNUZXuPSJzKY0hOHoSoHSriqgnSIANu9YydK
         KbP7/Y971olqXt7WwCgTc1wzXCyhGuSVVl2gKR+s56K1KGnCj1PeO1IWy2XQN8B1cjrk
         WyGRyGkKS53SdcD3RyCZqhBesXDl1oieG3hjE9Ujye8tbrMrSg4itOz0FtCvE4Rb+FMz
         pyPgFl3iB5+d+OShCi5YKHRHp35ag2Fw/gTLcMhuyfKuFcAi2msCm6cuBWUTsd5HicBe
         Lz/A==
X-Gm-Message-State: AOJu0YzPEFiSxRJk8uUDywvWEDhKiQsM6rWW81A87Kso32dWCuwnamhj
	DuvExJce7jvEEnyAetCVLC2DP9RfaE12xeFZdop2q0gmgVdHc7L5msIY9qVR/9I=
X-Google-Smtp-Source: AGHT+IFSxBmY4AK7fnqnR0wnoQI9b3JjKwSD1W5GPKy3gNmbzOadwxPrwj/Tnn23Os68r8aFtPZWUg==
X-Received: by 2002:a05:600c:1f82:b0:40e:d4bc:edaf with SMTP id je2-20020a05600c1f8200b0040ed4bcedafmr754513wmb.16.1706265077632;
        Fri, 26 Jan 2024 02:31:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id cx12-20020a170907168c00b00a317ca8b422sm480445ejd.92.2024.01.26.02.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 02:31:17 -0800 (PST)
Message-ID: <6f5172d1-b741-4bae-8e30-c3a3d99197e7@linaro.org>
Date: Fri, 26 Jan 2024 11:31:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/arm64: samsung: Enable W=1 on dtbs by default
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231116211739.3228239-1-robh@kernel.org>
 <ee10e67b-6a2f-4ab5-91ef-e42d2f03a424@linaro.org>
 <CAL_JsqJ67tZOmhTHQ7KqEbFuDjK8sKHR1FFtAFAaGjZ4uYi9Uw@mail.gmail.com>
 <986db909-144b-465a-8c46-273042a4fe5e@linaro.org>
 <20240125-unsaved-promoter-c0bc72bb4691@spud>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240125-unsaved-promoter-c0bc72bb4691@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/01/2024 18:51, Conor Dooley wrote:
>>>>
>>>> 64-bit has still few warnings:
>>>> https://krzk.eu/#/builders/29/builds/3710/steps/26/logs/warnings__6_
>>>
>>> I may move that graph check to W=2. There's some cases where port@1 is
>>> optional and it doesn't really make sense to fix these.
>>>
>>> Also, Conor wants to do this for all of riscv, but this solution is
>>> per directory. So I need to rework it to use a different variable that
>>> can be per directory or global.
>>
>> Just to clarify, because I still have this patch in my inbox: I assume
>> you are going to send a v2 of this, so I drop it.
> 
> We got
> https://lore.kernel.org/linux-devicetree/20231122-dtc-warnings-v2-0-bd4087325392@kernel.org/
> out of this instead of a v2, did we not?

Indeed, I forgot.

Best regards,
Krzysztof


