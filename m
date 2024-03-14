Return-Path: <linux-kernel+bounces-103470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EC087BFBF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B60C1C2286B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1245071B2F;
	Thu, 14 Mar 2024 15:19:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EDB7175D;
	Thu, 14 Mar 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429560; cv=none; b=fB/FyDn9bO1diD88l4QyGqC39Pos5ihjCDWJYeH/+wrT/SambGUZy4tjzaNFBZKRe9fAJzMFoY1QPRIBC/fNHqGZPmJ7KhxPILE7BRq5yRL2JnNS/CxSCYBNDwaUvod6c+N+ejgXx+j4bsmz0sN05GOTsXkeyfw9Vs7WZ+YIeQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429560; c=relaxed/simple;
	bh=w9FNIjfJRDN7Q4w1L8jaoFaPitp10XRj8P+F4loSqY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFsq9V0a279k/esrrY+SdCdUj+YIxLMHrlm1svoOO3MUQf2oGmluWiZF1i+lNagdnlgClHmpumQq0keZEnmGcxvZvdLaNbLz7qYW+v5aw6ACBaVzFvd9PY/HJIhcwX76fFWLPe1+IrKVy5xSiiQWGBy4sq6qzHVp7RPpF63287E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FC101007;
	Thu, 14 Mar 2024 08:19:54 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C882A3F762;
	Thu, 14 Mar 2024 08:19:15 -0700 (PDT)
Date: Thu, 14 Mar 2024 15:19:13 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: remoteproc: Add Arm remoteproc
Message-ID: <ZfMVcQsmgQUXXcef@bogus>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-4-abdellatif.elkhlifi@arm.com>
 <8c784016-9257-4d8a-b956-a0a406746c76@arm.com>
 <20240314134928.GA27077@e130802.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314134928.GA27077@e130802.arm.com>

On Thu, Mar 14, 2024 at 01:49:28PM +0000, Abdellatif El Khlifi wrote:
> Hi Robin,
> 
> > > +  firmware-name:
> > > +    description: |
> > > +      Default name of the firmware to load to the remote processor.
> > 
> > So... is loading the firmware image achieved by somehow bitbanging it
> > through the one reset register, maybe? I find it hard to believe this is a
> > complete and functional binding.
> > 
> > Frankly at the moment I'd be inclined to say it isn't even a remoteproc
> > binding (or driver) at all, it's a reset controller. Bindings are a contract
> > for describing the hardware, not the current state of Linux driver support -
> > if this thing still needs mailboxes, shared memory, a reset vector register,
> > or whatever else to actually be useful, those should be in the binding from
> > day 1 so that a) people can write and deploy correct DTs now, such that
> > functionality becomes available on their systems as soon as driver support
> > catches up, and b) the community has any hope of being able to review
> > whether the binding is appropriately designed and specified for the purpose
> > it intends to serve.
> 
> This is an initial patchset for allowing to turn on and off the remote processor.
> The FW is already loaded before the Corstone-1000 SoC is powered on and this
> is done through the FPGA board bootloader in case of the FPGA target.
> Or by the Corstone-1000 FVP model (emulator).
>

If this driver does the loading of the firmware, it will get reloaded. Do
you need any issues there ? The correctness matters here in the upstream
driver, it may not be optimised for you usecase now, but that is fine IMO.

> The plan for the driver is as follows:
>
>     Step 1: provide a foundation driver capable of turning the core on/off
>     Step 2: provide mailbox support for comms
>     Step 3: provide FW reload capability
>
> Steps 2 & 3 are waiting for a HW update so the Cortex-A35 (running Linux) can
> share memory with the remote core.
>

Honestly, I would prefer to know the overall design before pushing any partial
solution. If you know the final complete solution, present the same with
the complete device tree binding for better understanding and review.

> So, when memory sharing becomes available in the FPGA and FVP the
> DT binding will be upgraded with:
>
>     - mboxes property specifying the RX/TX mailboxes (based on MHU v2)
>     - memory-region property describing the virtio vrings
>

Looks like you have the information now, please define the complete
bindings now.

> Currently the mailbox controller does exist in the HW but is not
> usable via virtio (no memory sharing available).
>

That is fine, if the plan is to use them, then include them in the design
of your DT bindings.

> Do you recommend I add the mboxes property even currently we can't do the comms ?
>

Yes for sure IMO.

> > For instance right now it seems somewhat tenuous to describe two consecutive
> > 32-bit registers as separate "reg" entries, but *maybe* it's OK if that's
> > all there ever is. However if it's actually going to end up needing several
> > more additional MMIO and/or memory regions for other functionality, then
> > describing each register and location individually is liable to get
> > unmanageable really fast, and a higher-level functional grouping (e.g. these
> > reset-related registers together as a single 8-byte region) would likely be
> > a better design.
>

I completely agree with the above and this is what I was meant(I must admit
didn't put it forward with above clarity).

> Currently the HW provides only 2 registers to control the remote processors:
>
> The reset control and status registers.
>

Agreed, but it is part of a bigger block with other functionality in place.
MFD/syscon might be better way to use these registers. You never know in
future you might want to use another set of 2-4 registers with a different
functionality in another driver.

> It makes sense to me to use a mapped region of 8 bytes for both registers rather
> than individual registers (since they are consecutive).

Not exactly. Are you sure, Linux will not have to use another other registers
in that block ? Will you keep creating such (random if I may call it so)
bindings for a smaller sets of register under "Host Base System Control
registers".

I would see if it makes sense to put together a single binding for
this "Host Base System Control" register(not sure what exactly that means).
Use MFD/regmap you access parts of this block. The remoteproc driver can
then be semi-generic(meaning applicable to group of similar platforms)
based on the platform compatible and use this regmap to provide the
functionality needed.

-- 
Regards,
Sudeep

