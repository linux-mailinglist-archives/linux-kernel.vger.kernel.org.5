Return-Path: <linux-kernel+bounces-55543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A647984BDEF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91111C2444C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E0E14AA8;
	Tue,  6 Feb 2024 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Z/68Qkyx"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76AB13FF0;
	Tue,  6 Feb 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246577; cv=none; b=MKdYnkskbopFLP0zylyKfd8Xe/zrG0diuQv5w+xwB5vRpcqVn0E2WW1KD/hZbT+VmQiGbGyEf39uwdfo+cs8KEfYQAMU5WN1/lN506jX2P1qkWV7g/XLCel9ain4e5RKSmbqCNqrWoxvTuoHZWkejqityw195aQdhIw5JrTjvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246577; c=relaxed/simple;
	bh=ICT9GMmbWANWtV3WdQlzASzd3A+oLCs55eUv8T8iveY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDoT7cnp64eWASETjjCTi8u/Eu3Kh0fLN5uomHRpoGsJVehLAyhaIUnl3v27jo+X+vj0Sb+7W2uhRQsi0eLRTtrpvR1WIXwkcmGIpjS6Ug4/YsIOfVglXfU8Od1h+2dx+O4GnOtDR13D4Htc/WjdswZNsZMMuUSY86nsWW838RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Z/68Qkyx; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EA07622268;
	Tue,  6 Feb 2024 20:09:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707246572;
	bh=T7oA3o1/PV86rg/COPWoNeGWudEDqQS1SUtT78lzkFQ=;
	h=Received:From:To:Subject;
	b=Z/68Qkyx9maE5F2kdosAHBwgsa8JoWXLPIxbGMerQ3NiyEB6KxiJsyCmP69dSqGpG
	 QoEGS0y9M0J5IvqyYSA0qmZBJyzoTkINmqrz83JYAdk6IcFnQqdOOuiQPoL5AjISRJ
	 wfDhwYsFWINXVHHxd1GYs1LtE9KqiybGCSevQZR8k2n0pGs72RseXDGAV0XoNvsTHg
	 dnww4I3OGkVZQ/WVRiT/lnjEvDDXSUgfMJcEyYE8/tTkOaW8SjimNZhCvJXGmQ0lmz
	 FZudZKIiQtN2rNMQ+70KVeqJhkTTpbpTO99V940gvvU2rJb8vJrbCDajtQ9x2yp/dm
	 YbLPyonDAO1HA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 8FB077F98B; Tue,  6 Feb 2024 20:09:31 +0100 (CET)
Date: Tue, 6 Feb 2024 20:09:31 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] net: phy: micrel: reset KSZ9x31 when resuming
Message-ID: <ZcKD69vLxYkbvAL-@gaggiata.pivistrello.it>
References: <20240109205223.40219-1-wsa+renesas@sang-engineering.com>
 <20240109232838.GA3626@francesco-nb>
 <ZafXQS1_4fHpEzL0@ninjato>
 <20240206172645.GA24848@francesco-nb>
 <dbae1fca-9313-40e3-9b5c-0de1a8e177df@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbae1fca-9313-40e3-9b5c-0de1a8e177df@lunn.ch>

On Tue, Feb 06, 2024 at 06:57:37PM +0100, Andrew Lunn wrote:
> On Tue, Feb 06, 2024 at 06:26:45PM +0100, Francesco Dolcini wrote:
> > On Wed, Jan 17, 2024 at 02:33:53PM +0100, Wolfram Sang wrote:
> > > Makes sense? Tests work fine here, at least.
> > 
> > What I do not know, is what happen to any configuration that was done to
> > the phy before.
> 
> I'm assuming here WoL was not enabled, so the PHY did actually
> suspend.
> 
> mdio_bus_phy_suspend() calls phy_stop_machine() which will set the
> state of the PHY to UP.
> 
> During resume mdio_bus_phy_resume() calls phy_init_hw(). That should
> do a soft reset, call the config_init() callback, and configure
> interrupts. After that phy_resume() is called and then
> phy_state_machine(). Do to setting the state to UP, the state machine
> will kick off auto-negotiation, which will cause any auto-neg
> parameters to be written to the PHY.
> 
> > What if you have disabled gigabit ethernet from auto negotiation before
> > suspend, it will be enabled again after the phy get out of reset.
> 
> If you have set in fixed mode, the wrongly named phy_config_aneg()
> will set the fixed modes, same as it would set the auto-neg modes. So
> they should be preserved over suspend/resume.

Thanks for the detailed explanation Andrew.

What if the configuration was done using ethtool?

Francesco

