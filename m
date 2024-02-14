Return-Path: <linux-kernel+bounces-64907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D58C854485
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D922850FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0432AD4B;
	Wed, 14 Feb 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X5rdKeXP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774626FB6;
	Wed, 14 Feb 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901418; cv=none; b=qxnl1pOodvfl91DBZmopDP5jZDn5OMvSYGYI3JkjvM0O5stImot1UgCYyyhNguvQfCyBt3P1THfdQdCRDu999qQIs6y93lAmO2epfcglwhdbzaBFC1X30l3o7D2Jb0eCOGsYmAb7lOKvflUB28YTy7aAfYQsmeyUKyvHRzxhtz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901418; c=relaxed/simple;
	bh=IkMSx2GMsosJsuqeMCf9O8BI8a8CA/8JrvnoKOrX2hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVRGTHRoV3ABdAazCmBlF96NKMtM2n42QpZ+TnthQGIC9ZKlGlrHGpF78T5Kw1tBPoA9bUbK8JwV4yhClRztrqCajc+GsLjBgVdoZ39oX/fi6dVg6MaRXsWeBsokyAr1Ofm1iSE/3X9PDRniZFvUE190oUQZzQr9TzJqoxCEG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X5rdKeXP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707901408;
	bh=IkMSx2GMsosJsuqeMCf9O8BI8a8CA/8JrvnoKOrX2hY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X5rdKeXPeqAiyx6zTZSRHE9cio2suhjrDXXa3EKLg6fs5OJQQBTxzSS4xVRRG6kUi
	 aSxL96RzvvF3u+Vyol2XGDkzF78R8k/EJrtlevDmoMA0zn+pOk1En1CTs25BEfz0c+
	 JoPYq+x/n5GY4mghF7Pyj1kjwntdmBGgwix/7PAQ8uyBJj/GP5D3+5thYaKdD0JheH
	 NxNfsZoqCccbX3RoaTE3jEEs1AiSM7LFKEaBPHw/10X2oKX5eiWIdrx22jdLxBa+hK
	 UcPmIx++Zet9sP1+n2z8xElSAp85RldV5zKM4z1f0h3jxj1mdvXQEJH02010efGkmL
	 hEQhqPHsLEdPQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A26113781FD9;
	Wed, 14 Feb 2024 09:03:27 +0000 (UTC)
Message-ID: <6fea6cd3-031b-4d5a-8bba-f01f6afa12b3@collabora.com>
Date: Wed, 14 Feb 2024 10:03:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt8186: Add missing xhci
 clock to usb controllers
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
 Eugen Hristev <eugen.hristev@collabora.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240213-mt8186-ssusb-domain-clk-fix-v2-0-1f981d35f3fd@collabora.com>
 <20240213-mt8186-ssusb-domain-clk-fix-v2-2-1f981d35f3fd@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240213-mt8186-ssusb-domain-clk-fix-v2-2-1f981d35f3fd@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/02/24 16:02, Nícolas F. R. A. Prado ha scritto:
> The mtu3 usb controllers don't list the xhci clock, though they require
> it, and thus rely on the bootloader leaving it on in order to work.
> 
> When booting with the upstream arm64 defconfig, the usb controllers will
> defer probe until modules have loaded since they have an indirect
> dependency on CONFIG_MTK_CMDQ, which is configured as a module. However
> at the point where modules are loaded, unused clocks are also disabled,
> causing the usb controllers to probe without the xhci clock enabled and
> fail to probe:
> 
> mtu3 11201000.usb: clks of sts1 are not stable!
> mtu3 11201000.usb: device enable failed -110
> mtu3 11201000.usb: mtu3 hw init failed:-110
> mtu3 11201000.usb: failed to initialize gadget
> mtu3: probe of 11201000.usb failed with error -110
> 
> (and same for the one at 11281000)
> 
> Add the missing clock for the usb controllers so that they can
> successfully probe without relying on the bootloader state.
> 
> Fixes: f6c3e61c5486 ("arm64: dts: mediatek: mt8186: Add MTU3 nodes")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


