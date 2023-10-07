Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E4C7BC60D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjJGIaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjJGIaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:30:03 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09676B9;
        Sat,  7 Oct 2023 01:30:02 -0700 (PDT)
Received: from p5dc58360.dip0.t-ipconnect.de ([93.197.131.96] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qp2hA-004c4W-Rb; Sat, 07 Oct 2023 10:29:56 +0200
Date:   Sat, 7 Oct 2023 10:29:54 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        bcousson@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: omap4-embt2ws: Add Bluetooth
Message-ID: <20231007102954.2eeb5edc@aktux>
In-Reply-To: <20231007072442.GW34982@atomide.com>
References: <20231004070309.2408745-1-andreas@kemnade.info>
        <6b4968d9-80d3-4a5a-b42e-3982825e45e9@linaro.org>
        <20231007070015.GS34982@atomide.com>
        <20231007072442.GW34982@atomide.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Sat, 7 Oct 2023 10:24:42 +0300
Tony Lindgren <tony@atomide.com> wrote:

> * Tony Lindgren <tony@atomide.com> [231007 07:00]:
> > * Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [231005 08:47]:  
> > > On 04/10/2023 09:03, Andreas Kemnade wrote:  
> > > > Since the required clock is now available, add bluetooth.
> > > > 
> > > > Note: Firmware (bts file) from device vendor reroutes tx for some time
> > > > during initialisation and later put it back, producing timeouts in
> > > > bluetooth initialisation but ignoring that command leads to proper
> > > > initialisation.
> > > > 
> > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > ---  
> > > 
> > > 
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
> > 
> > Applying into omap-for-v6.7/dt thanks.  
> 
> Looks like this causes the following #clock-cells warning so dropping
> this patch.
> 
> Regards,
> 
> Tony
> 
> arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts:457462.4: Warning (clocks_property):
> /ocp/interconnect@48000000/segment@0/target-module@6c000/serial@0/bluetooth-gnss:
> Missing property '#clock-cells' in node /ocp/interconnect@48000000/segment@0/targe
> 
> 
well, it depends on the wlan dts patch. I think we are better of with having
both applied now. It is a better description of the hardware, and that is what
the devicetree is about. Having wlan randomly working without undocumented
description is IMHO worse than with a clear description.
The reason why this did not come to light earlier is because I had tested it on top
of a bunch of regression fixes for the twl (which were accepted at that point) 
and I did miss the fact that I had also a had a local hack amoung them to enable
the clock by a simple register write in _probe it twl-core.c.

I think as Stephen has little comments about the last version and just not
collected anything else than fixes for -rc, I would think it simply will be
applied. I think he just has a late start.

Regards,
Andreas
