Return-Path: <linux-kernel+bounces-102978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A2587B962
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEE21F23C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF9F6AF85;
	Thu, 14 Mar 2024 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h76hchDn"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3756EEC4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405376; cv=none; b=CW9E6Q/r4AOuZJOjXa89ZJ6q/HXyjXuniUqb9bHmgrGA0Hzm4dB5GierBZ81K2Nw/9DEQnqMy4J2t6QHKYgxf5dutBqxcAlQaV40OzTcTDDQNJaubc9ubi9tgxOa4FU7/n7IgUT7L8ZGu/SD+T9bK9KvmDgN3VmY+Ic8iYkjIwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405376; c=relaxed/simple;
	bh=fjbWlaQOikwKMnwZOz8/d8vqFrfC7KHDtintYgjI3K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEAOm/odypT26Fk/jQyWLJJPYadgilyTuIrUQZgypj8yw8nO/vH3umT3FdWA/9Mh1ohjE3BU9MinGcUeD6+Sv1UkiDOYqziNexXqeSStVx4SF0B7cNoBejtkcdPXOWMhOggs/7Oj5PglnT71vQVIo/hv33K3Rt+G5A8fMDAEnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h76hchDn; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5101cd91017so1191164e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710405373; x=1711010173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hj/WaHxD/qNMmrcRTKT2ci5bqw6SYan4groqkVU9P0E=;
        b=h76hchDnBKjjXkxRbAf1ymo1yYHVSGX/vE5MYuYOw/LniQcDQCsHBv5h9OvllF71Yq
         NwsveUquZ3Lz2pJ+58CjYnVtCVsXJSYEJbgbk/DKKR2EEWdbTEteLP2QwXkfyL8CQLmv
         sbXVxkEhyEZsst7mAocG1EI/ziw8bjZQhSF6UKUfZN+x8vOdq4PvD/+xYiOvtnVN5qFG
         VKwdo2i3UmB/dKfeUgwdN95BuQEt00ML0u4WzwcF6wVvJq7MqEXJVG1IAtGMd3EqAwJG
         MdQYvJVMTtNQKUu/PD3flCkCgfbLfJwdW9A/Ze+S/Cfx6IDENUPFLRLLd0edcUQET22G
         6KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710405373; x=1711010173;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hj/WaHxD/qNMmrcRTKT2ci5bqw6SYan4groqkVU9P0E=;
        b=tsSlyferowHAUtk5KYVmrlasoOTdxOgdAvI+KvkcSu+JDcB91mh/qfSL/vcaDACTIW
         2ljibS39WUi+3GLDPEW4dOOXaOqw5ovk21jZ/Zv/2U75ao5mmj234YiZlJA4LPewKFyw
         i9qap4zG3zO0KfKCQtih704WmiOzalv/9JgNccF0KoaSUXRVdt3hDvbeiozjqdnUqdob
         bgcWfl9as4gqU2l6Rlvx5+u3bH21JPPaZQ/dO7z4onag5DauqtSXv3NRk9LwWXMYBCyU
         foEkmkbJ8dDHclYjTqawii3NhSEYqMsAg0yKq5r6AcJ5nuumb0EKeugmImUOnk4lu8Gz
         sxBg==
X-Forwarded-Encrypted: i=1; AJvYcCWIWQeIMZmw+rHGIX++W8cK128XKqvqcRLyMQz9i3qZ6r8VseNns4JigIW52tC0t8qUQH0Up4nrJa0cArd0n5/RfxgO3w4bl2+ziUdG
X-Gm-Message-State: AOJu0YxmzGNSzQGy/IudlDBk2UdYoTggw8z+Ma+nWK9Bl63fuV79LGjt
	cmt6LxT8+yuUzY9mqFK0nCzym50O0bhnp86BVsRkmXyo6ceZ1mvOG8e3cc1T698=
X-Google-Smtp-Source: AGHT+IHg2phWpA6wr0Ec2JY5vMTzDKNCDe3uQE5/b2ulf3w4ZnDGpniqfyMBM8L5ZJNhTuBmWoDrLg==
X-Received: by 2002:a19:ae17:0:b0:513:cd2e:ceb1 with SMTP id f23-20020a19ae17000000b00513cd2eceb1mr619712lfc.48.1710405373003;
        Thu, 14 Mar 2024 01:36:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b00412d4c8b743sm1709942wms.30.2024.03.14.01.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 01:36:12 -0700 (PDT)
Message-ID: <75fd6970-f3a0-4eec-957c-3d8f6a553e0f@linaro.org>
Date: Thu, 14 Mar 2024 09:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
Content-Language: en-US
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
 andriy.shevchenko@linux.intel.com, daniel.lezcano@linaro.org,
 dmitry.baryshkov@linaro.org
Cc: lars@metafoo.de, luca@z3ntu.xyz, marijn.suijten@somainline.org,
 agross@kernel.org, sboyd@kernel.org, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, linus.walleij@linaro.org, quic_subbaram@quicinc.com,
 quic_collinsd@quicinc.com, quic_amelende@quicinc.com,
 quic_kamalw@quicinc.com, kernel@quicinc.com, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
 <20231231171237.3322376-3-quic_jprakash@quicinc.com>
 <3f812ffa-ec33-448e-b72a-ce698618a8c1@linaro.org>
 <13f2b558-a50d-44d3-85de-38e230212732@quicinc.com>
 <f52b2d5e-b2b4-48ae-a6a6-fc00c89662d2@linaro.org>
 <0b9e807d-e0ca-411c-9a2b-3d804bdf168c@quicinc.com>
 <d3dc9a41-4738-4634-9a98-fefcf418f552@linaro.org>
 <1537d42f-fe61-48c2-9ee2-1066db71a19e@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1537d42f-fe61-48c2-9ee2-1066db71a19e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 09:28, Jishnu Prakash wrote:
> 
> followed by updating maxItems back to 1 for all the earlier existing 
> compatibles, using if:then: conditions, like the below example?
> 
>    - if:
>        properties:
>          compatible:
>            contains:
>              const: qcom,spmi-adc5
> 
>      then:
>        properties:
>          reg:
>            maxItems: 1
>          interrupts:
>            maxItems: 1
> 
> 
> If this is acceptable, I'll add ADC5 Gen3 bindings in the same file with 
> changes like the above, else I'll add them in a new file after first 
> creating a common schema file as you suggested.

Please refer to existing files how it is done:
https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L132


Best regards,
Krzysztof


