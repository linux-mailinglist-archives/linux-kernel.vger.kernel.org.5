Return-Path: <linux-kernel+bounces-16324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EC3823CD4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8234F1C24717
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE591F610;
	Thu,  4 Jan 2024 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCRrxT6h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A201EB46
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28da6285c1so34806866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704353864; x=1704958664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XcmxxauYbfKJDqvFNCXACuCIGrw/Uc+4qzPY1VHZt9A=;
        b=gCRrxT6hiBPxXsAY03uiaxvwWXIq+oOqa4r8I8lbz3MYWMGvuZjWX31etE0PmCauqh
         b9GBiah+3q0SLODP/V+jn7ck6Bz3sda5/n/ypU7x8u4yrIWzBWYIilTewqYkQ22hZs6B
         CXp1u7b4VnuDxDP4XUi1/QRJ1nZGOoSfu6HZtpSNhWfnuLopt+YzzpyCgMz9fU9pp8mB
         fS1Awx2OkXSmGgcRY7In+Fhh7nmEj1XBdy1Nxfj1u47TFqa+RU90xkQ6YM3vOOrGOPul
         6+a/jZfOzDZ8yuUGKfqp0xi3avwFKkP/B2UTAMqI6BQy61/VEWr9L76SUphW5ZBpXFzQ
         w6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704353864; x=1704958664;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcmxxauYbfKJDqvFNCXACuCIGrw/Uc+4qzPY1VHZt9A=;
        b=WcPy3w29wR5BZ/qPwgwA7RreEWHjpx1Ad1I6PTuJXO1/0a7q0mTuBTagFiEAmJyALH
         i3OoifM5aQm0O8G84GMPzPruEtP3S6Id6bvyObDSoW4GnyIZ80Szgj8+ZC7Vf8e7u/bU
         f7pmpZNDoXY490SU74YRy+3HIxadOXopyBvxaof6Rr+8rbVPbgbIwAm8nZEzZSsxmoGY
         /kjwF8VxiG1tXLyZ3GNlZwVKavAn2p1SUJOZ+lN1KaMSGSxWRgn9Fi9oEjbsp7MuoHou
         l2/f0THHy4k66pqSGgFkEcCMfM0BfJYSdfTfiDiOw65aeUZ0v7nEvJa/X2+pqzbVEeav
         3pFA==
X-Gm-Message-State: AOJu0YxlcphEE8g5EsPLE1Ov0rdTDILHA3YDHdDZE1Z7qUEMCsMJPaAv
	QYXc1cx/MxXvZsukSpn4ZTTb5GFyeycAfA==
X-Google-Smtp-Source: AGHT+IF7EXuxwSlHTY5javAEI9SH4fqaYbbA3qEZhIO8Ef01OIU3T8e0S9VOYlK0L07mInkTxs8Byw==
X-Received: by 2002:a17:906:ee81:b0:a28:ac72:4570 with SMTP id wt1-20020a170906ee8100b00a28ac724570mr218580ejb.21.1704353863819;
        Wed, 03 Jan 2024 23:37:43 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id fw34-20020a170907502200b00a27aabff0dcsm5328306ejc.179.2024.01.03.23.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 23:37:43 -0800 (PST)
Message-ID: <c343e7f5-ea90-4bfb-a837-0cc6fd9a3488@linaro.org>
Date: Thu, 4 Jan 2024 08:37:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: add Marvell ac5
Content-Language: en-US
To: Elad Nachman <enachman@marvell.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
 huziji@marvell.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240103172803.1826113-1-enachman@marvell.com>
 <20240103172803.1826113-2-enachman@marvell.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240103172803.1826113-2-enachman@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/01/2024 18:28, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add dt bindings for Marvell AC5/X/IM eMMC controller.
> This compatibility string covers the differences in the
> AC5/X version of the driver: 31-bit bus limitation and
> DDR memory starting at address 0x2_0000_0000, which are handled
> by usage of a bounce buffer plus a different DMA mask.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  .../devicetree/bindings/mmc/marvell,xenon-sdhci.yaml          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> index 3a8e74894ae0..cfe6237716f4 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -27,7 +27,9 @@ properties:
>            - marvell,armada-ap806-sdhci
>  
>        - items:
> -          - const: marvell,armada-ap807-sdhci
> +          - enum:
> +              - marvell,armada-ap807-sdhci
> +              - marvell,ac5-sdhci

Order entries alphabetically if there is going to be resend/new version.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


