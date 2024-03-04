Return-Path: <linux-kernel+bounces-90373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5427586FE4C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE501F22A6E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BE12556F;
	Mon,  4 Mar 2024 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lxTIWQPg"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4DF241E5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546766; cv=none; b=JS8YswnWwLEvuObBGlEcKDdigXkuTzmqxKWhfp8C3ps+05LPxO8Zwltj/FNFsQhAjl1v/Xgm2oskyX1uwe+Di+6BVrLJRy5mj+xhsvwacW7PQKnjjOhW3Yn09xXJWk2/SWDvruO+fTDvBOaPnuRM3jW18RundGEPIhpfln5DvyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546766; c=relaxed/simple;
	bh=ISoQmi3oK6Vmoe0IMg783tBWT8NBk2AxOuF2EXXZsNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5d5ruQc4f1mJ5S0ZC8f+XtjHi+sL0rTqB0H/QnAdLlgTnF4gXqhJekKUNxH0oS2GmHM4ViZVMv6VDIsa0U7zSO7/+yvABxD1pbMlqFyVc2mE+wp/fC+lkdcxpu0h2exfGEXAypiP5IJrd+1EDV0hGhCCAvfg327CeBlJLxwWZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lxTIWQPg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709546762;
	bh=ISoQmi3oK6Vmoe0IMg783tBWT8NBk2AxOuF2EXXZsNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lxTIWQPgCtvn/08bqkNRUqmv9OYbsWXP25wg4KmMebFyq/31OukwBT07DglJTqM4e
	 0Arch9pe+YnSg0aKI5MI1gh5oshiDmv3CrgCLCMs+n/v1ufC8+PDP0DZe8gDfGEAn2
	 EmaXxlfcTIFeDXn6+LDuh4IsXgCf6G7/9QyYllXTE0Wz+b81wLDBkwS3tDhj5UMp/q
	 B+OFHeP4cMFa5kYcUz3xPckKDcQrIgg0KrwoYDjg2QvBvGfPeKtiL6XBtUt3Ey2C6V
	 f/b+mu89oMgzzbu3i1iuhPzJWJBYvMGNcFVSEaW6zgFubLlVviub4LwvmwuBzQk4Em
	 GjUU5Hts4gi3g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2739537820C3;
	Mon,  4 Mar 2024 10:06:02 +0000 (UTC)
Message-ID: <298c13ff-25a7-4d9c-ab51-4c22c07c245d@collabora.com>
Date: Mon, 4 Mar 2024 11:06:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mailbox: mtk-cmdq: Add support runtime get and set
 GCE event
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
 <20240301111126.22035-6-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240301111126.22035-6-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/03/24 12:11, Jason-JH.Lin ha scritto:
> ISP drivers need to get and set GCE event in their runtime contorl flow.
> So add these functions to support get and set GCE by CPU.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Change-Id: I494c34ebc5ec26c82213f2bc03d2033d60652523

Change-Id makes no sense upstream. Please drop.

> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c       | 37 ++++++++++++++++++++++++
>   include/linux/mailbox/mtk-cmdq-mailbox.h |  2 ++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index ead2200f39ba..d7c08249c898 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -25,7 +25,11 @@
>   #define CMDQ_GCE_NUM_MAX		(2)
>   
>   #define CMDQ_CURR_IRQ_STATUS		0x10
> +#define CMDQ_SYNC_TOKEN_ID		0x60
> +#define CMDQ_SYNC_TOKEN_VALUE		0x64
> +#define CMDQ_TOKEN_ID_MASK			GENMASK(9, 0)
>   #define CMDQ_SYNC_TOKEN_UPDATE		0x68
> +#define CMDQ_TOKEN_UPDATE_VALUE			BIT(16)
>   #define CMDQ_THR_SLOT_CYCLES		0x30
>   #define CMDQ_THR_BASE			0x100
>   #define CMDQ_THR_SIZE			0x80
> @@ -83,6 +87,7 @@ struct cmdq {
>   	struct cmdq_thread	*thread;
>   	struct clk_bulk_data	clocks[CMDQ_GCE_NUM_MAX];
>   	bool			suspended;
> +	spinlock_t		event_lock; /* lock for gce event */
>   };
>   
>   struct gce_plat {
> @@ -113,6 +118,38 @@ u8 cmdq_get_shift_pa(struct mbox_chan *chan)
>   }
>   EXPORT_SYMBOL(cmdq_get_shift_pa);
>   
> +void cmdq_set_event(void *chan, u16 event_id)
> +{
> +	struct cmdq *cmdq = container_of(((struct mbox_chan *)chan)->mbox,
> +		typeof(*cmdq), mbox);

struct mbox_chan *mbc = chan;
struct cmdq *cmdq = container_of(mbc->mbox, ... etc); (and this fits in one line)

> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cmdq->event_lock, flags);

Why do you need irqsave/irqrestore? I think I know, but please explain.

> +
> +	writel(CMDQ_TOKEN_UPDATE_VALUE | event_id, cmdq->base + CMDQ_SYNC_TOKEN_UPDATE);
> +
> +	spin_unlock_irqrestore(&cmdq->event_lock, flags);
> +}
> +EXPORT_SYMBOL(cmdq_set_event);
> +
> +u32 cmdq_get_event(void *chan, u16 event_id)
> +{
> +	struct cmdq *cmdq = container_of(((struct mbox_chan *)chan)->mbox,
> +		typeof(*cmdq), mbox);
> +	unsigned long flags;
> +	u32 value = 0;
> +
> +	spin_lock_irqsave(&cmdq->event_lock, flags);
> +
> +	writel(CMDQ_TOKEN_ID_MASK & event_id, cmdq->base + CMDQ_SYNC_TOKEN_ID);
> +	value = readl(cmdq->base + CMDQ_SYNC_TOKEN_VALUE);
> +
> +	spin_unlock_irqrestore(&cmdq->event_lock, flags);
> +
> +	return value;
> +}
> +EXPORT_SYMBOL(cmdq_get_event);
> +
>   static int cmdq_thread_suspend(struct cmdq *cmdq, struct cmdq_thread *thread)
>   {
>   	u32 status;
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> index a8f0070c7aa9..f05cabd230da 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -79,5 +79,7 @@ struct cmdq_pkt {
>   };
>   
>   u8 cmdq_get_shift_pa(struct mbox_chan *chan);
> +void cmdq_set_event(void *chan, u16 event_id);
> +u32 cmdq_get_event(void *chan, u16 event_id);
>   
>   #endif /* __MTK_CMDQ_MAILBOX_H__ */




