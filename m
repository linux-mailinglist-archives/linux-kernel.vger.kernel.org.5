Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC82376EEBF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbjHCPz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjHCPzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:55:53 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521813A97;
        Thu,  3 Aug 2023 08:55:52 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373FthPW025615;
        Thu, 3 Aug 2023 10:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691078143;
        bh=a+EqIwvTgsfqSuxrk8rjov+v37wQp94SbQ4RI/MeEvs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tikkqHgEAhrCdIZuKA2YlhEwb0YyFxtVYji068u08J1vvDo+YoOrQmD9s1P09HjVe
         peqX7gVUfvZLMjTBYsncPDHdPA9teFGdntlZkrLdv3ys2F+26vM5wWrWX45L/SbpUA
         NwN9UhRNIDUqyFmyaXG8wBEDb4FFSCh3VnCXo4Aw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373FthDV092109
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 10:55:43 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 10:55:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 10:55:42 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373FtgL6010324;
        Thu, 3 Aug 2023 10:55:42 -0500
Date:   Thu, 3 Aug 2023 21:25:41 +0530
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
Message-ID: <20230803155541.nwsfwobfkbpefoyw@dhruva>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-5-d-gole@ti.com>
 <3882f0ac-b74c-6eb2-197c-34ca233cd7a3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3882f0ac-b74c-6eb2-197c-34ca233cd7a3@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 03, 2023 at 10:26:32 -0500, Andrew Davis wrote:
> On 8/3/23 1:42 AM, Dhruva Gole wrote:
> > Introduce system suspend resume calls that will allow the ti_sci
> > driver to support deep sleep low power mode when the user space issues a
> > suspend to mem.
> > 
> > Also, write a ti_sci_prepare_system_suspend call to be used in the driver
> > suspend handler to allow the system to identify the low power mode being
> > entered and if necessary, send TISCI_MSG_PREPARE_SLEEP with information
> > about the mode is being entered and the address for allocated memory for
> > storing the context during Deep Sleep.
> > 
> > We're using "pm_suspend_target_state" to map the kernel's target suspend
> > state to SysFW low power mode. Make sure this is available only when
> > CONFIG_SUSPEND is enabled.
> > 
> > Co-developed-by: Dave Gerlach <d-gerlach@ti.com>
> > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> > Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> > Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >   drivers/firmware/ti_sci.c | 63 +++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 63 insertions(+)
> > 
[..snip..]
> > +static int ti_sci_suspend(struct device *dev)
> > +{
> > +	struct ti_sci_info *info = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
> 
> After this the will the IOs be in isolation? Or does the firmware wait
> until power down begins later?

From what I understand,
IOs will be in isolation immediately

> 
> Andrew
> 
> > +	if (ret)
> > +		return ret;
> > +	dev_dbg(dev, "%s: set I/O isolation: %d\n", __func__, ret);
> > +
> > +	ret = ti_sci_prepare_system_suspend(info);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ti_sci_resume(struct device *dev)
> > +{
> > +	struct ti_sci_info *info = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
> > +	if (ret)
> > +		return ret;
> > +	dev_dbg(dev, "%s: disable I/O isolation: %d\n", __func__, ret);
> > +
> > +	return 0;
> > +}
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(ti_sci_pm_ops, ti_sci_suspend, ti_sci_resume);
> > +
> >   static int ti_sci_init_suspend(struct platform_device *pdev,
> >   			       struct ti_sci_info *info)
> >   {
> > @@ -3759,6 +3821,7 @@ static struct platform_driver ti_sci_driver = {
> >   	.driver = {
> >   		   .name = "ti-sci",
> >   		   .of_match_table = of_match_ptr(ti_sci_of_match),
> > +		   .pm = &ti_sci_pm_ops,
> >   	},
> >   };
> >   module_platform_driver(ti_sci_driver);

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
