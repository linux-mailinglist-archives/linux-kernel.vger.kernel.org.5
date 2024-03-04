Return-Path: <linux-kernel+bounces-90370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB5686FE49
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7558D1F22D33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC0F224C7;
	Mon,  4 Mar 2024 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="u648iBAL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884DB19BA6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546754; cv=none; b=YlTyMnLTPXE/kXo2IN+U+S1Oxp994MmlSa+yg3UNxbhUj6d48pDgUoHbrg790eUBidTQWU8v+9FCyXo5gnm1uVojPCJ6NJ8p5LPjqaiUmAEAt+x6CFD1EwwpbhSuipmCFkaeKt/9Go2NEd1g5CHL0k93xBExYGM9G868TLFzTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546754; c=relaxed/simple;
	bh=lEVGehSBFjA/oLsvuBM7tDdI4uNapzzSDtjugpkUM1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTN6CS+LMEZgqu3Hv5LLXBPE6jDc4wvBa8q7AGo7q6ij2H02JKGIFFJNrWUbWXYCW95oLfviLGJcPWM4MDJwDRt9QNztf0lJcAbAz3nLKGiU/ZHzVXiGYP2s0kDm1kU4qqBpFviFHF1rAQoETfVL/PgimHPyIStx0y9m/AJe6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=u648iBAL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709546750;
	bh=lEVGehSBFjA/oLsvuBM7tDdI4uNapzzSDtjugpkUM1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u648iBALFnbEregncZZ5/ZV7XZFR61wPlXgXehGOrGlVtWgfP+paEkV89he4qoqLb
	 0lPbMaDLlnftYQWfPlqMnuioFJ4dnrD/UWsuI9C8Targm7H9+6WkIq0lac1odESx4o
	 +yGwu81yVrUkh9BoyfRdxYX/RivPa/3420rlBzS5d5qMgAnPXpZqL7rugIkBJJ1ZlC
	 zZd51qRCuThyQz86ag2om49x6hI3nsgbrxV6MX0cA6MPabE76+UIP7wQhZpXnzVcE1
	 rWqodqh6P3K5ssyJxKnQHbCwMmxGuJr67WsfV3/4WjDZcZZa5mam7T+XcH7Z3ficBq
	 bRid2umc47ZMw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BEA5837803EE;
	Mon,  4 Mar 2024 10:05:49 +0000 (UTC)
Message-ID: <41a2017f-5627-42fe-a624-642c3c47f436@collabora.com>
Date: Mon, 4 Mar 2024 11:05:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] soc: mediatek: mtk-cmdq: Add cmdq_pkt_mem_move()
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
 <20240301111126.22035-3-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301111126.22035-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/03/24 12:11, Jason-JH.Lin ha scritto:
> Add cmdq_pkt_mem_move() function to support CMDQ user making
> an instruction for moving a value from a source address to a
> destination address.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Change-Id: I0128db6a3412303fc6da61f8a57a0c08e0c0067e

Drop Change-id please

> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 26 ++++++++++++++++++++++++++
>   include/linux/soc/mediatek/mtk-cmdq.h  | 10 ++++++++++
>   2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index b0cd071c4719..3a1e47ad8a41 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -299,6 +299,32 @@ int cmdq_pkt_write_s_mask_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
>   }
>   EXPORT_SYMBOL(cmdq_pkt_write_s_mask_value);
>   
> +s32 cmdq_pkt_mem_move(struct cmdq_pkt *pkt, dma_addr_t src_addr, dma_addr_t dst_addr)
> +{
> +	s32 err;
> +	const u16 tmp_reg_idx = CMDQ_THR_SPR_IDX0;
> +	const u16 swap_reg_idx = CMDQ_THR_SPR_IDX1;

s32 err at the end please

> +
> +	/* read the value of src_addr into swap_reg_idx */
> +	err = cmdq_pkt_assign(pkt, tmp_reg_idx, CMDQ_ADDR_HIGH(src_addr));
> +	if (err < 0)
> +		return err;
> +	err = cmdq_pkt_read_s(pkt, tmp_reg_idx, CMDQ_ADDR_LOW(src_addr), swap_reg_idx);
> +	if (err < 0)
> +		return err;
> +
> +	/* write the value of swap_reg_idx into dst_addr */
> +	err = cmdq_pkt_assign(pkt, tmp_reg_idx, CMDQ_ADDR_HIGH(dst_addr));
> +	if (err < 0)
> +		return err;
> +	err = cmdq_pkt_write_s(pkt, tmp_reg_idx, CMDQ_ADDR_LOW(dst_addr), swap_reg_idx);
> +	if (err < 0)
> +		return err;
> +
> +	return err;

In the documentation, you say "0 for success", so...

return 0; here :-)

> +}
> +EXPORT_SYMBOL(cmdq_pkt_mem_move);
> +
>   int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear)
>   {
>   	struct cmdq_instruction inst = { {0} };
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 1dae80185f9f..b6dbe2d8f16a 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -182,6 +182,16 @@ int cmdq_pkt_write_s_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
>   int cmdq_pkt_write_s_mask_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
>   				u16 addr_low, u32 value, u32 mask);
>   
> +/**
> + * cmdq_pkt_mem_move() - append memory move command to the CMDQ packet
> + * @pkt:	the CMDQ packet
> + * @src_addr:	source address
> + * @dma_addr_t: destination address
> + *

  * @dst_addr: destination address
  *
  * Appends a CMDQ command to copy the value found in `src_addr` to `dst_addr`
  *
  * Return ....

> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_mem_move(struct cmdq_pkt *pkt, dma_addr_t src_addr, dma_addr_t dst_addr);
> +
>   /**
>    * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
>    * @pkt:	the CMDQ packet


