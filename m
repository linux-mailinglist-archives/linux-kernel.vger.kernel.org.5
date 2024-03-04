Return-Path: <linux-kernel+bounces-90371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACF986FE4A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2770EB2106F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C39A2261A;
	Mon,  4 Mar 2024 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KrlkVNX2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86EC224C2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546756; cv=none; b=spq0uM9qxqG38WtDFFIaYWk6qXXu03HQ1KJdQde8AiIIdXsWe9/Z2yi3IigNB4AVF2XZP6JNCDhKr3mY67Ket2BjkWj86v44qo1qZtun9jMJ3NmkbqUYJu0x8yXxlOCk+U5oe5W2RbBZfs5TyqsrXKKfBCK5uNrO96exaNNDTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546756; c=relaxed/simple;
	bh=QJ5+SoxWttbnb16KupyBcA6ZTzZC4TcWNM2sYRBjKag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFjwAzPq7ZGaujlQ36hnZpAMct70CSegIG/IZm50a/oXg4k5lfVug3OqcYnnLs2750FL2UJPDHjQLCLwU09/K1xSOLjT7gd+vn4b9lst7sF/IkCzESzolSnjeIiiBFpPh10iil6NFUY4xYhCvwaWbjyDG2avHQWGovu2giaOUfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KrlkVNX2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709546753;
	bh=QJ5+SoxWttbnb16KupyBcA6ZTzZC4TcWNM2sYRBjKag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KrlkVNX2Rc1kdAXsmHjZW0RqaTh9b+YFw34X3qprKnK9tZtD7kQyBnBLTdpedF/jT
	 2Qur/N4BwFqfF3AEkwXecVLzZpObe6tPPq99vIvMTGSQo3+czZePyCfMw6YxBMl2mx
	 iKtXzybxxoZIjCawuk5CmpGm5anI5w27jLihsDW5LtDC+dNZcOHbeGI2btXk/CddBI
	 PLMq7I2ZUJ1G85q6WwodIIMOlhlpHSWRQ8+9S6cV2/cfYZn7ILyqO+df0AwYY1HqUV
	 TQ64U1+jG4zzqLlkBdGnrgif9jMo6IukPanyaSnfb/VsjKsp2XWrfO2Wdljb9mkycc
	 63ezv8284fw9w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 59B5A378143B;
	Mon,  4 Mar 2024 10:05:52 +0000 (UTC)
Message-ID: <e0843692-d317-43ec-b8c8-1bdea37447dc@collabora.com>
Date: Mon, 4 Mar 2024 11:05:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] soc: mediatek: mtk-cmdq: Add cmdq_pkt_poll_addr()
 function
Content-Language: en-US
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jason-ch Chen <jason-ch.chen@mediatek.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Shawn Sung <shawn.sung@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240301111126.22035-1-jason-jh.lin@mediatek.com>
 <20240301111126.22035-4-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301111126.22035-4-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/03/24 12:11, Jason-JH.Lin ha scritto:
> Add cmdq_pkt_poll_addr function to support CMDQ user making
> an instruction for polling a specific address of hardware rigster
> to check the value with or without mask.
> 
> POLL is an old operation in GCE, so it does not support SPR and

POLL is a legacy operation in GCE, so it does not support .....

