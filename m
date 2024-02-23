Return-Path: <linux-kernel+bounces-79192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E33C6861EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C141F24531
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569CE149382;
	Fri, 23 Feb 2024 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PH1DbRgf"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5111149381
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723144; cv=none; b=qhwSmZ2029G7lO5S34zFmucNM5kSfd2vzh89ndVeS7xzx7N8thrbAa8TWomGEi2+KJOxuGCZxTaE4AfcmEEJK/75YeriWohXqYOMvFoZRF/yBmLtot15brTOC+rJvUNaFLJ1u69zUzMezGYkYnoyKVUJdA4NsxViYHx0DmvH728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723144; c=relaxed/simple;
	bh=4U611Q4elBg4t0AMJVYfZNMjDBB50VZmE+qFAsL6RK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgsmVxv7LDJO0cGc6BmeUsqfWJPLckwz7cBZHjn6+/EGDW7vkMQw0ER0Cyt390x9JSNGkBwTGXZPV5EAMHPXslIRDnUeHm3QEHWgV+wizZauFpjL1zi33mNA5RGe7fFTM4SZL5h5810pm/4kQqTHKeX+I7KQL755YK+cf6jpHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PH1DbRgf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so128004366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708723141; x=1709327941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDAHKg/xY0dKdy72D5kG+TPXcRiOx6D/NRETdEr9dSc=;
        b=PH1DbRgf+YqA7UKhX9i/xCFCNu21ka6MmQj5bqkD2jVpM9a+oVVAj8DuVDa9oHPa+Z
         PeGsFk+WFFE4e2ALnjZNdXnXdl7d009igpvLUo8beAY2MB+GAxvPPrMiGtc9rbZmhldd
         XxCAMbAe/9Wrat/XZnEsGTzT/vP3wY37Fwo9dHbfC457mj3SDQtrMoZ3z6Ih/1JjM4Tw
         KMowouEkkvMhWaCjF5/7j81J83x3t3aerRJ//su8WEUMJ54PXbF9MWCBBG0zLwPQPLVT
         KbF6j3LLz+bShVlAh9Ks7CkFnBWrVcmGuedwo1l9WAswdOPddOm15ysJ3R8lQ8QBLHGX
         wKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723141; x=1709327941;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YDAHKg/xY0dKdy72D5kG+TPXcRiOx6D/NRETdEr9dSc=;
        b=LzuVM8v8TjKaOAvwgBFtwGGXmP8hA3ZXUXltiwuSf4fltGV7CwplsplRpTBWsm9tzg
         Ds/wGlgzKVsKUSswME4L/C9aWachldSyRIHVd6qo5SI+shJz6l0d0FAdJIyt1I0bQxzs
         g6bOImUjn/1x5qASWTmZoq/RUhQxzWRLyb069dYGA2GMbLOJDAyuu973dlXZf99Doyw7
         u0XbDmskeyUoT6KRMGuou2huEHFP8k5dqh9GXIeKtBEKK5p7oyaNPoRtynLqtuZLNAEj
         s4ks4qPxeg7+AlFLLS7e2Yo+44XWVgCMZV/aqPxydbyumRq9YxYg43qC1185bTCC8WU3
         OUtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhV6YdBmDtHjms0VSdh4wtHZyDKE+Sw51XWqPnnCiHsm77TT/T998iK1GZOWIKwscbq2GLDuzfRjUmHEEvjHcT1ypnt8iMwSExNR4F
X-Gm-Message-State: AOJu0Yzea2OHOHd3G/QhvXQcTKnTSfXIkgsnzmDs6Wya2v+dwHB7TkFX
	tfiiRsLOCsQ6wD+R4A5Mxel7aHU5mhzVVbqV2s2xsIkxXDJVHKdg0l2k6qKFMgE=
X-Google-Smtp-Source: AGHT+IHOg7pXiT0AFZA/1QFt3MRtosBGj3lEqvVg28cc7hzqw7tFNkxREUX1zxQigtViZXRUXpQPHw==
X-Received: by 2002:a17:906:1353:b0:a3d:1df3:9d35 with SMTP id x19-20020a170906135300b00a3d1df39d35mr552886ejb.23.1708723141183;
        Fri, 23 Feb 2024 13:19:01 -0800 (PST)
Received: from [192.168.179.2] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id js20-20020a170906ca9400b00a3f947c55besm1660040ejb.92.2024.02.23.13.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 13:19:00 -0800 (PST)
Message-ID: <6ad10b1a-a15b-4877-bc73-90e17be67806@linaro.org>
Date: Fri, 23 Feb 2024 22:18:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] soc: qcom: socinfo: Add X1E80100 SoC ID table entry
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240223-x1e80100-socinfo-v1-0-be581ca60f27@linaro.org>
 <20240223-x1e80100-socinfo-v1-2-be581ca60f27@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240223-x1e80100-socinfo-v1-2-be581ca60f27@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.02.2024 15:37, Abel Vesa wrote:
> Add SoC Info support for the X1E80100 platform.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

