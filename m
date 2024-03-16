Return-Path: <linux-kernel+bounces-105111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75C787D93B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10D71C210D1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E38EAE4;
	Sat, 16 Mar 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="dltSEBiz"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31B1FBB;
	Sat, 16 Mar 2024 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710575044; cv=none; b=KnBT9AzR/aTPb26Lr6LO0cCNMEPT+UTznUT5dBIVIPS1q504bq5WLsoYAJdbGhzK6ood/MVzV5e6xq6716YetFurfQ2agJT+Z4/EnBklZYSI9Bx65rTJfdXRK97+uL0nxw4o5kXkW3wiGWPx3gvfNLf+voBUp7+kqsbcD7OWqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710575044; c=relaxed/simple;
	bh=SifCYBjprJRgThxFtpLvOKz2DSDgwa+1PQlpfweXXOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktFdyDRXmh71x3uutLuCwGv3mSPTaU26eBYSNRhCs5gjZ5oFze0OnWU4Q0YCVltOZlE19WdeDx1JvNbAtHcAYkMjguR9ZOHdGmzNwPoD7jy31EyHHXzBhxTuRI+CfwsqjRrcJsmJC8yn1DdAM1cyhuZ4mu+uzG8g0ZA81cbuIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=dltSEBiz; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C10871BF205;
	Sat, 16 Mar 2024 07:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710575039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaudTAjS9OrEf75WKlKVQeii/UQ8YYZCZtk03/a+WxE=;
	b=dltSEBizU1EpLVCl+E4/7gIDVn4aC38LqlKKoOfbKy4KSCUbSZvOiLfWaS6Upo8L8LPUv5
	A+n49OslfLhrEaS8wYrWEpPq88iV5rfvEVFFmB7XgXghHlJYlxfk3MpoXjCbieBiJGqOwM
	Sb6zS/xAcjc2hETJmsU4ulGGCBhaLMCdl47QUJtAmtD5Ee/uWS9fpxfmPZZHzb20YVLgY1
	VYR1Lrh+kXPWvDKL9R0evcy9z2eMdCRnXqBnx8aMx4uiLgcFwDNPdyNvuAcYq/NA39dwnA
	7sBoFpoLaSiGwSRhrtZvqTJNeWPb8lZeFhQsIa2reWZPocEDimQnAte2EzFJvA==
Message-ID: <62d128f1-11ac-4669-90ff-e9cdd0ec5bd9@arinc9.com>
Date: Sat, 16 Mar 2024 10:43:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt7622: set PHY address of
 MT7531 switch to 0x1f
To: Florian Fainelli <f.fainelli@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com>
 <20240314-for-mediatek-mt7531-phy-address-v1-1-52f58db01acd@arinc9.com>
 <94e3d09a-e6a4-4808-bc29-3f494b65e170@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <94e3d09a-e6a4-4808-bc29-3f494b65e170@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 15.03.2024 20:26, Florian Fainelli wrote:
> On 3/14/24 05:20, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> The MT7531 switch listens on PHY address 0x1f on an MDIO bus. I've got two
>> findings that support this. There's no bootstrapping option to change the
>> PHY address of the switch. The Linux driver hardcodes 0x1f as the PHY
>> address of the switch. So the reg property on the device tree is currently
>> ignored by the Linux driver.
>>
>> Therefore, describe the correct PHY address on boards that have this
>> switch.
> 
> Can we call it a pseudo PHY to use a similar terminology as what is done through drivers/net/dsa/{bcm_sf2,b53}*?
> 
> This is not a real PHY as in it has no actual transceiver/digital signal processing logic, this is a piece of logic that snoops for MDIO transactions at that specific address and lets you access the switch's internal register as if it was a MDIO device.

I can get behind calling the switch a psuedo-PHY in the context of MDIO.
However, as described on "22.2.4.5.5 PHYAD (PHY Address)" of "22.2.4.5
Management frame structure" of the active standard IEEE Std 802.3™‐2022,
the field is called "PHY Address". The patch log doesn't give an identifier
as to what a switch is in the context of MDIO. Only that it listens on a
certain PHY address which the term complies with IEEE Std 802.3™‐2022.

So I don't see an improvement to be made on the patch log. Feel free to
elaborate further.

Arınç

