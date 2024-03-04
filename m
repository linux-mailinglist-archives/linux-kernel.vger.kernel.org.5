Return-Path: <linux-kernel+bounces-90401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861D186FEAF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238751F22FCF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22AB3D96E;
	Mon,  4 Mar 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0QaBuOXA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829232CCAD;
	Mon,  4 Mar 2024 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547163; cv=none; b=RWUhzHFtbqziEfVSIZ9vl0MAQtiNFQP8DHovs3dEuHAvTcEFUFmD4FB+jJVxVT9onrOmy8jWnWwAc0BEZDyutrnZpF34l86awByzyTKdiFVH8r3dwvrJBbdFJNUFKmQe3Co/HC+FXG37s47Xb0cO4YvQR4EL0d7EPLNw3NcM/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547163; c=relaxed/simple;
	bh=iSC1NqRF1tB2WZkEVyJwSFBOpjJCHARvCNJh7jbFeMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfAiLS2CYxu7Ir+unc+KwwfNvxpBPqLohfi7avTUtOHum3YvyFp25xSbiWfmTy3Nyp+OgR4KGQg2wH5CPNbdJq3MOmaKFTdZgi7SjUk0k1XKnEjcvWrvunB7/LMzO50RnczgiDYU3f+bx8GouCCu3dZqGWNJT2uqQYu42+Rd3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0QaBuOXA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709547159;
	bh=iSC1NqRF1tB2WZkEVyJwSFBOpjJCHARvCNJh7jbFeMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0QaBuOXA3RlOVN5YhCbuGI1iZs/JOdSHwsklwe52AHu1oRuPfzl1IDQELeB/Kn6EY
	 7WzqzIZIybovqikWEa9aGIyU41tp+jTZxJJPKNiQxOsT22/j2Eanghw04+PCObnsy0
	 8G14V3oAcE1Rk5LE9RsM8TvYCNn9PuIZCcjYnpg8UpZ2mHHx9yw9pIPl6QVzKC9o/D
	 bpd9dNf8jn8GWzLG3twZ3ng9tlDgFKpE18cowtDnCkZLY1T3nWOWPb/hGnqEr6lgXC
	 BgqSJA1a1O/oN01TJua8tcid0cKs6mutj3zKdc+SEvBXL5fyAo2vqwowQuZPiLjF3N
	 OzqgEZVsGSrjw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 19A7A378143B;
	Mon,  4 Mar 2024 10:12:39 +0000 (UTC)
Message-ID: <33145efb-b13c-4a1c-9542-9a185fca7b01@collabora.com>
Date: Mon, 4 Mar 2024 11:12:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: mt7622: fix IR nodename
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240301113506.22944-1-zajec5@gmail.com>
 <20240301113506.22944-3-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301113506.22944-3-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/03/24 12:35, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Fix following validation error:
> arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: cir@10009000: $nodename:0: 'cir@10009000' does not match '^ir(-receiver)?(@[a-f0-9]+)?$'
>          from schema $id: http://devicetree.org/schemas/media/mediatek,mt7622-cir.yaml#
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Is this an IR receiver, an IR transmitter or a xceiver?

While we're fixing that node name, we might as well increase readability of (and
somewhat implicitly document) this.

.. so, that might be...:

ir-receiver@xxxxx {
...

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 283fdf7d2d8b..7714775d1bd0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -252,7 +252,7 @@ scpsys: power-controller@10006000 {
>   		clock-names = "hif_sel";
>   	};
>   
> -	cir: cir@10009000 {
> +	cir: ir@10009000 {
>   		compatible = "mediatek,mt7622-cir";
>   		reg = <0 0x10009000 0 0x1000>;
>   		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_LOW>;



