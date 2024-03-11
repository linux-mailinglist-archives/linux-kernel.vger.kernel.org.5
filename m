Return-Path: <linux-kernel+bounces-98776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39977877F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA174B217D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631443BBCF;
	Mon, 11 Mar 2024 11:44:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B2F3B78E;
	Mon, 11 Mar 2024 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157490; cv=none; b=tYRuGduxdOhOjKJvpXaF61aFpgOHpeB081hz+ePoA0zxxhanSXWOjWUZtmqD7cZPy4EcUEWD6MFgmJ/grqz0X/Wy1kqPfDtWJqKOqkK7I/PXDFma3b5Pnxj77FtC+cJjSCCCeombj4fP8VzQSuS45SBXzXsJFZMFg1T9lW/kvtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157490; c=relaxed/simple;
	bh=ScauDxIHPpzPMivn0k7nmNQRb13dHQ5538K1RuMQE+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ul+9LMWgFjaKHli813CeFiL/hAOPGa7e5o0V/Q9tcF/gOhRliDEhFrmXyeX3ZKrCtIFpHF8MROyxKdK7iZIWTJk4Aes2lRW4dB+K92PP3/J3aQt4TKB2NUW/7/dN8Z6cpFsDNz0iuE5DYqWPBZuzDucnL+fsb5svUUVyi6T5wSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C30691007;
	Mon, 11 Mar 2024 04:45:23 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.15.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D00DA3F64C;
	Mon, 11 Mar 2024 04:44:43 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:44:42 +0000
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
Message-ID: <20240311114442.GA82865@e130802.arm.com>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-2-abdellatif.elkhlifi@arm.com>
 <ZeYWKVpeFm1+4mlT@p14s>
 <20240307194026.GA355455@e130802.arm.com>
 <CANLsYkzA20rQdTM6AOvFK=3o28GvcoRbckL=ri8RegHqyHaiCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkzA20rQdTM6AOvFK=3o28GvcoRbckL=ri8RegHqyHaiCw@mail.gmail.com>

Hi Mathieu,

On Fri, Mar 08, 2024 at 09:44:26AM -0700, Mathieu Poirier wrote:
> On Thu, 7 Mar 2024 at 12:40, Abdellatif El Khlifi
> <abdellatif.elkhlifi@arm.com> wrote:
> >
> > Hi Mathieu,
> >
> > > > +   do {
> > > > +           state_reg = readl(priv->reset_cfg.state_reg);
> > > > +           *rst_ack = EXTSYS_RST_ST_RST_ACK(state_reg);
> > > > +
> > > > +           if (*rst_ack == EXTSYS_RST_ACK_RESERVED) {
> > > > +                   dev_err(dev, "unexpected RST_ACK value: 0x%x\n",
> > > > +                           *rst_ack);
> > > > +                   return -EINVAL;
> > > > +           }
> > > > +
> > > > +           /* expected ACK value read */
> > > > +           if ((*rst_ack & exp_ack) || (*rst_ack == exp_ack))
> > >
> > > I'm not sure why the second condition in this if() statement is needed.  As far
> > > as I can tell the first condition will trigger and the second one won't be
> > > reached.
> >
> > The second condition takes care of the following: exp_ack and  *rst_ack are both 0.
> > This case happens when RST_REQ bit is cleared (meaning: No reset requested) and
> > we expect the RST_ACK to be 00 afterwards.
> >
> 
> This is the kind of conditions that definitely deserve documentation.
> Please split the conditions in two different if() statements and add a
> comment to explain what is going on.

Thanks, I'll address that.

> 
> > > > +/**
> > > > + * arm_rproc_load() - Load firmware to memory function for rproc_ops
> > > > + * @rproc: pointer to the remote processor object
> > > > + * @fw: pointer to the firmware
> > > > + *
> > > > + * Does nothing currently.
> > > > + *
> > > > + * Return:
> > > > + *
> > > > + * 0 for success.
> > > > + */
> > > > +static int arm_rproc_load(struct rproc *rproc, const struct firmware *fw)
> > > > +{
> > >
> > > What is the point of doing rproc_of_parse_firmware() if the firmware image is
> > > not loaded to memory?  Does the remote processor have some kind of default ROM
> > > image to run if it doesn't find anything in memory?
> >
> > Yes, the remote processor has a default FW image already loaded by default.
> >
> 
> That too would have mandated a comment - otherwise people looking at
> the code are left wondering, as I did.
> 
> > rproc_boot() [1] and _request_firmware() [2] fail if there is no FW file in the filesystem or a filename
> > provided.
> >
> > Please correct me if I'm wrong.
> 
> You are correct, the remoteproc subsystem expects a firmware image to
> be provided _and_ loaded into memory.  Providing a dummy image just to
> get the remote processor booted is a hack, but simply because the
> subsystem isn't tailored to handle this use case.  So I am left
> wondering what the plans are for this driver, i.e is this a real
> scenario that needs to be addressed or just an initial patchset to get
> a foundation for the driver.
> 
> In the former case we need to start talking about refactoring the
> subsystem so that it properly handles remote processors that don't
> need a firmware image.  In the latter case I'd rather see a patchset
> where the firmware image is loaded into RAM.

This is an initial patchset for allowing to turn on and off the remote processor.
The FW is already loaded before the Corstone-1000 SoC is powered on and this
is done through the FPGA board bootloader in case of the FPGA target. Or by the Corstone-1000 FVP model
(emulator).

The plan for the driver is as follows:

Step 1: provide a foundation driver capable of turning the core on/off

Step 2: provide mailbox support for comms

Step 3: provide FW reload capability

Steps 2 & 3 are waiting for a HW update so the Cortex-A35 (running Linux) can share memory with
the remote core.

I'm happy to provide more explanation in the commit log to reflect this status.

Is it OK that we go with step 1 as a foundation please ?

Cheers
Abdellatif

