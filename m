Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B9A79AD60
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350258AbjIKVgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbjIKPKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C4FFA;
        Mon, 11 Sep 2023 08:10:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B2AC433CA;
        Mon, 11 Sep 2023 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694445000;
        bh=HBK913hbzSRgMTx4gQeXjHRhatWJrh9efNenYNX4HvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWCISGVQTm+q4IZ0aIgoiBhr0vMMgWqKcq6/4A/0XFK+f8gvISxV56VsG3PCFFdB3
         cHEqBxscq6koa28/cAEzJ6KRNdbzw/LVspl2gBCvYdKsn5a7J88Mgh3Pc0a2z2h/CA
         5tQAZG0VuwL+hM48f0osvnjm2G8rPdX/6HDIwNaxBuFiKn5ayFZvfKx3+CZplth6ul
         9uJc2Y4QxOfr8ygilTH2YRDGpyL5Sfwa+coHnnMNJAl7b06sGk+LC10jduURemQV5L
         VsC56QP3mubqcxk9J+tnfVHXhZLNTSH1L0E2PEAH0+IA+gq5k5YQD23IKYygQ54Z5w
         yRRhLWeX0mr3g==
Received: (nullmailer pid 1259085 invoked by uid 1000);
        Mon, 11 Sep 2023 15:09:58 -0000
Date:   Mon, 11 Sep 2023 10:09:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] dt-bindings: rng: add st,rng-lock-conf
Message-ID: <20230911150958.GA1255978-robh@kernel.org>
References: <20230908165120.730867-1-gatien.chevallier@foss.st.com>
 <20230908165120.730867-8-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908165120.730867-8-gatien.chevallier@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 06:51:17PM +0200, Gatien Chevallier wrote:
> If st,rng-lock-conf is set, the RNG configuration in RNG_CR, RNG_HTCR
> and RNG_NSCR will be locked. It is supported starting from the RNG
> version present in the STM32MP13

This should be squashed into the prior binding patch.

> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>  .../devicetree/bindings/rng/st,stm32-rng.yaml      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rng/st,stm32-rng.yaml b/Documentation/devicetree/bindings/rng/st,stm32-rng.yaml
> index 59abdc85a9fb..0055f14a8e3f 100644
> --- a/Documentation/devicetree/bindings/rng/st,stm32-rng.yaml
> +++ b/Documentation/devicetree/bindings/rng/st,stm32-rng.yaml
> @@ -37,6 +37,20 @@ required:
>    - reg
>    - clocks
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp13-rng
> +    then:
> +      properties:
> +        st,rng-lock-conf:
> +          type: boolean
> +          description: If set, the RNG configuration in RNG_CR, RNG_HTCR and
> +                       RNG_NSCR will be locked.

Define the property at the top-level and then restrict its presence in 
a if/then schema.

> +
>  additionalProperties: false

Did you test this property is allowed? No, because additionalProperties 
won't work with properties defined in if/then schemas.

>  
>  examples:
> -- 
> 2.25.1
> 
