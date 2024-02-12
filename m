Return-Path: <linux-kernel+bounces-61398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6188511DD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA7C1C215AA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062C3987A;
	Mon, 12 Feb 2024 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktP7c8sV"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D438FBE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736148; cv=none; b=RO3KJSQiJ4r6wCCwN49t1/QKOGiCZ7Vg3m3TAKMRbkX13jQnPqSKf/6Xu5OMoYEY/KoI76OkbPnjloV2HbIQdcuQ0eD+JqqBzkjDOdAlaC025PyXQgOmFfk73fuV9Urg48MR/ftSn80adu+lhAMBm1siDsv+Rn7Pt6y2GUcoNZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736148; c=relaxed/simple;
	bh=QcaaWn7ao0nGAqzvx7AVdbzxBzIDM1ngs8MULO6DHNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eY3pB410OwToqRuya5ZdxQOtwwcboPYbZnvQ5756Pc8TtCppdLK9hdBda3eg7M9iK19744YDAi3zrG4npwj/SFgPcWaH1sFQPKhiVRKSiFIfkADNReLzaoSn5O18kTbWGz+tSbuAciUE0xGFpeqxpRmxMkw+lFRHgKTnrrlUJn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ktP7c8sV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a293f2280c7so424733066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707736145; x=1708340945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52KWy+bb78uHnWfB2NXdI0P9az7MtRNqaFgDu3k1CH0=;
        b=ktP7c8sVmSp73PU3cSy6NmRz/gBYDorogxKT+4NPFFhIFqauNSWV3GKJc+2L96paku
         P2tTa5RitV7v7alp2IGreJbGcn2CF/axEpAsYVaQKsf5RCFbdGCyHZx3WhOtOqDNbeoX
         ChlBSkDlOf9WERfxqFjCi3zJvrrzkfxIdD4EBg/1QOiM3DdKsank4N8Ano1pVne6tRro
         ksRqxxsN7wT8MFI1CyUXXr9Gi3xB9J/DxmtLE2ZORUsQ3Zm2bPhrMdVOmd/rFUejscKp
         k42jwJJopeHvgOa1qd8TeyepGe8+mMz4L3t008BOdztdCAZZDfwUtsqgrvSCu8WxdZz+
         HgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736145; x=1708340945;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52KWy+bb78uHnWfB2NXdI0P9az7MtRNqaFgDu3k1CH0=;
        b=b3PuZKIjlQ/QLW94mvcjf9+XpZXl2VJTkDRTuSxZln/FqoVAWr3B/5IHHTtD9lBIgY
         RsTZMfdPEnkcOdkS2LBoxqrfodLLLmjRIXNNVoiNGPObj45GHAjzJxI/uke6IePIqGHG
         N+4O925k0Nerzr8UgM5W76+xBzDGz5Lt/BxVKxj51rPiVo9tZLFDvyx6GcdeIlfvY4uH
         oSDD8ZhEihYydQRl2Leyii0vbbEjOaD28PVxwjtf0MaRVvXHjmwO4Z1gq3M/4rxY08bk
         w/yOgm8e+GDLIp38piYmN/iwRb+aOPq6MK3YvcT4DtCvWCwC8qunf8bV6xtodMQv8vJ1
         cb4Q==
X-Gm-Message-State: AOJu0Yz4XzRQq6NX6m34LBTaMwFqwjwTpmIoLjzVQJcP0s1iSigrn0/6
	ouINuHCEasgt2zzM6copjCWgqQJXPiBz27PN8nvuGi4LteFAOWxxiYwjpsnLJkI=
X-Google-Smtp-Source: AGHT+IEskGmX+804BcBVbpo8ffo4bhmGESpAvFuXer9Um/vaWMy68af/ORlyDfj6rHKpEpGZ3v1eMQ==
X-Received: by 2002:a17:906:130b:b0:a37:aad2:1cff with SMTP id w11-20020a170906130b00b00a37aad21cffmr4957710ejb.63.1707736144853;
        Mon, 12 Feb 2024 03:09:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWFntPaCTWqTGhfCL3C1y3zgS9LTagejUbOuWu98JQ6lRcsgjXYnNO4oDoMjcr9KrT+MQUtcSM6cZMqSQY1GLHQkaA7AapPbZv26anfHES/67YqaJA2Y3uJsc14ZZPUgqtsG9bqhxp5Vs3FBEtaRR9C0uFuZUtUOylGeYv9dYDwk9c41cjLXXMQ8Thxrj+15mJ8ddxFX4iezZlPXAXjdPlWk+6naa+tcFAvFPe2VgI4tYUBYiiXw3mlWQOz6aABTirxMfA7XLq4REM0rwelBBoRQYj4mu0zSOZwj/Rfq9deJ1LMxybKhcB3jXyfeYapAkFBZguZDd7iycS+V/4
Received: from [192.168.192.135] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id z11-20020a170906074b00b00a3a40b7ecdbsm99569ejb.69.2024.02.12.03.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:09:04 -0800 (PST)
Message-ID: <254c1d14-25e3-4f4c-9e79-4ef7cec4d22f@linaro.org>
Date: Mon, 12 Feb 2024 12:09:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: misc: qcom,fastrpc: Compute callbacks can
 be DMA coherent
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240212110827.59302-1-krzysztof.kozlowski@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240212110827.59302-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.02.2024 12:08, Krzysztof Kozlowski wrote:
> Apparently on Qualcomm SM8550 and SM8650 the FastRPC compute callbacks
> are DMA coherent:
> 
>   sm8650-qrd.dtb: fastrpc: compute-cb@2: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

