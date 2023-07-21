Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9B75C601
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGULlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjGULlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:41:47 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C202D4D;
        Fri, 21 Jul 2023 04:41:45 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 15021209F8;
        Fri, 21 Jul 2023 13:41:40 +0200 (CEST)
Date:   Fri, 21 Jul 2023 13:41:35 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/3] ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6 SoM
 support
Message-ID: <ZLpu72xDla42x7J8@francesco-nb.int.toradex.com>
References: <20230721103350.3684483-1-james.hilliard1@gmail.com>
 <20230721103350.3684483-2-james.hilliard1@gmail.com>
 <3492152a-d668-54ba-7cb4-4db8bfec6f03@linaro.org>
 <CADvTj4r8oVyghXN_4ONMBfhMqHGNPJN517kB6X1FfwUmB16OFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4r8oVyghXN_4ONMBfhMqHGNPJN517kB6X1FfwUmB16OFQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 05:05:51AM -0600, James Hilliard wrote:
> On Fri, Jul 21, 2023 at 4:43 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 21/07/2023 12:33, James Hilliard wrote:
> > > +             compatible = "regulator-fixed";
> > > +             regulator-name = "touch_3v3_supply";
> > > +             regulator-always-on;
> >
> > Also, missing constraints.
> 
> Hmm, what's the correct way to determine the constraint values?

You should know/understand the hardware design. Normally when writing a
DT file you have the hardware schematics and the relevant datasheets
available.

> I'm guessing they should just be set to this based on the name?:
> regulator-min-microvolt = <3300000>;
> regulator-max-microvolt = <3300000>;

This looks like a good guess, assuming that the regulator name is
correct.

Francesco

