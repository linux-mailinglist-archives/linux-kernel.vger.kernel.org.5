Return-Path: <linux-kernel+bounces-102766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD8B87B70C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C06B22125
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A416FB5;
	Thu, 14 Mar 2024 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TaG2nx1u"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821253A0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710389719; cv=none; b=QuwvSjpa6ULy7p6Vl/CVkXMsqCpZ+Wvy2XkFAWwUAL25p5NKQWTYit4KndXony8xwBFpFsrlep4wGf1zt/a/S7FCt9MGk9mhCz36ts9wSb/IaWujs7IqlL50Kgy2EaMHM95uugYy4M40zhNkKWHPU+JMNhvxCAoKh8dPxLFcjkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710389719; c=relaxed/simple;
	bh=PzQsxNMp7SX/ZS4iaeo/1jeCjn3y1IwAu5C8iaiW9HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baJtu1i4fqL97DQudPzFc9xuPBu56kRCYQd6+2dM0yf5vySyheYlQ21MxJnw1oH4YipjQNDDjczK01Bc8vKuD/O4cvQzPxdTXaWNo9pUt6xasPGSNTCpLhmwDN9BjlLYQMROeZpgGQtFIyjhDHwBI4Nj8Z1wzCZqkXtrzjJTfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TaG2nx1u; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-413e6a11280so3655265e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710389716; x=1710994516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNOiEblG6DNUdShxkrvSv8VdX/F3Z4NRcuR2Z0a2HW0=;
        b=TaG2nx1uxifTqWOjanrRuODKYOx/HqRHnhCwomKhsKXZMI2Z/he9adIlsN4PY9TXu4
         +lWDTtHXcO85jhk/25/DIFjSmmCviEFspVc+kQnWMkphHHffeRh328WMOh1b7kAfXDYS
         R8/hWjTjXUpY1F3GbMmGnGXePWqGtdNwi6J4SAJwZ8UmZBMZvnTW7suO4NJ6rdQL62xt
         iivn82FzSoVWYrUwLmcSn6Eh47vNg23Kev2Qu22XaDhvUSPKArhTOXJJW/kxUYHeNt9B
         aZgiRSNfAmBVOl8zjLLo4jockNVaAJ2CfiSCYG5IpmolfFHhwuEkR4zMwNO2o/7uvBSc
         tihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710389716; x=1710994516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNOiEblG6DNUdShxkrvSv8VdX/F3Z4NRcuR2Z0a2HW0=;
        b=PCJv2o/ky39BcpOYPC9/U+eHtxtc/gX8N6cqomu6g8KXv0UAmgAFnzVzYxRjAvPsiO
         EwEr4YI9CHsYoP2sgqrcAtbalzbnJEvQq1sf/N1+Y5uWMZ3drh/PyZ8B9NaYuXNshPtk
         IInkbEoP4qEO9OgQGv0cO5cCWec70OEjFlPrEvyZ57+8HwKAiQpXNRZnh8pXncuaB/Xy
         Cd9+lnp6fwcXbPp9or47JspJUbIfEJTwFFNVef0CqKVatS5NXg8kbdVX6RdxJ83bUdu3
         Oei+IkQweeFFjGLi02VK9QNHtcznVq+9uvnZ9rk1rw20Z4FT7vO5yw4+S0hTqh2Bfkf/
         2DQA==
X-Forwarded-Encrypted: i=1; AJvYcCWkPn7/k+IMqgKamlR99kur++QlXJ5myU8C7gLJDyms3grxB/SLVxRgRuz5Bc2XS0ZzYYLdq96HBTC7qPDhys7zt+NReSkneyHjnish
X-Gm-Message-State: AOJu0Yy1GBlzeGKCiTRnMXAYP7pIZURNiyzaQdRGtGPwd/szsGiYs8bj
	U1uVKTPSxfyYt9XrHSB8oRzQnlCsX8/hH8fJHUmfM517Xfm7iz3dJcBvlirobS4=
X-Google-Smtp-Source: AGHT+IGlXqpRP/oSGEFwftT4jl4xZvSSoMb6AneY563YlPGGqJOidlRrJW4WydCNuCtgPnhhK/eNSw==
X-Received: by 2002:a05:600c:4e16:b0:413:315f:9e89 with SMTP id b22-20020a05600c4e1600b00413315f9e89mr384733wmq.40.1710389716381;
        Wed, 13 Mar 2024 21:15:16 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d678c000000b0033dd2c3131fsm605103wru.65.2024.03.13.21.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 21:15:15 -0700 (PDT)
Message-ID: <fc00af46-1521-4bb8-9b7c-237cbd26a17c@linaro.org>
Date: Thu, 14 Mar 2024 04:15:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: qcom: Document rb5gen2 board
Content-Language: en-US
To: Wasim Nazir <quic_wasimn@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240313071238.3290-1-quic_wasimn@quicinc.com>
 <20240313071238.3290-2-quic_wasimn@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240313071238.3290-2-quic_wasimn@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/03/2024 07:12, Wasim Nazir wrote:
> Document board bindings for Rb5gen2.
> Rb5gen2 is using Rb5 gen2 SOM which is based on QCS8550 SoC.
> RB5gen2 is development kit used for IOT solutions.
> 
> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 8115088a6076..de6139db8ef6 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -1013,6 +1013,13 @@ properties:
>            - const: qcom,qcs8550
>            - const: qcom,sm8550
> 
> +      - items:
> +          - enum:
> +              - qcom,qcs8550-rb5gen2
> +          - const: qcom,qcs8550-rb5gen2-som
Is this a Thundercomm SoM like the other RBx boards? If so, shouldn't it
be "thundercomm,c8550-som" (Or "qcom,c8550-som")?
> +          - const: qcom,qcs8550
> +          - const: qcom,sm8550
> +
>        - items:
>            - enum:
>                - qcom,sm8650-mtp
> --
> 2.43.2
> 
> 

-- 
// Caleb (they/them)

