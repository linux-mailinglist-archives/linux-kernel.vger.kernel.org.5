Return-Path: <linux-kernel+bounces-165147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D588B88A5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB841C22A76
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B3F5644B;
	Wed,  1 May 2024 10:32:13 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95A53E30;
	Wed,  1 May 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714559533; cv=none; b=aDgsK3xljmOZ770HOMSzev5bV6UowlX7cr8cetY7JoYURxDXSoVqbvPdv/XL/PfDa3t+XvLke9DSNsNRYPMMFLptK8iwOwob8mmXyRub3/qTvjFAyizHu/DvbQItT5MIrD0goINbkjG28YBLYv/VvQoxzeaWIFL+kpAmBDVLq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714559533; c=relaxed/simple;
	bh=1cFYgH4fejlr1k1LGhfR3A3jheL7EEj8sOaviZeqXKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDkdAsPEiDFmC5xbuoDdiC5mHekRSoPcnV4u217zYU6IZU2r15410aUv5HCsLIEv4tnN8tMQD6ygUGNusxTMMEwyZuA5egN0Hp+0ze1SdnsKiYSSfMknPykQkAQUShY5lIdEj0OIWhZy2FlpA5g1OTl+FaNhY8LNuP3e7olzTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b01.versanet.de ([83.135.91.1] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s27FU-0002w0-Fq; Wed, 01 May 2024 12:31:40 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: soc@kernel.org, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Khuong Dinh <khuong@os.amperecomputing.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Robert Richter <rric@kernel.org>, Chanho Min <chanho.min@lge.com>,
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>,
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>,
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: Add/fix /memory node unit-addresses
Date: Wed, 01 May 2024 12:31:38 +0200
Message-ID: <2235630.taCxCBeP46@diego>
In-Reply-To: <20240430191856.874600-2-robh@kernel.org>
References: <20240430191856.874600-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 30. April 2024, 21:18:54 CEST schrieb Rob Herring (Arm):
> '/memory' nodes always have a 'reg' property, and therefore should have
> a unit-address with just plain hex (i.e. no commas). Fix all the arm64
> '/memory' nodes.
> 
> It's possible that some bootloader depends on /memory (arm32 ATAG to DT
> code does for example). If so, the memory node should be commented with
> that requirement.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

>  arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi           | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3368-r88.dts            | 2 +-

For the Rockchip boards
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Other rk3368-based boards like the Geekbox and PX5-evb already use
the correct memory@0 node names, so it looks like the the bootloaders
used on rk3368 don't have special requirements for the node-naming.



