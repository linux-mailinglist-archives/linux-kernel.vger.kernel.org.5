Return-Path: <linux-kernel+bounces-66693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3985604A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0D01F281BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533BD132465;
	Thu, 15 Feb 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tORbjEKo"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19633131E5B;
	Thu, 15 Feb 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993655; cv=none; b=U/mU1KYw5+ErunyOk/6eq6pQIUqXmkKUNG2nJZeN0FRMtdTC0KjGghn/wCEgMx/1EOcQ5ZxZtWfA3sX0T8GOvOUqDp4BU8Bj8sXv2U5g/Vx57BmxPhoXWMwXl1NShkwDaE7RW/zA+46jgsGDS4u+C/JPZAImPJzlnQIHNs5mk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993655; c=relaxed/simple;
	bh=5wcOrmWAdm8TpcUI51bhbt1tBGqjQwvGwURuQv6OC9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VZeYu+qT5b2J/ervXSjl/Z6SwMmZz0n8w1gY6FtXiIbaz28Lu2Fft+COBSwW8sugSO4loTUlN7JLky55D4XRYlFQcDUEwe99ccv5r7Ue3B+TNlXyWO2CF+0pmFqKRSRmqgf5VkzG67Wdx7V2W9ltLrruP+ljXkteLk83OJTBoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tORbjEKo; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707993652;
	bh=5wcOrmWAdm8TpcUI51bhbt1tBGqjQwvGwURuQv6OC9E=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tORbjEKozUXgDVSjisgTfnm0szQ4Ks63i5wjFUPknRP0oqD85lAO5FCeS3tw0+Zkk
	 mYDHyFv15I2FqeSYc1C4X1EPicF7PIyVoZy0sfIqsha9T3/genKmlJAfVB1OBxPwSl
	 zE0f/X1QNjC5Sk6FMeBTBvGKqz+CGs+MTZsY0PNflkCz10o9yDNhr1zxuLXabYy445
	 EMYoQSD4pvHP5Uwaf6unpAlX2FBinyZQ4tYo+w5ZsIHCR42xfrNR26vNX45drWYEG6
	 oHUjxmGhAz5gAId3lNZTKTGDkCAhUV3ocSjDuGSYjdYlZicE91WKovSA0X6UjrJR5K
	 ueEYntvmlGqVw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2C6AD3780FC7;
	Thu, 15 Feb 2024 10:40:52 +0000 (UTC)
Message-ID: <21d17701-e40b-49c5-bf16-5e70a6daa2c4@collabora.com>
Date: Thu, 15 Feb 2024 11:40:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] soc: mediatek: cmdq: Add parameter shift_pa to
 cmdq_pkt_jump()
Content-Language: en-US
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
 <20240215004931.3808-3-chunkuang.hu@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240215004931.3808-3-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/02/24 01:49, Chun-Kuang Hu ha scritto:
> In original design, cmdq_pkt_jump() call cmdq_get_shift_pa() every
> time to get shift_pa. But the shift_pa is constant value for each
> SoC, so client driver just need to call cmdq_get_shift_pa() once
> and pass shift_pa to cmdq_pkt_jump() to prevent frequent function
> call.
> 

As far as I understand, the CMDQ supports both relative and absolute jumps, right?

Here's my proposal:
  - Add a new function cmdq_pkt_jump_rel() or cmdq_pkt_jump_relative()
    * note: I prefer "rel", as maybe in a future we'll get a jump_abs function? :-)
  - Don't touch the cmdq_pkt_jump() function for one cycle
    - Migrate mediatek-drm to use cmdq_pkt_jump_rel()
  - Remove cmdq_pkt_jump() in the next cycle.

What do you think?

Regards,
Angelo

> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 5 ++---
>   include/linux/soc/mediatek/mtk-cmdq.h  | 6 ++++--
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 67e17974d1e6..ed4ef95adf5b 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -348,14 +348,13 @@ int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
>   }
>   EXPORT_SYMBOL(cmdq_pkt_assign);
>   
> -int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
> +int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa)
>   {
>   	struct cmdq_instruction inst = {};
>   
>   	inst.op = CMDQ_CODE_JUMP;
>   	inst.offset = CMDQ_JUMP_RELATIVE;
> -	inst.value = addr >>
> -		cmdq_get_shift_pa(((struct cmdq_client *)pkt->cl)->chan);
> +	inst.value = addr >> shift_pa;
>   	return cmdq_pkt_append_command(pkt, inst);
>   }
>   EXPORT_SYMBOL(cmdq_pkt_jump);
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 6c42d817d368..6215191a328d 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -238,10 +238,12 @@ int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value);
>    *		     a physical address which should contains more instruction.
>    * @pkt:        the CMDQ packet
>    * @addr:       physical address of target instruction buffer
> + * @shift_pa:	shift bits of physical address in CMDQ instruction. This value
> + *		is got by cmdq_get_shift_pa().
>    *
>    * Return: 0 for success; else the error code is returned
>    */
> -int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr);
> +int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa);
>   
>   /**
>    * cmdq_pkt_finalize() - Append EOC and jump command to pkt.
> @@ -339,7 +341,7 @@ static inline int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
>   	return -EINVAL;
>   }
>   
> -static inline int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
> +static inline int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa)
>   {
>   	return -EINVAL;
>   }




