Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F732777CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjHJP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbjHJP4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAA326B7;
        Thu, 10 Aug 2023 08:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CA2B660F3;
        Thu, 10 Aug 2023 15:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3AFC433C8;
        Thu, 10 Aug 2023 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691683011;
        bh=KjR8tfjBjYapj4g2ZYHTR2lxl4LahNLGVGtwCEI8Er4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsWd4rF5xyh2zaC4uc/x2prlgCayaZ0Ap62vmMFAow6DnmoHOggw5t8v/IVICi95z
         /Vq90pLhOkXpu2e3yQb0HxhSbisrqqPZwiLGuKhAjAygvr1JXLgjYH3a971lXsmq6l
         SfLKh95ZGJUerkdz6ATI/xxRXfKJkbMasJ/l2Yqv4Z9KkSF5ivGF0fWcJWU8foB6iR
         dlBJo4sEhoXUZdlUMJxukw09qo6qDSKyZOgW0EwLX4N2OA/o3eirMd6F88BmEuZ938
         yfNanbIaKYKanrvOzezqu96+bfYvwVFoYHokA4eAZDykdvPfmNHEaN6n2tF4pXw3kK
         B/Z5hJ2BSzLRg==
Date:   Thu, 10 Aug 2023 23:45:07 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 09/10] dt-bindings: net: snps,dwmac: add per
 channel irq support
Message-ID: <ZNUGA+6/K5GJbK4d@xhacker>
References: <20230809165007.1439-1-jszhang@kernel.org>
 <20230809165007.1439-10-jszhang@kernel.org>
 <20230809-scabby-cobweb-bb825dffb309@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809-scabby-cobweb-bb825dffb309@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 06:38:36PM +0100, Conor Dooley wrote:
> On Thu, Aug 10, 2023 at 12:50:06AM +0800, Jisheng Zhang wrote:
> > The IP supports per channel interrupt, add support for this usage case.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> I do not see a response to
> <https://lore.kernel.org/all/20230808-clapper-corncob-0af7afa65752@spud/>
> in my mailbox or on lore, nor is there any changes in v3 on this front.

oops, sorry, I didn't mbsync to fetch my inbox before sending out v3, so
I missed your review comments ;)

I will reply in the thread
> 
> Thanks,
> Conor.
> 
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml   | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index 5d81042f5634..5a63302ad200 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -109,6 +109,7 @@ properties:
> >        - description: The interrupt that occurs when Rx exits the LPI state
> >        - description: The interrupt that occurs when Safety Feature Correctible Errors happen
> >        - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
> > +      - description: All of the rx/tx per-channel interrupts
> >  
> >    interrupt-names:
> >      minItems: 1
> > @@ -118,6 +119,38 @@ properties:
> >        - const: eth_lpi
> >        - const: sfty_ce
> >        - const: sfty_ue
> > +      - const: rx0
> > +      - const: rx1
> > +      - const: rx2
> > +      - const: rx3
> > +      - const: rx4
> > +      - const: rx5
> > +      - const: rx6
> > +      - const: rx7
> > +      - const: rx8
> > +      - const: rx9
> > +      - const: rx10
> > +      - const: rx11
> > +      - const: rx12
> > +      - const: rx13
> > +      - const: rx14
> > +      - const: rx15
> > +      - const: tx0
> > +      - const: tx1
> > +      - const: tx2
> > +      - const: tx3
> > +      - const: tx4
> > +      - const: tx5
> > +      - const: tx6
> > +      - const: tx7
> > +      - const: tx8
> > +      - const: tx9
> > +      - const: tx10
> > +      - const: tx11
> > +      - const: tx12
> > +      - const: tx13
> > +      - const: tx14
> > +      - const: tx15
> >  
> >    clocks:
> >      minItems: 1
> > -- 
> > 2.40.1
> > 


