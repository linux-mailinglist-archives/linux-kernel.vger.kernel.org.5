Return-Path: <linux-kernel+bounces-35033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7950838AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4343C283DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91735D751;
	Tue, 23 Jan 2024 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRf6BcNk"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F55FDAD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003135; cv=none; b=DQ8O/QKO1JZZMGv6tz1guklb428lk0MHWoJIrj0Vi+CZ7ATr0BXmtlKV0c6PBTm+aWzsmS0H+dwtY4qNRpagfE9V9SlNwOOw/DyWUuMZJlHcOExVVHR5sGFQO7MWHs6a50YEkpQzVRzZpN1LAYnSASMJa8PlRDQs8CQCDHlWiu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003135; c=relaxed/simple;
	bh=odkxBY8FHAysxrkRcY9fITRfwH8TqSDhGBgzysz/3Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uwJxZb+0oxmlFWstu81f0WBlqSb+i9mf12ZlYUmieeqdf2KSljugdpWhCpT8i/cPvx7USNsoYlV8FdzMsGlNpiURDQsPpOz8SsGaCX2gr5WM8fVE4rcTVYousFRiuSP4VMDqZrgXPUzanfswaATGAX/9+lRt95QH/nrAqQCwU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRf6BcNk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-337d05b8942so4711011f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706003132; x=1706607932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u4+mDft7U4+grrKWrx4KfPJ3Se1pTXr+hv+2847ZCNk=;
        b=SRf6BcNkcwC27XOOfKeVTKU7GmBbr+AW7gUm8atwjSpa0Z7PnmxQ+rA5OVq84Zk6/S
         DPKqxNMKeT11oxliTyzZbA7JF3wh5DIM8CawupE99/QW6sWVUtaOJRrtvfkn9BtcT5O/
         9+1xTcvAJ4Hkvpd2U86buqnVaOSxgXTD1htJbsSl11fJoBQoISjL0C6wvmQ8ZXXS54aq
         5JPhCCvEEaThL+GF24XV4zuWfmk2rUQkZNZX9pvcVeAOpcVX/DeRxm5FVjxr6b6oJyMm
         KHD0HZfwppFaQq68EjqFEouIeObIBO3AGxrWbqkkfyDADwID+SIv785wBiJb5y8IA5XA
         Az9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003132; x=1706607932;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4+mDft7U4+grrKWrx4KfPJ3Se1pTXr+hv+2847ZCNk=;
        b=qjNV8YtY91oNrIeCLSbGdc6XzHFsMKHD8O0sIq5T+8+uPRCYYFCQ+NPqARfqVY5L1t
         af/JFVKcVXgocsilVPpT3+UlQUjvK4IyJtn9SSV33lGXQOcz8k50TcWq+p6CGrvSJf+l
         wpXREjJOqE6sQ/c3pcHS4r+Ab20n4qqEJ9oa16K6kVQQDTix3GW5I3hYx37hcolJSL0H
         p/OZ324ewQ3U+dR98hHz33KXJ/PpxybaPDvBa8vD5BztoBaazXfTH764Bn4/o01wxChf
         bc1QUmLHNuzG8rZFv5iHeWSk4KdtTG50SwW9XAjUsg4Zt2B77fZDkvUbW5BMJ36dGaag
         cKdA==
X-Gm-Message-State: AOJu0YwrnyLdAykhajXcV5tNjkEc1eFAv1IMgGT5PYrffmdgkTKYKrZs
	BKidbBBevxcuXcGgg64IIsw9BHlzI8tJMtZX+qC+nQ7M+E5ntgebLqxCD76hL9A=
X-Google-Smtp-Source: AGHT+IGeUk4uevU136+WqgA6qK2GCWU3c+cQQnNPm3FHUaU5vvheb5Io6OPMK7/kyI6zteDSYvzpug==
X-Received: by 2002:a5d:4903:0:b0:337:bc26:5d43 with SMTP id x3-20020a5d4903000000b00337bc265d43mr3398320wrq.4.1706003132548;
        Tue, 23 Jan 2024 01:45:32 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id d12-20020adfe88c000000b00337be3b02aasm15889985wrm.100.2024.01.23.01.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 01:45:32 -0800 (PST)
Message-ID: <e19f2aa5-5040-4cab-8c67-557436883e40@linaro.org>
Date: Tue, 23 Jan 2024 10:45:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: memory-controllers: narrow regex for unit
 address to hex numbers
To: Jon Hunter <jonathanh@nvidia.com>, Rob Herring <robh+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Dmitry Osipenko <digetx@gmail.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20240123083517.21091-1-krzysztof.kozlowski@linaro.org>
 <a00a3d5f-9d96-4886-9ebe-4e2962667ab3@nvidia.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <a00a3d5f-9d96-4886-9ebe-4e2962667ab3@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 10:20, Jon Hunter wrote:
> 
> On 23/01/2024 08:35, Krzysztof Kozlowski wrote:
>> Regular expression used to match the unit address part should not allow
>> non-hex numbers.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../bindings/memory-controllers/nvidia,tegra20-emc.yaml         | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
>> index f54e553e6c0e..71896cb10692 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
>> @@ -145,7 +145,7 @@ patternProperties:
>>     "^emc-table@[0-9]+$":
>>       $ref: "#/$defs/emc-table"
>>   
>> -  "^emc-tables@[a-z0-9-]+$":
>> +  "^emc-tables@[a-f0-9-]+$":
>>       type: object
>>       properties:
>>         reg:
> 
> 
> Thanks! We could add the fixes tag ...
> 
> Fixes: de3d7018372c dt-bindings: memory: tegra20: emc: Convert to schema

There is no bug here, really. At least no bug with impact, because dtc
won't allow DTS with non-hex numbers.

Best regards,
Krzysztof


