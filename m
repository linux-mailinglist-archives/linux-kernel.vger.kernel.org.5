Return-Path: <linux-kernel+bounces-52231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21008495B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACFC2862F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BDA125BA;
	Mon,  5 Feb 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2ekU5C4"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED2125B7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123296; cv=none; b=Zp5RDsvYLPeAPvVf44erozIUMUmkvHa2PtfV7MebJEz5jRDVC3UoCpgo5yX20Q6W/mY20YtMSVLEhoUlusRAAvD0dlBH95PM7/KYO8/osWKb6lVDF7Q4aXPgTOSAahdYHq3wxqIVPWu7T+QW5EZeNrmKJbA8RJIHeQBTJaT86uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123296; c=relaxed/simple;
	bh=4mjZKEflzjfJDp1tV5mvq4wAv7jEjogMsAhhw6O6mSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soL1ZQIEL326EQZGUszM4EwQllHHAHK0o7G0z/wd44oU4B8w5GK95N06IfH0CF1JdrUnU7E6eLatIJrrZguswqfwnO/ZnvfU5/deFP+ehw4myF7iWRb/SMrop4XAik4lgaFP57YwOipEztr2Qzm0JnbWNr3OBwionpC+Hn3f/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z2ekU5C4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51147d0abd1so1327263e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 00:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707123292; x=1707728092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hyCyJBMeDHTrCsJV/NW1te8S4+cl2ZosQMbP8dJLG30=;
        b=z2ekU5C4rzsYlpF4o6b2+4TCsNXPxz42BxRQHGlIo+343ZWKUP/9vkdl2wGndrcyxI
         QgocUs7HnAxHH0koc5z33qOx/UM/jy7jgVwxn4NqjxO9gg5jgZZJ5M/mUw5to2jY5DNT
         C9TUX7JtzrkyQs/CmPMVvrNRz1HDiACh09DpEDHIrhPnbtzm5JVsm0jFQhqqPWyui2xm
         wzF5FgpFJDGioaPbPT4FDOlvk9LZt0bp6NdchGmfjA/wwlrAsIO+mfINt1IvzdKgxdiN
         KxNC2ubOoPQ6l5rpo3GARQfxOGnzljSUn4yBU6neh6lUHdDBDVe/450KeweIrEbDO64K
         0VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707123292; x=1707728092;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyCyJBMeDHTrCsJV/NW1te8S4+cl2ZosQMbP8dJLG30=;
        b=AtzRLBfaxS9cXvyL/bebGLlxUKyrNkW/tUz16y5Xw65B8KTiyEGubWpvjA4OQa3cB3
         RDxh4fZPahv+wfmIzgncLjcDcUBariXYIp0qTXDhSjIyyBdz1eXetKC3XBmVBMJS3kyF
         3/gVuB0S6NKqe6cogeskzS5c6TGtIwfDgcZgVEWtPfq91kJaDv7yAnFYf0HK5T67e1M/
         qF0W1Ut6IyyvUU08lmXyiMDtXjtRM0zwF+3rrvlCOXL88X6bbBwbKbFNSR7kQLT4nKqc
         7i27TYmQMCi6wV2bB2tyIjA3bHObwBAvqLtufn2OimpIsoTbO/EqeCilR3KV+I7MRl0N
         ZmoQ==
X-Gm-Message-State: AOJu0Yx84RwzUI9ukJnJ2U+H9RpkWJzY038AQHnR5LTaIJh2nazw32VJ
	3v/bnOqAB34CWj8yK5q9XLtByHP4LxvkYpQMPTE5OutWlIuU+oskdBCbmZANXJQ=
X-Google-Smtp-Source: AGHT+IFqWMLjRI2HSoEtXyjdThINlNK59mMWKxmRSyJ6miMD1AEAWsmsrDq1eyZw+pX8PqU1mDSUKw==
X-Received: by 2002:ac2:494a:0:b0:511:312d:6761 with SMTP id o10-20020ac2494a000000b00511312d6761mr6586912lfi.47.1707123292474;
        Mon, 05 Feb 2024 00:54:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWNIZ4wDz/KkwDlhiEloJFQUm4ivYLe2pXBmNaNxEn1QzhaMPwBB57HX81LjMda94sZbb9FhmitypdWMLU4J/tw/spWKVlrlDJ98AYmoUMTNPKozznnFTnEM6SWqoQxO8Ub33FzSXr0dwAqXGPY+p5to7FN6eIE3xfg+Ev+5oiTnoYzuEjOWBykK2DC8fVSnkV0tPjQCBjzdPmaW2nWmkI2vEtG0prffDCfkLedyMEVFYRrtV6exWOC/JN12nw3xwbVtUNYKKp4qDamTyqllb1164m+GbQ9sG53OJvxmp3Sm8yB5EyxkQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id n3-20020a0565120ac300b005113bbd2db5sm882980lfu.176.2024.02.05.00.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 00:54:52 -0800 (PST)
Message-ID: <abbd450d-8707-4daf-9a31-493c36dbc99c@linaro.org>
Date: Mon, 5 Feb 2024 09:54:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: mfd: syscon: Add ti,j784s4-pcie-ctrl
 compatible
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, afd@ti.com, srk@ti.com
References: <20240204090336.3209063-1-s-vadapalli@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240204090336.3209063-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/02/2024 10:03, Siddharth Vadapalli wrote:
> The PCIE_CTRL registers within the CTRL_MMR space of TI's J784S4 SoC
> are used to configure the link speed, lane count and mode of operation
> of the respective PCIe instance. Add compatible for allowing the PCIe
> driver to obtain a regmap for the PCIE_CTRL register within the System
> Controller device-tree node in order to configure the PCIe instance
> accordingly.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


