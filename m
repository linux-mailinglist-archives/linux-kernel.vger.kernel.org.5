Return-Path: <linux-kernel+bounces-148514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C698A83D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C7CB24146
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C9613DBAD;
	Wed, 17 Apr 2024 13:07:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2023113C9BF;
	Wed, 17 Apr 2024 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359271; cv=none; b=f65s0IE/v9f3nogEZ5xR4hPzSk+fo4COXKr2Pt8SsOZ3K3dbUuBy9b1hv90VMnptbaPozAaYqp+vuTBm8u8WQOA+Dh7m5aOeeUofiSnbIv0nj8Flh9isYH2ZxfZVCLBeYsT/7xEH34tDXIlJeWmxDyg1x7landY7aX2CGR8hTsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359271; c=relaxed/simple;
	bh=UwDPpPTO8fr38xZWC6BfjYWgirJI4xegCIDYLE9yDCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAA5QejyVs2GwSYvBMeJ7GU6dB0w7uYVmQVWIz5s2vC9TsOdciHQrbNU5dNueB/mkTTDH3sdnJap2Myy5g5pB5AwBurVg41rS3pQuej5P9WAylFM9trlHvE+psjUjqpkCqeNPmlmpDdFlQ9FCBMQ46f/VHVHdpJew3IeFx18UQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31E6D339;
	Wed, 17 Apr 2024 06:08:13 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14CC73F738;
	Wed, 17 Apr 2024 06:07:42 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:07:40 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v10 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <20240417130740.rxmseispc32d2sjz@bogus>
References: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com>
 <6c652af8-151e-4d8b-9587-8eae1254a4fe@moroto.mountain>
 <DU0PR04MB941737BD9ACF18526D8A50C7880F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB941737BD9ACF18526D8A50C7880F2@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Wed, Apr 17, 2024 at 12:15:57PM +0000, Peng Fan wrote:
> Hi Dan,
>
> Just a short question, you will make this a standalone
> patch part of your gpio pinctrl patchset, right?
>
> Or you wanna include this change in my v11 patch?
>
> I hope v11 + imx oem patches could land in 6.10,

I haven't looked at i.MX OEM patches even once so far. IIRC it is all
in the pinctrl driver and you may not need my review/ack. But let us get
this series in first.

This series looks good overall. Since it has pinctrl driver, I need Linus
to ack/agree to pick the whole series up or I can ack them so that Linus
can take the whole series. Either way it is fine for me.

Thanks for all your efforts in pursuing this.

--
Regards,
Sudeep

