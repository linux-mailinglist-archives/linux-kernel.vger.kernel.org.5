Return-Path: <linux-kernel+bounces-122017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889FF88F0D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCD21C2731A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C1153509;
	Wed, 27 Mar 2024 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXlcGQOX"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A74F208
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574561; cv=none; b=irws219bvje6DsqNTR9M15x5yCqlpyJyuQGEwr3r8ewT1IwvgMuGxhau1D9iBugrbnADxImuXw9KoQQSAdyBLXindkATDrnphanixtDA66WlgTHXdkhMQ5JYNVUpyD8CpRb0veih4KOKvV9aOi9nYF7fZ5yVccobz9iCfBWNnl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574561; c=relaxed/simple;
	bh=zwXZFcizE/oIpPUenN3sh8/KZC9xUh/LaMK+UNjBwWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcH1MVgiC6bVNr2or7Sq+w59OikVUCdmTeokAv4tliAkGJ7WULHnqMOnW0iFCTrT4FiqCeoEaDCzVhoIo2Oes9DS+W9ChClSCA7Qq6+Z8iqzKEPIunC1S/OUESrtZUATtVspupXEqxp7/WQKGyR8eM63SPHBxS+IQ6n5mB6uZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cXlcGQOX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513e14b2bd9so241334e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711574558; x=1712179358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oALEYX4wCloumYcO5F1iTn4rufRV5N52BfWH35gQd8Q=;
        b=cXlcGQOXOU7MVYsKaw5Vlbyn92Nfr6JHmueNUy5ed3JG762LMPvjM83Q6w+glKW6TO
         t9omOW/aTUyfZt9D8z8SndbxJ9DeFhIm52+B1l0fKV6jzGUL4RULiVxIm/8BONpFC+7G
         vnJeGt+qX6SnqAcqNhleSTKVsB6zhQ1TztdE+Obr3hD9Y8HqZ1Eqexu0FWW36bmTCmDz
         ZhmotG1iT3/xa+8Tuxjooj1oXxtRX4pgWM5tuSrW+exk8ROEjEX+cCgfEixySc7kBCWl
         1wfGHCYaddeTvKocxs17rk6MHdP7IGzDcnFpqeutBBH6lxWxlLJKfOgbqeJkX0cPijU/
         eE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711574558; x=1712179358;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oALEYX4wCloumYcO5F1iTn4rufRV5N52BfWH35gQd8Q=;
        b=GRuikV5eOKBZFCLRO3a/1zAm+hz8N10ZC2euVmDXKnIAxIskIimDODifHzmOYaBTx2
         LJz1HgjUIhCo00ocG7S0lEplmwQkr+OIK42khiSZRw19h+JLdOill8liRrQJk+cP+78l
         7IMh4/gik7aqrBS5N0FE0TVe0uZUIv4/Bz0NrGnTrkEHIRtoUswe2du2xsj0MHhtETEz
         u+m/vJmMfdL6lztPbPjW6UwNiCgGGoFACKwHSpsYLRHmQkabb3YLpGEucJFB6GylwaYp
         dluhqt2/8I+S52rekh3PfLn2p8D4a3bnKyH7bZ2/mYTiptNPx21dgIH02GrbaIjIW1BU
         Do8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyCk/Nhc3/7UQ3JmSnp/zRy2OlyYoUVrsB+sOb7bf0AVr2t+d4e02SURE14vnELBUCYaWY17A4GufGY95wa8ag9OqWQZy/A0SPOm+N
X-Gm-Message-State: AOJu0Yzb6sDLkVWbl3r8AjMYnX8g9H+w5l64dbZnYZdVfbj2l/BbCJmP
	mweSlbncoKh6923GdQbGGEyZzIN3HQZGvzhilSNoYQGnX8i3EmEXXDipnpPSUDE=
X-Google-Smtp-Source: AGHT+IGgeMEwtinQEW49E32+z5iIKlqj9TXhI5lxYCeye/JWxAG+NNeaLWLiRirjjwew7ciIrnLaLQ==
X-Received: by 2002:ac2:5a0f:0:b0:512:f6a0:1311 with SMTP id q15-20020ac25a0f000000b00512f6a01311mr452086lfn.47.1711574558059;
        Wed, 27 Mar 2024 14:22:38 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id jz7-20020a17090775e700b00a4576dd5a8csm5833405ejc.201.2024.03.27.14.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 14:22:37 -0700 (PDT)
Message-ID: <b8217de2-3276-4d98-ab17-f36058c633ca@linaro.org>
Date: Wed, 27 Mar 2024 22:22:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] clk: qcom: Add Display Clock Controller driver for
 SM7150
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 david@mainlining.org, adrian@travitia.xyz
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240321202814.59835-1-danila@jiaxyga.com>
 <20240321202814.59835-4-danila@jiaxyga.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240321202814.59835-4-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.03.2024 9:28 PM, Danila Tikhonov wrote:
> Add support for the display clock controller found on SM7150.
> 
> Co-developed-by: David Wronek <david@mainlining.org>
> Signed-off-by: David Wronek <david@mainlining.org>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---

Please drop CLK_GET_RATE_NOCACHE as it should not be necessary
(the rate of the clocks in question should not change without the
clock framework's knowledge)

I think it looks good otherwise

Konrad

