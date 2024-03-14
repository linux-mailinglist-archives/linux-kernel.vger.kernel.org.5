Return-Path: <linux-kernel+bounces-103591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EB187C183
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B31B1F21B05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8C474419;
	Thu, 14 Mar 2024 16:48:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A656E73526;
	Thu, 14 Mar 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434911; cv=none; b=dar3/4VHmzFARhQchgByWr69C3L6RzV4U9OF9x3HBrwlj5iVqCauaowMTI+BDgYClCR7H96GdX7ZS/9slZNf1t7tG+pEsjJ4kbI6/+nXjdArEUPF/azsqj//aaGWcH7r91skmQbb/7818+i/gjK6UlQERl9Nc6OHMQR9bE1ZCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434911; c=relaxed/simple;
	bh=61OWcJo8xpjNajI8IviQi0Oc5WE5ZxABZnArcdDNUDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idMvywmrnq/zCYQ/wwVT+Zyyrbbxt8YIAkDCbSkrB5TYErYm3B78M9tW5Q3OYEzzUb20xvFEmnz2UCOqY4o1i8BpZ1yFAU+AbcPeC32sLvLI165tiaR/eC7KG9GtITxLQAGVOLm6dSUxBTQ2Er8Yog3OraOTzVQL3Wlz3UJNVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 067561007;
	Thu, 14 Mar 2024 09:49:05 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 698643F762;
	Thu, 14 Mar 2024 09:48:26 -0700 (PDT)
Date: Thu, 14 Mar 2024 16:48:24 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZfMqWP-t39SCvkA2@pluto>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>

On Thu, Mar 14, 2024 at 09:35:17PM +0800, Peng Fan (OSS) wrote:
> Since SCMI 3.2 Spec is released, and this patchset has got R-b/T-b,
> is it ok to land this patchset?
> 

I'll have a look at this last version and a spin on my test setup.

..but has this V5 change at all since the Reviewed-by tags due to the
latest spec changes ?

..IOW does this V5 include the latest small bits spec-changes or those
latest gpio-related spec-changes are just not needed at the level of the Linux
pinctrl support as of now and can be added later on when a Linux gpio
driver will be built on top of this ?

Thanks,
Cristian

