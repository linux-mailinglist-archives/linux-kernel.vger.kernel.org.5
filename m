Return-Path: <linux-kernel+bounces-46282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94B3843D70
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843E628F1A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0BC76047;
	Wed, 31 Jan 2024 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R/Bapetf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F36D7690F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698634; cv=none; b=md6ZoGFz1y9rBMWQSU6eBQc9wNBJ0LfqisVZg87I4XUp9ZD02qPudHNT9wWNykpi3X/F4cfAsqRSHT4Z10aAzXVYEYyAJwiiCU0qfzcM64MDoDkOM209+dYVaWxk/3Xb+YFPlFxaOsWfCRnypXfHCQuNUg7gbyKnoyEu1LlWoiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698634; c=relaxed/simple;
	bh=0quI71Dh/TmsV6dBFjbobhxYY6YOyL2zUxoScLPgFUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDa37XbrnItyqa3UbrpZ3vNS1/osp7c8a48bAs5I/oBrqZnVSCj5QDERZZa9CeGOHYaSW6aDtH2KRJq7r8udjFUFodVWr+HdsHUPhAtk5dRec8QhxUF55nmkSbKm2l/0ANYKEdVUQof/78NNf0c7GsgTk8aN7xBKrkviQssBRCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R/Bapetf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706698625;
	bh=0quI71Dh/TmsV6dBFjbobhxYY6YOyL2zUxoScLPgFUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R/Bapetfk1gIHl4cGuCB5qNWzBGpkccgwsINMrM5hRW8KvP8QQX2jt3+eChHsFDT7
	 ht6W5UFTWon1vq2hoGkEEDWxUGC9qfuHsnIzuEOhG9xsGVgOqZd2kv+kROmNVL/Abo
	 9sfLrOg3wb3JGSzk6Q+MTi8/WDHqb9fM5y3Lf3DB1OW+FpOIJbrweyGPAUgCLGoKlq
	 BjuLcnyKwhRVQLtwcC2J6jRTPXZmMXj98FeJhMZG5ZIDyXGRBw7oHH6FVh+y+H/UvB
	 fLbZM1DlV5EezyzzGMlSuKBm0bwF9BH/OngqC/u3yr+66fuMa9mvEcpAiLdPLnUqmA
	 Fyq0FFJTeK4pw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 03EF2378042B;
	Wed, 31 Jan 2024 10:57:04 +0000 (UTC)
Message-ID: <2e797f80-2e77-4199-beb4-c91a0be11bb5@collabora.com>
Date: Wed, 31 Jan 2024 11:57:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/mediatek: dsi: Cleanup functions
 mtk_dsi_ps_control{_vact}()
Content-Language: en-US
To: Fei Shao <fshao@chromium.org>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231220135722.192080-1-angelogioacchino.delregno@collabora.com>
 <20231220135722.192080-3-angelogioacchino.delregno@collabora.com>
 <CAC=S1nhNfyEWKaJZjb_G-pXpxSpXvNQd2EMJUzWWwxmC+TzSaA@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAC=S1nhNfyEWKaJZjb_G-pXpxSpXvNQd2EMJUzWWwxmC+TzSaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 26/12/23 11:48, Fei Shao ha scritto:
> Hi Angelo,
> 
> On Wed, Dec 20, 2023 at 9:57 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Function mtk_dsi_ps_control() is a subset of mtk_dsi_ps_control_vact():
>> merge the two in one mtk_dsi_ps_control() function by adding one
>> function parameter `config_vact` which, when true, writes the VACT
>> related registers.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_dsi.c | 76 +++++++++---------------------
>>   1 file changed, 23 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index 23d2c5be8dbb..b618e2e31022 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -352,40 +352,6 @@ static void mtk_dsi_set_vm_cmd(struct mtk_dsi *dsi)
>>          mtk_dsi_mask(dsi, DSI_VM_CMD_CON, TS_VFP_EN, TS_VFP_EN);
>>   }
>>
>> -static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
>> -{
>> -       struct videomode *vm = &dsi->vm;
>> -       u32 dsi_buf_bpp, ps_wc;
>> -       u32 ps_bpp_mode;
>> -
>> -       if (dsi->format == MIPI_DSI_FMT_RGB565)
>> -               dsi_buf_bpp = 2;
>> -       else
>> -               dsi_buf_bpp = 3;
>> -
>> -       ps_wc = vm->hactive * dsi_buf_bpp;
>> -       ps_bpp_mode = ps_wc;
>> -
>> -       switch (dsi->format) {
>> -       case MIPI_DSI_FMT_RGB888:
>> -               ps_bpp_mode |= PACKED_PS_24BIT_RGB888;
>> -               break;
>> -       case MIPI_DSI_FMT_RGB666:
>> -               ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
>> -               break;
>> -       case MIPI_DSI_FMT_RGB666_PACKED:
>> -               ps_bpp_mode |= LOOSELY_PS_18BIT_RGB666;
>> -               break;
>> -       case MIPI_DSI_FMT_RGB565:
>> -               ps_bpp_mode |= PACKED_PS_16BIT_RGB565;
>> -               break;
>> -       }
>> -
>> -       writel(vm->vactive, dsi->regs + DSI_VACT_NL);
>> -       writel(ps_bpp_mode, dsi->regs + DSI_PSCTRL);
>> -       writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);
>> -}
>> -
>>   static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
>>   {
>>          u32 tmp_reg;
>> @@ -417,36 +383,40 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
>>          writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
>>   }
>>
>> -static void mtk_dsi_ps_control(struct mtk_dsi *dsi)
>> +static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool config_vact)
>>   {
>> -       u32 dsi_tmp_buf_bpp;
>> -       u32 tmp_reg;
>> +       struct videomode *vm = &dsi->vm;
>> +       u32 dsi_buf_bpp, ps_wc;
>> +       u32 ps_bpp_mode;
>> +
>> +       if (dsi->format == MIPI_DSI_FMT_RGB565)
>> +               dsi_buf_bpp = 2;
>> +       else
>> +               dsi_buf_bpp = 3;
> 
> The same is also in mtk_dsi_config_vdo_timing(). Given this is a
> cleanup series, I think it'd be a good chance to add another patch
> and integrate those usages. Just a thought.  :)

