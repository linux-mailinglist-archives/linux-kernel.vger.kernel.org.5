Return-Path: <linux-kernel+bounces-102250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C46E87AFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03CD3B25B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102B67F7EF;
	Wed, 13 Mar 2024 17:18:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61CB6214A;
	Wed, 13 Mar 2024 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350291; cv=none; b=QQKpstsG6/s6k2e28Otoqm0XBFOV0FUVoAWimg7aP2yeI/425wuZrj02ctXsTlyw+7tYrS67KpRzcleO5HgFQudV+Ub9KCqJAW75CoBXOTBhFC4PSnbUZSGVy9J40MFQ+/MdELHR3KGaFMJxzkYc+0XuPSZ0/FML9sB8o0BLhl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350291; c=relaxed/simple;
	bh=zl6GKPcZg55Qgo0Jw2HJS2kTGuEm21jcqfYQXWm9yxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lM4MEYWMbKrMYCKwFgaVk4ntwxNidKJqPixmUKAk/7tTjOAfVeSm0KSoLW3ry2TjPr5rHOKT7fsJU/b4/sIVvZfgJLInPnkIHkm+39QMMRsFLoTuUVeUYTj6cN650S39ZzKXaiO25arPGwxJ8nq0hcZz9ZO+pM4Yqgsd+0uldw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A78411007;
	Wed, 13 Mar 2024 10:18:45 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.32.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B79A03F73F;
	Wed, 13 Mar 2024 10:18:05 -0700 (PDT)
Date: Wed, 13 Mar 2024 17:17:56 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: Add Arm remoteproc driver
Message-ID: <20240313171756.GA82165@e130802.arm.com>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-2-abdellatif.elkhlifi@arm.com>
 <ZeYWKVpeFm1+4mlT@p14s>
 <20240307194026.GA355455@e130802.arm.com>
 <CANLsYkzA20rQdTM6AOvFK=3o28GvcoRbckL=ri8RegHqyHaiCw@mail.gmail.com>
 <20240311114442.GA82865@e130802.arm.com>
 <CANLsYkwReJvB1UWvR5TwtSs-w_VqU45kDSUzuQ0k+waetEn6Yw@mail.gmail.com>
 <20240312173252.GA38992@e130802.arm.com>
 <ZfHTfNx4um8koTlY@p14s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfHTfNx4um8koTlY@p14s>

Hi Mathieu,

On Wed, Mar 13, 2024 at 10:25:32AM -0600, Mathieu Poirier wrote:
> On Tue, Mar 12, 2024 at 05:32:52PM +0000, Abdellatif El Khlifi wrote:
> > Hi Mathieu,
> > 
> > On Tue, Mar 12, 2024 at 10:29:52AM -0600, Mathieu Poirier wrote:
> > > > This is an initial patchset for allowing to turn on and off the remote processor.
> > > > The FW is already loaded before the Corstone-1000 SoC is powered on and this
> > > > is done through the FPGA board bootloader in case of the FPGA target. Or by the Corstone-1000 FVP model
> > > > (emulator).
> > > >
> > > >From the above I take it that booting with a preloaded firmware is a
> > > scenario that needs to be supported and not just a temporary stage.
> > 
> > The current status of the Corstone-1000 SoC requires that there is
> > a preloaded firmware for the external core. Preloading is done externally
> > either through the FPGA bootloader or the emulator (FVP) before powering
> > on the SoC.
> > 
> 
> Ok
> 
> > Corstone-1000 will be upgraded in a way that the A core running Linux is able
> > to share memory with the remote core and also being able to access the remote
> > core memory so Linux can copy the firmware to. This HW changes are still
> > This is why this patchset is relying on a preloaded firmware. And it's the step 1
> > of adding remoteproc support for Corstone.
> >
> 
> Ok, so there is a HW problem where A core and M core can't see each other's
> memory, preventing the A core from copying the firmware image to the proper
> location.
> 
> When the HW is fixed, will there be a need to support scenarios where the
> firmware image has been preloaded into memory?

No, this scenario won't apply when we get the HW upgrade. No need for an
external entity anymore. The firmware(s) will all be files in the linux filesystem.

Cheers
Abdellatif

