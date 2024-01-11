Return-Path: <linux-kernel+bounces-23884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6FF82B332
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0D41C22D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5744B50270;
	Thu, 11 Jan 2024 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDz0ocW8"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2C51C26
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-337874b8164so626166f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704991436; x=1705596236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jTNEFYhxC94EAl/ojLdJRih+xoob4znGGot3ahEGPpw=;
        b=xDz0ocW8zL0fRLQa1sIyp/pNbUHSguj1Y8EJrAuN6U6VxHthqqoN5rAI1zSZDB7i/a
         cZ0OIcIMXYt9mGVqIVQF6co7V+hZk9yFfL0sY2oK+207zGp/8zzjm9flpNE/PjhWghfg
         ZF+fD/8hlnEZ5Gvus6FH/gUFU0UmhhFqG2jiz3A3RLcVZxQ9NCyulnsvK88Hm4wComMv
         58CZyvtJebD4qedmBKxdE1gS5445YFMKgQhnrGPSH94Wg/3iySc/UV47WRdFD/QLOdXg
         nEwYPnPNkD+t6PlqOYw+moNgoyU/lyL5qB7tmyce3pMb/TZCq0ax+9dFc6WBUaH0qmJU
         mEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704991436; x=1705596236;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTNEFYhxC94EAl/ojLdJRih+xoob4znGGot3ahEGPpw=;
        b=l1gXcDo4Xuf08ammJqI3AfLqa32r2P07X87pfe8Yq+TlN74190pgbVZ2f8YDKXQ+BH
         eRPp40ooD6DyfaYfpCITMg8PKoRVQNKQXtnFu89tgMZ133gYMuVWF+AVAcQC2rpNlctq
         CgNOLDaex8xA/awtMcZglf5JjnZoMrDBcppE93KYD5vZk7dpDD9a0alSw2f+fpa6sd9I
         sMbUT89EkJSRIScWDrcMrrjZSB5489WkVu2P+SARzlok094tSXBMVJDjQ2cJkxIAxZj7
         fnfyi/wdvWbxhV9P9tYG1a8YjCfN6xjpRQHcjepZAQ/lwJcKzVor+GYUeFIWhQ+Vu70p
         jObQ==
X-Gm-Message-State: AOJu0Yxr0NV69TzIWUpJiqf1vamKp+rxsMsGZOgmcdZCOku2ht4cZeqO
	iAy88cTFEnO6acBF5WeqC7KFLrzTyRmxRg==
X-Google-Smtp-Source: AGHT+IGFJCtPiincHLPIOfqG9ak9tbib0gBnH22W7vfoQpyy6uHDGNXCtIzUf7vnM3ERfazJiU3rvQ==
X-Received: by 2002:a5d:53c3:0:b0:336:5ddc:f474 with SMTP id a3-20020a5d53c3000000b003365ddcf474mr15308wrw.51.1704991436311;
        Thu, 11 Jan 2024 08:43:56 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d4dc6000000b00336a2566aa2sm1606389wru.61.2024.01.11.08.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 08:43:55 -0800 (PST)
Message-ID: <afb2cc4d-efcd-4d99-ac78-a65ffa148c74@linaro.org>
Date: Thu, 11 Jan 2024 17:43:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: dts: qcom: ipq5332: Add MDIO device tree
Content-Language: en-US
To: Jie Luo <quic_luoj@quicinc.com>, Andrew Lunn <andrew@lunn.ch>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com, quic_soni@quicinc.com,
 quic_pavir@quicinc.com, quic_souravp@quicinc.com, quic_linchen@quicinc.com,
 quic_leiwei@quicinc.com
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-4-quic_luoj@quicinc.com>
 <4bc0aff5-8a1c-44a6-89d8-460961a61310@lunn.ch>
 <e893c298-fbfa-4ae4-9b76-72a5030a5530@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e893c298-fbfa-4ae4-9b76-72a5030a5530@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/01/2024 16:59, Jie Luo wrote:
>>> +				mux_1 {
>>> +					pins = "gpio28";
>>> +					function = "mdio1";
>>> +					drive-strength = <8>;
>>> +					bias-pull-up;
>>> +				};
>>
>> I don't know why i'm asking this, because i don't really expect a
>> usable answer. What sort of MUX is this? Should you be using one of
>> the muxes in drivers/net/mdio/mdio-mux-* or something similar?
>>
>>      Andrew
> 
> Sorry for the confusion, the pin nodes are for the MDIO and MDC, these
> PINs are used by the dedicated hardware MDIO block in the SoC. I will 
> update the node name from mux_0 to MDC, mux_1 to MDIO, to make it clear. 
> The driver for this node is drivers/net/mdio/mdio-ipq4019.c, it is not 
> related to the mdio-mux-* code.

NAK. Run dtbs_check tests on your DTS first.

Best regards,
Krzysztof


