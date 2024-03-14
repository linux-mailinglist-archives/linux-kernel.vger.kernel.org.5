Return-Path: <linux-kernel+bounces-103319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A181887BDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7CE1F21859
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4862E6EB73;
	Thu, 14 Mar 2024 13:49:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1F35C60D;
	Thu, 14 Mar 2024 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424184; cv=none; b=KVhW+EnfKUSBJ9BVC+q4fr2o/WqMehMwZyIqDKDx+j1QvHlhYWqGk2x3Jviu/LOgSFe38VLpWKx+3wCU5RHegikAM1QAa+iUTpVkbbgigsf8VTk+NWTjVt/HnlYm/4+Zw6PC+3bmLHCD/h+8svlK/yX9pn+vi801sfxQh684ysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424184; c=relaxed/simple;
	bh=vD/laLUeo+efvDaFZnIPLmLPykBufdsDOZt3RL78OXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaUoO6bvL2mpBeQ/fD2njnH+PXH3yuDgyauMKN4BnfxC72i8xDpe2f0eEHF1/FYAbLmtLNXgKI0dx1msbc28EL3LcozEgSnkXCxCVz5oVxGD+zV77tztki2b2TKHazI5DxBFv0mKXtm5xPdwOUQ4G1shjAmWNczOOgz4mhwH3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8FFD1007;
	Thu, 14 Mar 2024 06:50:17 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.33.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB2483F762;
	Thu, 14 Mar 2024 06:49:37 -0700 (PDT)
Date: Thu, 14 Mar 2024 13:49:28 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <20240314134928.GA27077@e130802.arm.com>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-4-abdellatif.elkhlifi@arm.com>
 <8c784016-9257-4d8a-b956-a0a406746c76@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c784016-9257-4d8a-b956-a0a406746c76@arm.com>

Hi Robin,

> > +  firmware-name:
> > +    description: |
> > +      Default name of the firmware to load to the remote processor.
> 
> So... is loading the firmware image achieved by somehow bitbanging it
> through the one reset register, maybe? I find it hard to believe this is a
> complete and functional binding.
> 
> Frankly at the moment I'd be inclined to say it isn't even a remoteproc
> binding (or driver) at all, it's a reset controller. Bindings are a contract
> for describing the hardware, not the current state of Linux driver support -
> if this thing still needs mailboxes, shared memory, a reset vector register,
> or whatever else to actually be useful, those should be in the binding from
> day 1 so that a) people can write and deploy correct DTs now, such that
> functionality becomes available on their systems as soon as driver support
> catches up, and b) the community has any hope of being able to review
> whether the binding is appropriately designed and specified for the purpose
> it intends to serve.

This is an initial patchset for allowing to turn on and off the remote processor.
The FW is already loaded before the Corstone-1000 SoC is powered on and this
is done through the FPGA board bootloader in case of the FPGA target.
Or by the Corstone-1000 FVP model (emulator).

The plan for the driver is as follows:

    Step 1: provide a foundation driver capable of turning the core on/off
    Step 2: provide mailbox support for comms
    Step 3: provide FW reload capability

Steps 2 & 3 are waiting for a HW update so the Cortex-A35 (running Linux) can
share memory with the remote core.

So, when memory sharing becomes available in the FPGA and FVP the
DT binding will be upgraded with:

    - mboxes property specifying the RX/TX mailboxes (based on MHU v2)
    - memory-region property describing the virtio vrings

Currently the mailbox controller does exist in the HW but is not
usable via virtio (no memory sharing available).

Do you recommend I add the mboxes property even currently we can't do the comms ?

> For instance right now it seems somewhat tenuous to describe two consecutive
> 32-bit registers as separate "reg" entries, but *maybe* it's OK if that's
> all there ever is. However if it's actually going to end up needing several
> more additional MMIO and/or memory regions for other functionality, then
> describing each register and location individually is liable to get
> unmanageable really fast, and a higher-level functional grouping (e.g. these
> reset-related registers together as a single 8-byte region) would likely be
> a better design.

Currently the HW provides only 2 registers to control the remote processors:

The reset control and status registers.

It makes sense to me to use a mapped region of 8 bytes for both registers rather
than individual registers (since they are consecutive).
I'll update that, thanks for the suggestion.

Abdellatif,
Cheers

