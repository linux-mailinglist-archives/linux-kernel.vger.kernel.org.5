Return-Path: <linux-kernel+bounces-82762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5752D868930
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2167284B43
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1DA535B8;
	Tue, 27 Feb 2024 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDsSTZ1H"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3010D52F98
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016678; cv=none; b=V4ztTXeDGgDJmteytK2c9GVMbP7eMI846Y9b8P3F3qwhe15pkiFIH8gTEZO4wAmqVSrqR7cibZjidmBtsxZy6tR5xRoueVAiFE/yIGiQ8MGMUcBioi+2AYXrfJ2hNOWi3JmzJULPxJ8QF6xXpK9GRN7V+cNUTSPvAve5EhcrgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016678; c=relaxed/simple;
	bh=kMm0MhaI2hrFFVsLzwvLF6qO1EAC/UVvmQ2fD2bFDAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dI+mf1LL2+gjnW5yaKl42LQxlzXkek3MxhttEpmjwg/R3A2JwIQAEPpNrEM6SmKvRJJJ2nmvf2MlmkWQtdGbW9iWSOWMsde5PgB+0ejSJa0HIn18N1Ha28bY/ipsFGO2rUBqguigVSneJCdFNRbeohAgCEOONhPr2EmJLxvZJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oDsSTZ1H; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3e5d82ad86so540691066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709016675; x=1709621475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KyzYi/oCIq0JMIl4Zm7WvnQjiUgOFPhkkdhV4XV1/bY=;
        b=oDsSTZ1HKhB9DxGPQTeDuqXqUB0aFjWi60RN7KSTAJLs9EDSwzurTDi0Tw02tenrSr
         w4jGjgQdp96wlvI0vlkbUOrnv3PrRZ6NKnGh6x3vo7YuTLLo0/RHy7MxLEBczuJpub6Q
         atleOoABi9wnqIY5pbSre7QV9xNiNMx9BLR5mbFXhExnO7L0p4S1PPZMc/soYMpgZuHT
         wL/5dRRe948gbxTXPafKe6oE27xOuScPFBd9kRN8RU+FJy47QKqxYvEfGgx2+Bu8YuDo
         htoraWos+yWriPA+nbMQ6pPu64rQo3457+B4OVWtQq4GN99dGP/RIeHns1JpbNQRzayE
         XVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709016675; x=1709621475;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyzYi/oCIq0JMIl4Zm7WvnQjiUgOFPhkkdhV4XV1/bY=;
        b=RbW3ihcTuVaCDD7yKE2ztEVV57/5gNKi52RH7URbrXh7CH4dm3+DyyMcAqNrpoObl4
         sKC2bQz/YVqMusMMop/kKh/NWGH4Qph7DA1zg6J8kxcop4am3I0TIotRef0l1gXVDsqN
         gA5XwQA0cn9Riibh85lsmOstfynWO3UUKHkmQUOrdN1RE1F88HAIyUbYV1Mgb5HcEnPm
         qEqyoMlAIlTmMb/NKtw4i9gIpwrOvoH7Nz4nk2VPjRjvTnLBEgVJLl8txUpEoBHCsGKC
         oMW3rN6SAKXoUyRiGPqIw+u8cixxJYadtsYUAJkxnfdsQrMQXAAUBvsNXKuEDqvs3vK/
         Gwgg==
X-Forwarded-Encrypted: i=1; AJvYcCUlDoKgje3KRjeglr8rjllitocb/T/KExQnpuyYp8sLOkMXFlsO2SocMfJWEmIOHjGnJP+ZaHpLwVTy31osO6ROz5SOUdpljRC/hiMO
X-Gm-Message-State: AOJu0YwYzPx+o7MCwQ4hVCHMkZE42/ZGqJ9WSNJ+N1NYFM0jfa3hNf1N
	QT7yEQo/GjG+1k9IE2t9K2a9tt2ymoL/7mCK3cO8W9sVPOmaLGRVwh2xtxjeCcs=
X-Google-Smtp-Source: AGHT+IEyY0uo9sxm3c77EHMIMldafeOPLJD2VjS8oEye05bD2H7dpe+TuMi9MuCDSKsXFoJEhRus7A==
X-Received: by 2002:a17:906:528d:b0:a3f:4b56:b9bc with SMTP id c13-20020a170906528d00b00a3f4b56b9bcmr6779201ejm.47.1709016675374;
        Mon, 26 Feb 2024 22:51:15 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id k7-20020a17090627c700b00a3f81200425sm448734ejc.122.2024.02.26.22.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 22:51:14 -0800 (PST)
Message-ID: <2e277281-0c28-4159-8c32-4e96254339c3@linaro.org>
Date: Tue, 27 Feb 2024 07:51:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/6] dt-bindings: net: remove outdated
 hisilicon-femac
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240222-net-v4-0-eea68f93f090@outlook.com>
 <20240222-net-v4-3-eea68f93f090@outlook.com>
 <c3f3d276-46a5-4cc7-ab79-e1ca3262abdf@linaro.org>
 <SEZPR06MB695901BB60F786D7E209EAAC96592@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB695901BB60F786D7E209EAAC96592@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/2024 02:43, Yang Xiwen wrote:
> On 2/26/2024 3:50 PM, Krzysztof Kozlowski wrote:
>> On 22/02/2024 13:43, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> The user documented(Hi3516) is not found in current kernel anymore. And
>>> it seems this SoC has been EOL for a long time. While at it, Remove this
>>> binding entirely due to recent driver changes.
>>
>> This removes documented compatibles, which:
>> 1. should cause checkpatch issues,
>> 2. is not what we want.
>>
>> Driver is still there, so first the driver would have to be removed...
>> but then why do you add it immediately back? No, it does not work like that.
> 
> I has downloaded TRM for this old Hi3519 SoC. So i think with the new
> driver, it still works for Hi3519 FEMAC controller. So i'll rewrite
> these 3 patches and describe the whole thing in commit logs. i.e. the
> old binding is wrong, inconsistent with real hardware, etc..
> 
> So you mean conversion to YAML first, in a separate commit. And then do
> necessary edition to match the real hardware? I believe Hi3519 FEMAC and
> Hi3798MV200 FEMAC are compatible in hardware. So the old binding is
> wrong, missing critical hardware resources.

If you remove binding, then it has to be done in reverse order than
adding it (see DT submitting patches). However removing binding and
re-adding it, is not what you think. It's a obfuscated way to make a
change, so better just make a change and explicitly say why and what is
happening

Best regards,
Krzysztof


