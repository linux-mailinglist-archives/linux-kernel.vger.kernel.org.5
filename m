Return-Path: <linux-kernel+bounces-65023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31EC8546D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CAA1F2467D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36627171AE;
	Wed, 14 Feb 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdi+4Y0P"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979E17584
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905269; cv=none; b=H8HEu061MbvSiZcLv6rRz9AOlImF0JymTL6WupsQgUnpTxvvOpMDjyUZtPqFK3NJIWiJTwqUWLfNde2bwZr1PQyd+aKUvNBOkctOKq2CjIkr1UPDOTUgiVaH614ia3R7QFkO2P5CESH10VQ3NqjkLbi5GAjsLlz8tfS+aHVLJBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905269; c=relaxed/simple;
	bh=dDd52HcQ9FjnHXEVMovh5ndPC+i8WGVru7AVFYR0Ctg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6OH1RwS9TKEpvTJkYj3claM3hVhsWbQ0HbgDBzmgovqg3Q1Y6ZDcvro3PbwzaU3g3Zz4grSD4ZOKsyNyetwz7FbK0q3/ExAjcDjVVmRWyCacZ3ggGe7W+xcvL/Kp+vnXk69BmR3tEi7FS7Tbqvy3DHVeDhSuk7FlCwaF/r3gl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qdi+4Y0P; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3cc2f9621aso200261266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707905266; x=1708510066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4S+dmutnJlsc7Y02Zch4RpMAq9Ld2olVAZFnN/YBZNw=;
        b=qdi+4Y0PnvwriCofD3jfiBqWQ/ihHZ7fbWl81iE2cJzyWZxHwiReOhoZk30tnFgS6R
         d5oUr67J82QZBhBYBxLs0X/husIMNs2qalGm36qgPo0VPmSVyaBj0DNwjTzZzhQS/K6Y
         ur36jYk3LgWrt2cqcHThZ6PfQZm58fOhUc03Zwm0C9227XNqYskJiBmTfqFa4vRTIdEk
         Kub92mF82pLpurd3ahonktMHdgSuNJ+TMBvCTgmQEfQuJcbGJaxBiX5+ly/Nv/P/mvyj
         LQ2O3cQNN0tU2bxHYUdX9pR0yPmriX98TF8IwuEHE8wUpX/6p6HE3jkbpeXq3nSR1LU3
         kfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707905266; x=1708510066;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4S+dmutnJlsc7Y02Zch4RpMAq9Ld2olVAZFnN/YBZNw=;
        b=EAK8QGKaAe4C/Sy7puZbpu4Lx4RvXyWVkl1hAhmMAYYDBJ3J9DGsVukYY1t9/+I8zK
         mcg62fv7V3OICncreosAi8eEpsUhV2++ERcvfdnDPNC96Geu5VRrtTEZbaLpjB1r/pSA
         HuxaQOyNoDwZV6wmVMPvMT6oqsMLw/d9FMZHFyWf/SKV8KgVeUNMyYjDmJoxFDhTdfZ3
         Qt4jZmiC15WOHBBOmen0EWoKboI3vG67UpAGiNCyVkWMdwN9I0WAMbFUQ3uN/7pZ0Evt
         Uxz5DRRYgIeNrHLIedeH0QZW9l+6Uokk06uowgfvjTkE4q6lg9TOP0vrOjlWGDPWn/uF
         keMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9YofgT+t1ylBkfW5njSadzuO77GPtErmp9JhrMfmqcuhm2OJnLW8A/pzhTqSrrm/ojTYXu0TY64ty75sre7JJ8+RHV5UjnUq0qlRQ
X-Gm-Message-State: AOJu0YyF9qcml0M/aROx+ZJ/lynEJ8x0FIX5jZHygMHkfhDTSFnJwq0w
	9DK3arFBBqdSANG0dqKoo1EHAayK2xHGAgWApV9fPJDrZXDBRl4YQ63hIvHqvQ0=
