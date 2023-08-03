Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8166476EF04
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbjHCQIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjHCQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:08:28 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914612D7E;
        Thu,  3 Aug 2023 09:08:27 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373G8GaD077018;
        Thu, 3 Aug 2023 11:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691078896;
        bh=4xHql+cKbKBSwfFNBD8YC0edLIB4k/JLl55YhDFuI7k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kBn0KPV/cplBhWM/D/nKVBV3mv7879fb47G74rd4Qcjtx323Z08efeeMiQj7O7LNL
         mMGbTvootDZpOfxlBAVWU5mf7WuOsdBX2ROdJXxdIbVoiAxQs8O0cUhgYlfviGwNqF
         84t4mlp4rv800SxwKGJhJTYxh/NzABMgl0YRCi9s=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373G8GG0078594
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 11:08:16 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 11:08:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 11:08:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373G8F1E036790;
        Thu, 3 Aug 2023 11:08:15 -0500
Date:   Thu, 3 Aug 2023 21:38:15 +0530
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
        Vibhore Vardhan <vibhore@ti.com>, Georgi Vlaev <g-vlaev@ti.com>
Subject: Re: [PATCH V6 4/4] firmware: ti_sci: Introduce system suspend resume
 support
Message-ID: <20230803160815.yfpkdfssv75d4inf@dhruva>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-5-d-gole@ti.com>
 <3882f0ac-b74c-6eb2-197c-34ca233cd7a3@ti.com>
 <20230803155541.nwsfwobfkbpefoyw@dhruva>
 <8c330bd9-5f4e-8cd0-ed02-c3a696d7473a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8c330bd9-5f4e-8cd0-ed02-c3a696d7473a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 03, 2023 at 11:00:11 -0500, Andrew Davis wrote:
> On 8/3/23 10:55 AM, Dhruva Gole wrote:
> > On Aug 03, 2023 at 10:26:32 -0500, Andrew Davis wrote:
> > > On 8/3/23 1:42 AM, Dhruva Gole wrote:
> > > > Introduce system suspend resume calls that will allow the ti_sci
> > > > driver to support deep sleep low power mode when the user space issues a
> > > > suspend to mem.
> > > > 
> > > > Also, write a ti_sci_prepare_system_suspend call to be used in the driver
> > > > suspend handler to allow the system to identify the low power mode being
> > > > entered and if necessary, send TISCI_MSG_PREPARE_SLEEP with information
> > > > about the mode is being entered and the address for allocated memory for
> > > > storing the context during Deep Sleep.
> > > > 
> > > > We're using "pm_suspend_target_state" to map the kernel's target suspend
> > > > state to SysFW low power mode. Make sure this is available only when
> > > > CONFIG_SUSPEND is enabled.
> > > > 
> > > > Co-developed-by: Dave Gerlach <d-gerlach@ti.com>
> > > > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> > > > Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> > > > Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> > > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > > > ---
> > > >    drivers/firmware/ti_sci.c | 63 +++++++++++++++++++++++++++++++++++++++
> > > >    1 file changed, 63 insertions(+)
> > > > 
> > [..snip..]
> > > > +static int ti_sci_suspend(struct device *dev)
> > > > +{
> > > > +	struct ti_sci_info *info = dev_get_drvdata(dev);
> > > > +	int ret;
> > > > +
> > > > +	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
> > > 
> > > After this the will the IOs be in isolation? Or does the firmware wait
> > > until power down begins later?
> > 
> >  From what I understand,
> > IOs will be in isolation immediately
> > 
> 
> That is what I understand too, so then any device that may need to do some
> external communication for its suspend will not function, this must be the
> last driver _suspend() the system calls, how do you enforce that?

I will make use of .suspend_noirq callbacks in that case. Does that
sound better, or is there anything else I may not be aware of?

> 
> Andrew
> 
> > > 
> > > Andrew
> > > 
[..snip..]
> > 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
