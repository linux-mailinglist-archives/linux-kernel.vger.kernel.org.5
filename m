Return-Path: <linux-kernel+bounces-134892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8853389B854
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5431C21EDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F31524B2F;
	Mon,  8 Apr 2024 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="hkS1kS6J"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530D2BAE1;
	Mon,  8 Apr 2024 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560993; cv=none; b=GKtlQOVliU7GTGACOD/Q8MqQ7kZyh+K75+8QP/K/OmgApO7T4Ftz1+HV0eNxHY+SWFeYzI0q7ptHkubyKuMVepDSSdDgkfcf13bsIYpSE6rARmeH/QEQuy+Ib8ac1bJlT4unlIBpEp5i9RqakVOzxpRVd6jyqqcp+elport8bfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560993; c=relaxed/simple;
	bh=OITXZGJUk5lrW7e6D5GKgTr7moJ2XzWLjdO75iL3o7s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P2mb0f30VXi0k7PjYYyArY4dER866oAfHWr9HmUznU+zHCbd45g9ldvO24eluoUakWcTy3+VkY0rqNJ9zFCjm/pvtc77GVtAoVlUQxb5SR5yVrNXP+VZmEmWtZHjqrygk8WFvCDvPOIe4bUaLYlgsA9/+ClsSKuikSkBkdb0rcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=hkS1kS6J; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75566E0006;
	Mon,  8 Apr 2024 07:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1712560982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyDYERK6l30+oDEBuARqGCRNtAGvvbmEpKNmF9iObNE=;
	b=hkS1kS6JejD8PCxzYAB99s8mrC/a2KTdaxqAII8bbnMJNBwsoOnoTHB1v63oUMItk8mXlF
	4VfQ0PfNZ1GbTUVHmuULqxkrLImkjASykz44FdUQAZNzbANm+c3xPs83O+7p7Tl0R+Lbx2
	1Lrp9U8Cbf0PjZSlTC2MG5wPub4FjnxuXI4c/oqykZ6iAD9kTJ44B9QyDkwpET2dHa9Oe4
	sw2Zb113De6qb8V9rN7xmjBCvEp1Wb1wSIwAek0LmZU4BD9sMOK829aaWGoSvxMC4Xk7Va
	EcVEKoRla575rGuzrF3FYcUH+NCSi7AvLfUOxqEYAux24d64pixQdnVqxxBMaA==
Message-ID: <a60fc16d-4236-427c-b4a8-ec6fdf62d9f0@arinc9.com>
Date: Mon, 8 Apr 2024 10:22:54 +0300
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
Content-Language: en-US
In-Reply-To: <ff196055-ecd8-4563-bc01-ff2533a07109@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 31.03.2024 12:28, arinc.unal@arinc9.com wrote:
> On 14.03.2024 15:20, Arınç ÜNAL via B4 Relay wrote:
>> Hello.
>>
>> This is a small patch series setting the PHY address of MT7531 to 0x1f on
>> all boards that have the switch.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>> Arınç ÜNAL (2):
>>        arm64: dts: mediatek: mt7622: set PHY address of MT7531 switch to 0x1f
>>        arm64: dts: mediatek: mt7986: set PHY address of MT7531 switch to 0x1f
>>
>>   arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
>>   arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 4 ++--
>>   arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 4 ++--
>>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts             | 4 ++--
>>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts             | 4 ++--
>>   5 files changed, 10 insertions(+), 10 deletions(-)
>> ---
>> base-commit: ba90af39ba57b3fe3ecfdba0c87a80d20c7b788d
>> change-id: 20240314-for-mediatek-mt7531-phy-address-9d0b4cfeca21
>>
>> Best regards,
> 
> Reminder that this patch series is waiting.

Another reminder that this patch series is waiting to be applied.

Arınç

