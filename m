Return-Path: <linux-kernel+bounces-157235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC0A8B0EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911DA1C216D9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE5615FD04;
	Wed, 24 Apr 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wo9bEsve"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969A515FA80
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973441; cv=none; b=QCnseYtSjXiwG7z9a6v90YRDxOwhu3K/qmn4mPTgOrfWdx4ERAcN045SudwaCq5l6iwkcNfiMdDpuwl45E+FuRc3lqlq3DEAF3vnmB+PJl53o+5pQcxr/QF+2pao1GIQOJBAyKrZkVQgYsS+qHpokrUH9VP/U7/NR1QhNiqd1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973441; c=relaxed/simple;
	bh=Smn1thELJe6H8Hi4QwFeVCA2i/KhGRWxi/C3KjKLf4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOQ8vrvNF6+B0e5mrLnLsT8XrI9IY0xAXNQ0+5seVsku/ddssR6INTkWI/ngP3pU+/s77fWUp+6J8IRJ1gDHuXVLwYKQnLcZyJmoQZ6bhYR+lsvPyTViG+ejCa2YFii39ZareNaad5sWrZuQlLXmxRSDJLjto4pbJ95DIbFoOUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wo9bEsve; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a52223e004dso948466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713973438; x=1714578238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNhQouszyO4G6x+Wog6/QhRAtYiInd0o+cfFBd5MkXo=;
        b=Wo9bEsvel6gVXBdrRm/0gns+ED6qsGq/tHfvU6D5JBELEi14+W6uJvYHz7wZxo2iDu
         1rFHFOVnKd27FchUAkkOzQWESOrnFOvAf1zr9bRxdb8soAqyI7BQ4gizGDOoaNteGEPA
         ch/n1NM9ZZ9AmEamq0S3Cu/RPfjjMOVy++dyXucakLK0sJ49NWzwRLvnq+N2P7SNpjiF
         VvNVH31SmriJeXI1g8tJbq/pKKJmHF7BLQ86FZx3LMtqM48Cxr1B2WSmqGXXg0T+9l06
         E9XwjCAVY1lVBS/c2lR+aEJnh7YYCCnyd1W2p7Z7nQU+JedRCEx59TpB2GOf+JCwko9a
         hhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713973438; x=1714578238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNhQouszyO4G6x+Wog6/QhRAtYiInd0o+cfFBd5MkXo=;
        b=xNResULRjps5MzxarKUkgavUiwz/TcpXLKSDPAPYrm7c9W54BWta5tHNgTrNrcYLMl
         yfOAhtMSccH+DsLUwLkGzSBIap8On2eJ5Y6B1vS5DuL0Uu5BRfncXrOIicNeRZMJdOYr
         J8zJcTZSHyDOQ4Sl9CfL7A++fvz733a/S+Yk3jAl6RWxrD5grBYrZVwWrpniLZSBFahf
         j715LvKPBdVwolPKcKfFpnms5zYt3PsKfjkrEq6z13GXBJpQVQvrP24lhfvAqwQ+vrme
         5YoDiZY7Pnnune2OMTYTWWTq6Ko3Y7zPUN2cuiE+CnJ0URw5wGjJz3zcLh01ek9/WA3M
         o2MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhmXA8cjUMoHIYTXrNUrNtFkP81uFHdbUQECELYbMNSwjkTgu2CuGfzJAfYFMkNrIm4jeH4cUI37WeTA7VBNbQHAiLlioRRpXScBCm
X-Gm-Message-State: AOJu0Yy8M+NgBTUepqlax6xtqXJiPI7QUG4tC8XuSluzI8h9HOaqC3An
	g9aNftKg7GBnQhB0UibWV9daT9cTxCePSe7w07Fx7tGo+EqRRy0mHQqGrn6M9jk=
X-Google-Smtp-Source: AGHT+IGbXGrpnubvU3fB+twJxorCJaNpth47KfqOPWrUQ5JuHE+TeN75cbmD+qlTh6lLqPPbiQHdkA==
X-Received: by 2002:a17:906:a996:b0:a58:8662:1f06 with SMTP id jr22-20020a170906a99600b00a5886621f06mr2463128ejb.56.1713973437807;
        Wed, 24 Apr 2024 08:43:57 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id i9-20020a170906090900b00a55b05c4598sm4459714ejd.133.2024.04.24.08.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:43:57 -0700 (PDT)
Message-ID: <aad0e811-28ff-4bbc-b5fa-691701d35f01@linaro.org>
Date: Wed, 24 Apr 2024 16:43:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] dt-bindings: arm: qcom: Add AYN Odin 2
To: wuxilin123@gmail.com, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Molly Sophia <mollysophia379@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-9-e0aa05c991fd@gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240424-ayn-odin2-initial-v1-9-e0aa05c991fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/04/2024 16:29, Xilin Wu via B4 Relay wrote:
> From: Xilin Wu <wuxilin123@gmail.com>
> 
> This documents AYN Odin 2 which is a gaming handheld by AYN based on
> the QCS8550 SoC.
> 
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> ---
>   Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 090fc5fda9b0..8e991f2bd9d8 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -1003,6 +1003,7 @@ properties:
>   
>         - items:
>             - enum:
> +              - ayn,odin2
>                 - qcom,qcs8550-aim300-aiot
>             - const: qcom,qcs8550-aim300
>             - const: qcom,qcs8550
> 

Doesn't apply to -next

Patch failed at 0009 dt-bindings: arm: qcom: Add AYN Odin 2
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: patch failed: Documentation/devicetree/bindings/arm/qcom.yaml:1003
error: Documentation/devicetree/bindings/arm/qcom.yaml: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch


