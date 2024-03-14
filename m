Return-Path: <linux-kernel+bounces-103442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD11B87BF68
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986B9284B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53697173E;
	Thu, 14 Mar 2024 14:59:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3361D6EB6E;
	Thu, 14 Mar 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428368; cv=none; b=cGxAAM6WH4YgVEJgKAQRULgsJHAMO4N+zOP4DIz7+Ff61AEUVt1kh7j6K2LEi9fivhOTt9ah86OxCYj2Lz22Yjt+nCK/WzEz2d6rPDt4ZM1BIadxgUMWDCInSqvukyG34sLfv505BR62bjb3LyBN0lBfiqQiGKPCA1Zb2ikZMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428368; c=relaxed/simple;
	bh=XJdEeratGaF+uMHUKGSH/y0MHkuF8kvwtElHPYuGgKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac7InEbMYW/htteohwufrtaqnn6rSC9Q7S3xth3pzXjbsE1xwJRa21PjDtNCl4+jCc+349O7W+M8yROsF4XMHCLm3IVYd5878xMAtPVb7U3z55N+nEoYb4NVyFHTx5lhKctKXP4+t2YtOWPfhUjTg1pSMrc+9rm71999I+2R7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 535281007;
	Thu, 14 Mar 2024 08:00:01 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 147DD3F762;
	Thu, 14 Mar 2024 07:59:22 -0700 (PDT)
Date: Thu, 14 Mar 2024 14:59:20 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: Add Arm remoteproc driver
Message-ID: <ZfMQyJWTh15P7Ru3@bogus>
References: <20240301164227.339208-2-abdellatif.elkhlifi@arm.com>
 <ZeYWKVpeFm1+4mlT@p14s>
 <20240307194026.GA355455@e130802.arm.com>
 <CANLsYkzA20rQdTM6AOvFK=3o28GvcoRbckL=ri8RegHqyHaiCw@mail.gmail.com>
 <20240311114442.GA82865@e130802.arm.com>
 <CANLsYkwReJvB1UWvR5TwtSs-w_VqU45kDSUzuQ0k+waetEn6Yw@mail.gmail.com>
 <20240312173252.GA38992@e130802.arm.com>
 <ZfHTfNx4um8koTlY@p14s>
 <20240313171756.GA82165@e130802.arm.com>
 <ZfMPS+qn0lh5IrS7@p14s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfMPS+qn0lh5IrS7@p14s>

On Thu, Mar 14, 2024 at 08:52:59AM -0600, Mathieu Poirier wrote:
> On Wed, Mar 13, 2024 at 05:17:56PM +0000, Abdellatif El Khlifi wrote:
> > Hi Mathieu,
> >
> > On Wed, Mar 13, 2024 at 10:25:32AM -0600, Mathieu Poirier wrote:
> > > On Tue, Mar 12, 2024 at 05:32:52PM +0000, Abdellatif El Khlifi wrote:
> > > > Hi Mathieu,
> > > >
> > > > On Tue, Mar 12, 2024 at 10:29:52AM -0600, Mathieu Poirier wrote:
> > > > > > This is an initial patchset for allowing to turn on and off the remote processor.
> > > > > > The FW is already loaded before the Corstone-1000 SoC is powered on and this
> > > > > > is done through the FPGA board bootloader in case of the FPGA target. Or by the Corstone-1000 FVP model
> > > > > > (emulator).
> > > > > >
> > > > > >From the above I take it that booting with a preloaded firmware is a
> > > > > scenario that needs to be supported and not just a temporary stage.
> > > >
> > > > The current status of the Corstone-1000 SoC requires that there is
> > > > a preloaded firmware for the external core. Preloading is done externally
> > > > either through the FPGA bootloader or the emulator (FVP) before powering
> > > > on the SoC.
> > > >
> > >
> > > Ok
> > >
> > > > Corstone-1000 will be upgraded in a way that the A core running Linux is able
> > > > to share memory with the remote core and also being able to access the remote
> > > > core memory so Linux can copy the firmware to. This HW changes are still
> > > > This is why this patchset is relying on a preloaded firmware. And it's the step 1
> > > > of adding remoteproc support for Corstone.
> > > >
> > >
> > > Ok, so there is a HW problem where A core and M core can't see each other's
> > > memory, preventing the A core from copying the firmware image to the proper
> > > location.
> > >
> > > When the HW is fixed, will there be a need to support scenarios where the
> > > firmware image has been preloaded into memory?
> >
> > No, this scenario won't apply when we get the HW upgrade. No need for an
> > external entity anymore. The firmware(s) will all be files in the linux filesystem.
> >
>
> Very well.  I am willing to continue with this driver but it does so little that
> I wonder if it wouldn't simply be better to move forward with upstreaming when
> the HW is fixed.  The choice is yours.
>

I think Robin has raised few points that need clarification. I think it was
done as part of DT binding patch. I share those concerns and I wanted to
reaching to the same concerns by starting the questions I asked on corstone
device tree changes.

--
Regards,
Sudeep

