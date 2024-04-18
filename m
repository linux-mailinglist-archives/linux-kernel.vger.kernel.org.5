Return-Path: <linux-kernel+bounces-149774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ACF8A95B5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B762CB21715
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F6015AAD3;
	Thu, 18 Apr 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jfcYy2i/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852C158DD5;
	Thu, 18 Apr 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431499; cv=none; b=rx8tHXey3MVm/sE7jFzWGwZjocmE5vWZu6rFMWhVjq7jfssvid3fDuDogyKeqUCadiXkFA9BiJMyuaa/w0COgA18VcW80XepAx4icvxFFnWqQECUl0p9iQl7lqx+wGjyDdiO0XhTrU4ekykyDDApcCfmqs6MI5mprXwSvXwbsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431499; c=relaxed/simple;
	bh=YQ9vfsRGkhEbPOmWURxpZsYHOlp6fTaTFgW6oeH82V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgIvFclQ+33/SMq9qcr3laQt3uXiJDoFAT2cZRhvNGalT026pZmesk33pS5a6Yn5Dzemhdktw9rSab1hsnJvnae0TWfeQ6Opj/vZaRKF5ZzMRc8HTRVJQ3EJ4R7MsNu3AqecoNg+YaDZnccsLxIAGH/BLR43i/dZtTTWuPALhHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jfcYy2i/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713431496;
	bh=YQ9vfsRGkhEbPOmWURxpZsYHOlp6fTaTFgW6oeH82V4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jfcYy2i/6n2qLpC6eIbBMym/USM1OFjmH4bFqlxZsr6sxzQ1ahI6TFrpcJuqNeptM
	 JcaHj1CQBNkSqgjpDGJhEPnzxPdIJ7822tHR74IMXuFxQDzU7b+WhiVUW2i7yGV5SV
	 2HW750fNTIeS7aNGdojbhWR36e0EuHIA3l0W9EUT2jr7JHbTrIJWRHK9kwYuvrViZq
	 d49CsrWQ2pLUp1EDLtp7sQZ/53stN5B8BWt1WZiWeK0fuH8WeEfLTMCZdK3SOVuYuf
	 LjM1lrOIecuVV9HgLbX+0cQ2gs9Cy/FtMUDN8I+yCmrPJ4xa11Y3DJ6GXT3/2QW/05
	 PI4vz51Gkp8vg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6B7B7378203F;
	Thu, 18 Apr 2024 09:11:35 +0000 (UTC)
Message-ID: <9fae0a42-76b8-4029-bd45-0cadd3b93464@collabora.com>
Date: Thu, 18 Apr 2024 11:11:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8395-genio-1200-evk: add u3port1
 for xhci1
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>, stable@vger.kernel.org
References: <20240216095751.4937-1-macpaul.lin@mediatek.com>
 <cdcadfdc-1861-b3b3-eafa-22071516197b@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <cdcadfdc-1861-b3b3-eafa-22071516197b@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/04/24 05:44, Macpaul Lin ha scritto:
> On 2/16/24 17:57, Macpaul Lin wrote:
>> This patch fixes an issue where xhci1 was not functioning properly because
>> the state and PHY settings were incorrect.
>>
>> The introduction of the 'force-mode' property in the phy-mtk-tphy driver
>> allows for the correct initialization of xhci1 by updating the Device Tree
>> settings accordingly.
>>
>> The necessary fixup which added support for the 'force-mode' switch in the
>> phy-mtk-tphy driver.
>> commit 9b27303003f5 ("phy: mediatek: tphy: add support force phy mode switch")
>> Link: https://lore.kernel.org/r/20231211025624.28991-2-chunfeng.yun@mediatek.com
> 
> Dear AngeloGioacchino,
> 
> Just a soft reminding about the patch has been sent a while back for the shared 
> U3PHY and PCIe PHY setup for genio-1200 boards. I'm not sure if you've missed this 
> patch in mail box. :)
> 
> The patch is pretty important as it lets the device tree (dts) decide whether to 
> enable U3PHY or PCIe PHY. Because this is a shared hardware phy and could only be 
> configured in dts to decide which function to be initialized, so it's something 
> that should be included in the board-specific dts files.
> 
> Do you think it needs to be resubmitted, or is it still in the queue for review? 
> It's meant to be ready for action from kernel version 6.8 onwards.
> 
> Looking forward to your thoughts on this. Let me know if there's anything else you 
> need from my side.
> 

As you can understand, I have to take care of many patches for each merge cycle,
and it may happen that inadvertently some patch goes out of my radar.

Please Macpaul, if this happens again, I appreciate that you remind me about
patches that I seem to leave behind, so please keep sending me such emails if
and when necessary.

Thanks!
Angelo

>> Prior to this fix, the system would exhibit the following probe failure messages
>> for xhci1:
>>    xhci-mtk 11290000.usb: supply vbus not found, using dummy regulator
>>    xhci-mtk 11290000.usb: uwk - reg:0x400, version:104
>>    xhci-mtk 11290000.usb: xHCI Host Controller
>>    xhci-mtk 11290000.usb: new USB bus registered, assigned bus number 5
>>    xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
>>    xhci-mtk 11290000.usb: can't setup: -110
>>    xhci-mtk 11290000.usb: USB bus 5 deregistered
>>    xhci-mtk: probe of 11290000.usb failed with error -110
>>
>> With the application of this dts fixup, the aforementioned initialization errors
>> are resolved and xhci1 is working.
>>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts 
>> b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> index 7fc515a07c65..e0b9f2615c11 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
>> @@ -854,6 +854,10 @@
>>   &u3phy1 {
>>       status = "okay";
>> +
>> +    u3port1: usb-phy@700 {
>> +        mediatek,force-mode;
>> +    };
>>   };
>>   &u3phy2 {
>> @@ -885,6 +889,8 @@
>>   };
>>   &xhci1 {
>> +    phys = <&u2port1 PHY_TYPE_USB2>,
>> +           <&u3port1 PHY_TYPE_USB3>;
>>       vusb33-supply = <&mt6359_vusb_ldo_reg>;
>>       status = "okay";
>>   };
> 
> Thanks
> Macpaul Lin




