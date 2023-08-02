Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F73F76CF66
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbjHBOAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbjHBOAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:00:37 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C762122;
        Wed,  2 Aug 2023 07:00:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372E0KxD084046;
        Wed, 2 Aug 2023 09:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690984820;
        bh=QzqUq95aQ6oOsHQEGnGJgGG3G9lbd6Qhpv7J5KatXFw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AchlSEZZiQeb+b18wnz2ff3sMHKWIggDanc0l3IzevUUB0QAatH+EUXxVP2mPVl6T
         Fr+Ph9NqTNRgXn1kg7RZIRS/YnTPGE/GuhFgk1KIhVdbOsUO9gMmJHGXHGopawJv2M
         8A+g3y4NLqOk80ZKCOqQ8EboKkX3hnIhbVGvvZbU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372E0Kjv109363
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 09:00:20 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 09:00:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 09:00:20 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372E0Kmh118210;
        Wed, 2 Aug 2023 09:00:20 -0500
Date:   Wed, 2 Aug 2023 09:00:20 -0500
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
Message-ID: <20230802140020.k233zqpjar5ag4iv@outbreak>
References: <20230731142135.108477-1-francesco@dolcini.it>
 <20230731142135.108477-2-francesco@dolcini.it>
 <itvg2zmmapbfmgbwos6c4y5zsc2rb3sffv2znhwz6i2vahe4y6@uu2547kcz5sd>
 <23C6E13C-3F10-490B-A18E-C67B91CBAF35@dolcini.it>
 <20230802133244.b66pg3mztotgqotm@steerable>
 <ZMpc7x8U91JLVakd@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMpc7x8U91JLVakd@francesco-nb.int.toradex.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:41-20230802, Francesco Dolcini wrote:
> On Wed, Aug 02, 2023 at 08:32:44AM -0500, Nishanth Menon wrote:
> > On 13:37-20230802, Francesco Dolcini wrote:
> > > Il 2 agosto 2023 13:23:50 CEST, Jai Luthra <j-luthra@ti.com> ha scritto:
> > > >On Jul 31, 2023 at 16:21:32 +0200, Francesco Dolcini wrote:
> > > >> From: Jai Luthra <j-luthra@ti.com>
> > > >> 
> > > >> On AM62-based SoCs the AUDIO_REFCLKx clocks can be used as an input to
> > > >> external peripherals when configured through CTRL_MMR, so add the
> > > >> clock nodes.
> > > >> 
> > > >> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > > >> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > >> ---
> > > >>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 18 ++++++++++++++++++
> > > >>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++++++
> > > >
> > > >Given currently none of the AM62A boards are using the refclks, can you 
> > > >drop those or just mark the nodes as disabled. Whoever is the first user 
> > > >can enable them.
> > > 
> > > I can drop the 2 clocks from AM62A, however, should we really do it?
> > > These clocks exist and they are just defined in the DTS, they are
> > > not going to be enabled if not used, "ti,am62-epwm-tbclk" is also
> > > not disabled for example.
> > 
> > Overall, the SoC clock as such has nothing to do with board specific, so
> > leave it default (enabled) in SoC.dts - just want to make sure that the
> > clk-parent selection doesn't get in the way of platforms and is a sane
> > default.
> 
> When I looked into that, months ago, this looked to me the correct and a
> sane default. I had the same in our downstream way before the addition
> from Jai Luthra to the SoC dtsi.
> 
> Not sure if Jai can add more on that regard.
> 
> > pll2_hsdiv8 output - which looks like the default mux value anyways..
> > I am ok for it being explicit, but wondering if that works for boards
> > that do not use this default.
> 
> IFF needed, it would be very easy to just override from the board dts,
> using the labels that are already there (audio_refclk0, audio_refclk1).

Jai: This sounds sane to me, if you are OK as well, I'd appreciate a reviewed-by

> 
> > (sidenote): Fransesco - your new mail client has line wrap issues ;)
> Yep, I had the crazy idea to reply from my mobile phone while having a
> walk. It's already a success that I did not top post ;-)

hehe ;)

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
