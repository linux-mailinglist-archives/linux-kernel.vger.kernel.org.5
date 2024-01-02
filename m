Return-Path: <linux-kernel+bounces-14745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7DD822163
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC661F22F7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E91515ADE;
	Tue,  2 Jan 2024 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyDkr0Z2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138715AC7;
	Tue,  2 Jan 2024 18:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F84C433C7;
	Tue,  2 Jan 2024 18:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704221487;
	bh=iodPmT05aRTcXJyWyOSIYvKFTErh7rK0rweYkCiv/ac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jyDkr0Z24vtNunYWPWkmlfe0rzhamPgmk0RSxEjVXG2Bm0zZSroWwO/27uV39C+sd
	 32v+HYCkkYSi/cbRgp7UPvAtr650OZ/e0J26nS1oL/LXG5mi9uLnqwHDN92MXM3v2K
	 L3cUdKwi1l7TI2/ttUW+ifaMKO2fgqMdEc/XV1MVQ4obcuQrJO/BukVvGO9/AQzIob
	 4/BFRp9YXvqxcrfWgB5Fq2da67EEl1avuvIQmuBaX19x86U8/UA2/Bz+qln4fKK9Kb
	 BpHzpjx0e1cfpJeSMjIWPzmIuVrJqhUbE5Orsza9KhNE2XH5QAWijeXeqAI2jDA6xT
	 ZvJExRbVi1IMQ==
Date: Tue, 2 Jan 2024 10:51:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: patchwork-bot+netdevbpf@kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 christophe.leroy@csgroup.eu, herve.codina@bootlin.com,
 f.fainelli@gmail.com, hkallweit1@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, jesse.brandeburg@intel.com, corbet@lwn.net,
 kabel@kernel.org, piergiorgio.beruto@gmail.com, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org
Subject: Re: [PATCH net-next v5 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240102105125.77751812@kernel.org>
In-Reply-To: <ZZP6FV5sXEf+xd58@shell.armlinux.org.uk>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<170413442779.30948.3175948839165575294.git-patchwork-notify@kernel.org>
	<ZZP6FV5sXEf+xd58@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jan 2024 11:57:09 +0000 Russell King (Oracle) wrote:
> ... and I haven't reviewed this yet. I guess it's now pointless to
> review.

I guess the shutdown was only a partial success. Nobody cleaned out
pending stuff on the 23rd, and old things got applied now before we
even officially reopened :( It is what it is, please review anyway,
we'll be reverting things which shouldn't have been applied..

