Return-Path: <linux-kernel+bounces-43104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C9840B99
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE674B21A27
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2992159589;
	Mon, 29 Jan 2024 16:30:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA2415956D;
	Mon, 29 Jan 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545852; cv=none; b=dv/jj1WY1+0Q6DI+oHEyFO2N2E1a8qrAnip93s7JBYfTnw+CJy02JlmaQvi4nBrE+KN1yxXNSCdJAa9ayfwPuQ8NyNknlZP2TuQpBPhWr/BN1vp/C8oJomSVmT+qRhSNht3xiXYTAA4f9YX6sR7DOUY2brGSXL0+cuEZMWPWSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545852; c=relaxed/simple;
	bh=W6TMqRtC+7055PVNc/k+MoT8M6gVLJlYB+nOkTGTGBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZLV/jwypAnlWnIwyo1rB/V4RWgCDrWGVUx6EnIhxphpsbIfj6CHOb63gfxyJSTvpqvYGBttjl5ERr08+ltWP17gARWiAmF50GfSkKw9XLSLgFXzs9DWvQT00fPpjpj9i8eYd2iha4IJZeaL5GTM+Y5R8V2pxQSmq6o9/4y5eQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A95ADA7;
	Mon, 29 Jan 2024 08:31:33 -0800 (PST)
Received: from bogus (unknown [10.57.78.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C67DC3F738;
	Mon, 29 Jan 2024 08:30:45 -0800 (PST)
Date: Mon, 29 Jan 2024 16:30:43 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
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
Subject: Re: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <20240129163043.if5jj4kyacqfe2n5@bogus>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
 <f88d07ef-83b2-4d14-976a-6dbbd71e036f@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88d07ef-83b2-4d14-976a-6dbbd71e036f@oss.nxp.com>

On Mon, Jan 29, 2024 at 08:36:50PM +0800, Peng Fan wrote:
> Hi Sudeep, Cristian
> 
> Would you pick up patch 1-4?

I will for v6.9 sometime.

> And for i.MX95 OEM extenstion, do you have any suggestions?
> I have two points:
> 1. use vendor compatible. This would also benefit when supporting vendor
> protocol.

May be, but that was never on plate for standard protocols. So I don't
like that approach either.

> 2. Introduce a property saying supporting-generic-pinconf
>

I am not sure what you mean by that. But that doesn't sound right especial
in context of SCMI. So I would say no.

> How do you think?
>

I don't have any other suggestions than fix your driver to use the pinmux
properly with features in the upstream pinmux subsystem.

-- 
Regards,
Sudeep

