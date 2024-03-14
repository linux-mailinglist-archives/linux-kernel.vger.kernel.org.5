Return-Path: <linux-kernel+bounces-103248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B887BCE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B60B21054
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2F158106;
	Thu, 14 Mar 2024 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Zy1zUE5W"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7598B51C49;
	Thu, 14 Mar 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419865; cv=none; b=SZdGW0olKgHvT1cUpwSImV0UiAWg7vOYTiMKj1kfJs7WOwBeyFSOYlyPTd3BxbH0dYc7qAlsuoJlpH+pbpBcH4bW0AHxhpiaFD0kmUj0oNkxR6WwpUfnzHQp0E9h7uuPXLo6aDgWTF6mwfJOEpNCF8YZ4PGqYuclhFO848FBlOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419865; c=relaxed/simple;
	bh=Z8cJyTYUV4aTS9G91QVSKjKFmtjxIQEC3j7bqhcW9Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pq0zIeEvL9W5vfY86qOEPa+lttuajo38GhUeRE0QBFON8KIaIcQElHVRy3YIXKm3VfPrJvo5Vz4HfUci9NfALJUOMq02E26k6cCl8HWzQcTOR6/4Qq6SAi4zo2YWn9nEMeetLHzMpurW/yzCqv974XmPivbZyqshHicZDoyJLnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Zy1zUE5W; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 305FC60006;
	Thu, 14 Mar 2024 12:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710419858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/peOBOnLsJGv1ihVaTFv7Ntt/VLBoWwY2pecEGf0v7c=;
	b=Zy1zUE5WNj30me+0vnKbflTH/h3Mx7DfSrQdmh/OlwgjRz6guFJpz5zDo6mdHj2YWymx7E
	nALZIKd+2Zw6tEn+N0zcsUcLCr2OjOjQQGP8TqkwZgkwm3RgxzViKo2mozGtSMHiw7RZpz
	gQ5Wh9O9VjUCU8jOUjonDaEwKdTvDNYbDZAgDd+0IrEc8rTC48ZNlmXX11xeDa5V7tqM3W
	INqoLgQ7voXnYIQNYWoPfDzjiQUWe5++2lVxe8A8EOrunaa9ZWxx66OyYv3fY2FmUbnV9V
	To3ECh0B5vbizAX5HXn0ZDLYklqcAjV1fNOTLM5RtjPObi+thVib6EqFWkX+ZQ==
Message-ID: <3eb63e39-c7f2-4411-bb84-e4c152be1f0c@arinc9.com>
Date: Thu, 14 Mar 2024 15:37:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: set PHY address of MT7531 switch to
 0x1f
Content-Language: en-US
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240314-for-rockchip-mt7531-phy-address-v1-1-743b5873358f@arinc9.com>
 <4682635.taCxCBeP46@diego>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <4682635.taCxCBeP46@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

Hello Heiko.

On 14.03.2024 15:31, Heiko Stübner wrote:
> Am Donnerstag, 14. März 2024, 13:24:35 CET schrieb Arınç ÜNAL via B4 Relay:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> The MT7531 switch listens on PHY address 0x1f on an MDIO bus. I've got two
>> findings that support this. There's no bootstrapping option to change the
>> PHY address of the switch. The Linux driver hardcodes 0x1f as the PHY
>> address of the switch. So the reg property on the device tree is currently
>> ignored by the Linux driver.
>>
>> Therefore, describe the correct PHY address on Banana Pi BPI-R2 Pro that
>> has this switch.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Fixes: c1804463e5c6 ("arm64: dts: rockchip: Add mt7531 dsa node to BPI-R2-Pro board")

Do I need to resubmit with this added, or would you add it while applying
the patch?

Arınç

