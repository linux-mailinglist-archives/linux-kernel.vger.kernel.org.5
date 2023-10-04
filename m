Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA4C7B7E81
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbjJDLzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjJDLy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:54:59 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2159FA1;
        Wed,  4 Oct 2023 04:54:56 -0700 (PDT)
Received: from pd9e2f797.dip0.t-ipconnect.de ([217.226.247.151] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qo0So-004Vmh-UI; Wed, 04 Oct 2023 13:54:50 +0200
Date:   Wed, 4 Oct 2023 13:54:48 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap3-gta04: Drop superfluous omap36xx
 compatible
Message-ID: <20231004135449.591b3f6c@aktux>
In-Reply-To: <FF3A3F35-E264-4D28-AFAC-EFA2ADB69F40@goldelico.com>
References: <20231004065323.2408615-1-andreas@kemnade.info>
        <12323F42-3611-4685-8981-F6A18C4A5862@goldelico.com>
        <20231004130353.01228376@aktux>
        <FF3A3F35-E264-4D28-AFAC-EFA2ADB69F40@goldelico.com>
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

On Wed, 4 Oct 2023 13:39:03 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > Am 04.10.2023 um 13:03 schrieb Andreas Kemnade <andreas@kemnade.info>:
> > 
> > On Wed, 4 Oct 2023 12:50:16 +0200
> > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> >   
> >> Hi Andreas,
> >>   
> >>> Am 04.10.2023 um 08:53 schrieb Andreas Kemnade <andreas@kemnade.info>:
> >>> 
> >>> Drop omap36xx compatible as done in other omap3630 devices.
> >>> This has apparently fallen through the lattice.
> >>> 
> >>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >>> ---
> >>> arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi | 2 +-
> >>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>> 
> >>> diff --git a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
> >>> index b6b27e93857f..3661340009e7 100644
> >>> --- a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
> >>> +++ b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
> >>> @@ -11,7 +11,7 @@
> >>> 
> >>> / {
> >>> 	model = "OMAP3 GTA04";
> >>> -	compatible = "goldelico,gta04", "ti,omap3630", "ti,omap36xx", "ti,omap3";    
> >> 
> >> there seem to be some more references to ti,omap36xx:
> >> 
> >> arch/arm/boot/dts/ti/omap/omap3-lilly-a83x.dtsi:	compatible = "incostartec,omap3-lilly-a83x", "ti,omap3630", "ti,omap36xx", "ti,omap3";  
> > 
> > apperently all the dtsi are fallen through the lattice when handling the dts.
> > 
> >   
> >> arch/arm/mach-omap2/board-generic.c:	"ti,omap36xx",
> >> drivers/clk/ti/dpll.c:	     of_machine_is_compatible("ti,omap36xx")) &&
> >> drivers/cpufreq/ti-cpufreq.c:	{ .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
> >> 
> >> So are you sure that we can remove it without replacement or code fixes in dpll and cpufreq (board-generic is probably no issue)?
> >>   
> > see discussion of:
> > 
> > commit e341f338180c84cd98af3016cf5bcfde45a041fb
> > Author: Andrew Davis <afd@ti.com>
> > Date:   Thu Feb 16 09:33:38 2023 -0600
> > 
> >    ARM: dts: omap: Drop ti,omap36xx compatible  
> 
> Ah, I wasn't aware of this.
> 
> > 
> > all the places also basically check for omap36xx || omap3630.  
> 
> 
> Yes, I have checked but drivers/cpufreq/ti-cpufreq.c seems to be an
> exception (unless I am missing some other patch).
> 
No:
        { .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
        { .compatible = "ti,omap3630", .data = &omap36xx_soc_data, },

The bindings also only specify omap3630.

Regards,
Andreas
