Return-Path: <linux-kernel+bounces-61290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB50D85106A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B34D1F21F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D541817C9B;
	Mon, 12 Feb 2024 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P0qqR1sT"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0458617C62;
	Mon, 12 Feb 2024 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732943; cv=none; b=Pa+v8ANBCAzuvTIld93FsAUMl7J5X9clNJy2i6tBYHsf5Kvef0jdWwS0pGPllVXtzUIhuwq6vPVvi01k1MDXXyYmyUO5mYU/90IchrcXAPEzeBeErAeCXPNsLghmagaVq6oFLctQ5amx7WpPgceGQ0fPyLNgVFqyw81EYxI9dy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732943; c=relaxed/simple;
	bh=aWKumoUsnscxzWmRBBruu38aTkpW/6wtp1LS7OGgMAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpSlXJaJZg/1N2NZQ9v2ShoA4SASYC/vtBvCDmWHTKgHCx3asF18aOtyTPU8NKX6rsGPi8cKsA/cY+5IZrSA18ngpSak3fuLK4+yZ1xJehAzM7YK9XrBiR0vztZgVHcNQKUdQ4PvZPsjobtgLQJUWlpUytJUDu91vf/fTUEqHjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P0qqR1sT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707732938;
	bh=aWKumoUsnscxzWmRBBruu38aTkpW/6wtp1LS7OGgMAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P0qqR1sTaF7VRE4oZDxUbbSZhjzbzSQNkl8wxSvIRvLwuKOIUZaKQvgvtwBosYtT+
	 nySK3K590Oq1EOMq8ldDOZoSM/lkJ7ofumXXfOwLTBSXR/vP+W4DX7MEgny6Akx8Kf
	 Kdo8J5Lr9tkjSxFLQWRdigLz6/g68/Pp0CAiv07/ylymT3D1k+wAOZr+6GZoqGYt4w
	 GTpjMU7N3q8wD6oCJ9Hay7QL2JaYbRxVEwgJ1w2KV9jQUQleQajBxnr2zn/D83PzT4
	 U8EhZsk2xc9SDH4PdBo43l9W9ZMEl/5rAVSAJ/gfP+PSju+W2DD/U2ui7Jhq31bt5G
	 AGVbTBbKkNvyQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 259AC3780029;
	Mon, 12 Feb 2024 10:15:38 +0000 (UTC)
Message-ID: <6ccaba64-4bbe-4710-9fee-eaf31c0485b8@collabora.com>
Date: Mon, 12 Feb 2024 11:15:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] usb: mtu3: Add MT8195 MTU3 ip-sleep wakeup support
Content-Language: en-US
To: =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20240122111809.148546-1-angelogioacchino.delregno@collabora.com>
 <20240122111809.148546-2-angelogioacchino.delregno@collabora.com>
 <0f96aac2ee16c31808f22853fdf746678f5284e8.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <0f96aac2ee16c31808f22853fdf746678f5284e8.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/02/24 07:03, Chunfeng Yun (云春峰) ha scritto:
