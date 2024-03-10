Return-Path: <linux-kernel+bounces-98145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 274118775A5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 08:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61BA8B21E08
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E93111A1;
	Sun, 10 Mar 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUJRpCpP"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862226AC2
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710057094; cv=none; b=YY8yTCNUNVnbWnRojMLZmFPfRvn23j51c/nro2G8SnRpwMQ398LKkNTTCmbyh3AZMj+K5CupDFLzRG1be5l87KQivqlH6eD+lzXZElKrCF5EAtUXkJVaeiImUp4qgHoF6bc/MHSN+X4Eo9cn+9zrUpJUS+f132gZro4ZuNOhZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710057094; c=relaxed/simple;
	bh=w3TVGs4O+3tfbHuJCY7WBmDJj5YrHGDsQ7zq9RM2Wh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jveVEmKAJ2PiWuPuSvehGswT9nDFJL1V0RrMmpJCk+pcsL5HeP0t980yXTIBYnV7koWiAAo82Vzh19RwSW7PaUmATpO3SOhkNmG0HA1uN+MFhpvYhlI53xzGAgZ0cMhKworxpvtLzDWu2HWYW68muWO9hTu4DnvDVfNVgrM8VxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XUJRpCpP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e92b3b5c9so175304f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 23:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710057091; x=1710661891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8W33mbdiTYPC2j+P1szavj2IqjGiZrZ00GeDRBGX+is=;
        b=XUJRpCpPT3SZCkj4xd9Iyv35BKiOgRzkQG7T2a01RJuO/WeCFMe+OZtv+rMAzCowUz
         ssA7ZdEpXkfqi4LWY2ydUSwGOwycbJbYTe2HXh2/ODITJp9Xb1zgqOdq1qVQn6qEqTvs
         DITAHqoiZ7nU3RR2rkMzj6Og6si5no3fZF+nOz8yhlcqysnUIhpPbm9NGWLczol6xtG+
         Ramu+yHUpMBv6aNYwDwAn0kvIk3eTruqVL6lH35n4aa+6hm0RxMU8G3GbDqjfy0Toxhr
         X4unhHGGaSSijncT8udcUURnF3HRpUP7Cp7jRAOanKvDaUAaV3sT8MmxVVuONCZ6yD0r
         /aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710057091; x=1710661891;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W33mbdiTYPC2j+P1szavj2IqjGiZrZ00GeDRBGX+is=;
        b=pVokXSbwC+OtuszoLX9KGHvPS5Fs08rF9OTcew2slGll4QP4NVsMePcf6quA7UsZ1a
         7CaKmMRwStkLTzHw9GFqP4D1oHeqJVfKzwmv+1Ce7h3wtUz6Lo4FFyI/fXIYakj049j/
         O2U72qszo283GBZZ5VU2JbdhKEoqlLQpu7ZrxpgLSZiIBktmvC5l78waZdMKcbzQF0H/
         F0CSUzlwuqL143ORAXGEyfxEghw8hWgCLAJHn5UPGS8DWf668jjZMDX1UPJno6dp5rNA
         TKpfJvpMfuZOG/KQQ6N/PaboqoRaGp/XByyDBrT9l0ctRiDbTm2BHWtp0XeqFMzLmMuC
         A1EA==
X-Forwarded-Encrypted: i=1; AJvYcCX+SRhyAlrZJ1Rp7v2/+GGjMqLQRTBYa+Wfz8Xy0qx7VOXqXVQ6fdoaw5BQ0MBiCJlWp0AhIzAzIQULPjDPDDZ5tHP7uNDVRfbTPnRE
X-Gm-Message-State: AOJu0Yy7QA2gLh8jF3y5A7XA6O+Nw/zcb5uxIzlU76AZI/9cjjoh3M83
	jOEMKOZSQpuwxlCTpD4q44dg7xd3w+7p2wJNC06JbBUpdIX3jW+xDJRLKFZ17Z4=
X-Google-Smtp-Source: AGHT+IHEuiu03OT9ABhnilYjcbvKL3LinzMZbFYJYEzfv9igKCe2RyewD2QYZErERDM1sOOmht5XsQ==
X-Received: by 2002:adf:e510:0:b0:33d:26b1:c460 with SMTP id j16-20020adfe510000000b0033d26b1c460mr2581781wrm.39.1710057090808;
        Sat, 09 Mar 2024 23:51:30 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id bw4-20020a0560001f8400b0033e2777f313sm3512812wrb.72.2024.03.09.23.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 23:51:30 -0800 (PST)
Message-ID: <8a822699-aca5-4bcd-9bbf-86104a98f3f8@linaro.org>
Date: Sun, 10 Mar 2024 08:51:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: imx-pata: Convert to dtschema
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240310051914.153193-1-animeshagarwal28@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240310051914.153193-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2024 06:19, Animesh Agarwal wrote:
> Convert the imx-pata bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> 
> ---
> Changes in v4:
> - added fsl,imx31-pata in compatible property
> - imx51-pata was not defined as	compatible in txt bindings, adding imx51-pata ensures this node	compiles to imx31.dtsi
> Changes in v3:
> - added fsl,imx51-pata in compatible property
> - imx51-pata was not defined as compatible in txt bindings, adding imx51-pata ensures this node compiles to imx51.dtsi
> Changes in v2:
> - fixed style issues
> - compatible property now matches the examples
> - fixed yamllint warnings/errors
> ---
> ---
>  .../devicetree/bindings/ata/fsl,imx-pata.yaml | 41 +++++++++++++++++++
>  .../devicetree/bindings/ata/imx-pata.txt      | 16 --------
>  2 files changed, 41 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
> new file mode 100644
> index 000000000000..aa0174844eb1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/fsl,imx-pata.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX PATA Controller
> +
> +maintainers:
> +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,imx31-pata
> +          - fsl,imx51-pata
> +      - const: fsl,imx27-pata
> +

How did you resolve my comment about imx27?

Best regards,
Krzysztof


