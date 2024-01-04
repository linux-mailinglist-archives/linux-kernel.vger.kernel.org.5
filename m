Return-Path: <linux-kernel+bounces-17112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6C0824870
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7301C225F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A628E3A;
	Thu,  4 Jan 2024 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K4pp7smN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BDE2C19A;
	Thu,  4 Jan 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 404IqjjM028754;
	Thu, 4 Jan 2024 12:52:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704394365;
	bh=Jixmz8UmdzmchzS9VJO4ZuCFHsN7gfU1qaRRGXCk3j8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=K4pp7smNcP5O66x1ZOGRFKeUI7yrbnzJJCk4XKh+XsgUtuFjk6x8c0b2T2b/gdCij
	 rwsRBP0a7p4rRdKNDkJOJf8ZYZ9Ny3Xb5JsX0Asexu9wurijHAjZYfDqDRlwnUsIHb
	 FiCPrkfsrOrHJSo7veZVDKWoSeKZQcwJxW3dlMow=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 404IqjZH017937
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jan 2024 12:52:45 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jan 2024 12:52:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jan 2024 12:52:44 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 404Iqhqr001930;
	Thu, 4 Jan 2024 12:52:43 -0600
Date: Fri, 5 Jan 2024 00:22:42 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Jai Luthra <j-luthra@ti.com>,
        Javier Carrasco
	<javier.carrasco@wolfvision.net>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Heikki Krogerus
	<heikki.krogerus@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>
Subject: Re: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Message-ID: <20240104185242.tf2fvgf56ehajqd5@dhruva>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
 <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
 <e9e8dd9f-b11b-43fc-8d76-6734dbddb540@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e9e8dd9f-b11b-43fc-8d76-6734dbddb540@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi all,

On Jan 04, 2024 at 18:15:36 +0200, Roger Quadros wrote:
> 
> 
> On 04/01/2024 17:47, Jai Luthra wrote:
> > Hi Javier,
> > 
> > On Jan 04, 2024 at 19:50:05 +0530, Jai Luthra wrote:
> >> Hi Javier, Greg,
> >>
> >> On Dec 14, 2023 at 17:29:08 +0100, Javier Carrasco wrote:
> >>> This series extends the patch update mechanism to support the tps6598x.
> >>>
> >>> Currently there is only support for the tps25750 part and some
> >>> conditional clauses are used to make a special case out of it. Now that
> >>> different parts support patch updates, a more general approach is
> >>> proposed.
> >>>
> >>> The update mechanism differs from the one required by tps25750 and it is
> >>> explained in the commit message as a summary of the application note in
> >>> that respect.
> >>>
> >>> Note that the series makes use of the TPS_SETUP_MS introduced in
> >>> commit 6a4d4a27f986 ("usb: typec: tps6598x: add reset gpio support"),
> >>> which is currently available in usb-next / usb-testing.
> >>>
> >>> A TPS65987D has been used to test this functionality with positive
> >>> results.
> >>>
> >>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> >>> ---
> >>> Changes in v2:
> >>> - Remove probe defeferring mechanism and expect the firmware to be
> >>>   available (Heikki Krogerus).
> >>> - Link to v1: 
> >>> https://lore.kernel.org/r/20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net
> >>>
> >>
> >> FYI, this series breaks boot for TI SK-AM62A and SK-AM62 which use 
> >> TPS6598x as the USB-C PD chip.

This series also broke boot on TI SK-AM62x [0].

> >>
> >> The platforms stopped booting since next-20240103 [1], and reverting 
> >> this series [4] seems to fix the issue [2]
> >>
> >> Is there any change needed in the board device-tree [3] and bindings?
> >>
> >> We don't specify any firmware in the device-tree node, but seems like 
> >> that is an assumption in this series. I tried reverting it (below 
> >> change) but that did *not* help with the stuck boot.
> >>
> >> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> >> index a956eb976906..fa3bd7349265 100644
> >> --- a/drivers/usb/typec/tipd/core.c
> >> +++ b/drivers/usb/typec/tipd/core.c
> >> @@ -1139,7 +1139,7 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
> >>         ret = device_property_read_string(tps->dev, "firmware-name",
> >>                                           &firmware_name);
> >>         if (ret)
> >> -               return ret;
> >> +               return 0;
> >>
> >>         ret = tps_request_firmware(tps, &fw);
> >>         if (ret)
> >>
> >>
> >> [1] https://linux.kernelci.org/soc/ti/job/next/kernel/next-20240103/plan/baseline-nfs/
> >> [2] https://gist.github.com/jailuthra/0c077176585e4df2f8b78f7784087865
> >> [3] https://gitlab.com/linux-kernel/linux-next/-/blob/master/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts#L305
> >> [4] https://github.com/jailuthra/linux/commits/next-20240103-tps6598-fix/
> > 
> > The following change seems to fix boot on SK-AM62A without reverting 
> > this whole series:
> > 
> > ------------------
> > 
> > diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> > index a956eb976906a5..8ba2aa05db519b 100644
> > --- a/drivers/usb/typec/tipd/core.c
> > +++ b/drivers/usb/typec/tipd/core.c
> > @@ -1223,11 +1223,16 @@ static int cd321x_reset(struct tps6598x *tps)
> >  	return 0;
> >  }
> >  
> > -static int tps6598x_reset(struct tps6598x *tps)
> > +static int tps25750_reset(struct tps6598x *tps)
> >  {
> >  	return tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
> >  }
> >  
> > +static int tps6598x_reset(struct tps6598x *tps)
> > +{
> > +	return 0;
> > +}
> > +
> >  static int
> >  tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
> >  {
> > @@ -1545,7 +1550,7 @@ static const struct tipd_data tps25750_data = {
> >  	.trace_status = trace_tps25750_status,
> >  	.apply_patch = tps25750_apply_patch,
> >  	.init = tps25750_init,
> > -	.reset = tps6598x_reset,
> > +	.reset = tps25750_reset,
> >  };
> >  
> >  static const struct of_device_id tps6598x_of_match[] = {
> > 
> > ------------------
> > 
> > I am not an expert on this, will let you/others decide on what should be 
> > the correct way to reset TPS6598x for patching without breaking this SK.
> > 
> > 
> 
> This looks like a correct fix to me.
> Could you please send a proper PATCH with Fixes tag? Thanks!

Thanks for reviewing this Roger, the same patch above worked for me to
fix SK-AM62x as well [1].

[0] https://storage.kernelci.org/next/master/next-20240103/arm64/defconfig/gcc-10/lab-ti/baseline-nfs-am62xx_sk-fs.txt
[1] https://gist.github.com/DhruvaG2000/326b5d7fab4be95f20cd0aac4125f577

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

