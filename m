Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A1377056F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjHDQAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHDQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:00:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4B4170F;
        Fri,  4 Aug 2023 09:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A34346206F;
        Fri,  4 Aug 2023 16:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338BEC433C7;
        Fri,  4 Aug 2023 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691164829;
        bh=dupMnnlm92X5GBYvSrFj7v5q809KKr9QlF56rG7YxJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMWGpZDFv6hHcc0BkW5axZUm77Gt2+JylWAnDqKYGgqDGF5H28OSN12lm4KznTJFK
         oo4L8Z5HGm8hYyFbXt7Ke0CIQ1G3yr96WTOJDoELhEohjvFK/jNfRkveFbnqulUclz
         XpcJ9d9ZkTHaGq4VkvOqC76i4z1z+Tjp+Wk846GjjZqvacOT0/xjRSCBRuuDHB2586
         D3TLfKpyOru/Rz2nIZu4KhVsJJ2/vxo0D1ywd9z0N89P8iqjlT9ME49FGauJ9lq3aO
         syxSC4ioQUL5oplJDCZs7HS+H07UwwaMsV/PtAH4Auj3fcysddv3KhWkDGbZ9D3kPY
         jRKsF8yTlgKhQ==
Date:   Fri, 4 Aug 2023 09:03:28 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: soc: qcom: qcom,pmic-glink: add a gpio
 used to determine the Type-C port plug orientation
Message-ID: <zhm72wrjg7yazutkinv5lx55dgqtm4hmuexw2ht24fu6txxk3d@oum27inbk7si>
References: <20230804-topic-sm8550-upstream-type-c-orientation-v1-0-36dd3edec7bf@linaro.org>
 <20230804-topic-sm8550-upstream-type-c-orientation-v1-1-36dd3edec7bf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804-topic-sm8550-upstream-type-c-orientation-v1-1-36dd3edec7bf@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:50:07PM +0200, Neil Armstrong wrote:
> On SM8450 and SM8550 based platforms, the Type-C plug orientation is given on a
> GPIO line set by the PMIC.
> 
> Document this optional Type-C connector property, and take the
> assumption an active level represents an inverted/flipped orientation.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> index bceb479f74c5..1b0a00b19a54 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> @@ -35,6 +35,11 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  orientation-gpios:
> +    description: An input gpio for Type-C connector orientation, used to detect orientation
> +      of the Type-C connector. GPIO active level means "CC2" or Reversed/Flipped orientation.

This is a per-connector/port property, as such be part of the connector
sub nodes rather than as a property of the shared pmic_glink entity.

Regards,
Bjorn

> +    maxItems: 1
> +
>  patternProperties:
>    '^connector@\d$':
>      $ref: /schemas/connector/usb-connector.yaml#
> @@ -44,6 +49,19 @@ patternProperties:
>  required:
>    - compatible
>  
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - qcom,sm8450-pmic-glink
> +                - qcom,sm8550-pmic-glink
> +    then:
> +      properties:
> +        orientation-gpios: false
> +
>  additionalProperties: false
>  
>  examples:
> 
> -- 
> 2.34.1
> 
