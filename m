Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA25479E6CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbjIMLcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbjIMLcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:32:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B01173E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:32:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a645e54806so839351366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694604735; x=1695209535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5j+vOlqz3f4oxafJPXTsw7TQpxVIHCk4693pzx0c94w=;
        b=j5zsfOwwFvT0XBAEEnzwdg3+Juy6FufuPTuUSRSZUxFkHpsyIVxRow7RFRXmJMhvwy
         mXNffXJ3s+xyyTChSgiVQQNL7WK/FZfkFY9fEb7Gwo+NfFadVmTgqzqk6ZGWSk/y4iSd
         JKmYrnSg8w0ntigiOoHzf2fVugEBs8I1TTYH0QLc76pv0K6ELcRxIMdZ98Ic90dNaHVS
         StqAWt8DhIW42BabvecYxiTkRYfXOK5hHEUi/wPyhb6K9cOdBDW+Cor0EArGuH1wXRB9
         XdhXAgtzqOs5c5ndl0tCgVZqp30HlmBw5exnZdW6OjfhbSu0cVydFQW2+xf5AB47nS+P
         lCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694604735; x=1695209535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5j+vOlqz3f4oxafJPXTsw7TQpxVIHCk4693pzx0c94w=;
        b=YXmIeWgWoW1e3C+HYokJzMpmfJtaSRGTrDLVg1ILTIdOAfrzYNE4R3lvTfoOG7YWMn
         er9LimKi+4vrTyp96tGfRHFrw+zHEoFaOaP/CEEjbrxfkn/k8CCKW04dSiBsIGYhqMwR
         4RI6/UWUqkVR7zkN0TF/vfxbF4adB9tBl2x9Yot/lBM/6QU5bpXAZplywYRZRvUdphik
         EiCQcIP4xr0I3YURJ2bQrbLnyIQOxl9yexozox/o6y7gtEH985rdGj/KcYMk9Jekxxfx
         lsohEkuOkvULMzVZ9LTITNvnI0rRMvwYIzqPCOYBew2BuKaBD+ICGSMOzRRI7cla5S4L
         Z/fg==
X-Gm-Message-State: AOJu0Yzc+MbNS1/bmrqYNpfwEwMAKPTPSFkIRzOXW+kr21eDiklCQRHJ
        vZPzICxkL3wxtiQGPBb9agLtqw==
X-Google-Smtp-Source: AGHT+IFXgY8RifaZBzIgEcrovRfTJIFYuVf95XlpZfa3lhurVCngM06VSVipO+09NlPwOMdF7/xX9A==
X-Received: by 2002:a17:906:2cf:b0:9a1:aa7b:482e with SMTP id 15-20020a17090602cf00b009a1aa7b482emr1622499ejk.26.1694604735038;
        Wed, 13 Sep 2023 04:32:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090603d600b0099ce025f8ccsm8289621eja.186.2023.09.13.04.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:32:13 -0700 (PDT)
Message-ID: <052be57d-4081-43ca-6c9f-9afedb030a58@linaro.org>
Date:   Wed, 13 Sep 2023 13:32:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 1/4] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
Content-Language: en-US
To:     Hari Nagalla <hnagalla@ti.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, p.zabel@pengutronix.de,
        martyn.welch@collabora.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20230913111644.29889-1-hnagalla@ti.com>
 <20230913111644.29889-2-hnagalla@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913111644.29889-2-hnagalla@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 13:16, Hari Nagalla wrote:
> K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
> The remote processor's life cycle management and IPC mechanisms are
> similar across the R5F and M4F cores from remote processor driver
> point of view. However, there are subtle differences in image loading
> and starting the M4F subsystems.
> 
> The YAML binding document provides the various node properties to be
> configured by the consumers of the M4F subsystem.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
> Changes since v1:
>  - Spelling corrections
>  - Corrected to pass DT checks
> 
> Changes since v2:
>  - Missed spelling correction to commit message
> 
> Changes since v3:
>  - Removed unnecessary descriptions and used generic memory region names
>  - Made mboxes and memory-region optional
>  - Removed unrelated items from examples
> 
> Changes since v4:
>  - Rebased to the latest kernel-next tree
>  - Added optional sram memory region for m4f device node
> 
> Changes since v5:
>  - None

Hm, why none? There were errors in the binding to which you did not
respond. Did you just ignore them?

> 
>  .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 136 ++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> new file mode 100644
> index 000000000000..21b7f14d9dc4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,k3-m4f-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI K3 M4F processor subsystems
> +
> +maintainers:
> +  - Hari Nagalla <hnagalla@ti.com>
> +  - Mathieu Poirier <mathieu.poirier@linaro.org>

Are you sure Mathieu has this device and is a maintainer of this device?

> +
> +description: |
> +  Some K3 family SoCs have Arm Cortex M4F cores. AM64x is a SoC in K3
> +  family with a M4F core. Typically safety oriented applications may use
> +  the M4F core in isolation without an IPC. Where as some industrial and
> +  home automation applications, may use the M4F core as a remote processor
> +  with IPC communications.
> +
> +$ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
> +
> +properties:
> +

Drop blank line.

> +  compatible:
> +    enum:
> +      - ti,am64-m4fss
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  reg:
> +    items:
> +      - description: IRAM internal memory region
> +      - description: DRAM internal memory region
> +
> +  reg-names:
> +    items:
> +      - const: iram
> +      - const: dram
> +
> +  resets:
> +    maxItems: 1
> +
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string

Wrong type. This is an array. You need maxItems instead.

> +    description: Name of firmware to load for the M4F core
> +
> +  mboxes:
> +    description: |
> +      Mailbox specifier denoting the sub-mailbox, to be used for communication
> +      with the remote processor. This property should match with the
> +      sub-mailbox node used in the firmware image.
> +    maxItems: 2

You need to describe the items instead.

> +
> +  memory-region:
> +    description: |
> +      phandle to the reserved memory nodes to be associated with the
> +      remoteproc device. The reserved memory nodes should be carveout nodes,
> +      and should be defined with a "no-map" property as per the bindings in
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> +      Optional memory regions available for firmware specific purposes.
> +    maxItems: 8
> +    items:
> +      - description: regions used for DMA allocations like vrings, vring buffers
> +                     and memory dedicated to firmware's specific purposes.
> +    additionalItems: true


Best regards,
Krzysztof

