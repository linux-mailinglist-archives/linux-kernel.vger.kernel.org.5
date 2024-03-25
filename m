Return-Path: <linux-kernel+bounces-116833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CE388A45B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379092E09BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF8E13B2B0;
	Mon, 25 Mar 2024 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yGfct/ci"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233B131BB2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362471; cv=none; b=pN0pRmjHf3a2tqPX2u+lkAvPMMNBNYXoXhdLrj2OBh9rA/UfmVTxR7pNhkTvw/cuswXyqTlNXUH9vwFWo0pawim5rpQqZ648BmX8DrUW5M606DiiofC9MgrYLmfEmcmZiTWJqEpj0cmkCqmvzIF9Z/bTCu3hKERFySAn8QZFxjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362471; c=relaxed/simple;
	bh=f4fourTNn3Y9VOXW+5bOT8tSE9a8rH8tpaj42qSXsus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBI5N1x2pLQ/bn45DWmjuypqPcAHfiGKRDQC80oxoLgImM04/WqJpSdE3UF0sl5BUsxT4tFHw1MwxO2AQg7MnRGfAmeiMIwjC3oCsXgESzmxpplg98B2BBJNOrZA/IL3O+l85WXc6oIAy4vPFTGxhv+5nOqoLec5UTSq6wuZ06g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yGfct/ci; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a46dd7b4bcbso508640566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711362467; x=1711967267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WyN0/plXDAmtEoHE9Q5NJaUkW+ebBHssQoVcKAW6yzY=;
        b=yGfct/ciatwCjjqpmQzxdusKlbcfGJiZ7b09lG2wZ+iVCfnVZhOoYyibGqk3y5u2JH
         p9on7oaF/ckyI2jIalBZKEwNR2IfEbEksy2U54n7aSrTNJTO9kWe3KHlXNpq/1k8ItUA
         QECKLEJ+gYOndPifOVxDaaAQ9xjdL1Rtn/QTrpysADArggUdUrShGMYSpGlP60u21X6T
         qsc/zb+BnsGYq+9S6D9+rriK+Y4yTlgAF4VPtVebwZ8ubAzj49ro8WsUrx5xMqYzixQ3
         K8mYh8SJqnZt63ihpsIaxTEhlKsd7y60u6VWU7g8hlYJeFpY8p6FfiIUUTAtBRF3L+f2
         uZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362467; x=1711967267;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyN0/plXDAmtEoHE9Q5NJaUkW+ebBHssQoVcKAW6yzY=;
        b=CM1wRXnyujuwMjeNS/yELnTMgmi7/bDJiOcBIp37po7HFiwXdseCG3gZNu/3vS3noo
         39ypn3c/Uc24uqX040TTO/zEsYHnE+0kKghtD4xClizgEFHTMKbFS7sMM61+uy3RE9TC
         zy9s138PC6Au8ZDGuwLN+BBNim9LMPj+8MBuV/ZPv+jMwVHOUMTPzAgG8LE7ENS/NiKT
         NdUCiGVVDtfN2mt+V5IX/l4IT3xwiYxr9kA0BiD+3cEpv1GvcWsKHs5V586xxdjClvS3
         j+ftNu3QgiVSzPc2OH02H4AAQHVEeoI8nl5EUZWnZBoG5VCMbubMDI9aEym+/I0gZ7ZE
         fbfg==
X-Forwarded-Encrypted: i=1; AJvYcCXVohvSlERooDGAjCYSTN+66ku/YqNpH/mHbWnFJaQVV/jNexSAQpvfOgcMnabb8JZGbC5QE5BaJu+nbWogVsNUvsNg/K+vP9/Mn+AA
X-Gm-Message-State: AOJu0YxWTYNCvwppt1kYpRMIS1s7gDdSNE4LzEJmG1d0UOL7EpzuQWUc
	uOWfAFXaSg5sU6zrrGMbKb+pajAh8bA65LiK66qrD/Lid/KJ9rFAJEDs4ipWJ8w=
X-Google-Smtp-Source: AGHT+IGK6ceUlIME9R4/GQMt+7uCDGXiKM/z9j/c9NgAopISUFCGzMjsAmm5gRr3FFpwsf7tVj1BrA==
X-Received: by 2002:a17:907:7e9a:b0:a47:a340:c9c1 with SMTP id qb26-20020a1709077e9a00b00a47a340c9c1mr2736098ejc.27.1711362467565;
        Mon, 25 Mar 2024 03:27:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709066b9400b00a4d95d4a8f7sm58042ejr.5.2024.03.25.03.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 03:27:47 -0700 (PDT)
Message-ID: <49146c33-d698-4e3d-b204-ef567c7b7d38@linaro.org>
Date: Mon, 25 Mar 2024 11:27:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: net: dwmac: Document STM32 property
 st,ext-phyclk
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240325094218.56934-1-christophe.roullier@foss.st.com>
 <20240325094218.56934-3-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240325094218.56934-3-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 10:42, Christophe Roullier wrote:
> The Linux kernel dwmac-stm32 driver currently supports three DT
> properties used to configure whether PHY clock are generated by
> the MAC or supplied to the MAC from the PHY.
> 
> Originally there were two properties, st,eth-clk-sel and
> st,eth-ref-clk-sel, each used to configure MAC clocking in
> different bus mode and for different MAC clock frequency.
> Since it is possible to determine the MAC 'eth-ck' clock
> frequency from the clock subsystem and PHY bus mode from
> the 'phy-mode' property, two disparate DT properties are
> no longer required to configure MAC clocking.
> 
> Linux kernel commit
> 1bb694e20839 ("net: ethernet: stmmac: simplify phy modes management for stm32")

Don't wrap. Word commit must be followed by the commit. Syntax is:
commit deadbeef ("foo
bar").

> introduced a third, unified, property st,ext-phyclk. This property
> covers both use cases of st,eth-clk-sel and st,eth-ref-clk-sel DT
> properties, as well as a new use case for 25 MHz clock generated
> by the MAC.
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


