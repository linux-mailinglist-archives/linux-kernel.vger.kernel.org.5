Return-Path: <linux-kernel+bounces-163528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2A88B6CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34FF1F233A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D9854905;
	Tue, 30 Apr 2024 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fW57j2P2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C9346551;
	Tue, 30 Apr 2024 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465029; cv=none; b=YSePFQhaifUZmZD/hcgMq7GXnr7Mf9ivOSebPceqfQQwj9GkHtoDnUJhUZoO8380UkoN8fGt0bZ33X5ruv/bqmgXeIPOFWVfEZRtstd9Wh84NHEXD3RE0Cg0/PBXgc3FTnwkoLEsK+cJTsaeCKQ18YzVejpn8z14HZUzGiQjwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465029; c=relaxed/simple;
	bh=YiqPXDGuBJ9ChCHuLfO5SZxskbmlZQtPZtwhXVSn32Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZ2lHQnBG7vBty/CldY/4k/nM5k29mQXmtjA7TAWLrxfhpfDNLrPCJjhH2wReqJqfER+S3Hegr1X+SNfxK6nrMY9YEPPdhYxZ1trYxi22W1ndpfg6bvoNj9cxfrI6e0cmhFqqc5TRVEC0Ue6z5jf6kOuH56nmroerIjrSItbiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fW57j2P2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714465026;
	bh=YiqPXDGuBJ9ChCHuLfO5SZxskbmlZQtPZtwhXVSn32Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fW57j2P2O3Z+7aEhUtDF2jmZ1Kp4MjGO34GUw7v8M7qlscjAQD8DLyxvBZ30CLiMe
	 bkoo5irtEB8p1ZL1xZtYLsQJXCWreJtRxyhUjIIKzBg4wjHyqw5ioTGK+oH7XxGa9T
	 3S7tWy8Yr9BPAEYCjcMsjblhhZ4MxXAv6Ljo8DqqPCjMLnhRlIQjSz39Hs/ILpOFHf
	 6IiPK37h9Bj5Bp31Aei5UioFpuQ3lhjM4vw68UDxcGQkUjA7pamvfj8TDfUCVLDEfM
	 ezfLq41ahK0JQ9zsDMMw/EpwnASuEXCcQmGXhzpE8GolwV0oDOuK80Vsqg0szww558
	 IiSTvoS3S+GbA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3BDDF378134F;
	Tue, 30 Apr 2024 08:17:06 +0000 (UTC)
Message-ID: <b3c69a78-78c9-4a15-829b-e4b36e16566a@collabora.com>
Date: Tue, 30 Apr 2024 10:17:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192-asurada: Add off-on-delay-us
 for pp3300_mipibrdg
To: Pin-yen Lin <treapking@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
 Hsin-Te Yuan <yuanhsinte@chromium.org>
References: <20240429095333.3585438-1-treapking@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240429095333.3585438-1-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/04/24 11:53, Pin-yen Lin ha scritto:
> Set off-on-delay-us to 500000 us for pp3300_mipibrdg to make sure it
> complies with the panel sequence. Explicit configuration on the
> regulator node is required because mt8192-asurada uses the same power
> supply for the panel and the anx7625 DP bridge. So powering on/off the
> DP bridge could break the power sequence requirement for the panel.
> 
> Fixes: f9f00b1f6b9b ("arm64: dts: mediatek: asurada: Add display regulators")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 

Uhm, there might be more to it - I don't think that this should ever happen.

The regulator is refcounted, so...
  * Bridge on: panel goes off, but regulator doesn't turn off (refcount=1)
    * Panel resume -> sequence respected (refcount=2 -> wait -> more vregs, etc)
  * Bridge off: panel is already off (refcount=0)
    * Bridge resume -> refcount=1, no panel commands yet
    * Panel resume -> refcount=2, wait -> more vregs, etc

Can you please describe the issue that you're getting?

Cheers,
Angelo

> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> index 7a704246678f..08d71ddf3668 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> @@ -147,6 +147,7 @@ pp3300_mipibrdg: regulator-3v3-mipibrdg {
>   		regulator-boot-on;
>   		gpio = <&pio 127 GPIO_ACTIVE_HIGH>;
>   		vin-supply = <&pp3300_g>;
> +		off-on-delay-us = <500000>;
>   	};
>   
>   	/* separately switched 3.3V power rail */


