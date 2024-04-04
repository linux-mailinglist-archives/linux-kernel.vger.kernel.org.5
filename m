Return-Path: <linux-kernel+bounces-131048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2DE89825F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFE01C21EB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1FA5C8F4;
	Thu,  4 Apr 2024 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="TKKNGcyN"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40A63C7;
	Thu,  4 Apr 2024 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216731; cv=none; b=JdIBA4oo8NEYtsL8JmYVfGH+P/qrNU7aRBisEGGURzepQOIE9/zM2XAuyESWYpNDAWiKRPt4bSKBKP8IY4dufzYoKvhevDMUm9gWkxP7cjs14Tme3Hfhsa0TM7EA0BBEsviDP1rWPWzjRHhxlLi4OEhcoBbC/xvOp42WE1TPq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216731; c=relaxed/simple;
	bh=oZro36DPjo91nHmLLoFWN5FvMZOrQjLObCI4Gt9wbr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+hh1D94Mixz10LR2cvjnkhqKWmAglJcAEf6Yd38DaDRu6SlLcj+0GDvaoIT8KAiBIvbFWD8ecjs/MqIYvcDdxfrWj0iyPLdSHzBIAw+jCRjoMlfWTxvflxs6dbpb2b3NgKwkR1lsej5KKVNVG79DTHrYMD4I1eYQ4IBXDVMtGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=TKKNGcyN; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E93141FA6E;
	Thu,  4 Apr 2024 09:45:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712216719;
	bh=ryvia0nLhKRVPovUMdbprzNdINyicI2Sofph4j5VnBw=; h=From:To:Subject;
	b=TKKNGcyN4+4pkGR46A9CckWl6rgrQniGTh1sxESxhrGRuQEyFxlHJaMYz+eCh8WPK
	 Dw8Z85s+8uzomgK0jDWqMIY9i79fdHOJGiHgm6OL2LXGllg0db0d27DQKswz9oBPRk
	 L2w/U8xUSVQk99Q5kuS9EVvm1CymD11vijQLeritsb+vLHzDHN+xEozlq3zvT3fvyN
	 pwPtNk/tHXZJsxfAIr5R9jeZ+a9fl4u8T3OxHjYhQ9b714Gh499nHq2Mdk0zbs2l2F
	 wLacfIKRrniWEb+qdqsf3B755taCAYodPhYXjIY0rGWBF1eWPKqsYZEZuPdZrJftF/
	 jqGyPFKpvOk7A==
Date: Thu, 4 Apr 2024 09:45:15 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Michael Walle <mwalle@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j722s-evm: Enable eMMC support
Message-ID: <20240404074515.GA5639@francesco-nb>
References: <20240403102302.3934932-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403102302.3934932-1-mwalle@kernel.org>

Hello Michael,

On Wed, Apr 03, 2024 at 12:23:02PM +0200, Michael Walle wrote:
> The J722S EVM has an on-board eMMC. Enable the SDHC interface for it.
> There is no pinmuxing required because the interface has dedicated pins.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> v2:
>  - move status="okay" last
> ---
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index cee3a8661d5e..6b148da2bcdc 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -369,6 +369,13 @@ partition@3fc0000 {
>  
>  };
>  
> +&sdhci0 {
> +	ti,driver-strength-ohm = <50>;

According to the latest DTS coding style guidelines this needs to be
just before status.

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

Yes, we would need a checker, I know and I agree. At least now we moved
out of the tribal knowledge way of working with every maintainer having
slightly different expectation on this topic ... one step at a time :-)

> +	disable-wp;
> +	bootph-all;
> +	status = "okay";
> +};


Francesco


