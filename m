Return-Path: <linux-kernel+bounces-46702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E108442EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28E4282DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763AA86AC5;
	Wed, 31 Jan 2024 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pU1VFtBq"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E80880C07;
	Wed, 31 Jan 2024 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714512; cv=none; b=ZrXdp/Uf9VXQMRJiEZSDlA5DQyBuj69Z/LfW31aiORFOEfOAa6TnE4zzbGB7J+yF2E4PGG4njboorY6BAowko/6nAyxxo63IvUmqf0eKoUgZZqC7nLpa8HWYIwHZkA8gNV/i4ZZocb8Dz3/v/zO2yio2nk1lfxFrw5vTgJD3FJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714512; c=relaxed/simple;
	bh=q6mhv3JADRxbR9n/Wp1Nh4lEHJY3eahLQ5UjrWSbNB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSskZB2Jy55AVuRQ1iKXPZOGRF2mNjd2+AmYRTrQBs3cH9Pj5T3v5Y7wYsfyCiJrzsXT7XhU/0m6pShfhKN8UmHwZ2z75SjDPW3yLVN+RBb5YlXBtL67VZ9qeYUuw2wD+Ru0yzF2QclONB+0zcbQFElQ7FQgrBW/U8m3PLdVKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pU1VFtBq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=asPQLrb51OQChEodWg2dePcvhwLYID9ZT09x6YMMitA=; b=pU1VFtBqeOag5WKHQ6MLSSY5p7
	BVqLmjpSmj8bND/GJiETySDFtpILWTUT3zd1wewjVZTLRYO8/bekP3sDAqzJeKUG6jKYyx0G2ecHS
	gCSWqWd+PYv4VRHK5RL89uqmqzPs4kjOCAXnCXiaSSPTAFL+s77lIOX4CgbaLvPLJXOw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVCPI-006aqg-Fa; Wed, 31 Jan 2024 16:21:44 +0100
Date: Wed, 31 Jan 2024 16:21:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 12/13] net: phy: marvell-88q2xxx: cleanup
 mv88q2xxx_config_init
Message-ID: <c2bb9f1b-2003-4c0c-b6c0-1cee6ac6a5b8@lunn.ch>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-13-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122212848.3645785-13-dima.fedrau@gmail.com>

On Mon, Jan 22, 2024 at 10:28:45PM +0100, Dimitri Fedrau wrote:
> mv88q2xxx_config_init calls genphy_c45_read_pma which is done by
> mv88q2xxx_read_status, it calls also mv88q2xxx_config_aneg which is
> also called by the PHY state machine. Let the PHY state machine handle
> the phydriver ops in their intendend way.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

