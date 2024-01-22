Return-Path: <linux-kernel+bounces-32802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2930836039
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4E9289462
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EFC3A8C6;
	Mon, 22 Jan 2024 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cYEV9FRW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D616439;
	Mon, 22 Jan 2024 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921211; cv=none; b=A0hwMJvQGbDOeD+/t4+YmRersm1VjnhzueAc3LhujW/b2CKdCB2XV2o2BxNu921LPvnc5ea7O+xse7UVrfh7EqKbRmxzuDG1FHaHWW35Ugdr3xb/z5TrzW3fPLU4M+S/Jqz4VogmpTzb9Xo+YyulqDsaCEPvdZqqhL/sgYIn0Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921211; c=relaxed/simple;
	bh=G6ENMbYnSExmBsiKgUE0XhOt+HRgA6TcZEvQKVF8gYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnwYnc8yEey1oNiQfoe66nmlQBv92Y76nvgcKld80XN0vv1xAE3csrWeH0fROp7vVeTRnaYcPSdHjU3gMyQeQPa2rhDUuhhr05Bl3Tdm9NH3i5Rd2tSxyCSoi/cn3AZS8jX7uGyLTmrEqfHqFLcJrUw4vWMm1iZ7I6SNOGvyyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cYEV9FRW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705921208;
	bh=G6ENMbYnSExmBsiKgUE0XhOt+HRgA6TcZEvQKVF8gYI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cYEV9FRWZv8f/lwYnr1LE0PtXwV207uuNisL4vf0YddAd0RXp9RHIaf4/q/wCjtbU
	 FpV8G8RlBORFfIcTuP9PQuqDPg7R4hvv80O9bWsBOFFfutvgLvOJOxxsqNKUi0QUZ8
	 nFM1eza4JYtCyjVwSkYtNgDsmUOuEOxJJNcTe86FXUkHGTYoag+8ANXsHSYmPL6qPN
	 LgnKUB1Kb5BVP9JKW5fCFqAcb2a5xB6W+dsWZ/28tqIKK3WXGgTt3CvgM35UdYyrsm
	 jB+Szy8JSGGNe/OvQwDibrr2pcqeExSJ/JUKQBSQmEKV6trMa5MzqsCWqTfEocXr/X
	 MYq3Tl12vQK0w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E8A613781FDF;
	Mon, 22 Jan 2024 11:00:07 +0000 (UTC)
Message-ID: <2f8d6e4e-ba01-4a87-94d6-65421db765ed@collabora.com>
Date: Mon, 22 Jan 2024 12:00:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: mtu3: Add MT8195 MTU3 ip-sleep wakeup support
Content-Language: en-US
To: Matthias Brugger <matthias.bgg@gmail.com>, chunfeng.yun@mediatek.com
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240112133222.240038-1-angelogioacchino.delregno@collabora.com>
 <20240112133222.240038-2-angelogioacchino.delregno@collabora.com>
 <5bf2910f-c184-4681-a474-69bea8ee7b71@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <5bf2910f-c184-4681-a474-69bea8ee7b71@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 22/01/24 08:58, Matthias Brugger ha scritto:
> 
> 
> On 12/01/2024 14:32, AngeloGioacchino Del Regno wrote:
>> Add support for the ip-sleep wakeup functionality on the three MTU3
>> controllers found on the MT8195 SoC.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/usb/mtu3/mtu3_host.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
>> index 9f2be22af844..85f49e00e8db 100644
>> --- a/drivers/usb/mtu3/mtu3_host.c
>> +++ b/drivers/usb/mtu3/mtu3_host.c
>> @@ -34,6 +34,19 @@
>>   #define WC0_SSUSB0_CDEN        BIT(6)
>>   #define WC0_IS_SPM_EN        BIT(1)
>> +/* mt8195 */
>> +#define PERI_WK_CTRL0_8195    0x04
>> +#define WC0_IS_P_95        BIT(30)    /* polarity */
>> +#define WC0_IS_C_95(x)        ((u32)(((x) & 0x7) << 27))
>> +#define WC0_IS_EN_P3_95        BIT(26)
>> +#define WC0_IS_EN_P2_95        BIT(25)
>> +#define WC0_IS_EN_P1_95        BIT(24)
> 
> Not used, shouldn't we drop that?
> 

Hey Matthias!

Thanks for catching that - yeah that bit exists, but cannot be used in MTU3, so
it has to be dropped.

Sending a v2 in a jiffy....... or two. :-)

Cheers,
Angelo

> Regards,
> Matthias
> 
>> +
>> +#define PERI_WK_CTRL1_8195    0x20
>> +#define WC1_IS_C_95(x)        ((u32)(((x) & 0xf) << 28))
>> +#define WC1_IS_P_95        BIT(12)
>> +#define WC1_IS_EN_P0_95        BIT(6)
>> +
>>   /* mt2712 etc */
>>   #define PERI_SSUSB_SPM_CTRL    0x0
>>   #define SSC_IP_SLEEP_EN    BIT(4)
>> @@ -44,6 +57,9 @@ enum ssusb_uwk_vers {
>>       SSUSB_UWK_V2,
>>       SSUSB_UWK_V1_1 = 101,    /* specific revision 1.01 */
>>       SSUSB_UWK_V1_2,        /* specific revision 1.02 */
>> +    SSUSB_UWK_V1_3,        /* mt8195 IP0 */
>> +    SSUSB_UWK_V1_5 = 105,    /* mt8195 IP2 */
>> +    SSUSB_UWK_V1_6,        /* mt8195 IP3 */
>>   };
>>   /*
>> @@ -70,6 +86,21 @@ static void ssusb_wakeup_ip_sleep_set(struct ssusb_mtk *ssusb, 
>> bool enable)
>>           msk = WC0_SSUSB0_CDEN | WC0_IS_SPM_EN;
>>           val = enable ? msk : 0;
>>           break;
>> +    case SSUSB_UWK_V1_3:
>> +        reg = ssusb->uwk_reg_base + PERI_WK_CTRL1_8195;
>> +        msk = WC1_IS_EN_P0_95 | WC1_IS_C_95(0xf) | WC1_IS_P_95;
>> +        val = enable ? (WC1_IS_EN_P0_95 | WC1_IS_C_95(0x1)) : 0;
>> +        break;
>> +    case SSUSB_UWK_V1_5:
>> +        reg = ssusb->uwk_reg_base + PERI_WK_CTRL0_8195;
>> +        msk = WC0_IS_EN_P2_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
>> +        val = enable ? (WC0_IS_EN_P2_95 | WC0_IS_C_95(0x1)) : 0;
>> +        break;
>> +    case SSUSB_UWK_V1_6:
>> +        reg = ssusb->uwk_reg_base + PERI_WK_CTRL0_8195;
>> +        msk = WC0_IS_EN_P3_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
>> +        val = enable ? (WC0_IS_EN_P3_95 | WC0_IS_C_95(0x1)) : 0;
>> +        break;
>>       case SSUSB_UWK_V2:
>>           reg = ssusb->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
>>           msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;




