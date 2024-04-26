Return-Path: <linux-kernel+bounces-159973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87AE8B3700
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB55B20FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46E0145B09;
	Fri, 26 Apr 2024 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="jUAcl225"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12D2144D12;
	Fri, 26 Apr 2024 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133782; cv=none; b=AR9OYl9SYUGFuOOMCt72pEO6/UNeSIWM2LztZxZRXBhLanb23ajGEB1M/byIxkJBFH/isK2fzRstOVtM5Xx5GIi/geBxYh7o3f902rMxARaQpWZ2h9+G6GgJoRmqsWCFLZm3tK7ZlJ+j5Ty0R5eA5FLca+xGlf7bO80VLCLf9Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133782; c=relaxed/simple;
	bh=UMlQaK/5MNgWMKRYoDEUTT/B1NefwRCqD1vtAVtPAsY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eZS4ur0lV39Y1+wVLptpTq6RORGYeMlaLsUvIATZn2PAYeI0CE9EGL3QUr/xhPScN5Dn8NVEhe1S3WV894RZwlV8LieGEtibcaO2mjtgGMAgeY8pk5coMbH3NGxS18F3EBD6PR09UlB42ePaNdXV8EzLIQrLI4zZdJlozndFozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=jUAcl225; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 677131BF203;
	Fri, 26 Apr 2024 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1714133776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKKtm36SBTWsbDXzRyPwPacxtTX+fdl2bBrbOBDwJoM=;
	b=jUAcl225gOyeJ08AulAYmoy2CFU+zi+HTn0Njr2U5MjRjPgTzeGSPgV5kMX9NQ0q3ipbdN
	kwO2c/cq0yHvyWt1nVOx0r2P0NwSgn0Uz8mvnsiXzkOXcw20WTfEXQXDHL+pW8LPStfetd
	422bbzHf7xIhCyMDZjZa6jHgSPPH/hCQIf/CfK6HxxPiqtDlBu3DCPzpa8wBCmTUtFVH9k
	A4dSJotdzHs7Czt41crDAPrFDF1mTrRKmb2fgnybIopJJTw+EQ6JCFcp/pwNUEc9zTFL2V
	TydqSpE1FxZNkXf+OXkiS392iMHiKPid4fsK2JtzIva5tNivT+/9f50Jy1l/7Q==
Message-ID: <44e366ea-964a-4515-9027-2a2edfe12512@arinc9.com>
Date: Fri, 26 Apr 2024 15:15:51 +0300
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
 <facb8204-c2b3-4084-a2e3-4fbf3a3fdc9d@arinc9.com>
Content-Language: en-US
In-Reply-To: <facb8204-c2b3-4084-a2e3-4fbf3a3fdc9d@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 23.04.2024 12:16, Arınç ÜNAL wrote:
> On 08/04/2024 10:22, Arınç ÜNAL wrote:
>> On 31.03.2024 12:28, arinc.unal@arinc9.com wrote:
>>> On 14.03.2024 15:20, Arınç ÜNAL via B4 Relay wrote:
>>>> Hello.
>>>>
>>>> This is a small patch series setting the PHY address of MT7531 to 0x1f on
>>>> all boards that have the switch.
>>>>
>>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>> ---
>>>> Arınç ÜNAL (2):
>>>>        arm64: dts: mediatek: mt7622: set PHY address of MT7531 switch to 0x1f
>>>>        arm64: dts: mediatek: mt7986: set PHY address of MT7531 switch to 0x1f
>>>>
>>>>   arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
>>>>   arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 4 ++--
>>>>   arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 4 ++--
>>>>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts             | 4 ++--
>>>>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts             | 4 ++--
>>>>   5 files changed, 10 insertions(+), 10 deletions(-)
>>>> ---
>>>> base-commit: ba90af39ba57b3fe3ecfdba0c87a80d20c7b788d
>>>> change-id: 20240314-for-mediatek-mt7531-phy-address-9d0b4cfeca21
>>>>
>>>> Best regards,
>>>
>>> Reminder that this patch series is waiting.
>>
>> Another reminder that this patch series is waiting to be applied.
> 
> Here's the third reminder for someone to apply this. From now on, I am
> going to reply to this thread once every day until this patch series is
> applied.

Fourth.

Arınç

