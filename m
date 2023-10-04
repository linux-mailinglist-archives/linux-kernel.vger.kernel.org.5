Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ED17B8355
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243179AbjJDPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243162AbjJDPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:14:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2711F2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:14:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E00C433CA;
        Wed,  4 Oct 2023 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696432475;
        bh=sVb1k0yUWZmIiRmLsr5E7KWlOhVNJ9j/Nl1LiNAAiwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tw8k4DLhwzdNCnsX5ets8V40gPrPSpiB2WspgLXxhl8zyr0Qft+YioawNU8w4YJE9
         jEhKUKy7qWsjEd758xXKDjFZD99EooG3xGnYrd1o4SsJvimeDj/l/GIhAaGEq3ckix
         h+aMJg0QuIg9x2K80WOAgsCEiq6rDq0thaA+IxOCnbRKlTeIRaXgs6GRK9JNbTi9Rf
         lxVC7AR34IDtnDgS5jYzvsZz0N+5/UWumnWfNjeb3o3lRT/LM0XL31jnlS8G4xMK4K
         NOTfzn5iK/VMy0O73nJ1kc4FPzaU1a6CulL907FDsPbDKMFYdq6GFZrl+4pdZp3OLI
         kVaNYY31PQNJw==
Received: (nullmailer pid 3147925 invoked by uid 1000);
        Wed, 04 Oct 2023 15:14:33 -0000
Date:   Wed, 4 Oct 2023 10:14:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: regulator: regulator-output: Multiple
 supplies
Message-ID: <20231004151433.GA3145438-robh@kernel.org>
References: <20231004120529.1155700-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004120529.1155700-1-naresh.solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:05:26PM +0200, Naresh Solanki wrote:
> Add support for multiple supplies.

Why?

> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>  .../devicetree/bindings/regulator/regulator-output.yaml  | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/regulator-output.yaml b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> index 078b37a1a71a..6d077f123729 100644
> --- a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> +++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> @@ -21,13 +21,13 @@ properties:
>    compatible:
>      const: regulator-output
>  
> -  vout-supply:
> +patternProperties:
> +  ".*-supply":
>      description:
>        Phandle of the regulator supplying the output.
>  
>  required:
>    - compatible
> -  - vout-supply
>  
>  additionalProperties: false
>  
> @@ -37,3 +37,8 @@ examples:
>            compatible = "regulator-output";
>            vout-supply = <&output_reg>;
>        };
> +      output1 {
> +          compatible = "regulator-output";
> +          sw0-supply = <&output_reg0>;
> +          sw1-supply = <&output_reg2>;
> +      };
> 
> base-commit: f9a1d31874c383f58bb4f89bfe79b764682cd026
> -- 
> 2.41.0
> 
