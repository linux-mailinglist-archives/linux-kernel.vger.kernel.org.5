Return-Path: <linux-kernel+bounces-70497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BD8598AF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805951F2125F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CDB6F091;
	Sun, 18 Feb 2024 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mh+xjTXW"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573CE10A0D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282329; cv=none; b=qp1qnrBFi1TwSZQW5jVC1xUkAqZSnNbgnPBbYgdCMxzYejHIMB/Mfp9WM0rGSgIlC/ABQoBARRRCliQ4NDKpcgZl7CJZcWeLls8Xpd67C/IWicNDFf7o4xNEsiUdk3mCW8os0BFdQy/HI5ggcd3oFUBLWhUS/o8QdIzgp2nQ1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282329; c=relaxed/simple;
	bh=WIqJZbaPkUeaZ6fzw7naKrgrDKBnwdRF/57LdtYivCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODLTY1W7tqUHUIRZsDC0Rr4+EjPdkkfjl2gJgsVz0+CYKUK5xIzoQOdD+pQpT7g5xOXnv2H2RDeua2sxZDEz9UlTVGUlL4D9fulY48Yee4//VtsBopxa567TVgul18hjn19azg99tiZ77c+TwWvOTeMjyXVgGdb2v96ixrcHKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mh+xjTXW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394b892691so2083305f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708282326; x=1708887126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNBEOVVb/rP1qaF97WrZeJwt+wEqX59IP8EY5F5M0uM=;
        b=Mh+xjTXWVAWLomdgkOXG/7uHRYmHcrO6OItQW3iHb3terVhC9zlX+fnHZXqr7qC59k
         XSC+46qZM5ipAPbabYEoM03fpb1y0jrQZxSIPMr+QtgkAZNxhnz4Lh7bNFsmcPBysVbn
         hYj9M2aTv4f5UI/AYbVpg4OgVAUuQ10dAJeGY0XBxvtO6xUHkCj28wFYIze/G9vaTSQm
         hpMzMGgGttCbrWh+lAgNMnSuoyFY+HyqmidmFzk9zNPGBxGq8PRXZaBzDbrwCsSXSSE5
         NkfVG3YRdCDdK664XaYTbwQ+QgYQzy/Rqu73/X/zziq1+wekyhe7rUraoN/jVxUiTwNi
         y9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708282326; x=1708887126;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNBEOVVb/rP1qaF97WrZeJwt+wEqX59IP8EY5F5M0uM=;
        b=O5s77WXvMWKZKTHQ/Aygsfc3UNryMpYcxfx5xGrbrACJFdnoth1H3FRcBGwEe8xQ2e
         vkJAFa0+MPV8qglMh4qTr+zhnsiLowD1YevH4f1tFTJ/cBUJgNW60UxSm8AZqFhdpE1f
         hht7JtqWp+/MEObWM1dsPIlqAOos+mhewdOJCqghC6N/0CMC3+4VUEeNQ8W/ff8gDZXi
         Cxns/eu61SNxojuzToXkEgj7uZxnyJW/YavZnddnC/BXCIWSIeA2C0uWSCKmpHNbMpcd
         FUL11TPcRk55QsG6uQylEMpAK3UlAt3jYYE67CBPlSzt1tNWJ862LMaLgSLoM23uLOBF
         RQiw==
X-Forwarded-Encrypted: i=1; AJvYcCW3g6rfJSzlCQUc3XnQNaP+LeTdAxKJ/0pBh8kLpcEpmxiGIAa97x5Ki8UL3kyg1nnTnG2CtolYUwnxrqal4Q+WB7FH6mwVfLvXj4u4
X-Gm-Message-State: AOJu0YyjcvZrPQ3ec718+XSrq6n0t3FGevxRZAAUigbaLo25NzJV6CGH
	dfXeMWT1sWwXsAzxK/2DbJvSdA18I/YYRQFflU/rfjHGohZmMmwlsWv2M1BfrwE=
X-Google-Smtp-Source: AGHT+IEG1WdiR3eQwnrb//cEfiT0Sx0t9LAhVUuGI6WXwfKCIpNTnZnU9e9ScPsT8AfU5RS2bUrM7A==
X-Received: by 2002:a5d:570b:0:b0:33d:47c6:24fe with SMTP id a11-20020a5d570b000000b0033d47c624femr1113697wrv.12.1708282325670;
        Sun, 18 Feb 2024 10:52:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id r8-20020adfe688000000b0033cf5094fcesm8026214wrm.36.2024.02.18.10.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 10:52:05 -0800 (PST)
Message-ID: <d3a4c6f9-e24a-446c-acbf-75519f6782fb@linaro.org>
Date: Sun, 18 Feb 2024 19:52:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM7150 DT
 bindings
Content-Language: en-US
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, djakov@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240218183239.85319-1-danila@jiaxyga.com>
 <20240218183239.85319-2-danila@jiaxyga.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240218183239.85319-2-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2024 19:32, Danila Tikhonov wrote:
> The Qualcomm SM7150 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../interconnect/qcom,sm7150-rpmh.yaml        |  88 ++++++++++
>  .../interconnect/qcom,sm7150-rpmh.h           | 150 ++++++++++++++++++
>  2 files changed, 238 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
> new file mode 100644
> index 000000000000..604822ed4adc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sm7150-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on SM7150
> +
> +maintainers:
> +  - Danila Tikhonov <danila@jiaxyga.com>
> +
> +description: |
> +  RPMh interconnect providers support system bandwidth requirements through
> +  RPMh hardware accelerators known as Bus Clock Manager (BCM).
> +
> +  See also:: include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
> +
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm7150-aggre1-noc
> +      - qcom,sm7150-aggre2-noc
> +      - qcom,sm7150-compute-noc
> +      - qcom,sm7150-config-noc
> +      - qcom,sm7150-dc-noc
> +      - qcom,sm7150-gem-noc
> +      - qcom,sm7150-mc-virt
> +      - qcom,sm7150-mmss-noc
> +      - qcom,sm7150-system-noc

I don't see how you resolved the warning we talked about on IRC.

Best regards,
Krzysztof


