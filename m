Return-Path: <linux-kernel+bounces-157132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEB78B0D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC2D1C20CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF551607B6;
	Wed, 24 Apr 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DJDC5Hxu"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992B1607A7;
	Wed, 24 Apr 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970336; cv=none; b=abBeLUUWan/OwqzV3vHaQaElEPgpuCWO8kfr26456LgnCPolAQMsax8paRuf0A/uve7tYR/ZJcpFez6UjogGVUgDh8RlWNrfbNSHS4COOBGn26lqKUxuEXFs/iwjE1A+vISDgwruD0r1hIgKHwTpCVzVTbzBy62ROAX0aC4Nef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970336; c=relaxed/simple;
	bh=8OG3L6tsch8ezyCz85g4zpluu0lHvX3mFSZnP8XVbLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdBQMedztEqKYYOGZ2vuvklREHVkPkv8QYBmPl3XtV0PrJCWcCnWbgNVMauhF5NJuWOKrOhWkcd83omzBuJin3Fn2EoKwjJbpOAKvm30xh8wIpLH9EVF7oKWpza/bC1O81P0oiKQ6/jRvZEVxPSQuzfKdRPJoL6fGRwnuTHsZfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DJDC5Hxu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UncEKkszVNTT7dkHQYzZF1Tpr275q25VsK0cIQfUi3M=; b=DJDC5HxuP2Mpm42o56fkaBKt+o
	K1eeAO21B584e/OBdkAlOSO9tbGncVaLIqDJ3EDC/vh4TI/SwrcG+04iGRvM4obRpoLBp81NR18/l
	o06LpY0zSYySl2MJqg+iXO68og5EM1WGJANKbf3s8NzzZEgX8sY+XuY/nXX6nzfHiZ6E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzdyd-00DpT4-Aj; Wed, 24 Apr 2024 16:52:03 +0200
Date: Wed, 24 Apr 2024 16:52:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH net-next] net: phy: marvell: add support for MV88E6020
 internal PHYs
Message-ID: <64dbfe14-e777-49e2-ab7d-ec6fa517a8f1@lunn.ch>
References: <20240424121022.160920-1-matthias.schiffer@ew.tq-group.com>
 <19c4b8da-203e-4a81-9531-9ba4a4f750fd@lunn.ch>
 <1cb8bafb44075858221b31c056d75a40d7ba2ee1.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cb8bafb44075858221b31c056d75a40d7ba2ee1.camel@ew.tq-group.com>

> We currently do not override the PHY ID for this family in the DSA
> driver - my understanding was that this is only necessary for
> switches that don't provide a usable PHY ID at all. As I have no
> idea if this PHY ID works for the whole family or just the single
> switch, I went with the more specific naming here.

The 'broken' switches have the Marvell OUI, but no module number. From
your description it sounds like the 6250 is the same?

     Andrew

