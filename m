Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73B5771C08
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjHGIJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHGIJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:09:30 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839D1170A;
        Mon,  7 Aug 2023 01:09:29 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37789NeD088783;
        Mon, 7 Aug 2023 03:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691395763;
        bh=qXreic1jeDVpRWpVaJNwZXPhQDgIeVSEDk98xTOHGBY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xhI9Yiuz1Uumh52CcWtha1h6ubD29E+hDHlxmTz9RdmGawemMH5Mc3q7pnGgqxgTx
         YzQcV9BB01dN1Uy/1N//ldg8zBWHJj1x8WaMj97WjTBXPXSTD4Oli984K+cV2uGjm5
         PEktHsDE6401V/UO9C7P9dCj7xcnkNznml0QUngY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37789Nxt095413
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 03:09:23 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 03:09:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 03:09:23 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37789MwN023168;
        Mon, 7 Aug 2023 03:09:23 -0500
Date:   Mon, 7 Aug 2023 13:39:22 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Nishanth Menon <nm@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] pinctrl: single: Add compatible for ti,am625-padconf
Message-ID: <20230807080922.t35yvyvrknjcriyr@dhruva>
References: <20230805045554.786092-1-d-gole@ti.com>
 <20230805171508.schg4xquoa24klk5@october>
 <20230807070724.GN14799@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230807070724.GN14799@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 07, 2023 at 10:07:24 +0300, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [230805 17:15]:
> > On 10:25-20230805, Dhruva Gole wrote:
> > > From: Tony Lindgren <tony@atomide.com>
> > > +static const struct pcs_soc_data pinctrl_single_am625 = {
> > > +	.flags = PCS_QUIRK_SHARED_IRQ | PCS_CONTEXT_LOSS_OFF,
> > > +	.irq_enable_mask = (1 << 29),   /* WKUP_EN */
> > > +	.irq_status_mask = (1 << 30),   /* WKUP_EVT */
> > > +};
> > > +
> > 
> > Why cant we set this in the k3-pinctrl.h and set it once?

Do you mean that I set 1 << 29 and 30 as sort of macros in the
k3-pinctrl.h file and then include it in pinctrl-single.c?

Are we okay to #include a header from arch/arm64/boot/dts/ti?

> 
> Good idea to define the bit offsets k3-pinctrl.h instead of magic numbers
> here :)

If I understand what Nishanth is saying correctly, are we expected to
set the wake_en bit on every single K3 SoC's every single padconf reg?

I am a little sceptical with this approach, because what is people
_don't_ want to wakeup from certain pads? What would be the right way to
disable wakeup on those pads then?

> 
> > The event will not be generated until wakeup daisy chain is triggered
> > anyways.

Any voltage level shift can potentially trigger a daisychain and I don't
think that's really such a good idea?

> 
> Yup, and having that happen is enough to show the wake-up reason with
> grep wakeup /proc/interrupts :)
> 
> > Have you looked at all the padconf registers across devices to ensure
> > the WKUP_EN/EVT bits are present? daisy chain feature is used elsewhere
> > as well.

In my limited experience, I have only seen daisychain wakeups being
enabled on AM62x SOC. This is because this is one of the first K3
devices to implement deepsleep, and I think IO daisychain only applies for
wakeups in the case of deepsleep kind of scenarios.

> 
> The lack of bits at least earlier just meant that attempting to use a
> wake-up interrupt would just never trigger. Worth checking though.
> Dhruva, care to check if some padconf register have reserved bits for
> 29 and 30 that might be set high by default?

Sure, I could take a look, but setting wake_en on all pads still
doesn't feel right to me.

> 
> Regards,
> 
> Tony

To summarise, I don't think any other devices are using daisychain
atleast today, and even if there is possibility of using in future I
think the same compatible I have used here can be used to set wake_en
wherever applicable, for eg. whenever AM62A would want to use daisychain
it can use this quirk in it's DT node.

I believe that we shouldn't set every pad as daisychain enabled
otherwise in deepsleep it may result in unintended wakeups. And the way
I thought we can give this choice to the user is using wakeirq chained
interrupt along with this quirk,
compatible = "ti,am6-padconf";

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
