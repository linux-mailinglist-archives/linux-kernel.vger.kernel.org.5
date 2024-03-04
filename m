Return-Path: <linux-kernel+bounces-90169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB0F86FB5B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45A1280DEC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87812171C1;
	Mon,  4 Mar 2024 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zobjKhBx"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE96E171A9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539915; cv=none; b=WLUNgwNDKeudhwE4uDGKwcRHZZbmEvZSWsiSYaGl2AY8I0XSG8Eh+kaIEj3T3EN3r264xpla55aBK+GsBF1ewRMdapmX7QpQahL76cHlQw8jKkgEKVFcaBNt/GLMKmWLRnRPGkOC9SjZy/XRYQHthtRVEdX01b2NH691CGzAAWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539915; c=relaxed/simple;
	bh=shEtHItvivagarjJTiE6fGeKZZ+g9u9mXbVqtVe6uOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPJwlQlOF0neSSQmBOebeHmIfyW+v4AwbZKyUFTdDti2FY/eUGE6OP8r3AV3J6jxheIT8Yitvy4Msz9DhabGdfkHwXjSlsRLW1eYXKpVjBeaGYKU8DCr6pMkVmyKkvXvlUCpSGI0jbZmCGxhlYSaZ0fSqLcbfWnRWq8fYJsA39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zobjKhBx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e444c202fso78045f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709539912; x=1710144712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PuGYwI8XWNcdtH5o1abzcPhx8A0mjNetGD+1BKOovGk=;
        b=zobjKhBxvG6E+Bn1eAtP9vva8qBvwfyCVW6ve6Z7pbZI1pJNkDmoaZR7Sxjal0W3cP
         3pr7Djt0GWs572seWR5+dNYPtPiRTHRDblJKlvZy5kYW1RRpiuo5bRJxg77LsVMmiC1o
         wF94GgVt3Qu6QQWa9hTB0POM9rxSaHMcJHTuwwYAzrcJX+bt0iv4VwaS0oa/wnAmgALh
         33Ta6JYbTYsZEYBb33CptyGrRxnMA3WRZuCMmxmcxyXiZ6KcswAsh/gVKG2UqYswNY2J
         48j6uetxIEGiu7Du3VQEJZbOy90zthMLbJly5VA8KtpiUf5fXQHVHAVpR6Qqw1qGeswG
         LNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709539912; x=1710144712;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PuGYwI8XWNcdtH5o1abzcPhx8A0mjNetGD+1BKOovGk=;
        b=brhdiKpZZcxybEJbag5MYVdEH1xfbklwxqAoMyyRcorx+AdS/ti16SawYylNC1MS8A
         0KsugVpJPJiXlX6Ef9ZKbgshwpXw8dGRD0eO+A3NyCxN8eIvmcg1wArMycjhiKtIxWRH
         m7BA82JmbRGKIzj8gCnpY2jAV3nlgAUApzwHfVfr2YWqDBCN1mNoNW/5gVXCs6J/c198
         ijWzfRq8QgxlHULtoZJYzuNCo6b4RbUYoh8lMPJO5EytD50EXudsto84wmsQVp8XbYmO
         WrkIfhULBJ7adbskhNuXjMFDZYCux4pMrDj2fmf4mKRi1i7j3xW8g8ayPjwtrtI2Brmp
         YqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBDsZjhYSGhTjlCouFXlPJoLycvlNaOtOrAoYbWyORtc3zlmivwMUZXU0POHTKJfiZZok5U3chlBsaUE7qZYaccKcvLTMwgWMV0axu
X-Gm-Message-State: AOJu0YzPbTzCYrMP7Ws6+jVZ87tnud2PqhDIGwksTj5OwQ+16V8ZbSwl
	AgqqZPzWk9Ad62OcyJBvZAI3dG2wfQxQPwhxJYEh4RtqO0FmfexdRuoU786lMNI=
X-Google-Smtp-Source: AGHT+IE1Qtnzv6QuEZsAk4wcrJFACFpPoafoXnJKgjkFkkmeQNqjsjRbk2WzsTz2qTNdVa7sL4jlWA==
X-Received: by 2002:adf:9dd0:0:b0:33e:1ee0:6293 with SMTP id q16-20020adf9dd0000000b0033e1ee06293mr8143843wre.14.1709539912363;
        Mon, 04 Mar 2024 00:11:52 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id b7-20020a05600003c700b0033e44b23921sm117559wrg.24.2024.03.04.00.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 00:11:51 -0800 (PST)
Message-ID: <7c3c578a-d662-4485-ad15-47250ad0e935@linaro.org>
Date: Mon, 4 Mar 2024 09:11:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: add Canaan K230 boards compatible
 strings
Content-Language: en-US
To: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
 <tencent_D5188EA5B85A31AC21588DBD7C7482ACDA08@qq.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <tencent_D5188EA5B85A31AC21588DBD7C7482ACDA08@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/03/2024 14:26, Yangyu Chen wrote:
> Since K230 was released, K210 is no longer the only SoC in the Kendryte
> series, so remove the K210 string from the description. Also, add two
> boards based on k230 to compatible strings to allow them to be used in the
> dt.
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  Documentation/devicetree/bindings/riscv/canaan.yaml | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/canaan.yaml b/Documentation/devicetree/bindings/riscv/canaan.yaml
> index 41fd11f70a49..444758db964e 100644
> --- a/Documentation/devicetree/bindings/riscv/canaan.yaml
> +++ b/Documentation/devicetree/bindings/riscv/canaan.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Damien Le Moal <dlemoal@kernel.org>
>  
>  description:
> -  Canaan Kendryte K210 SoC-based boards
> +  Canaan Kendryte SoC-based boards
>  
>  properties:
>    $nodename:
> @@ -42,6 +42,17 @@ properties:
>        - items:
>            - const: canaan,kendryte-k210
>  
> +      - items:
> +          - const: canaan,k230-usip-lp3-evb
> +          - const: canaan,kendryte-k230
> +
> +      - items:
> +          - const: canaan,canmv-k230

Why this is not part of previous entry in an enum?

> +          - const: canaan,kendryte-k230
> +
> +      - items:
> +          - const: canaan,kendryte-k230

Usually you cannot run SoCs alone. What does it represent (in real life)?

Best regards,
Krzysztof


