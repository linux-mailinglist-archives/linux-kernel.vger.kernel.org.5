Return-Path: <linux-kernel+bounces-63185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBE7852C08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B011F2201D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC5622606;
	Tue, 13 Feb 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VFNbAmdX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C557F2231C;
	Tue, 13 Feb 2024 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815498; cv=none; b=HS5T19dMDMu4H1xNJg0KQ4hWZW7VbE8pvxV1KQstqaHUhxW0J8JYD0ZlELkt1WVimeZzu0whH++LiFgkWguhR6PGDhfZw9Zwtj+CcMGaIvxCk2xmQUhYna8Y35uVjAIMQqylPWQF6EaZhoZBvi51NZeTmeIicAo1g9JvwTp1ryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815498; c=relaxed/simple;
	bh=ndqYmeV6A7b8wwtcMLEgfQaIjNxznoUbQ2OiauorsUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTfimoOjbAo1CPXYHQT/21kiTVozhjoBULWn5jUtpVQC/OGuQj/uKAZ5503LhHHZ2ga1KH32SLm0okyMZyfa7+l/1KsscCmKcO509azCQLEp5gkdmXhTiyhgq9q09dYuWdcYBV0QrVbDQ5ioSe+RFdb389Zoj5o+NjRS/CCsmVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VFNbAmdX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707815495;
	bh=ndqYmeV6A7b8wwtcMLEgfQaIjNxznoUbQ2OiauorsUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VFNbAmdXYnSU7RJeTXfc2p0xK2QlMFrboEiAnzkmNckehmgpiOI3z6XEJrbzSHktf
	 xpBl4hGBbpCayUB1XmPI4g2AKGvIWv/Y4QvNk+7Pc3LP25YlTWTZU7QGLmqNTVE7GQ
	 HNSvsqD13ZZ+6Dl/dxXH/2a5YF9spIMEER4Bkn2AcaUbNFUlXEh8qjdSs40tECYw3U
	 MGtzyyvZmz8NMeIAWUqI0pyEbA1bxEMWruGoaR3JwNrPt5R9iGQ6pwgDkI9myk8wF5
	 pugekqlBqMovfS34ISfgoHxi7/uch1T98U98xgqi3hOyeoQVHUtpxF1EeyHeMQckSB
	 PXuaDqUkrHkBg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1170C3782073;
	Tue, 13 Feb 2024 09:11:34 +0000 (UTC)
Message-ID: <af0bda0a-2c8c-49ea-8e62-b6674b671a2f@collabora.com>
Date: Tue, 13 Feb 2024 10:11:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: mediatek: mt7986: drop invalid properties
 from ethsys
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240213053739.14387-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/02/24 06:37, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Mediatek ethsys controller / syscon binding doesn't allow any subnodes
> so "#address-cells" and "#size-cells" are redundant (actually:
> disallowed).
> 
> This fixes:
> arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: syscon@15000000: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
>          from schema $id: http://devicetree.org/schemas/clock/mediatek,ethsys.yaml#
> 
> Fixes: 1f9986b258c2 ("arm64: dts: mediatek: add clock support for mt7986a")
> Cc: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



