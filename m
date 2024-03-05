Return-Path: <linux-kernel+bounces-92578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E570087226D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1317282712
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BA4126F3F;
	Tue,  5 Mar 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7K5oniR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345484683;
	Tue,  5 Mar 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651303; cv=none; b=bJbdGGaYbZU5YNvwkSPjd/FRbQPd30dG0hdrdDjemmH6Cn9eH3Xz079uus4rSO+cJLg++iu9yNcKBcPKD+DCX1vpKj/DG5X2R49IxKakxUVRbg5c+BR6OQ4f1vPtleJ3OYUYa3Mtss4RmGdCdVbvqSgT7tszjhPbElmYfIdWb9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651303; c=relaxed/simple;
	bh=kb0HU/bpu81+bPdS1bu4ZUmTsI3IRN22602RSyuVVlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AX8l65lun1IxoLnpW2oPe7RqvWDR+wwTatu+0hVefy+pAv2QPO5wEH/2CXkXjcD8QYWkGXJUCimFLdj0p7CGgyMEUBNKGlDeaWF5LEHx7WMMPgfu6WEwL9LXkIQqd9Nlj2Er6ZZVQ81iIVEyKXjNDick+Xg8Mqvx2xyr28aitfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7K5oniR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDD8C433C7;
	Tue,  5 Mar 2024 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709651303;
	bh=kb0HU/bpu81+bPdS1bu4ZUmTsI3IRN22602RSyuVVlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7K5oniR0R+3MqTla0QfY1U5DvqGXZ1O5zRn1mrswdu2kQxmQ4aay0nMetZ1J25So
	 PLDIPSDF0AqSxbWo9nCWBBxe93V0DR4KJtzDWVpDociPFs0orbDtIaFjBy8h7YNTlq
	 VXEb45vgTTIY5RJGFvWSJ5FBlryIMJx5XUn875K/YSnczJImIElKkIwWX/ZrqzJcDl
	 P+gtAg/gJ7fkGPcSMmK6ckHpteEH324QViltEdYhkiaZfaLNDqI8y6Iv1q8G+QCrZE
	 xqM8MQNn1lsNd3JWMg6jMhpu0Zfahhj8fAUAwUvsjzlLaoSGb8PekEWjj1oYBvvckE
	 DFf1YYgS7VD3A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rhWP7-000000000Uq-3pFe;
	Tue, 05 Mar 2024 16:08:30 +0100
Date: Tue, 5 Mar 2024 16:08:29 +0100
From: Johan Hovold <johan@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vinod.koul@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: Lenovo ThinkPad X13s regerssions (was Re: Linux regressions
 report for mainline [2024-02-25])
Message-ID: <Zec1bSx4H0VRmzfe@hovoldconsulting.com>
References: <170886726066.1516351.14377022830495300698@leemhuis.info>
 <Zd23ZKlNnDKPaU9I@hovoldconsulting.com>
 <83c6019f-9c6f-4ad1-87d5-e4f1bdaca93c@leemhuis.info>
 <ZecjcApvdZSGRysT@hovoldconsulting.com>
 <1726bbb2-2cdc-4cad-b6b1-295f6338e771@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726bbb2-2cdc-4cad-b6b1-295f6338e771@leemhuis.info>

On Tue, Mar 05, 2024 at 03:50:13PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 05.03.24 14:51, Johan Hovold wrote:
> > On Tue, Mar 05, 2024 at 10:33:39AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> [dropping Linus from CC, we can add him back later when needed]
> >>
> >> On 27.02.24 11:20, Johan Hovold wrote:

> >>> But also with these fixes, there are still a couple of regressions
> >>> related to the Qualcomm DRM runtime PM rework in 6.8-rc1. I'll send
> >>> separate reports to track those.
> >
> >> Any decision yet if they are going to be reverted for now?
> >>
> >> Am I right assuming those would fix
> >> https://lore.kernel.org/lkml/Zd3kvD02Qvsh2Sid@hovoldconsulting.com/
> >> which did not get even a single reply?
> > 
> > That was the hope, but I've managed to trigger a reset on disconnect
> > once also with the runtime PM series reverted.
> 
> Ohh. So did the PM series increase the chance of hitting this? Because
> if not, then...

What we know is that some change in 6.8-rc1 either introduced or
increased the chances of hitting the disconnect resets, while the
runtime PM series (and patch which has now been reverted) broke hotplug
detect.

> > One of the patches from that series has already been reverted (to fix
> > the VT console hotplug regression) and there is some indication that
> > that was sufficient to address the issue with hotplug not being detected
> > in X/Wayland too. I'm waiting for confirmation from some users that have
> > not been able to use their external displays at all since 6.8-rc1, but
> > it does seem to fix the X/Wayland issues I could reproduce here.
> > 
> > But either way, the reset on disconnect is still there, and have since
> > been reproduced by Bjorn also on another Qualcomm platform without a
> > hypervisor so that we've now got a call stack. I've heard that Abhinav
> > is looking into that, but I don't know if there's any chance to have a
> > fix ready this week.
> 
> ...this sounds (please correct me if I'm wrong) like on Sunday the
> situation likely will be "the problem is basically in 6.7.y already, so
> there is not much we can do for 6.8 and reverting or delaying the
> release is unneeded" -- unless of course a fix comes in reach during
> this week.

Yes, unless Abhinav and Bjorn can pinpoint the change that makes us hit
this since 6.8-rc1 and revert that change (or come up with some
temporary band-aid).

It is also possible that we're dealing more than one bug here, since
we're seeing resets both on disconnect and when stopping X some time
after a disconnect.

Johan

