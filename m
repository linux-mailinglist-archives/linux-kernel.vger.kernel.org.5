Return-Path: <linux-kernel+bounces-117555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F07B88AC91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896B7307B28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6D713D2BD;
	Mon, 25 Mar 2024 17:13:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1D313D2A4;
	Mon, 25 Mar 2024 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386831; cv=none; b=pO8sG1Vh3wl2xwnHiNWfsAcp0io8A7cUllv0jYQA6nT/q0N1Ei/VQXe8d9KrF0qjVt4+P9mNNL25Um5AP4nVM+n/PQAumm9d2if5c/M6/wnv0p7Ih/5VqvlY6apkN9TqmtOlZqK6c9iFViAVJ1erE5DZKDzzzBywSN06xJPS4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386831; c=relaxed/simple;
	bh=oW8CC3CJ4tqn9O1ZLXf4iHX4u7TtfCImQpy+iup+WZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg1FhJCXkUzTrpgMFO/DWAf2spYS8lTUqlXsKWHYXmlXZWiQbJvpNNfO3y4nSzl11d0qvv1Bxdh+7zEAZDAudnUF51HlfZR4d0o4NBi7jzjgbQroZ6gtyLlVUKDe8XSXqjggXfXptWDwjmjI1E/4QEEJKiQZgpoRpLhMM/zv9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 833E92F4;
	Mon, 25 Mar 2024 10:14:21 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.72.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E16353F64C;
	Mon, 25 Mar 2024 10:13:44 -0700 (PDT)
Date: Mon, 25 Mar 2024 17:13:39 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: Add Arm remoteproc driver
Message-ID: <20240325171339.GA368569@e130802.arm.com>
References: <20240307194026.GA355455@e130802.arm.com>
 <CANLsYkzA20rQdTM6AOvFK=3o28GvcoRbckL=ri8RegHqyHaiCw@mail.gmail.com>
 <20240311114442.GA82865@e130802.arm.com>
 <CANLsYkwReJvB1UWvR5TwtSs-w_VqU45kDSUzuQ0k+waetEn6Yw@mail.gmail.com>
 <20240312173252.GA38992@e130802.arm.com>
 <ZfHTfNx4um8koTlY@p14s>
 <20240313171756.GA82165@e130802.arm.com>
 <ZfMPS+qn0lh5IrS7@p14s>
 <ZfMQyJWTh15P7Ru3@bogus>
 <CANLsYkzdfP8Np-XwPDt=GBNLYiSypd8tNdb29KUwr+tyi7gJEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkzdfP8Np-XwPDt=GBNLYiSypd8tNdb29KUwr+tyi7gJEA@mail.gmail.com>

Hi Mathieu,

> > > > > > > > This is an initial patchset for allowing to turn on and off the remote processor.
> > > > > > > > The FW is already loaded before the Corstone-1000 SoC is powered on and this
> > > > > > > > is done through the FPGA board bootloader in case of the FPGA target. Or by the Corstone-1000 FVP model
> > > > > > > > (emulator).
> > > > > > > >
> > > > > > > >From the above I take it that booting with a preloaded firmware is a
> > > > > > > scenario that needs to be supported and not just a temporary stage.
> > > > > >
> > > > > > The current status of the Corstone-1000 SoC requires that there is
> > > > > > a preloaded firmware for the external core. Preloading is done externally
> > > > > > either through the FPGA bootloader or the emulator (FVP) before powering
> > > > > > on the SoC.
> > > > > >
> > > > >
> > > > > Ok
> > > > >
> > > > > > Corstone-1000 will be upgraded in a way that the A core running Linux is able
> > > > > > to share memory with the remote core and also being able to access the remote
> > > > > > core memory so Linux can copy the firmware to. This HW changes are still
> > > > > > This is why this patchset is relying on a preloaded firmware. And it's the step 1
> > > > > > of adding remoteproc support for Corstone.
> > > > > >
> > > > >
> > > > > Ok, so there is a HW problem where A core and M core can't see each other's
> > > > > memory, preventing the A core from copying the firmware image to the proper
> > > > > location.
> > > > >
> > > > > When the HW is fixed, will there be a need to support scenarios where the
> > > > > firmware image has been preloaded into memory?
> > > >
> > > > No, this scenario won't apply when we get the HW upgrade. No need for an
> > > > external entity anymore. The firmware(s) will all be files in the linux filesystem.
> > > >
> > >
> > > Very well.  I am willing to continue with this driver but it does so little that
> > > I wonder if it wouldn't simply be better to move forward with upstreaming when
> > > the HW is fixed.  The choice is yours.
> > >
> >
> > I think Robin has raised few points that need clarification. I think it was
> > done as part of DT binding patch. I share those concerns and I wanted to
> > reaching to the same concerns by starting the questions I asked on corstone
> > device tree changes.
> >
> 
> I also agree with Robin's point of view.  Proceeding with an initial
> driver with minimal functionality doesn't preclude having complete
> bindings.  But that said and as I pointed out, it might be better to
> wait for the HW to be fixed before moving forward.

We checked with the HW teams. The missing features will be implemented but
this will take time.

The foundation driver as it is right now is still valuable for people wanting to
know how to power control Corstone external systems in a future proof manner
(even in the incomplete state). We prefer to address all the review comments
made so it can be merged. This includes making the DT binding as complete as
possible as you advised. Then, once the HW is ready, I'll implement the comms
and the FW reload part. Is that OK please ?

Cheers,
Abdellatif

