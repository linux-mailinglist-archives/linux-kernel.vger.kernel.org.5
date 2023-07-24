Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3840E76031B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGXX0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGXX02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E65E7B;
        Mon, 24 Jul 2023 16:26:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD3F761463;
        Mon, 24 Jul 2023 23:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DCFC433C8;
        Mon, 24 Jul 2023 23:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690241187;
        bh=4KSq1+MwOBFiXF30dhtmS7Fj1Uen43j4cbGhaxzDkQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AVl0guQBTKgPU625eTtTiJ730ZEWk7Y7+8PLfxgxYRhJk9+ktGWz3b306R3LK8Heg
         L5g6xPDWJyM0EB7e0GlDoGR9kmlt5H3dE6q81sx4C7Ju1thz0PdaKdYfwP7xOLXA6Y
         RGrBj5+Iz8N0rNN8SyvwvWDsgnsKdBLI5s8XmcCnvDXmuHh+9udH0VRpm+28ZFoZYG
         baB2Vv3XExVU2KQUsO9vFNMpwiiNzyQrXJRP6uuSukARjfty/1k1YEjsuc6BpVsh6p
         dnArt6BOWuU3gl6Glu2BW0Nm+nHiHAZhldyqu+m5InAVFou0GdIXNqethlH29s389V
         onJqHwhLpZzSw==
Received: (nullmailer pid 1114814 invoked by uid 1000);
        Mon, 24 Jul 2023 23:26:24 -0000
Date:   Mon, 24 Jul 2023 17:26:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 07/10] dt-bindings: net: snps,dwmac: add safety
 irq support
Message-ID: <20230724232624.GA1112850-robh@kernel.org>
References: <20230723161029.1345-1-jszhang@kernel.org>
 <20230723161029.1345-8-jszhang@kernel.org>
 <20230724-cleat-tricolor-e455afa60b14@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724-cleat-tricolor-e455afa60b14@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 06:23:13PM +0100, Conor Dooley wrote:
> On Mon, Jul 24, 2023 at 12:10:26AM +0800, Jisheng Zhang wrote:
> > The snps dwmac IP support safety features, and those Safety Feature
> > Correctible Error and Uncorrectible Error irqs may be separate irqs.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index ddf9522a5dc2..bb80ca205d26 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -107,6 +107,8 @@ properties:
> >        - description: Combined signal for various interrupt events
> >        - description: The interrupt to manage the remote wake-up packet detection
> >        - description: The interrupt that occurs when Rx exits the LPI state
> > +      - description: The interrupt that occurs when Safety Feature Correctible Errors happen
> > +      - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
> >  
> >    interrupt-names:
> >      minItems: 1
> > @@ -114,6 +116,8 @@ properties:
> >        - const: macirq
> >        - enum: [eth_wake_irq, eth_lpi]
> >        - const: eth_lpi
> > +      - const: sfty_ce_irq
> > +      - const: sfty_ue_irq
> 
> Putting _irq in an interrupt name seems rather redundant to me although,
> clearly not the first time for it here.

It's already inconsistent, so don't follow that pattern. Drop '_irq'.

> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.


