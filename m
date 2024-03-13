Return-Path: <linux-kernel+bounces-101725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0234187AB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E66A1F22D69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE42482DA;
	Wed, 13 Mar 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNyJy8xk"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8231F47F73
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347138; cv=none; b=PODZCr7faTi3eFxrSadC2bFhh5PrVTHE+9O6Oqlvd46msKBlciFWbSNOnK1N84O9k63zIJpqbFl30jaV1Pwxljbp4qZBZD9sPoiRYWnFxhE4quYVCh4UoYnEenMzgcUBzzGe708L2Ra1MZsGRr9w6KOJW9ArSsu31Hl8tqn9GIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347138; c=relaxed/simple;
	bh=fndGBeOY3SA23+9FmeX+5KQzzCNTLAKeBHKcSLCTo4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRwfxjX6hPc+ciwM8VXCeh1PlM01ZX3a6xpyscNP6uBXzyAww9G0aKv2WOMv88XowG7WDKy8ec5wyVDujpTDfHCby85+xb94YWzigi1rarCTT8O9QMLkrlnjlnE6nfYt5Xr9diIg0AKI8Z+Bbu+swLk9zfeMLr3U5efTPP8Atrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oNyJy8xk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6082eab17so68553b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710347136; x=1710951936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYxzXCVmzr66awhRoPiulHCLdn6odFpvWPqlxUZTg40=;
        b=oNyJy8xkxNu9iaHb8N5o9sOPBYyjboZbrGNCHC0UccH86YNw9OQkty9lL/j1ctUVes
         VU6urZpWLvCIGQOwUXNBVrJUtb+nsfhE2LJlGbgDybWmit/DShVra/R9bUp/FHf+NDE+
         2fkAqK/Eq+8FCLy3WpkEr3mSotyHzeF5u0aRgEADdNHfplIhaAJmxjc7Lz4oOj7Nnyv6
         83CHH44pEpEoRLvoy8iq3PamqFumUcqEN0uFmG0Axsc01wE4CqkXZbzhs85ZtzRaL0T6
         uTMdbgkUT6278P9Kl/5g+WrWaTlgpA3/KLaRBMHVleMByl4TnetBVinJ2V6ed48Jg8y4
         idCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710347136; x=1710951936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYxzXCVmzr66awhRoPiulHCLdn6odFpvWPqlxUZTg40=;
        b=B0Y7vBGJ6CaS6espuqDn44a4jfAvqz4Dt8s+/4DcWk85GbV9sQVY1aphu8rnK7e1Dn
         X+RsBzbNqfI+zGpg+y734MxmNSGYPScOeShN+0YS/A/8DOe71ujkPm1zpD3Ou0IaFfE5
         iPEFCRAvDhY+gXrztFKgU/DQ8BHuZ1nMNzQFGp0scCBGgdcgbeVAzTp6/RVz0tZyzrGm
         FUykbbZcxvZ0Eu/N6OLt1tLhIEKMiKJOmCt3E+1rDoHAcJ+QUhvRLvJFL1JBBGVhnq05
         IXb/HbdwtW5cTS/hnUhSiTF3YUDgRuY4d7kcpM5BD/y+bB4OmND1a6k8Yv3l/QJM4RmJ
         cvaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7f/OvCsu4VzmpYA1xUnoYfrnJkwomYLHdJSKrvsFrHRl9uPrKNsbyKkxSlkI/Y0rT95whgB6XcZXzrXQWD4kpsM7q5/eAJby1pUK3
X-Gm-Message-State: AOJu0YzwWTIlIfXjWdU6GecjrLLDvrPaYaTQit5sN2vDiEoSZfiBA1Hn
	IAB69LAki3Rcd7L2dBUdmjPJ0RHHucXmaeUxGcUstsHN42NmSpYBzbFtqmJQ7+A=
