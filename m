Return-Path: <linux-kernel+bounces-17361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70814824C45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC751C22349
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD561FB2;
	Fri,  5 Jan 2024 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T867SE5D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245191845;
	Fri,  5 Jan 2024 00:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12FFC433C7;
	Fri,  5 Jan 2024 00:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704416171;
	bh=k4ElxgdIDUFZm/OwSjcJ4qnDgBAxFTnJp7f0bYL3MgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T867SE5DK7RQwDO+NYYFo29zNkInS2SHh8vOLKK+grd7oZsSOj89NeSmGMIxEkuul
	 k2J0esgBFt/WK+pyeUT36pFKB6pgGTjffaekg9hRX4v+k4QRHW8h5JOBvxzjRNpz6c
	 vVpLB4ELYaNV+FwEamDuaTSyYZDsHpHF8IfjxOMD1wPHbJCiWjTXGLKc5MGyq8v54L
	 n5kMqHlpdW//1TpB2pDu8SuC1pPJHwcbHkR3NG0qkT7H7qImx9fHFkWtM7Sm7rH6kf
	 za4t0nFpGkjLSwVcU59DjJsrZimTySlTuaj0bYMWkE2Q+jId0hyXfT+pXPqy6BnspS
	 m8ar15rSntOBw==
Date: Thu, 4 Jan 2024 16:56:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, "Russell King
 (Oracle)" <linux@armlinux.org.uk>, patchwork-bot+netdevbpf@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 christophe.leroy@csgroup.eu, herve.codina@bootlin.com,
 hkallweit1@gmail.com, vladimir.oltean@nxp.com, kory.maincent@bootlin.com,
 jesse.brandeburg@intel.com, corbet@lwn.net, kabel@kernel.org,
 piergiorgio.beruto@gmail.com, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org
Subject: Re: [PATCH net-next v5 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240104165609.5a56cac1@kernel.org>
In-Reply-To: <1447ce09-f90e-4ba2-a6f7-e5cb23bf724f@gmail.com>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<170413442779.30948.3175948839165575294.git-patchwork-notify@kernel.org>
	<ZZP6FV5sXEf+xd58@shell.armlinux.org.uk>
	<20240102105125.77751812@kernel.org>
	<20240103153336.424dcfe3@device-28.home>
	<20240104154721.192694a8@kernel.org>
	<1447ce09-f90e-4ba2-a6f7-e5cb23bf724f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 15:50:40 -0800 Florian Fainelli wrote:
> > The netlink handling looks a bit wobbly to me.
> > I commented best I could in the 20min I had to look at this code :(
> > I think it'd be best to revert, if you don't mind, because reviewing
> > incremental fixes will get even harder.  
> 
> +1

Okay, let's say that the three of us - Florian, Russell
and I are a quorum? :) Reverted.

