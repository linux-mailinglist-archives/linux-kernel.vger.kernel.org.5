Return-Path: <linux-kernel+bounces-6898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A930819F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114A5284625
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB16E24A00;
	Wed, 20 Dec 2023 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L33mAer/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B253E24B34
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2698eae0a9so43877666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703075676; x=1703680476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BC20f4XutzLFfpBlBZPN2cj1EyfzNMVi6SKb89pUAMs=;
        b=L33mAer/gJZ6xWEYOaCWyeB3VBCBFbKo+DoBTuKCU6M8y8JNOTH4sc9lTzE3TlEZnt
         k7LgEgom9Zgf4pPPz112m/inPQwMP5vIVRoLvmVYe5dOmSW0nD1cR6BxJ8Szm6MyEQ1A
         fx5h/Pz2Cdplj6zxVSN+v142xHTOrZcZpebCCztIXjjC9XKnpAwiOxtJ7W1iuys6CRqX
         +LRCTM8JALKnlMhuIa9XCZUxrEflc0zn8SLMw0Hnu/+hiiLYxH3IOfE1QJLW0RoXcalX
         3vDRDWANdU4ucDTLF2tAUrpN47GmfpVxDXLilHcRSDqNUYkk6w3QnP7sowsqnYtx3CJ4
         q6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703075676; x=1703680476;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BC20f4XutzLFfpBlBZPN2cj1EyfzNMVi6SKb89pUAMs=;
        b=oWGpZ78YYNWvqQAEmcW1GS+yi0po0PIlB1D43JOToO0NhIpuYRy+21/y4CmXUnTYjV
         15PyY5pQjWDhrgP0c47LwuE9cghd0bOMz5Wi8esV7YszMrKjw3hS51kZkodhhRAX81cl
         5kaky7x6ecLbmx0EFXx6bhPMDrcFLVgaGcyDRzRK7ttsD0Skq2USceGmhcQ8v3B3cGu5
         5l3UgTA6MoyzOIVQ31Pv7wwueL47NW5MEqN+3YMKIny1qKGSAEgwKJun8N5Ld8Ze8b5B
         9eWTRApK8C+yA46q5LMUU5C4dW3e3H5NbGTLKSUDMLjKZx6fzbBLfplrkUIkem80kPow
         sl2g==
X-Gm-Message-State: AOJu0YyptEwnVLAwqb0sgl1Hxgo6EM93k3nBrfpK1odmG6bsNEZ2GFjZ
	UCAxnt9TwwWGQUDVqnlRWyaE5g==
X-Google-Smtp-Source: AGHT+IHfLA0M9+7B/B79vaXWFhdnJgnAtZr90vLKDClciPf9jJT12Xwyn0FDdgw3+Dl0MFf73BejpQ==
X-Received: by 2002:a17:906:3289:b0:a1a:57f4:e5a4 with SMTP id 9-20020a170906328900b00a1a57f4e5a4mr10680260ejw.140.1703075675982;
        Wed, 20 Dec 2023 04:34:35 -0800 (PST)
Received: from [192.168.199.59] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id lv16-20020a170906bc9000b00a23540a14c8sm3959949ejb.29.2023.12.20.04.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 04:34:35 -0800 (PST)
Message-ID: <cfe3ee21-e1c7-4e54-b544-43cdc8d64bfa@linaro.org>
Date: Wed, 20 Dec 2023 13:34:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add MSM8909 interconnect
 provider driver
Content-Language: en-US
To: Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
 Georgi Djakov <djakov@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Adam Skladowski <a39.skl@gmail.com>
References: <20231220-icc-msm8909-v2-0-3b68bbed2891@kernkonzept.com>
 <20231220-icc-msm8909-v2-2-3b68bbed2891@kernkonzept.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231220-icc-msm8909-v2-2-3b68bbed2891@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.12.2023 11:38, Stephan Gerhold wrote:
> From: Adam Skladowski <a39.skl@gmail.com>
> 
> Add driver for interconnect busses found in MSM8909 based platforms.
> The topology consists of three NoCs that are partially controlled by
> a RPM processor.
> 
> In the downstream/vendor kernel from Qualcomm there is an additional
> "mm-snoc". However, it actually ends up using the same RPM "snoc_clk"
> as the normal "snoc". It looks like this is actually the same NoC
> in hardware and the "mm-snoc" was only defined to assign a different
> "qcom,util-fact" to increase bandwidth requests by a static margin.
> In mainline we can represent this by assigning the equivalent "ab_coeff"
> to all the nodes that are part of "mm-snoc" downstream.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> [Stephan: Drop separate mm-snoc that exists downstream since it's
>  actually the same NoC as SNoC in hardware, add qos_offset for BIMC,
>  add ab_coeff for mm-snoc nodes and BIMC]
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
The hard work we put into fixing up smd rpm icc paid off.. thanks!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

