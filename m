Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679CC76CECC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjHBNdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjHBNdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:33:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62C42698;
        Wed,  2 Aug 2023 06:32:59 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372DWjkj010348;
        Wed, 2 Aug 2023 08:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690983165;
        bh=Pb47ihHgkkg82VFKhKRzgf6jhYh9u+kVldNcXUkLblI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=mbta5YWRD5beShU13K60yykpsYwzLo+4NlR0GNoRbNaTN4rO622GKclgQHnyu/5Q1
         L/pi8JKkZlKSQGumzQyU4IFXgL1UGnEu7I7fo5vYKg8ay55BywC2Yw2afCi30z3L/I
         sU5QRdjuQwN9dfDqopDCzZgajQhJQw9T4v3/2Nns=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372DWj8p093641
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 08:32:45 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 08:32:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 08:32:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372DWiNZ093450;
        Wed, 2 Aug 2023 08:32:44 -0500
Date:   Wed, 2 Aug 2023 08:32:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Jai Luthra <j-luthra@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/4] arm64: dts: ti: k3-am62x: Enable AUDIO_REFCLKx
Message-ID: <20230802133244.b66pg3mztotgqotm@steerable>
References: <20230731142135.108477-1-francesco@dolcini.it>
 <20230731142135.108477-2-francesco@dolcini.it>
 <itvg2zmmapbfmgbwos6c4y5zsc2rb3sffv2znhwz6i2vahe4y6@uu2547kcz5sd>
 <23C6E13C-3F10-490B-A18E-C67B91CBAF35@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23C6E13C-3F10-490B-A18E-C67B91CBAF35@dolcini.it>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:37-20230802, Francesco Dolcini wrote:
> 
> 
> Il 2 agosto 2023 13:23:50 CEST, Jai Luthra <j-luthra@ti.com> ha scritto:
> >Hi Francesco,
> >
> >Thank you for posting this patch.
> >
> >On Jul 31, 2023 at 16:21:32 +0200, Francesco Dolcini wrote:
> >> From: Jai Luthra <j-luthra@ti.com>
> >> 
> >> On AM62-based SoCs the AUDIO_REFCLKx clocks can be used as an input to
> >> external peripherals when configured through CTRL_MMR, so add the
> >> clock nodes.
> >> 
> >> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> >> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> >> ---
> >>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 18 ++++++++++++++++++
> >>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++++++
> >
> >Given currently none of the AM62A boards are using the refclks, can you 
> >drop those or just mark the nodes as disabled. Whoever is the first user 
> >can enable them.
> 
> I can drop the 2 clocks from AM62A, however, should we really do it? These clocks exist and they are just defined in the DTS, they are not going to be enabled if not used, "ti,am62-epwm-tbclk" is also not disabled for example.

Overall, the SoC clock as such has nothing to do with board specific, so
leave it default (enabled) in SoC.dts - just want to make sure that the
clk-parent selection doesn't get in the way of platforms and is a sane
default.

I find audio clock muxing a bit of a pain (only next to DSS clocking,
but that is another story).. so will depend on you folks for help.
Looking at https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am62ax/clocks.html#clocks-for-board0-device
and Clocking spec, setting this:
+			assigned-clocks = <&k3_clks 157 0>;
+			assigned-clock-parents = <&k3_clks 157 8>;
as default implies:
pll2_hsdiv8 output - which looks like the default mux value anyways.. I
am ok for it being explicit, but wondering if that works for boards that
do not use this default.

Could you guys confirm?

(sidenote): Fransesco - your new mail client has line wrap issues ;)
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
