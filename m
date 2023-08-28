Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C77078B82B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjH1TXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjH1TW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:22:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F04A102;
        Mon, 28 Aug 2023 12:22:53 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A2350741;
        Mon, 28 Aug 2023 21:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693250490;
        bh=VVvs2Og4CU9Yf0bW7xlqGzmlyvM5uaH4UtpPPK9nqKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7sQd4PUHmbVEhNB6wHZLjDjYLLWtHy84Xpd6o2/tqQwNyTliWKxHV39i2ehi0Le2
         JqQjQP64ssEMZggmPP/s54pZjbpANsKwXqTXwtZIvAsztsFFEBFV5yawPwYESDZvuR
         kARndQS41IeOGvxgY/A3ioBsyJxF/X5CT8hzUb0g=
Date:   Mon, 28 Aug 2023 22:23:01 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: display: panel: add common dual-link
 schema
Message-ID: <20230828192301.GC17083@pendragon.ideasonboard.com>
References: <20230825121142.101759-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230825121142.101759-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the patch.

On Fri, Aug 25, 2023 at 02:11:40PM +0200, Krzysztof Kozlowski wrote:
> Add schema with common properties shared among dual-link panel ICs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Changes since v3:
> 1. Re-phrase description of binding and ports (Laurent)
> v3: https://lore.kernel.org/all/20230823081500.84005-1-krzysztof.kozlowski@linaro.org/
> 
> Changes since v2:
> 1. New Patch
> v2: https://lore.kernel.org/all/20230502120036.47165-1-krzysztof.kozlowski@linaro.org/
> v1: https://lore.kernel.org/all/20230416153929.356330-1-krzysztof.kozlowski@linaro.org/
> ---
>  .../display/panel/panel-common-dual.yaml      | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml b/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
> new file mode 100644
> index 000000000000..cc7ea3c35c77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/panel-common-dual.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/panel-common-dual.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common Properties for Dual-Link Display Panels
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> +
> +description:
> +  Properties common for Panel IC supporting dual link panels.  Devices might
> +  support also single link.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    additionalProperties: false
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: First link
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Second link
> +
> +      "#address-cells": true
> +      "#size-cells": true
> +
> +    required:
> +      - port@0
> +
> +# Single-panel setups are still allowed.
> +oneOf:
> +  - required:
> +      - ports
> +  - required:
> +      - port
> +
> +additionalProperties: true

-- 
Regards,

Laurent Pinchart
