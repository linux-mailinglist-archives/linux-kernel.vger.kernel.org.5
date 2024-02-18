Return-Path: <linux-kernel+bounces-70492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F7E859897
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EF01F216E1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ABD6F06C;
	Sun, 18 Feb 2024 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Snso/58g"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53821E87F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708281341; cv=none; b=al6cPUit98ClpNum2JiSprc5aOTKL7D5X81pHyCPmunbM3DBFV6sGDScc4hQ/tpK9s7aaJ9KeIloZPdfR0UN6YDunxxnU2Uv8E71166oUDcJMIb+11X22JlLyj4ZkRWKMvhKDTVLI+WumvIyzN1O/sLQxzVEnmaV9m8+9HPYEGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708281341; c=relaxed/simple;
	bh=IELhMP2AeuGkk3hZA0BPNHxnwCFGw2GFPgU0FluDnk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7LLq4lk7D+hkE8bfXWyT/cbHwavt3q+q68l+UtTu9Iddn/hXoHS+gFLU2BZg1k5StEF1a8v8AxiPFC4ct7oA3qUiPE7Q/VT8YcKGp8C6Bg+mCcDnOAQfEC77FsN7Psr2IV6lCBJKJmnP6nTNLknguUq+41hAxHErJT2El8Emao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Snso/58g; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41263e8b7f8so3143205e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708281338; x=1708886138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HmhsdjiVydbji9/BcSZQ8XMnnQqt5AZTtEIoi8Kez+o=;
        b=Snso/58gwtZ3uqEfEGIWf9bry0jm02h4kDenwQUu6FR3mSiQSk9SwNrR2ZZRk7AQUi
         AQ7CnNowb5FInlDtIJ0s2o5DbRJqiOs16ZVSXbSMJHSJHXvxfVlC5LacriiCVR2YLXZ+
         Si1uEDMxW0tI6yX7rxbuaXXdPW1O819f4NprROqx1G9m44byg2awZUJMhorMrKudEGlI
         XVdLTBEPwWN+bFMXudbeO8Z9Il9ltCQQMt9vLgokdTR+v9rybIjon4WI1rPXzuGVeYYl
         I5/M5tAHzij5He2ZnFHSYnp4eeAtRPRqUXkgpJoKeAerxnlZi/nwrHbaNYxqPgLYao6a
         NtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708281338; x=1708886138;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmhsdjiVydbji9/BcSZQ8XMnnQqt5AZTtEIoi8Kez+o=;
        b=ERHd1CVWWPKI1USWfIRhcBAX8+gckbT0QFq6BiH/bdol9XIomNfk4A0VVzTAJigFuO
         gg0fC0j+VLSWFqeG5q+B4ua+gNzVf+C8E1jvBjavdpco/SBCEH80mW+ToBdyYpra7DHB
         cOaG6cwM7lu9Jv7E500RFoHZ++1qSp9htQ3Pq70KdBPeHj89UyTUmGmPPfYvmNcdjVMD
         UgWwBGuXvQkUmhMDihLqoHI33QPp02LK8eduHaPev03Vo+8GiG+wgT9Mlncpi+DqhnYW
         myaZwQYXEXrLzYTWZK/oUePrA9dHcle4QC2hqXh7+GhU4gytSedF5ToIzQ1gTke7sWLQ
         zB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuUI9CV43mt5xyOXbtH6StfT2Kfw+xtJT/N0KaOyW+wp4Q7QQoo2DigYe5qGPqfYB8oUmBwTLfkKevcUE6hLafLXsovPBCJEBKxJVD
X-Gm-Message-State: AOJu0Yy7837Mh5v4DfjRNxdOgzQAtnHo7holagdm295T7SiX9ZDoAkVr
	NLXA6Czh1sF5jJ578JRBXjZ3Bgjz6rJHcNTokg/NrQALqHxHtxiuvidANKNT1A27KwRHaT683rD
	TXaQ=
X-Google-Smtp-Source: AGHT+IEr8LrLo8rnwBtfp9cUd9o7aqVTJAIclLAIh7GyvHzXVGv0w8CZXc+tD91eJhchPQAPLNQW7w==
X-Received: by 2002:a05:600c:3502:b0:412:aec:2cfa with SMTP id h2-20020a05600c350200b004120aec2cfamr8677926wmq.1.1708281338234;
        Sun, 18 Feb 2024 10:35:38 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0041256ab5becsm5990592wms.26.2024.02.18.10.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 10:35:37 -0800 (PST)
Message-ID: <6ac4005b-01e6-48c2-971e-d6a127134d13@linaro.org>
Date: Sun, 18 Feb 2024 19:35:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] dt-bindings: cache: Document the
 sifive,perfmon-counters property
To: Samuel Holland <samuel.holland@sifive.com>, Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Eric Lin <eric.lin@sifive.com>, Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240216000837.1868917-1-samuel.holland@sifive.com>
 <20240216000837.1868917-2-samuel.holland@sifive.com>
 <eeb2331d-10e6-4902-91ba-85896a8f0ee1@linaro.org>
 <72221da1-4a1a-4947-a202-9de203032f5c@sifive.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <72221da1-4a1a-4947-a202-9de203032f5c@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2024 16:29, Samuel Holland wrote:
> Hi Krzysztof,
> 
> On 2024-02-17 3:00 AM, Krzysztof Kozlowski wrote:
>> On 16/02/2024 01:08, Samuel Holland wrote:
>>> The SiFive Composable Cache controller contains an optional PMU with a
>>> configurable number of event counters. Document a property which
>>
>> Configurable in what context? By chip designers or by OS? Why this
>> cannot be deduced from the compatible?
> 
> This parameter is configurable by the chip designers.
> 
> The information certainly can be deduced from the SoC-specific compatible
> string, but doing so makes the driver only work on that specific list of SoCs.

Usually that's exactly what's expected, so why here usual approach is wrong?

> When provided via a property, the driver can work without changes on any SoC
> that uses this IP block. (None of the SoCs currently listed in the binding

Sorry, properties are not a work-around for missing compatibles.

> contain a PMU, so there is no backward compatibility concern with adding the new
> property.)
> 
> My understanding of the purpose of the SoC-specific compatible string is to
> handle eventualities (silicon bugs, integration quirks, etc.), not to
> intentionally limit the driver to a narrow list of hardware.

Depends what is the hardware. For most of licensed blocks, the final
design is the hardware so equals to its compatible.

Best regards,
Krzysztof


