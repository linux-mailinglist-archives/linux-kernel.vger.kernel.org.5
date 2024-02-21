Return-Path: <linux-kernel+bounces-74582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0468E85D657
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A3B1F23930
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A243E497;
	Wed, 21 Feb 2024 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9r7C64o"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2CC3E494
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513288; cv=none; b=EjjhpzLyE7gsA2O4Py8DHXABoVOr6nN5tKHBS/M4g4pKxUJz4z0kEpwzjzNsRuNToD8fo4vs4EgEYnqIxAwcIaNBaDtM5XXRcZ+bYaIrP1j0fgcefkz0cwOj9XbOA5fnHu6R7w4LJh2VxJxa8waAiTXINlwjt0ukyRooHf1Cod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513288; c=relaxed/simple;
	bh=8Pqi2OvYHkdbbzOZoaZOwv6BUpCoATH4Y3bMmVwaWIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBKPLdDcH3r5/+JUeQw+VbKqwPv6PsgSGUo4BmAUyw6tqytGFEd3EkD56ugd44PVDk1DZ81nzy5FjO8Li0DQwBN3xqmDrGDGRvKOZ7OE/ZAzmAnQIOrx9BE0lgVW130xoaJSmd8GEvb8iQQ3Y2N7a49wW8LPfmEr/6f4o3y+lMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l9r7C64o; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so5430487a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708513285; x=1709118085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m2pkJbBBVU7OxhHun8X03GydiaahosMvy5Ph96bySx0=;
        b=l9r7C64ol2749jhgkmYYmYtTU3G0tOsl3Qfxkb1vaerB+bCdb9kZFUwkjWxkAM7L4i
         jSwJ7bcw8pvkhR0e7fqV8AzGgCrxi61OnWCnPI9ObEeMIYLe2vKdlyZy8g5TZcZy+ExT
         45o6xzbYNWFCfG6CFD/tBsn+L1tBQ1Ba2bTb0M3VwE5fjqo8LgAX0AqwgqlbWSlCF5Xm
         4dy8EcceStsIOG4sa4dNqqx7UoeCMWkhHThNKbyb3qyrBYP500Qr7WH3cQ8Fx+8/q643
         7rwvoF3R3jTMeFOrA7NQ4tbdjesBxjEdlyJeHEWOd1MGrk4QDyIFvhhpjrV1XmcnGbJh
         kqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513285; x=1709118085;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2pkJbBBVU7OxhHun8X03GydiaahosMvy5Ph96bySx0=;
        b=ju4ouzKAgvYVeyvlBU4lvxEimWdiPpiOwWUvHRmEKA2tZ3uJC/eBRefxj2j+4sSUhc
         s8nD2eLlCzqNo5rrRMa6gwosdll+lxQN2c4PL+aqRAoMwhAqPLrEFsDI9Nf7Iz8WAric
         L+MFOujAm4WfQJnmtcRhsALOKve1su+kaezQGEJZggd+jb3mNtYCbq2uzlC70rrl4C+0
         ov7vzwDj8lWo2pbgbZpgn/iFQeceR4Kh7+MpSJ5mqJf/G4e0EiBuI8EkUreN368WRaFI
         DP+bsr9uHZ/ZwnCJkMGxjcZAbkwTRQSyEvoMjaco0gWoiht9OJ0RDe/z3Y7xVU097Nt5
         dx1A==
X-Forwarded-Encrypted: i=1; AJvYcCV+wFRF4M4Hvf2prWSRn9HyulnaOD9wLJlc00skU7bz/pBVfRROXuyD1YQQcBmwzBWpRJByZDWMxX8n3j2Jvu+71IAreIgBMQsFVoLW
X-Gm-Message-State: AOJu0Yzz+dAkZw7xPaN6B2JdJLLRpYFLPoBarAEf/y10mCA5KEu1KkTy
	5jcqE3rzT20FsAasu11/EJ03dyh6CbezahSbT5Sn+007Cyo5b4bVSwP6inB52L4=
X-Google-Smtp-Source: AGHT+IGKFQfxxh8f92W176IqOsPZLnlvo1236gn/NcK4osUoufn8tePgwwNQB8Vjdhu3+BPGeKco8w==
X-Received: by 2002:a05:6402:e8d:b0:561:ea0:e234 with SMTP id h13-20020a0564020e8d00b005610ea0e234mr20258262eda.16.1708513285522;
        Wed, 21 Feb 2024 03:01:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id i23-20020a05640200d700b005648745b23bsm2429714edu.90.2024.02.21.03.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 03:01:25 -0800 (PST)
Message-ID: <d9a49d77-32b1-45d1-b110-5e66155abad3@linaro.org>
Date: Wed, 21 Feb 2024 12:01:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add QPIC SPI NAND driver
Content-Language: en-US
To: Md Sadre Alam <quic_mdalam@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, quic_srichara@quicinc.com,
 quic_varada@quicinc.com
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240219130412.GC3281@thinkpad>
 <3ad2909d-4ac3-fff3-739d-b12a3408fa0f@quicinc.com>
 <454a7e8d-70f5-4bf5-a3f1-bf9e42672c4c@linaro.org>
 <bfa0edb7-02fd-42dd-2235-0ea34f362515@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <bfa0edb7-02fd-42dd-2235-0ea34f362515@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 11:34, Md Sadre Alam wrote:
> 
> 
> On 2/20/2024 5:06 PM, Krzysztof Kozlowski wrote:
>> On 20/02/2024 12:32, Md Sadre Alam wrote:
>>>
>>>
>>> On 2/19/2024 6:34 PM, Manivannan Sadhasivam wrote:
>>>> On Thu, Feb 15, 2024 at 07:18:51PM +0530, Md Sadre Alam wrote:
>>>>> This series of patches will add initial supports
>>>>> for QPIC SPI NAND driver.
>>>>>
>>>>> Currently this driver support following commands
>>>>>
>>>>> -- RESET
>>>>> -- READ ID
>>>>> -- BLOCK ERASE
>>>>> -- PAGE READ
>>>>> -- PAGE WRITE
>>>>> -- GET FEATURE
>>>>> -- SET FEATURE
>>>>> -- BAD BLOCK CHECK
>>>>>
>>>>> This driver has been tested with dd command with read/write page
>>>>> with multiple file size 1MiB, 10MiB,40MiB etc.
>>>>> Also tested with "mtd" command like mtd erase, mtd write, mtd verify etc.
>>>>>
>>>>
>>>> This is not the first version isn't it? Where is the changelog describing what
>>>> has changed since then?
>>>
>>>     The earlier patch was the RFC for design review only.
>>
>> RFC is state of patch, not version. This is v2 then.
>>
>> These RFC postings are really becoming mess. Some people make multiple
>> RFCs and then post v1 hiding entire previous history... And why even
>> bother with calling it RFC?
> 
>   Sorry, I was not aware of this. Shall I post the next one as V3
>   and add references to the RFC patch and this patch in the cover
>   letter of V3?

Yes, like with every posting.

Best regards,
Krzysztof


