Return-Path: <linux-kernel+bounces-100600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B576A879AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78061C223C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132F1386B1;
	Tue, 12 Mar 2024 17:33:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37CD58107;
	Tue, 12 Mar 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264787; cv=none; b=D3qGVq8nq7GvklWbUm/PGxIj1yvL8YlIqa5WJt2OQTyDtUvzIfL20wh9hJoPeE16rPZPIwanAdd/Qq4y2tfvG5e1czwQDczrbU0cWVMUZsEL95m5OCX5wyjyGuMS6xbpito8EDK/E7D3XbeMFiOe/dncatQkw0dnA1Zp8Dj2R9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264787; c=relaxed/simple;
	bh=VJ3HqrqttX/0M9yf/X7FSjZfpQPVNSvOUw9eDyk/GnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/tnQ0YDIJ0IR5vReS14NjUJzuFwNl75LzSGQlC42/zmRWzfjGPdkwsQkBlY290h2UECWC5XAUE8KNdFL6+5Bhjd/VgSi8cgYxh5F5h92hp7lvu3FaSBbWJNMTsTGi5i5NQoy7tlMBhUws7+VLYuvO7xDoipwclWSZZe0F2Kepo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D74D61007;
	Tue, 12 Mar 2024 10:33:40 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.38.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 993F83F762;
	Tue, 12 Mar 2024 10:33:00 -0700 (PDT)
Date: Tue, 12 Mar 2024 17:32:52 +0000
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
Message-ID: <20240312173252.GA38992@e130802.arm.com>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-2-abdellatif.elkhlifi@arm.com>
 <ZeYWKVpeFm1+4mlT@p14s>
 <20240307194026.GA355455@e130802.arm.com>
 <CANLsYkzA20rQdTM6AOvFK=3o28GvcoRbckL=ri8RegHqyHaiCw@mail.gmail.com>
 <20240311114442.GA82865@e130802.arm.com>
 <CANLsYkwReJvB1UWvR5TwtSs-w_VqU45kDSUzuQ0k+waetEn6Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwReJvB1UWvR5TwtSs-w_VqU45kDSUzuQ0k+waetEn6Yw@mail.gmail.com>

Hi Mathieu,

On Tue, Mar 12, 2024 at 10:29:52AM -0600, Mathieu Poirier wrote:
> > This is an initial patchset for allowing to turn on and off the remote processor.
> > The FW is already loaded before the Corstone-1000 SoC is powered on and this
> > is done through the FPGA board bootloader in case of the FPGA target. Or by the Corstone-1000 FVP model
> > (emulator).
> >
> >From the above I take it that booting with a preloaded firmware is a
> scenario that needs to be supported and not just a temporary stage.

The current status of the Corstone-1000 SoC requires that there is
a preloaded firmware for the external core. Preloading is done externally
either through the FPGA bootloader or the emulator (FVP) before powering
on the SoC.

Corstone-1000 will be upgraded in a way that the A core running Linux is able
to share memory with the remote core and also being able to access the remote
core memory so Linux can copy the firmware to. This HW changes are still
under development.

This is why this patchset is relying on a preloaded firmware. And it's the step 1
of adding remoteproc support for Corstone.

When the HW is ready, we will be able to avoid preloading the firmware
and the user can do the following:

1) Use a default firmware filename stated in the DT (firmware-name property),
that's the one remoteproc subsystem will use initially, load the firmware file
and start the remote core.

2) Then, the user can choose to use another firmware file:

    echo stop >/sys/class/remoteproc/remoteproc0/state
    echo -n new_firmware.elf > /sys/class/remoteproc/remoteproc0/firmware
    echo start >/sys/class/remoteproc/remoteproc0/state

> > The plan for the driver is as follows:
> >
> > Step 1: provide a foundation driver capable of turning the core on/off
> >
> > Step 2: provide mailbox support for comms
> >
> > Step 3: provide FW reload capability
> >
> What happens when a user wants to boot the remote processor with the
> firmware provided on the file system rather than the one preloaded
> into memory?

We will support this scenario when the HW is upgraded and copying the firmware
to the remote core memory becomes possible.

> Furthermore, how do we account for scenarios where the
> remote processor goes from running a firmware image on the file system
> to the firmware image loaded by an external entity?  Is this a valid
> scenario?

No, this scenario won't apply when we get the HW upgrade. No need for an
external entity anymore. The firmware(s) will all be files in the linux filesystem.

> > Steps 2 & 3 are waiting for a HW update so the Cortex-A35 (running Linux) can share memory with
> > the remote core.
> >
> > I'm happy to provide more explanation in the commit log to reflect this status.
> >
> > Is it OK that we go with step 1 as a foundation please ?
> >
> 
> First let's clarify all the scenarios that need to be supported.  From
> there I will advise on how to proceed and what modifications to the
> subsystem's core should be made, if need be.

Thanks, I hope the answers above provide the information needed.

Cheers
Abdellatif

