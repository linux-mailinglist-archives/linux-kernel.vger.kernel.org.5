Return-Path: <linux-kernel+bounces-66688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B79E85603E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216992895FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BA384FC2;
	Thu, 15 Feb 2024 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U9KIv3uh"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209384FC0;
	Thu, 15 Feb 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993640; cv=none; b=mnxu7SKwngeK+VNBRwOcCKIgKeaM0TS9dCllHW6B5gPgQcjq9g8kiHMKoxQn1fXlJ0IvppP88rvWIspiQrxUTuQBD8/jDb3KgFztS8VQBNi9IpUfGg9nfyGzmCBnZaPB83C4/k4OEw0VtAJgtPvWHjtPBlKzGjbYwhuwTbYSx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993640; c=relaxed/simple;
	bh=Cd4xi9HhZEMAGJT2YQ0prCB+BmIoBoWmUrLCsLhn0aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ortjjR2ymbBVj+PHUpY8oXs/r/uU6xxCK900kBjS5Letzw4q5fCWD3YqyANlHrAuwMNPo+gwp4+hka63TW1J8as1vFoKo3jguBqgDpCzz75MQz3kTszE0gXbVqjU0hZ2zlW8Co8mxnHZ5JlolgFzlgl7sl0jd126O4AUVrOXrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U9KIv3uh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707993636;
	bh=Cd4xi9HhZEMAGJT2YQ0prCB+BmIoBoWmUrLCsLhn0aM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=U9KIv3uhtMwUspJbyLete/tC9XPq1pMA/XhjUfDof9wK78Ug2zLTD2aBCzMm3jXKN
	 rwXQOus4f2twEzAWuoipJ0WD4cOAeVVZUzX3pe9V/tXitreMgw0Pol+lgzBqWYFkKy
	 DmHPyZnh96x06yLQyj3G6+YXENFLmelB9pYBae5U0VHvT2P0pC5zwkyF8KKbP+OQBH
	 nITptUjHkS/ABd+utumI7AXkST6DATejNc8SqhkLYFf+isk4DIkmA/nPWzoyhu8b36
	 x7P1UIpYYEc62rXo1wlnCKYz6NiaUC/fWzYXZVZbekUjx/3bhxQ1KDfSWcMexgVAgG
	 6KRnvNZ3/Mtnw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5D01A3780FC7;
	Thu, 15 Feb 2024 10:40:36 +0000 (UTC)
Message-ID: <c87af05e-9017-4806-88b1-7aa65f2b7070@collabora.com>
Date: Thu, 15 Feb 2024 11:40:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] soc: mediatek: cmdq: Remove unused helper funciton
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
 <20240215004931.3808-2-chunkuang.hu@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240215004931.3808-2-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/02/24 01:49, Chun-Kuang Hu ha scritto:
> cmdq_pkt_create(), cmdq_pkt_destroy(), and cmdq_pkt_flush_async()
> are not used by all client drivers (MediaTek drm driver and
> MediaTek mdp3 driver),
> 

Hello CK,

We can technically force the hand to say that this is true - but only because
these two functions are copy-pasted in both mediatek-drm and MDP3 drivers with
no meaningful changes, as in, the only change is that `pkt` is supposed to be
preallocated in both of the variants, while the one in mtk-cmdq-helper allocates
it on its own.

Code duplication is something that we want to avoid, not something that we want
to embrace: removing those functions from cmdq-helper with the plan to keep
duplicating them in each MediaTek driver that uses CMDQ packets is plain wrong.

This - especially because I'm sure that we will see yet another copy-paste of
those two functions in a future ISP driver, bringing the duplication count to
3 (or actually, 3 by 2 functions = 6 times).

On the other hand, removing the cmdq_pkt_flush_async() function is something
that I *do* support, as it's only doing two simple calls that are not even
specific to cmdq, but more like "generic stuff".

In short, as it is right now, this is a NACK - but if you change this commit to
remove only cmdq_pkt_flush_async() I would agree.

The right thing to do is to remove the duplicated functions:
  - mtk_drm_cmdq_pkt_create()
  - mtk_drm_cmdq_pkt_destroy()
  - mdp_cmdq_pkt_create()
  - mdp_cmdq_pkt_destroy()

..and migrate both drivers to use the common cmdq helper code instea, but that's
something that can come later.

For now, you can simply perform the ->cl removal on all duplicated functions, then
we can migrate them all to the common helper, removing duplication all along.

Regards,
Angelo

> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 59 --------------------------
>   include/linux/soc/mediatek/mtk-cmdq.h  | 40 -----------------
>   2 files changed, 99 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index b0cd071c4719..67e17974d1e6 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -105,50 +105,6 @@ void cmdq_mbox_destroy(struct cmdq_client *client)
>   }
>   EXPORT_SYMBOL(cmdq_mbox_destroy);
>   
> -struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size)
> -{
> -	struct cmdq_pkt *pkt;
> -	struct device *dev;
> -	dma_addr_t dma_addr;
> -
> -	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
> -	if (!pkt)
> -		return ERR_PTR(-ENOMEM);
> -	pkt->va_base = kzalloc(size, GFP_KERNEL);
> -	if (!pkt->va_base) {
> -		kfree(pkt);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -	pkt->buf_size = size;
> -	pkt->cl = (void *)client;
> -
> -	dev = client->chan->mbox->dev;
> -	dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
> -				  DMA_TO_DEVICE);
> -	if (dma_mapping_error(dev, dma_addr)) {
> -		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
> -		kfree(pkt->va_base);
> -		kfree(pkt);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	pkt->pa_base = dma_addr;
> -
> -	return pkt;
> -}
> -EXPORT_SYMBOL(cmdq_pkt_create);
> -
> -void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
> -{
> -	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
> -
> -	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
> -			 DMA_TO_DEVICE);
> -	kfree(pkt->va_base);
> -	kfree(pkt);
> -}
> -EXPORT_SYMBOL(cmdq_pkt_destroy);
> -
>   static int cmdq_pkt_append_command(struct cmdq_pkt *pkt,
>   				   struct cmdq_instruction inst)
>   {
> @@ -426,19 +382,4 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>   }
>   EXPORT_SYMBOL(cmdq_pkt_finalize);
>   
> -int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
> -{
> -	int err;
> -	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
> -
> -	err = mbox_send_message(client->chan, pkt);
> -	if (err < 0)
> -		return err;
> -	/* We can send next packet immediately, so just call txdone. */
> -	mbox_client_txdone(client->chan, 0);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(cmdq_pkt_flush_async);
> -
>   MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 649955d2cf5c..6c42d817d368 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -59,21 +59,6 @@ struct cmdq_client *cmdq_mbox_create(struct device *dev, int index);
>    */
>   void cmdq_mbox_destroy(struct cmdq_client *client);
>   
> -/**
> - * cmdq_pkt_create() - create a CMDQ packet
> - * @client:	the CMDQ mailbox client
> - * @size:	required CMDQ buffer size
> - *
> - * Return: CMDQ packet pointer
> - */
> -struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size);
> -
> -/**
> - * cmdq_pkt_destroy() - destroy the CMDQ packet
> - * @pkt:	the CMDQ packet
> - */
> -void cmdq_pkt_destroy(struct cmdq_pkt *pkt);
> -
>   /**
>    * cmdq_pkt_write() - append write command to the CMDQ packet
>    * @pkt:	the CMDQ packet
> @@ -266,19 +251,6 @@ int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr);
>    */
>   int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
>   
> -/**
> - * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
> - *                          packet and call back at the end of done packet
> - * @pkt:	the CMDQ packet
> - *
> - * Return: 0 for success; else the error code is returned
> - *
> - * Trigger CMDQ to asynchronously execute the CMDQ packet and call back
> - * at the end of done packet. Note that this is an ASYNC function. When the
> - * function returned, it may or may not be finished.
> - */
> -int cmdq_pkt_flush_async(struct cmdq_pkt *pkt);
> -
>   #else /* IS_ENABLED(CONFIG_MTK_CMDQ) */
>   
>   static inline int cmdq_dev_get_client_reg(struct device *dev,
> @@ -294,13 +266,6 @@ static inline struct cmdq_client *cmdq_mbox_create(struct device *dev, int index
>   
>   static inline void cmdq_mbox_destroy(struct cmdq_client *client) { }
>   
> -static inline  struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
> -static inline void cmdq_pkt_destroy(struct cmdq_pkt *pkt) { }
> -
>   static inline int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
>   {
>   	return -ENOENT;
> @@ -384,11 +349,6 @@ static inline int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>   	return -EINVAL;
>   }
>   
> -static inline int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
> -{
> -	return -EINVAL;
> -}
> -
>   #endif /* IS_ENABLED(CONFIG_MTK_CMDQ) */
>   
>   #endif	/* __MTK_CMDQ_H__ */


