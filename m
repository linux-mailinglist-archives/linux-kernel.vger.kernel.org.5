Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB8976DC95
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjHCAZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHCAZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059BE11D;
        Wed,  2 Aug 2023 17:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9597F61B95;
        Thu,  3 Aug 2023 00:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6861C433C8;
        Thu,  3 Aug 2023 00:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691022304;
        bh=Ak6kWgpita0ccStQUBSLTHQZ7Qxm2852u+BDrFi7RTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxoeAZAGjuZLO3hoE98/N44RKxRUPG41IhNvI224eG9LzGYuPJ8KxOHPpB05W3om9
         5b5TuYFEiAHtFZ2fL7L9JR+ldk+TrfSE0YhaBJJHVmh5mn7nDHfVruAH97TJK9hood
         gLYnjUG1/u8MMHPdk4BzKhpk3JqQ2dPHz5nvlEqmccwuBMgtJE7TMz5k0WHn5BF7uH
         +DupCeCicS+5gCblQeAizSgrN0sPOwSEuLBc4GEt/q6nYNtTI3A2/GQ0iBkuL7Glxl
         RLD0GwnXsX4J71uei464iGVOTgdXaegNN4hvxit/2wWQgS9Y4HiONI/Nkp6+y+fRMA
         9wDKyN8IyhgtQ==
Received: (nullmailer pid 1580378 invoked by uid 1000);
        Thu, 03 Aug 2023 00:25:02 -0000
Date:   Wed, 2 Aug 2023 18:25:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     pavel@ucw.cz, lee@kernel.org, thierry.reding@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, luca.weiss@fairphone.com,
        konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: leds: leds-qcom-lpg: Add support for
 LPG PPG
Message-ID: <20230803002502.GA1569972-robh@kernel.org>
References: <20230725193423.25047-1-quic_amelende@quicinc.com>
 <20230725193423.25047-3-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725193423.25047-3-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 12:34:18PM -0700, Anjelique Melendez wrote:
> Update leds-qcom-lpg bindings to support LPG PPG.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  .../bindings/leds/leds-qcom-lpg.yaml          | 92 ++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> index e6f1999cb22f..6feca859fb74 100644
> --- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> @@ -11,7 +11,7 @@ maintainers:
>  
>  description: >
>    The Qualcomm Light Pulse Generator consists of three different hardware blocks;
> -  a ramp generator with lookup table, the light pulse generator and a three
> +  a ramp generator with lookup table (LUT), the light pulse generator and a three
>    channel current sink. These blocks are found in a wide range of Qualcomm PMICs.
>  
>  properties:
> @@ -63,6 +63,27 @@ properties:
>          - description: dtest line to attach
>          - description: flags for the attachment
>  
> +  nvmem:
> +    description: >
> +      This property is required for PMICs that supports PPG, which is when a
> +      PMIC stores LPG per-channel data and pattern LUT in SDAM modules instead
> +      of in a LUT peripheral. For PMICs, such as PM8350C, per-channel data
> +      and pattern LUT is separated into 2 SDAM modules. In that case, phandles
> +      to both SDAM modules need to be specified.
> +    minItems: 1
> +    maxItems: 2
> +
> +  nvmem-names:
> +    minItems: 1
> +    maxItems: 2
> +
> +  qcom,pbs:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: >
> +      Phandle of the Qualcomm Programmable Boot Sequencer node (PBS).
> +      PBS node is used to trigger LPG pattern sequences for PMICs that support
> +      single SDAM PPG.
> +
>    multi-led:
>      type: object
>      $ref: leds-class-multicolor.yaml#
> @@ -106,6 +127,44 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,pmi632-lpg
> +    then:
> +      properties:
> +        nvmem:
> +          maxItems: 1
> +        nvmem-names:
> +          items:
> +            - const: lpg_chan_sdam
> +        qcom,pbs:
> +          maxItems: 1
> +      required:
> +        - nvmem
> +        - nvmem-names
> +        - qcom,pbs
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pm8350c-pwm
> +              - qcom,pm8550-pwm
> +    then:
> +      properties:
> +        nvmem:
> +          minItems: 2
> +        nvmem-names:
> +          items:
> +            - const: lpg_chan_sdam
> +            - const: lut_sdam

This can go into the main section and then here you just say 
'minItems: 2'. And similar for the 1st if/then.

> +      required:
> +        - nvmem
> +        - nvmem-names

Looks like these are always required.

> +
>  examples:
>    - |
>      #include <dt-bindings/leds/common.h>
> @@ -191,4 +250,35 @@ examples:
>        compatible = "qcom,pm8916-pwm";
>        #pwm-cells = <2>;
>      };
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    led-controller {
> +      compatible = "qcom,pmi632-lpg";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      #pwm-cells = <2>;
> +      nvmem-names = "lpg_chan_sdam";
> +      nvmem = <&pmi632_sdam_7>;
> +      qcom,pbs = <&pmi632_pbs_client3>;
> +
> +      led@1 {
> +        reg = <1>;
> +        color = <LED_COLOR_ID_RED>;
> +        label = "red";
> +      };
> +
> +      led@2 {
> +        reg = <2>;
> +        color = <LED_COLOR_ID_GREEN>;
> +        label = "green";
> +      };
> +
> +      led@3 {
> +        reg = <3>;
> +        color = <LED_COLOR_ID_BLUE>;
> +        label = "blue";
> +      };
> +    };
> +
>  ...
> -- 
> 2.41.0
> 
