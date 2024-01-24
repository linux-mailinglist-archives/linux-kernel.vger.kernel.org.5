Return-Path: <linux-kernel+bounces-37407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A373383AF65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83921C22C98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831337E796;
	Wed, 24 Jan 2024 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/zKUaeB"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B982D65
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116442; cv=none; b=cMOnB80l2x+qRa8DwyiNYgEHA1ySqV/tCNsOUFDkzPWG4Sf9pbt1pIXgLe1EruyHh+QgAHOiVOVl64dfqd6cJojran1Nzh3OyP7UKclGaFdWLiI9eTJUljGIiY+few7qGB6XXrKMEE+HW67NRdlBj4vTCnuTdsfLesanbicjYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116442; c=relaxed/simple;
	bh=ksY3FyxrpeM45qULHI2CemOCxVkP1KI3deN11YyyMJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCk2pD7BUqEAuQ+VlfE2vdMrKZZ9CqwcSxybM3wZzUVLi+ZMHILLnnrl0Ok/l8uk+tfX3e8Jkcs8HvDEvpzAFrDxqNsdyUluZ5Yz3ADlQY+j8QjfizhUuGG6ObxrPl8Q3Vsvh13ZVBamHm4Xj0gqjv9GpBg2FSB0+ZfMCIgWECU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b/zKUaeB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3392b12dd21so3710670f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706116439; x=1706721239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fL7vekHcmLaJ+7QQ0HPquBXHA0gUr2biUPM9ZcIUwI8=;
        b=b/zKUaeBH9dJFNKgz8844KBmL6sFsdBFPZrD3Nk0siqqLk10IpOWzjtcAqMGKa78D8
         EQJiyHdMe90SRPUN0QoCBand9ECO2f40TJtZ0XqIbv8Li+IB1Ku8/yncqdvvwzxX9JuS
         4LMClIyqL18eTYhiPk+a28gm69o78iX27EdyQ7KE4sopEUfFC4Skv8slk0YG78mxFvvo
         KGgDFf7d23NtcVq4TkJmDT16YxCo7Yhv//4fQGhnKCQRY5UIgrpcKrUJUP/Qn+xx3SPU
         IQshVNJtEfS1YFPjV+k5c8SNL+DQY+ZPVrNaLb1OSFGglI718gUILC5ykFrsDQE+Zpr3
         hkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116439; x=1706721239;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fL7vekHcmLaJ+7QQ0HPquBXHA0gUr2biUPM9ZcIUwI8=;
        b=sbuzGeQJFuwMcBuX40OiGKAUJeLQanGbOnQlM9FW03E0twVBA2jRbDvmSsCAgwoSbO
         u2Buc+guo2jWw7aT6iUVSROlzPSULKaBsktdHdMqf3LQ1r2wbQz7eOgHragyDfCYDejG
         mXwZEdjoOCw75mmJ971cK+S1LU8sab10Q6jjH/TSNnGAvwzLaczmR3/ZL0OD6E+qRsAC
         HuyRdmwOHC+qmLnOTgQH1PJ7qwwYBXePRsX6iIRBMAToIUfbkvF2haFCcgJ9oyxLkL2Q
         qJ/x5p3C9E+TfTIqzNn4hlpOGiEhrqzz70zBwRu1JEfZd06vnXp1vroz/uJYTJXnSGj7
         KAfQ==
X-Gm-Message-State: AOJu0YyhzhXxQRV1OvIweREXOPCJ2cStOXObCDrthyJBLkPJ6fUhO6cX
	r12RH4fgJ830bV3WNXW7NtN8Cx0mjC2O9lKFiW3p8zkNVUnCFbFuBvq4hJophCQ=
X-Google-Smtp-Source: AGHT+IGiztgrcSNL81j59fnaoJJkGT+BbuFUTxiiXBC/V1bmXz1a6xzgEEz/U/UX0uhqc/tpOlHFvg==
X-Received: by 2002:adf:fd49:0:b0:336:7793:6ab2 with SMTP id h9-20020adffd49000000b0033677936ab2mr571520wrs.143.1706116439175;
        Wed, 24 Jan 2024 09:13:59 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id m10-20020adffa0a000000b003392172fd60sm13992202wrr.51.2024.01.24.09.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 09:13:58 -0800 (PST)
Message-ID: <64d7811a-61c8-4257-8009-79e023ab3139@linaro.org>
Date: Wed, 24 Jan 2024 18:13:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: remove redundant company
 name
Content-Language: en-US
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 leoyang.li@nxp.com, hvilleneuve@dimonoff.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 andy.shevchenko@gmail.com
References: <20240124164646.1506814-1-hugo@hugovil.com>
 <20240124164646.1506814-2-hugo@hugovil.com>
 <799819b6-6183-4d92-8bf6-93e2e2c1122a@linaro.org>
 <20240124120803.019e8408c5a8de292d9a6a35@hugovil.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240124120803.019e8408c5a8de292d9a6a35@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2024 18:08, Hugo Villeneuve wrote:
> On Wed, 24 Jan 2024 18:00:00 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 24/01/2024 17:46, Hugo Villeneuve wrote:
>>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>
>>> Company name in compatible description appears twice, which is not really
>>> helpful, so remove it from product name.
>>
>> It's just a string. There is no bug, at least you did not describe where
>> the bug is.
> 
> Hi Krzysztof,
> in fact the fix is based on comments you made in a
> review for another board that I submitted:
> 
> https://lore.kernel.org/all/6035c4cc-afe1-456d-a4d0-16992da09a2e@linaro.org/
> 
> ------------------
> Company name appears twice, which is not really helpful. What's the true
> name? Gateway EVK? Then keep only this.

You are mixing arguments. You want to change released compatible based
on style comment. Style comments are reasonable comments for compatibles
while they are patches. Not released commits.

> ----------------- 
> 
>> This has probably little impact on user-space, but there could be such
>> which actually reads compatibles and depends on them. Or bootloader or
>> whatever. Therefore to me such cosmetic change of correct compatible is
>> not worth ABI impact.
> 
> Yes, normally you would be right, but in this specific case, the board
> is a prototype developped by my company and we are still at the
> prototype stage, so there is zero ABI impact.
> 
> Maybe I can add this to the cover letter if you want me to submit a V3.

Any explanation and possible ABI impact should be in commit msg.

Anyway, one patchset per day, so people have chance to respond...

Best regards,
Krzysztof


