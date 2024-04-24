Return-Path: <linux-kernel+bounces-156585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E718B0531
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04CFFB236A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9BC158A27;
	Wed, 24 Apr 2024 09:00:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A1DD29E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949220; cv=none; b=iuYdaCrSRXiXBs/cpHKL7pj4Rl3Y38USRaAU44v+rR4ZJKWp9miw2SeZwxCp8hECJtiT5HaIQRcO5Wq2Uzojgb1HUjGQM0bPcCrS0YPC6ysh3Tm5hzNE4ttDJlt8qMJY+f/bQnkuJlvVVFt5XKTnMVW2iUN5da3gnn1o2KWCC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949220; c=relaxed/simple;
	bh=qsf+RRnp5g+OnDLjpDsc5DoXxwNV0G0O90um6qiv6m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns8bWpX8B0W2/5LDT9n2ivPCITs4Ldzei+OFbOifg8okmdiHisvDA06epToM0DdvSTfzht4/SR5zWlud3ALy8TeVyFoZT9JBBSs8UdDEwExA1CAy9nL4xPLsXqBL0ItQtQrXA+MVmJE44QVoeSPzNY7YXDV+imkYmocFQXBUGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rzYTs-0008Pi-Ko; Wed, 24 Apr 2024 10:59:56 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rzYTr-00E2yV-Sd; Wed, 24 Apr 2024 10:59:55 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rzYTr-00BWz3-2Y;
	Wed, 24 Apr 2024 10:59:55 +0200
Date: Wed, 24 Apr 2024 10:59:55 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Joy Zou <joy.zou@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v4 1/1] arm64: dts: imx93-11x11-evk: add rtc
 PCF2131 support
Message-ID: <20240424085955.xsseqmzarh3uyfys@pengutronix.de>
References: <20240417031455.3177778-1-joy.zou@nxp.com>
 <20240417031455.3177778-2-joy.zou@nxp.com>
 <20240417045720.hk3y6m6roiqtuvfz@pengutronix.de>
 <AS4PR04MB9386FB10797C0AE8A19AA88BE1102@AS4PR04MB9386.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS4PR04MB9386FB10797C0AE8A19AA88BE1102@AS4PR04MB9386.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-04-24, Joy Zou wrote:
> 
> > -----Original Message-----
> > From: Marco Felsch <m.felsch@pengutronix.de>
> > Sent: 2024年4月17日 12:57
> > To: Joy Zou <joy.zou@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; Jacky Bai <ping.bai@nxp.com>;
> > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> > <linux-imx@nxp.com>; devicetree@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: [EXT] Re: [PATCH v4 1/1] arm64: dts: imx93-11x11-evk: add rtc
> > PCF2131 support
> > 
> > 
> > Hi Joy,
> > > diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > > b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > > index 07e85a30a25f..bc3c9271d747 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > > @@ -281,6 +281,23 @@ ldo5: LDO5 {
> > >       };
> > >  };
> > >
> > > +&lpi2c3 {
> > > +     #address-cells = <1>;
> > > +     #size-cells = <0>;
> > 
> > while reading your patch I also noticed that you had to specify these cells
> > here. It is very common to specify it within the base dtsi file imx93.dtsi. Can
> > you please provde an extra patch which adds this to the base dtsi followed by
> > this patch, which of course do need to specify it again.
> > 
> > Thanks you,
> >   Marco
> > 
> Thanks for your comments!
> Have checked the base dtsi file imx93.dtsi. The these cells already existed.

You're right, not sure why I didn't saw it in the first place.

> The current cells is same with the lpi2c3 node in imx93.dtsi. So should remove
> these cells in order to keep terse?

Yes please remove it.

Regards,
  Marco

