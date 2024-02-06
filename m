Return-Path: <linux-kernel+bounces-54764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8732784B368
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05C11F2436A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA5312F392;
	Tue,  6 Feb 2024 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e5f64p7g"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13212D74F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218695; cv=none; b=YyI4c5HybOeJbREQbqKeF5uuuQPXS+ghcmrKImi0yDIjy+uIwOJnz+Jvw6/qMvvz2+lVGMYbllCqJpaIdOkqiXZWNodwcGxJMoj8Jtk11SqVu4QdC+dc/vUtYWY1cKM+QlPIM3AEuh8T0JplRjfEgT3GJI+6fkVgsz1bhIfhXwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218695; c=relaxed/simple;
	bh=W9eVxM9U4SL9Oval+gIwwmjbVA2ob2C9cUlB+OFaVvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYm2ms0u1DXg2xg2tMBDX/nqyUtIlepVK0wDz5dFf7XhoZ1vpBocvUnER8f8xLGBR2bZpkG/fktRUZ54NwuBbEq7uB2wg0wHFKzW2xX3HPYucz0v1MMZAY4OrQpvAflUkfsaafAuEm4bURThkgABqhkmBETHcY8n2q7WAG7qGkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e5f64p7g; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707218691;
	bh=W9eVxM9U4SL9Oval+gIwwmjbVA2ob2C9cUlB+OFaVvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e5f64p7gND16GTg1YhhbvoMrXWlljuooWsiJ1nAVQstieLhpfDpYss7vxXOCcukp9
	 bqU3DHZiB5K9jtpWwUdjLDLQGvncm2gGYIW7qoWVJ3kczytkd/NusXDThTFNngZp2C
	 6gu6gCU1OTL1tRKVsuaEprn48G5HRMYgzKz4+Mp3pdAwRXXz7SSSAi0gA88P1SjDGT
	 f8MNgqJ4ZcxRnET/5TnaWwoGVWOBD9Dfk4Leilb9+nL314aoIJg1rqOraAU3+qX6a+
	 pJ4/SDii/b/xKagaKT1GzoTzdvUAM08ExKWQKtN6dKtQIzROnYqJGBROW5tfzIj5Kr
	 aKdW8EzqnJTtw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E37003781F8E;
	Tue,  6 Feb 2024 11:24:50 +0000 (UTC)
Message-ID: <1d6b4a7d-4107-4880-858a-ecd565eee124@collabora.com>
Date: Tue, 6 Feb 2024 12:24:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] drm/mediatek: dsi: Cleanup functions
 mtk_dsi_ps_control{_vact}()
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
 <20240131113434.241929-3-angelogioacchino.delregno@collabora.com>
 <14e124f02d82ff151974f99d042c4197e4dd5dd7.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <14e124f02d82ff151974f99d042c4197e4dd5dd7.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 06/02/24 10:50, CK Hu (胡俊光) ha scritto:
