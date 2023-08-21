Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692E7782DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjHUQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjHUQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7A8100;
        Mon, 21 Aug 2023 09:01:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2726630D6;
        Mon, 21 Aug 2023 16:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C7DC433C8;
        Mon, 21 Aug 2023 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692633683;
        bh=aX4uOZqx4fuKGR4vLazYSCKmLEo9pLv6Ch7nrty5dEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZYKpyWrsAwMxX28B1d1pdBPaZQ2kJZQGINDkwdh1aUmJj0Trs/jhyB6SlUfbeGwq6
         X9Ivl9Pj+IC/EEMghk/YeV6VC7xygOyYqcEwkVSYXZLRbMm74ARf7SOYKeXuKavTlU
         qI3JW9qOa3Vm3kecdy2KaIskEVhHGBi3uu+TUH5bkRXX3RdAHNysR4ZRhFvXhyTFOe
         BC2LjPM4VspI3JCz9U4Ro8M7StLxXxEH6bIKLUV386YUQotI2x5/5ZG80pV8uYETOd
         q0fZFSJXpJUcdfXkBCK2vX7SNrOdn/QewNx9spqsQ7xoeX2VlWndtpnnxmLJsOa/4e
         TZ0s/b51DPXAw==
Received: (nullmailer pid 1743429 invoked by uid 1000);
        Mon, 21 Aug 2023 16:01:20 -0000
Date:   Mon, 21 Aug 2023 11:01:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] dt-bindings: net: Add iep property in ICSSG dt
 binding
Message-ID: <20230821160120.GA1734560-robh@kernel.org>
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230807110048.2611456-3-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807110048.2611456-3-danishanwar@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 04:30:45PM +0530, MD Danish Anwar wrote:
> Add iep node in ICSSG driver dt binding document.

Why?

Bindings are for h/w, not drivers. You are adding a property, not a 
node. Would be nice to know what 'iep' is without having to look at the 
diff (e.g. when running 'git log').

> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index 8ec30b3eb760..36870238f92f 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -52,6 +52,12 @@ properties:
>      description:
>        phandle to MII_RT module's syscon regmap
>  
> +  ti,iep:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

phandle-array really means matrix, so you need to fully describe the 
items constraints.

> +    maxItems: 2

2 phandles or 1 phandle and 1 arg? Looks like the former from the 
example, so:

maxItems: 2
items:
  maxItems: 1

> +    description:
> +      phandle to IEP (Industrial Ethernet Peripheral) for ICSSG driver
> +
>    interrupts:
>      maxItems: 2
>      description:
> @@ -155,6 +161,7 @@ examples:
>                      "tx1-0", "tx1-1", "tx1-2", "tx1-3",
>                      "rx0", "rx1";
>          ti,mii-g-rt = <&icssg2_mii_g_rt>;
> +        ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
>          interrupt-parent = <&icssg2_intc>;
>          interrupts = <24 0 2>, <25 1 3>;
>          interrupt-names = "tx_ts0", "tx_ts1";
> -- 
> 2.34.1
> 
