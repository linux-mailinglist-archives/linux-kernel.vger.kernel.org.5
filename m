Return-Path: <linux-kernel+bounces-133469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F235289A429
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B2428C539
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2351E17277C;
	Fri,  5 Apr 2024 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x516Pu3B"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91916FF55
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341359; cv=none; b=oZuDz86hxs3bP6RN0QaqwzcKHp///WMnf1FAWXLALTPw7I4Nn+F/r0vsmmRmzxSYpcP1/UYWQtypj2+Hi+xHnewCURU6oy152dwVLOJuejvMvybvDZ9fsNF/hJ3PhgagPwr0gAVLPXF+B/iFOmmRSw7SdfpusTe04n7b5bcZJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341359; c=relaxed/simple;
	bh=Eb4QivfojF2KBYGQtLTGj79v9spvtkcJ8e5SELGKaM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmjPofTAnUH8jvmu0DDC1hGaebuIKvEus4HdWHKJvF6lAgqsKCkDQ9E2cWVCsJwLz6h9PeuqvOUAgfu0EfFECVY9kDWp6Ed2/RHr6SdiMQo8ORXymvGQGoBPpOeTEL1gE80gqad+XbfHTHPvIT6s4pzSUVbZFuVliBp38BGzdU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x516Pu3B; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a468226e135so351359666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712341356; x=1712946156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sOgo5RZxyLQAXRylmOVlpLWGQ8hgIzVwKAwYPoIs/oI=;
        b=x516Pu3B6qplcu3f2CsJ/bJ7Dy7vTAUacSjzuHO900Gp6Rlh+Pkxs9LpTk/ZknFq0t
         xlPmr8oEjrXU1Bmd1D5XEnAD6DU2N5eFkfVosWIK60JOcYFi8uXsv5ENu01As4zKCFvl
         0XZ6FE8cW5m6BlpjaCooqgIPICk6ZgxsL7oeIAUjyPPiu7rnd/EKy4dRY0ZidMnecB8C
         ZnY2g4PZ8whC7SRrUrjeY82Z9Ybxu6dNzEQ3NXxi2itTCExpEnC7k4Yp169PMuO606sr
         skNA5CYug7KDC7BqtHVQmKlX8v35jg8yhBg1p4EkyVHIxVYZMyZ2H6Qi0SK9Whis2YQr
         +W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712341356; x=1712946156;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOgo5RZxyLQAXRylmOVlpLWGQ8hgIzVwKAwYPoIs/oI=;
        b=qqT8cDerRu2TywQtR8RBMyWqpPi9WdW2YnS3zOsyb7ct5BhxXPActY89SQ5YURng8x
         iN9MunYdd2ZmyJFNlaqac/oQ3sHTJdTqgk80Z9KDVbhxBpjNEZ9ZW0ZuMuwqG5ocl/x8
         nVN89cU8kieU5qFwNWdwAa5DV7NsmjE9T58ttyUqW8/qQwciEleRU0ZlRlfjMeGupeGX
         PNSJO8Yyi0u3mqcNDHDySK6jS0/rLXVtCQpbUsjQNMLZvEG/vAyArM7G8+b867ukBwXk
         6qmsFD827g0ecyojZA9CxqMHdvtIg2Zu6hkW7Y9E5lq/7eRGmbPz/+fMgGB/VWXIs5Zv
         9FaA==
X-Forwarded-Encrypted: i=1; AJvYcCV9SJ5G1G6XivIxT6Y6QCQZasYcWol1rO7ObvD/ZY0bpZhMOXNJC7oliYCZhf4mN4qAkKA/W+wTpJgyIa9qEV4t3KAMo8FqE9xYsDis
X-Gm-Message-State: AOJu0Yw2645W6fWSdP6OF28jEC+S1DHVrli8qwGIx3VhIEMbYEi2iS12
	Iko760CpGNRicHu/xRURSEuN5X2/V7gFbPceDiy7iAB2imjpQSOD4mWr2Si+/wU=
X-Google-Smtp-Source: AGHT+IFMQw/zKN9uRvgPRGc5zVaArbDABcW2Xzw06jTWHFfwmg2dJuOHt9bRUfiMuGmJkzTHkqqx2g==
X-Received: by 2002:a17:906:565a:b0:a51:9737:f23d with SMTP id v26-20020a170906565a00b00a519737f23dmr1469625ejr.70.1712341355878;
        Fri, 05 Apr 2024 11:22:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id hv6-20020a17090760c600b00a469d3df3c1sm1105557ejc.96.2024.04.05.11.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 11:22:35 -0700 (PDT)
Message-ID: <7279fe8a-5727-463e-8dd5-08f2238b3499@linaro.org>
Date: Fri, 5 Apr 2024 20:22:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v9 2/4] dt-bindings: stm32: update DT bingding for
 stm32mp25
To: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240402125312.277052-1-gabriel.fernandez@foss.st.com>
 <20240402125312.277052-3-gabriel.fernandez@foss.st.com>
 <e70dc513-df9f-4b99-b9d9-7ebaf83e8f3e@linaro.org>
 <285f2f64-58b0-4dd0-9f1a-89306a79d572@foss.st.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <285f2f64-58b0-4dd0-9f1a-89306a79d572@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 14:54, Gabriel FERNANDEZ wrote:
> 
> On 4/5/24 09:12, Krzysztof Kozlowski wrote:
>> On 02/04/2024 14:53, gabriel.fernandez@foss.st.com wrote:
>>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>>
>>> Now RCC driver use '.index' of clk_parent_data struct to define a parent.
>>> The majority of parents are SCMI clocks, then dt-bindings must be fixed.
>>>
>>> Fixes: b5be49db3d47 ("dt-bindings: stm32: add clocks and reset binding for stm32mp25 platform")
>> And except what Rob said, this does not look as a fix. How ABI break
>> could be a fix and what is even to fix here? Please describe the
>> observable bug, how it manifests itself and what is exactly the fix for
>> that bug.
> As I replied to Rob, there are no RCC STM32MP25 drivers already upstreamed.
> 
> However, in my series, the DT binding was merged even though Stephen 
> made some
> 
> important remarks that needed to be taken into account.
> 
> That's why I proposed a fix to update the documentation.
> 
> To be sure, how would you like me to proceed?

You can send v3 and get exactly the same questions. Your commit msg must
answer to all such unusual questions. If maintainer asks something that
you need to explain, it is a hint for you that your commit msg is
inadequate.

Best regards,
Krzysztof


