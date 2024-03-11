Return-Path: <linux-kernel+bounces-98712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA22877E51
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54111F214CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB65938FB6;
	Mon, 11 Mar 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ATIYZUqh"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706742E410;
	Mon, 11 Mar 2024 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153909; cv=none; b=BTj7QGpOvcXsGU6XeaiCzOdxBz9ZY+WbAN83MVmRFE8kOVOXBbWML3jB4ScAvLNYt8JQX8pIxwvD8rO1TcGjMuwoIYa7AXkUX0R4ddov5R+qRWBTuec00eaJh7mmqqyFsnAe7ScXvQJvtBC5ZBXx28ouoJvntsEaIf+L70XDBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153909; c=relaxed/simple;
	bh=WrbwWD64V4NOfPkPm3GizaWD64FSlu+yEQ1HOGnLdCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ki1BqYp79611dcHkHs/6Ed1bR0i8rWO9/kjZZuWmvW+hye8mYMT64ZVukU3qeRp6ed21SObUk81usWrxP+btH9jSTFDgLoJ6Ojl2FDNzHTyRtR95zuQh1ncyklgFKtGAZc2BBOU2ZXrWPA2Vc16NE8Jo5WoUfMSFIwTzNJ2n/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ATIYZUqh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710153905;
	bh=WrbwWD64V4NOfPkPm3GizaWD64FSlu+yEQ1HOGnLdCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ATIYZUqhE0Y6GACEs8aEzAE32w5BtbEnMutK6Ff0O4F9+2U9fYByYCHvtQXoZwOTI
	 rJKQ9iU0FkY6GIH02fONVcBr29xXVlE2ddhrL5k/Vy8Ii9DfKR6fpeZIjDUVWrlKXy
	 2ar7C6dtTdAJEhyBLOJuUXaIGxqI15fjjVsJC8ldmuc3Pq6qj3/voYluLuFN8owS4m
	 leNqdnduF5GlAifd6RoytTnkmNem1zNpZ7Z0ivc5nlv/VJYeUHFYzesfNlQgSJbIFc
	 +I7vTUMaQUsu1aR1C0Bat+J9WGTtSi2SXWHnRbSQ4fi23l5TspfoX+RVOAbb8bM6QJ
	 kxm6DNT3D/0uA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0C7E53781FD3;
	Mon, 11 Mar 2024 10:45:04 +0000 (UTC)
Message-ID: <7692ec9b-52d2-4bae-a9af-a7a695b4e8f4@collabora.com>
Date: Mon, 11 Mar 2024 11:45:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: mediatek: add Kontron 3.5"-SBC-i1200
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240221155905.1217340-1-mwalle@kernel.org>
 <20240221155905.1217340-2-mwalle@kernel.org>
 <CZQSEKZ288OL.205CBK4EC7G2J@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CZQSEKZ288OL.205CBK4EC7G2J@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/03/24 09:44, Michael Walle ha scritto:
> Hi,
> 
> On Wed Feb 21, 2024 at 4:59 PM CET, Michael Walle wrote:
>> Add basic support for the Kontron 3.5" single board computer featuring a
>> Mediatek i1200 SoC (MT8395/MT8195).
>>
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
> 
> Any feedback on this? Should I repost after the merge window or is
> it fine as it is for now?
> 

My feedback is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

..and no there's no need to repost after the merge window, at least, I'm not picky
about that.

Though, if I ever forget about this one for *whatever reason*, please feel free to
ping me or Matthias about it and we will make sure to pick it up.

Cheers!
Angelo

> -michael
> 
>> ---
>> v3:
>> - add vsys regulator
>> - correct the LDO input of the mt6360 regulator
>> - add missing interrupt-cells
>> - no underscores in node names
>> - dropped regulator-compatible everywhere and use the correc node name
>>    instead
>> - reordered mmc0 properties
>> - split mmc1 pinctrl properties, add no-mmc
>> - removed all MTK_DRIVE_8mA
>> - add i2c0 and i2c1
>> - add comments for spi and i2c busses
>> - add firmware-name property for scp (this should probably go into the
>>    base dtsi?!)
>> - add missing tpm compatible
>> - renamed thermal zones to something more meaningful
>> - add correct bias-pull-up to (some) i2c busses
>> - moved reset handling into the PHY node, also added a compatible string
>>    for the PHY.
>>
>> Mh, my memory is hazy, but IIRC I run into the same problem which was
>> discussed on netdev some time ago. That is, the PHY driver cannot be
>> probed unless it is taken out of reset. Which will only happen if you
>> probe it. And the workaround/advise was to use the compatible string in
>> that case, which is unfortunate.
>> Just wanted to point out, that it is *not* the same as snps,reset-*
>> because the latter will work just fine without the compatible. I'll
>> go with the compatible for now.
>>
>> I did *not* add the vbus to the USB ports, not even on the front port.
>> That is because of:
>>    dependencies:
>>      connector: [ usb-role-switch ]
>> and we just have a simple USB3.2 USB-A connector, no dual roles. IMHO
>> that is a bug in the driver, which should handle the vbus supply as
>> optional.
>>
>> v2:
>> - none



