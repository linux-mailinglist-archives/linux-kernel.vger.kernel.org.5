Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5250B782E08
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbjHUQOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbjHUQOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:14:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBED1DB;
        Mon, 21 Aug 2023 09:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5977D63D4C;
        Mon, 21 Aug 2023 16:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C80C433C9;
        Mon, 21 Aug 2023 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692634483;
        bh=HaFkRLw39AyOlg5LKd8SotMyWHrCrbNB/b2ma+dX5y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myuDm5eSozfKEjyhuaqU7d0d4v22QuzKSsoALDNAcO0PQsZxqSM5MqFcAAmaUA3ZP
         bORAcnrX2DkATzZL14uUuXGLoAWj5fvoIeSrvawx+9hHgchfk9pwiMMNQsnbzer5Nh
         wu1lv+Y4Qqt71o7uejj6YTHKTj8tp5Z0NwKWm9/pG6ixpZF6GZ8aOSrIlqyftbpHCD
         WVVX4Y1+oiad4C/0e7D60pV/0vDsyouUgLTGHFDzwNcUlr8Ix4dtnxEG3ChJCAAqXT
         56v5gNOukSk0clim19s/DWuu4wXoGVOYeZBJcg0W5Jil88IbmRULxNAiCBiGnsV+L/
         NZq12WSVw2RXw==
Received: (nullmailer pid 1830598 invoked by uid 1000);
        Mon, 21 Aug 2023 16:14:41 -0000
Date:   Mon, 21 Aug 2023 11:14:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: display: tegra: nvidia,tegra20-dc:
 Add parallel RGB output port node
Message-ID: <20230821161441.GA1743870-robh@kernel.org>
References: <20230807143515.7882-1-clamor95@gmail.com>
 <20230807143515.7882-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807143515.7882-3-clamor95@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 05:35:12PM +0300, Svyatoslav Ryhel wrote:
> From: Maxim Schwalm <maxim.schwalm@gmail.com>
> 
> Either this node, which is optional, or the nvidia,panel property can be
> present.
> 
> Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../display/tegra/nvidia,tegra20-dc.yaml      | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
> index 69be95afd562..102304703062 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
> @@ -127,6 +127,37 @@ allOf:
>                $ref: /schemas/types.yaml#/definitions/phandle
>                description: phandle of a display panel
>  
> +            port:
> +              $ref: /schemas/graph.yaml#/$defs/port-base
> +              description: Parallel RGB output port
> +
> +              properties:
> +                endpoint:
> +                  $ref: /schemas/media/video-interfaces.yaml#

Just to make sure, what properties are you using from this? Usually 
we'll list them though not a hard requirement. If none, then you just 
need to ref graph.yaml#/properties/port instead and can drop the rest.

> +                  unevaluatedProperties: false
> +
> +              unevaluatedProperties: false

In the indented cases, it's easier to read if this is before 
properties/patternProperties.

> +
> +          anyOf:
> +            - if:
> +                not:
> +                  properties:
> +                    nvidia,panel: false
> +              then:
> +                not:
> +                  properties:
> +                    port: true
> +            - if:
> +                not:
> +                  properties:
> +                    port: false
> +              then:
> +                not:
> +                  properties:
> +                    nvidia,panel: true

I would prefer to drop this and mark "nvidia,panel" as deprecated. 
Eventually I plan to add a mode to the tools to warn on using deprecated 
properties. Having both could be perfectly fine too. You have the 
"nvidia,panel" for compatibility with an old OS version and 'port' to 
work with newer users.

> +
> +          additionalProperties: false

Move this up too.

Rob
