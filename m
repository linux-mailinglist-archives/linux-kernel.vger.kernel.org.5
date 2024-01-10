Return-Path: <linux-kernel+bounces-22799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EB882A30B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D782F1C22444
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06C84F5EA;
	Wed, 10 Jan 2024 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/Nab8d+"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F52E4EB3A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e43fb2659so41970145e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704920779; x=1705525579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpzmoubksARMqXWsZukQ4nFns/a5KbT0VTwgd0T9PkY=;
        b=S/Nab8d+Da3dYMeM4BwzcKNJ61ltINBrb0dclk4w1RY0oWmfjFONlVbmFTmwv2n4qj
         43MsOYJnsZgCESOjKLNe1P0pqFWoH5Fi8ON0KJofFKv5j6XHIpJzo0ODXSGICuddCDqf
         7fFrHU7c22s9RLxFo3SUTcPZh/foXsPaFW8rnMX5nS0wJW9FQmUveIkf7av3xrkPNPS2
         lUDKNATsyzRd7sru+meWg8iMIh74ZG/YhX8pLohYiEGzMP1nyrIQDAeq0khlRzsUVtBq
         pnhpfpgzneHrdPU0Smp+WFQbpmYqV3FWYbXyH3uHlkNkegwcf2eKiYUL1Xmry+9zKCeU
         F6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704920779; x=1705525579;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpzmoubksARMqXWsZukQ4nFns/a5KbT0VTwgd0T9PkY=;
        b=cRYv2Wqde8Sh5i72MstAItCpF8qtlOK+Pe5JQO3F3v9hmwbNjfqZFuhWgvpFzYIRnU
         Ah7a67dVHqamm/B44a8e2SHu2463qMAKMBOdmybvygdeBcKuwrhgQFDpXNwLETm60akq
         emkJt26OQvVhVW+G0IIMvLwjCj2tqzB4TWeLUv1kqtkAisKcDSFQJZuWDeCR3Z++7+DO
         3Wmxk1t1Gq6QUtkAyxbKxwctsMfYmYVs4dwKTBPAb7cNKzpthu2TbFe4R9zbEacsoDfk
         SR4AaEC6VezB6t/EJe5DuL8FdkTgVmTETX+fwgIyY/lOOWxuL0Jk+hTUX99IMiJtrQ5R
         ezrw==
X-Gm-Message-State: AOJu0YwzDmCdJUCqIK4InI8UVnOyzOtSsId67xsqwSxQPMpBJ7IuC1xJ
	JJWOVFdWFkL9txq3MUNi/1mLd9ML4f/wvQ==
X-Google-Smtp-Source: AGHT+IHFlGncNfu3SoO22D0r5KNlYwKxq23l/A6Gmfh05kYV75OIftfz8SEsujeKzXHGaaZ4YbD6CA==
X-Received: by 2002:a05:600c:4fc5:b0:40e:556d:7885 with SMTP id o5-20020a05600c4fc500b0040e556d7885mr20137wmq.165.1704920779512;
        Wed, 10 Jan 2024 13:06:19 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906329b00b00a1f738318a5sm2424226ejw.155.2024.01.10.13.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 13:06:18 -0800 (PST)
Message-ID: <78b8400b-806d-4e8e-b7e3-582b80aff4b2@linaro.org>
Date: Wed, 10 Jan 2024 22:06:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: cdns: Add properties
 to support StarFive JH7110 SoC
Content-Language: en-US
To: Shengyang Chen <shengyang.chen@starfivetech.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, tomi.valkeinen@ideasonboard.com, r-ravikumar@ti.com,
 aford173@gmail.com, rdunlap@infradead.org, u.kleine-koenig@pengutronix.de,
 bbrezillon@kernel.org, changhuang.liang@starfivetech.com,
 keith.zhao@starfivetech.com, jack.zhu@starfivetech.com,
 linux-kernel@vger.kernel.org
References: <20240109072516.24328-1-shengyang.chen@starfivetech.com>
 <20240109072516.24328-2-shengyang.chen@starfivetech.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240109072516.24328-2-shengyang.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2024 08:25, Shengyang Chen wrote:
> From: Keith Zhao <keith.zhao@starfivetech.com>
> 
> Add properties in CDNS DSI yaml file to match with
> CDNS DSI module in StarFive JH7110 SoC.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Subject: Make it concise, like: "Add StarFive JH7110 SoC display bridge
or something".

> 
> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
> ---
>  .../bindings/display/bridge/cdns,dsi.yaml     | 44 ++++++++++++++++++-
>  1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> index 23060324d16e..da091e105794 100644
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> @@ -16,6 +16,7 @@ properties:
>    compatible:
>      enum:
>        - cdns,dsi
> +      - starfve,jh7110-dsi
>        - ti,j721e-dsi
>  
>    reg:
> @@ -27,14 +28,20 @@ properties:
>            Register block for wrapper settings registers in case of TI J7 SoCs.
>  
>    clocks:
> +    minItems: 2
>      items:
>        - description: PSM clock, used by the IP
>        - description: sys clock, used by the IP
> +      - description: apb clock, used by the IP
> +      - description: txesc clock, used by the IP
>  
>    clock-names:
> +    minItems: 2
>      items:
>        - const: dsi_p_clk
>        - const: dsi_sys_clk
> +      - const: apb
> +      - const: txesc
>  
>    phys:
>      maxItems: 1
> @@ -46,10 +53,21 @@ properties:
>      maxItems: 1
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: dsi sys reset line
> +      - description: dsi dpi reset line
> +      - description: dsi apb reset line
> +      - description: dsi txesc reset line
> +      - description: dsi txbytehs reset line
>  
>    reset-names:
> -    const: dsi_p_rst
> +    items:
> +      - const: dsi_p_rst
> +      - const: dpi
> +      - const: apb
> +      - const: txesc
> +      - const: txbytehs
>  
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
> @@ -90,6 +108,28 @@ allOf:
>          reg:
>            maxItems: 1
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: starfive,jh7110-dsi
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +          maxItems: 4
> +        resets:
> +          minItems: 5
> +          maxItems: 5

Missing constraints for xxx-names.

> +      required:
> +        - reset-names
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 2
> +        resets:
> +          maxItems: 1

Same problem.

Best regards,
Krzysztof


