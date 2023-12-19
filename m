Return-Path: <linux-kernel+bounces-5531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01CA818BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E598D1C24705
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F78B1D138;
	Tue, 19 Dec 2023 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3zDVnsgI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753920323;
	Tue, 19 Dec 2023 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2P8yV53vl0UUKGT9ZG2NVjkjQuA8zzjMdrp6s7PKqho=; b=3zDVnsgIZVcg+h5lXx4sbdNjNN
	uG0IpVnJnckXhrySVQeZZRd4ykrlNlFlaI0MjM91z/QSHzWS8x+1k8zXNKpXjjiITLjHjBn4n9dXv
	2bde897jtMNV1f2LWj09c7tuDLVEARJT2kmqqLrUr2hm0jmWcQpazDm9mgV+SxQAjoaI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rFcWw-003LQ6-OC; Tue, 19 Dec 2023 17:01:14 +0100
Date: Tue, 19 Dec 2023 17:01:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <eichest@gmail.com>
Subject: Re: [PATCH 1/2] net: phy: Add BaseT1 auto-negotiation constants
Message-ID: <ad5f6bc9-071b-4c3e-b53b-872ca91fb8ea@lunn.ch>
References: <20231218221814.69304-1-dima.fedrau@gmail.com>
 <89f68405-2506-420b-952f-a168ebcb4d73@lunn.ch>
 <20231219092837.GB3479@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219092837.GB3479@debian>

> Yes, I'm currently trying to push a driver for the Marvell88Q2220
> 100BASE-T1/1000BASE-T1 PHY. It supports autonegotiation and with an
> additional patch to function genphy_c45_baset1_an_config_aneg which is
> not part of the series it is possible to set the advertised speed.
> I probably should send all patches as a series including the driver ?

Yes, please do send it all together as one patchset.

	Andrew

