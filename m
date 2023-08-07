Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C15772984
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjHGPmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjHGPmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:42:19 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254D4E3;
        Mon,  7 Aug 2023 08:42:18 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377Fg8OG118273;
        Mon, 7 Aug 2023 10:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691422928;
        bh=LxIuDrnugWUWf6Gc14SpD7v+KN8Q+LO0U/QjZXJYEtQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AYF7o6EYGwL6rEbUd/K1yFM4uXfBhyml+pqatjAX4oUQOvwNtCQSdjAkBtLYpFnmo
         Sj2quF7tEg9QiSUPj4/foVrsyRYqWrS17vvjLSbSKo7ha0WSSrnAir0n267JLclxgr
         1Emv/gqAN85bAnmuDQ314n1b02NIw4uYjMublQLk=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377Fg8hc124586
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 10:42:08 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 10:42:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 10:42:07 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377Fg73T091750;
        Mon, 7 Aug 2023 10:42:07 -0500
Date:   Mon, 7 Aug 2023 10:42:07 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Dhruva Gole <d-gole@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/13] arm64: dts: ti: k3-j7200: Enable GPIO nodes at the
 board level
Message-ID: <20230807154207.7eho6er55revipjo@shuffling>
References: <20230802205309.257392-1-afd@ti.com>
 <20230802205309.257392-11-afd@ti.com>
 <ea932535-b69c-ec57-0dfe-31a891b6df5c@ti.com>
 <1b3366b0-e3a4-3609-9e25-7b880d2fe656@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b3366b0-e3a4-3609-9e25-7b880d2fe656@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:28-20230807, Andrew Davis wrote:
> On 8/7/23 12:38 AM, Dhruva Gole wrote:
> > Andrew,
> > 
> > On 03/08/23 02:23, Andrew Davis wrote:
> > > GPIO nodes defined in the top-level J7200 SoC dtsi files are incomplete
> > > and may not be functional unless they are extended with pinmux and
> > > device information.
> > > 
> > > Disable the GPIO nodes in the dtsi files and only enable the ones that
> > > are actually pinned out on a given board.
> > > 
> > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > ---
> > >   .../boot/dts/ti/k3-j7200-common-proc-board.dts | 18 ++++--------------
> > >   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi      |  4 ++++
> > >   .../arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi |  2 ++
> > >   3 files changed, 10 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> > > index dee9056f56051..4a5c4f36baeec 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> > > +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> > > @@ -240,27 +240,17 @@ &main_uart3 {
> > >       pinctrl-0 = <&main_uart3_pins_default>;
> > >   };
> > > -&main_gpio2 {
> > > -    status = "disabled";
> > > -};
> > > -
> > > -&main_gpio4 {
> > > -    status = "disabled";
> > > -};
> > > -
> > > -&main_gpio6 {
> > > -    status = "disabled";
> > > +&main_gpio0 {
> > > +    status = "okay";
> > > +    /* default pins */
> > 
> > Small question, where is the pmx for main_gpio0? What does "default pins"
> > refer to here? Where are they pinmuxed?
> > 
> 
> Good question, where is the pmx for main_gpio0? I don't know, it was
> never defined before either, we only are noticing this now as we are
> disabling by default instead of leaving an unfinished node enabled
> by default. (another benefit of this disabled by default scheme).
> 
> What is really happening is GPIO nodes we tend to pinmux differently
> than normal device nodes. Their pinmux selections tends to be spread
> out in all the nodes that make use of these GPIO pins, not all together
> here in this node.
> 
> For instance in this device we use one of the main_gpio0 pins as a
> GPIO toggled regulator, and we define the pinmux for it in that node
> (see vdd-sd-dv-default-pins).
> 
> We can either define the rest of the pins not used elsewhere
> here, or we can consider GPIO an exception to the rule, I'd say
> the latter is fine for now.


GPIO pinmux are typically defined where they need - the only place where
they are explicitly called out in gpio is when they are meant to be used by
libgpio - typically in the case of dev boards.

Just drop the comments of /* default pins */ - that is just mis-leading.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
