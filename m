Return-Path: <linux-kernel+bounces-110475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFDD885F71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0AB1C23204
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6393056B76;
	Thu, 21 Mar 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOctEU41"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0E1755F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041375; cv=none; b=oCEODN8VbQjTLec3zroyt3MtvpfVBfj0v69Ug99JJm9O0tYROQmPTbNcNtsop18H2Y50N1dH6SzD1VqhRxj6oCGxhdDmUMMZTq5CF6dbgNaJXoLR93c+kr9hUV/z8ISXZ7Qi7qqfzdcrrN6MqOHpHDFBnAKgysg0HyMrEVbOw1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041375; c=relaxed/simple;
	bh=RUsWaSGEGyzJkXmAa/BIHP71etV0BQXLfjmPcNLZps8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4aZPSqX9/B9GfT4+k1suelCTjdzMo0ur5QqJA90pgws9Ns6XwTKrLCrniHunwcpJPw4rGC2tgpSynq0OdvS3ymwUbivfbbwFqwxuFVg9sgi4ew+j/gTzCXx0EH567+TMTD03kbnwjxy+ojs+3xK6nBrLcHZpG/CtxfPPI8syMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rOctEU41; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d094bc2244so17398461fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711041372; x=1711646172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBA7Y36AMw0KTupRrw+PnBU6PO+JQCp7HzJLhSmsbvQ=;
        b=rOctEU41ksX2XVMCUcrsRmWO6kNfoqXJ4z/t+hVWJdVVyfW/5+FtCxa9Quxc6kiPE2
         /lSXGM4JmHy0L3diLkWAzU5z5DN+asJTr9ZJkrZSjcyMsaWpCrezd4OckMDrblSMyuYF
         jMfw3XuxMShzCLypHQrpyY2j0ZG4Mho8ypSph5EnIO6A+S7kIFfDnFhuum3ovuXlt1AC
         UM6z9zfPKlh2xWF0g/yIVntihzDjTJJW7vZN8fQ8y9heEeoAnqZ8r4IT7vlNpiOTtKsT
         L7C4neCUETKTZKn+lTRpetRmp+0v32H10w12aEYjyGilCd4+ieJDUEb71fNK88DEWA1L
         7D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711041372; x=1711646172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBA7Y36AMw0KTupRrw+PnBU6PO+JQCp7HzJLhSmsbvQ=;
        b=aGFm/aOiZx9cGLFz+1XYWx14gmPLpb4BlYEAIwdt0lLNwIv8uxOeJNlVUEcwxsGoF0
         OnZYD9gY/TZBh81F+ejZZzOlUGcA2dh8iFaK5mJwh+8RTrqCSfalxZ9hKXemr6yNUUrF
         roQUgpuC9v2YVDOC1XEMt8OiPDb5NstRSjmgwLF4iDNZaBxf/XkuNrqix7ZcSHgCPfhU
         UFO+C2w0QQYOBcq37HknI+gpAO+rKcMx/v2sI+x3xgZ2qC+KQSpA2v6hOpcUuo/L0sdr
         ujE5jXOr/sm7FirmW6SCvPAQPRV+W+U0ZtPsy88sE7rEELnv4IcC9tEf4dfR1GbcHy8b
         EAaw==
X-Forwarded-Encrypted: i=1; AJvYcCW2K/xaXAE7o67sS99U8f9WbrrLIntFbfJ2jVaH6G3vJt9/10clof3rqpupBjuOi8P4CtJisyBjHa+C8LKPglVsYDyPfSTnoQGh9Lfi
X-Gm-Message-State: AOJu0Ywxf4UInVseDXU0+O4awMPys1SvF7ZD52nR27BradsJT/20syy0
	aNswV+9Je6N6uD/21j/wPtD9/lNxZ5CQSi18QrukiLWKQmXFZFFN03Vi2IgzSu4=
X-Google-Smtp-Source: AGHT+IGkJlWYDvk6fZNaztZrSC12byEOQoxXY+/V0L13JjfECs9/v6X2OntqmmM+6UAK1rUT7dwbiA==
X-Received: by 2002:a2e:a415:0:b0:2d4:a6aa:39b3 with SMTP id p21-20020a2ea415000000b002d4a6aa39b3mr97037ljn.31.1711041372139;
        Thu, 21 Mar 2024 10:16:12 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v9-20020a05600c470900b0041409db0349sm333276wmo.48.2024.03.21.10.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:16:11 -0700 (PDT)
Message-ID: <6df3c39e-5a03-46d7-921b-d53d75447aaf@linaro.org>
Date: Thu, 21 Mar 2024 18:16:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: convert st,stih407-thermal
 to DT schema
Content-Language: en-US
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240320-thermal-v3-0-700296694c4a@gmail.com>
 <20240320-thermal-v3-1-700296694c4a@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240320-thermal-v3-1-700296694c4a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/03/2024 22:33, Raphael Gallais-Pou wrote:
> 'st,passive_colling_temp' does not appear in the device-tree, 'reg' and
> '#thermal-sensor-cells' are also missing in the device description.
> 
> Convert st,stih407-thermal binding to DT schema format in order to clean
> unused 'st,passive_cooling_temp' and add missing properties.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
> Changes in v3:
>    - Specify const value for '#thermal-sensor-cells'
>    - Add 'maxItems' for 'interrupts' property
>    - Change commit log accordingly
> 
> Changes in v2:
>    - Change commit log to use imperative
>    - Drop description
>    - Drop 'clocks' description
>    - Add 'reg' property
>    - Add '#thermal-sensor-cells'
>    - Make node name generic in example
>    - Fix YAML style
> ---
>   .../bindings/thermal/st,stih407-thermal.yaml       | 58 ++++++++++++++++++++++
>   .../devicetree/bindings/thermal/st-thermal.txt     | 32 ------------
>   2 files changed, 58 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
> new file mode 100644
> index 000000000000..9f6fc5c95c55
> --- /dev/null

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


