Return-Path: <linux-kernel+bounces-122717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B960D88FC00
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC391C2C136
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DF4657D5;
	Thu, 28 Mar 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nv3tEDuf"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1564CF7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619363; cv=none; b=E6I7Mk7d7J9w4GmTq24Ua9iikw2s6a3wqFcz9LPGHQf6i4x1l1W5adts04aqoLlVcUj0Pdsg8QUIOpTtxDz4BXnvx2bY3uJ998Rno7dYMqMGKum5+AbdjaBjrxCNb+4x6Zs8FvzDJuMQxJRONGq/GRfdjkPI7ZQagJ36InKPIag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619363; c=relaxed/simple;
	bh=hzmvgD34ISPJE+AouaRVXOuDSIWXTiOaZypBcAViVmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmFQ5KgfqKh0D8TG/daZpk77oH26N2kWl5Jve9CAoBqJbobL0M7vWZ6UYcXfHe6JCvib6bfPhISx2Mmln/WI46n4H6UKaMzfOS4x0EF9pSp2bvl8HzDVh5wmMym/u5WPRc4FF6qWqLYp6hVffKbJyfjUFHCDZeBl8njfPiHrCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nv3tEDuf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41545616455so2388205e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711619360; x=1712224160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v77UoLBLsIld8XmVs+b2QBRLQe7ErVFpEjJbNjK04qs=;
        b=Nv3tEDufYfzp9xf3ADvUzJRmpowxjuqshWWRaX5MA8/WrDqtT7a5hQ9XffiZR0TOVq
         v6xIbYKml2YNu4cd2hIPcbQ3TOX4s2HdNSMWpUtQQJEKxkt7Syk7DsLdIYbCaG7yvFSa
         ZJNhugVr40AOIOixGAPZMrUeSEmnZzU5mfd5f4uInnBfbEQ/0fa6fr7oKhb5MvrSh8r6
         ewJCt4UXpXtVOZV5XoZBQa7ic5842iX/tgXdagkjz+Rf6LRUF7QuAc6kEsWLt0LO7pOa
         5/NOTqk0aPfvckoy/L014H3oklkO2WGmFMPDMnBo7cPN3tViPRikTHi8XYFu54/HAtLc
         U4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711619360; x=1712224160;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v77UoLBLsIld8XmVs+b2QBRLQe7ErVFpEjJbNjK04qs=;
        b=FyGJXTTm5cXAJfSqu6vf39RICGGPiisNEOkgqdYeJWAcG/ThQp9MN9mWmx5qixwqoe
         jqCr1EDseimj3u6kS0UWFJ1sUVY9ONkcN5kK2SUfYJhyq88UCaN7O6TS9nBoTgtxnxNm
         xDBlvQz5Sl0lYFtgO5g4/ZxOVccNytOz3sOsbM8veprVipJjyMrwBLor3dQJgWR+g8xU
         Q7ReahVSiKa8x9c0R9DvbH5vBsRgTqhQWx9MT8yK7P8Di8q/AYbSz07O1t2Q/sw7LN8K
         g9mjicICncNZVKr4FtcsL5OmvPfjdruBtZeEZ70h1MKEdQdnzghdA8TrtGO9RaobvFLn
         CnNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0L1c/CiTUUozFXFpUgrrLrPigwS1Q+jt3tTvaDWg4fBdfBY4VPfM5UvyWcULBNoUQ0HJtLezSr0zzZxgziRt72KMFgNwGj1Rf/U5G
X-Gm-Message-State: AOJu0YxdgDMmfn17AmKY1+W1MYM06T7VxJ4eh6QGXybhKzyOgvgARx4j
	7pctSjwfqVfcSPgD8mrTfxhTsp0c7b3NwbaY61FmVYlLuys+TPy8iGeQ6FPpSqw=
X-Google-Smtp-Source: AGHT+IF8/V9vViTXm0hMhm+pxnBd3cPTY38qxFZ3M/IzVD0AG9F0j/daJRVYLpqaCWPwXKHSqjP47Q==
X-Received: by 2002:a05:600c:46d1:b0:414:8870:9c1a with SMTP id q17-20020a05600c46d100b0041488709c1amr1344121wmo.7.1711619359773;
        Thu, 28 Mar 2024 02:49:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b00414688af147sm4881034wms.20.2024.03.28.02.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:49:19 -0700 (PDT)
Message-ID: <1a7f1818-2f2c-4e89-b2dd-4ad0f72ae3c2@linaro.org>
Date: Thu, 28 Mar 2024 10:49:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: exynos: gs101: join lines close to 80
 chars
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, peter.griffin@linaro.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com
References: <20240326103620.298298-1-tudor.ambarus@linaro.org>
 <CGME20240326103631epcas5p37bc95c57becdeb63b0d8b01ffc6606fb@epcas5p3.samsung.com>
 <20240326103620.298298-4-tudor.ambarus@linaro.org>
 <001801da7f6e$40545650$c0fd02f0$@samsung.com>
 <454b88d5-885d-4933-ae49-46eaee99d75d@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <454b88d5-885d-4933-ae49-46eaee99d75d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 15:48, Tudor Ambarus wrote:
> 
> 
> On 3/26/24 11:10, Alim Akhtar wrote:
>> Hi Tudor
> 
> Hi, Alim!
>>
>>> -----Original Message-----
>>> From: Tudor Ambarus <tudor.ambarus@linaro.org>
>>> Sent: Tuesday, March 26, 2024 4:06 PM
>>> To: peter.griffin@linaro.org; robh+dt@kernel.org;
>>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org
>>> Cc: alim.akhtar@samsung.com; linux-arm-kernel@lists.infradead.org; linux-
>>> samsung-soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; andre.draszik@linaro.org;
>>> willmcvicker@google.com; kernel-team@android.com; Tudor Ambarus
>>> <tudor.ambarus@linaro.org>
>>> Subject: [PATCH v2 3/4] arm64: dts: exynos: gs101: join lines close to 80
>> chars
>>>
>>> These lines fit 81 characters, which is pretty close to 80.
>>> Join the lines.
>>>
>> Does this breaks checkpatch flow?
> 
> ./scripts/checkpatch --strict does not complain

Because checkpatch does not have limit of 80... Coding style has, but
for readability it is fine to stretch or even break this rule.

Best regards,
Krzysztof


