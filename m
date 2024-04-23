Return-Path: <linux-kernel+bounces-154774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458868AE0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9071F227C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4DE58234;
	Tue, 23 Apr 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Noqz7nUU"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7455579F;
	Tue, 23 Apr 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863773; cv=none; b=n5JrsZxiet78eoewKbvu+Qx/eDD5vivR48ajHe2o/mb4Ot2KKlzEgVf3ar4MW77bdYxYJrqTpg3RpUFM9+AXp1rVIPTpRJS4TAI2eB1MfWaHPGrNAM3zaWRtnr/lYCVS5vr9U8fUj/81snb1VsdTE3LE9XBrmfZOx+x53l3fWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863773; c=relaxed/simple;
	bh=rv0p/MWkAuT2vz1VMOmdFiPXoFuGDfYUuce8c41MYNg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OYvkKyk+0AUYEwUB5e0ISThKnYU8r3/Eb7jEPrwhAiyDTK/9Ldoj+IZ/5wlcKJjoaUkoR1ZKsaWJBQaslM22iAAUUQblIv67zvon515c8q3nqIrjL0xpWtzO9h5X+E+rQ0tn7VWbL13mIznzKOSyyOfj5BE8oQ3yJBoPEM+MaZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Noqz7nUU; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2FC3FF80D;
	Tue, 23 Apr 2024 09:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713863766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46+IHxai2w3bldZvmMzKkHuWZictfMvaorkaAyKmx7Y=;
	b=Noqz7nUU+wByDEgUUaUBJqb1Ue1br1avd+ELDCq7zip4RUr2JLl2RNYqMy4Q2q/6N861Pf
	1gvzDziUKUw2KbfagAYRF3swtyMahHqFVE4zIEYIdQljbTtoA/OkECdlLhgMr+YefZCaWm
	t9kYUcKAuta9PAFUHhb/mAO2vkoKNQybdzaTNi+2x99lKPiDp11A4GiLHU57IODB10+sJM
	6WleyMoDJQrBLg/xULjzaEck/JnkQRUYF2POX9ry691NnIMHpSBKp75fjrHv6hZB110New
	/Li99wTGVLBtQmuJRu7cRcMrVKwDbO4+p5zX9Is6DLAQTg9CiG3TLqiKnWBW/A==
Message-ID: <facb8204-c2b3-4084-a2e3-4fbf3a3fdc9d@arinc9.com>
Date: Tue, 23 Apr 2024 12:16:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Set PHY address of MT7531 switch to 0x1f on MediaTek
 arm64 boards
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com>
 <ff196055-ecd8-4563-bc01-ff2533a07109@arinc9.com>
 <a60fc16d-4236-427c-b4a8-ec6fdf62d9f0@arinc9.com>
Content-Language: en-US
In-Reply-To: <a60fc16d-4236-427c-b4a8-ec6fdf62d9f0@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 08/04/2024 10:22, Arınç ÜNAL wrote:
> On 31.03.2024 12:28, arinc.unal@arinc9.com wrote:
>> On 14.03.2024 15:20, Arınç ÜNAL via B4 Relay wrote:
>>> Hello.
>>>
>>> This is a small patch series setting the PHY address of MT7531 to 0x1f on
>>> all boards that have the switch.
>>>
>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>> ---
>>> Arınç ÜNAL (2):
>>>        arm64: dts: mediatek: mt7622: set PHY address of MT7531 switch to 0x1f
>>>        arm64: dts: mediatek: mt7986: set PHY address of MT7531 switch to 0x1f
>>>
>>>   arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
>>>   arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 4 ++--
>>>   arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 4 ++--
>>>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts             | 4 ++--
>>>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts             | 4 ++--
>>>   5 files changed, 10 insertions(+), 10 deletions(-)
>>> ---
>>> base-commit: ba90af39ba57b3fe3ecfdba0c87a80d20c7b788d
>>> change-id: 20240314-for-mediatek-mt7531-phy-address-9d0b4cfeca21
>>>
>>> Best regards,
>>
>> Reminder that this patch series is waiting.
> 
> Another reminder that this patch series is waiting to be applied.

Here's the third reminder for someone to apply this. From now on, I am
going to reply to this thread once every day until this patch series is
applied.

Arınç

