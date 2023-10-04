Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7177B781E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjJDGpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241425AbjJDGpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:45:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB735B8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 23:45:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99de884ad25so312160866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 23:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696401932; x=1697006732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wCb9lP7uwTGMIvCNxnNt6XFJaNWP0FMMzCoWiTaUzc=;
        b=XmTvYUpo52L86IJ8K270cW/MC2VFp4gI5An7ZIWH/Pia+AMa4a01SDowowU2koFjq/
         /NkL8VxMhyTlmvVDQeUV693rahM2QKSmdqVSU4nBBChAvBE8wmzLjidym0cZ3LoRn0pS
         qzxGgLbAL8GkXVxxHFPqsTl4T/0isRliy9w73gcvxgfc5EiAMVxUa//xLIX8xxmJ6BKf
         Sn2LO3909DrkOj+G91jLyqyu7ejIRvkp8hwMtwab8mFYoSXPKQelSYS26riIjSM/ZQhw
         XxA7Pmw6Ts5cBpP9x6wP68Plr2lY4v7kwjq0irb70atE0f85oZ+ZnxxDNYB4csu0ux3b
         pCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696401932; x=1697006732;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wCb9lP7uwTGMIvCNxnNt6XFJaNWP0FMMzCoWiTaUzc=;
        b=RPd8hLVGhh0Fq+WGj4cp7IAtGHjQ/lEz5doGOrEN1EtnTE9b1motINkJuvv2jQGcpo
         3IPhmQbJautylP+tP0MCYX+c5yzxD55e4S6uItPRtuKk9z/42WeKd3X37+k+Mqhh6eC/
         r4il3qXkwppAkiYfsG1N6VnEwcQrR9rswzcu4GVlzmouHcfKhHEZCIlBWWvLEUWbuOhj
         jxOqndLaNQtWoemPUCYIetqgCnsUT4c3cZXJHfwfSWhviqWCHdP6jc2P5Q0CE4qy3TBI
         TO+GPlT1v2G6CFf60g4bNzg6HoGzpY28a6tEHy8EPPXRjtiwA/fpJuO7FVpiQIqkB0iV
         iQqA==
X-Gm-Message-State: AOJu0YzPn65dB3ce2ySTne5WwxovQaEFZ6ayj3MvTasz0dz6elPbEPNb
        FGHTKtjoN8djSy+e8VnV1fAhMfZlqzQe1tXfQaE=
X-Google-Smtp-Source: AGHT+IFVILhAcRu5ILapffojzgmNvJbTyu0ma91GZpoGx569jG6a/8hMrHhr5XNaqFvn3xy56OHA1g==
X-Received: by 2002:a17:906:291:b0:9ae:587a:e5ce with SMTP id 17-20020a170906029100b009ae587ae5cemr1117138ejf.27.1696401932268;
        Tue, 03 Oct 2023 23:45:32 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id s13-20020a170906168d00b00991e2b5a27dsm2241844ejd.37.2023.10.03.23.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 23:45:31 -0700 (PDT)
Message-ID: <43b158b2-6958-4a2f-8b2d-c6f7d3b39dfb@linaro.org>
Date:   Wed, 4 Oct 2023 08:45:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm: altera: convert socfpga-system.txt to
 yaml
Content-Language: en-US
To:     niravkumar.l.rabara@intel.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231004030723.11082-1-niravkumar.l.rabara@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231004030723.11082-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 05:07, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Convert socfpga-system.txt to altr,sys-mgr.yaml.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>  .../bindings/arm/altera/altr,sys-mgr.yaml     | 50 +++++++++++++++++++
>  .../bindings/arm/altera/socfpga-system.txt    | 25 ----------
>  2 files changed, 50 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/altera/altr,sys-mgr.yaml

arm is only for top-level. What is this this device about? FPGA? SoC?


>  delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera/altr,sys-mgr.yaml b/Documentation/devicetree/bindings/arm/altera/altr,sys-mgr.yaml
> new file mode 100644
> index 000000000000..8deb70aef664
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/altr,sys-mgr.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/altera/altr,sys-mgr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera SOCFPGA System Manager
> +
> +maintainers:
> +  - Dinh Nguyen <dinguyen@kernel.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Cyclone5/Arria5/Arria10
> +        const: altr,sys-mgr
> +      - description: Stratix10 SoC
> +        items:
> +          - const: altr,sys-mgr-s10
> +          - const: altr,sys-mgr

That's not what old binding was saying. Please describe in the commit
msg differences from pure conversion.

> +
> +  reg:
> +    maxItems: 1
> +
> +  cpu1-start-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: CPU1 start address in hex
> +
> +required:
> +  - compatible
> +  - reg
> +
> +if:

Please keep it here under "allOf:". Will save you one re-indentation on
any new variant.

> +  properties:
> +    compatible:
> +      contains:
> +        const: altr,sys-mgr-s10
> +then:
> +  properties:
> +    cpu1-start-addr: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sysmgr@ffd08000 {
> +      compatible = "altr,sys-mgr";
> +      reg = <0xffd08000 0x1000>;
> +      cpu1-start-addr = <0xffd080c4>;
> +    };
Best regards,
Krzysztof

