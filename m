Return-Path: <linux-kernel+bounces-55016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D6E84B650
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2854BB277AB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7807F130E47;
	Tue,  6 Feb 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iYWDzEEn"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654612FF97
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226036; cv=none; b=Z+XUfnpH+rPD5ReZ4GGAe2iAa8P3uZdikB2aSWmHousNJkjZ/DuN3smZGb1DZZK3WifTtWUY3A+sswv2V2Imz+vYPCsETYXQ6v+l64Trtp4wIBekmoSGGUHnlUEyAfIuYreOnfDaHD+lNTj+lXEmyVxrcW6D1xWgGYlEZih4G0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226036; c=relaxed/simple;
	bh=hQ+QP63TDympmBm6f1787+x8JkcNvVe7bh5SVgAcn5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBo8/3iZPyjpWz1O0Ox0wtLt/2fawRVb4JowkpAxHI+YYEK+gLkeOxXfIv3kg8OMEQTb+4zf8cST8QIM9m78zNEPdEvLSlCEarXKS/cfbF5wYBY/aw4gSjocsnnCYOartMhz2BrWmSnn2HR9bO7ZHe/zWHrNILz9zqkCLiWdod0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iYWDzEEn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707226033;
	bh=hQ+QP63TDympmBm6f1787+x8JkcNvVe7bh5SVgAcn5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iYWDzEEnv1nWRcUIeci/q5vSYZZ9aUERduKYgiTOqA/Kd60fzZRLg84hRqzdEewZh
	 ZFSXZPdOHreGQCVnMMudxUFLJuT/6V+AA7WialF6TuGeV0lUtV5I4f1m0k12ipSrSJ
	 pzlUIjNbWWX2NDZSwoXRuOZqLwWhQ8Kc90oohMV+Qw8dXBoD/1ZDLkiv1WuR6vBw6y
	 L63+4nUOmSSH4qTZlG76DWRn81skPu0ZaCKYI2MclYNREMPdHmOjc06yGoWq8UZi93
	 I+KNZaAEroMP2M5BNfaCtvpHpZuNUQQGoidab5TVMPXbcp1k+dgsoRF2fXCWfbjzdU
	 i4HRrDMGCssEg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 69A233782072;
	Tue,  6 Feb 2024 13:27:12 +0000 (UTC)
Message-ID: <4fe9947f-b190-4dcc-8d1e-f532e6dcb827@collabora.com>
Date: Tue, 6 Feb 2024 14:27:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] drm/mediatek: dsi: Use GENMASK() for register mask
 definitions
Content-Language: en-US
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20240131113434.241929-1-angelogioacchino.delregno@collabora.com>
 <20240131113434.241929-2-angelogioacchino.delregno@collabora.com>
 <082bc4d9efd0746d7ec25eab0b3bf96018e997e5.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <082bc4d9efd0746d7ec25eab0b3bf96018e997e5.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 06/02/24 09:57, CK Hu (胡俊光) ha scritto:
> Hi, Angelo:
> 
> On Wed, 2024-01-31 at 12:34 +0100, AngeloGioacchino Del Regno wrote:
>> Change magic numerical masks with usage of the GENMASK() macro
>> to improve readability.
>>
>> While at it, also fix the DSI_PS_SEL mask to include all bits instead
>> of just a subset of them.
>>
>> This commit brings no functional changes.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_dsi.c | 45 +++++++++++++++-------------
>> --
>>   1 file changed, 23 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index a2fdfc8ddb15..3b7392c03b4d 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -58,18 +58,18 @@
>>   
>>   #define DSI_TXRX_CTRL		0x18
>>   #define VC_NUM				BIT(1)
>> -#define LANE_NUM			(0xf << 2)
>> +#define LANE_NUM			GENMASK(5, 2)
>>   #define DIS_EOT				BIT(6)
>>   #define NULL_EN				BIT(7)
>>   #define TE_FREERUN			BIT(8)
>>   #define EXT_TE_EN			BIT(9)
>>   #define EXT_TE_EDGE			BIT(10)
>> -#define MAX_RTN_SIZE			(0xf << 12)
>> +#define MAX_RTN_SIZE			GENMASK(15, 12)
>>   #define HSTX_CKLP_EN			BIT(16)
>>   
>>   #define DSI_PSCTRL		0x1c
>> -#define DSI_PS_WC			0x3fff
>> -#define DSI_PS_SEL			(3 << 16)
>> +#define DSI_PS_WC			GENMASK(14, 0)
>> +#define DSI_PS_SEL			GENMASK(19, 16)
> 
> The original definition of DSI_PS_WC/DSI_PS_SEL is correct in MT8173.
> So both need two definition and let each SoC select its own definition.
> 

The additional bits are unused on older SoCs and, if set, will be simply ignored;
if we want to prevent setting bits that don't exist on the old ones, that should
be done as a later commit introducing SoC capabilities for those and when the new
capabilities for the new SoCs are introduced anyway.

As of now, this doesn't break anything.

Regards,
Angelo