X-Google-Smtp-Source: AGHT+IG16aCKvGqfGMvVqfd7HunSzBT1WwMQM6uxLmD7hXEU5em2A7Pi2aDEbxoiWobhCdQETRUgvg==
X-Received: by 2002:a17:906:e248:b0:a3c:63ee:ad82 with SMTP id gq8-20020a170906e24800b00a3c63eead82mr1319676ejb.19.1707905263735;
        Wed, 14 Feb 2024 02:07:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUv+vnzooSrKna4gOeIJgsQfvJUwjMcVVAIqhSfSiiv3nAleghG7SZi8yO/1pLRC5J2hnsueIPpuwSvyTvWWk2YdN07Zr2OoZpZNGqPggnfA8/BsVJCLGfyWDN7NQKCdIt6+hRe1PfOCEFjOfuwHv64iOLfWQApyPK5ldW09bVSzSTdl9BYM8Fc1rW9EPqS/pdpjBdWt3NxnS24RtYTIw8Y3vB22LAKmYCrOdWh0lbfi3TfYxWsSzLZGZ6Qwz3gbaeznv4mqRKFliKbOrtKVtzJD7AxKj5XioKUk2EuREOiUJ01Nyhwz/kZ/mZf/nyS13ixJ44Skondp7nMgCgoQZfOhKAks7GOejSyqbEQH6tOv/qVbNWXDQ4HFJz0gFfPdlprChw/Q6ZF5F+Fwsu59xHPeISYaEUO58hp7KRyW0mJ0iRpoNboGn37yHjnL6n+
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709061d4700b00a3d6395156esm53769ejh.168.2024.02.14.02.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 02:07:43 -0800 (PST)
Message-ID: <e2bcc8e4-e73f-4e31-b725-aecc51145cef@linaro.org>
Date: Wed, 14 Feb 2024 11:07:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] dt-bindings: memory-controller: st,stm32: add
 'power-domains' property
Content-Language: en-US
To: Christophe Kerello <christophe.kerello@foss.st.com>,
 Conor Dooley <conor@kernel.org>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-3-christophe.kerello@foss.st.com>
 <20240212-chemicals-skinny-18eda1cfe781@spud>
 <c57b8094-be08-4ae4-ba85-f48522e5d2a8@foss.st.com>
 <52be1d88-51a1-4ec7-8aaf-6046f5a469f4@linaro.org>
 <44f24885-eb62-4730-86fd-f42b3a3cca34@foss.st.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <44f24885-eb62-4730-86fd-f42b3a3cca34@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 16:57, Christophe Kerello wrote:
> 
> 
> On 2/13/24 12:57, Krzysztof Kozlowski wrote:
>> On 13/02/2024 11:57, Christophe Kerello wrote:
>>>
>>>
>>> On 2/12/24 19:33, Conor Dooley wrote:
>>>> On Mon, Feb 12, 2024 at 06:48:12PM +0100, Christophe Kerello wrote:
>>>>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>>>
>>>>> On STM32MP25 SOC, STM32 FMC2 memory controller is in a power domain.
>>>>> Allow a single 'power-domains' entry for STM32 FMC2.
>>>>
>>>> This should be squashed with patch 1, since they both modify the same
>>>> file and this power-domain is part of the addition of mp25 support.
>>>
>>> Hi Conor,
>>>
>>> Ok, I will squash this patch with patch 1.
>>>
>>>>
>>>> If the mp1 doesn't have power domains, shouldn't you constrain the
>>>> property to mp25 only?
>>>>
>>>
>>> As this property is optional, I do not see the need to constrain the
>>> property to MP25 only, but if you think that it should be the case, I
>>> will do it.
>>
>> The question is: is this property valid for the old/existing variant?
>>
> 
> Hi Krzysztof,
> 
> It is not currently valid but there is a plan to move MP1 on PSCI 
> OS-initiated.

OK

Best regards,
Krzysztof


