Return-Path: <linux-kernel+bounces-97973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1874E8772A0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C1A2816A5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450272C84F;
	Sat,  9 Mar 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLAfKz/S"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169425765
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710007694; cv=none; b=owpm1hCB/d+O6WgK/rU0M7ngBkHCYundnassEgfUuHN+r/VS3skjp1zTo2UkSRLQJkOf2zqb7ONJRtSWH1iLANMsKcIlk1iSCNV6C+4hGgRi6V7/1GNt1LczDkjMnYIl+H5Z9tDoqCHE/TbohVyobOuPl090cL9pZbKcEgiX9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710007694; c=relaxed/simple;
	bh=ix8UDwm8cWDgt6gghk4+sBTO9vEfAEMGgkEWTx5Y1g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nC+Ug7AO2uGFVwWh/YHLsWbXTE8iKYe3WdnLdtiq318Ic2iiaqXVS3qkSTf62piJFwV0rEFMtjVZZjLf+LaZIe2zQFM8UBdVoq6aKQuBaI7bTQD6tvNXiVW/t2DIjpboM74Is8vvl3u+bevq5wxsDN/2jpF96F+mzMeSx+aCUsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLAfKz/S; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513a06ef9b6so405378e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710007690; x=1710612490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h1piW7BqBzP6rwvrpwmztPkmci8B3hn3dS9ZvXEzVJc=;
        b=tLAfKz/SQrIc61E7L4975SBj+CHNzeWGP7QiRERfOWr5BxYYNOkjcw+W3YCTqmDb81
         IrQAl5s3TpaUlFR2z3q305xNFb6aDVfdNy62kKyDO95Nf21q4pbO4mQWtGhz8eOYE+iN
         QslTA6BNzWWxFD8mBbOrLtR3T8muHylVUYuSmGJ18N/H6NeBEJ5UoYgs3VQu13neReAP
         0MK5iHuMvaTDpEN8g/PfeKFprLCdTtvCm0YCCIwgz+cyMV89Ahp0w4bY4L16shD7JLv5
         lZxnNwnq/12OzGXjmKO+qJqlGvJQ7VZmUJuLGW7mwt2l2cGvz5XPVk6oqfLXaB5zx+rQ
         couA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710007690; x=1710612490;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1piW7BqBzP6rwvrpwmztPkmci8B3hn3dS9ZvXEzVJc=;
        b=J6pzYDzTLuYDnQQ/u5uJC+emm/yr+9HQdoFpkSnpbC/qx2Esva6uT4hxv2H5qNxPN8
         Ex7RIB2MiB1C0vCxth9pk5zJjkDEPleqzs9a4St75KBmsppPSMvP7cPF8ThWPlBrORKz
         0CodNGFMGFIXXOIXxmCvfaRCFQj83CwL1hjQAJ6sUrTJNycL5Vpnbuql42p0NyeeqcbX
         FkRjsE04//Wude9dmfFv1WvULmp73FsSH+IuuyCiNkyRMaE2sTLhZnFJ5MyRP1xjaacQ
         HCEsJBJCpS3Py11UUCGhPKPa5Ezy2ZMgapm170vmwn/ZnXlt5q8yk+3bofanFj3j/IZW
         iLHA==
X-Forwarded-Encrypted: i=1; AJvYcCWnQgu7aTbckoEirWnWFE2POiucLvsOohrWv9tXSWqyuskGsxgmmbKOOxtGcAjBVSnzlOnsaQar2343hTIzGb9cgx3VOyYt2kfz+ZTk
X-Gm-Message-State: AOJu0Yz2bLDgkm9fJV41L1R+KMWxa4YNo5Vhec0m1srWx+B1cxttRW/A
	xxYFAPdsQj4gSyqorXJhdKJkVqBQYACskSZfp2f10wQgULC8YsTMf1sy9jfp4KQ=
X-Google-Smtp-Source: AGHT+IH2NGZX0bGwm4MV6ZNN1D9Sa7rmWuHU4YKX9t+Rz6eLynsHR651N4AEj79qjOR6cje1xg8PBg==
X-Received: by 2002:a19:6901:0:b0:513:3483:e727 with SMTP id e1-20020a196901000000b005133483e727mr1432024lfc.48.1710007690403;
        Sat, 09 Mar 2024 10:08:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b004131d2307e7sm3231563wmq.12.2024.03.09.10.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 10:08:09 -0800 (PST)
Message-ID: <a26689a4-1c8c-4458-bb82-137cd1ac21d0@linaro.org>
Date: Sat, 9 Mar 2024 19:08:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: imx-pata: Convert to dtschema
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240309160741.54096-1-animeshagarwal28@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240309160741.54096-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/03/2024 17:07, Animesh Agarwal wrote:
> Convert the imx-pata bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
> Changes in v3:
> - added fsl,imx51-pata in compatible property

Please explain the differences done during conversion in the commit msg.
There was no imx51 compatible in the binding before.

> 
> Changes in v2:
> - fixed style issues
> - compatible property now matches the examples
> - fixed yamllint warnings/errors
> ---
>  .../devicetree/bindings/ata/fsl,imx-pata.yaml | 40 +++++++++++++++++++
>  .../devicetree/bindings/ata/imx-pata.txt      | 16 --------
>  2 files changed, 40 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
> new file mode 100644
> index 000000000000..265ea80434e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
> @@ -0,0 +1,40 @@
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
> +          - fsl,imx51-pata
> +      - const: fsl,imx27-pata

This allows only imx51 and disallows imx27 alone, which is not what old
bindings were saying.

The best if you just test it on DTS. Please run `make dtbs_check W=1`
(see Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

You should see two warnings for imx31 and imx51. You need imx31 as well
(and changes against pure conversion should be mentioned in commit msg).


Best regards,
Krzysztof


