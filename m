Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AF675FBDE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjGXQWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGXQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:22:52 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43BB90;
        Mon, 24 Jul 2023 09:22:50 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id B3715209ED;
        Mon, 24 Jul 2023 18:22:48 +0200 (CEST)
Date:   Mon, 24 Jul 2023 18:22:44 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Judith Mendez <jm@ti.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: ti: k3-am62: Add MCU MCAN nodes
Message-ID: <ZL6lVGklNclkVu58@francesco-nb.int.toradex.com>
References: <20230724133612.37366-1-francesco@dolcini.it>
 <20230724133612.37366-2-francesco@dolcini.it>
 <42044653-cc22-131a-bf1b-e68ddfa0ff9d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42044653-cc22-131a-bf1b-e68ddfa0ff9d@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Judith,

On Mon, Jul 24, 2023 at 11:06:24AM -0500, Judith Mendez wrote:
> On 7/24/23 8:36 AM, Francesco Dolcini wrote:
> > From: Judith Mendez <jm@ti.com>
> > 
> > On AM62x there are no hardware interrupts routed to A53 GIC
> > interrupt controller for MCU MCAN IPs, so MCU MCAN nodes were
> > omitted from MCU dtsi.
> > 
> > Timer polling was introduced in commits [1][2] so now add MCU MCAN nodes
> > to the MCU dtsi for the Cortex A53.
> > 
> > [1] b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
> > [2] bb410c03b999 ("dt-bindings: net: can: Remove interrupt properties for MCAN")
> > 
> > Signed-off-by: Judith Mendez <jm@ti.com>
> > [fd: fixed labels to match datasheet numbering, revised commit message,
> >       fixed reg/reg-names order]
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---

...

> Thanks for sending this patch, will also send for AM62ax.

Please have a look at the couple of changes I did:
 - corrected the label to be coherent with the datasheet and the other
   peripheral names
 - inverted "m_can" and "message_ram" regs/regs-names to fix a binding
   checker error.

These might be relevant also for the AM62a.

Francesco

