Return-Path: <linux-kernel+bounces-29778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A685F83134B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D68A1F21F40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D4AC14F;
	Thu, 18 Jan 2024 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BdpqghYW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498BBE47;
	Thu, 18 Jan 2024 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563842; cv=none; b=M0v/lxehrpZNQ0GiBOzuOTuBUgSWThbYSHrsoU5IS+Pzx92A34UjhvBWbWFjmYt4PEjtAuktPZu7PWid3w6Q38t1oB2xeCiUAmZpZr3hj71f1g+rkCzt2cCfaTUH86z8uJfhuyJCFpqC17bsxkIQgpqigo2/inMZty7b/rGusE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563842; c=relaxed/simple;
	bh=FJDtLtU9UOOxM+OWv+K7Z/HDhMhubIrn5ZYpu0wn4nw=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cKM49Nv1Kd1JcVpu6XqJB03Zj+SgYWqBgFtXvqrD/WwBAenfCOTtWxT8K2jK4HzL1/KEs9OyM/uD4618EUdRKtOL5LLmnVtsKcAQc0/AP06ii+brix6vwBEuHZpuld0qPdPhvmKkWaALhZX1QvyNUgbe0cuvGmSMTqdC9SIMQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BdpqghYW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705563840; x=1737099840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FJDtLtU9UOOxM+OWv+K7Z/HDhMhubIrn5ZYpu0wn4nw=;
  b=BdpqghYW/LmnurU5vmoiTDIM47WlDCAHt+jQkh7xdr6QUUSWALUp386p
   36Z+pxbo6rjIZ70kyVKDbtsev8JnKvM4i/Whg7Zq8E2ALmxBLWe0xaJRl
   zIjpUxbDX+kGllrQOHF2XeKeu0V3MHD3PyczsrKYYNNEC3QALa5ew/eu6
   WMWfR2C/UiqQ7bwVx1VyUIE1IEz1/po07b/ir4KjJ34lpxkL1FGsbbVV4
   2H3/z2IZHo5/E9R5Nbb+BVMv+BIDvIF6IXUucj/PEKANEkhAAvXn75SgJ
   pFavbF1X6g88xVJFPux32t8gRAoGi2DLpJAAV14SDHl7tR9wp6FsOEKUa
   A==;
X-CSE-ConnectionGUID: TzzvWUnNRhiVQSaPj0jdeg==
X-CSE-MsgGUID: QTWNn1p2QJqfnSF1wwgrGQ==
X-IronPort-AV: E=Sophos;i="6.05,201,1701154800"; 
   d="scan'208";a="15400384"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2024 00:43:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 00:43:40 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 18 Jan 2024 00:43:40 -0700
Date: Thu, 18 Jan 2024 08:43:39 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Divya.Koppera@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net 1/2] net: micrel: Fix PTP frame parsing for lan8814
Message-ID: <20240118074339.wxokx6dc7tmgcxgd@DEN-DL-M31836.microchip.com>
References: <20240113131521.1051921-1-horatiu.vultur@microchip.com>
 <20240113131521.1051921-2-horatiu.vultur@microchip.com>
 <20240115110635.60b1884c@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240115110635.60b1884c@device-28.home>

The 01/15/2024 11:06, Maxime Chevallier wrote:
> 
> Hello Horatiu,

Hi Maxime,

> 
> On Sat, 13 Jan 2024 14:15:20 +0100
> Horatiu Vultur <horatiu.vultur@microchip.com> wrote:
> 
> > The HW has the capability to check each frame if it is a PTP frame,
> > which domain it is, which ptp frame type it is, different ip address in
> > the frame. And if one of these checks fail then the frame is not
> > timestamp. Most of these checks were disabled except checking the field
> > minorVersionPTP inside the PTP header. Meaning that once a partner sends
> > a frame compliant to 8021AS which has minorVersionPTP set to 1, then the
> > frame was not timestamp because the HW expected by default a value of 0
> > in minorVersionPTP. This is exactly the same issue as on lan8841.
> > Fix this issue by removing this check so the userspace can decide on this.
> >
> > Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  drivers/net/phy/micrel.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > index bf4053431dcb3..1752eaeadc42e 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -120,6 +120,9 @@
> >   */
> >  #define LAN8814_1PPM_FORMAT                  17179
> >
> > +#define PTP_RX_VERSION                               0x0248
> > +#define PTP_TX_VERSION                               0x0288
> > +
> >  #define PTP_RX_MOD                           0x024F
> >  #define PTP_RX_MOD_BAD_UDPV4_CHKSUM_FORCE_FCS_DIS_ BIT(3)
> >  #define PTP_RX_TIMESTAMP_EN                  0x024D
> > @@ -3150,6 +3153,10 @@ static void lan8814_ptp_init(struct phy_device *phydev)
> >       lanphy_write_page_reg(phydev, 5, PTP_TX_PARSE_IP_ADDR_EN, 0);
> >       lanphy_write_page_reg(phydev, 5, PTP_RX_PARSE_IP_ADDR_EN, 0);
> >
> > +     /* Disable checking for minorVersionPTP field */
> > +     lanphy_write_page_reg(phydev, 5, PTP_RX_VERSION, 0xff00);
> > +     lanphy_write_page_reg(phydev, 5, PTP_TX_VERSION, 0xff00);
> 
> Small nit: This looks a bit like magic values, from the datasheet I
> understand the upper byte is the max supported version and the lower
> byte is the min supported version, maybe this could be wrapped in
> macros ?

Your understanding is correct. Yes, I will update this in the next
series.

> 
> > +
> >       skb_queue_head_init(&ptp_priv->tx_queue);
> >       skb_queue_head_init(&ptp_priv->rx_queue);
> >       INIT_LIST_HEAD(&ptp_priv->rx_ts_list);
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

