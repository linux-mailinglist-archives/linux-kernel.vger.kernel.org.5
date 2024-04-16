Return-Path: <linux-kernel+bounces-146558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1748A6735
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1BD282577
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA785C68;
	Tue, 16 Apr 2024 09:35:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28B184E0A;
	Tue, 16 Apr 2024 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260130; cv=none; b=MGijnzhyLtbzMY6nRJyAb9cy2XM1Zirej+DRYIICQFZ2D2p5+3YWir6lGqBPprvIRCl52L+RY+HM4aIbWPVabkkZvOBi5UUAdlW0NLxgG3F+s8mLvFr/Vz68LZvdzs97xhHSIkHmfw0Iwhp7WUeRm3MGOg6AJzvPfB81ShFS45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260130; c=relaxed/simple;
	bh=TNm9wA9VCf4GRpizHagVxFmlH0uk3TxbxAtSjpVSKiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGlQ5+0CmJTlqMXrtZhxJ/o5LY02aPo+EeTrJHK67e5kkrZJTtBcnA8+5NWlyFgvXPi0SG/h76D06cX874rPYVQ61AG+EXB0ZOEvjEqRf77OvA+cP1BkKvNeKRRWtqQCzzd+MjUcsjeUTR0qKeqaGAnJvu82IBqEzTZwURzuN5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28C53339;
	Tue, 16 Apr 2024 02:35:56 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B0A83F792;
	Tue, 16 Apr 2024 02:35:25 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:35:22 +0100
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
	"Mark Rutland" <mark.rutland@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Implement vendor resets for PSCI SYSTEM_RESET2
Message-ID: <Zh5GWqt2oCNHdF_h@bogus>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>

On Sun, Apr 14, 2024 at 12:30:23PM -0700, Elliot Berman wrote:
> The PSCI SYSTEM_RESET2 call allows vendor firmware to define additional
> reset types which could be mapped to the reboot argument.
>
> Setting up reboot on Qualcomm devices can be inconsistent from chipset
> to chipset.

That doesn't sound good. Do you mean PSCI SYSTEM_RESET doesn't work as
expected ? Does it mean it is not conformant to the specification ?

> Generally, there is a PMIC register that gets written to
> decide the reboot type. There is also sometimes a cookie that can be
> written to indicate that the bootloader should behave differently than a
> regular boot. These knobs evolve over product generations and require
> more drivers. Qualcomm firmwares are beginning to expose vendor
> SYSTEM_RESET2 types to simplify driver requirements from Linux.
>

Why can't this be fully userspace driven ? What is the need to keep the
cookie in the DT ?


-- 
Regards,
Sudeep

