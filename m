Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD56787CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjHYBEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjHYBEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:04:05 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED0E77
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:04:04 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a56ed12c0so76988b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692925443; x=1693530243;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O78US63FfsQzmACvTjZMokzlCsmaMM4h32+Wp3IzgcU=;
        b=h/OlHopVZqV0ui3E+m+IdDYT58/fes7lwYYaK/DEj//H9Wh7UqxCKfcYzGZ+ekMJ7f
         qMPYNqWprGuGccHYWpsbSAU3ToS1t+y84N/nh29EwvJVTmAuBKcdxUePTY99d9xKPPBo
         p/w6//TXZkPAz83UFrvdmxzoCkPtpuwRYV99jEAB2OnmMCWS+pXSMiQJPQFuVFk4yekP
         YxWaTdH62vFrGbOZMz7i75GqPS40X50Q0IWJl3LltLg78563BJKSMm305AFnnvYacwjE
         wKBLEKxnbnzIoqDS1LxK5oNxLIf/O6kqlsT8dCA9GT9AuU1z8wyXU82z4sMpHrrkXy+W
         XGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692925443; x=1693530243;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O78US63FfsQzmACvTjZMokzlCsmaMM4h32+Wp3IzgcU=;
        b=eTRWAB88xrt8bZYGMwgqgdxFl/+nNfHie6p0SsHwGY3qDboCJsQmq0ePNXm8YRqh9K
         Z8qTElzUN3uTS0v4bgLi9CIvbzEy1ZG5Ynz0IicEhocuLSPz8Gpf+6LOjmx0o8Fv2Q+k
         I+5aWSfeFgv8feBJ/1vcSjYfUdcStWTIbvwiVmjuZJAWfrSdcrvlWWPd3oxKYFGKV+ag
         7VbqrsonaUULdzpFKu47Ak9DwRlojZLZqbLJ4E9tqMEK2/kXcvD3mw11T5YV1bBAOBfL
         ryTbvkS7+F8Q97r996zIdUCgY1r0zP+cPLFZ8BbAhl+tse4T9coZuWaI0VtONcV9ndk1
         ACAA==
X-Gm-Message-State: AOJu0YxMKJQmMlTF1zqjXCKkGeVn5n8KuI/Ditk+CVEy1ZSQG//cvbfs
        SedBqZVJYEpZahcumWCiZ87MFA==
X-Google-Smtp-Source: AGHT+IFADa9to1oIspLe0Sh5Ftf307VsJJzQgb6brQ/sYjhq0w4KfW8P3TPfT//dHMboCCp5MQcUcQ==
X-Received: by 2002:a05:6a21:6da5:b0:137:3eba:b81f with SMTP id wl37-20020a056a216da500b001373ebab81fmr22106910pzb.3.1692925443476;
        Thu, 24 Aug 2023 18:04:03 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:ebbb:f01b:5bbb:8d77])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001b898595be7sm300108plq.291.2023.08.24.18.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 18:04:03 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:03:59 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Message-ID: <ZOf9/z5iPMUX3Ocu@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <cover.1691518313.git.oleksii_moisieiev@epam.com>
 <1dcf25b5c6b16b7138534e3c13827287f7c644cf.1691518314.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dcf25b5c6b16b7138534e3c13827287f7c644cf.1691518314.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 06:25:36PM +0000, Oleksii Moisieiev wrote:
> Add new SCMI v3.2 pinctrl protocol bindings definitions and example.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> 
> ---
> Changes v3 -> v4
>   - reworked protocol@19 format
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 5824c43e9893..5318fe72354e 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -233,6 +233,39 @@ properties:
>        reg:
>          const: 0x18
>  
> +  protocol@19:
> +    type: object
> +    allOf:
> +      - $ref: "#/$defs/protocol-node"
> +      - $ref: "../pinctrl/pinctrl.yaml"

Does this rule require that the node name start with "pinctrl" or "pinmux"?
If so, it doesn't match with "protocol@19".

> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        const: 0x19
> +
> +      '#pinctrl-cells':
> +        const: 0
> +
> +    patternProperties:
> +      '-pins$':

Is this restriction necessary?
(Most pinctrl's do so, though.)

> +        type: object
> +        allOf:
> +          - $ref: "../pinctrl/pincfg-node.yaml#"
> +          - $ref: "../pinctrl/pinmux-node.yaml#"
> +        unevaluatedProperties: false
> +
> +        description:

I think the description may be a bit ambiguous.

> +          A pin multiplexing sub-node describe how to configure a
> +          set of pins is some desired function.

Even a sub-node that has pin multiplexing definitions may have
pin property/parameter definitions. Right?

> +          A single sub-node may define several pin configurations.

Do you not allow for having a sub-node under a sub-node?

> +          This sub-node is using default pinctrl bindings to configure

Does "default pinctrl bindings" refer to "pinctrl-bindings.txt"?
Is it necessary to specifically mention it here as it is for client devices?


> +          pin multiplexing and using SCMI protocol to apply specified

Again, not only multiplexing but also pin property/parameters.

Thanks,
-Takahiro Akashi

> +          configuration using SCMI protocol.
> +
> +    required:
> +      - reg
> +
>  additionalProperties: false
>  
>  $defs:
> @@ -384,6 +417,26 @@ examples:
>              scmi_powercap: protocol@18 {
>                  reg = <0x18>;
>              };
> +
> +            scmi_pinctrl: protocol@19 {
> +                reg = <0x19>;
> +                #pinctrl-cells = <0>;
> +
> +                i2c2-pins {
> +                    groups = "i2c2_a", "i2c2_b";
> +                    function = "i2c2";
> +                };
> +
> +                mdio-pins {
> +                    groups = "avb_mdio";
> +                    drive-strength = <24>;
> +                };
> +
> +                keys_pins: keys-pins {
> +                    pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
> +                    bias-pull-up;
> +                };
> +            };
>          };
>      };
>  
> -- 
> 2.25.1
