Return-Path: <linux-kernel+bounces-59545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 682B484F8BC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD00283B03
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B586074E36;
	Fri,  9 Feb 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H480AzYP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655A14EB3B;
	Fri,  9 Feb 2024 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493251; cv=none; b=sfl2C4qfnr8+92UzTvZyU0LEig1OcS/4tPFR73Kirdc+AZmDS/SFPHgvmcURITa0SAu53OahzAQQJcW9Q6fky4IeCBP2WojaxqigiErdi+aqawVKSuw2HB1jkL0F0ateKpZUTrI0gi0yoXmYeaR0dz3cF8MN2XgsMJLGQY8EAKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493251; c=relaxed/simple;
	bh=MPW5mUOHhGvQPg5Tf7W+tLCjO+I4TQCvuwIij893KfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqD4jrauYAQD4KMuL6/obizFCXEyetOCFmBRNJkSdEP9Wj7MozdtkZQ0lemA1anELtijnxw7momI4dDmJ36ql05R/CEIcINVmla7ynlxOQZvJs409r5aeZtP4papEdTYTPphAaaPcS7UJX4+36hdEZokO08GW3G+zrU2G4+DDwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H480AzYP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0JtvBMaLBcFOgHj2y9suAh17jw5aR24oDvXIDv/MskI=; b=H480AzYP/5GQ9LD5jtt07Tj8Mo
	tSAs5RMFHHzFw2ZRMhUrJJXX/eS2xAAdhYuetmBs7FlvLfH0DkrH82JRdFEf1IkpQBhWkTpdc1qEo
	QLqxon46sriFrfWYdbr+1/3vj1RlBLk+MJdphxEA+fvJ7kk+RHwxHNOhEIjgIJmw+WWc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYSzP-007Ogm-Cn; Fri, 09 Feb 2024 16:40:31 +0100
Date: Fri, 9 Feb 2024 16:40:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"afd@ti.com" <afd@ti.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH v3 2/2] net: phy: dp83826: support TX data voltage tuning
Message-ID: <3a0eace4-6f24-4f7e-b693-65973a112b32@lunn.ch>
References: <20240209123628.2113971-1-catalin.popescu@leica-geosystems.com>
 <20240209123628.2113971-2-catalin.popescu@leica-geosystems.com>
 <00691961-d516-4338-b7e8-203625e561ee@lunn.ch>
 <5a15d8eb-d6e9-46cf-9b33-d0a04e01b365@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a15d8eb-d6e9-46cf-9b33-d0a04e01b365@leica-geosystems.com>

> DP83826 offers the possibility to tune the voltage of logical levels of 
> the MLT-3 encoded TX data. This is useful when there is a voltage drop 
> in between the PHY and the connector and we want to increase the voltage 
> levels to compensate for that drop.
> 
> Is this more meaningful ?

Yes, that is good.

Thanks

	Andrew

