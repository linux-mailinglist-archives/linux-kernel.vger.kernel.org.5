Return-Path: <linux-kernel+bounces-151425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C9C8AAEB4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B0F28202E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3A512B17C;
	Fri, 19 Apr 2024 12:38:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B03185943;
	Fri, 19 Apr 2024 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530336; cv=none; b=l0ogdbnm+50WAWGtHVvp+d6IEbClSfN5JUUZOQrqf4Bhj9Iubgxu7rCuYdClIu4+DLUWWMdl/wT3WpHCSXuIqB6o2zuimru9z2MBVxrZ9z4nxY4+pMixnNzPSxD+AHv372wdl8r2M/uKSd+PZZn4ntDhzt8HK5PEkSv+J+ODEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530336; c=relaxed/simple;
	bh=6c4g+/06gQCstLfzuVhVmJ7KExrdz67CYKZTprqbHuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hod9qIm+tAbT2RLRNLbHs+Af+HmDtj/mnhnso/kJYhdkSV7qNe04COHi92yMPApsg9ZiCQuTfunRJRy8l0efBbTIrssNNB0inCv/dit8346iymXkk9H8Z+cDtACdfzRTKYZD4qBA02P//PzAJ+cQK+eBLNIe0vijlXCxJyF0GsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69E772F;
	Fri, 19 Apr 2024 05:39:21 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A9ED3F64C;
	Fri, 19 Apr 2024 05:38:49 -0700 (PDT)
Date: Fri, 19 Apr 2024 13:38:47 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Elliot Berman <quic_eberman@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Implement vendor resets for PSCI SYSTEM_RESET2
Message-ID: <20240419123847.ica22nft3sejqnm7@bogus>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <Zh5GWqt2oCNHdF_h@bogus>
 <48f366f5-4a17-474c-a8e3-6d79c9092d62@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48f366f5-4a17-474c-a8e3-6d79c9092d62@broadcom.com>

On Wed, Apr 17, 2024 at 10:50:07AM -0700, Florian Fainelli wrote:
> On 4/16/24 02:35, Sudeep Holla wrote:
> > On Sun, Apr 14, 2024 at 12:30:23PM -0700, Elliot Berman wrote:
> > > The PSCI SYSTEM_RESET2 call allows vendor firmware to define additional
> > > reset types which could be mapped to the reboot argument.
> > >
> > > Setting up reboot on Qualcomm devices can be inconsistent from chipset
> > > to chipset.
> >
> > That doesn't sound good. Do you mean PSCI SYSTEM_RESET doesn't work as
> > expected ? Does it mean it is not conformant to the specification ?
> >
> > > Generally, there is a PMIC register that gets written to
> > > decide the reboot type. There is also sometimes a cookie that can be
> > > written to indicate that the bootloader should behave differently than a
> > > regular boot. These knobs evolve over product generations and require
> > > more drivers. Qualcomm firmwares are beginning to expose vendor
> > > SYSTEM_RESET2 types to simplify driver requirements from Linux.
> > >
> >
> > Why can't this be fully userspace driven ? What is the need to keep the
> > cookie in the DT ?
> >
> >
>
> Using the second example in the Device Tree:
>
> mode-bootloader = <1 2>;
>
> are you suggesting that within psci_vendor_sys_reset2() we would look at the
> data argument and assume that we have something like this in memory:
>
> const char *cmd = data;
>
> cmd[] = "bootloader 2"
>
> where "bootloader" is the reboot command, and "2" is the cookie? From an
> util-linux, busybox, toybox, etc. we would have to concatenate those
> arguments with a space, but I suppose that would be doable.
>

Yes that was my thought when I wrote the email. But since I have looked at
existing bindings and support in the kernel in little more detail I would say.
So I am not sure what would be the better choice for PSCI SYSTEM_RESET2
especially when there is some ground support to build.

So I am open for alternatives including this approach.

--
Regards,
Sudeep

