Return-Path: <linux-kernel+bounces-29115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A472E8308EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F80E2897EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEEE210FF;
	Wed, 17 Jan 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M126Baao"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D921356
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503572; cv=none; b=EPyNsx7dRxGopzaDv+XgfNSof1QhM3vQWAPNNCbBk2KnjPOc8XAXf4ROY46PFRYX9gJpQ50JuSVMMoVQ9BFoq4cNl0JqsfgB6K+OZJbCYUc7qkaHXB4FbO9eYDPkWd9ol3du6bZoU2k/9jd4Y08g5m+8tcCtcIOPgO8ck2RMZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503572; c=relaxed/simple;
	bh=7j81HGmM3UVZuMW1aajgnh/Tqkfv5ZlF1e2arTN11NI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=LktqTKvQZCcqI7KMN68r7RzYrtN2XkXbk6JSyH7MgGeyLkyAwUGg8nElDOvt1dLMWn+r/SLehDD2eDsm7ee8qHYA7xK9sk7E+GkpxN0mhjNnw4BEHavOHEv0M12el5d+Q5KiofX98uc2bjZ51it6lZd29CCuJrTmpp62vqlawOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M126Baao; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e884de7b9so11164535e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705503567; x=1706108367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmOxe8Kt63reb+K83M/fiIpc7ZoymLxbMzD4gGdoAzs=;
        b=M126Baaoif7bxWr9cLsIatT/8b81mBZd4R7H9bNooD8W27aH0LrMDecGWraXMcRqC8
         Ir2XCV3QW5PYHHEZyxbiTeHHcKTbpDjR0+sj4IAcyoWnPfqhEul5vKC2d6GpAHnQPeik
         RfVme+heJWOj5cgrC3fNaO4kOw5O9+CkeB0Mxj6UzWe53WYVKsbVgIpFK/Lw69MGhDC1
         tNDxkChPwapCvqQWBVrKshvO6rOwmxdBjbl9PrPGqABSStMEmZfwIIxmNT/swZBRRHS+
         TuM7NxiyJInuDpgPPQmdz/SB4/Bjqsa4hE+fDa+fYE3Eew0ORyFTxVBaxLpeZ0Fq1T2d
         7UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705503567; x=1706108367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmOxe8Kt63reb+K83M/fiIpc7ZoymLxbMzD4gGdoAzs=;
        b=nt4wvnXZ99ZS9jVdXqQY9B01qXbN3EfSjzMFq/U5S5gfxED0NQS9Dv10jNBwyRhpFs
         GPtiAC7/M5F1e1BzMLQ5K2OpUQWkOIo0Zzgy3MV6Ir9fIi0Hce8oOZhskYeNh1sprb6j
         xO/GCoyyu1tnMYn0zIaz896qFiEDrYVwid32wed+mgyM1SbAOTXlid1LNdDNzgN/l+wE
         cbKqHcj6Zdz+vANTViISQ/hAPpTp1zLmkjgVNLipxfkGRlMwGrUNZ4kG20KFVENBSjy5
         gHIw5xSYjrj/OXycDKhqwZo0h+K9nsEMk9piW5HGIA2xs5RhKBxWz1z07sOxrQmQ5/KV
         63ZQ==
X-Gm-Message-State: AOJu0YyBnAI+7W4ASHBH9bn7Hz1m7vKEyvWuoCuYrRSh3UczAkT+H9Da
	q7M6e4GKzClMYPb0XCQQx1YCchBfpj/iWw==
X-Google-Smtp-Source: AGHT+IGy6qHkEPrF3Ir1FNIzi8E8U7HINl3OXeiajhONjDtBYPNIZN6SHJlqkSjxbgHRxUhaMtMqfg==
X-Received: by 2002:a05:600c:84ca:b0:40e:4e54:3e46 with SMTP id er10-20020a05600c84ca00b0040e4e543e46mr4715735wmb.91.1705503567601;
        Wed, 17 Jan 2024 06:59:27 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id bm19-20020a170906c05300b00a2362c5e3dbsm7856439ejb.151.2024.01.17.06.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 06:59:27 -0800 (PST)
Message-ID: <59a2e142-e970-4792-9233-7c447ac391b2@linaro.org>
Date: Wed, 17 Jan 2024 14:59:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] arm64: dts: exynos: gs101: remove reg-io-width
 from serial
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: peter.griffin@linaro.org, krzysztof.kozlowski+dt@linaro.org,
 gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
 alim.akhtar@samsung.com, jirislaby@kernel.org, s.nawrocki@samsung.com,
 tomasz.figa@gmail.com, cw00.choi@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org, andre.draszik@linaro.org,
 kernel-team@android.com, willmcvicker@google.com
References: <20240109125814.3691033-1-tudor.ambarus@linaro.org>
 <20240109125814.3691033-9-tudor.ambarus@linaro.org>
 <CAPLW+4mUMx9RvFiS0L2U+_Fd_PzcHhmNbyR4cmUrYF3BVgb=Cw@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4mUMx9RvFiS0L2U+_Fd_PzcHhmNbyR4cmUrYF3BVgb=Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/16/24 17:57, Sam Protsenko wrote:
> On Tue, Jan 9, 2024 at 7:00 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>> Remove the reg-io-width property in order to comply with the bindings.
>>
>> The entire bus (PERIC) on which the GS101 serial resides only allows
>> 32-bit register accesses. The reg-io-width dt property is disallowed
>> for the "google,gs101-uart" compatible and instead the iotype is
>> inferred from the compatible.
>>
>> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> 
> Just out of curiosity (I probably missed the relevant discussion
> earlier): what is the actual reason for moving 'reg-io-width' to the
> driver's code as 'iotype'? I mean, what is the actual problem that's

The majority (if not all?) of the hardware blocks in GS101 SoC require
32 bit register access widths. Instead of specifying reg-io-width = 4
everywhere in the device tree, we infer it from the compatibles.

The relevant discussion is here:
https://lore.kernel.org/linux-arm-kernel/db368449-f446-47e8-81b6-a11c2a872306@linaro.org/

Cheers,
ta

> being solved by this -- is it to make the earlycon functional for
> gs101? I'm asking because the bus width looks like a part of HW
> description, which usually belongs to dts, from the design point of
> view. Anyways, that's not a concern, just trying to understand the
> decision.

