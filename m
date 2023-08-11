Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF4B7792C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbjHKPSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbjHKPSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:18:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A80630FE;
        Fri, 11 Aug 2023 08:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1402467491;
        Fri, 11 Aug 2023 15:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC7CC433C8;
        Fri, 11 Aug 2023 15:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691767077;
        bh=sYvo6BzZgVIR+Xo2mgLwMg8tTTWGszb7yIrxN1LiV9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=af1XG8igMEDms8WJwIDR8zAXEB1LFBOggC12ArcsWcd8+0F94rfLne/U2x1Jf5X3T
         5U9owhCxIpoU4kHWRAUBhre6SlzeGOUyUzdrXCNpwt0Tqp1EFddHneh/EcydrnL+Yb
         g7EIA0CZO56Qkr4LGCxPpC1qIDiFHMUNRK4VvjpsHZC59Z+tPlhp6ptuo3Nl3JgoDq
         GsKjQoMeU0d17CzvLs4HYEngKxK9dAoHgqy9wcBuCZAm6xarG4ABoc+NGTzcZf/eZb
         byDC12BKJe6CNeWYBgrl1XNgmX65P/R+w9ueXCu3HPNHB8ZIjxuCTl9BERy+WvWeX+
         5qPd+FlNjQgBA==
Received: (nullmailer pid 3485263 invoked by uid 1000);
        Fri, 11 Aug 2023 15:17:55 -0000
Date:   Fri, 11 Aug 2023 09:17:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: rohm,bu27010: add missing vdd-supply
 to example
Message-ID: <20230811151755.GA3484524-robh@kernel.org>
References: <20230808063223.80431-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808063223.80431-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 08:32:23AM +0200, Krzysztof Kozlowski wrote:
> Bindings require vdd-supply but the example DTS was missing one.  This
> fixes dt_binding_check error:
> 
>   Documentation/devicetree/bindings/iio/light/rohm,bu27010.example.dtb: light-sensor@38: 'vdd-supply' is a required property
> 
> Fixes: ae8c47c51e5c ("dt-bindings: iio: ROHM BU27010 RGBC + flickering sensor")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
