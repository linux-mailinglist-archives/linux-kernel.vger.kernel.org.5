Return-Path: <linux-kernel+bounces-157181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3243D8B0DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573CB1C23C36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B971607AA;
	Wed, 24 Apr 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhFp5CD0"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0677C15FA77
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972023; cv=none; b=UAZix3BjP9KZUBO7mj7jdI5uS1Ubt/x3Y1jUgSYB/ic6pKhrVD/6QVk5kQlRJx43qmC1HH3pJYruoCkFlDmSridVDyAZVBkQIG3p3zSg86U80rAIubvZERqol+tC2ZnUaUtkk0CTlyeER3eGUFRlJhTDPDOwok0qGXy965KrULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972023; c=relaxed/simple;
	bh=IkNwRhn2zr/N4GbMJYKRsLNTK467ZixseIRE0jdvaSs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VGdOhmfd6vuNEGRHXt4HpFdSefr8N+RpFUQi1YRK5BnW6BVqS5qtoAgGLcnYZ/A7DBOQHmV4uc6KQ2OzfSwi5tWmfWfgi3D+MsoXhhNg6Yz8ltsn5LJbVIh535zxdtCKv8CR6GqNj36tnlTWb+sd8WuhhsFYdQ30qQ2j/FssqU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vhFp5CD0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4715991c32so779064766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713972020; x=1714576820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zOSS4zpLxRuv23Fz6BcEqaOp6sJRoVP/DKysFYz4jz0=;
        b=vhFp5CD03AGUou84nuENq6mAx2ZyxHUFlGKq9mq+h9HE1oFWNkVHxXHNYJeTvIaO2n
         m51k4fZ14iyJKWPje8q4pqEFv8Md14iOogqiEXZb/QjpXIAc5LJDaWiXSsCKEEfZmNHC
         ZYu9gVnhuCbjd26ae0f9Hqj9aG4A0tzv9J9tKlYVPOYWiJG8Nf3F0Btaozu2GHaOdAhZ
         2+ocvscB//sR/HJwAvjKc0MIzXhEJbnEDyalrxNZX3RHK1aO4IGKXwGNW6ggSCcrw+AU
         f0tAzQppzfF1du1d1wFta/Hh47ttgtE6NrG3KW/kteiV9mboRzx9/aQhuyD/VF3JbNb0
         rE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713972020; x=1714576820;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOSS4zpLxRuv23Fz6BcEqaOp6sJRoVP/DKysFYz4jz0=;
        b=LR9M658F3uXiBhDu9d4+xiXzAOAWIOjPT1OTiS+pZKMO9xnZKDAAF1nblItYgUI6lo
         H2qcu4a7sIc+3drR1w0iLWjfupp3/V4QolG6cuOw47/3O1+KsbJpc35jxw5Q0s3XNK+9
         mecb5kY/BVGsS9vx6YPGK8DFAE0i/FBD3glk2UkJkK9Q3Sgw9sNulcYNv05pTQnx8Y5N
         aym8tLJvx0vVcxz+1XBN/d9EQNlVxPjMUQycWNg4kicX+bAwhbDDnN9A+PKs+rLZKyVg
         K3PMunZs9E59nZDdFJAnFIqE2j7X34UPzNEvTo0vRG2BiDqb75Yr0aMObdfaYM9r/x++
         D7nA==
X-Forwarded-Encrypted: i=1; AJvYcCUuQI6P/0ZiteZcxWVBHpU5n141MdZwhi4TCBzkoKV5eIBWJYWyitTXGPCsWasH0HOzJ4ypQsw36mWYUfjNmR6EGec4kV03NKiOZeAU
X-Gm-Message-State: AOJu0YxreaAzqJx23sPeLvFSh1uX4YG377TXhVGAS07DqJHu46tWxRWU
	HU/1ror4hW/M7DuAKdq4cFMk3jdlF4+ty45TNgMKa5lP3KqPrKk5d0113qGF+tk=
X-Google-Smtp-Source: AGHT+IElT8H4efb+pp6iL8JJpz3ZqX2R5Nc687CipE8CzOn8+/ZWQPr+YKXr1PYt283PJCyNlHCsoQ==
X-Received: by 2002:a17:906:eb10:b0:a55:73c3:f817 with SMTP id mb16-20020a170906eb1000b00a5573c3f817mr1716522ejb.12.1713972020285;
        Wed, 24 Apr 2024 08:20:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id dk12-20020a170906f0cc00b00a46d9966ff8sm8609463ejb.147.2024.04.24.08.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:20:19 -0700 (PDT)
Message-ID: <c0c3257b-7706-4055-942e-8f66678cd30d@linaro.org>
Date: Wed, 24 Apr 2024 17:20:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: reset: Add binding constants for
 BLZP1600
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: James Cowgill <james.cowgill@blaize.com>,
 Matt Redfearn <matthew.redfearn@blaize.com>,
 Neil Jones <neil.jones@blaize.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240424133230.19179-1-nikolaos.pasaloukos@blaize.com>
 <2a3d928d-3e18-4e3a-9f5b-94dbbaaf3652@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2a3d928d-3e18-4e3a-9f5b-94dbbaaf3652@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 16:16, Krzysztof Kozlowski wrote:
>> +
>> +/* BLZP1600 reset numbers as defined in the hardware architecture */
>> +
>> +#define BLZP1600_A53_C0_HARD_RST 0
>> +#define BLZP1600_A53_C0_SOFT_RST 1
>> +#define BLZP1600_A53_C1_HARD_RST 2
>> +#define BLZP1600_A53_C1_SOFT_RST 3
>> +#define BLZP1600_A53_L2_CACHE_RST 4
>> +#define BLZP1600_A53_DBG_RST 5
>> +#define BLZP1600_GIC_RST 6
>> +#define BLZP1600_CRYPTO_RST 7
>> +/* reset 8 invalid */
> 
> Same concerns.
> 
> However another problem is lack of users of it. Your patchset looks
> random - this goes to subsustem, but there is no device binding, no
> driver, no DTS. Could be result of lack of threading. :/

And now I see my reply at v1 saying that these gaps are unexpected.
Please respond to reviewers comments either acknowledging the comment or
responding with feedback. What are these header constants representing?

Best regards,
Krzysztof


