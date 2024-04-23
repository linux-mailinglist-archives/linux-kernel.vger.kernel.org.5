Return-Path: <linux-kernel+bounces-154817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F57C8AE16E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42310B21D50
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D05EE97;
	Tue, 23 Apr 2024 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOCOTKvJ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275756772
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866090; cv=none; b=ut9oWke5ugorZ30H8bS3aEFl80DgXGpaRvC4NYsJ7xbV7blpuoMZhYZvQXqLUkLNTLof141PoxbumTtUs003uye535+HY5LKiIur9W+QqYztZRCS7Mdg/q/UE92ICXV0vqSsdLm5R6oQKTvZuhTIAzXChVFETp6VV2gNECqjqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866090; c=relaxed/simple;
	bh=TcvuEYLws2fboubCzoAXSrZP5EX/PhUVq3p1ipmW6hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQ5jrvE06WP0iAwEeaMR2Jkdq+TitXHOs945jjEIyqEjRlUFXUuYLa715r/BNeS22SEosbxvzsKAlJR/0UepiTdQi6DGHCGsz0aLZ24OUoGMjViR8ZUvJ69J3IeTxOogsRZFC7Ecw3YFR2EwWlqceB1x4UV5k/khbvAohutLb4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jOCOTKvJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34a4772d5easo4371394f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713866087; x=1714470887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QGmqwrxoYYNL7ItgGfa16lOMAGRJ/1BRq31t1v+wXrE=;
        b=jOCOTKvJ+bLfBsyZYST5YwRbTvwlEuWSL6OvOXFuCJDj0fvpSmmQ9DRRYFlgf4lajD
         ONop6jnfZD02vX1x9oDW6GMwvVnipisRjdDeb/uWgFEIzkpNLFt/KUZVKaYWmRhBjn45
         o3jmJS+sjTWnDqLXZA9YHliB25sbLthFd6aVFbY9oMmtOVHkzR7mjf2Ukt6fjwGeYBvC
         lQ6qAd7QFwe1GCcLFZnHwJBo4dqvnoieglaDFXJPrMPzbWG/DGbv4WJ1Vj4b/6CpzA7x
         hcJLufOaKZYLKeP4KgAIoXJd/1Xz+Fxdg6Jm5QWNZ7kh0V0mfDSPmoVKE4kjc8ClHFDT
         rnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713866087; x=1714470887;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGmqwrxoYYNL7ItgGfa16lOMAGRJ/1BRq31t1v+wXrE=;
        b=hmtDie/ssI9MbL4uxZ/ah5WHMFTfesL8x7snfGcrso6DdcHFDzTsWah3Tlq0qR/x0i
         2Cnn+cteckDWqHUH4QK0+hs/LB+uFJCrLH3CLvjNZOS+YyVYnzUXIuFaH7uYpAFs1k3O
         WKo/3UavZSf1tVo2JvSNYXO7dWwCXwBGbX+f5hEN5IsuVLU6iOA/P8UPWUWCPjZm6G+g
         oBpVOAqJ5OR0XU6cDr7DiSdWk4aZCMpv4Iw+roPsT7X01qaUkom3njkOFOrbt7Mafmcw
         zVk3SglS3WWxfzmIXL/FJkVUNx799FRbhA+imywword09Pk6GwDDzEfmxv7bEANVuhpU
         2tWA==
X-Forwarded-Encrypted: i=1; AJvYcCWHhmXgwddu2m2/9mV6x9CYVzro/KHe0Cce+cCc5fRNzBGXJO18ZTs2C/0stDsbFV1zKPt3z4wFh6w0cfromqMAJzgL0I3lJeGbHWF5
X-Gm-Message-State: AOJu0YxQ2qubbwUW3KzWaxWTHm3arXcJE6IIex9hySbHw10rVt1y0H+c
	CARPTh54ksbdej5GN9nLwy3GBoupBiXi0DKzZesLKevQPCA+aBjIMO88Ft5llrY=
X-Google-Smtp-Source: AGHT+IE/LWXfsKNKZXdZV14oyl4JzTZ8tD01rfU3dW2+ZPhcML7vwZuDNPaGuU/TzZKO5imlcL/WGg==
X-Received: by 2002:a5d:6743:0:b0:343:ab10:f31e with SMTP id l3-20020a5d6743000000b00343ab10f31emr8273049wrw.42.1713866087320;
        Tue, 23 Apr 2024 02:54:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d434b000000b0034a2d0b9a4fsm13016234wrr.17.2024.04.23.02.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 02:54:46 -0700 (PDT)
Message-ID: <10006d22-eaa7-4414-ae4b-d1c9d57f5a13@linaro.org>
Date: Tue, 23 Apr 2024 11:54:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] dt-bindings: counter: Update TI eQEP binding
To: Judith Mendez <jm@ti.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 William Breathitt Gray <william.gray@linaro.org>
Cc: David Lechner <david@lechnology.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20240418221417.1592787-1-jm@ti.com>
 <20240418221417.1592787-6-jm@ti.com>
 <a0eee08b-17c0-4089-85eb-d645cbcafae3@linaro.org>
 <e58ff9ee-b050-4ad8-a060-dc0e33cc4896@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e58ff9ee-b050-4ad8-a060-dc0e33cc4896@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/04/2024 00:11, Judith Mendez wrote:
>>>   
>>>     interrupts:
>>>       description: The eQEP event interrupt
>>>       maxItems: 1
>>>   
>>>     clocks:
>>> -    description: The clock that determines the SYSCLKOUT rate for the eQEP
>>> +    description: The clock that determines the clock rate for the eQEP
>>>         peripheral.
>>>       maxItems: 1
>>>   
>>>     clock-names:
>>> -    const: sysclkout
>>> +    maxItems: 1
>>
>> NAK. That's just wrong, not explained at all either.
>>
> 
> The intention was to make the binding a bit more generic, but I see
> that is not the correct direction to go, thanks for the feedback.

Bindings must be specific, because they describe the hardware. Your
hardware has exactly one clock input pin, not some superposition of pins
which change depending on photon stream.

Best regards,
Krzysztof


