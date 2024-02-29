Return-Path: <linux-kernel+bounces-86295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE33086C38C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261691F25867
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48D64CDE5;
	Thu, 29 Feb 2024 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bcOIu+kv"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57051EA7D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195631; cv=none; b=qVSDbUHic5GP8h4BbrV+rZCdAS/3IGSdqMAd2+vKMvW5+D+NMwwaikKbz4UNzjWvammp/8ipKbrUswQAZQpBFR8JqHlEvcOwVjGtK2roHNx1Ow80Mg8rYdDK9x49WKqLqPpuiUUjLuwujgwNgGow9KaRUhoDzWXoIppDoXM3a78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195631; c=relaxed/simple;
	bh=90z2sa1ZfZfW9YSdK3CkEFLtQvGFbYf3YRjvNp+8JZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLs+y5m34lazldFkV8IJgrNcz/AvI8Ca9RsYkcyXbaBY1Wd67fQprbL5OwJoZk5QjenWLAEGLJOhG2dk+QeWWr5LuprYsV6VNrv0mH+OnSjm6E1smzp7wKyaRvXZJOjEYZ78e0b3xKIrDsIXT9P8CDmedzZZgkkjMQGwUKjpnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bcOIu+kv; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6096ab005c0so3307867b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709195628; x=1709800428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=837J79ZQSddskmgCAAO5FmkY0ihPzUclUe3cZWzHeBc=;
        b=bcOIu+kvbmw6lm6tluGN7lImzU0+AmKfldz7SbwsBrpvjIiUuMvLZOadaTgDwFRSL/
         d/mYSiGD0E8oIQUTnveKdYmZ8ABQ9sRV3nyJGon2pDtGhkGkTsoKJMewRD/KjAnNfA/t
         F7sm0qJb68IwU/8u50bSB5dsYgHNkDRF3QhVmsqCas8VddlTNTFl+XbBujzCOsQ0U3d7
         nE+NQrQprK5OPIrwtVU3sO3RT63lmn2gI7/XJw2X1cIIDtZJBPB4inzBC19X7U4orzvb
         YSBpFTG2LtPjAYVnWAxqJTSZX0rHOVWKOXU23cmwHX6zJ8XlI7Ksi64qgWq8V8RkB0G7
         SUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709195628; x=1709800428;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=837J79ZQSddskmgCAAO5FmkY0ihPzUclUe3cZWzHeBc=;
        b=qh5a48q9RgB22NdGjVzaSzzUJartEQNdkrFxRBdNTKt7mxnhruQrHVgg0+iLW75DCO
         tsKEhFVajWhzbMr0RMdTIvboV/0RAkK8rudaw7IhlyXTY+57jV0jrcYf8VfR57R66fte
         efLqsSHvedoZvGdUo8Ht7LMKsqyFIjf0VELcy9XffHx/I6MLx3PrbiK7QKQlG52IYkeC
         48CVSoArrtKZZ1MJJG/pBSvjN1ufNC+/o0LAoCjwQ+1BJUefZ+qAafR+cUVfY+tNvfDL
         4GwWjt1A8n/C0fgZox28oGG7PZzqTEv8bHKETGn4/Ei5pm2CgzoaPSIVLi05S423/NuV
         3wVw==
X-Forwarded-Encrypted: i=1; AJvYcCVFTM/iQ+tsJZue5Ctornk+IfXnmebLmxWcxKWQgKR99x68ne/CGLjU1wL+rLA/YubLlqFzVyuAjPKrP+kp89HnOcVgSGgSeLuoYak7
X-Gm-Message-State: AOJu0Yz4Qr/7CvHwOzyZo4BAMPUQt+MbgbqPC8KtIUuW2KSazs1EfxD1
	0YUT+9FLVimGLSK8TTLYM0WvIB4961CASagd6TONSIPjfLmb/HB4N6b/F3+i+hA=
X-Google-Smtp-Source: AGHT+IEFsXXKqZ4x1g6UUSotDzPs4EaRNV7EfXLIepVz9PCWrUB5SUJUiSHxrIv36Zw9aW7Eyk+0Kw==
X-Received: by 2002:a81:490f:0:b0:609:3958:7121 with SMTP id w15-20020a81490f000000b0060939587121mr1757947ywa.0.1709195628583;
        Thu, 29 Feb 2024 00:33:48 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id i68-20020a0ddf47000000b0060969b6e74asm248178ywe.123.2024.02.29.00.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 00:33:48 -0800 (PST)
Message-ID: <7c167fac-46c0-4d7f-b56f-ff1922736aa5@linaro.org>
Date: Thu, 29 Feb 2024 09:33:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: interrupt-controller: fsl,intmux: add
 power-domains
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Linux Team <linux-imx@nxp.com>,
 "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20240228213808.632603-1-Frank.Li@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240228213808.632603-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 22:38, Frank Li wrote:
> Allow power-domains property for fsl,intmux node.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,intmux.yaml    | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
> index 985bfa4f6fda1..d73d9a6c50a69 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
> @@ -37,6 +37,8 @@ properties:
>    clock-names:
>      const: ipg
>  
> +  power-domains: true

You need maxItems

Best regards,
Krzysztof


