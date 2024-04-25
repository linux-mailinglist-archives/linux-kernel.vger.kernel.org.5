Return-Path: <linux-kernel+bounces-158964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969028B2769
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D941F25BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD7C14EC4A;
	Thu, 25 Apr 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fug2jzr5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8514E2E9;
	Thu, 25 Apr 2024 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065313; cv=none; b=KzWbxhhyOirTfxEW6C6RWMlXcgeDrHndVrEVg5v4htDz9IYD6UqOBPf6Jsct4Sd8NSEe1HtbZC5KpJvFPK1Z3wDkIXCkN1IirRlhd2F5XK+6Hz9T2f0uc5sN47g2npBWQF2r4+lP1IgUPDfDkJL/e5pNmpJ1BFaC603/Vw1uoYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065313; c=relaxed/simple;
	bh=OXfscdyiLjA/W3jh08CqV7Sp2kSFAJOevRHG9arZCqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAsqvI6F2PC7m8nOcTJv8/Omam76jI+9iQHe0KPI3jDOzilI5V/rqLa5o/8NI6Jat1pVu9lRI0HXlE77yFeJSEFd5Sdu8364RO+Eln2+h895by9kzO/FsvZuAuLhJgZJIMn2cwsHpmkg3VawHfvjoXFLINwHrQ/4arCjaEuD6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fug2jzr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B570C113CC;
	Thu, 25 Apr 2024 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714065312;
	bh=OXfscdyiLjA/W3jh08CqV7Sp2kSFAJOevRHG9arZCqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fug2jzr5lG5Pa11Uq5uR1WbszFuNmLKM1x9xTYNpiY3FLojNaO/qUKRSbKUoGAD+E
	 VLxadnRbkVv5XQEt3q1UVv9dVHeZeES/U63hSn/Xx2rnHR7XAGVhMYTAqry2R14eiq
	 bYA7ulxHHYnZyRKa/zCMdGLqnaD6oSNWmMGgXQBFV1epng0fknKVE8iE9VQFMJ6Cur
	 dmMYuvxjGjf15FzyBkS/R1ut2zTcIN1FM4CuwF1IXLf8FrWvX1boFNgXA081VcqYPt
	 lYR0AMhiZ6iF3ksMkn5uwqj8jtj73iVwGuKO1A/Gp6/iOXVDUYx5/dF3RIepfCiOlJ
	 D7RNaXlGSK54w==
Date: Thu, 25 Apr 2024 10:15:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <20240425101511.6a3a517c@kernel.org>
In-Reply-To: <20240425190426.1a1a7d00@kmaincent-XPS-13-7390>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
	<ZiebQLdu9dOh1v-T@nanopsycho>
	<20240425103110.33c02857@kmaincent-XPS-13-7390>
	<20240425070619.601d5e40@kernel.org>
	<20240425163002.5894c5e5@kmaincent-XPS-13-7390>
	<20240425074205.28677540@kernel.org>
	<20240425165708.62637485@kmaincent-XPS-13-7390>
	<20240425080724.15be46e9@kernel.org>
	<20240425190426.1a1a7d00@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 19:04:26 +0200 Kory Maincent wrote:
> > That one was fine:
> > 
> > https://patchwork.kernel.org/project/netdevbpf/cover/20240422-feature_ptp_netnext-v11-0-f14441f2a1d8@bootlin.com/
> > 
> > Are you thinking it's the extra From in the cover letter?  
> 
> Maybe or some patches between b4 version 0.13.0 and 0.14-dev. I will try
> next time without my extra From b4 patch to test 0.14-dev.

Another random thought is that some people put the name in quotes if
it contains non-trivial chars, so may be worth trying with:

From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

