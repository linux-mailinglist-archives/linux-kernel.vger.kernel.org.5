Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044D576763F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjG1TXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjG1TXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:23:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561EC11B;
        Fri, 28 Jul 2023 12:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE52F621D2;
        Fri, 28 Jul 2023 19:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECB7C433C8;
        Fri, 28 Jul 2023 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690572181;
        bh=bpqmvFe1tBhOBmXbLXPISbiAb+pX9YpEUC+7p3McqTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRHDQYe/a5s6LPy4yxR4fRYhyw0pfaCgRNW+brnvs2gUHBg2DaouOF79k9+AOLEJP
         2E1Zr/jKibWAED9g3HemurePVU35CxA1MCn82DgRbp8dObtLXFbz7hGLIXfKbkezHC
         aUb52JfUHDu96Aocn23T8uRf8e6CuOTGJNZbBlD4ZvhvyVqzPCfgqpieul2yy7gTEa
         hmEbt3OooIzM6DobGUyp2A3q7SWzchp/p3lQihsWCFhaVDy05uCn6EVDT51iWEI6vo
         mWKMM9K7iBIL+n5JQO5yPvoQhTRUCoUshi42AMLkGs9KgwM4OlMwbAZ5uLrUOUVdXQ
         M0Z6uPDCWzRNw==
Received: (nullmailer pid 1168530 invoked by uid 1000);
        Fri, 28 Jul 2023 19:22:59 -0000
Date:   Fri, 28 Jul 2023 13:22:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 33/50] dt-bindings: usb: add sam9x7
Message-ID: <20230728192259.GA1164895-robh@kernel.org>
References: <20230728102843.266967-1-varshini.rajendran@microchip.com>
 <c03f4364-3d97-531a-8acc-aae68de39562@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c03f4364-3d97-531a-8acc-aae68de39562@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 01:48:01PM +0200, Krzysztof Kozlowski wrote:
> On 28/07/2023 12:28, Varshini Rajendran wrote:
> > Document sam9x7 compatible for usb ohci.
> > 
> > Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/usb/generic-ohci.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> > index be268e23ca79..a2490759f694 100644
> > --- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> > +++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> > @@ -57,6 +57,12 @@ properties:
> >                - nxp,ohci-nxp
> >                - st,spear600-ohci
> >            - const: usb-ohci
> > +      - items:
> > +          - enum:
> > +              - microchip,sam9x7-ohci
> > +          - enum:
> 
> That's not an enum. You cannot have here different compatibles.
> 
> > +              - atmel,at91rm9200-ohci
> > +          - const: usb-ohci

As mentioned elsewhere, you aren't really compatible having custom 
properties. If you are adding this here, then stuff should be removed 
from the .txt binding. You need to sort out this mess and the existing 
warnings with 'usb-ohci' in Atmel dts files before adding on to it.

Rob
