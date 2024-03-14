Return-Path: <linux-kernel+bounces-103465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2AF87BFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE091C220ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6158B71B25;
	Thu, 14 Mar 2024 15:17:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191F371738;
	Thu, 14 Mar 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429428; cv=none; b=mPWLhbj+p2JeWR4sMi1sg0S2hNY33AqKqVgBGbHTtq/wRGWy4yIyvCqG0TAaYYjFDQJNdIxRy8X01UNVj1gsTXsWKjPMms1N9MHgbBxEy6jU7y4ECdqMncDH0+vVo+FaZyzfrF2aonySKvKzFaBAapyCykNWxa3XgIU6C29/OM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429428; c=relaxed/simple;
	bh=nJSdqGpDfoAcpzNxMMTCuqm2yzJZLVFp6mo7pIJTDEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqTHPnmkYfFA4uYMKgFZRPkIeNEl/tvKO4VDxEQQ9qLM9rcu3BjnEgzHvxOw7jT14u++M61Bi22WivZCV0AJooCXuy2cpDfFHmkRG8hae11Jh5g4JWRjW+qBqGbTDkFXgXNntqOBo2CuJUu7lGAv5Xp5hF9ctdsJCw2d+KSYThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B9311007;
	Thu, 14 Mar 2024 08:17:41 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.33.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0603C3F762;
	Thu, 14 Mar 2024 08:17:01 -0700 (PDT)
Date: Thu, 14 Mar 2024 15:16:53 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: Add Arm remoteproc driver
Message-ID: <20240314151653.GA40443@e130802.arm.com>
References: <ZeYWKVpeFm1+4mlT@p14s>
 <20240307194026.GA355455@e130802.arm.com>
 <CANLsYkzA20rQdTM6AOvFK=3o28GvcoRbckL=ri8RegHqyHaiCw@mail.gmail.com>
 <20240311114442.GA82865@e130802.arm.com>
 <CANLsYkwReJvB1UWvR5TwtSs-w_VqU45kDSUzuQ0k+waetEn6Yw@mail.gmail.com>
 <20240312173252.GA38992@e130802.arm.com>
 <ZfHTfNx4um8koTlY@p14s>
 <20240313171756.GA82165@e130802.arm.com>
 <ZfMPS+qn0lh5IrS7@p14s>
 <ZfMQyJWTh15P7Ru3@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfMQyJWTh15P7Ru3@bogus>

Hi Sudeep,

On Thu, Mar 14, 2024 at 02:59:20PM +0000, Sudeep Holla wrote:
> On Thu, Mar 14, 2024 at 08:52:59AM -0600, Mathieu Poirier wrote:
> > On Wed, Mar 13, 2024 at 05:17:56PM +0000, Abdellatif El Khlifi wrote:
> > > Hi Mathieu,
> > >
> > > On Wed, Mar 13, 2024 at 10:25:32AM -0600, Mathieu Poirier wrote:
> > > > On Tue, Mar 12, 2024 at 05:32:52PM +0000, Abdellatif El Khlifi wrote:
> > > > > Hi Mathieu,
> > > > >
> > > > > On Tue, Mar 12, 2024 at 10:29:52AM -0600, Mathieu Poirier wrote:
> > > > > > > This is an initial patchset for allowing to turn on and off the remote processor.
> > > > > > > The FW is already loaded before the Corstone-1000 SoC is powered on and this
> > > > > > > is done through the FPGA board bootloader in case of the FPGA target. Or by the Corstone-1000 FVP model
> > > > > > > (emulator).
> > > > > > >
> > > > > > >From the above I take it that booting with a preloaded firmware is a
> > > > > > scenario that needs to be supported and not just a temporary stage.
> > > > >
> > > > > The current status of the Corstone-1000 SoC requires that there is
> > > > > a preloaded firmware for the external core. Preloading is done externally
> > > > > either through the FPGA bootloader or the emulator (FVP) before powering
> > > > > on the SoC.
> > > > >
> > > >
> > > > Ok
> > > >
> > > > > Corstone-1000 will be upgraded in a way that the A core running Linux is able
> > > > > to share memory with the remote core and also being able to access the remote
> > > > > core memory so Linux can copy the firmware to. This HW changes are still
> > > > > This is why this patchset is relying on a preloaded firmware. And it's the step 1
> > > > > of adding remoteproc support for Corstone.
> > > > >
> > > >
> > > > Ok, so there is a HW problem where A core and M core can't see each other's
> > > > memory, preventing the A core from copying the firmware image to the proper
> > > > location.
> > > >
> > > > When the HW is fixed, will there be a need to support scenarios where the
> > > > firmware image has been preloaded into memory?
> > >
> > > No, this scenario won't apply when we get the HW upgrade. No need for an
> > > external entity anymore. The firmware(s) will all be files in the linux filesystem.
> > >
> >
> > Very well.  I am willing to continue with this driver but it does so little that
> > I wonder if it wouldn't simply be better to move forward with upstreaming when
> > the HW is fixed.  The choice is yours.
> >
> 
> I think Robin has raised few points that need clarification. I think it was
> done as part of DT binding patch. I share those concerns and I wanted to
> reaching to the same concerns by starting the questions I asked on corstone
> device tree changes.

Please have a look at my answer to Robin with clarifications [1].

Apart from mapping the register area rather than using the reg property
I'll also add the mboxes property as Krzysztof confirmed.

[1]: https://lore.kernel.org/all/20240314134928.GA27077@e130802.arm.com/

Cheers,
Abdellatif

