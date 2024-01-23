Return-Path: <linux-kernel+bounces-35062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CF3838B53
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49681C22536
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534FC5C5F8;
	Tue, 23 Jan 2024 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z7kK/SwE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE215C5E0;
	Tue, 23 Jan 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004224; cv=none; b=tjd2tLXU2LXmdn7zRIvjRANfFuZmF+WfHULXfMh7xXjGDSfMkk8fMThL3LEF0FQSSmgt0tzpz5JRKs8plFM16aQR+4aJq1DIf/QsqoqOeGT1p4GF65XIMrvCBfkFe3SgGJxJCBdO0r/Dfei/Wtx+fZ4toztYSkcFAfRa13tF+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004224; c=relaxed/simple;
	bh=uMNNg+3njresSW14XlqPX2ISyI4rysroKuO5EzSZJcY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RahRc0N1htZtGLSPO7LyywyV+QsDVfTxWPTOkuvJNPBeWd1RBv/crn20HKAXfBhZeuIb7/n6pJN9azDsnayxibhrQ/Hs3DgiiNeqRyDL45gCrJBo4M1juQOIpICZkEa2WmOcEbyzaN6K3z9YnrLYe4crG+Zich055AnqPSNrs9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z7kK/SwE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706004222; x=1737540222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uMNNg+3njresSW14XlqPX2ISyI4rysroKuO5EzSZJcY=;
  b=Z7kK/SwECCIj2ufKU3bP/qE23MAuLlt4vwZL6bo5DMnyXp3Fh6Y7+WFG
   5GKE/YvTMcXA7kDUht3QR3PB1MFtTa1PhVbAp4roBS+STAsVfTY37MS7B
   0i8Ww0caTP4DRI6MZ76SbhRJy6/nqWXTrQJIRtgNqxOwJtNf2ON3xclrE
   x3QEg/X9RPhoKc0g9pPRvYnGYs8ddhw5XXdII2KKKJiuFbE8q2Pyc3RQ1
   IuWUdT5C4qa3o6Kiha2PY9McQawEcQc+ejpl+Z1xftsRKkxP7X8J54atf
   gd76Yyg9iv11GeQVVPGf85c+cIeePbwAZborb1tAw9RnI74beLB1dGkoL
   A==;
X-CSE-ConnectionGUID: RZ1Nz7WUS3Gi2FofoZ48Tg==
X-CSE-MsgGUID: QLqhO3EaRo+fPgWiwCOc7w==
X-IronPort-AV: E=Sophos;i="6.05,214,1701154800"; 
   d="scan'208";a="15158519"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 03:03:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 03:03:20 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Jan 2024 03:03:20 -0700
Date: Tue, 23 Jan 2024 11:03:19 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net] net: lan966x: Fix port configuration when using
 SGMII interface
Message-ID: <20240123100319.3z6or2ahhztkplgv@DEN-DL-M31836.microchip.com>
References: <20240123081514.3625293-1-horatiu.vultur@microchip.com>
 <20240123094849.5ce5acc8@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240123094849.5ce5acc8@device-28.home>

The 01/23/2024 09:48, Maxime Chevallier wrote:
> 
> Hello Horatiu,

Hi Maxime,

> 
> On Tue, 23 Jan 2024 09:15:14 +0100
> Horatiu Vultur <horatiu.vultur@microchip.com> wrote:
> 
> > In case the interface between the MAC and the PHY is SGMII, then the bit
> > GIGA_MODE on the MAC side needs to be set regardless of the speed at
> > which it is running.
> >
> > Fixes: d28d6d2e37d1 ("net: lan966x: add port module support")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  drivers/net/ethernet/microchip/lan966x/lan966x_port.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
> > index 92108d354051c..975a6d64a2e18 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
> > @@ -170,7 +170,8 @@ static void lan966x_port_link_up(struct lan966x_port *port)
> >       /* Also the GIGA_MODE_ENA(1) needs to be set regardless of the
> >        * port speed for QSGMII ports.
> 
> Small nit, I think this comment above the test could also be updated to
> reflect that change.

Ah... yes, you are right. I will update this in the next version.

> 
> >        */
> > -     if (phy_interface_num_ports(config->portmode) == 4)
> > +     if (phy_interface_num_ports(config->portmode) == 4 ||
> > +         config->portmode == PHY_INTERFACE_MODE_SGMII)
> >               mode = DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);
> >
> >       lan_wr(config->duplex | mode,
> 
> Besides that,
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Thanks,
> 
> Maxime

-- 
/Horatiu

