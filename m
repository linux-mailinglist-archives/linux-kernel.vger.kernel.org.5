Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F3076EE62
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbjHCPm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbjHCPmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:42:23 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3086110C1;
        Thu,  3 Aug 2023 08:42:19 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373Fg676087141;
        Thu, 3 Aug 2023 10:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691077326;
        bh=PkhrIUr7nxDD4Ybk8WFkTUCLABhbozcH9qeb4sfUXRE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=CDh327RMz5gZM+TUhQ+QQX/c+bO9JF1ofSTyHxSgZyenzPsEV85J3/uMcM/EiV4hr
         BpYLnGeCt74qo+oBoFy8jlQ+U/aL4ovIJTNt6ZGuQrCMF6vz1H6dLoOzFT0j7DzSyk
         oDr4pWtJkLaewwwFdZ4R5lpa6e/1eP7D196h9wkA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373Fg6hj063629
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 10:42:06 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 10:42:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 10:42:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373Fg5fe027876;
        Thu, 3 Aug 2023 10:42:05 -0500
Date:   Thu, 3 Aug 2023 21:12:04 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        "Santosh Shilimkar" <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH V6 1/4] firmware: ti_sci: Introduce Power Management Ops
Message-ID: <20230803154204.iyohslrpma7bqqpk@dhruva>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-2-d-gole@ti.com>
 <930ffb16-f212-0bcb-4713-2acc138c4035@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <930ffb16-f212-0bcb-4713-2acc138c4035@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 03, 2023 at 10:14:03 -0500, Andrew Davis wrote:
[..snip..]
> >   #define TI_SCI_IRQ_SECONDARY_HOST_INVALID	0xff
> >   /**
> > diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> > index bd0d11af76c5..f2d1d74ab8fc 100644
> > --- a/include/linux/soc/ti/ti_sci_protocol.h
> > +++ b/include/linux/soc/ti/ti_sci_protocol.h
> > @@ -195,6 +195,49 @@ struct ti_sci_clk_ops {
> >   			u64 *current_freq);
> >   };
> > +/* TISCI LPM wake up sources */
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_I2C0	0x00
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_UART0	0x10
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_GPIO0	0x20
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_ICEMELTER0	0x30
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER0	0x40
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER1	0x41
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_RTC0	0x50
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_RESET		0x60
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB0		0x70
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB1		0x71
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MAIN_IO		0x80
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_IO		0x81
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_CAN_IO		0x82
> > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_INVALID		0xFF
> 
> I don't see these used in this series, do you need them? lpm_wake_reason()

True, we are not currently using these macros. They _maybe required in
future.
I can remove them if required?

> doesn't seem used either and I'm not sure how you plan to use it, could
> you detail that?

When the system wakes from suspend-to-mem we can check which
subsystem has woken us up with the TISCI LPM_WAKEUP_REASON message.
There's no hardware event generated and we have to ask the firmware
for the actual wake reason.

We may want to add support for a wake up interrupt controller that will
generate an interrupt for other subsystems. This might end up using this
lpm_wake_reason API, hence even though the function maybe unused today
it will be required for above described scenario.

However if you prefer that I remove it and then add it in future when we
finally write a working interrupt controller driver, then do let me
know.

> 
> Andrew
> 
> > +
> > +/* TISCI LPM IO isolation control values */
> > +#define TISCI_MSG_VALUE_IO_ENABLE			1
> > +#define TISCI_MSG_VALUE_IO_DISABLE			0
> > +
[..snip..]

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
