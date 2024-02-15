Return-Path: <linux-kernel+bounces-66691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E58560BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97894B36821
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA3E137C42;
	Thu, 15 Feb 2024 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hWyFocqb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1036C137C38;
	Thu, 15 Feb 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993647; cv=none; b=fgHTeFn1WRz3/0F2ATkTjNOLY+AbLTfgjRVHMhvxLE33TWw/ir6c+GWk6L4uUGQL2A6+XIffXlt9MkBTpuNC3UqSYz/8TGhFZ/oseiaRwlrDStwArTAyvIPbLyIfLMI5BvPdzCsgoZqfhiBv2EHuweoGmvQp1xCjJJJvjJdL0fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993647; c=relaxed/simple;
	bh=CwvRGrbcZZ5Od6h/Tep6iTYxKSkQs10plfNFyaPZ33c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qfJGy67U8gffCQ6NmgXUwqxYpA0A8V0NG6hOd1SxfrmkR+K07KzUNBA9zwkFcpVgSxjKnErVPJBvcqz0ANSnzL1xvwJQeh526TJtmLOr+pIrz14fZ8QgtPGanvxyexZ3tJjo9EOSQOHaCQEOi9zPevWDf48C3mT4i2Bz9BNuXts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hWyFocqb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707993644;
	bh=CwvRGrbcZZ5Od6h/Tep6iTYxKSkQs10plfNFyaPZ33c=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=hWyFocqbH4mr/y++9uGkUayXVp39ZRe+nLhMFDLlE3qidpdwY85STrDOgEto1LllY
	 gjlI4JecZToT5aQEjmrhC9FK86HLP68SNWBXn5jsgdlOKzwJyclbV5CQ1DhdaGf62F
	 kz79/3p0c37c5R8kFXyNH4g1XqOpBAthPoIuZ/0TPqhQVUcHtkralu2bIFL5awRJpo
	 FvAgNzPPUb9P/+WWU7TaqWrHxZoWikIPhO6lkAJbxBBkCViPd6lRV7HO02od237r+u
	 L5p7GXBDejV43LIVJIM2G3Z33UQ/lm2ktU55yEbIzzH7B3jS1CJHsxbc0vsjA6lgcS
	 1pW2VtTbItWeQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E6C843780FC7;
	Thu, 15 Feb 2024 10:40:43 +0000 (UTC)
Message-ID: <1821c17e-6a40-4d1a-bc5a-06e8dd944456@collabora.com>
Date: Thu, 15 Feb 2024 11:40:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] soc: mediatek: cmdq: Add cmdq_pkt_eoc() helper
 function
Content-Language: en-US
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
 <20240215004931.3808-4-chunkuang.hu@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240215004931.3808-4-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/02/24 01:49, Chun-Kuang Hu ha scritto:
> cmdq_pkt_eoc() append eoc command to CMDQ packet. eoc command
> would ask GCE to generate IRQ. It's usually appended to the end
> of packet to notify all command in the packet is done.
> 
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 10 ++++++++++
>   include/linux/soc/mediatek/mtk-cmdq.h  | 15 +++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index ed4ef95adf5b..e982997117c2 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -359,6 +359,16 @@ int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa)
>   }
>   EXPORT_SYMBOL(cmdq_pkt_jump);
>   
> +int cmdq_pkt_eoc(struct cmdq_pkt *pkt)
> +{
> +	struct cmdq_instruction inst = { {0} };
> +
> +	inst.op = CMDQ_CODE_EOC;
> +	inst.value = CMDQ_EOC_IRQ_EN;
> +	return cmdq_pkt_append_command(pkt, inst);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_eoc);
> +
>   int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>   {
>   	struct cmdq_instruction inst = { {0} };
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 6215191a328d..a67f719dec0b 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -245,6 +245,16 @@ int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value);
>    */
>   int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa);
>   
> +/**
> + * cmdq_pkt_eoc() - Append eoc command to the CMDQ packet, ask GCE
> + *		    to generate IRQ. It's usually appended to the end of
> + *		    packet to notify that all command in the packet is done.
> + * @pkt:	the CMDQ packet
> + *
> + * Return: 0 for success; else the error code is returned

/**
  * cmdq_pkt_eoc() - Append EOC and ask GCE to generate an IRQ at end of execution
  * @pkt:	The CMDQ packet
  *
  * Appends an End Of Code (EOC) command to the CMDQ packet and asks the GCE
  * to generate an interrupt at the end of the execution of all commands in
  * the pipeline.
  * The EOC command is usually appended to the end of the pipeline to notify
  * that all commands are done.
  *
  * Return: 0 for success or negative error number
  */

Apart from that,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> + */
> +int cmdq_pkt_eoc(struct cmdq_pkt *pkt);
> +
>   /**
>    * cmdq_pkt_finalize() - Append EOC and jump command to pkt.
>    * @pkt:	the CMDQ packet
> @@ -346,6 +356,11 @@ static inline int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_
>   	return -EINVAL;
>   }
>   
> +static inline int cmdq_pkt_eoc(struct cmdq_pkt *pkt)
> +{
> +	return -EINVAL;
> +}
> +
>   static inline int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>   {
>   	return -EINVAL;


