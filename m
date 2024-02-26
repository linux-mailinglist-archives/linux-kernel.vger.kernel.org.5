Return-Path: <linux-kernel+bounces-80980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7729A866E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09638287657
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F621F619;
	Mon, 26 Feb 2024 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y8uHFjKc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8221CD2B;
	Mon, 26 Feb 2024 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937652; cv=none; b=PLzoCQw89wFOLttVIvmpUcqGj5SGyWj499jDyY0C0DDySFp4ttn3x1J4v5hzdME+Q8qLVPfdpcJNUmzQuj/JEIxbcX3s7CeCw/jaggKtdOhoY2VlviluGb6afY/bdvCgFqgADiaySw3pnUUMA4X5SmFLMWjve9eu2eWDhin9Qfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937652; c=relaxed/simple;
	bh=pjv2fhOW94iLLWS4VEuh49cFeCknKUZZbCQ8xc1tWOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K773oyh61RPPg4ILDQzZMA07oUTEoqxC4h0hz/8k2euClfSqAHFNjzT5uHAlMV68dy2mOp41Zv2sTywn2hsYf8MWY/DWt8MZapK87syErg1U2YBnDv6Bcx4xyxWKbHm8B2D5g7hj82UfF70rbzwQDMYegwfOUWBH/dY2ALPrMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y8uHFjKc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708937648;
	bh=pjv2fhOW94iLLWS4VEuh49cFeCknKUZZbCQ8xc1tWOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y8uHFjKcveo1pVJZlRfFNFHwPbJMhQ6YfKl5FXTPDX1/vf96Z9+SBvqwh0BWUs/7Q
	 ppn6luqf/Aci81+xb2qMABaa5fK7ROaTv0m+VA4rEqwAIesYC1QXzIvNZVuLEokSmw
	 eRflYxpwL1Y13iMSmu2lf2GCsVv5Se+8ToY38OvsnoPDgbexRtcCT9SSccFaeQ0rm6
	 xh4Xr9IAQph6NrfOog4b56SusB90LxmG634DJ7dEhi/8UXfnJ0Yyla8QriLbdemgaU
	 +HcqatEWq+XMHbKqDKZDxRWCdtJ9hI0wUhLXi+nyCz2ikSNZeTbIJEYCH3UD7v30nm
	 G1rXyzsxbPPnw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1CE373781183;
	Mon, 26 Feb 2024 08:54:08 +0000 (UTC)
Message-ID: <feab2039-5745-41a4-87c3-44fa266efc1d@collabora.com>
Date: Mon, 26 Feb 2024 09:54:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: Add power-domains properity
 to mfgcfg
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ikjoon Jang <ikjn@chromium.org>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>
References: <20240223091122.2430037-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240223091122.2430037-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/02/24 10:11, Chen-Yu Tsai ha scritto:
> From: Ikjoon Jang <ikjn@chromium.org>
> 
> mfgcfg clock is under MFG_ASYNC power domain.
> 
> Fixes: e526c9bc11f8 ("arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and Makefile")
> Fixes: 37fb78b9aeb7 ("arm64: dts: mediatek: Add mt8183 power domains controller")
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> This patch is long overdue. Could we merge it for fixes for this or the
> next release?
> 

A clock controller that needs a power domain? Can you please describe the issue
that you're trying to solve with this?

It's not very uncommon but I'm not entirely convinced that this is right, because
the MFG_BG3D is a gate - and it's *not* outputting a clock rate on its own: the
mfgcfg is entirely GPU related and if there is no GPU support this clock is not
even ever needed.

MediaTek, can you please clarify if (and why) this gate clock needs a MTCMOS to
be ungated?

Thanks,
Angelo

> Changes since v2:
> - Rebased onto current tree
> - Added Fixes tags
> - Fix up subject prefix
> 
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 93dfbf130231..774ae5d9143f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1637,6 +1637,7 @@ mfgcfg: syscon@13000000 {
>   			compatible = "mediatek,mt8183-mfgcfg", "syscon";
>   			reg = <0 0x13000000 0 0x1000>;
>   			#clock-cells = <1>;
> +			power-domains = <&spm MT8183_POWER_DOMAIN_MFG_ASYNC>;
>   		};
>   
>   		gpu: gpu@13040000 {



