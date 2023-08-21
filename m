Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BC2783481
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjHUU5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjHUU5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:57:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59848C7;
        Mon, 21 Aug 2023 13:57:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6B4862ADB;
        Mon, 21 Aug 2023 20:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A3BC433C7;
        Mon, 21 Aug 2023 20:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692651468;
        bh=PF6X5SwvaOhtmmfjP6qY7/WWdtOLsngVMo7QWig8ffs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YO2Ds2MHgrs75HGv/pODkl51YVRrILHA4ymHlDRFOOdLd+Be8/GNVP5DYiMbPL+Nq
         3xm/ly78G/zH5Iyds6S+aZEYD1LSWA9AISpihqbx9kDEQ4JocdloXiClXFhavaNZBk
         VaYoHuRtUJemCVWXE77ludOg/4Baw77Xd+96BK3Qt2oD5Yl8a55d6tgUVEHhBUo8sT
         EjZuM79Sounco7X6YkTqUmxUVZaFQ/TwJmIa5YpE2E6ndtgGNpXUYUeBC1RZlE2ec/
         hnrajHnkFYmFK0AhKrGmn9drqpYm/OgS7RIlyA7Q3eu9aIjZQ47AB2LUr+A/s0hesQ
         TgZKTO6yy5Pjw==
Received: (nullmailer pid 2280185 invoked by uid 1000);
        Mon, 21 Aug 2023 20:57:45 -0000
Date:   Mon, 21 Aug 2023 15:57:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: add TWL6032 32K clocks
Message-ID: <20230821205745.GA2270173-robh@kernel.org>
References: <20230819134147.456060-1-andreas@kemnade.info>
 <20230819134147.456060-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819134147.456060-2-andreas@kemnade.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 03:41:45PM +0200, Andreas Kemnade wrote:
> To be able to be referenced from a future yaml-version of
> mfd/twl-family.txt depending on toplevel compatible have a separate file
> for the 6032

Really, the parent needs to be done first...

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../bindings/clock/ti,twl6032-clk.yaml        | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml b/Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml
> new file mode 100644
> index 0000000000000..aebd9f8d761a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti,twl6032-clk.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/ti,twl6032-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Clocks of the TWL6032 PMIC
> +
> +maintainers:
> +  - Andreas Kemnade <andreas@kemnade.info>
> +
> +description:
> +  The TWL6032 has some 32Khz clock outputs which can be controlled.

outputs? Seems like only 1 with no clock cells to specify which one.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,twl6032-clk32kaudio
> +      - ti,twl6032-clk32kg

Or is it 1 output per compatible? I hope not.

> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    twl {
> +        clk32kaudio {
> +            compatible = "ti,twl6032-clk32kaudio";
> +            #clock-cells = <0>;
> +        };

You don't need a child node to be a clock provider. Just add 
#clock-cells to the parent node.

Rob
