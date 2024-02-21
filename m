Return-Path: <linux-kernel+bounces-74899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5517D85DFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBB628627E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EE17FBD9;
	Wed, 21 Feb 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="VfD0xMKJ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855EE1E4AF;
	Wed, 21 Feb 2024 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525928; cv=none; b=TdvV4tXS9kFiCu4cBshf3EiUXMbeMHYgVMPYuvgzyI32nLPWTYJ9CC950HuMd1U3DmZ+db4MwsY5kwLGHnuP3TRAqQ2CUPp75j/gUpo8S0CtZPhNPoIrxQK+bRFw6hMTzN5bArlBk6BfDP3fVnFqPBZhQw+EDg+8Ag5sTLFl6cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525928; c=relaxed/simple;
	bh=XKusKUEvj+nGG0dkwgHxoxK1AcSzzZsNUAn7iTQh6Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQXEwhmZMHxtN3KEvpHa3Kh8KQg49Voj2WnADSVHWhx8neCmiAjCrWNbFRVaiwKJFCiUQQzK9W70X8XcSmiYcB9w58uaytRWYWmV9oqRHrS+iz4BJoVEitlxwgZmAjLxNvuRqK88ZjOk08fEVm5lDnbowleMuVLyo3HvrBjkt0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=VfD0xMKJ; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708525925; x=1740061925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gbk069DucRj43Sndt/nnkJaRND27RAMcHT3E75mzM4s=;
  b=VfD0xMKJm1V44nWI71twevkdfhTkib5Uykwf+RosbFA236UWVlwKYtA/
   W7B6vAKKxgS4AkSwS7U1mLv1/GFI/D4OHiCCvSeMNpMnXIB9ygUTxwSpC
   dCLDG6T931d0t7EnfSU4q/CmgmYuP3Ra+G9Fxy/KC61pCDUy2BTKmz/Ee
   Mc/yQWzhDO86rG7aCVI13DXoXug2i6XiCGTRHSNoiUnQxmJHWsYC5k8N/
   i+1CIZP6qvG1ehyiQKFuF72vH0jHU7iP8Np9OS0sWECyToGu6bo+zIBFc
   WHYOBlaRN4/xH5RCHvAU5sdSuLxJP74fDD3FAJEMrt2YyeuBOaIGwU5L2
   Q==;
X-IronPort-AV: E=Sophos;i="6.06,175,1705359600"; 
   d="scan'208";a="35525607"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Feb 2024 15:32:01 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 7DD8D280075;
	Wed, 21 Feb 2024 15:32:01 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	"jonas@kwiboo.se" <jonas@kwiboo.se>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <"li nux-phy"@lists.infradead.org>,
	Sandor Yu <sandor.yu@nxp.com>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, Oliver Brown <oliver.brown@nxp.com>, "sam@ravnborg.org" <sam@ravnborg.org>
Subject: Re: [PATCH v14 7/7] phy: freescale: Add HDMI PHY driver for i.MX8MQ
Date: Wed, 21 Feb 2024 15:32:01 +0100
Message-ID: <1880037.tdWV9SEqCh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <PAXPR04MB9448DE5926B60C36D5BFC96AF4572@PAXPR04MB9448.eurprd04.prod.outlook.com>
References: <cover.1708395604.git.Sandor.yu@nxp.com> <22191690.EfDdHjke4D@steina-w> <PAXPR04MB9448DE5926B60C36D5BFC96AF4572@PAXPR04MB9448.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Sandor,

Am Mittwoch, 21. Februar 2024, 08:47:52 CET schrieb Sandor Yu:
> Hi Alexander,
>=20
> Thanks for your comments,
>=20
> >
> > Hi,
> >
> > thanks for the update.
> >
> > Am Dienstag, 20. Februar 2024, 04:23:55 CET schrieb Sandor Yu:
> > > Add Cadence HDP-TX HDMI PHY driver for i.MX8MQ.
> > >
> > > Cadence HDP-TX PHY could be put in either DP mode or HDMI mode base
> > on
> > > the configuration chosen.
> > > HDMI PHY mode is configurated in the driver.
> > >
> > > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > > Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> >
> > This still works as before. I noticed there is a lot of code duplicatio=
n with
> > patch 6. IMHO these PHY drivers should be merged into a single one where
> > the mode is configured using phy_set_mode() from cdns-mhdp8501-core.c.
> > This nicely matches my concerns regarding patch 5.
> >
> Yes, there are some registers offset are same and the clock management fu=
nction could be reused for DP and HDMI PHY driver.
> But because of HDMI and DP PHY totally different work mode, the functions=
 in struct phy_ops,
> Such as ->init, ->power_on/off and ->configure could not combine into a s=
ingle one,
> So separate DP and HDMI PHY driver should be a better resolution.

Despite some output type (DP/HDMI) specific settings, the similarities
are quite huge actually. Even though apparently DP has it's own ->init setu=
p,
this can be delayed until ->set_mode or even ->configure.
The distinction between each mode can be done by checking phy->attrs.mode.
=46or a prove of concept I've hacked both drivers into a single one. I can't
test DP, but HDMI still works. Feel free to contact me in private.

Best regards,
Alexander

> B.R
> Sandor
>=20
>=20
> > Best regards,
> > Alexander
> >
> > > ---
> > > v13->v14:
> > >  *No change.
> > >
> > > v12->v13:
> > > - Fix build warning
> > >
> > > v11->v12:
> > > - Adjust clk disable order.
> > > - Return error code to replace -1 for function wait_for_ack().
> > > - Use bool for variable pclk_in.
> > > - Add year 2024 to copyright.
> > >
> > >  drivers/phy/freescale/Kconfig               |  10 +
> > >  drivers/phy/freescale/Makefile              |   1 +
> > >  drivers/phy/freescale/phy-fsl-imx8mq-hdmi.c | 960
> > > ++++++++++++++++++++
> > >  3 files changed, 971 insertions(+)
> > >  create mode 100644 drivers/phy/freescale/phy-fsl-imx8mq-hdmi.c
> > >
> > > diff --git a/drivers/phy/freescale/Kconfig
> > > b/drivers/phy/freescale/Kconfig index c39709fd700ac..14f47b7cc77ab
> > > 100644
> > > --- a/drivers/phy/freescale/Kconfig
> > > +++ b/drivers/phy/freescale/Kconfig

> [snip]

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



