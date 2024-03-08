Return-Path: <linux-kernel+bounces-97031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67012876496
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5781A1C21B45
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ED11B947;
	Fri,  8 Mar 2024 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+7uzEgl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CEA63B8;
	Fri,  8 Mar 2024 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902543; cv=none; b=rAFK6NGMKtEqzu2ttZrm7F+jKQzwei/aFbnUOv/pulpuimHCvCHTGEnHjpj1DZhQsCNZGr2rgrfIjT4CVhUzVt51Dyfou00hGJ6TjNnT8OUVaRcaME4G19BuD5IKnNsCMwhfyzbspNO2LllKq7rD9Kck/HQwmUJ5O245YJOtCrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902543; c=relaxed/simple;
	bh=XzlD8OK+n2+8xxnxUIfr7jDUUAa8eBm1PY9cIuQU2Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtYaBSMtEQ22UBdd0UaGtt1bFzUjurcBfszSSY3UpXc0Qtuey04QjtXgvE4T74y0cQPWyvq+/MubrozdL44ZUKGXY1OFuktpE93B0mDPpRwBUU1SHFVMT8Ms+REgNajBikud1W8X0SCypcsd2aSnD4E/FMgQhTEhnaA8omZKn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+7uzEgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6490C433F1;
	Fri,  8 Mar 2024 12:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709902542;
	bh=XzlD8OK+n2+8xxnxUIfr7jDUUAa8eBm1PY9cIuQU2Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+7uzEglLWDQFyNu1AHUm/0A3RA1njvNqcsFtlLxGMTpEIJQPoqFqMn5LmIpnoZvX
	 Gy+9hmogANN4mkIjbjwaTMe8RWwy7JVWsJBs843XLOP5DaJtrS+jLf3FsI/TVbbUi5
	 ee1XQ5WI1t+0Q6P4//COxaV9bJXKTJItCt200dL65lvgHoiS5SfogrBOU0PD8lL4lS
	 MxDnHFPhyUBMPqLuXdDGOqZTND25R41iA0KqqZn6/MYN4ce2/STj8Vx6xXxg5CeDG4
	 Iie7fMOKCK6aerRWEcmVLFz6A787X4/R3R85zVXMpIvQFI0ab81wZU+PF7D+bA8VJ/
	 EAl1noOaoVCug==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1riZlN-000000001rW-2J4a;
	Fri, 08 Mar 2024 13:55:50 +0100
Date: Fri, 8 Mar 2024 13:55:49 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	Vinod Koul <vinod.koul@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: Lenovo ThinkPad X13s regerssions (was Re: Linux regressions
 report for mainline [2024-02-25])
Message-ID: <ZesK1SKUB9BVKouF@hovoldconsulting.com>
References: <170886726066.1516351.14377022830495300698@leemhuis.info>
 <Zd23ZKlNnDKPaU9I@hovoldconsulting.com>
 <83c6019f-9c6f-4ad1-87d5-e4f1bdaca93c@leemhuis.info>
 <ZecjcApvdZSGRysT@hovoldconsulting.com>
 <20240306041947.GG3213752@hu-bjorande-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306041947.GG3213752@hu-bjorande-lv.qualcomm.com>

On Tue, Mar 05, 2024 at 08:19:47PM -0800, Bjorn Andersson wrote:
> On Tue, Mar 05, 2024 at 02:51:44PM +0100, Johan Hovold wrote:
> > On Tue, Mar 05, 2024 at 10:33:39AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:

> > > Any decision yet if they are going to be reverted for now?
> > >
> > > Am I right assuming those would fix
> > > https://lore.kernel.org/lkml/Zd3kvD02Qvsh2Sid@hovoldconsulting.com/
> > > which did not get even a single reply?
> > 
> > That was the hope, but I've managed to trigger a reset on disconnect
> > once also with the runtime PM series reverted.

I have not been able to reproduce the reset with the series reverted,
and after reviewing the code in question it seems unlikely that I ever
did so.

> > One of the patches from that series has already been reverted (to fix
> > the VT console hotplug regression) and there is some indication that
> > that was sufficient to address the issue with hotplug not being detected
> > in X/Wayland too. I'm waiting for confirmation from some users that have
> > not been able to use their external displays at all since 6.8-rc1, but
> > it does seem to fix the X/Wayland issues I could reproduce here.

> I bumped my X13s to v6.8-rc7 earlier today and took it for a spin.
> 
> I was successfully able to plug/unplug my main display both in fbcon and
> Wayland (sway) a number of times, I was able to boot with external
> display connected and have it show up in fbcon and then survive into
> sway. I tried suspending (echo mem > /sys/power/state) and got back from
> that state a few times without problems.
> 
> Mixing connection/disconnection with being in suspended state was less
> successful and I was able to crash the machine twice here - but I can't
> say this worked before... (As previously we would not have eDP after
> suspending with external display).
> 
> So, things are looking much better with -rc7, but of course, my test
> scope is limited.

Thanks for confirming. The revert in rc7 seems to help with the hotplug
detect issues I could reproduce too. And for some reason, I can no
longer seem to reproduce the reset either, possibly due to unrelated
changes in timing (e.g. as I don't see it after reapplying the reverted
patch either). 

I just spent some more time on this driver and sent a follow-up report
here:

	https://lore.kernel.org/lkml/ZesH21DcfOldRD9g@hovoldconsulting.com/

It seems quite clear to me that the reset-on-disconnect regression have
been introduced by the runtime PM series and I don't currently see how
the hotplug notification revert in rc7 could have fixed it.

Johan

