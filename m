Return-Path: <linux-kernel+bounces-126025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4462C89311B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 11:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AA328293E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A760757FF;
	Sun, 31 Mar 2024 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="SYbvsV0Q"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D468BE8;
	Sun, 31 Mar 2024 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711877300; cv=none; b=oIP4Q2rl9dtis1lUD7oVVd6aVZy3YZ5tUKDJgaWH4zMa1AypYlxifRmeIyZxGoxUJNFEh6azfA6xP8Q2kyGpZrsxpojxJpuwsnoXPvvs+MYcqn3pGOVW09eSKZfISRd/IriPo6CMZRlIL+iwl3lT+SQ5RCTsSwz0XmOiCs06Wig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711877300; c=relaxed/simple;
	bh=atHYMADKrIyGgNKWVLwIwluYpFa44DQ3VN+kH8YnIRk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Lh/Su0HJovMkTY7VKMVuYiAuO73CNLOp4Ha05gmJf76OYmaUTJSb/vpegZUyUZsAuuII5A6eCYxNXuc3R/6K5EMe+6owPAXkusiTzFKzke7xJeFQRbVa3oJpVuEUt0KaQgD75eVUK4pM4BeonKqdOdOXBCw/gwf+RtTBiL/pcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=SYbvsV0Q; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 088D240002;
	Sun, 31 Mar 2024 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1711877290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fryVNeKcFi90zGkyiXh+sDRmYe0qNq3h58tPTD/nTY=;
	b=SYbvsV0QOW5SIxArNvayTkUOk1Iu/7frW4lonHhDTt9QJbYqJjwak/raLpyUYHV9mYoVX+
	VSrTjlHuSWJIprEyNU3wP6MLKjsty5nII0og5SPfkenzTGwLrmCzE4nJnV+t5n2bJpIIep
	NgwWzc0MLvcN1VY4x0nE4DJKzkr9VtSpYWR6diqPfCEtu2s/PU85OgLxFn0M5XRtJTKRdS
	vgK4UjBWF+FF7wnKvTdUkOFXLpnTef8ChLPno3paxPaNsNB3FE2zTc5LK5qeh2AUDhAQpv
	IExxVs4vthw95Exeg8CZa5UwC5LMDnPWXDXu9uaPhO5TAuL6nJ1Rm61JMfgkqg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 31 Mar 2024 12:28:08 +0300
From: arinc.unal@arinc9.com
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/2] Set PHY address of MT7531 switch to 0x1f on MediaTek
 arm64 boards
In-Reply-To: <20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com>
References: <20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com>
Message-ID: <ff196055-ecd8-4563-bc01-ff2533a07109@arinc9.com>
X-Sender: arinc.unal@arinc9.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 14.03.2024 15:20, Arınç ÜNAL via B4 Relay wrote:
> Hello.
> 
> This is a small patch series setting the PHY address of MT7531 to 0x1f 
> on
> all boards that have the switch.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> Arınç ÜNAL (2):
>        arm64: dts: mediatek: mt7622: set PHY address of MT7531 switch 
> to 0x1f
>        arm64: dts: mediatek: mt7986: set PHY address of MT7531 switch 
> to 0x1f
> 
>   arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
>   arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 4 ++--
>   arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 4 ++--
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts             | 4 ++--
>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts             | 4 ++--
>   5 files changed, 10 insertions(+), 10 deletions(-)
> ---
> base-commit: ba90af39ba57b3fe3ecfdba0c87a80d20c7b788d
> change-id: 20240314-for-mediatek-mt7531-phy-address-9d0b4cfeca21
> 
> Best regards,

Reminder that this patch series is waiting.

Arınç

