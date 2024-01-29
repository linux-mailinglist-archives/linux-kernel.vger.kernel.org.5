Return-Path: <linux-kernel+bounces-43128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5F0840BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837241F25408
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625D315AAAC;
	Mon, 29 Jan 2024 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="asPnCp/H"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E387A15A4A7;
	Mon, 29 Jan 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546209; cv=none; b=qx/L1CBYOfxCDq1MvYIJETe+PpTM0z9uSCCoLcEULO0L6psVlcciRPpB6B9KB4kU3drChH2kWYA4Fy5IJiz3xyaLdPRcFzCTWMwEICmsglk5ARuLBw4m9WnCrGZwsf6rI4lnklcF+7wL5cAdfwn49cn7EUBhCil1B9Th4vZH6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546209; c=relaxed/simple;
	bh=KeRmE3stTSKqTV2GA+O/3KWIiAY8DmL3ppn/fIpoFW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIMvyhfG/Icc5KhP6qsKiJ4JOwe2he79E25vErEDpen4vpLL5TkH/CI7t5iugjOOPSUAUTXfINUWq5FHVPx/UFT4W7y6AG/o21UBZuo5D6a0ng87g/fn1tT3X5ds4iRxh7fbdA30+IT9u31VLsjPyxj6jUt4qDUC5wBb+fCnzJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=asPnCp/H; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706546205;
	bh=KeRmE3stTSKqTV2GA+O/3KWIiAY8DmL3ppn/fIpoFW4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=asPnCp/H8h6+VqbZ9tIYh5Vh4PY+FTVb/PmHnNL/1zsecKppZyoIPp6JiTq7LLyCY
	 DjSK1ST1Y8SghrKCQfbsE5r2QFu0gSpmvqzYdtw5wzzKN3mblPkrMoUTZwnS65X3aB
	 ndXrMWUF9aB1C8AhF3+RS4X1bEIZvOqQBFzIuYI8/mu4ICZ9gJZfhlDt84px+ixQ9+
	 bTXJSWaqccLPFvt8H+gTH/8Y0VE31bsGxo6K39iH4kQGSUGoIceR8cBndhMOySlwom
	 EuTIczHvBeR5nwOOVCcBK0ML05D5Tyt2GUrMuBEABJZyKVGCEqbp40RDeKN5AF5WQ3
	 pZiLyMHQIBeEg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E834137814A4;
	Mon, 29 Jan 2024 16:36:44 +0000 (UTC)
Message-ID: <627c9ff9-06b3-4735-92ea-8c0ecfc2faf6@collabora.com>
Date: Mon, 29 Jan 2024 17:36:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt8183-pico6: Fix bluetooth
 node
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, Chen-Yu Tsai <wenst@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240126063500.2684087-1-wenst@chromium.org>
 <20240126063500.2684087-3-wenst@chromium.org>
 <2c37a716-e4bb-4db3-a95f-a40e05b28cad@molgen.mpg.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <2c37a716-e4bb-4db3-a95f-a40e05b28cad@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 29/01/24 17:31, Paul Menzel ha scritto:
> Dear Chen-Yu,
> 
> 
> Thank you for your patch.
> 
> Am 26.01.24 um 07:34 schrieb Chen-Yu Tsai:
>> Bluetooth is not a random device connected to the MMC/SD controller. It
>> is function 2 of the SDIO device.
>>
>> Fix the address of the bluetooth node. Also fix the node name and drop
>> the label.
> 
> Excuse my ignorance: Is this a cosmetic fix or does it fix the device somehow?
> 
>> Fixes: 055ef10ccdd4 ("arm64: dts: mt8183: Add jacuzzi pico/pico6 board")
>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>> Changes since v1:
>> - Collected reviewed-by
>>
>>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts 
>> b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
>> index a2e74b829320..6a7ae616512d 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
>> @@ -82,7 +82,8 @@ pins-clk {
>>   };
>>   &mmc1 {
>> -    bt_reset: bt-reset {
>> +    bluetooth@2 {
>> +        reg = <2>;
> 
> To avoid confusion, would it be possible to use sdio as a “name”.
> 

Names must be generic and descriptive; this is the Bluetooth part of the MT7921s
hence it's called "bluetooth". If its functionality was "sdio", it'd be as such,
but this is BT anyway.

"sdio@xxx" would be applicable to, for example, a controller that provides support
exclusively for SDIO (with no support for eMMC/SD).

Regards,
Angelo



