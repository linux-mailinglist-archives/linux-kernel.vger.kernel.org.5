Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1078006AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377977AbjLAJS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:18:56 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778BE194
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:19:02 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 47991207A1;
        Fri,  1 Dec 2023 10:18:58 +0100 (CET)
Date:   Fri, 1 Dec 2023 10:18:54 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Message-ID: <ZWmk/t7wPJW71emR@francesco-nb.int.toradex.com>
References: <20231130231657.12715-1-francesco@dolcini.it>
 <20231201060346.GE5169@atomide.com>
 <20231201064919.5mbmqo5fco7n3rgq@endnote>
 <ZWmdyenBpqI1S8HG@francesco-nb.int.toradex.com>
 <20231201085957.uxvwe3l33n5fxfw4@unrushed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201085957.uxvwe3l33n5fxfw4@unrushed>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 02:59:57AM -0600, Nishanth Menon wrote:
> On 09:48-20231201, Francesco Dolcini wrote:
> > On Fri, Dec 01, 2023 at 12:49:19AM -0600, Nishanth Menon wrote:
> > > On 08:03-20231201, Tony Lindgren wrote:
> > > > * Francesco Dolcini <francesco@dolcini.it> [231130 23:17]:
> > > > > Increase CONFIG_SERIAL_8250_NR_UARTS from 4 to 8, the current legacy value
> > > > > is not adequate for embedded systems that use SoCs where it's common to
> > > > > have a large number of serial ports.
> > > > > 
> > > > > No need to change CONFIG_SERIAL_8250_RUNTIME_UARTS, see commit 9d86719f8769
> > > > > ("serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS").
> > > > > 
> > > > > This enables using the UART connected Bluetooth device on Verdin AM62
> > > > > board.
> > > 
> > > I'd prefer to get Arnd's view on the topic as well (I kind of
> > > recollect some historic discussion which I am not failing to trace
> > > that there usage model doesn't exceed 4 and aliases could be used to
> > > map these as required for the platform).
> > 
> > The usage model that triggered this change exceed 4, we >4 uart in
> > use at the same time.
> > 
> > And the issue is not really "distro use", and I do not think anything
> > about aliases matter (the BT device is described as a child of the uart
> > in the DT).
> > 
> >   &main_uart5 {
> >     bluetooth {
> >       compatible = "nxp,88w8987-bt";
> >     };
> >   };
> > 
> > The change here is required to have basic hardware functionalities
> > working for kernel development and debugging using the in-tree
> > defconfig.
> 
> I'd suggest to elaborate on "This enables using the UART connected
> Bluetooth device on Verdin AM62 board."

I can do this, of course, I'll wait for some more feedback in the coming
days as you somehow already suggested.

Francesco

