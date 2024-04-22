Return-Path: <linux-kernel+bounces-153408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D558ACDC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FB2282AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E2514F11E;
	Mon, 22 Apr 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RvnVmbMH"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DF14A4DD;
	Mon, 22 Apr 2024 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791160; cv=none; b=K3l8Dg/w5SX3gi1IkO6fpkx9EtiDaAZwf7Q30Qzbnc4o3ZxT1y4RvblGMpn4B8WH5tlYZObqxTo4gXKtdy6Qdyrq4tb9nq8o11MFvMoVv3abZIO8SySUiwjiRwV7OFdmaH8bh8qeHzdmwo43p9TV+nX6599XqySRWN7i44sovz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791160; c=relaxed/simple;
	bh=l1oiuR2JNg6j9Ez4Iw0LZM6AVEXGjBXFcoLJakn8dQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/lBrHv8UJ9mbBMRYbK12TlBJd0Z6fOa3rik3OJUF3eHw/tlFrPjFGnrHh8I/jcSmRXOuJMf0C3gfEyc0/tMC/vp2EZhUAknWey2HMw98RBmLkm2SoJYPbK8dkoDJPoAxwdDOatipw9Heog2s6Q3ktTwHWPlImensunLFnLnbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RvnVmbMH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JyXiZGD4WICf14v9mMu03HVoRauA6DvZ1aqUNGKU6Hs=; b=RvnVmbMHehrvZ42K+gaAemw6Z6
	4CEk4Ma4uHE7dOmEX7hz7Lgut4IPpt22Noer7Xh5XbzldO3hc7M/7j+QFD9IkobonCje1sQg7M8Pd
	bYGGjjjDFaYz7GGQfltZ9w6OhEVjo81vvY/VopKWNI50TZiZWWoLOi2vJIeIj0Lfzipk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rytMZ-00DcJF-9N; Mon, 22 Apr 2024 15:05:39 +0200
Date: Mon, 22 Apr 2024 15:05:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <3614267f-4d0e-43af-8237-568d294172fd@lunn.ch>
References: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
 <20240422150234.49d98b73@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422150234.49d98b73@kmaincent-XPS-13-7390>

On Mon, Apr 22, 2024 at 03:02:34PM +0200, Kory Maincent wrote:
> On Mon, 22 Apr 2024 14:50:47 +0200
> "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com> wrote:
> 
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > 
> > This patch series fix few issues in PSE net subsystem like Regulator
> > dependency, PSE regulator type and kernel Documentation.
> > 
> > Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Found out I had a git configuration that adds "Dent Project" to my sob. I don't
> want that, and will send a v2 without it. 
> I will wait a week for review before the v2, so please do not merge this
> version.

Hi Kory

You should be able to send:

pw-bot: cr

to your own patch series and patchwork will mark the series are Change
Requested. That will stop it from being merged.

	Andrew

