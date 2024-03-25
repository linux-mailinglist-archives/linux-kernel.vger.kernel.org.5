Return-Path: <linux-kernel+bounces-117065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A96088A69D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E97C1F3F841
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04BB15ECC7;
	Mon, 25 Mar 2024 12:52:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578341758F;
	Mon, 25 Mar 2024 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371145; cv=none; b=FEMUJ+T1Ll4CmLgO4jQ6Q1LFPBny18mhgxcPgMtelfNwvxL7v7msYBKqC2y71QVvKMG4h6RnpxAZEyGZIBoVMdxbbyZU4RoN3Co8Y0EzCQ2Dl2b5F54itTpeiuHl3Zm1RFNpF9rEqR3GitDg895Pk7FXASuNfTwNPEziRBFvelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371145; c=relaxed/simple;
	bh=ExUUsC+CqMjF+l/I8M6xKudiZbcZcqHRiPeAkaD7Bko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bo1u9xAAGUJD5D8rBO1LNSasLPSGd74Ns0AlppLFzPAoAk04vbJiebK/AObKrFk57YYj3O4wLhgXePX9u8+i0JdRvhJTKjZTI9S5mv7K9riNI/M5Ad9Jo6LrHqJ57feLNbw9dPXP4lrITx38pMAqpPp9cp22/094BnFCBgx5aLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7162F1FB;
	Mon, 25 Mar 2024 05:52:56 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C48633F67D;
	Mon, 25 Mar 2024 05:52:20 -0700 (PDT)
Date: Mon, 25 Mar 2024 12:52:18 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH 2/2] arm64: dts: juno: fix thermal zone node
 names
Message-ID: <ZgFzgr1KtuFIeVux@bogus>
References: <20240103142051.111717-1-krzysztof.kozlowski@linaro.org>
 <20240103142051.111717-2-krzysztof.kozlowski@linaro.org>
 <171136466536.36729.15243854495211929982.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171136466536.36729.15243854495211929982.b4-ty@linaro.org>

On Mon, Mar 25, 2024 at 12:05:14PM +0100, Krzysztof Kozlowski wrote:
> 
> On Wed, 03 Jan 2024 15:20:51 +0100, Krzysztof Kozlowski wrote:
> > Linux kernel uses thermal zone node name during registering thermal
> > zones and has a hard-coded limit of 20 characters, including terminating
> > NUL byte.  Exceeding the limit will cause failure to configure thermal
> > zone.
> > 
> > 
> 
> Applied, thanks!
> 
> This was waiting on the lists for some time and no one picked it up, so... let
> me know if I should drop it from my tree.
>

Sorry for that, must have slipped through when I was off. Thanks for picking
it up. If not too late, feel free to add

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

