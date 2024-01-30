Return-Path: <linux-kernel+bounces-43797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 209BB8418EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A4AB222C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5D736B0A;
	Tue, 30 Jan 2024 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXUgv+ey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85915B0EC;
	Tue, 30 Jan 2024 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580602; cv=none; b=qXp1HanysdkD0oEbQBF4BWLvHd0VzNMYaY62EvQfRRc0xqnj5WF7O5UXCGPIxWP7AfZiyEgnppDe/+QEuFcwZ27ghgLqg+sTN2KLT/L351Y+wC0VeJxdDW2PHB2Wl7Yf4HQuEx27IcsUhTJoFl4Eb8m8PD6ZNe8ivuQ11rLlMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580602; c=relaxed/simple;
	bh=MslyLyLtkNeZN/XbS7LDK6PTpQDHaV2q6pV5kODuDUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIl9bfbecjwuTtSRrTnxdDxEU+2iLimR/7OVhz/BF4WQEITcWxHwXVpMeih4mAhkxRsqKOQGN47p2X2DocssoVvRf7JRfu/g7tgcfX1oVw2FoVLqgpqWN2oD/P6K56HXfAb5idPTJ940oRQ7Y87Ve3y4gylAtAaE2yWy4Jwk6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXUgv+ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1DDC433C7;
	Tue, 30 Jan 2024 02:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706580601;
	bh=MslyLyLtkNeZN/XbS7LDK6PTpQDHaV2q6pV5kODuDUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XXUgv+eyKYSfK8nkDipNeihYKctwmL6GxBrOEeBmH4XTIfcFC1SF5QmUljCLUWJXy
	 WGhrLCOy0hsmcqnaikbDsuysG7SEfvuqBNouu4WR3x8lf+BZ7Lik7SWs93edKIoY9L
	 H04vM4e94IFjjTuCA+shNEWnvq6PhzDNanh1DeetQ+ycozz6XJ2DdTMWHnHkvvpyqO
	 CGwzkmqrT0B1k64u1lWn4HJEcSC3fHimZ/06dwldjxNJIpp8MKn+Y3zfhTqiCBLFKY
	 oFdhqM6Fvtx8kEQ0XaUZmUwckvSqalqOYiGBFMemNZSh+BTiLc2QzuC8dUhqSU5UKe
	 lzaTXso+brnJw==
Date: Mon, 29 Jan 2024 18:09:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Stefan Eichenberger <eichest@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 00/13] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2220 PHY
Message-ID: <20240129180959.582dbc88@kernel.org>
In-Reply-To: <20240122212848.3645785-1-dima.fedrau@gmail.com>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 22:28:33 +0100 Dimitri Fedrau wrote:
> Changes in V5:
> 	- add missing statics for mv88q222x_revb0_init_seq0 and
> 	  mv88q222x_revb0_init_seq1
> 	- fix typo in commit message: autonegotiation
> 	- fix ordering of Signed-off-by and Reviewed-by in commit messages
> 	- add interrupt support for link detection
> 	- add suspend / resume ops
> 	- add support for internal temperature sensor
> 	- add cable test support
> 	- call .soft_reset in mv88q2xxx_config_aneg, this makes
> 	  mv88q2xxx_config_aneg compatible for Marvell88Q222x devices and
> 	  remove mv88q222x_config_aneg which is then just duplicated code
> 	- cleanup mv88q2xxx_config_init and make it compatible with
> 	  Marvell88Q222x devices
> 	- move parts from mv88q222x_config_init to mv88q2xxx_config_init
> 	  that are applicable for all Marvell88Q2xxx devices.

PHY maintainers - could anyone take a look at these patches?

