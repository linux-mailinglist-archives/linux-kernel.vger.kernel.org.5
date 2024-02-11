Return-Path: <linux-kernel+bounces-60775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0D3850948
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6817AB225B8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415845A108;
	Sun, 11 Feb 2024 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQ1sEy8L"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA923761
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707655648; cv=none; b=BjnK9l6uePCKh44vgxoyoc3H7QbAPAkWdgdllXOoveKn3ZItaTYF/TpuuerSMvZB+o5TJ+C/yoxHOoPqVBdhZB2pdP5mDNaSHfHNjas9Nt5PLivLK02ORQlBEvbgA9VakEYwApMCbbL4tPgHgmLMMUMbY6BUJ229F6LwqVGgv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707655648; c=relaxed/simple;
	bh=G25xHqUFzksy8kb1jyALeIWZG2R9a0mTV07uXW34yk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMGe4gTSBbPDJvBlU1SIrT+mzGq/DP2ZhUVPEEjXRSXMkNi6q2uvmpN0wqfH5pVOiv8zXNCuhWhXRWs//se3NIceBCu/HdFbR33S1oI3BLWcmCbjZ2rsKam0aTcHf0aH+6Qtl/e8CTYaeTYYozZ/ypCUgNULWlKirr4zNTBX3fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iQ1sEy8L; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so1104312f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707655645; x=1708260445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuLm1mBq+YQU/C/djqzAs9Oj/JD7svM/Rt4/im8xGjs=;
        b=iQ1sEy8LPgHf9Ij6OzV6HpRS8L7dJuwXZ+s+J3+eRmBxpJTX6GikPFmAMcTVWOxlJ4
         FHf8B3AzR6Lfdh4G5P1/EEReF36SeIUprek3SsqY6TuVmpd5p8lEYNS5VMRrld/Dt8mF
         cJWvoEjQ0C4+B1l0ndByxVpwyLm0pT78QN60EE9fKkjXxZNBwsI3UD3CP11QmvPAbWNj
         V6+H1owM/TsXR6k0V5mcM4sstPgY/rAljzeWSTQdKl783DXI5pSCgeUW80RjwErhLq7P
         V/htVz9FnErgLQVNdhfIOwl9GM2GAl0Fffs1zY7nA2+jY50JzVbx5k2CyYONIVFGWswl
         Emgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707655645; x=1708260445;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuLm1mBq+YQU/C/djqzAs9Oj/JD7svM/Rt4/im8xGjs=;
        b=rxfj1w+2GkMGRGBAwBZ2MzRzgUHdNnxbUy4AVBvJa4cBB3vQnpBtTBQC7QJ/V2VTIM
         SvZbOM25/d+hIUMuYgWqeDJ+kIp8Rl5IkulHRASn/pYkBhecfFkKsMNiT0b7Mg/drNzM
         YPeTNraDyvBCNszEQQUdEb2uHUlnWkwY8Sey0reUsnRUe814/73c6R7iV9xmmMMUxh2B
         xaDVeVVjKjOwl6PpaBLxLEcxt28U3hSWEirILnU57HbJeYuMU9twMwXFKUFY9dnejz9K
         1lKbEue68to1h5TqEEUxj62ngJfehRsFfOrSn66s3vl6H8puXKdmiNYEGXL5QYHEe4Hi
         A7zg==
X-Gm-Message-State: AOJu0Yw860sml7pgmvlLzgUfvOtw+9RA49Euj8miSr/PWiMrOYOUvZN3
	JhwLrs6196G/aMgHBsP/WfTWHxoq1vF4SEDLs/UNrqyDH6MHJUCZo4hwIvDi7HA=
X-Google-Smtp-Source: AGHT+IEbMc5/xpMvyDzKivK7t4UtR/DSUuHozaW89IOzosGgYy/foWu3MRhGbmh2h7S/1qxl+GEm8A==
X-Received: by 2002:a05:6000:108d:b0:33b:4d14:2eea with SMTP id y13-20020a056000108d00b0033b4d142eeamr5268293wrw.5.1707655645063;
        Sun, 11 Feb 2024 04:47:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4dcGAfUzywa4TdAdcvxLz20Aw2Kv8Z6f1LIb3tQp5uT5LUZFGJfaF7P9PHhIYHVuiyx/TJG7ICwpnQjx0RP0lj6xkYHUQ1eWgSwauqosvpN+b+EgRnjV9fyHPqNoxZ/4odv6LzwL67R8v1qDEhKf0Ctl3ngmkkeQ0N9A1jMMfb/iUhFkmYjQsDmVOOOsDyUu/9iK9sinN75gBi5tjbJ7yO3Y28msxh/rPugif4R7AwbKvHSshUFWsU3wZsNJk/KnGJDjY9LxuDUvcvyc30KIvqMK8MeYSCDn7Y9rTNPG5A+gFOC+fLIobSlw0opB1foVr7dCzbDXYYTutBpNyiatRKFlBfngXi8qzZiah/+gf+JZyRKx+QrLZjJw8hW4UvFMhpIsI5SF/NZfjcF9ZcmeCRYNL/G5ML+85LbfM9eecNyXMh8VYr+qNo53ATxHRdiQtv0lpEUtJLN1/0VIBNBFuJK7PLCN7ltfv870ifHAARo9KFhRCz9nXUsvseDr6yPQtJ9u+D9irFCCYnV43xw==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b0033b2276e71csm4192345wrq.62.2024.02.11.04.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 04:47:24 -0800 (PST)
Message-ID: <bc73e76a-74da-4372-bb92-d52025b2b2aa@linaro.org>
Date: Sun, 11 Feb 2024 13:47:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/14] dt-bindings: soc: imx: fsl,imx-iomuxc-gpr: add
 imx6
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-7-sre@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240210012114.489102-7-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 02:18, Sebastian Reichel wrote:
> Add compatibles used by different i.MX6 variants to the i.MX IOMUX
> Controller GPR binding.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
> index 1da1b758b4ae..6f229ffe20a5 100644
> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
> @@ -16,6 +16,24 @@ description:
>  properties:
>    compatible:
>      oneOf:
> +      - items:
> +          - const: fsl,imx6q-iomuxc-gpr

Just change existing entry to enum and add it there.


Best regards,
Krzysztof


