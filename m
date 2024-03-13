Return-Path: <linux-kernel+bounces-101626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C6987A99A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067E21C2204C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2CA79DD;
	Wed, 13 Mar 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wV45Rr4v"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F814A07;
	Wed, 13 Mar 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340615; cv=none; b=lGraK+qijlyPcSHMvPS0K8le/63rAFsBxgc2bI8K4VKE6GZ/b/p4QkYGOt/cvMZQhunmZySPzhiOtOFGtirxQzLtgyTMplPVN90czdnEr34mnVoJrPeOTnm5R46MQdW6YrpjgPeMhBKYvLRjvyA6vJhbA9Jttm16SCRIdSh5TGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340615; c=relaxed/simple;
	bh=aBISMkyzcuXC4tndXkf0VYcmI9kprzzcj/ehlqHMdAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrJxc8VdFGc0tfJXf3KQviAC2BKw5mQ3bkbX6pT2yuBOOXbc9CNtxX62X/xLdXRGFosMuDgRZGbUBDfRdlsv/AkM3pGQhwPF6U4BTb7NVvpEzf7hL7vTpIO55dYyYh3TnRt8hVVX7o6L1fvJt0osuoQsgsEqoZ4uknNANYUvRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wV45Rr4v; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710340612;
	bh=aBISMkyzcuXC4tndXkf0VYcmI9kprzzcj/ehlqHMdAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wV45Rr4voGJHrKXICE5+Eye7hrS2Pjf//lLfPMsweUmrMtaGowHMg8I1ftEp0aoc6
	 vVBZcOLf4o11Mg5tTnufw6SyfR0TmnYh7euYN5U/mbmh4D+veduK3L1cVcQzJtfwf8
	 3xTrl9JpUKtiEXdqBnujwEENhAYfYbBGvY78+vuV4+LxRKjiguO64XhrhCNeecyRoN
	 QZR3ZhhDixM01wErO5qokiWMlKaRyx4SfSpnoi9s4eVgvGyGB75R5QPDv7h5kpVTPk
	 4auppMOqkpTTs4wsJ/OuuvWTViAs6wdbnrHFPzTu7gtp0SfvfQWyasvBTJhcjCEcls
	 O/G14egc519mg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9A15437813C4;
	Wed, 13 Mar 2024 14:36:51 +0000 (UTC)
Message-ID: <d1bdf9a6-3082-4076-99de-e49d59843244@collabora.com>
Date: Wed, 13 Mar 2024 15:36:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192-asurada: Update min voltage
 constraint for Vgpu
Content-Language: en-US
To: Pin-yen Lin <treapking@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 devicetree@vger.kernel.org
References: <20240313135157.98989-1-treapking@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240313135157.98989-1-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/03/24 14:51, Pin-yen Lin ha scritto:
> Although the minimum voltage listed on the GPU OPP table is 606250 uV,
> the actual requested voltage could be even lower when the MTK Smart
> Voltage Scaling (SVS) driver is enabled.
> 
> Set the minimum voltage to 300000 uV because it's supported by the
> regulator.
> 
> Fixes: 3183cb62b033 ("arm64: dts: mediatek: asurada: Add SPMI regulators")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Okay, that makes sense, I agree.

..but.

The datasheet never mentions 0.3V as vmin - infact, it does mention that the
vsel is selected as (0V +) 6250 * Vsel, but the brief spec says that for the
standard configuration (in terms of HW), the Vmin is 0.4V and not 0.3.

Reading through makes me think that it's not much about the buck providing an
unstable output, but more about it starting to become inefficient under that
value.

This means that it is sensible to set, instead:

	regulator-min-microvolt = <400000>;

Also, this is repeated on multiple platforms: can you please perform the same
change also on MT8183, MT8186 and MT8195?

P.S.: For MT6358, the Vmin for VGPU is 0.5V :-)

Cheers,
Angelo

> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> index 43d80334610a..5cc5100a7c40 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> @@ -1448,7 +1448,7 @@ regulators {
>   			mt6315_7_vbuck1: vbuck1 {
>   				regulator-compatible = "vbuck1";
>   				regulator-name = "Vgpu";
> -				regulator-min-microvolt = <606250>;
> +				regulator-min-microvolt = <300000>;
>   				regulator-max-microvolt = <800000>;
>   				regulator-enable-ramp-delay = <256>;
>   				regulator-allowed-modes = <0 1 2>;



