Return-Path: <linux-kernel+bounces-74508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47C285D546
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C391C229E4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E015E3D577;
	Wed, 21 Feb 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4sDG00bU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691F3D39A;
	Wed, 21 Feb 2024 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510514; cv=none; b=L3it+AT5hcy3pS6yIrVr8Pwton5Rk4aHybxpaZYh7oIUdclnuK1q+5wDphdGnNjy3fiisanG9ahh9zQeUr3/tXDLv8YzrBYSvHoWgPrM6UpZqRbloz/eZJXnVsnP7kJ7GlyhoYRH1WWTcOcizHO4VK6HTHn0XeweoNS4fN3H19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510514; c=relaxed/simple;
	bh=/OBK/vPgAEGePwGQU9P8QRYiaWDf258P929gH0+KqMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBFhMXBMKwXYtyKW83Xj2a8/sZTmmbCoHIBs2hHU2AkD7Mzn/aN4o72QqRuwNBAHLu4FlY/ZetJrut7IqcWwh7HkRsc72sTOGt5p4XBzQXGFwPhRQLAGU1cg0HiLh7mE429EfvF4Qr2RYvTRpefrfKccvp2Okz86OdXlfZHzIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4sDG00bU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708510511;
	bh=/OBK/vPgAEGePwGQU9P8QRYiaWDf258P929gH0+KqMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=4sDG00bUo4bLREuLVu8MVnI8BgzUcOe14r2DO+FerX22OHmUS71JMJilatztYGiss
	 5J8/ZIlVXu/7ZzjnsvR3ovj05O8pNxHb3CdkwSL+DgrId3FtbQaSm/9qr0FW621Z0s
	 kKRTLPF/9HudJR1ydgNAgB8t1R4ZdbBJdR+ECsDACnV1LGooEfA+Z8/wEHeqqyzgrc
	 Aj8FY/LtbG3DzCO7cRAOmCM78zvf2YANdkBf177BRL0um2kn8A5Cp0v+j8yWE73g7x
	 gWFp09E+wpESw+eBksRFCshNiEAb1y0E3IMYWHHZIKI5pAszABWlNvaxQ1PcQ+8RqQ
	 pksGJHs+w79aQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4C25C37820C9;
	Wed, 21 Feb 2024 10:15:10 +0000 (UTC)
Message-ID: <d5535a86-17d6-40c1-ae8e-df9fc0425866@collabora.com>
Date: Wed, 21 Feb 2024 11:15:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt7981: add watchdog & WiFi
 controllers
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240221085547.27840-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240221085547.27840-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/02/24 09:55, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7981 (Filogic 820) is a low cost version of MT7986 (Filogic 830) with
> the same watchdog controller. It also comes with on-SoC 802.11ax
> wireless.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