X-Google-Smtp-Source: AGHT+IGDDlbUcL/kmPgUIK2ocQ/+NVZ5EpvDYRvXae3NfxQmNd58fUdW3Xb6ch21rxY5N5eLOQx7sQ==
X-Received: by 2002:a05:6a20:3956:b0:1a3:2fe9:ad74 with SMTP id r22-20020a056a20395600b001a32fe9ad74mr3319252pzg.44.1710347135680;
        Wed, 13 Mar 2024 09:25:35 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:10b1:40f7:3529:d4f2])
        by smtp.gmail.com with ESMTPSA id cl12-20020a056a02098c00b005e438fe702dsm6934633pgb.65.2024.03.13.09.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 09:25:35 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:25:32 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
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
Message-ID: <ZfHTfNx4um8koTlY@p14s>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-2-abdellatif.elkhlifi@arm.com>
 <ZeYWKVpeFm1+4mlT@p14s>
 <20240307194026.GA355455@e130802.arm.com>
 <CANLsYkzA20rQdTM6AOvFK=3o28GvcoRbckL=ri8RegHqyHaiCw@mail.gmail.com>
 <20240311114442.GA82865@e130802.arm.com>
 <CANLsYkwReJvB1UWvR5TwtSs-w_VqU45kDSUzuQ0k+waetEn6Yw@mail.gmail.com>
 <20240312173252.GA38992@e130802.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312173252.GA38992@e130802.arm.com>

On Tue, Mar 12, 2024 at 05:32:52PM +0000, Abdellatif El Khlifi wrote:
> Hi Mathieu,
> 
> On Tue, Mar 12, 2024 at 10:29:52AM -0600, Mathieu Poirier wrote:
> > > This is an initial patchset for allowing to turn on and off the remote processor.
> > > The FW is already loaded before the Corstone-1000 SoC is powered on and this
> > > is done through the FPGA board bootloader in case of the FPGA target. Or by the Corstone-1000 FVP model
> > > (emulator).
> > >
> > >From the above I take it that booting with a preloaded firmware is a
> > scenario that needs to be supported and not just a temporary stage.
> 
> The current status of the Corstone-1000 SoC requires that there is
> a preloaded firmware for the external core. Preloading is done externally
> either through the FPGA bootloader or the emulator (FVP) before powering
> on the SoC.
> 

Ok

> Corstone-1000 will be upgraded in a way that the A core running Linux is able
> to share memory with the remote core and also being able to access the remote
> core memory so Linux can copy the firmware to. This HW changes are still
> This is why this patchset is relying on a preloaded firmware. And it's the step 1
> of adding remoteproc support for Corstone.
>

Ok, so there is a HW problem where A core and M core can't see each other's
memory, preventing the A core from copying the firmware image to the proper
location.

When the HW is fixed, will there be a need to support scenarios where the
firmware image has been preloaded into memory?

> When the HW is ready, we will be able to avoid preloading the firmware
> and the user can do the following:
> 
> 1) Use a default firmware filename stated in the DT (firmware-name property),
> that's the one remoteproc subsystem will use initially, load the firmware file
> and start the remote core.
> 
> 2) Then, the user can choose to use another firmware file:
> 
>     echo stop >/sys/class/remoteproc/remoteproc0/state
>     echo -n new_firmware.elf > /sys/class/remoteproc/remoteproc0/firmware
>     echo start >/sys/class/remoteproc/remoteproc0/state
> 
> > > The plan for the driver is as follows:
> > >
> > > Step 1: provide a foundation driver capable of turning the core on/off
> > >
> > > Step 2: provide mailbox support for comms
> > >
> > > Step 3: provide FW reload capability
> > >
> > What happens when a user wants to boot the remote processor with the
> > firmware provided on the file system rather than the one preloaded
> > into memory?
> 
> We will support this scenario when the HW is upgraded and copying the firmware
> to the remote core memory becomes possible.
> 
> > Furthermore, how do we account for scenarios where the
> > remote processor goes from running a firmware image on the file system
> > to the firmware image loaded by an external entity?  Is this a valid
> > scenario?
> 
> No, this scenario won't apply when we get the HW upgrade. No need for an
> external entity anymore. The firmware(s) will all be files in the linux filesystem.
> 
> > > Steps 2 & 3 are waiting for a HW update so the Cortex-A35 (running Linux) can share memory with
> > > the remote core.
> > >
> > > I'm happy to provide more explanation in the commit log to reflect this status.
> > >
> > > Is it OK that we go with step 1 as a foundation please ?
> > >
> > 
> > First let's clarify all the scenarios that need to be supported.  From
> > there I will advise on how to proceed and what modifications to the
> > subsystem's core should be made, if need be.
> 
> Thanks, I hope the answers above provide the information needed.
> 
> Cheers
> Abdellatif