Checking that right now.

>>
>> +
>> +       ps_wc = vm->hactive * dsi_buf_bpp;
> 
> I noticed the "& DSI_PS_WC" part was dropped (but perhaps with awareness?).
> 
> While the outcome seems to always fall within the range of
> DSI_PS_WC so we should be fine in practice, I think it doesn't hurt to
> keep the value masked to save readers some time to check if this would
> ever be possible to overflow and write undesired bits down the line.
> WDYT?
> 

Masking a pre-masked value doesn't look right.

Besides, as for the concern of overflowing, if we masked that we'd still end up
with broken functionality, as if the value is invalid... well, it's invalid.
Masked or not. :-)

Thanks for the R-b, sending a v3 soon with some fixes.

Regards,
Angelo


> Regardless of that, I didn't find obvious issue in this patch, so
> 
> Reviewed-by: Fei Shao <fshao@chromium.org>
> 
> Regards,
> Fei
> 
> 
> 
> 
>>
>> +       ps_bpp_mode = ps_wc;
>>
>>          switch (dsi->format) {
>>          case MIPI_DSI_FMT_RGB888:
>> -               tmp_reg = PACKED_PS_24BIT_RGB888;
>> -               dsi_tmp_buf_bpp = 3;
>> +               ps_bpp_mode |= PACKED_PS_24BIT_RGB888;
>>                  break;
>>          case MIPI_DSI_FMT_RGB666:
>> -               tmp_reg = LOOSELY_PS_18BIT_RGB666;
>> -               dsi_tmp_buf_bpp = 3;
>> +               ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
>>                  break;
>>          case MIPI_DSI_FMT_RGB666_PACKED:
>> -               tmp_reg = PACKED_PS_18BIT_RGB666;
>> -               dsi_tmp_buf_bpp = 3;
>> +               ps_bpp_mode |= LOOSELY_PS_18BIT_RGB666;
>>                  break;
>>          case MIPI_DSI_FMT_RGB565:
>> -               tmp_reg = PACKED_PS_16BIT_RGB565;
>> -               dsi_tmp_buf_bpp = 2;
>> -               break;
>> -       default:
>>
>> -               tmp_reg = PACKED_PS_24BIT_RGB888;
>> -               dsi_tmp_buf_bpp = 3;
>> +               ps_bpp_mode |= PACKED_PS_16BIT_RGB565;
>>                  break;
>>          }
>>
>> -       tmp_reg += dsi->vm.hactive * dsi_tmp_buf_bpp & DSI_PS_WC;
>>
>> -       writel(tmp_reg, dsi->regs + DSI_PSCTRL);
>> +       if (config_vact) {
>> +               writel(vm->vactive, dsi->regs + DSI_VACT_NL);
>> +               writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);
>> +       }
>> +       writel(ps_bpp_mode, dsi->regs + DSI_PSCTRL);
>>   }
>>
>>   static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>> @@ -522,7 +492,7 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>>          writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
>>          writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
>>
>> -       mtk_dsi_ps_control(dsi);
>> +       mtk_dsi_ps_control(dsi, false);
>>   }
>>
>>   static void mtk_dsi_start(struct mtk_dsi *dsi)
>> @@ -667,7 +637,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>>          mtk_dsi_reset_engine(dsi);
>>          mtk_dsi_phy_timconfig(dsi);
>>
>> -       mtk_dsi_ps_control_vact(dsi);
>> +       mtk_dsi_ps_control(dsi, true);
>>          mtk_dsi_set_vm_cmd(dsi);
>>          mtk_dsi_config_vdo_timing(dsi);
>>          mtk_dsi_set_interrupt_enable(dsi);
>> --
>> 2.43.0
>>
>>

