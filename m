Return-Path: <linux-kernel+bounces-146556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142918A6728
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF974B22788
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9F085954;
	Tue, 16 Apr 2024 09:30:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FDB3BBEC;
	Tue, 16 Apr 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259826; cv=none; b=npt/anmAwiz2M11wfY2NY/vLBL7sh8zsVdC+/3kwbnFgtXFM3XlDUU8VAQIlPKvSjBzfvo191n8VIJ2kzLmv/o82jkHX0MtVb/UOcSWXqQNt9f07Ra9DKslLzrIt6KkofNA5WvC41gXGJYki7AbvhqQRgWszuOeLWXDDIIzow44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259826; c=relaxed/simple;
	bh=0S4dl5OPyAOfxXD39bgYpW+Ks0WTkRgAMp/IaV6F/2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmwbNaYNUZUX3Dd/70ULTR0QW8MOMZZosMRLw26Vcx8Um+1QUchIYfphg3hQP1hRy1ysHfOgDoJDp4pMWLsvKEs+vGEy46IMTgKrwelLwcM0W/lUWDNTHmc3JdIDFdiHna9868puX46BwMN82LurRcuqHQVxqkLANqix8AVDkeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E744339;
	Tue, 16 Apr 2024 02:30:52 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 581E43F792;
	Tue, 16 Apr 2024 02:30:21 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:30:18 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
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
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: Document reboot mode magic
Message-ID: <Zh5FKtLVhIH-6R-I@bogus>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <20240414-arm-psci-system_reset2-vendor-reboots-v2-2-da9a055a648f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-arm-psci-system_reset2-vendor-reboots-v2-2-da9a055a648f@quicinc.com>

On Sun, Apr 14, 2024 at 12:30:25PM -0700, Elliot Berman wrote:
> Add bindings to describe vendor-specific reboot modes. Values here
> correspond to valid parameters to vendor-specific reset types in PSCI
> SYSTEM_RESET2 call.
>

IIUC, PSCI SYSTEM_RESET will be always supported, so the choice of using
SYSTEM_RESET2 sounds like a system policy and must not have any information
in the device tree. All required support from PSCI is discoverable and
the policy choice must be userspace driven. That's my opinion.

-- 
Regards,
Sudeep

