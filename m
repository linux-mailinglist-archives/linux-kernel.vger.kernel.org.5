Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7C2785893
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbjHWNNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjHWNNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:13:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A56E4E;
        Wed, 23 Aug 2023 06:13:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A14365663;
        Wed, 23 Aug 2023 13:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE786C433C8;
        Wed, 23 Aug 2023 13:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692796417;
        bh=DaGglQshpU9aTm/Tv91gnQQDys7dUA7tLk3NwPkPRFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsPaOqQ+kqB2t/YvmWau52gagC8bfE45jMsvBQnlroxNCZYsBR5PJBhBCc77d10We
         R3gRHOTSVZom8xz6+Ojn4fSqbgZ0BMreYCIM3zSTszk9NhHhaViyCDsCkeJXaXWII6
         ydUKJ/3yzfTPSUN1foUMOz44KC2K/4HlcCa5lKFOaDF1FA9SNjSr13HJQuFCiF2Ixp
         +woHAjlR1Add2jN6/FQFaFCjHvNN8lF0/+HJl2iXAJfeBuP+JIx3SF0XOpWYZ81c/Z
         f5UiMfKsJAFfxO/5UUpOBKwSFeiXVQJha3FTLJ9ND2ihND+V01vbZHsLTxz2ZrykJV
         0RjttZkHtsEKw==
Received: (nullmailer pid 2148592 invoked by uid 1000);
        Wed, 23 Aug 2023 13:13:34 -0000
Date:   Wed, 23 Aug 2023 08:13:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        corbet@lwn.net, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        BMC-SW@aspeedtech.com, patrick@stwcx.xyz
Subject: Re: [PATCH v7 1/2] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Message-ID: <20230823131334.GA2059582-robh@kernel.org>
References: <20230817120029.221484-1-billy_tsai@aspeedtech.com>
 <20230817120029.221484-2-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817120029.221484-2-billy_tsai@aspeedtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 08:00:28PM +0800, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-pwm-tach device, which can
> support upto 16 PWM outputs and 16 fan tach input.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> new file mode 100644
> index 000000000000..1666304d0b0f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED G6 PWM and Fan Tach controller device driver
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The ASPEED PWM controller can support upto 16 PWM outputs.
> +  The ASPEED Fan Tacho controller can support upto 16 fan tach input.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-pwm-tach
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  aspeed,fan-tach-ch:
> +    description: Specify the Fan tach input channels.
> +    $ref: "/schemas/types.yaml#/definitions/uint8-array"

This property is already defined in aspeed-pwm-tacho.txt as a single u8 
that goes in a fan node. You can't redefine its type and location here.

To repeat what I've said in previous versions, work with others to 
define a common fan and fan controller binding. Otherwise, anything new 
with fan related properties is simply going to be rejected.

Rob
