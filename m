Return-Path: <linux-kernel+bounces-69766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 736F6858E37
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831141C21167
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B871D527;
	Sat, 17 Feb 2024 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yuyn5Zg5"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE91CFBE
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708160370; cv=none; b=a2a1QalHI+nVRnMxr5HADgMD+ZsmmprjtrjGahmbKHvbT4wXB/3Z5SmjfTcuFIT67wIR0FpbqWgJFIe7rFbPW+Pk01xlOe532EkdfIePHsyZfgT/u/Kis6+sdD2eHPoStSeFxp6n6StBqO1OF31qWY8UIqYx9r1hDZRUYBBm0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708160370; c=relaxed/simple;
	bh=8InsxmqfZQLd3ulUQG+LgYVSOGcEOWqATZfF/M1PPvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fb1Y6Q00gxnXw7uBAvIGajXwPde6fdx2ruj0mlkRSPsulAVOpKvCZhlJ10b/p3IqKqTlWf7nw8+ninfPt4tBcW/RokC/jOpx18G5S5IxlF/3RnxvptKrRs36vQShzTmD6cUOx244vgfD+nRaYs4+2TEEOpHzCVETlQkhePP7B2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yuyn5Zg5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5610cc8cc1aso2997134a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708160364; x=1708765164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPnF2UnPEK9IopO1lZfk/F+3jdw5LhE9uXdyHqBy+ZI=;
        b=yuyn5Zg5lWDhujZrTKEC5HvpLrPXy5R7TbI1jP+W5X+QHy1jGFvsCXaM5rjSJHigRG
         BSyuQON42dRNHCRe7QmnzL9E+B6psU/mCKCkCjuoEfJYkZwYKzTGlBqDPEq+yyMvHtcy
         E5HxuWcvEbj+HSuIOOlR36qJ6WJrSRkpalxuSrcxRcNQhMJ6eWNQd32JIuXlzIXUV6o+
         RQqXieeI7tlhQV5M+cQWR75RNtFezCbiGb9tgZ0ZkNSUZyUUUpId18LmuHLCNa41A/0M
         DRc+/gT9ZSipbTGLbr4igJmX12RchCPsD9Om4yTjH96mKmNNFsJowsJ7Z36R+icziEb1
         Rarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708160364; x=1708765164;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPnF2UnPEK9IopO1lZfk/F+3jdw5LhE9uXdyHqBy+ZI=;
        b=hnHB4vBJ2qN2LOLg9xgPEILStEqF61Royu2p+MZGOHYNWCDTzjZb3S+iYH/eAzOjIq
         NGj+KsHVeCrQzecHpbcZZc/oQCQiNEiRBne9yr2ake5FA3yLLDHzrZvLw8PiIdIwmlAz
         no9mUzfxNNsYaXUi+81Kyvy2ey03j/TmZJXLWib3nde7UcDeAIgNuJYQucU5FQnhdhej
         6F9RLAcea2MLVqdEqlBKPn7zZbJYWrvTqoBh/NYIWUk39wlZYlFTVcU/j0H2Oxw26liF
         WRj3R13cXcZtmjXAYFllGixLDBbJmvkAXr8mG/u92elpxkfN0jnaGCEGNBLUxcDhECwU
         nSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAQRUItHwIFgyjZC4yHBW0Ki8HE4nIq7TPcZZ4SMwBrY6UCjJnFFtXscW8PPGb4DVXgBTvTYsUsRo41oGEVry9Ss77K+Ig8omE8JpY
X-Gm-Message-State: AOJu0YzHH3FzwRHh4ruK6mNQmRUKInZWXMMS+hK96SEeDhQrnNuS4B3/
	sLYpOc6HjhVvJEoRUWiQ0R9YmIPtcizRGykEuQudG3xHEQ/67ttul1oglASk75o=
X-Google-Smtp-Source: AGHT+IEJJNi24rvq8c+17CsSj00wltExN6m9dkDzjM34Q4qlAqXsV2T+AbQAwFRXvvCQzFUQN/ZZ2g==
X-Received: by 2002:aa7:d0d6:0:b0:564:1884:76be with SMTP id u22-20020aa7d0d6000000b00564188476bemr891326edo.39.1708160363803;
        Sat, 17 Feb 2024 00:59:23 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id e9-20020a50ec89000000b00563e425da56sm711139edr.85.2024.02.17.00.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 00:59:23 -0800 (PST)
Message-ID: <eee8e6f8-9efe-466e-9e5a-de5a9378ae71@linaro.org>
Date: Sat, 17 Feb 2024 09:59:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc:
 rename to hisilicon,hi3798-dw-mshc
Content-Language: en-US
To: forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>,
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com>
 <20240217-b4-mmc-hi3798mv200-v3-4-f15464176947@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240217-b4-mmc-hi3798mv200-v3-4-f15464176947@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 22:02, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Add binding and an extra property for Hi3798MV200 DWMMC specific extension.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  ...-dw-mshc.yaml => hisilicon,hi3798-dw-mshc.yaml} | 23 ++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/hisilicon,hi3798-dw-mshc.yaml
> similarity index 73%
> rename from Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
> rename to Documentation/devicetree/bindings/mmc/hisilicon,hi3798-dw-mshc.yaml

Keep the old name, we don't need to rename the file for each new compatible.

> index f3dc973cb490..26d7f4be965b 100644
> --- a/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/hisilicon,hi3798-dw-mshc.yaml
> @@ -1,10 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>  %YAML 1.2

Best regards,
Krzysztof


