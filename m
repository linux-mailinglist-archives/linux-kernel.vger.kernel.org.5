Return-Path: <linux-kernel+bounces-68719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFAC857EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E88B27C33
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528812E1FA;
	Fri, 16 Feb 2024 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oCudOuxD"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B912CDAD;
	Fri, 16 Feb 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092700; cv=none; b=eglLXxTWsmGyNKh7QG/NRy2WI98Z35aX8JQJ/RkhcDraq4DOt5+zVtpAuu/zpCPIs61wgj5B/UokZPXNVrokU7ib4TsoSQ85wtJSan7tz3HgQw77cjuEyaZts1MaweoApelD2Y00EoUhfMOjNwJzMGQibNnpQjQhYnJn72Dykh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092700; c=relaxed/simple;
	bh=/JBzgGoPm0eAFGIdZQX28KB66+owY5uuYmdgGLTTA7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuRknYKQ1bM5i0JW+ZxAA1T7qjca3K3DY/Jed0frx1NPAtfGe1taLj2WMXogvgTEsdii4OISCsiN3zkQkyW4AXXOq5OfCziuUcGeb7oLjAPUZs+gip7BLfgCAcJ6TDILpQ++iU9FDZdSyT8CNkcBdaJuj4oJEeOVDPCdnHOEZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oCudOuxD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gXok714HXjWAbtIIpdJSn0VRn+9Uj8prlIuY8eyJf4o=; b=oCudOuxDukPnLJJ59CEe2wFteK
	JFQgtsGw+JsD507WomKv96l2x8TqVtit5FQ+dwqQ/eEluq0yD2xjONtFZPFKzIcKJGUSOxDKBkRZF
	bjsxTM3GCPonyBpxp6SolOrsDL5YF0eQ15wZkAxhzZBkd5dapDsB6J3vVxPCLPSx6xbQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raywC-007zHr-NJ; Fri, 16 Feb 2024 15:11:36 +0100
Date: Fri, 16 Feb 2024 15:11:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/6] net: hisi-femac: add support for Hi3798MV200,
 remove unmaintained compatibles
Message-ID: <b244b8ef-9a30-42dc-b9e8-a9d35cce99a3@lunn.ch>
References: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
 <254d3c4d-bc74-4a26-9c23-17b4399c3755@lunn.ch>
 <SEZPR06MB695927E7E18D62EB1E6FB603964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR06MB695927E7E18D62EB1E6FB603964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>

On Fri, Feb 16, 2024 at 09:38:31PM +0800, Yang Xiwen wrote:
> On 2/16/2024 9:37 PM, Andrew Lunn wrote:
> > On Fri, Feb 16, 2024 at 06:01:59PM +0800, Yang Xiwen via B4 Relay wrote:
> > > Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> > > ---
> > > Changes in v2:
> > > - replace email.
> > > - hisi-femac: s/BUS/MACIF (Andrew Lunn)
> > > - hisi-femac: add "hisilicon,hisi-femac" compatible since the driver
> > >    seems generic enough for various SoCs
> > > - hisi-femac-mdio: convert binding to YAML (Krzysztof Kozlowski)
> > > - rewrite commit logs (Krzysztof Kozlowski)
> > > - Link to v1: https://lore.kernel.org/r/20240216-net-v1-0-e0ad972cda99@outlook.com
> > Generally, you wait for discussion to finish before posting a new
> > version. Also, netdev requests you wait a minimum of 24 hours between
> > versions.
> > 
> > Having discussion happening on two different versions of a patchset
> > at once just causes confusion.
> Sorry for that, it's the first time i send netdev patches.

Reading this might help you:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

