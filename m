Return-Path: <linux-kernel+bounces-80986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E35866EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42891C214E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE348657BC;
	Mon, 26 Feb 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1GZ852FN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A34657A9;
	Mon, 26 Feb 2024 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937797; cv=none; b=ERFn1h+tpV28LqbWbCp1yPj+beA8ojwt+uT+fAM2B0RPsM12IiZaynceIZiRSI/Veuu3TCgDjpPNKy96V/S1tUcAQugpG9urMJUm1RIkODTjieqktS+7103GHfawWhv64Gg/IVc2HzDuGkWjdNVXwv6cnRzPNXafnLN/1eIL/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937797; c=relaxed/simple;
	bh=NtluJuvOx4HWb8QYTDVkRwb3/l9Jxvrl3zQKPftAdX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcKAm/jsEEQXxBcS4KHw6hkEJFNuhOfCefkG/7LGhzcc0GO/S2SV61hkAeYWAc0IoK1Hs2sNCH2VTwIX2LRZqWSkGZKynzaC8/xfU0umrpE1sKtPBL+cZfgFUj9vezzYjK2HrSA57sD1uenzmGcHtaJutLy2PdeYhje/sxiZ+6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1GZ852FN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708937794;
	bh=NtluJuvOx4HWb8QYTDVkRwb3/l9Jxvrl3zQKPftAdX4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1GZ852FNOMnr/PS0M0RdA4DNl2DVu0NYwUjbmRcrgfff5YshOTxkSKY2zYA4GouuZ
	 es/4h7tohQjegewUxeHx1JpC6WBEPT5hAUKvzQd2a4k4THNfyXsANv8FrcMTEfKGWl
	 CiZ1KrBlrEXKpL/zZZJagNlB765etcchPShYmkGMfLwPbL2+C80k4KyqbMuwuAne1z
	 m63StaV6/JofaEcUCPnBtA14i3MrzInzyPqsFPEb8VbuvE7ej/eguKFHsPZO6VgtD/
	 1uBgXzelU/H2gBKGgt+ciIGEWA50gc+yR5mOeoFEi+WZWML5bNaR1y85I+SeufRgZl
	 m8G+WtvW7uazg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0B6973781183;
	Mon, 26 Feb 2024 08:56:32 +0000 (UTC)
Message-ID: <70cda6ba-b6d4-4343-9afd-2a1978150f84@collabora.com>
Date: Mon, 26 Feb 2024 09:56:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/4] arm64: dts: mediatek: mt7981: add pinctrl
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sean Wang
 <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240223101709.30072-1-zajec5@gmail.com>
 <20240223101709.30072-4-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240223101709.30072-4-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/02/24 11:17, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7981 contains on-SoC PIN controller that is also a GPIO provider.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



