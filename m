Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FDB7EA456
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjKMUI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjKMUIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:08:21 -0500
X-Greylist: delayed 18527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Nov 2023 12:08:17 PST
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0327C173D;
        Mon, 13 Nov 2023 12:08:16 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id A464F1F8F7;
        Mon, 13 Nov 2023 21:08:14 +0100 (CET)
Date:   Mon, 13 Nov 2023 21:08:10 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Conor Dooley <conor@kernel.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: usb: microchip,usb5744: Add second
 supply
Message-ID: <ZVKCKop2zxI5FvCv@francesco-nb.int.toradex.com>
References: <20231113145921.30104-1-francesco@dolcini.it>
 <20231113145921.30104-2-francesco@dolcini.it>
 <20231113-jargon-manliness-584f34a5cf85@squawk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113-jargon-manliness-584f34a5cf85@squawk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Conor,
thanks for the review.

On Mon, Nov 13, 2023 at 07:55:20PM +0000, Conor Dooley wrote:
> On Mon, Nov 13, 2023 at 03:59:20PM +0100, Francesco Dolcini wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > The USB5744 has two power supplies one for 3V3 and one for 1V2. Add the
> > second supply to the USB5744 DT binding.
> > 
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  .../devicetree/bindings/usb/microchip,usb5744.yaml         | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> > index ff3a1707ef57..6d4cfd943f58 100644
> > --- a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> > +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> > @@ -36,7 +36,11 @@ properties:
> >  
> >    vdd-supply:
> >      description:
> > -      VDD power supply to the hub
> > +      3V3 power supply to the hub
> > +
> > +  vdd2-supply:
> > +    description:
> > +      1V2 power supply to the hub
> 
> How about v1p2-supply?

The reason for vdd2 is this

/*
 * Use generic names, as the actual names might differ between hubs. If a new
 * hub requires more than the currently supported supplies, add a new one here.
 */
static const char * const supply_names[] = {
	"vdd",
	"vdd2",
};

from drivers/usb/misc/onboard_usb_hub.c.

Francesco

