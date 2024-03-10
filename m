Return-Path: <linux-kernel+bounces-98274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB408777BB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E195F1C20B13
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809CD39847;
	Sun, 10 Mar 2024 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSVlIGWk"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A43771E
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710091526; cv=none; b=IzN9Xj80pRzdUD9Nsy2TjnD9HOIXzvTNWLAN3Qs/4VWYaEnBDwY49SHAw30tDt4yJtkQTI2ImPShbX81ROsIlmqs8VhlRRBqpPaZTfkbLavNr1jfwk50qa9CEXeQrSkHqOEyHKddBOlUDncZ6uFvGEGs2JhIIzsiEA0vuJ9ISMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710091526; c=relaxed/simple;
	bh=66QCMff1e4Q9pmqiX59fNKSb9hFqj0MO7u2v2Hjr2qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRixcKD9LRuJUEnJUWFpjqyM06eqRoWEd58sjPohGeB+HoKQN0u+cnlUZNrumPsmRBQEsOJwDIL8xsM5YI/beKff9nQcH28VVqw5+0r/4xyrEqKzBEluDcPgh9Rjy6lFSk+RfKbCSjP4D9Pi2rgqQnZFavvbAmfRmXZCt6ygmfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oSVlIGWk; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so4168266a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710091522; x=1710696322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BE/szE4w0mwlWfHsW0GOiCR6ujpcN3AuDkO0rgustTU=;
        b=oSVlIGWkiQH3BPYG+7+aYT/hn1Gu8+KxWvxHqoFsxjgVw4brpftr5dMDeTdxpy8iC3
         hCrmei7oJLvYe2KDsHjyEOgU7GzOtKmQ5p2d7Qm0urnpPam9sLBGmSuRqlQxEbWWnwSb
         WDPnu7Ho2+Ce+N3IAQ03PKBwtJVAibpLgGn8zuUPs2GumGlO6wxbm6mu9yC0tozbqajV
         +2Pw45w5qkFwKHR3gjO9/HHZRT0HF/5zsgdUf9Z1sVyw8wc7a/uEGNJo5tv10HSebDx7
         8FTsn6ffrB5YLXz/2yPy+6dns7dR2V15kiN6B/ugufPH91DhWZPxK2+3MMx2UoZ0USkX
         9rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710091522; x=1710696322;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE/szE4w0mwlWfHsW0GOiCR6ujpcN3AuDkO0rgustTU=;
        b=R3XM3Z103Zx4NR2VcN5fwZCf7awS8G6L0dKrPDWuA4p53YP/QcKpcJdjO+GciwFBL2
         A0zDzWFpXkCFPegrFX1hTY9FcBi3QdDCniacAl6k/94avHaQWp1jZcuKH902erQ082p/
         cHLr/KzDoQ1f8OyORG99Gc8CEZT14ltbDsOmnr0VADUx0QZbYn7CYz+VfbV/Hra2tNYq
         Z8SOEK16yEvUCmqiDbuk+s3lJWLpzS2p1yNVRhog4Pnlm0BRlp+XX5Mn4KoNuF+ex5ew
         yBQBOmrPvBmlEYzbfHOTs7HaVW6emW17IaGGlYUQ2wtOSSmekAOYolt0W4eUXL9lLskr
         LDBA==
X-Forwarded-Encrypted: i=1; AJvYcCWX+gr78c9FLCb2DzpEWYETp8BAWlFTo6mu7y6ljpxGgDmvr5RfUavq9hsaVKlVHp4U9vSH3RDId8aXMTDfCDR6hwA2fumnke68f+EY
X-Gm-Message-State: AOJu0YyElA1MpTiX/B9utoeMweRnvePEwAPD+oD1gDCSu1eTj2oDeBjf
	jyZynSA6Bw9c1k3IM1L/TF3+dSKq6uUqz4Z2DC9UOjesvrPjA2HyOeI/Ax4DrHI=
X-Google-Smtp-Source: AGHT+IGz5Rz+wOc7c/GmUSJD7hqueiA5iv8MQJJ4Rs9Frkb7n1B+PRGsJJcX3G0zt1COp9+y0qa4lg==
X-Received: by 2002:a50:cddd:0:b0:566:aa2:843f with SMTP id h29-20020a50cddd000000b005660aa2843fmr3296514edj.10.1710091522394;
        Sun, 10 Mar 2024 10:25:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005656bbb5b3fsm2085830edb.63.2024.03.10.10.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 10:25:21 -0700 (PDT)
Message-ID: <2b939f61-c8b9-4b41-a319-3bf7be42ba3e@linaro.org>
Date: Sun, 10 Mar 2024 18:25:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dt-bindings: imx-pata: Convert to dtschema
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240310171958.96388-1-animeshagarwal28@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240310171958.96388-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2024 18:19, Animesh Agarwal wrote:
> Convert the imx-pata bindings to DT schema.

Same commit msg, nothing changed.

> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> 
> ---
> Changes in v5:
> - added oneOf in compatible property to allow the usage of imx27 alone.
> 
> Changes in v4:
> - added fsl,imx31-pata in compatible property as enum
> - imx31-pata was not listed in compatible in original txt binding
> - adding imx31-pata in enum ensures the node compiles to imx31.dtsi
> 
> Changes in v3:
> - added fsl,imx51-pata in compatible property as enum
> - imx51-pata was not listed in compatible in original txt binding
> - adding imx51-pata in enum ensures the node compiles to imx31.dtsi
> - fsl,imx27-pata is added as a const to ensure it is present always
> 
> Changes in v2:
> - fixed style issues
> - compatible property now matches the examples
> - fixed yamllint warnings/errors
> ---
>  .../devicetree/bindings/ata/fsl,imx-pata.yaml | 43 +++++++++++++++++++
>  .../devicetree/bindings/ata/imx-pata.txt      | 16 -------
>  2 files changed, 43 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
>  delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
> new file mode 100644
> index 000000000000..85b18d26a834
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
> @@ -0,0 +1,43 @@
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
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx31-pata
> +              - fsl,imx51-pata
> +          - const: fsl,imx27-pata
> +      - items:

No need for items here, just const.

Best regards,
Krzysztof


