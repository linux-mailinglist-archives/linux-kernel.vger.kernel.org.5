Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB77F781231
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379151AbjHRRk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379193AbjHRRkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:40:04 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4B33C2F;
        Fri, 18 Aug 2023 10:40:01 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so17832251fa.1;
        Fri, 18 Aug 2023 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692380400; x=1692985200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBqiuE1W/JJkU+Tq/bgiu3Be54o3xfgf8EPQHSsbYvE=;
        b=BE6OaS94KC3ES1uLbXhuynhUsT43JlDerMghFFjqIBLZRKj3V6ayVWQjeDeSF0fpIM
         m1eWPzhApnMgn2BM6oKkZASsKq1b5exbcw4gYIBhdWwkF8rKGj8MEfH5soKjOGHwvkBH
         mAfzprqByd9zneoNWzFx/Ilo9cqeQqsSnY4MRvX0Vu2cU7Xx0oY05D7X2WveFD/gsJlR
         lEa4a7PRqZP2059Wln0pRUKBOXPlsyu0IBwJ1zJGV2sIs7DDdPCTtl6wlpdeVRM8IyYu
         6IfzJRkMFBJCXIhh68jJB25BDm0d2oLGBtuGWLVWq9h+yrKU8goCbjPLkk7OVurTkGYA
         BqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692380400; x=1692985200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBqiuE1W/JJkU+Tq/bgiu3Be54o3xfgf8EPQHSsbYvE=;
        b=OxFsUSL8HA+HrmtrTYHLW0ydIyaAyqelarCYhEWIxOWOOFSP/5plN1fxox9CSvgy9y
         aGmHz03jo4s3ZvASTCxiHAaXSUaGR3Hsa8Nf+MVqOxv6uf5z3GMxCOGPBw2uexbgVrMa
         p/sqD7i66Q2x0sF0JE1+zk8XCQKX//6yrLH0HQIIu9NaToNHNtg6DNcSpwm7/44s4xGp
         KQBo7iabUvI+Ep7M2P7g5JJ6p/5Xj7v59K5i6cJCrvYOo6BIvQL8B7DARXXovpHI0XGC
         aaN+pThJHgEcbeIK9EF0fok58wfTGUEhEaqhUrPs0SyipWzv89dYmXguDGbYA/vR+cmf
         eeAQ==
X-Gm-Message-State: AOJu0YzrWmncDgo5yam5AwJQGl6uKTmUXhfcPn/ZnYHliTuKN6AxMJII
        Syv1HVF44/sg1Ok9NdFwP3U=
X-Google-Smtp-Source: AGHT+IGK+CdeoXcBxxlJm2PEhmKHd4mivKEyLJ33UNYeWnW7bCiXLwfuHFYfdl82c1rbMIs3ytviaw==
X-Received: by 2002:a2e:9c55:0:b0:2b9:eb9d:cc53 with SMTP id t21-20020a2e9c55000000b002b9eb9dcc53mr2439249ljj.42.1692380399736;
        Fri, 18 Aug 2023 10:39:59 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id v22-20020a2e9256000000b002b9f4f3e16dsm546065ljg.85.2023.08.18.10.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:39:59 -0700 (PDT)
Date:   Fri, 18 Aug 2023 20:39:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v5 6/9] dt-bindings: net: snps,dwmac: add safety
 irq support
Message-ID: <wkzy3v272ia237pfhlvtrwbij7qeswb2zmkxhnsir5xtroezr7@frow2mvqeq35>
References: <20230817165749.672-1-jszhang@kernel.org>
 <20230817165749.672-7-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817165749.672-7-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 12:57:46AM +0800, Jisheng Zhang wrote:
> The snps dwmac IP support safety features, and those Safety Feature
> Correctible Error and Uncorrectible Error irqs may be separate irqs.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml         | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..ee9174f77d97 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -103,17 +103,26 @@ properties:
>  
>    interrupts:
>      minItems: 1
> +    maxItems: 5
> +    additionalItems: true
>      items:
>        - description: Combined signal for various interrupt events
>        - description: The interrupt to manage the remote wake-up packet detection
>        - description: The interrupt that occurs when Rx exits the LPI state
> +      - description: The interrupt that occurs when Safety Feature Correctible Errors happen
> +      - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
>  
>    interrupt-names:
>      minItems: 1
> +    maxItems: 5
> +    additionalItems: true
>      items:
>        - const: macirq
> -      - enum: [eth_wake_irq, eth_lpi]
> -      - const: eth_lpi
> +      - enum:
> +          - eth_wake_irq
> +          - eth_lpi
> +          - sfty_ce
> +          - sfty_ue

IIUC this would mean the next constraints:
Item    0: must be macirq,
Item    1: any of eth_wake_irq, eth_lpi, sfty_ce, sfty_ue
Items 2:4: any bla-bla-bla.

After adding the per-DMA-channel IRQs in the next patches the array
will be extended to up to 37 any names. It doesn't look correct. What
about converting it to the position independent arrays constraint:

  interrupts:
    minItems: 1
    maxItems: 34

    
  interrupt-names:
    minItems: 1
    maxItems: 34
    items:
      oneOf:
        - description: Combined signal for various interrupt events
          const: macirq
        - description: The interrupt to manage the remote wake-up packet detection
          const: eth_wake_irq
        - description: The interrupt that occurs when Rx exits the LPI state
          const: eth_lpi
        - description: Safety Feature Correctible Errors interrupt
          const: sfty_ce
        - description: Safety Feature Uncorrectible Errors interrupt
          const: sfty_ue
        - description: DMA Tx per-channel interrupt
          pattern: '^dma_tx([0-9]|1[0-5])?$'
        - description: DMA Rx per-channel interrupt
          pattern: '^dma_rx([0-9]|1[0-1])?$'

    allOf:
      - contains:
          const: macirq

Hope neither Krzysztof nor Rob will be against such modification
especially seeing it's the only way to resolve the very much possible
case of a device having macirq and per-DMA-channel IRQs but lacking
the LPI, PMT or Safety IRQs.

Note 1. I've changed the name of the Tx/Rx IRQs to having the "dma_"
suffix to signify that these are actually DMA-channel IRQs. The MTL
queue interrupts drive the sbd_intr_o signal which is tracked by the
"macirq" line.

Note 2. I've reduced the number of DMA Rx IRQs to being up to 12 in
accordance with available to me DW XGMAC HW manual.

-Serge(y)

>  
>    clocks:
>      minItems: 1
> -- 
> 2.40.1
> 
> 
