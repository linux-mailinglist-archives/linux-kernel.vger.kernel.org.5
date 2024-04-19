Return-Path: <linux-kernel+bounces-151193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E084B8AAAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1782850A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA23745C5;
	Fri, 19 Apr 2024 08:53:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00AFF9CD;
	Fri, 19 Apr 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516834; cv=none; b=oQfzDhx1zdC34i6Q73AbvMaiU0J0E+n82hAI9/DRWe8/zqwiDkfQpVKAyOqoTB5jU2K8Fr5s5tk/OkOr6DXpF6zhvvakWF24kYARs+4PAiQ+bKgprgdWLZ43lHSPmzjRG6h86bg0FXoCaSoMZSlJIjd9Ks1bKBBRfBDUXx5T2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516834; c=relaxed/simple;
	bh=mZaqwvICdeQc4Uk1/mG9rpCXgLLl45RMWhDGIpJ27DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRIkL5xv59i2SOpty6Qle+dx6GdAnJAZ93rIE9oY3EZlbWn3GQGpF3vUXq/DSy+1AejJgILOg3+obowcyfomY6ChsICpwV90uRIbCvqI/u8uXtth6LWGMZz/z1Us6XhSxXPPivzi36T2wnKh0AcaPxMJ8T09arF0+9GIeO7J7zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 198A42F;
	Fri, 19 Apr 2024 01:54:19 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D14E23F792;
	Fri, 19 Apr 2024 01:53:47 -0700 (PDT)
Date: Fri, 19 Apr 2024 09:53:45 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
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
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Implement vendor resets for PSCI SYSTEM_RESET2
Message-ID: <20240419085345.4ovebbbmcabo3f73@bogus>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <Zh5GWqt2oCNHdF_h@bogus>
 <20240417140957985-0700.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417140957985-0700.eberman@hu-eberman-lv.qualcomm.com>

On Wed, Apr 17, 2024 at 02:54:41PM -0700, Elliot Berman wrote:
> On Tue, Apr 16, 2024 at 10:35:22AM +0100, Sudeep Holla wrote:
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
>
> I was motivating the reason for using SYSTEM_RESET2. How to set the PMIC
> register and IMEM cookie can change between chipsets. Using
> SYSTEM_RESET2 alows us to abstract how to perform the reset.

Fair enough. But I assume you are not providing the details of PMIC register
or IMEM cookie via DT.

Anyways you did confirm if PSCI SYSTEM_RESET works as expected or not. That
is default and must work.

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
>
> As Dmitry pointed out, this information isn't discoverable. I suppose
> we could technically use bootconfig or kernel command-line to convey the
> map although I think devicetree is the right spot for this mapping.
>

Yes and as usual DT has become dumping ground for firmware that don't
make things discoverable. Make crap that Qcom puts in the DT are firmware
related and can be make discoverable. Anyways it is sad that no efforts
to make it so are done as DT is always there to provide shortcuts.

> - Other vendor-specific bits for PSCI are described in the devicetree.
>   One example is the suspend param (e.g. the StateID) for cpu idle
>   states.

You are right, but that is the only example I can see and it was done
in very early days of PSCI. It shouldn't be example if there are better
ways.

> - Describing firmware bits in the DT isn't unprecedented, and putting
>   this information outside the DT means that other OSes (besides Linux)
>   need their own way to convey this information.

Correct but it can be Qcom specific firmware interface. There are so many
already. This splitting information between firmware and DT works well
for vertically integrated things which probably is the case with most of
Qcom SoCs but it is prone to issues if DT and firmware mismatch. Firmware
discovery eliminates such issues.

> - PSCI would be the odd one out that reboot mode map is not described in
>   DT. Other reboot-mode drivers specify the mapping in the DT. Userspace
>   that runs with firmware that support vendor reset2 need to make sure
>   they can configure the mapping early enough.
>

Well I am not saying not to this yet, just exploring and getting more info
so that whatever is done here can be reused on all PSCI based systems.

--
Regards,
Sudeep

