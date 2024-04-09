Return-Path: <linux-kernel+bounces-137585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE2389E449
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7BD1F23219
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7C115820F;
	Tue,  9 Apr 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpNgss1Q"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CBF4436;
	Tue,  9 Apr 2024 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693954; cv=none; b=YI9Hr6TGJnDtb9b5C71O60cSaq0X+iDJXvLf/1jcmAUYawrObu0dcHAfiXFFt1IgCW0X1vbQUB+u0tC0rQwlBs2RkG3bMtOw5obLvE7Ss3bmgvQUpZxSAdAyMSLbIeBwOKb25Uv2yg0VrXkeBSdxChUq85eF0AEgyLryxM1vLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693954; c=relaxed/simple;
	bh=ToYr3o6+mLV92Xi6A7D0WqypWAMc28DaNSTm+5qtVZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVyfbajWemou8chwaHlIaNrnrvi2haK+eFvVL8PME678x/Ij/4nB66Juk//bdZWgvuFidnS5iSugC4ozWXfl9RiBabtkW5ycAoaY9tcG/C9tcZmbu5PZ+l/nMdvkRMJDT3vphAaPW3GPYNB9xFfl0CMQZAkWgnW9ys65SaWaZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpNgss1Q; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c5f6b33f1bso512659b6e.1;
        Tue, 09 Apr 2024 13:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712693952; x=1713298752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/qH8NItVOVq4Bt+ZHLr1TJQobJtozwRWOASECxFFK4=;
        b=YpNgss1QXtHtq048zWaslF9bFr6gHkcWt/8nu8AWWjtEbKyNjzG5QtMjexKSj2QyZc
         GbpRnrAiKSyBwt2LPU5v6XWL8lee8kGc8FNMeKQg449KGq4RcQjrA35X7w6VWOfcYdY4
         Oxr/7CeHhMKQUMGJj2fL+ZNYKLus5FXqWknBnbHjUXPOSdzAgGX3CpcCo0tDlpsfhOe/
         thXYauKCDJO8YsSp1EtaKNdR10tfQ6GHFtdULEtrohaDCDIElon7OEVKkrNJs4TYAvdH
         TcEsekLvhGdrXdio2zliVUVnVhaMyiks7e843sVIcuTHhsQq0K8XKlGNCPVjNF5Lggkl
         ORdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712693952; x=1713298752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/qH8NItVOVq4Bt+ZHLr1TJQobJtozwRWOASECxFFK4=;
        b=TGAMUcYjhCjiaqm7wPT480gX3YDni8DoWc3LP9HpYjirYMPJ3bWLv2yJ3IJcPxkayy
         vTi7wvZzwRkloFC8brvuzD0kEdPHDm0rvm3iL51jOfbDD1CyjuVNaH93iElqWK5subz4
         At+klaRD3zmul6pZmTRn5ADEihti9Yb+SLNI5rbh0h6EoB9bn4LphIy3j3NFmODx0o8c
         aoX/f77bWLLpkZ3YTjv4javJNhlvQBtPAkUkByaTfagc4uNYBxV1iE/3ETOasx7YOX++
         kGWariXLN4xmM9//fiaMO4ACBxZc7KxRi7buTT+9xrEKYp5eidNZUfZMuRWRzFQMMrEK
         LsGw==
X-Forwarded-Encrypted: i=1; AJvYcCV0PCTiC+5xSJrFL1IYlnAiN728eBGw2T1lbVn6sCWfCyePRiPbzu+ICWIvbh3yhKlb0RiQSqvQJg2TU5ZYnVNi0T4Wwmm1SAObdryx+RN0DX3wwHr8Uul7lHBbhYsomXOte+Whxd5SWw==
X-Gm-Message-State: AOJu0YzzWd2TqM5pLll5u6R6MRb3Duf/dpmXSz0hfbt7AHFVrYPMXjUY
	c9E2HUbUY7qCBou2y5UiuIgLhRuMGodMvkwodK1yECf6X8fDGPSwq1GlrEfJScGaiA==
X-Google-Smtp-Source: AGHT+IEaPDVryrV9ov98iA3AwPMOsXh9L8jN+mfbgZ96uWTQB5vVI9XX1DxRaywPeCcUYq4A7VCIaA==
X-Received: by 2002:a05:6808:bd2:b0:3c3:dcb9:118a with SMTP id o18-20020a0568080bd200b003c3dcb9118amr1519524oik.28.1712693951843;
        Tue, 09 Apr 2024 13:19:11 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id b14-20020a056808010e00b003c5edda8526sm1083722oie.31.2024.04.09.13.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:19:11 -0700 (PDT)
Message-ID: <33461c22-21a3-023b-4750-c69304471ea8@gmail.com>
Date: Tue, 9 Apr 2024 15:19:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/7] dt-bindings: phy: qcom,ipq8074-qmp-pcie: add
 ipq9574 gen3x2 PHY
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
 <20240409190833.3485824-6-mr.nuke.me@gmail.com>
 <019180df-67b9-438b-a10d-f92fd4ddec03@linaro.org>
From: mr.nuke.me@gmail.com
In-Reply-To: <019180df-67b9-438b-a10d-f92fd4ddec03@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/24 15:09, Krzysztof Kozlowski wrote:
> On 09/04/2024 21:08, Alexandru Gagniuc wrote:
>> The IPQ9574 gen3x2 PHY is very similar to IPQ6018. It requires two
>> extra clocks named "anoc" and "snoc". Document this, and add a
>> new compatible string for this PHY.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        | 31 ++++++++++++++++++-
>>   1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
>> index 634cec5d57ea..017ad65a9a3c 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
>> @@ -19,19 +19,22 @@ properties:
>>         - qcom,ipq6018-qmp-pcie-phy
>>         - qcom,ipq8074-qmp-gen3-pcie-phy
>>         - qcom,ipq8074-qmp-pcie-phy
>> +      - qcom,ipq9574-qmp-gen3x2-pcie-phy
>>   
>>     reg:
>>       items:
>>         - description: serdes
>>   
>>     clocks:
>> -    maxItems: 3
>> +    minItems: 3
> 
> Which binding inspired you to such change? No, you need maxItems. See
> your previous patches here how it is done.
> 
> 
>>   
>>     clock-names:
>>       items:
>>         - const: aux
>>         - const: cfg_ahb
>>         - const: pipe
>> +      - const: anoc
>> +      - const: snoc
> 
> OK, you did not test it. Neither this, nor DTS. I stop review, please
> test first.

I ran both `checkpatch.pl` and `make dt_binding_check`. What in this 
patch makes you say I "did not test it", and what test or tests did I miss?

Alex

