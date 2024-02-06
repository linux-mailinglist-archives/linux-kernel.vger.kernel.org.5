Return-Path: <linux-kernel+bounces-54589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0705084B146
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF99A281E6C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CE512D144;
	Tue,  6 Feb 2024 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="x+EkDser"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5212D151;
	Tue,  6 Feb 2024 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211722; cv=none; b=SRTR+yIg6t8bTGxlpNfAT9wrfnMU18nvtt69Pqb11phH9+DKuiGg1f1ns8CjauQoBgN/GKyPcuCRLnDV6ZLfpfh1LGkbr2p/k/iP+uIijcyfibRgnn31IEjzRyL/6wtOXfu7fckrqmQ2cNyKkQBf09NuvrdaXx5vRZV9GaWqbs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211722; c=relaxed/simple;
	bh=2Xrzre9dmcGOoIHcHGMvLHKHKLzHYCWIXe840+0qVeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=btXhNrl+O4kQQiBCOw/FFHnrh/OyMdmlXBcUVHNCRNlOyZUr/V6euw0sRm0vu3M6MfIWA+sLTS7Ym7YdeWkJ+LdGkTqU3ZDw9PDHy9QSl9AQ0uvZ8e3HhQbzrDx6ItwFPavy4dIAhY6HtDL32UaNcNCv4LfEomtF3rx4uK2oYyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=x+EkDser; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707211719;
	bh=2Xrzre9dmcGOoIHcHGMvLHKHKLzHYCWIXe840+0qVeQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=x+EkDserXeZIDx38jSRNE1m5SBpssqP7OemvhDAealPBtoDg/7KRAi0mLRnQ09oj3
	 Awzrne9T9AA3bpqNmjyvbSt94DaMPvVgysDgCbL8ZkB+wz5CJnsl1jdqmBUUVK7HwO
	 4nMlEaZCfYd0NS/TarfVpqURG6zdGli5mq240MD1bMJzQZW6rhOmac/fCCMcZpW8Qf
	 iTqfHsMtWtpEi9epF2Ji5auQTAvgA9J2JRKZF7wfXuy7Ua+0F9zpL1SB+ypCrEsTk4
	 /8q4aTGrOha+feqIsXNDTx4WOVxbenIXuOItHIy5j1GCArn+LIHfZ+QB5JpzbutXhj
	 ikgZF19ksZe3w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A7DD3782039;
	Tue,  6 Feb 2024 09:28:38 +0000 (UTC)
Message-ID: <98c6c8ae-f7cf-4e5d-895a-18cb2dcc5d35@collabora.com>
Date: Tue, 6 Feb 2024 10:28:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek,mt7988-xfi-tphy: add
 new bindings
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Qingfang Deng <dqfext@gmail.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <3251ac3db1a739e0c18ded0a824edae981c1e2df.1707153425.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <3251ac3db1a739e0c18ded0a824edae981c1e2df.1707153425.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/02/24 18:28, Daniel Golle ha scritto:
> Add bindings for the MediaTek XFI Ethernet SerDes T-PHY found in the
> MediaTek MT7988 SoC which can operate at various interfaces modes:
> 
> via USXGMII PCS:
>   * USXGMII
>   * 10GBase-R
>   * 5GBase-R
> 
> via LynxI SGMII PCS:
>   * 2500Base-X
>   * 1000Base-X
>   * Cisco SGMII (MAC side)
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



