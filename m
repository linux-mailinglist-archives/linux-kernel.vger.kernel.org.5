Return-Path: <linux-kernel+bounces-63183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8F6852C04
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29671F254F0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E84822319;
	Tue, 13 Feb 2024 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="y3/SvmFT"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8872208E;
	Tue, 13 Feb 2024 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815495; cv=none; b=mW8bxb9r/q+6EdGB5LUL5KxAjcxXYGhTZp87rv9nFeEFzjd5XwelK2FjjC/15ET//fP4VZDDRL5i9KdNmjOxOYtsW0eUCe3ht9YU3dOSubwz/bo+jC9afFfr0dIoR9iXt1tQfvvEuXLtKALx8inQOPMymg8mnX8LfUGMTXiJOeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815495; c=relaxed/simple;
	bh=9knv+ODPdDJCuZiyTJw6oxKEkgd2kVoris7GQl7tfmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M82dEXdkF0Gpg+NU+gHCK2rw8efUDivdsGYJu5zg6SOvMrxuwbqwjnGrcXOPFe+bs3OAv1pH9X1rHWdoPOdYl486/GEkO2RvXqxC4qQisINbBLTiit/AoDkd7MdQddjP+j1coaQ3+aOVdDcsqY3wGF4opgG/cFE+4K6ksb0iVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=y3/SvmFT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707815492;
	bh=9knv+ODPdDJCuZiyTJw6oxKEkgd2kVoris7GQl7tfmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=y3/SvmFTdf2l5qEhn9PHwYdshIWEor+YHOecyE4Dl1L60lJC3BmxG1wgZqYOB/C46
	 FeTF8rFnpwEhTIFWyd2g+xZPI/VQYB+EYLUWw5Yv3ILrsQtSGT5+v8oOV18X8S7kyd
	 C/K+rugmFEX2HkkNDUZUsbTKGPIekpUBl2hjCYlZdMVp1v4wLSKsJn6h44rgIMPIzT
	 Krh/x0zxozFpfbufTtxxI8Uqt1BsWQUo5PHROhlx8SgabK4MURIzMfqI5uKEGkVoS0
	 7XRxqCVrP4nNpnVcl23YJOR80Eds3xR1cEsyO8i1XSI9Jn47fbmg7V10QGIZKVn2//
	 0Y+0bC8YPcoKQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5627B3781FEF;
	Tue, 13 Feb 2024 09:11:31 +0000 (UTC)
Message-ID: <a99af719-4b2c-4c38-830e-b49a89971cb1@collabora.com>
Date: Tue, 13 Feb 2024 10:11:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt7986: drop invalid thermal
 block clock
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Sam Shih <sam.shih@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Daniel Golle <daniel@makrotopia.org>,
 Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240213053739.14387-1-zajec5@gmail.com>
 <20240213053739.14387-3-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240213053739.14387-3-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/02/24 06:37, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Thermal block uses only two clocks. Its binding doesn't document or
> allow "adc_32k". Also Linux driver doesn't support it.
> 
> It has been additionally verified by Angelo by his detailed research on
> MT7981 / MT7986 clocks (thanks!).
> 
> This fixes:
> arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: thermal@1100c800: clocks: [[4, 27], [4, 44], [4, 45]] is too long
>          from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
> arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: thermal@1100c800: clock-names: ['therm', 'auxadc', 'adc_32k'] is too long
>          from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
> 
> Fixes: 0a9615d58d04 ("arm64: dts: mt7986: add thermal and efuse")
> Cc: Daniel Golle <daniel@makrotopia.org>
> Link: https://lore.kernel.org/linux-devicetree/17d143aa-576e-4d67-a0ea-b79f3518b81c@collabora.com/
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



