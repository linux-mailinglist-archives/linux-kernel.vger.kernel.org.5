Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C009778F123
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242786AbjHaQWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjHaQWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:22:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF1CCF3;
        Thu, 31 Aug 2023 09:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17887B8229D;
        Thu, 31 Aug 2023 16:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72C2C433C8;
        Thu, 31 Aug 2023 16:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693498923;
        bh=CTXJBHNMlG2S512kPkmVIDm+/koZ+JKTX7OmWnz6zkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MoSlTJr5HrwsK9zs6I2kICcng8QccNM/8rFnIdYdBR8LODAfVQW9dAxG/KxKI1L+v
         DdbekyxziJ+V+TnoRtkxyxC3MdztZFhgs3mj08d2sWTit5HCfS/wsWEv0i18j5VKpQ
         ZPN6uJtEU5qrxXhaoiPHUoDyTgkA3XASn9pwp2+A+ac3ad631nXSIIsjgjIWgXcLUt
         s5F74JlKuGnXhnmSPFmUWbUBD7ALEfpbOlxeiufDJs9L5Oyg+lKfqS9URDNhNQAtEG
         sNV2GJF/8RaoNmFozOwfC5DdaeYN2dAr7ab4TLR5uVdQg1M9HyRP5YuQbsTpOmPJGK
         wqzbSRxTKldAg==
Received: (nullmailer pid 2383784 invoked by uid 1000);
        Thu, 31 Aug 2023 16:22:01 -0000
Date:   Thu, 31 Aug 2023 11:22:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/4] dt-bindings: input: touchscreen: st1232: add
 example with touch-overlay
Message-ID: <20230831162201.GA2381101-robh@kernel.org>
References: <20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v4-4-5c6c0fc1eed6@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-feature-ts_virtobj_patch-v4-4-5c6c0fc1eed6@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 03:17:12PM +0200, Javier Carrasco wrote:
> The st1232 driver supports the overlay-touchscreen and overlay-buttons
> objects defined in the generic touchscreen bindings and implemented in
> the touch-overlay module. Add an example where nodes for an overlay
> touchscreen and overlay buttons are defined.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  .../input/touchscreen/sitronix,st1232.yaml         | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
> index 1d8ca19fd37a..857b611f84c2 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
> @@ -48,3 +48,43 @@ examples:
>                      gpios = <&gpio1 166 0>;
>              };
>      };
> +  - |
> +    #include <dt-bindings/input/linux-event-codes.h>
> +    i2c {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            touchscreen@55 {
> +                    compatible = "sitronix,st1232";
> +                    reg = <0x55>;
> +                    interrupts = <2 0>;
> +                    gpios = <&gpio1 166 0>;

Just add this to the existing example. No value in 2 examples.

> +
> +                    overlay-touchscreen {
> +                            x-origin = <0>;
> +                            x-size = <240>;
> +                            y-origin = <40>;
> +                            y-size = <280>;
> +                    };
> +
> +                    overlay-buttons {
> +                            button-light {
> +                                    label = "Camera light";
> +                                    linux,code = <KEY_LIGHTS_TOGGLE>;
> +                                    x-origin = <40>;
> +                                    x-size = <40>;
> +                                    y-origin = <0>;
> +                                    y-size = <40>;
> +                            };
> +
> +                            button-power {
> +                                    label = "Power";
> +                                    linux,code = <KEY_POWER>;
> +                                    x-origin = <160>;
> +                                    x-size = <40>;
> +                                    y-origin = <0>;
> +                                    y-size = <40>;
> +                            };
> +                    };
> +            };
> +    };
> 
> -- 
> 2.39.2
> 
