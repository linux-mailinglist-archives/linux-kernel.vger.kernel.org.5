Return-Path: <linux-kernel+bounces-70916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B07859DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CD41F232A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA7A20DFC;
	Mon, 19 Feb 2024 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VayQekPn"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB84720DE2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330518; cv=none; b=SvflGykpgYeT3v0J5zbnvFd+I4EkBvK+b1HmrEzEGH7GprUGikl9ajSMMJdarJDQYXoBjrXjypqwt2Bx6j53j1Us+3Kl8sy/Q3X6fgSSoQxsbZ3T7liwBVK4iAK9B8mEQp9HGXgjd5wkR0weWw6A9X0sJIM7mMwaF2ijQUg/FCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330518; c=relaxed/simple;
	bh=vMLPhu8yoXICkNXnspLUV8Xf92T5AQe3Rrj+u9I8dEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZ3Vs1z3mk/HbEoVMU8FPJgwLoCcCRgsOjJ/kOzs9pfsguYAEk1YEag9PfxC5bqB2safqT1GKOtscSDahU1mYffHgKE/GSrSP8nPt6zxIqE6QsWf0e/S3QbGwWJercCwnOtPaYELE+lSSg+5IQr27Wiq+nhDtD8mO2MWzKzvulI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VayQekPn; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d204e102a9so51567391fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708330515; x=1708935315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3K4ad/Lfv3ZGBwgn4i0F+LzMaTVaDUBN9X1Fxu1n0g=;
        b=VayQekPncPeLcXbjyRJd78emcD5kUuNV/YQ52kxixLhkQ6q+fq7ZbnEV8YFL5pzLy4
         bI+kPTClSpDqeQieFwzrD1HvIz3DVp8kiGkob2UHttR6kRuaPlTI3yRN0fsbfI8Yb3QO
         Gi+8G0oiTir1sBKnoVwMdeuRF7ZVCZnrMaRQj4+YcdYxHqJxjbucqeFM7IIGuVz9quN9
         BSiRxczaq8yKuUlwqqwLKLDsIKOQwEtO2Tuyygvtjif5HkRM5TqPgAfaJVq/IEtlTjOA
         V1jn80fY21s2aHtkJAvBnUCsWDtHngekL1AgsCCXfEu7tuI13swDJ2fc1b7ftyYPG2wv
         DZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708330515; x=1708935315;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3K4ad/Lfv3ZGBwgn4i0F+LzMaTVaDUBN9X1Fxu1n0g=;
        b=Qt62PD4yy9/etpgmSiZZX9n9oBGZcRMSk/tBxI7M5yb6qMLfsGzEBSvcZ+nKVk5Oms
         /ASJGSbH7CR5eWLZ3KrFx4EHakeo2yoK8Ki1td5VF0ZvI5F+2Pg6uFQoQZk+SVFDPRrr
         7EcukDF/z5BaoevHlSDARBH0NqQSBZUBWGLT6b+O60QfabECtz3YppD4HuI24NNSQ9rK
         yIZCoLxRPzj1FcAdYH0/UQKFJZ5i3A+dMyDfmxMeVoLOQgbIgwKHHkAKBxStBq3aeus9
         e4ghA7IghvyiioBUeuRl+7Usqj3co4OUEgNzR9d3VxVsT0KfqGZWNsIMCiMqxF3UYtUK
         pQlg==
X-Forwarded-Encrypted: i=1; AJvYcCU3vlS3q/E9bJPzRRYxlpFqxTrhrJzy9+q7Zw/afkbCkCnJo+n7rEMrIRpoM4Qu5HWM8ZTbmWRVoEPob2dYwImr4no3Y2Xf62VqJwPe
X-Gm-Message-State: AOJu0YzWs78ftvKtcopJ8YJHfvTLS4QngSL+8A/L21S7WPI2t/zJb3Lm
	U2wg07kdZAJAocskG6bVNwpC26e1c8bm1xPfxwWhJxiGHTel78vBQwE6x7wGk00=
X-Google-Smtp-Source: AGHT+IEuOAHkitTHG/a4+gR94ZjXAK2+gibe1H7tHVtJLlvqP5qJ0LnqwheyMUbCWA45h6juT09BtQ==
X-Received: by 2002:a2e:9197:0:b0:2d1:8f:d2ba with SMTP id f23-20020a2e9197000000b002d1008fd2bamr7046504ljg.23.1708330515136;
        Mon, 19 Feb 2024 00:15:15 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id co22-20020a0560000a1600b0033d2848046asm7075888wrb.95.2024.02.19.00.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 00:15:14 -0800 (PST)
Message-ID: <28ea8dc1-302b-496b-a3b5-6e7f9382b0ca@linaro.org>
Date: Mon, 19 Feb 2024 09:15:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: rockchip: Add Toybrick
 TB-RK3588X
Content-Language: en-US
To: Elon Zhang <zhangzj@rock-chips.com>, heiko@sntech.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: weizhao.ouyang@arm.com, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
References: <20240218065407.652213-1-zhangzj@rock-chips.com>
 <20240218085314.658223-1-zhangzj@rock-chips.com>
 <20240218085314.658223-2-zhangzj@rock-chips.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240218085314.658223-2-zhangzj@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2024 09:53, Elon Zhang wrote:
> Add devicetree binding for Toybrick TB-RK3588X board from Rockchip Toybrick.
> 
> Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 5cf5cbef2cf5..d29df97c7b25 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -878,6 +878,11 @@ properties:
>            - const: rockchip,rv1108-evb
>            - const: rockchip,rv1108
>  
> +      - description: Rockchip Toybrick TB-RK3588X board
> +        items:
> +          - const: rockchip,rk3588-toybrick-x0
> +          - const: rockchip,rk3588

Assuming you keep it in-order with existing ordering in this file:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


