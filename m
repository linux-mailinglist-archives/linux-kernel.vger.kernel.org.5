Return-Path: <linux-kernel+bounces-66692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31491856047
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A491C21471
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BE9138485;
	Thu, 15 Feb 2024 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X1pu8P4t"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3595F131E5B;
	Thu, 15 Feb 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993650; cv=none; b=sPt2wZnqU+BvPPvvObvDnysL91T2eLPRllrBVOrS+XtsXRV7JiT2BZ6epVfMTV/y2pINmSKJznRIXxwQwxiqFt4P5AQz7PIHTSVaN6MwKk69CFMhlKLENA1EGYfv5SwFTWIyLOX+Vip0y0lD35BnbDFSNGOLT0ZJpJBiHWqXbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993650; c=relaxed/simple;
	bh=iSVp6dLTFhBiFSnkW1LO3rz+tjlpHFgMWN84cVY5kB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m8i4d4XWBawoFgwzStrXM07NuZuTrzxjUDJg3uYdZ0fshl/1hFPC/jBs2UDPFZ/18CVIlVCsuDwxc4sCdcZ9+QFod7Ku30wacuWUDUB4YAkVD9W9njcAd4++xYo3GhWPpgzjNZKGo8cCJM0GRoI4QXO1S0cXalFADOTRL5+SeHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X1pu8P4t; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707993647;
	bh=iSVp6dLTFhBiFSnkW1LO3rz+tjlpHFgMWN84cVY5kB8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=X1pu8P4tHnLAJ/NzR3FsmEfCfcYEmDufQsGBm2JjdNgoCsFy9qBRUt4hmItMSH4l4
	 apKgyef/UKTllMBzNjg6Y0AZsGIHG0j709qo8k+S0XeJV8sqdJYXfWu0Sm46yFmKf1
	 /xcqUMq9EBb7PLCC7NfFkKSKYYg7LrQxjD1/K+sX8Mny4Ng6ityj+etq4FBXeOUBBK
	 NvMPWDKY6iInbjcQSDBJMjUHtOkDBaImq7mIeoeVQFHIyZ2/W3u5uXQSUzPPDL/2Bl
	 QpYLHhF/XmcvNLiVjSKU0JFLadl/pn+efiDn+Oa7lisUWKo/yRSb83zkxUktkaK9n4
	 53Lok0WcOI9vw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2A23737820B1;
	Thu, 15 Feb 2024 10:40:47 +0000 (UTC)
Message-ID: <680fcb9a-d7e2-4a15-877e-09c01024ed53@collabora.com>
Date: Thu, 15 Feb 2024 11:40:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] soc: mediatek: cmdq: Add cmdq_pkt_nop() helper
 function
Content-Language: en-US
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
 <20240215004931.3808-5-chunkuang.hu@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240215004931.3808-5-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/02/24 01:49, Chun-Kuang Hu ha scritto:
> cmdq_pkt_nop() append nop command to the packet. nop command ask
> GCE to do no operation.
> 
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 11 +++++++++++
>   include/linux/soc/mediatek/mtk-cmdq.h  | 16 ++++++++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index e982997117c2..1be950b4ec7f 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -369,6 +369,17 @@ int cmdq_pkt_eoc(struct cmdq_pkt *pkt)
>   }
>   EXPORT_SYMBOL(cmdq_pkt_eoc);
>   
> +int cmdq_pkt_nop(struct cmdq_pkt *pkt, u8 shift_pa)
> +{
> +	struct cmdq_instruction inst = { {0} };
> +
> +	/* Jumping to next instruction is equal to no operation */
> +	inst.op = CMDQ_CODE_JUMP;
> +	inst.value = CMDQ_INST_SIZE >> shift_pa;
> +	return cmdq_pkt_append_command(pkt, inst);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_nop);
> +
>   int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>   {
>   	struct cmdq_instruction inst = { {0} };
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index a67f719dec0b..8179ba5238f9 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -255,6 +255,17 @@ int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa);
>    */
>   int cmdq_pkt_eoc(struct cmdq_pkt *pkt);
>   
> +/**
> + * cmdq_pkt_nop() - Append nop command to the CMDQ packet, ask GCE
> + *		    to do no operation.

  * cmdq_pkt_nop() - Append No-Operation (NOP) command to a CMDQ packet

After which...
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



