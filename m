Return-Path: <linux-kernel+bounces-104488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B969487CEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA39B21C12
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68555376F2;
	Fri, 15 Mar 2024 14:22:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A22A1A38DA;
	Fri, 15 Mar 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512558; cv=none; b=YiSkLHLjPHgcgtViil62YhlSk2OSVEP7g7Wp07RQcO1wKyPN0W2Y6jmK5LtR3RYPnW9brg/H75no8b8i6wSdRRXsX56apnfX495yjrdcl6hH0I47JhFlkdciKFv22i4mgVi31GnKeO5WGYAwFkLWP5MdYbrFqneTLoPJmyUbBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512558; c=relaxed/simple;
	bh=toIEnnzYNiwyWD6Gb0TYT5sbPnu9iUMI7CYXzC9b3+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7382VyWhULKTok1qlpCDmBwj1q+oaYhHJfyWYhGZmJIQD9ktv/redgps4drYgyGI0dSbCaJLXRhrpsk2D1Ro+Q8M+b7aNyYRyBDixIbmb/q0s/BDppsTmGhmXzc1U4MW4XoJyeN19WtQsXK3FOTq727+oWUkZ58H/irYTzghzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1B81C15;
	Fri, 15 Mar 2024 07:23:09 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.34.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03D5D3F73F;
	Fri, 15 Mar 2024 07:22:30 -0700 (PDT)
Date: Fri, 15 Mar 2024 14:22:22 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
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
Message-ID: <20240315142222.GA38748@e130802.arm.com>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-4-abdellatif.elkhlifi@arm.com>
 <8c784016-9257-4d8a-b956-a0a406746c76@arm.com>
 <20240314134928.GA27077@e130802.arm.com>
 <ZfMVcQsmgQUXXcef@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfMVcQsmgQUXXcef@bogus>

Hi Sudeep,

On Thu, Mar 14, 2024 at 03:19:13PM +0000, Sudeep Holla wrote:
> > The plan for the driver is as follows:
> >
> >     Step 1: provide a foundation driver capable of turning the core on/off
> >     Step 2: provide mailbox support for comms
> >     Step 3: provide FW reload capability
> >
> > Steps 2 & 3 are waiting for a HW update so the Cortex-A35 (running Linux) can
> > share memory with the remote core.
> >
> 
> Honestly, I would prefer to know the overall design before pushing any partial
> solution. If you know the final complete solution, present the same with
> the complete device tree binding for better understanding and review.

Sounds good to me. I'll make the binding as complete as possible.

> Agreed, but it is part of a bigger block with other functionality in place.
> MFD/syscon might be better way to use these registers. You never know in
> future you might want to use another set of 2-4 registers with a different
> functionality in another driver.
> 
> > It makes sense to me to use a mapped region of 8 bytes for both registers rather
> > than individual registers (since they are consecutive).
> 
> Not exactly. Are you sure, Linux will not have to use another other registers
> in that block ? Will you keep creating such (random if I may call it so)
> bindings for a smaller sets of register under "Host Base System Control
> registers".
> 
> I would see if it makes sense to put together a single binding for
> this "Host Base System Control" register(not sure what exactly that means).
> Use MFD/regmap you access parts of this block. The remoteproc driver can
> then be semi-generic(meaning applicable to group of similar platforms)
> based on the platform compatible and use this regmap to provide the
> functionality needed.

I like the idea of using syscon/regmap to represent the "Host Base System Control registers"
area. Thank you for suggesting that.

I think syscon is the way to go (rather than MFD). With syscon we can use
the generic syscon driver that converts a set of MMIO registers to a regmap,
allowing it to be accessed from multiple device drivers.
In our case these MMIO registers will be the "Host Base System Control registers".

remoteproc will be a child node under sysctrl node.

Cheers,
Abdellatif

