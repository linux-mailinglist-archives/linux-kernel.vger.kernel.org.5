Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EE57B221E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjI1QTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjI1QTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:19:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D23136
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:19:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C59C433C8;
        Thu, 28 Sep 2023 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695917973;
        bh=mw3dCL34p/b/T6NWnBreYmODuNtO2bUmbCul5IYJSkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKNi11AdR30o0vP7v+IqY9BF+c+bXg21PvtUJyg0ZXvRYfSTJmIZlNo0YQNfBpqyt
         R/2OIMD3hx1+8VdppRQc9sdDWqFr18cwB1UweQpBr05RMw6GD4AZarq4N1zQCoqQ9a
         4ZeMozVxmn6InZKdI4XXdo2pp7VM5S5nbBFpZOPR9pDnONIR/vNX+p/0ZiZ3cWj1a+
         CBNL/N6xRacq5uLDFogMRIw87JDEHcU7/Z0EKG1yEotyeInQvlG/nunING72HvGO2P
         VWHNKdjn/bWWfFyLMotPOhoACTycIdPq+jYq7tDMdYxi2ObUhJubIpvu+S9qsfoAC+
         dC7XjVaANSEXg==
Received: (nullmailer pid 745205 invoked by uid 1000);
        Thu, 28 Sep 2023 16:19:31 -0000
Date:   Thu, 28 Sep 2023 11:19:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: rt5616: Convert to dtschema
Message-ID: <20230928161931.GA713974-robh@kernel.org>
References: <20230925165715.34883-1-bragathemanick0908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925165715.34883-1-bragathemanick0908@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:27:15PM +0530, Bragatheswaran Manickavel wrote:
> Convert the rt5616 audio CODEC bindings to DT schema

> No error/warning seen when running make dt_binding_check

No need to say that. That's the assumption and it should never get 
applied if not.

> 
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>  .../bindings/sound/realtek,rt5616.yaml        | 53 +++++++++++++++++++
>  .../devicetree/bindings/sound/rt5616.txt      | 32 -----------
>  2 files changed, 53 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/rt5616.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
> new file mode 100644
> index 000000000000..00ff9b4e3c7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/realtek,rt5616.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek rt5616 ALSA SoC audio codec driver
> +
> +description: |
> +  Pins on the device (for linking into audio routes) for RT5616:
> +
> +      * IN1P
> +      * IN2P
> +      * IN2N
> +      * LOUTL
> +      * LOUTR
> +      * HPOL
> +      * HPOR
> +
> +maintainers:
> +  - Bard Liao <bardliao@realtek.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: realtek,rt5616
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#sound-dai-cells'

This was not in the original doc. Was that an error? If so, just state 
that in the commit msg.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;

blank line

> +        codec@1b {

audio-codec@1b

> +            compatible = "realtek,rt5616";
> +            reg = <0x1b>;
> +            #sound-dai-cells = <0>;
> +        };
> +    };
