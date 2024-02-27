Return-Path: <linux-kernel+bounces-83021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0392B868D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B9A28B0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48BD13849F;
	Tue, 27 Feb 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9wkRx0F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6191138493;
	Tue, 27 Feb 2024 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029218; cv=none; b=PWbXC5QAQof5Jm9IH+/6sU6xubKH0f0tWJtrjMRW+o3Lh1EdC4hVl24E4aUyjOHKQVt+UBZdklhdeCQkdZk7jFWrUkPldVihx1h+wfv/poNfQuaJGcZUg4M87R9hkufgA3liSFmNbwd8pQeTPdjQY0iWLdA5wWY0+WY/Kmk5reU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029218; c=relaxed/simple;
	bh=2jY/Q1QEdmyK669q6iJw5r6Thx2kyp1FRQuFTYB/9Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExvY4Zf7GWacYrMsB9NKAr7sQMNjkB31jnWGpbmnNdUjFgqGAcNkXMEhTa7nPU3adA5lTP26DDPjQSNGCMoD9dQ+EUMfe8kjPUhFcfiid0skPf00eGcPziivEqlBNms8KnpoSks4SCGXz/CL0ijG6wbh96sj3z/5khRM4p0KBrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9wkRx0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67763C433C7;
	Tue, 27 Feb 2024 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709029217;
	bh=2jY/Q1QEdmyK669q6iJw5r6Thx2kyp1FRQuFTYB/9Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9wkRx0FWSM2Wi52xH7nRkker4XhCGXaRgHzeCLII7LrF1VubvPUlD6iDr8kXVXXk
	 f3PQo3/+5cpsS8bcUPnrQjSwUwMxm1/cUo3NiIndBLIefEUsJLD1Fq0+PW4PR/LtLh
	 4V2Xe+InmM6OLon5IMkmoYZpChSCOspnGsyZKVkVcaAOOxcySK/ZLW8MYkc/YTwJg5
	 SEQSVjEYDmaySbhHzheqltJDyyo55JuTkFQUInllIMR9bOvgiBzoazVRJ/FbHAu9g2
	 B/1/wrQB4Zdxr4cg89M3DUSdfmh5umaOIVC7tPWU07bY3kPGec5cnjQl/yWUipyIKc
	 sJqnpu3EJGBGg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1reuZQ-000000004LH-1P1i;
	Tue, 27 Feb 2024 11:20:20 +0100
Date: Tue, 27 Feb 2024 11:20:20 +0100
From: Johan Hovold <johan@kernel.org>
To: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Linux regressions report  for mainline [2024-02-25]
Message-ID: <Zd23ZKlNnDKPaU9I@hovoldconsulting.com>
References: <170886726066.1516351.14377022830495300698@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170886726066.1516351.14377022830495300698@leemhuis.info>

On Sun, Feb 25, 2024 at 01:21:46PM +0000, Regzbot (on behalf of Thorsten Leemhuis) wrote:

> Johan Hovold also deals with multiple issues affecting Lenovo ThinkPad
> X13s, but he send out patch series to fix some or all of those[1], so
> with a bit of luck those issues will soon be fixed as well.
> https://lore.kernel.org/lkml/ZctVmLK4zTwcpW3A@hovoldconsulting.com/

> [1]
> https://lore.kernel.org/lkml/20240217150228.5788-1-johan+linaro@kernel.org/

This series addresses a use-after-free in the PMIC glink driver caused
by DRM bridge changes in rc1 and which can result in the internal
display not showing up on boot.

The DRM/SoC fixes here have now been merged to drm-misc for 6.8.

> https://lore.kernel.org/lkml/20240223152124.20042-1-johan+linaro@kernel.org/

This series is unrelated to the DRM regressions and deals with PCIe ASPM
issues.

> [ *NEW* ] drm/msm/dp: runtime PM cause internal eDP display on the Lenovo ThinkPad X13s to not always show up on boot (2/2 regressions)
> ---------------------------------------------------------------------------------------------------------------------------------------
> https://linux-regtracking.leemhuis.info/regzbot/regression/lore/faad839a-4c28-449f-bd87-845b47a1a6a1@leemhuis.info/
> https://lore.kernel.org/regressions/faad839a-4c28-449f-bd87-845b47a1a6a1@leemhuis.info/
> 
> By Johan Hovold; 2 days ago; 5 activities, latest 2 days ago.
> Introduced in 5814b8bf086a (v6.8-rc1)

> Noteworthy links:
> * drm/msm: Second DisplayPort regression in 6.8-rc1
>   https://lore.kernel.org/lkml/ZdMwZa98L23mu3u6@hovoldconsulting.com/
>   6 days ago, by Johan Hovold; thread monitored.

This regression is the most severe one as it triggers hard resets on
boot occasionally (I just tried updating the regzbot title).

This turned out to be due to a long-standing issue in a Qualcomm PM
domain driver. Bjorn A posted a fix over night which addresses this:

	https://lore.kernel.org/linux-arm-msm/20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com/T/#u

But also with these fixes, there are still a couple of regressions
related to the Qualcomm DRM runtime PM rework in 6.8-rc1. I'll send
separate reports to track those.

Johan