> CMDQ_CODE_LOGIC. CMDQ users need to use GPR and CMDQ_CODE_MASK
> to move polling register address to GPR to make an instruction.
> This will be done in cmdq_pkt_poll_addr().
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Change-Id: I91ff98e06570dc4501187eb29de64aaa65b1cf13
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 38 ++++++++++++++++++++++++++
>   include/linux/soc/mediatek/mtk-cmdq.h  | 16 +++++++++++
>   2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 3a1e47ad8a41..2e9fc9bb1183 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -12,6 +12,7 @@
>   
>   #define CMDQ_WRITE_ENABLE_MASK	BIT(0)
>   #define CMDQ_POLL_ENABLE_MASK	BIT(0)
> +#define CMDQ_POLL_HIGH_ADDR_GPR	(14)
>   #define CMDQ_EOC_IRQ_EN		BIT(0)
>   #define CMDQ_REG_TYPE		1
>   #define CMDQ_JUMP_RELATIVE	1
> @@ -406,6 +407,43 @@ int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
>   }
>   EXPORT_SYMBOL(cmdq_pkt_poll_mask);
>   
> +int cmdq_pkt_poll_addr(struct cmdq_pkt *pkt, dma_addr_t addr, u32 value, u32 mask)
> +{
> +	struct cmdq_instruction inst = { {0} };
> +	int err;
> +	u8 use_mask = 0;
> +
> +	if (mask != U32_MAX) {

inst.op = CMDQ_CODE_MASK;

/* Describe what you're doing here as a comment please */
if (mask < GENMASK(31, 0)) {
	inst.mask = ~mask;
	err = cmdq_pkt_append_command ...
	use_mask ...
}

/* POLL is a legacy operation in GCE and ... etc etc */
inst.mask = addr;
inst.dst_t = ...
inst.sop = ...
err = cmdq_pkt_append... etc etc etc


> +		inst.op = CMDQ_CODE_MASK;
> +		inst.mask = ~mask;
> +		err = cmdq_pkt_append_command(pkt, inst);
> +		if (err != 0)
> +			return err;
> +		use_mask = CMDQ_POLL_ENABLE_MASK;
> +	}
> +
> +	/*
> +	 * POLL is an old operation in GCE and it does not support SPR and CMDQ_CODE_LOGIC,
> +	 * so it can not use cmdq_pkt_assign to keep polling register address to SPR.
> +	 * It needs to use GPR and CMDQ_CODE_MASK to move polling register address to GPR.
> +	 */
> +	inst.op = CMDQ_CODE_MASK;
> +	inst.dst_t = CMDQ_REG_TYPE;
> +	inst.sop = CMDQ_POLL_HIGH_ADDR_GPR;
> +	inst.mask = addr;
> +	err = cmdq_pkt_append_command(pkt, inst);
> +	if (err < 0)
> +		return err;
> +
> +	inst.op = CMDQ_CODE_POLL;
> +	inst.dst_t = CMDQ_REG_TYPE;
> +	inst.sop = CMDQ_POLL_HIGH_ADDR_GPR;

This is a reassignment of the same value. You can do it like

/* dst_t and sop must be CMDQ_REG_TYPE, CMDQ_POLL_HIGH_ADDR_GPR */
inst.op = CMDQ_CODE_POLL;
inst.offset ...
inst.value ....

(but you're also inheriting the same `inst.mask`, was that intended?)

err = cmdq_pkt_append ....
if (err < 0)
	return err;

return 0
}

> +	inst.offset = use_mask;
> +	inst.value = value;
> +	return cmdq_pkt_append_command(pkt, inst);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_poll_addr);
> +
>   int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
>   {
>   	struct cmdq_instruction inst = {};
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index b6dbe2d8f16a..2fe9be240fbc 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -253,6 +253,22 @@ int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
>   int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
>   		       u16 offset, u32 value, u32 mask);
>   
> +/**
> + * cmdq_pkt_poll_addr() - Append polling command to the CMDQ packet, ask GCE to
> + *			 execute an instruction that wait for a specified
> + *			 address of hardware register to check for the value
> + *			 w/ or w/o mask.
> + *			 All GCE hardware threads will be blocked by this
> + *			 instruction.

/**
  * cmdq_pkt_poll_addr() - Append blocking POLL command to CMDQ packet
  * @pkt:	the CMDQ packet
  * @addr:	the hardware register address
  * @value:	the specified target register value
  * @mask:	the specified target register mask
  *
  * Appends a polling (POLL) command to the CMDQ packet and asks the GCE
  * to execute an instruction that checks for the specified `value` (with
  * or without `mask`) to appear in the specified hardware register `addr`.
  * All GCE threads will be blocked by this instruction.
  *
  * Return: 0 for success or negative error code
  */

That's better, isn't it? :-)

Cheers,
Angelo



