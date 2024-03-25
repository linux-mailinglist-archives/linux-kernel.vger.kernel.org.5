Return-Path: <linux-kernel+bounces-117081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBFF88A6C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098361C3AFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF7E433A1;
	Mon, 25 Mar 2024 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vKpnVzl1"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB23FEC;
	Mon, 25 Mar 2024 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371868; cv=none; b=JTIVKnPvTIFu6/zp6oyO0sGZ+Vr3jaI53Elfx1Kp8BCbu1WJaKSONPWeVbSq1NbomxcCmnypMeg4K6z37spQhmJfTYpEoSuTyUvvzwS86RRL9QctVb1jcArTTWjlr09NK67ALDNQ+7aIFLgkZPMLSxLmev9a2IP2ltdOPsUXVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371868; c=relaxed/simple;
	bh=DrmCWdDLWDSGOltq0/ZEBbiqKQG2fiua/xjvLRoXu10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ8WgWxHD4FCCbI83CViMXrZd+xzox3Ado3zkgThytBwYY78iMVAy+Gt9w0Tyt67BHDM6BizEfbK/jNYY5JRJplyHOIMjAHin7F5sqYWb0i80cCaRJwqb6YkoVpPChJ1HSpjVXhyvZBcZSHd1+u4ZbuNW+3j8p4B5xge8w1syzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vKpnVzl1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9puSFQovfBN06iwz9da2ZyPCtyMVaryxiy4PBxWgMns=; b=vKpnVzl1im9WGoNBOtSpwUTLnn
	j/QsLGQ+6woouAs6mQQ6YM7iErUH7Z/eWJ49VBF6+uD/HhGkbNFDaYlWq6/DX04PbaW7ju7ksp0R/
	yBZngaC31us/fbK1XKoXGVvDjEqXX63C7arjDWeoZxy5qdazZhbPe7FbOPNX317ZvJ2E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rojzn-00B9WC-OV; Mon, 25 Mar 2024 14:04:11 +0100
Date: Mon, 25 Mar 2024 14:04:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Elad Nachman <enachman@marvell.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"dkirjanov@suse.de" <dkirjanov@suse.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/5] Fix prestera driver fail to probe
 twice
Message-ID: <7c79b1f8-a5b6-46b7-99fc-a0ac1bec5694@lunn.ch>
References: <20240320172008.2989693-1-enachman@marvell.com>
 <4104387a-d7b5-4029-b822-060ef478c6e3@lunn.ch>
 <BN9PR18MB42517F8E84C8C18078E45C37DB322@BN9PR18MB4251.namprd18.prod.outlook.com>
 <89a01616-57c2-4338-b469-695bdc731dee@lunn.ch>
 <BL1PR18MB42488523A5E05291EA57D0AEDB372@BL1PR18MB4248.namprd18.prod.outlook.com>
 <6dae31dc-8c4f-4b8d-80e4-120619119326@lunn.ch>
 <20240325134537.1cc7560e@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325134537.1cc7560e@kmaincent-XPS-13-7390>

> Prestera is indeed not directly involved in PoE. I wrote a hack to be able to
> get the PoE ports control, for testing my PoE patch series.
> 
> The aim in the future will be to add RJ45 port abstraction.
> The Prestera will get the port abstraction which will get the PoE ports control.
> The prestera driver then might receive an EPROBE_DEFER from it.

O.K, so EPRODE_DEFER has to work in a meaningful way. I'm not sure we
can call a 30 second delay meaningful.

And it is not just PoE. phylink_create() can return EPROBE_DEFER, and
there are probably others.

      Andrew

