Return-Path: <linux-kernel+bounces-3306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C85F816AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70AF1C20D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F7B134DF;
	Mon, 18 Dec 2023 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDf4xGxk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CAA13ADC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a23350cd51cso138802066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702894430; x=1703499230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkvb6qP7X/Y/nyw6mkT/Y/MAz8ekqvjhiXskkaWC72Q=;
        b=qDf4xGxktHrs1A9OodOLxqYFM3Qxllk3+fYd1jpi01TKxyp6JmMT0wnOBoZAqDESp1
         mtxaa2IJUuDmrB4spuYdzlZIrdRczHWApIC52Ztk02557NxdVNcEN9hiMqbBnbow1bte
         CT5ppk4ffG66bRs2KzNSYWhxDREBx4h3uxY81ijnWYkXQNdU8dVYMRU+2bGvcDyJH+sq
         Ex7I1WUPRERD8M9qHd/Ck328a5x3AT2yz3/8x67JL7Z5PTPZl0Oe2xnbhjXNi0dgxGbF
         oBpDkU8hyXTvGwe77YKFBv/fB0jjtV8k17RGATy0PjJl289Jfu8lqP+8NfWKVuw8FVNr
         KmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894430; x=1703499230;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkvb6qP7X/Y/nyw6mkT/Y/MAz8ekqvjhiXskkaWC72Q=;
        b=O2t2RQUoXKOtA1SsPOJHvYGZ3LjVVky2NKNtzX3ZgDHDMugMLWbU0a08ZY3MTduIJt
         /eGGboeisVYC4xSbaMu3pczj+58guvhUQOFUz7lZap9njznYG0Phu0mWe5mQT0NGMK01
         vFl7v/bK8tNmSyMRWGRTpGlMLhZhJ+S1Yl1vP4otHOcFhPBg8W+lLxazsEs8yl6o0y79
         OV7tZVO95CzDX1BdTBnSTYmjbccEJNQN+LZzSB6WfdU+dO7JVXoaMuLEsOvDfWML3WG7
         23ZEgd+/AZqPMEgyDuFQe969Djtp2V51YlRCfnLz8btfYvrZRtWy9AZ8Z9jL/A2iRSCf
         Pmmg==
X-Gm-Message-State: AOJu0YwYvtUxybLokUQfWYW5R3cZn4r8Tw5rvxDxyCzpE36jffz+Cr3L
	/PanHsc/kQfZnqDRrstWRwTcZg==
X-Google-Smtp-Source: AGHT+IGluLwuGFhWFlzxn0oui7jNoKoD8+0w4l6m/j8/1BPKX4p1hTpSsFbMvCNvKw9XOR+94CAARQ==
X-Received: by 2002:a17:907:9686:b0:a18:92db:282b with SMTP id hd6-20020a170907968600b00a1892db282bmr9799272ejc.39.1702894429800;
        Mon, 18 Dec 2023 02:13:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id uz26-20020a170907119a00b00a234b686f93sm1566486ejb.187.2023.12.18.02.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:13:49 -0800 (PST)
Message-ID: <c1d4f636-d068-48e0-9013-b5a586fff99f@linaro.org>
Date: Mon, 18 Dec 2023 11:13:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: sm8550: remove
 address/size-cells from mdss_dsi1
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20231207092801.7506-1-quic_tengfan@quicinc.com>
 <20231207092801.7506-4-quic_tengfan@quicinc.com>
 <9cf61b7b-199a-4535-a701-10851959b940@linaro.org>
 <e00b2c5a-cd79-40ed-b78b-0aa8c5b33fa0@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e00b2c5a-cd79-40ed-b78b-0aa8c5b33fa0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/12/2023 10:59, Tengfei Fan wrote:
> 
> 
> 在 12/11/2023 6:25 PM, Krzysztof Kozlowski 写道:
>> On 07/12/2023 10:27, Tengfei Fan wrote:
>>> Address/size-cells will cause dtbs check warning, because mdss_dsi1 node
>>> have not ranges and child also have not reg, so remove address/size-cells.
>>
>> Paste the excerpt of warning.
> Sure, I will paste the excerpt of warning.
>>
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>
>> I am not sure if this is correct. The address/size cells are there for
>> panels. We have multiple of such warnings, so I would like to have here
>> consensus for all of them.
> Currently these address/size cells lead to dtc W=1 warning, so these 

I know.

> should be dropped. 

Why? They are correct.

> These can be re-added if needed at a later date.

Added where? These are rather properties of SoC.

This does not solve any of my concerns.

Best regards,
Krzysztof


