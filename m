Return-Path: <linux-kernel+bounces-48227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7218458CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DFD2B24165
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0935CDCE;
	Thu,  1 Feb 2024 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y63Gy8Rz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9925CDC4;
	Thu,  1 Feb 2024 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793808; cv=none; b=sj4pGi8AVh+DP6cKmOJcEbrMH2w8jMkQfGWMv6qlLD5OC4X6waJS1Xy+ZF6B8JDIL90t7tLS8pvAozFs4g6zBivVbmrSIimzoIU6xvNLt1JaB+R2f/R47FVCdnhle5GqYbSNeOSheMKF1ALFnryFC/9p3SgWbe8hXxDvkdRscAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793808; c=relaxed/simple;
	bh=3+x2EsXavQCIPebwcAOQUOLpFvb0FfdGkO6b1Hxf+2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9A7CaKn4Qp966tEpgWP9yoBQ+I9sKX4UOpoc21nnmZotxAggB9QqHmK4HcC4/4S7zbB2yNdfp/65khpwMTa+q24NgV5RTG8TITkL+h0gSHr4oNlN28JQyn5/CcVVFiq8a2qUpC/tVYKOq1c9buNm5sGgSRR66sW9u/2J5a48nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y63Gy8Rz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kLRyFqez982lPckWXQj/NwGeBDgZ8+2imJpiNJYpFj0=; b=y63Gy8RzuZglUXnHCGw1Fa7aPE
	bY7p/1wK+aQ/foxrGxt7VbFyrAzwx2DgrZQNP/6k+FkWuJ7Ox0A+jNRp7e4mN3h1RWT+a6c57CfoS
	xTU9YUN9hq02TjPRgzqwf5AAKaI4MvW5C9YHTmTFEVcgtlbYNSpMd+EOIhlVPtlxbLZw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVX2B-006fzU-K6; Thu, 01 Feb 2024 14:23:15 +0100
Date: Thu, 1 Feb 2024 14:23:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Message-ID: <a8d7125d-156c-4c7e-a49d-d246719dcfe2@lunn.ch>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <65071184-428b-4850-9e0c-baaa73513c6d@lunn.ch>
 <20240201071137.GA41347@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201071137.GA41347@debian>

> Anyway it's wrong. I couldn't find a good solution to use the temperature
> interrupt. Will have a look into this, and probably figuring out how to
> do so. But it won't be part of this patch series.

I don't know of any PHY driver you can follow, those that do have a
temperature sensor just report the temperature and don't do anything
in addition.

You might need to look at thermal zones, and indicate there has been a
thermal trip point. That could then be used by the thermal subsystem
to increase cooling via a fan, etc. In theory, you could also make the
PHY active to thermal pressure, by forcing the link to renegotiate to
a lower link speed. If you decide to go this route, please try to make
is generic to any PHY. But its going to be quite a disruptive thing,
the link will be lost of a little over a second...

   Andrew

