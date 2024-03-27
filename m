Return-Path: <linux-kernel+bounces-121584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAED88EB47
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD92B2E8A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6181304A2;
	Wed, 27 Mar 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfFvfus0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95C12EBD5;
	Wed, 27 Mar 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555257; cv=none; b=gErfNU6eziTi/Y1yDjIp933fozZ5i3rz+9Uh+aBYr3/gioxYKPMEiTC066hq/D98sVRvdG/aUiNzKWy0lHRMx6bZ1xAWlPVY1vJJQ//35qOB4kMjNGd696ZxuDnu3kpsIwj+tfSP9vf6UYWjSVWWNxUwMu2gVPjd6XHbJBSCrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555257; c=relaxed/simple;
	bh=u6n+JOCbKSEs9oYkgfRBrVp4u4Bc/B/DGHjtaPIfQac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0sQpkGKPczu4LMgZ9QMhYb84nil3q/opKZLuKGkYUAYlcwoSAvcj7Jv+Svgb6oqgHpuC/rOYXvigvfIfjOlbA0FlTangyaHsV0WL3wVU5N8ZSIb233xos0w4c4btMMJkVtW4EXjjI5bwmKKnr/jKw/kVXLq83rTJ/l88HsLecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfFvfus0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01459C433C7;
	Wed, 27 Mar 2024 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711555257;
	bh=u6n+JOCbKSEs9oYkgfRBrVp4u4Bc/B/DGHjtaPIfQac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YfFvfus0K9rgM73e4RFSFYk9ZfrbyhADvtKBKQi6KsHAAuA3ky6rkjAzk1fIkl8gZ
	 J4B/HuKG8Yz1zqxAd1jswnvyh9WipcMNMqh2lEn23f2yBF5jzl8GPeQQnU47ZowJIB
	 paTPhlCxtNcPVfQjaKfOoEh+USnnbBUr9rmKX7LTBIRHbTgVWua5woTlnxcRwLxXqW
	 NZN8OaklRgaV+O9gXTNkNbo0Q4jsgjkORNzC7pMkm9Glh0r60PHro6vibRMEB9953n
	 2ylLAWKKRofiLmpTYMkl83GHcg16t1M2a81yGSJrT/H1QV4VB/qHe/rsz5Aacb/Vjv
	 +vOaFyiG1793Q==
Date: Wed, 27 Mar 2024 16:00:52 +0000
From: Simon Horman <horms@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: dave.stevenson@raspberrypi.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: usb: ax88179_178a: non necessary second
 random mac address
Message-ID: <20240327160052.GP403975@kernel.org>
References: <20240326092459.GG403975@kernel.org>
 <20240326163107.306612-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326163107.306612-1-jtornosm@redhat.com>

On Tue, Mar 26, 2024 at 05:31:07PM +0100, Jose Ignacio Tornos Martinez wrote:
> If the mac address can not be read from the device registers or the
> devicetree, a random address is generated, but this was already done from
> usbnet_probe, so it is not necessary to call eth_hw_addr_random from here
> again to generate another random address.
> 
> Indeed, when reset was also executed from bind, generate another random mac
> address invalidated the check from usbnet_probe to configure if the assigned
> mac address for the interface was random or not, because it is comparing
> with the initial generated random address. Now, with only a reset from open
> operation, it is just a harmless simplification.
> 
> cc: stable@vger.kernel.org # 6.6+
> Fixes: 9fb137aef34e ("net: usb: ax88179_178a: allow optionally getting mac address from device tree")
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> V1 -> V2:
> - Split the fix and the improvement in two patches and keep curly-brackets
> as Simon Horman suggests.

Hi Jose,

Thanks for splitting the patches.
They look good, but there are a few process issues.
Sorry for not being clearer in my previous email.

As the 2nd patch of the series is not a fix it:
- Should not have a fixes tag
- Should not be sent to stable
- Should be targeted at the net-next tree rather than the net tree

As the granularity of patch handling on netdev is generally at the
patchset level I believe that this means that you need to separately,
in different, new, email threads, repost:

1. Patch 1/2 of this series, targeted at net, with a Fixes tag

   [PATCH net v3] net: usb: ax88179_178a: avoid the interface always configured as random address

2. Patch 2/2 of this series, targeted at net-next, without a Fixes tag

   [PATCH net-next v3] et: usb: ax88179_178a: non necessary second random mac address

Also, please be sure to wait 24 hours since the posting of this patch-set
before reposting.

Some more information can be found here:
https://docs.kernel.org/process/maintainer-netdev.html

..

--
pw-bot: changes-requested

