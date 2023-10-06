Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ABB7BBCB1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjJFQ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjJFQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:27:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF293AD;
        Fri,  6 Oct 2023 09:27:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE25C433C8;
        Fri,  6 Oct 2023 16:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696609626;
        bh=SVGR/dgN3Ia2g/ceGF5AhDwZ0Sefym/pCcWKrkUlFKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CITwWzMH2g2fBjiW+AXqbUZj0vPTcGj7f8bAVh7Oe5DcE97YDA2mheL32aZ+K5jNI
         pKS6nY0cQ8JxKwOKttq6+T8BWP3EdbF5sjzFixfOJfCTM8e1OmLn7nn28iKhjxFqYQ
         n2G9es+KaFUV+lPkfNJx3q3iAvihKyW6Fw0NCdOBEJKaxMImWeFxATrjN1swsvEMaZ
         07UlLpaTtQKPU60RnfeNGam5IGSnqJQfE+yXfuPRlYdA4JjjHtrNir/sa6qSchQhj9
         3qYXuB4ar4+AfHVgKOLQwLoMF81K7ilczQ8k9YrXGMb0mZxjNFAxBan8I31OL15+NH
         Xv4RGfNvG8G2w==
Received: (nullmailer pid 4034213 invoked by uid 1000);
        Fri, 06 Oct 2023 16:27:03 -0000
Date:   Fri, 6 Oct 2023 11:27:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: Re: [PATCH 3/7] dt-bindings: media: Document STM32MP25 VENC video
 encoder
Message-ID: <20231006162703.GA4030032-robh@kernel.org>
References: <20231004091552.3531659-1-hugues.fruchet@foss.st.com>
 <20231004091552.3531659-4-hugues.fruchet@foss.st.com>
 <CAHCN7xKrriTPaRMJ-r86cSgFDUUP1At08imLBr_zEP0g3fga_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xKrriTPaRMJ-r86cSgFDUUP1At08imLBr_zEP0g3fga_g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 06:41:09PM -0500, Adam Ford wrote:
> On Wed, Oct 4, 2023 at 4:16 AM Hugues Fruchet
> <hugues.fruchet@foss.st.com> wrote:
> >
> > Add STM32MP25 VENC video encoder bindings.
> >
> > Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> > ---
> >  .../bindings/media/st,stm32mp25-venc.yaml     | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml b/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml
> > new file mode 100644
> > index 000000000000..c69e0a34f675
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/st,stm32mp25-venc.yaml#
> 
> Can this dt-binding be made more generic, like something like
> hantro-h1 or VC8000NanoE?
> 
> I think there will be more boards that may incorporate the Hantro-H1
> or a VC8000 in the future, because I don't think this IP is unique to
> the STM32MP25.

Unless the underlying IP is well documented (i.e. public), then it's 
kind of pointless. Everyone will just invent their own numbers and names 
of clocks, resets, etc. unless someone can enforce not doing that.

Rob
