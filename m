Return-Path: <linux-kernel+bounces-96994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18999876431
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8761F21436
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B256B70;
	Fri,  8 Mar 2024 12:21:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211FF56459;
	Fri,  8 Mar 2024 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900497; cv=none; b=B4rnKn9JonfmLKa5MegrxyK1ZL2zehNQMycEPzqcSajeTSHzhbsdLD2fSLjsDItEYaRgTe1mKB6HnfQNNpYtpJrAyWwMTKJcq+bc887DuN3EfFcl2DZxvYFO5AUEU8RGCQCFV5r3hGdeM4DO0ANOQFlB3YLA9OeqPcGEJaDxbWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900497; c=relaxed/simple;
	bh=b9yBLPt4aHoHJIYns7zSseeiClwRXy+lWb/eKwahSKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuMKQ74KSs87SGnVvYabYl9/gXBL3VcvcNmOifm+J4NB8V41UGhHsOAKwWO1TtUVMH0opX0NKyF2I834+xkL6YLBw/VDbuID+H81M1ZX3XUuqKP+jt7uXUk5q+8O8BvzP+aiMAX7Z4ZKK7Dn10QwfJIpAWwVyK9P9wd7m5RehIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E8CFC15;
	Fri,  8 Mar 2024 04:22:09 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFD4B3F73F;
	Fri,  8 Mar 2024 04:21:30 -0800 (PST)
Date: Fri, 8 Mar 2024 12:21:28 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: abdellatif.elkhlifi@arm.com
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: Add corstone1000 external system device
 node
Message-ID: <ZesCyIpRgi1EkixF@bogus>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-3-abdellatif.elkhlifi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301164227.339208-3-abdellatif.elkhlifi@arm.com>

On Fri, Mar 01, 2024 at 04:42:26PM +0000, abdellatif.elkhlifi@arm.com wrote:
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> 
> add device tree node for the external system core in Corstone-1000
> 
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> ---
>  arch/arm64/boot/dts/arm/corstone1000.dtsi | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/corstone1000.dtsi b/arch/arm64/boot/dts/arm/corstone1000.dtsi
> index 6ad7829f9e28..67df642363e9 100644
> --- a/arch/arm64/boot/dts/arm/corstone1000.dtsi
> +++ b/arch/arm64/boot/dts/arm/corstone1000.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0 OR MIT
>  /*
> - * Copyright (c) 2022, Arm Limited. All rights reserved.
> + * Copyright 2022, 2024, Arm Limited and/or its affiliates <open-source-office@arm.com>
>   * Copyright (c) 2022, Linaro Limited. All rights reserved.
>   *
>   */
> @@ -157,5 +157,13 @@ mhu_seh1: mailbox@1b830000 {
>  			secure-status = "okay";     /* secure-world-only */
>  			status = "disabled";
>  		};
> +
> +		extsys0: remoteproc@1a010310 {
> +			compatible = "arm,corstone1000-extsys";
> +			reg = <0x1a010310 0x4>,
> +				<0x1a010314 0X4>;


As per [1], this is just a few registers within the 64kB block.
Not sure if it should be represented as a whole on just couple
of registers like this for reset.

-- 
Regards,
Sudeep

[1] https://developer.arm.com/documentation/101418/0100/Programmers-model/Register-descriptions/Host-Base-System-Control-register-summary

