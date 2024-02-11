Return-Path: <linux-kernel+bounces-60778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E8085094E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA261F2183A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5F45A4E1;
	Sun, 11 Feb 2024 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUry67xC"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D12FC29
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707655711; cv=none; b=j0XGbW2NQP1EWmacPiAuzWRk3DPVOJrRnoKcWJ4rzG0N+XCyhYoZS/pnaAJy+49+PrPtzjB0/e1H+TQbuayKQQF7Ayn6YNP80UPE7uJFa8vWykTjj8X89ktSDtVpZ0WnW91HiIUuYheL1WAVrg0PgDJVaRjP6M6XBJe4k3Y15SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707655711; c=relaxed/simple;
	bh=cLEjnhmgemjxazMRt9ScREUGdT40Z/YyIMHg8MzxN0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lufd+2gBeUaFdzS+HFapN2lGaohlkR6pTgaWJ8yh7imIpM/CrCGIU8OBN5/VkiVpVWL9CFwBi3fJDr+3asEkUbzNcVQzVRHWFIf1r/xCURe7n1WRb5bOYnsfCOskxGkBTLs1KOpqdTf6UHPJObkBk13rW2lv2A6kfegxy/x0HHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jUry67xC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33aea66a31cso1319041f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707655708; x=1708260508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=znJM8EqOqe1L7/rkdj8Xx7X6DuCSHarpq2A8jLyK3gs=;
        b=jUry67xC19hLdv3T17GWR4bJA/lUaMHlEhqjdkpDjbzm0FyroWGuL+0dHS16j50OtY
         bK/ruR+84FepMh9znrXDUni0rs7/AsLfbBjXifdkzvV8DrUngCniop+DI2L4Cq9w7Uie
         aOR6guu6v43EyzXiNvp1T7Telf1VWRKIvoamIBZIjUR91sELmOYDvbnijbK/oAHMQYhk
         gZlMYt8N2pa1ikjYDl4Q81B8sOCCo2wrFzU1rYWDTte5G+ZRVvKyfV7VxnFtF2gyaYqG
         itrFpy0uFQFvL7PKQsqToB1CatxcBp3cD8gGPLVkl4ItxYiryvokdz7LY3eLjfHBFBOP
         /W9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707655708; x=1708260508;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znJM8EqOqe1L7/rkdj8Xx7X6DuCSHarpq2A8jLyK3gs=;
        b=sIeGsmF8nYkZGIxq7WiuE0ha1tF+KEtG1xN4ufTpukiw+dbq4VC1F0anmJVsykctkz
         5MuxXHxZ+wFdSfCR3WBu5QY1FV2kqMrLJ1s3dzU7TmdgDgXjJGKViGuRfJa04hBl2l82
         KsRI+rwll3tHxOAlq/SAOj2A5u+JydvOlqMZK9+cg+w0JKuT+C7+Dv0PqEbldxVG+sKq
         WwD99iMMnPKo3EoYpaTuR9gafWmr7Zb7Ih7tL9hIsXuoou8yB0wn4LgVyDnlHe+U3GoN
         A4O+0Cdqj4qdl8Fx9bectFbAEo/Umobsq2o4lmZfLl8OfYieJoIu7Qoy4ljosmH+u3vL
         838Q==
X-Gm-Message-State: AOJu0Yz/8Ue8Gh5lfuj/D1H29K54qFt37x66W0iNaNe+Y7gYGYi4bh6j
	r01nYsomWc1UplQRVPTI9pCntpBUy437/mdyArDdFa1ThGOCIod1o3GE9JKHuAw=
X-Google-Smtp-Source: AGHT+IG0KvjrcWX9fP8EQ7HuGQT7UlKwD3xHYnV+wAFvwQFbH2rlerUWOPvJcpstaxqHN/9pCfSgcQ==
X-Received: by 2002:a5d:634e:0:b0:33b:3586:86ea with SMTP id b14-20020a5d634e000000b0033b358686eamr2844726wrw.13.1707655708140;
        Sun, 11 Feb 2024 04:48:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoOEFsSssgrbStB3EW7eXoUW80jldlyeWnTVJIQwpmM6LWi+46AHiWkqjrn+p3Mt1geEmKA8OElB4t4goKhXrsTk70S0kEzNiQzzTPDV4RZ9MqbQZaC8F7epV1wdfd3dKEuVnfaNGiMKqybduQT3kyY+SdRE6WJVUxJcx4v87JiYGkHj2MolrfM/QV+Irharq+WrRO26RaLMKX+o3zgcnNaCFaEeVHOElUSDSOrGd/1KzWYIp8Xfm7EJuacQfPucjDD3BkLYbKauuOHh14RiFaPBCqYk7sMzgubaQJ5jDJhClcA7LhPXiXVwpPPwDsBUhLfY2jl03Rs4t/+FBui+4zAna9Lxyd5ZDP5WGPOuPsKREkYwiMoFV8pkPhYGrMFvIRypwaEMwcSjGWjzdNjQiO4KZ7o5GSfcDnQ30GESkwFoJvDXi0LHbcfCdxQuMio4GwTshZ+o4+qVRDZOMBOzjUPynAVm6jml0PNFzRuIzzu+RpVt+YDZph9Bg2uiO+IvaTG9L9rZmqT+x7UjaMqV3oRBp+pgiRYFJB8UUqTpVkgc9obOw=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b0033b2276e71csm4192345wrq.62.2024.02.11.04.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 04:48:27 -0800 (PST)
Message-ID: <6312cdd5-ae58-4d6b-a89e-58a70a1ef5c4@linaro.org>
Date: Sun, 11 Feb 2024 13:48:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/14] dt-bindings: fsl-imx-sdma: fix HDMI audio index
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Yackavage <michaely@ips-yes.com>
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-9-sre@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240210012114.489102-9-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 02:18, Sebastian Reichel wrote:
> HDMI Audio has been added to the DT binding documentation with an
> incorrect index. DT and the driver use index 26. This happened,
> because the binding is missing MULTI_SAI type, which is using
> index 25.
> 
> Reported-by: Michael Yackavage <michaely@ips-yes.com>
> Fixes: 7bdbd87d4008 ("dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema")
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


