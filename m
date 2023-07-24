Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0625275F998
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjGXOPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjGXOPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A2B10E2;
        Mon, 24 Jul 2023 07:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1D4161213;
        Mon, 24 Jul 2023 14:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D08BC433C7;
        Mon, 24 Jul 2023 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690208079;
        bh=LcBzGcu8cVrPU7UOdv69Qy9MBw+HUBFHBZ8ZEqiYA7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3w7M18NfN8wHEy4MvyA5rAIA3HhCkqYs8txQ6Ud3x98Vctx5hZIW6gRHkHrQADAu
         qj9obGjkxps45h7nKoSwGiIjwTZuNpN0KvNA4lSyimkJOTdgmFNo1+m8Lehjo8koee
         Ry/H1V8/09khGZp5AXBgOANM6TC0j+YR+FUu2nwIr3zOepU/9k1V6ddfS7ms+boG3J
         7gbsyTDJoFKKUvGT+LSIztLbl4rVBG5OZM6MYWQA+Yhz2wMviqdlKXzj/qhHX5bU2s
         oCmqCmIaRp0rBJxadlbbMLFoCM8uGynvx7Z6G0TCd/qFUFaS35rYB9A4cnLF/4HyXK
         PMG2FcosvcbNQ==
Received: (nullmailer pid 3401627 invoked by uid 1000);
        Mon, 24 Jul 2023 14:14:35 -0000
Date:   Mon, 24 Jul 2023 08:14:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.com
Subject: Re: [PATCH 09/10] dt-bindings: marvell: Document PXA1908 SoC
Message-ID: <20230724141435.GA3378340-robh@kernel.org>
References: <20230721210042.21535-1-duje.mihanovic@skole.hr>
 <20230721210042.21535-10-duje.mihanovic@skole.hr>
 <5266764a-4551-4117-8aa4-bd435f63f450@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5266764a-4551-4117-8aa4-bd435f63f450@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 11:27:21AM +0200, Krzysztof Kozlowski wrote:
> On 21/07/2023 22:37, Duje Mihanović wrote:
> > Add dt bindings and documentation for Marvell PXA1908 SoC.
> > 
> > Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> > ---
> >  .../bindings/arm/marvell/marvell,pxa1908.yaml | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml
> > new file mode 100644
> > index 000000000000..085d238129ad
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml
> 
> I suggest having one bindings file for all pxa platforms, not per one SoC.

Or perhaps mirroring the new dts directory structure. PXA is really 
multiple families. This one is more aligned with MMP than the 
PXA2xx/3xx.

Rob
