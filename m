Return-Path: <linux-kernel+bounces-83636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A39869C97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73CCC284595
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6AF4DA11;
	Tue, 27 Feb 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A363ersE"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2734D9F0;
	Tue, 27 Feb 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052140; cv=none; b=McNo+J/P7ctVihrHsvcsg+TWdJLYqj4T/7XVYcF75kpr4DxtrV1zwQsDJGVOvOuVKPhhi8HvTPdrYDeoKX9Sc51bSRy0/RB8YO/e9dQm+6dF1H0I14bam0IsNNtRNSfE5ST+OS4Z++hHvvZCNpE1BFZHWjTeQ4EOuxNKzJhZKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052140; c=relaxed/simple;
	bh=wqGBDu2iVSiFPGeYB2ZaQCe+qtPB3V7wawJrssUmrcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WVDjaN6DVyR7ciU/WdBKUTBVveM3tGBAQdJtCxNxv/42+uvq0jNu5qFjzIL+hJYdvIYN8YKjpLlH+N8VCVlNRz53qB/CuUtrova+kUzxktMc61ulXuy9xmd+6pSPO7qQMiO+kG6MA+lxQEbgYbRGBwsB3DYM59KAeW6CRQUc7BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A363ersE; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5DA3C000D;
	Tue, 27 Feb 2024 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709052136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFFvc/kXhhPE/Ai0TIt6kItQ96wA8rGqNC6w6HzN1PM=;
	b=A363ersE126DmTtgO2Pm7Xjs9TB4ShvnciloCFnEm1bPZxUViUJkaDudlz8V3WUcg1pOmb
	RKDfoLjsW3mbkH9LmaSkEoO0EFAx+/mQSLhceGjThBsbprz9nP0igw7buJChkPpdYAyZlB
	C6mQAUo4K6b2IUa2aBkg5QUo2pGWy5QLhkLQOMLOnvtNoluPmILEMN1MMmok7ZA7rokgkm
	TPZwie/mN6bS1/wXIzRRGfRM0gn6OYAyuvPTOf+zK/rxsr7xF2buCug/8y1w4LDVlpagvX
	TlNpPUxPPws9A9AgiOpe+/IuVv4FMbh5F7eR8Hml12btt/HsyU14UZNhAgnW2Q==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Stefan Eichenberger <eichest@gmail.com>, andrew@lunn.ch,
 sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Leibovich <alexl@marvell.com>, Stefan
 Chulski <stefanc@marvell.com>, Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v2] arm64: dts: armada-ap807: update thermal compatible
In-Reply-To: <20240208081413.7923-1-eichest@gmail.com>
References: <20240208081413.7923-1-eichest@gmail.com>
Date: Tue, 27 Feb 2024 17:42:14 +0100
Message-ID: <87ttltj1uh.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Hi Stefan Eichenberger,

> From: Alex Leibovich <alexl@marvell.com>
>
> Use the correct thermal coefficients for the Armada AP807 dies.
>
> Signed-off-by: Alex Leibovich <alexl@marvell.com>
> Reviewed-by: Stefan Chulski <stefanc@marvell.com>
> Tested-by: Stefan Chulski <stefanc@marvell.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>


Applied on mvebu/dt64

Thanks,

Gregory

> ---
> Changes in v2:
> - Added me as last signed-off-by
> - Besides that it is the third patch of this series:
> https://lore.kernel.org/all/ZIxMYXDCTB7IvsDk@shell.armlinux.org.uk/
> - The first two patches in the series are already applied
> ---
>  arch/arm64/boot/dts/marvell/armada-ap807.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> index 4a23f65d475f..a3328d05fc94 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> @@ -33,3 +33,6 @@ &ap_sdhci0 {
>  		     "marvell,armada-ap806-sdhci"; /* Backward compatibility */
>  };
>  
> +&ap_thermal {
> +	compatible = "marvell,armada-ap807-thermal";
> +};
> -- 
> 2.40.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

