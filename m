Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E677F0724
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjKSPYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKSPYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:24:03 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E221B5;
        Sun, 19 Nov 2023 07:23:58 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1efa01323b4so2202768fac.3;
        Sun, 19 Nov 2023 07:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700407437; x=1701012237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvBH+EWY74pgOdnostfTvFXJoA0rOQwdXiujVZ07pTs=;
        b=BgtnF7aRHB9UFtp4uF/p/XioDOed/vZySK1FS/I6vRDmgLf1vtMeG1MtWxkLH6Hvhk
         3T9IDypWc+3A+4/50ZSPzpV++kFdMMfrnJKiuYZu4ED7Shi+bwoOtw9p36PK7nqoqJoQ
         w/XjeWglXN9qtBrA4vwEOUhCRPDwiyJhO3VsaJehvpYNUA8T7LtG4RgHztgvO9ZK+oWX
         8SzcvH9mlRV1NAq3e/WZhI+gS+Fk9MWTUm7at7AJfPmaoab/MFWOIglNyiDmAKBgtkiq
         tCgvDpB0bKHbEBh8kvxUM7ZINcCPGVPlHiAywmR/nhLLBI2asjUtMfV9bpQut9NGi5n/
         uA3Q==
X-Gm-Message-State: AOJu0YxsiUUUmhFzon+u7CKbrY7kC2I4lHnOGVNZhsaZlWoDre5pNVkI
        UGv82bCBDBPQ4MlixMefBOPKFA4S6Q==
X-Google-Smtp-Source: AGHT+IGDY8KITDzwXPPX6dbv/Syq98ERWXvGlyDk+aFKC8MDHNnswIHQzkscF5GiPJ//Dn3zZ0QfQw==
X-Received: by 2002:a05:6870:af05:b0:1f4:a48d:d32f with SMTP id ux5-20020a056870af0500b001f4a48dd32fmr5682063oab.25.1700407437363;
        Sun, 19 Nov 2023 07:23:57 -0800 (PST)
Received: from herring.priv ([2607:fb90:45e3:889f:15b4:1348:6d64:224b])
        by smtp.gmail.com with ESMTPSA id v9-20020a056830090900b006d64f51a94bsm899932ott.34.2023.11.19.07.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 07:23:56 -0800 (PST)
Received: (nullmailer pid 223586 invoked by uid 1000);
        Sun, 19 Nov 2023 15:23:54 -0000
Date:   Sun, 19 Nov 2023 09:23:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     gabriel.fernandez@foss.st.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: stm32: add clocks and reset binding
 for stm32mp25 platform
Message-ID: <20231119152354.GA216405-robh@kernel.org>
References: <20231116154952.1206705-1-gabriel.fernandez@foss.st.com>
 <20231116154952.1206705-4-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116154952.1206705-4-gabriel.fernandez@foss.st.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 04:49:50PM +0100, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> Adds clock and reset binding entries for STM32MP25 SoC family
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>  .../bindings/clock/st,stm32mp25-rcc.yaml      |  72 +++
>  include/dt-bindings/clock/st,stm32mp25-rcc.h  | 492 ++++++++++++++++++
>  include/dt-bindings/reset/st,stm32mp25-rcc.h  | 165 ++++++
>  3 files changed, 729 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>  create mode 100644 include/dt-bindings/clock/st,stm32mp25-rcc.h
>  create mode 100644 include/dt-bindings/reset/st,stm32mp25-rcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
> new file mode 100644
> index 000000000000..1bdcfacd62d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/st,stm32mp25-rcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STM32MP25 Reset Clock Controller
> +
> +maintainers:
> +  - Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> +
> +description: |
> +  The RCC hardware block is both a reset and a clock controller.
> +  RCC makes also power management (resume/supend).
> +
> +  See also::
> +    include/dt-bindings/clock/st,stm32mp25-rcc.h
> +    include/dt-bindings/reset/st,stm32mp25-rcc.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,stm32mp25-rcc
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  clocks:
> +    description: Specifies oscillators.
> +    maxItems: 5
> +
> +  clock-names:
> +    items:
> +      - const: hse
> +      - const: hsi
> +      - const: msi
> +      - const: lse
> +      - const: lsi

No idea what these TLAs are... Define them in clocks:

clocks:
  items:
    - description: what hse is
    - ...

