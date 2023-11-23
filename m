Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFD67F5AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjKWI6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWI6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:58:38 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A3111F;
        Thu, 23 Nov 2023 00:58:42 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 52474201D4;
        Thu, 23 Nov 2023 09:58:37 +0100 (CET)
Date:   Thu, 23 Nov 2023 09:58:33 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>
Cc:     Parth Pancholi <parth105105@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Parth Pancholi <parth.pancholi@toradex.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1] arm64: dts: k3-am625-verdin: enable Verdin UART2
Message-ID: <ZV8UOTSTl6spUXt5@francesco-nb.int.toradex.com>
References: <20231121160436.1032364-1-parth105105@gmail.com>
 <20231123071235.omgxs3ixnojpkfvu@greeter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123071235.omgxs3ixnojpkfvu@greeter>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nishanth,

On Thu, Nov 23, 2023 at 01:12:35AM -0600, Nishanth Menon wrote:
> On 17:04-20231121, Parth Pancholi wrote:
> >  /* Verdin UART_2 */
> >  &wkup_uart0 {
> > -	/* FIXME: WKUP UART0 is used by DM firmware */
> > -	status = "reserved";
> > +	status = "okay";
> >  };
> > -- 
> > 2.34.1
> > 
> 
> Do the &pinctrl_wkup_uart0 in verdin.dtsi hold good through these
> variants?
Yes.

Let me add a little bit of context.

In general the way the Verdin AM62 (and Toradex SOM) is designed is that
we have a standard pinmuxing on the module edge connector (SODIMM) and
normally the carrier board that is mated with just implements it.
It's absolutely possible to redefine it all, but to maximize
compatibility across the family what we do at most is to reconfigure
some pins as GPIO.

Francesco

