Return-Path: <linux-kernel+bounces-138162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88D089ED80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9AF1C20C86
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381C713D535;
	Wed, 10 Apr 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bz4z88D1"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A310713CFA1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737455; cv=none; b=TGYenJjx3WyT7QtsXH7k59CoSZ85Pw54GsFktWbtoSpul2ay6BlFB/l7zbby+lK2FLZ8PzcycFpgv5AUa+0D8NM/a93zFPHvAIxqcr2Ju12ZmOcYmAgngoBdSELTVbVOs6RFuvWuSO/4tbLs7jSxnd3EpZ0q6sObcwZiPUY0tyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737455; c=relaxed/simple;
	bh=QZJ4A/EixpFW4L6UFzffUAX2kcgLP6E7AW8tr5vkcO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4f4SF+KiH0qTEAE83LI2S/gUokRwGBsKXVsQheiPw8Oc48TIuWPPsx3+QnUbbvtUvkS8cIk6dwjMRJSVJt5N5XxcthZekkh0HS3g/83RBejyLftRGPQe8JpypwQ+DqQ9KI0L0WVgypGivNQQ5ZUg8p2Wy95FpPpAoVBw1DgjCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bz4z88D1; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516dbc36918so5024165e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712737452; x=1713342252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=osmNZYYHYaoEiq+e67YvU3I3gUGFZgWJO10fvS2C8yE=;
        b=Bz4z88D1I/ExagKq43DVhb7k+94mn+dBuomETJiPL+zkLnKNkU4Pr+5jw7BoHuhN9S
         pX8lhT+i8itpwNNIVKcT7f+sFovN+EIgJoNlbfZlqErhMEInFki6LPCx3lQm/0fDfIdj
         T+oCX9S9SHuCM8c21raJREjOL9UI/nugyxgyCDh4DQ3SVqOn9B8ettdSSKtvd+zXjQxU
         x2Hp3jr4MUtqviU+EfsnHGdH2skm0LUvOsHfcj7wXRigbIuInIy831VR9FD2smj8LJmo
         SJdqGSVQjs6m2Dt1tjZ19G/9P8woFXC4yXXynglB2h7qzmzZNGT3oSpZnfQ4PVF8cWrW
         6WHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712737452; x=1713342252;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osmNZYYHYaoEiq+e67YvU3I3gUGFZgWJO10fvS2C8yE=;
        b=P/D3SAWcf3eae4O64mjpV8inm+Xzexr1s8iaOMcRVXliZ9A8iMbZPo4ZwPXW477d6d
         63iZkPmdrEHw5qlZJbaSKLanyuJWBZItNxBGz51ewdp7sLMIX35mcBehuyIPQc0EfWrx
         8OKXv8tNTrir+sgPwETXkOKytdqhbIR8q4bTcT++rIyNwHd79+9LXAQZqXDR29Tmbk60
         6R6t4GWDieLBv1R9WJF+VT1XSc3sEz2oyy2c5B54dm5bPKmfA1dKo8QGYhOiIXUYp6tb
         JlYx5R4/l8LPiLrqLUACnSwqJ8WgPQv62VS4zp5L2q9XMT4Hvyi6UeSqRGFOVzDrrxS6
         cJQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWrYL9SxsmzEPNadbVh8383EP/Xy02WYQbOOmS83OCd1YC8//lB0BPQs2TWOMTyHauLGi3Kdl4efwLEaUB1WRwJhFl03Pg7P4VBjoQ
X-Gm-Message-State: AOJu0Ywj8K7l+mG3uX/fHfaLMp29qLmDVbM+hMYou6VzaAitLct+m0tm
	3wqdSCQ+lyJT8O8ZXWWWgHl8R09Y4C7zReH6sJrST9davYfyhjoYmwxqsUlMmCY=
X-Google-Smtp-Source: AGHT+IF2OCwswt1+i9KeBPeDbtBitGS5VonfN56UIgmfBsfMaitIK3KbAGQPkkbcAY5c4anGR4DiCQ==
X-Received: by 2002:a05:6512:2824:b0:516:b07b:47b2 with SMTP id cf36-20020a056512282400b00516b07b47b2mr1422553lfb.44.1712737451821;
        Wed, 10 Apr 2024 01:24:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id el1-20020a170907284100b00a51ce6730b5sm4221466ejc.84.2024.04.10.01.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 01:24:11 -0700 (PDT)
Message-ID: <9731687d-b239-469b-b014-dfa5d58a0ab3@linaro.org>
Date: Wed, 10 Apr 2024 10:24:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] dt-bindings: display: panel: Add compatible for
 IVO t109nw41
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, sam@ravnborg.org,
 neil.armstrong@linaro.org, daniel@ffwll.ch, dianders@chromium.org,
 airlied@gmail.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
 <20240410071439.2152588-4-yangcong5@huaqin.corp-partner.google.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240410071439.2152588-4-yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/04/2024 09:14, Cong Yang wrote:
> The IVO t109nw41 is a 11.0" WUXGA TFT LCD panel, which fits in nicely with
> the existing panel-boe-tv101wum-nl6 driver. Hence, we add a new compatible
> with panel specific config.
> 
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> index 50351dd3d6e5..f15588a2641c 100644
> --- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> @@ -38,6 +38,8 @@ properties:
>        - starry,ili9882t
>          # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
>        - boe,nv110wum-l60
> +        # Ivo t109nw41 11.0" WUXGA TFT LCD panel
> +      - ivo,t109nw41
>  

Same problem...

Best regards,
Krzysztof


