Return-Path: <linux-kernel+bounces-33560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23105836B58
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76B7285BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155DC151CDC;
	Mon, 22 Jan 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BaaXSve9"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E215147A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936729; cv=none; b=mmygCtO++sVyGPAXxOeF5bkZKWyRrJjy4XzczIxCsnpKAY7p5CaUV6ngUiMOkK6TAEWgKdwR1cPqrY/Z0jJq4pLRVzSBtKUFbUaLhM2S30Ap8mAu5rnQhjuvHtSkhza25mIcU81aIPb+cNJWk1rMunJ0prT9HPJhjlSmSUPA54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936729; c=relaxed/simple;
	bh=Vcqvwo5NtvdkS3JDSuGlk6h/coXDv83EPpI3qHVo4Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XX2AsXGlJ/S/eY4Gm8Vp9ZwlvVCxYLnfW1wB5N+qV1c+M6+XjkpHrVA7EOv4kwxtrAjyHkpb3k4+JqfgJEgFP2Y4TgpRt/ratSv0gquADp4ZUDu4njoYy96Heu4SYdxZ9gRZ+fWyO07msm0IciCOpgBiTm8APgpxLwRuqTvEv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BaaXSve9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a87dfc3b5so2144464a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705936726; x=1706541526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=juFcktYimshe/ma21X3Y0f0ZmGa2eMiXpvnhhI4FSbU=;
        b=BaaXSve9SGPVUnsKBJddBFF0u/G4tfeZpXujvJt/gindqzPbtyvi8vJotqfQySnL6Z
         fftDitgtKG2Vy9Daih1lpMMTRPseQqk/fSrkYHpty99v5mNXlLFTT08o7dEwpBLCqm3F
         US+kAmPLSE6mHJyK+B+bD+cExz2tZY7v1qPBjdM+mhht9BGhst4R3DwPHqhjDMGCyyP1
         bhLokOxQoEvehex5uMBsC+23ZripgXrR0I396ZX1zTQAemRHLP+y8AqS2Abo1/VkJBzv
         b+O3OyyZc/L0HOnFbihk5aoXf2jM1GFAP9DAS+epHhRoTSEn29Cv/gafOY722FmmB4QL
         zNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936726; x=1706541526;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=juFcktYimshe/ma21X3Y0f0ZmGa2eMiXpvnhhI4FSbU=;
        b=rIBVyZNyAMtnen/XzQg4t5Nvu4PJwJswg6lj9DIeFzpyF8tksURcTXGBlVh86t/92F
         hB9tBqodu5S8Z7duZL5jYx6rK/RnfUTzU3meOtV/tMyLTDh1AJVKtnECm8T9TMf4aOkP
         gLjBwNnJ5aNURBg1eep3tb+TUlu+4SEjv4a5TZG2dX5zCkzfNzKBsE/BYp+q3cJz7M0s
         L9cTbzJuRgOrwcDbM6UnPHI7cuS1yb3ilMv6UHVC5fA94YSzngi1RHmjklgZFVYg2q9M
         OLKExYc7+/zXqtBDQ0Sq+hkSSr9TXJgsemm0E5eYhj9K8cX16Hw0DoguLCcHF1VPmVLi
         zeUQ==
X-Gm-Message-State: AOJu0YwAdHXXRaS6l2NhAFLYB7p1VE74RCkYODHGB0vHXJYnvfJeS/Y6
	OSZPbFQDsRHpdgTYaV9mFui7IwHpbhj5YeJG57kHCB6Qn2Tcy1KZsB0g49C1rGA=
X-Google-Smtp-Source: AGHT+IFjfq9d/uvNz0u23dPkvpo9/xlzK89IaTx383amNoCIUzDvY+Dy3Nvq5ExTXAkJY5/t9Go6cw==
X-Received: by 2002:aa7:c887:0:b0:55a:34e1:4d13 with SMTP id p7-20020aa7c887000000b0055a34e14d13mr42404eds.17.1705936725979;
        Mon, 22 Jan 2024 07:18:45 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id r1-20020a056402018100b00558e2a97fc2sm12735338edv.68.2024.01.22.07.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:18:14 -0800 (PST)
Message-ID: <47fb5916-a4b1-4917-ba0d-41bb7240edba@linaro.org>
Date: Mon, 22 Jan 2024 16:17:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974: Add device tree for Samsung
 Galaxy S5 China
Content-Language: en-US
To: Rong Zhang <i@rong.moe>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
References: <20240121154010.168440-1-i@rong.moe>
 <20240121154010.168440-5-i@rong.moe>
 <12e04abf-7720-4c2c-9f1f-0cfee7ba004e@linaro.org>
 <9b1c28415b5e3a5d94d167612fc0b7e0f9d0a767.camel@rong.moe>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <9b1c28415b5e3a5d94d167612fc0b7e0f9d0a767.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 15:51, Rong Zhang wrote:
> I've glanced similar dts. To solve this, I think we could either:
> 1. keep the dt-binding in [PATCH 3/4], and delete "samsung,klte" here
> 2. rewrite dt-binding like crystalfontz,cfa100{36,37,49,55,56,57,58}:
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 2bd29a2399ad..4979ccae2b64 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -223,11 +223,17 @@ properties:
>                - fairphone,fp2
>                - oneplus,bacon
>                - samsung,klte
> -              - samsung,kltechn
>                - sony,xperia-castor
>            - const: qcom,msm8974pro
>            - const: qcom,msm8974
>  
> +      - items:
> +          - enum:
> +              - samsung,kltechn
> +          - const: samsung,klte
> +          - const: qcom,msm8974pro
> +          - const: qcom,msm8974
> +
>        - items:
>            - const: qcom,msm8916-mtp
>            - const: qcom,msm8916-mtp/1
> 
> My preference is (2.) since other variants of klte may be added in the
> future. I would like to hear your preferences.

It depends whether the devices are compatible. IOW, entire klte DTB
should work fine on kltechn, just without few new devices.

Best regards,
Krzysztof


