Return-Path: <linux-kernel+bounces-103471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D6487BFC2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6EB71C227F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECE671B30;
	Thu, 14 Mar 2024 15:20:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA17C7175A;
	Thu, 14 Mar 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429632; cv=none; b=bLugoA9rpjJPHNpUvoaDV3nfO8IhLYhuM5QD2Aff86Rj2SPy43K8a20jUKFBVvMRMlJWGRjeeQA7Wl6RYQ+eRtFUxZMUrGGYClx3WU/5hyNssqJoKMbeHl6NnkMme1QFGYDM5ifEDGOL/h3OrD3hv8M0TQc604tz8wNA5R2khBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429632; c=relaxed/simple;
	bh=dcb/gsF85aoiYODQ+GAmVe2LLHQNrA+u7u1lvW9BxAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnGdypv3L/TmI/c/oPGNzxdCWw6gFvmviFUhMbXSEQsO+HNlyD/FV2Ol1Y5sstbHoPDJvrJmYLvsbnVnGCdIdTpl93F2VUK5LiYeAKwOSGnT/J1duwhQ6BhDQAq3ZkA55xgyvJlCJ9HXHZwCSmzEQA9QYxHIQzpCXJp5To34GdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43CEF1007;
	Thu, 14 Mar 2024 08:21:06 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.33.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE0AE3F762;
	Thu, 14 Mar 2024 08:20:26 -0700 (PDT)
Date: Thu, 14 Mar 2024 15:20:18 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: remoteproc: Add Arm remoteproc
Message-ID: <20240314152018.GA41711@e130802.arm.com>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-4-abdellatif.elkhlifi@arm.com>
 <8c784016-9257-4d8a-b956-a0a406746c76@arm.com>
 <20240314134928.GA27077@e130802.arm.com>
 <d3b7fd09-76ef-42b3-aaf9-de0369a28e03@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3b7fd09-76ef-42b3-aaf9-de0369a28e03@linaro.org>

Hi Krzysztof,

On Thu, Mar 14, 2024 at 02:56:53PM +0100, Krzysztof Kozlowski wrote:
> On 14/03/2024 14:49, Abdellatif El Khlifi wrote:
> >> Frankly at the moment I'd be inclined to say it isn't even a remoteproc
> >> binding (or driver) at all, it's a reset controller. Bindings are a contract
> >> for describing the hardware, not the current state of Linux driver support -
> >> if this thing still needs mailboxes, shared memory, a reset vector register,
> >> or whatever else to actually be useful, those should be in the binding from
> >> day 1 so that a) people can write and deploy correct DTs now, such that
> >> functionality becomes available on their systems as soon as driver support
> >> catches up, and b) the community has any hope of being able to review
> >> whether the binding is appropriately designed and specified for the purpose
> >> it intends to serve.
> > 
> > This is an initial patchset for allowing to turn on and off the remote processor.
> > The FW is already loaded before the Corstone-1000 SoC is powered on and this
> > is done through the FPGA board bootloader in case of the FPGA target.
> > Or by the Corstone-1000 FVP model (emulator).
> > 
> > The plan for the driver is as follows:
> > 
> >     Step 1: provide a foundation driver capable of turning the core on/off
> >     Step 2: provide mailbox support for comms
> >     Step 3: provide FW reload capability
> > 
> > Steps 2 & 3 are waiting for a HW update so the Cortex-A35 (running Linux) can
> > share memory with the remote core.
> > 
> > So, when memory sharing becomes available in the FPGA and FVP the
> > DT binding will be upgraded with:
> > 
> >     - mboxes property specifying the RX/TX mailboxes (based on MHU v2)
> >     - memory-region property describing the virtio vrings
> > 
> > Currently the mailbox controller does exist in the HW but is not
> > usable via virtio (no memory sharing available).
> > 
> > Do you recommend I add the mboxes property even currently we can't do the comms ?
> 
> Bindings should be complete, regardless whether Linux driver supports it
> or not. Please see writing bindings document for explanation on this and
> other rules.
> 
> So yes: please describe as much as possible/reasonable.

I'll do thanks.

Cheers,
Abdellatif

