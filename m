Return-Path: <linux-kernel+bounces-38295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B553183BD93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBE11F304C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8D81CA85;
	Thu, 25 Jan 2024 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HNmTjZM+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2E1CA84;
	Thu, 25 Jan 2024 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175612; cv=none; b=loXXQZB5cpntolNW1pq4fBnAmsQPSSEqk/G7Uk+5lreG/sGvfT5LOp5gM+LQYP8TbcUy9sch6BXAu0Hg9PCmeLoRW0DSbiH+qt8HpKihMY1qRecSh0BOGIhOPr5QDNgfNPaMMZHPlL1oSzil40DstK3cOzWrn5+7FToc4ugEBkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175612; c=relaxed/simple;
	bh=LHVp2Aq1cKc1dUF9nEIRvfSxerS4jkPtOKuHQWo2Y4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXuDHW5E+L9EBmGjXI85W8ZqzXMWSnuEVAsC0L2qCWgLwAHbzyVAYXsLrVXaCtOwIodCO9hwRUZC+n4Y5+ENENKm3EHUwZFjpvApU26DBxhY/+Fpiy2rmiabVTpYEhV6AMGT+cGnuwy2myBR/50IYD5u5n9Y7MYLGjn4BXm8wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HNmTjZM+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706175594;
	bh=LHVp2Aq1cKc1dUF9nEIRvfSxerS4jkPtOKuHQWo2Y4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HNmTjZM+cfx0ARK433VvR4AuJnBRyXEw1t7MXW/7qvt8fNu48UCHv4cGpps2Qfcbk
	 NGgtbIaDvr/RhskarosTfvZSg14zgPUZMG7XDzzbLas/ExbbsCvwvImusFlzByYYzN
	 aVqYqvgloem1PAXShyRctp6AR5WHU81qFV2b62goE7KJX115atg9Z0jmiDGNIwQme9
	 sNNf+Hh0/LwbOSI8lHzCHV9urNkt8yCSyIQBblPKFyDOfqpdZUeeGCFuhfu60QRhCn
	 uR85MzEx4+KRNHeOJ2tV3S25GhjmP/vrJ2nmfkE29b/fBzAnO0AzTePS8J4CJvcAHS
	 q8KxPCEnHllqA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9F4D937820BC;
	Thu, 25 Jan 2024 09:39:53 +0000 (UTC)
Message-ID: <4a68ff4b-fafc-4d51-91c3-304b01562945@collabora.com>
Date: Thu, 25 Jan 2024 11:39:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: phy: Add Rockchip HDMI/DP Combo PHY
 schema
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Johan Jonker <jbx6244@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>,
 Algea Cao <algea.cao@rock-chips.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
 <20240119193806.1030214-3-cristian.ciocaltea@collabora.com>
 <18f66108-98e7-49b3-b362-880121438fc6@linaro.org>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <18f66108-98e7-49b3-b362-880121438fc6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 11:11, Krzysztof Kozlowski wrote:
> On 19/01/2024 20:38, Cristian Ciocaltea wrote:
>> +    soc {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +
>> +      hdptxphy_grf: syscon@fd5e0000 {
>> +        compatible = "rockchip,rk3588-hdptxphy-grf", "syscon";
>> +        reg = <0x0 0xfd5e0000 0x0 0x100>;
>> +      };
> 
> Drop node, not part of this binding.
> 
>> +
>> +      hdptxphy: phy@fed60000 {
> 
> Drop label.
> 
>> +        compatible = "rockchip,rk3588-hdptx-phy";
>> +        reg = <0x0 0xfed60000 0x0 0x2000>;
>> +        clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>, <&cru PCLK_HDPTX0>;
>> +        clock-names = "ref", "apb";
> 
> With these two changes:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Will do, thanks for the review!

Regards,
Cristian