> Hi, Angelo:
> 
> On Wed, 2024-01-31 at 12:34 +0100, AngeloGioacchino Del Regno wrote:
>> Function mtk_dsi_ps_control() is a subset of
>> mtk_dsi_ps_control_vact():
>> merge the two in one mtk_dsi_ps_control() function by adding one
>> function parameter `config_vact` which, when true, writes the VACT
>> related registers.
>>
>> Reviewed-by: Fei Shao <fshao@chromium.org>
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_dsi.c | 76 +++++++++-------------------
>> --
>>   1 file changed, 23 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index 3b7392c03b4d..8414ce73ce9f 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -351,40 +351,6 @@ static void mtk_dsi_set_vm_cmd(struct mtk_dsi
>> *dsi)
>>   	mtk_dsi_mask(dsi, DSI_VM_CMD_CON, TS_VFP_EN, TS_VFP_EN);
>>   }
>>   
>> -static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
>> -{
>> -	struct videomode *vm = &dsi->vm;
>> -	u32 dsi_buf_bpp, ps_wc;
>> -	u32 ps_bpp_mode;
>> -
>> -	if (dsi->format == MIPI_DSI_FMT_RGB565)
>> -		dsi_buf_bpp = 2;
>> -	else
>> -		dsi_buf_bpp = 3;
>> -
>> -	ps_wc = vm->hactive * dsi_buf_bpp;
>> -	ps_bpp_mode = ps_wc;
>> -
>> -	switch (dsi->format) {
>> -	case MIPI_DSI_FMT_RGB888:
>> -		ps_bpp_mode |= PACKED_PS_24BIT_RGB888;
>> -		break;
>> -	case MIPI_DSI_FMT_RGB666:
>> -		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
>> -		break;
>> -	case MIPI_DSI_FMT_RGB666_PACKED:
>> -		ps_bpp_mode |= LOOSELY_PS_18BIT_RGB666;
>> -		break;
>> -	case MIPI_DSI_FMT_RGB565:
>> -		ps_bpp_mode |= PACKED_PS_16BIT_RGB565;
>> -		break;
>> -	}
>> -
>> -	writel(vm->vactive, dsi->regs + DSI_VACT_NL);
>> -	writel(ps_bpp_mode, dsi->regs + DSI_PSCTRL);
>> -	writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);
>> -}
>> -
>>   static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
>>   {
>>   	u32 tmp_reg;
>> @@ -416,36 +382,40 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi
>> *dsi)
>>   	writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
>>   }
>>   
>> -static void mtk_dsi_ps_control(struct mtk_dsi *dsi)
>> +static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool
>> config_vact)
>>   {
>> -	u32 dsi_tmp_buf_bpp;
>> -	u32 tmp_reg;
>> +	struct videomode *vm = &dsi->vm;
>> +	u32 dsi_buf_bpp, ps_wc;
>> +	u32 ps_bpp_mode;
>> +
>> +	if (dsi->format == MIPI_DSI_FMT_RGB565)
>> +		dsi_buf_bpp = 2;
>> +	else
>> +		dsi_buf_bpp = 3;
>> +
>> +	ps_wc = vm->hactive * dsi_buf_bpp;
>> +	ps_bpp_mode = ps_wc;
>>   
>>   	switch (dsi->format) {
>>   	case MIPI_DSI_FMT_RGB888:
>> -		tmp_reg = PACKED_PS_24BIT_RGB888;
>> -		dsi_tmp_buf_bpp = 3;
>> +		ps_bpp_mode |= PACKED_PS_24BIT_RGB888;
>>   		break;
>>   	case MIPI_DSI_FMT_RGB666:
>> -		tmp_reg = LOOSELY_PS_18BIT_RGB666;
>> -		dsi_tmp_buf_bpp = 3;
>> +		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
>>   		break;
>>   	case MIPI_DSI_FMT_RGB666_PACKED:
>> -		tmp_reg = PACKED_PS_18BIT_RGB666;
>> -		dsi_tmp_buf_bpp = 3;
>> +		ps_bpp_mode |= LOOSELY_PS_18BIT_RGB666;
> 
> You change the original logic here. If it is a fixup, separate to a
> independent patch not hiding in a clean up patch. So we could backport
> the fixup patch.
> 

Thank you CK! Thanks to you noticing that, I've discovered that actually
besides the two functions not agreeing on the bit to set, the definitions
of those bits are actually wrong (as you can verify on datasheets for
multiple SoCs, including MT8195, MT8188, MT8186, MT8183).

v4 will fix that by adding a fixup commit to rectify the whole thing.

Cheers,
Angelo

> Regards,
> CK
> 
>>   		break;
>>   	case MIPI_DSI_FMT_RGB565:
>> -		tmp_reg = PACKED_PS_16BIT_RGB565;
>> -		dsi_tmp_buf_bpp = 2;
>> -		break;
>> -	default:
>> -		tmp_reg = PACKED_PS_24BIT_RGB888;
>> -		dsi_tmp_buf_bpp = 3;
>> +		ps_bpp_mode |= PACKED_PS_16BIT_RGB565;
>>   		break;
>>   	}
>>   
>> -	tmp_reg += dsi->vm.hactive * dsi_tmp_buf_bpp & DSI_PS_WC;
>> -	writel(tmp_reg, dsi->regs + DSI_PSCTRL);
>> +	if (config_vact) {
>> +		writel(vm->vactive, dsi->regs + DSI_VACT_NL);
>> +		writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);
>> +	}
>> +	writel(ps_bpp_mode, dsi->regs + DSI_PSCTRL);
>>   }
>>   
>>   static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>> @@ -521,7 +491,7 @@ static void mtk_dsi_config_vdo_timing(struct
>> mtk_dsi *dsi)
>>   	writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
>>   	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
>>   
>> -	mtk_dsi_ps_control(dsi);
>> +	mtk_dsi_ps_control(dsi, false);
>>   }
>>   
>>   static void mtk_dsi_start(struct mtk_dsi *dsi)
>> @@ -666,7 +636,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>>   	mtk_dsi_reset_engine(dsi);
>>   	mtk_dsi_phy_timconfig(dsi);
>>   
>> -	mtk_dsi_ps_control_vact(dsi);
>> +	mtk_dsi_ps_control(dsi, true);
>>   	mtk_dsi_set_vm_cmd(dsi);
>>   	mtk_dsi_config_vdo_timing(dsi);
>>   	mtk_dsi_set_interrupt_enable(dsi);



