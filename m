Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831C67BBCBB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjJFQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjJFQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:30:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF5AD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:30:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51776C433C8;
        Fri,  6 Oct 2023 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696609856;
        bh=q+LkTZ3kRNksRx5zPKLolASfAnEed8JZw5Y217f8E/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TgPQyIRU7Vf6SIA0Ux7qV6+hi5EX79radiijlfGtiqnqIrTIMuRS2AMUuanZgNwrD
         KFuvGN6/PSC2hbS6PN5yNoDpD+CI/icPhigNVuwQosN897nO45UtgBnwGTYkIt38Si
         21VAvTi1pSlbCzAkJ9h+IXSLuNbdX1bCPbtOUZD00D12DJeUtZHCH+Ja9kQzDy8FoC
         Xe++Nkg/hWoejUcPH+kuITzL6QoGzba3XKs/lQbtUVSKMAjJHvpR02LDcj/ptbqFw0
         xLl72YAe3Eofm760rDUdSaLdyFhdONV927fMf6aqgNRKusbmZ2H/anum2kW064RH/+
         ha7L1Njo+qBSQ==
Received: (nullmailer pid 4038357 invoked by uid 1000);
        Fri, 06 Oct 2023 16:30:54 -0000
Date:   Fri, 6 Oct 2023 11:30:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: regulator: regulator-output:
 Multiple supplies
Message-ID: <20231006163054.GA4037413-robh@kernel.org>
References: <20231004121010.1192344-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004121010.1192344-1-naresh.solanki@9elements.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:10:07PM +0200, Naresh Solanki wrote:
> Add support for multiple supplies.

Again, why?

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
