Return-Path: <linux-kernel+bounces-148293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1271B8A8071
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFB21F215F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733E613AD15;
	Wed, 17 Apr 2024 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh+9nV4K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42781327E0;
	Wed, 17 Apr 2024 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348870; cv=none; b=roa8gm6HRy9veBKcXDfyqi0mEpD2Ao4kn/4lNaTZLBDFV3aRDksxCynl07nbjMjhQjKnxssjnn9dxjL5ywoixQWDkufMFghDYAkYh4abXgtJQENIGgMfysoJSKQwwjARrlk9JzkiRtsy7hdAR3SqeCNbQb+b+Nf4InPwnraRsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348870; c=relaxed/simple;
	bh=uqTux5BTqNidcvCVoro4kFIdtrbsx5D1uzrP63oND7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/Z30QuiUuTPhwutUf0/fcZtObgnKc3fFnKHbzhXIC2jjTQ+lqzM5j8YeSUPlipV3kSpR5JUf9kvxrEbO4z9itVyRaack1nLh+yNhM0j5zXGxqm56yTS2nXtu92gVTGYPhkG21wRGwFnCmrhIXVl3xJh+BKglj9MqXc78PtvXlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh+9nV4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE307C072AA;
	Wed, 17 Apr 2024 10:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713348870;
	bh=uqTux5BTqNidcvCVoro4kFIdtrbsx5D1uzrP63oND7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hh+9nV4K8q7rWXefDX5J2ndsQMC6AahShC5P+5AzThF5xYCY8gxZuZaulKRlRWq1a
	 CGd1nB6oUrJnpyS10YmNrEhUgLkWvjSU5PcV9WFcwmJTJ61pibz4qgs10EMls0ffDp
	 /fAvFA7MAC8Ef1Me57h9VG03rCKtVyn2vVnEciGHItJgQRrbOeZtBatz4tRVXDjV/A
	 TQZGpYV5MfI1dLmII194BgVeImCwpAjszZswPkuY5nwAWORnubcuXpRD5fx0+xhldC
	 nXDSs62dNywce2tJanrDeLCnAZws5m5e0O2nH9FdYYUYl5ZuxZWTkiWjytbqzA0aAZ
	 f51kPp9nposVg==
Date: Wed, 17 Apr 2024 12:14:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Gustav Ekelund <gustaek@axis.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Gustav Ekelund <gustav.ekelund@axis.com>, hare@suse.de,
	martin.petersen@oracle.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] ata: Add sdev attribute to lower link speed in runtime
Message-ID: <Zh-hASYS4XkyNJc9@ryzen>
References: <20240412134838.788502-1-gustav.ekelund@axis.com>
 <4e5c88f1-1b24-4f6d-8c11-d7029329ba7a@kernel.org>
 <7e6eb387-5a0e-460c-af08-eff070fa35ca@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e6eb387-5a0e-460c-af08-eff070fa35ca@axis.com>

On Mon, Apr 15, 2024 at 04:49:46PM +0200, Gustav Ekelund wrote:
> On 4/13/24 02:29, Damien Le Moal wrote:
> > On 4/12/24 22:48, Gustav Ekelund wrote:
> >> Expose a new sysfs attribute to userspace that gives root the ability to
> >> lower the link speed in a scsi_device at runtime. The handle enables
> >> programs to, based on external circumstances that may be unbeknownst to
> >> the kernel, determine if a link should slow down to perhaps achieve a
> >> stabler signal. External circumstances could include the mission time
> >> of the connected hardware or observations to temperature trends.
> > 
> > may, perhaps, could... This does not sound very deterministic. Do you have an
> > actual practical use case where this patch is useful and solve a real problem ?
> > 
> > Strictly speaking, if you are seeing link stability issues due to temperature or
> > other environmental factors (humidity, altitude), then either you are operating
> > your hardware (board and/or HDD) outside of their environmental specifications,
> > or you have some serious hardware issues (which can be a simple as a bad SATA
> > cable or an inappropriate power supply). In both cases, I do not think that this
> > patch will be of any help.
> > 
> > Furthermore, libata already lowers a link speed automatically at runtime if it
> > sees too many NCQ errors. Isn't that enough ? And we also have the horkage flags
> > to force a maximum link speed for a device/adapter, which can also be specified
> > as a libata module argument (libata.force).
> > 
> >> Writing 1 to /sys/block/*/device/down_link_spd signals the kernel to
> >> first lower the link speed one step with sata_down_spd_limit and then
> >> finish off with sata_link_hardreset.
> > 
> > We already have "/sys/class/ata_link/*/hw_sata_spd_limit", which is read-only
> > for now. So if you can really justify this manual link speed tuning for an
> > actual use case (not a hypothetical one), then the way to go would be to make
> > that attribute RW and implement its store() method to lower the link speed at
> > runtime.
> > 
> > And by the way, looking at what that attribute says, I always get:
> > <unknown>
> > 
> > So it looks like there is an issue with it that went unnoticed (because no one
> > is using it...). This needs some fixing.
> > 
> Hello Damien and Niklas,
> 
> Thank you for the feedback.
> 
> I have a hotplug system, where the links behave differently depending
> on the disk model connected. For some models the kernel emits a lot of
> bus errors, but mostly not enough errors for it to automatically lower
> the link speed, except during high workloads. I have not observed any
> data-loss regarding the errors, but the excessive logging becomes a problem.

It might be interesting to compare the output of:
$ hdparm -I

for a drive that you can hot plug insert without errors, against a drive
that gives you errors on hot plug insertion, to see if this can give you
a hint of why they behave differently.

(e.g. certain features, e.g. DevSleep, is only enabled if there is support
in the HBA, the port, and the drive.)


Kind regards,
Niklas

