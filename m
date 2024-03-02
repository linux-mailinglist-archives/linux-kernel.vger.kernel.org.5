Return-Path: <linux-kernel+bounces-89453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BE386F094
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF623283CC0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 13:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9EC17BD9;
	Sat,  2 Mar 2024 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xCquQX63"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACA17BAB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709387986; cv=none; b=rNXFEr22WBM5QtEOsEnyMaNlwp2aqMzQ1EcqjoIfELidLJjW6Wun0Nj9xjsZtzgjHF2t2IzksxG4s4VnHwZETaYwj3Ym5fpFwL2yLHmjw0cwhZXk29+UuCta/yobwtPTOTf2mHR5MwhfElZwmst6OfY6rZNu1vzaycMt3LOf0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709387986; c=relaxed/simple;
	bh=ytYwRlSFsq4Rpg4+XTxJGMB16Nmqe+x03a7CtTu4qYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPTWjfvGME42Pot9E0OGNvlFQG6JqenncZ+FAm1jpDtmO8GDttqK0nnkXBNffLTXwaZ/a1hkHdVvqrTk1ufWvgjZKHh48G9bkhPHfz6G8G//KeMpvgtBM7F2P+BZJ0FHrtd7zMZW6hPx0txCuzvs/Po0PvF5ChPy77iHBVTTZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xCquQX63; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412dabe26easo1459425e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 05:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709387982; x=1709992782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z2ATSc579AxmexsuG13YAb1qbi2nF1oW29/Ts8WYULM=;
        b=xCquQX63UFlDEye6wnbsfVo6cPu44NE/6tLe6Bwdf1nfiZsGbS6pjhCKnZhpaD/K2A
         2pjlkGmihcMtYjoaO1K/pW5a2BE7XvRl34DkqpoEplv4k50xHX0wMYr9I686FOeOs35P
         M8dZO4ylixLsFUUybqOLnOvdIsal/78wVHbogluiW3mLllKnl86rpvoz9rj4MJzMD8xX
         C73soSCE8cGfyKsGg1ViikNodIgZb/Zpnwz7gTNfNRfGmZa7HB5aV7gDJxnWSdqIqWon
         VJZnLFV58umYrgf1AficBhvTqMZUJ4Fu9WO4eaA46XLoeu7rfRHYjedCo0gpqC0V8ynq
         2v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709387982; x=1709992782;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2ATSc579AxmexsuG13YAb1qbi2nF1oW29/Ts8WYULM=;
        b=urnbCIbw9tcPdyzz17U2NhFL8JTtUkDGMjcUS6AlfmZrsjHk9/DjXWSXg9DFk/qMqu
         i3avT5dkSuGuWi+PGcF0me7H/GgwRO6zSitrUfPTly9wRrd581g7dteqEG6JwDWxmAUl
         eX6IRBqJmkEnG7VJy4wLzp+BESWTvbkqawSN9gJI6DMFsZI0oWAcs/bdCwQl5LXAgyDc
         fNGwxdwEEozkUuw6qMTYBY5YOWUfFrML0wMGeYdrCJbxJljzLezdBWbtDviu35glfx3J
         bVSIxrL396AlfdE2gBch0X6qJfR/5w/Bqu2L2ZsMnUVFgp6ezO7E76ir5mYV+bSQvCPc
         eHDw==
X-Forwarded-Encrypted: i=1; AJvYcCXyg1teEGuIW/NY253tSFQgoqvnFKNep0szVouso0DTZ/OXwFrSadeVI5ccao/bMq/1UN3b/P9H1A6K+sLTQCwJmdPlkLICi4IXgTRh
X-Gm-Message-State: AOJu0YyxNdnTTI4aE4isOHgosD0Wkrk5J3otfba7Qd/QDdtPxyi1OBIe
	DjhlReJhtzDNCkh1FDuT28Mv2w/xWhAwlVRbvJ19SZ3+CBB4Dd2WyvgylKGvouM=
X-Google-Smtp-Source: AGHT+IFTUYzI0LLkvJu4+nlfioe2GMj1QikEFf1Qd1aCCira9vwa1aikQpVcwSh7HYu4K+/F0xziog==
X-Received: by 2002:a05:600c:35cb:b0:410:656c:d6d with SMTP id r11-20020a05600c35cb00b00410656c0d6dmr4263924wmq.18.1709387981645;
        Sat, 02 Mar 2024 05:59:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b00412cbe4f41bsm3714036wms.4.2024.03.02.05.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 05:59:41 -0800 (PST)
Message-ID: <885501b5-0364-48bd-bc1d-3bc486d1b4c6@linaro.org>
Date: Sat, 2 Mar 2024 14:59:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains'
 property
To: Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, imx@lists.linux.dev,
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
 peng.fan@nxp.com, robh@kernel.org, vkoul@kernel.org
References: <20240301214536.958869-1-Frank.Li@nxp.com>
 <20240301214536.958869-2-Frank.Li@nxp.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240301214536.958869-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/03/2024 22:45, Frank Li wrote:
> Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
> it.
> 
> Fixed below DTB_CHECK warning:
>   dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v1 to v2
>     - using maxitem: 64. Each channel have one power domain. Max 64 dmachannel.
>     - add power-domains to 'required' when compatible string is fsl,imx8qm-adma
>     or fsl,imx8qm-edma
> 
>  .../devicetree/bindings/dma/fsl,edma.yaml         | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index cf0aa8e6b9ec3..76c1716b8b95c 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -59,6 +59,10 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  power-domains:
> +    minItems: 1
> +    maxItems: 64

Hm, this is odd. Blocks do not belong to almost infinite number of power
domains.

Best regards,
Krzysztof


