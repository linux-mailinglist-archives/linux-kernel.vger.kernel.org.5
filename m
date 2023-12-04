Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DDA8041AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjLDW1b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 17:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjLDW13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:27:29 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D4285;
        Mon,  4 Dec 2023 14:27:34 -0800 (PST)
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1rAHPS-0071Vx-0b; Mon, 04 Dec 2023 23:27:26 +0100
Date:   Mon, 4 Dec 2023 23:27:22 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Adam Ford <aford173@gmail.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 6/6] ARM: dts: omap: gta04: standardize
 system-power-controller
Message-ID: <20231204232722.031f618c@aktux>
In-Reply-To: <CAHCN7xKG6-vgnJ+mA8xt0aFK-jCBWOX-GkVmJGNERH43N0ikaw@mail.gmail.com>
References: <20231203222903.343711-1-andreas@kemnade.info>
        <20231203222903.343711-7-andreas@kemnade.info>
        <CAHCN7xKG6-vgnJ+mA8xt0aFK-jCBWOX-GkVmJGNERH43N0ikaw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2023 16:46:20 -0600
Adam Ford <aford173@gmail.com> wrote:

> On Sun, Dec 3, 2023 at 4:29 PM Andreas Kemnade <andreas@kemnade.info> wrote:
> >
> > Replace TI-specific property by generic one.
> >
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > cannot be applied independently of the other ones, so maybe simply delay
> > it.
> >
> >  arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
> > index 3661340009e7a..5001c4ea35658 100644
> > --- a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
> > +++ b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
> > @@ -476,6 +476,7 @@ twl: twl@48 {
> >                 reg = <0x48>;
> >                 interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> >                 interrupt-parent = <&intc>;
> > +               system-power-controller;  
> 
> Could this go into the twl4030.dtsi file so we don't have every omap3
> board with this part duplicating this line?
> 
Well, that is a board-specific issue, so I do not think it belongs there,
although quite common to have the twl4030 as the system-power-controller.

Regards,
Andreas
