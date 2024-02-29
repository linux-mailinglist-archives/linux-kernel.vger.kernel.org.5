Return-Path: <linux-kernel+bounces-86901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 180A586CC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCAD1F238EF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428A413AA4D;
	Thu, 29 Feb 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecITEpfj"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F84F1384A8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219598; cv=none; b=cFKzQ85jDlXssQyvSSpBQdXDa7kWtIMD1VzZKrp5evrYUJo1hze6312PjCgTUmJek4fioH1Se8OZXOwtK3SkZBB2YMYSpBqN6yWFQcJhOm63PEhJHjg30kMLHLLHG3lXyd4P7kQ/LusLwcYSpIaOirAdthV9X4ht2URmF3wEz/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219598; c=relaxed/simple;
	bh=67SmYY4ooRGrPBgcw0OPAB3/KL/QMmEBCD+dVmFKk/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeyznZ65hgaBrsNFFUa9/THX9UhjUacT8p3KAu1grxkN13zVpgb0+niTI+6+Fv8nrZ4r2vFf+uEJ14kohgFz66K+zFcW++MqBVsbpsZGjUDbdxNh6ocSarDEUmwHG2s0UPNVpp6ONciJtHKXwD4aPHIN7MRr01xOYMz4od5VAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ecITEpfj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a441882f276so149727266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709219595; x=1709824395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmE6uQJKgk2uTSSZxs4zooHqDrjA+QjwIq4xvSfXrxw=;
        b=ecITEpfjNLQurTS9b5HhYi/JIRwnjwByp8wil7NXyMkvOV0QPQfTm2TF2Qw9Ek1BQm
         HcJJYnTieeBtRDvIbe9TapzaF5rGXgZggf8P0PU+/5zibo5sobro7jTP2EkB3CkleJiJ
         3uihMe588G57cn5wnsCKiU1hZ45J051Y6uaDoULLYqSB03xz83+eXyvj/eU/oXsXUQG3
         wJoSvAXV3V0MLVRTQBhSWGo5U/G7g0dHtEU6J9ukEeIpZetXK9lbzxedDttH+poVDXyD
         wQ2ukk2jGOLrpmgSOFrY5FfzvQDWWF4DkxKT3BuVoHeQL9ed9h8oLSs9gWXwBfvRsfXs
         vMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219595; x=1709824395;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmE6uQJKgk2uTSSZxs4zooHqDrjA+QjwIq4xvSfXrxw=;
        b=Uk7ZFEyJu7ZUMEqzrYzWHzYQlng7zwZfcIR9dS7hhME6XyjNgIyWqO026C15Plnzhb
         xt4IAYbb4HJIA3mBJW75StsvETm7Vx+KydtRrCO+KIY+cpD+ugOmXovWdRvaeYymGCTm
         ipG0mEdcCyO+4pokWmRmEUhdzqbvu6+wTG2KMMR/aU60UA9g64shfOj5Bxbcr5v+Ts4R
         THfkQBJQNH8GClC98Fc5tkot5MB2VS9EwaYVMlT9CapTfQUuovvJ9z3cJyvj7vQNPYIW
         Nfw/FGvnaqJIFuXW4xv7bI+Qse7/As9Ngl1/69Sl2RZ5F1WDH4E07Xoz+6Uyl0rzXRpy
         ZjRw==
X-Forwarded-Encrypted: i=1; AJvYcCVrv/chkPdHHfDa/zaO2kjpAVTidVDe2lD8a70T1wLyghSqPabdO1iWTN8iul7yZ1FDIfZ/fNdBuyYw468vMLOcO/YcEw1nIZVRciao
X-Gm-Message-State: AOJu0YwOi1hEdFQ6AIzTwNvY0Vq6zXTuDMAEkHK7cnp7du1k46uaV5yC
	tFS8Pcxzm70FCUUCr9z60REkdM5M9tGII26nauI2mjcTVELsbmBhGhzMcurNAM8=
X-Google-Smtp-Source: AGHT+IEb+6lFc+Mahw+UiNmc/A2MlKENND+RW37c2Ren8sFZyG/abQ+syWccXtCELvS0FUjnQW7NFg==
X-Received: by 2002:a17:906:f198:b0:a41:3492:5fed with SMTP id gs24-20020a170906f19800b00a4134925fedmr1848264ejb.61.1709219594984;
        Thu, 29 Feb 2024 07:13:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id wb4-20020a170907d50400b00a3ee5c19ee5sm769010ejc.109.2024.02.29.07.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 07:13:14 -0800 (PST)
Message-ID: <6bc065ac-81e1-47ab-9e3f-d03283e2a207@linaro.org>
Date: Thu, 29 Feb 2024 16:13:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/11] dt-bindings: usb: ci-hdrc-usb2-imx: add
 restrictions for reg, interrupts, clock and clock-names properties
Content-Language: en-US
To: Xu Yang <xu.yang_2@nxp.com>, gregkh@linuxfoundation.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
 conor+dt@kernel.org
Cc: s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, peter.chen@kernel.org, jun.li@nxp.com,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
 <20240228113004.918205-5-xu.yang_2@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240228113004.918205-5-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 12:29, Xu Yang wrote:
> Add restrictions for reg, interrupts, clock and clock-names properties
> for imx Socs.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v4:
>  - new patch since v3's discussion
>  - split the reg, interrupts, clock and clock-names properties into
>    common part and device-specific
> Changes in v5:
>  - keep common property unchanged
>  - make if-then more readable
>  - remove non imx part
> Changes in v6:
>  - new patch based on ci-hdrc-usb2-imx.yaml
> Changes in v7:
>  - no changes
> ---
>  .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> index 50494ce06d07..a4730a2393e6 100644
> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> @@ -49,6 +49,12 @@ properties:
>            - const: fsl,imx6ul-usb
>            - const: fsl,imx27-usb
>  
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

This kind of proves that your previous patch does not make sense. Why
common IMX schema allows two items, but IMX allows only one? So the
common is not only for IMX, right?

Best regards,
Krzysztof


