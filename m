Return-Path: <linux-kernel+bounces-120474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4031D88D816
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B9A1C2617D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0982D60C;
	Wed, 27 Mar 2024 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v60OY88s"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3F68833
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526076; cv=none; b=XDu2b4Yfh5Hc43LQ3WQLt66AUGpl26ROCreZofG0XH78I5ojzjHudgb+ih1WNq0Hl359lERmkWClBqqlHwphyCZAo3Cb2ll3A3PuLk9ssYVPy0aaal1LOmiHp7418tm3pLsNq5z/opximw53Duzr3aBbUAT6Edz0aKQFkQytsZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526076; c=relaxed/simple;
	bh=8+LLbp43q+hfjs5ymAg8kij5Hy4bzN7T0M9/FvwxK/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBf6T20D0YXR0+VWLZLyn0rJxrS+957sEv6gtSWyRQWyiLrnK/MMpJEsLLSvQtZIqLen7ENo/kJxyPJkJ3vPlqcyIiWFwAC1P/LmP+j8sy9bTpGGDWF3G9uBG/0otAtgqjA39J+td3kcXuYqeh1+cHF5tFs5HNAExUvS6tK4YCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v60OY88s; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso768013366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711526073; x=1712130873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=47TQHK5tr4oTWKeoCO4xhTxaiIGWWamQR+oyvM1xDdo=;
        b=v60OY88slB3WWgOZk9tX2EWz90zEUQZP5G0S6qDo44HUnyC9VDLn8yVzkR6+srqjGX
         /EGRDlGvNUq4trI4aaW/dbENfGQZ3gmzHZ8uOAUzv7A9yDLyDwiRlnBFPVtUWG+/5aqI
         Gjdj8ObVIlvtZqpriPk7YWGxPLkEyCpeHz9iau+GbHB8qjUJqgr95ZPoscFpGKdLK/pS
         636+kkvwotGqmIc/2crX+GHWargLVM/tk7T2fcyRJahZ9RJFZK1U1R45uN93XeuNOPNN
         o+CoGf9KRL8L/m5dxVJyGn3HB4pS0ZsIhutQUQE21ueFL26dX1nAuEM7vRP7nkBQA7zX
         8xzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711526073; x=1712130873;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47TQHK5tr4oTWKeoCO4xhTxaiIGWWamQR+oyvM1xDdo=;
        b=KZGpqm+64CbZik70SXYfomalkNDpGuzf89A2Mz8AIAI00vVHDRu7b7jB0LvghfoP+g
         PDMitbXKtQMSR+CR56//iUxyeWnTOzfW4zJxZXnebw15yABxkz/ioaWu36YiivF0lBXT
         H3tRyXVhAZhBTxeiqKeboHNnpRNzqmf2MGAGctWTwUQBH8EukF0432XYZeSoCkgKpdG7
         6L6ROchqxKFXcdu97dr+LOtgDAkz05J8lqGUrXQlr5j1v6Hzc32/9wqRA9zADk2FHrpH
         tB6wYdtxHzvVFaB/XqZOL4+PcMrvgcF6+tq2p8M2VdzbNSrPGwQ0TDjXc39jE56LWihU
         ERfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvpuLIXRmwR61+WIHcofsFoDgio2MtSDzN5Qh6FdoQlIUVAs7yC0nmH0bYc0NM32hV6MQ5//LmdnV+57IEx15nvfxKeJWEUDOpFyQA
X-Gm-Message-State: AOJu0YzEY9aZIYdvoVzrKX1/b9ygzWR6jloaEiVDCO5Ofj3ZAOyq9mUN
	SkzlJWpF2wXPQztA1YlSKPZzBz4heymQrk16Xj/1i48yYujXYksMLnngrAAcmQU=
X-Google-Smtp-Source: AGHT+IGSGtVU28nMbjqAjMEL6UzKByu3jHiyksyRt9/sCk4+2cUceRaHHMh3EOBzRtNVFspvoIIByQ==
X-Received: by 2002:a17:906:b2c9:b0:a48:7cbd:8b13 with SMTP id cf9-20020a170906b2c900b00a487cbd8b13mr305312ejb.52.1711526073300;
        Wed, 27 Mar 2024 00:54:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id kh11-20020a170906f80b00b00a4df6442e69sm1394491ejb.152.2024.03.27.00.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 00:54:32 -0700 (PDT)
Message-ID: <31ac366d-bfa6-4c99-a04d-ab9fb029da7e@linaro.org>
Date: Wed, 27 Mar 2024 08:54:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add
 StarFive JH8100 support
To: Tan Chun Hau <chunhau.tan@starfivetech.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Simon Horman <horms@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Andrew Halaney <ahalaney@redhat.com>, Jisheng Zhang <jszhang@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Russell King <rmk+kernel@armlinux.org.uk>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Jee Heng Sia <jeeheng.sia@starfivetech.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
References: <20240327015750.226349-1-chunhau.tan@starfivetech.com>
 <20240327015750.226349-2-chunhau.tan@starfivetech.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240327015750.226349-2-chunhau.tan@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 02:57, Tan Chun Hau wrote:
> Add StarFive JH8100 dwmac support.
> The JH8100 dwmac shares the same driver code as the JH7110 dwmac
> and has only one reset signal.
> 
> Please refer to below:
> 
>   JH8100: reset-names = "stmmaceth";
>   JH7110: reset-names = "stmmaceth", "ahb";
>   JH7100: reset-names = "ahb";
> 
> Example usage of JH8100 in the device tree:
> 
> gmac0: ethernet@16030000 {
>         compatible = "starfive,jh8100-dwmac",
>                      "starfive,jh7110-dwmac",
>                      "snps,dwmac-5.20";
>         ...
> };
> 
> Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 29 +++++++++++++++----
>  2 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 6b0341a8e0ea..a6d596b7dcf4 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -97,6 +97,7 @@ properties:
>          - snps,dwxgmac-2.10
>          - starfive,jh7100-dwmac
>          - starfive,jh7110-dwmac
> +        - starfive,jh8100-dwmac

I think that's not needed. You have there already your fallback.

>  
>    reg:
>      minItems: 1
> diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> index 0d1962980f57..5805a58c55d1 100644
> --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> @@ -18,6 +18,7 @@ select:
>          enum:
>            - starfive,jh7100-dwmac
>            - starfive,jh7110-dwmac
> +          - starfive,jh8100-dwmac

Same here, even more obvious.

>    required:
>      - compatible
>  
> @@ -30,6 +31,10 @@ properties:
>        - items:
>            - const: starfive,jh7110-dwmac
>            - const: snps,dwmac-5.20
> +      - items:
> +          - const: starfive,jh8100-dwmac
> +          - const: starfive,jh7110-dwmac
> +          - const: snps,dwmac-5.20
>  
>    reg:
>      maxItems: 1
> @@ -116,11 +121,25 @@ allOf:
>            minItems: 3
>            maxItems: 3
>  
> -        resets:
> -          minItems: 2
> -
> -        reset-names:
> -          minItems: 2
> +      if:

I would personally avoid nesting if within if. It gets unreadable.
Although Rob did not comment on this one, so I guess it is fine.

Best regards,
Krzysztof