> On Mon, 2024-01-22 at 12:18 +0100, AngeloGioacchino Del Regno wrote:
>> Add support for the ip-sleep wakeup functionality on the three MTU3
>> controllers found on the MT8195 SoC.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>
>> Changes in v2:
>>   - Dropped unused definition for WC0_IS_EN_P1_95
>>
>>   drivers/usb/mtu3/mtu3_host.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/usb/mtu3/mtu3_host.c
>> b/drivers/usb/mtu3/mtu3_host.c
>> index 9f2be22af844..7c657ea2dabd 100644
>> --- a/drivers/usb/mtu3/mtu3_host.c
>> +++ b/drivers/usb/mtu3/mtu3_host.c
>> @@ -34,6 +34,18 @@
>>   #define WC0_SSUSB0_CDEN		BIT(6)
>>   #define WC0_IS_SPM_EN		BIT(1)
>>   
>> +/* mt8195 */
>> +#define PERI_WK_CTRL0_8195	0x04
>> +#define WC0_IS_P_95		BIT(30)	/* polarity */
>> +#define WC0_IS_C_95(x)		((u32)(((x) & 0x7) << 27))
>> +#define WC0_IS_EN_P3_95		BIT(26)
>> +#define WC0_IS_EN_P2_95		BIT(25)
>> +
>> +#define PERI_WK_CTRL1_8195	0x20
>> +#define WC1_IS_C_95(x)		((u32)(((x) & 0xf) << 28))
>> +#define WC1_IS_P_95		BIT(12)
>> +#define WC1_IS_EN_P0_95		BIT(6)
>> +
>>   /* mt2712 etc */
>>   #define PERI_SSUSB_SPM_CTRL	0x0
>>   #define SSC_IP_SLEEP_EN	BIT(4)
>> @@ -44,6 +56,9 @@ enum ssusb_uwk_vers {
>>   	SSUSB_UWK_V2,
>>   	SSUSB_UWK_V1_1 = 101,	/* specific revision 1.01 */
>>   	SSUSB_UWK_V1_2,		/* specific revision 1.02 */
>> +	SSUSB_UWK_V1_3,		/* mt8195 IP0 */
>> +	SSUSB_UWK_V1_5 = 105,	/* mt8195 IP2 */
>> +	SSUSB_UWK_V1_6,		/* mt8195 IP3 */
>>   };
>>   
>>   /*
>> @@ -70,6 +85,21 @@ static void ssusb_wakeup_ip_sleep_set(struct
>> ssusb_mtk *ssusb, bool enable)
>>   		msk = WC0_SSUSB0_CDEN | WC0_IS_SPM_EN;
>>   		val = enable ? msk : 0;
>>   		break;
>> +	case SSUSB_UWK_V1_3:
>> +		reg = ssusb->uwk_reg_base + PERI_WK_CTRL1_8195;
>> +		msk = WC1_IS_EN_P0_95 | WC1_IS_C_95(0xf) | WC1_IS_P_95;
>> +		val = enable ? (WC1_IS_EN_P0_95 | WC1_IS_C_95(0x1)) :
>> 0;
>> +		break;
>> +	case SSUSB_UWK_V1_5:
>> +		reg = ssusb->uwk_reg_base + PERI_WK_CTRL0_8195;
>> +		msk = WC0_IS_EN_P2_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
>> +		val = enable ? (WC0_IS_EN_P2_95 | WC0_IS_C_95(0x1)) :
>> 0;
>> +		break;
>> +	case SSUSB_UWK_V1_6:
>> +		reg = ssusb->uwk_reg_base + PERI_WK_CTRL0_8195;
>> +		msk = WC0_IS_EN_P3_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
>> +		val = enable ? (WC0_IS_EN_P3_95 | WC0_IS_C_95(0x1)) :
>> 0;
>> +		break;
>>   	case SSUSB_UWK_V2:
>>   		reg = ssusb->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
>>   		msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;
> 
> which project will use ip-sleep wakeup for mt8195? only use device
> mode?
> 
> As I know, when use upstream code to support dual-role mode on mt8195,
> there is a bug caused by hw limitation;
> 
> 

This is required because:
  1. The device tree nodes for MT8195 were wrong (now they're correct), as in,
     there are three MTU3 controllers that must be described, as the device tree
     provides a description of the hardware, not a partial description of whatever
     one machine wants to use; and
  2. When the description of the hardware in DT is correct, even if Chromebooks are
     declaring dr_mode = "host", the IP sleep must come from MTU3 - otherwise there
     will be issues when trying to enter system sleep (as the system will be woken
     up immediately after trying to go to suspend); and
  3. Upstream does support the Genio 1200 EVK, and I'm also introducing a new board
     that is similar to that (Radxa NIO12L).

Besides, which bug are you talking about?

At least on Chromebooks, everything seems to be working just fine; maybe that's
because, on Cherry, dr_mode is forced to host.

Regards,
Angelo

