Return-Path: <linux-kernel+bounces-92119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07298871B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FFE1F22758
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF175BAE7;
	Tue,  5 Mar 2024 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LORY2kHf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCBB5490F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634060; cv=none; b=P7PbbwFSKSOTH54Jqs+BOInohWBRUexX8e5Mhi5rXD+3WVov51M+bReYRUXQRxOiZeexhLroZMgu2EK/qe6d+3LbBmirenMkAaWgZYAMMua6dHzkRJtMb7Kwa7EKYRBNwXVdcaLcHcZQT9+MJ/3V7v8HArmgQo6B1yfBJOr7jHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634060; c=relaxed/simple;
	bh=BPEtYfyFZ3zIsSSumymVBNXkt5kDgI1A4gqsNs7DMws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCHNuvvNisdvjlNfXzi8uMiZbOx8/XFHIiHLjBxZ+jqcTD+nltTFumIrGB3g10r03dh2ErC/FdRoJmKM7q74uPpRQG/kw5PmP0Vwj/Pwle8HXhcEq+Av0D5WeXAcqs+ns8KZP2CnpZ0gY5ZKb9U8DKyQOmuHDZK5QeYAEXRQ/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LORY2kHf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709634057;
	bh=BPEtYfyFZ3zIsSSumymVBNXkt5kDgI1A4gqsNs7DMws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LORY2kHfPljuF+0IEJo7vcxZLDuh04Xff+jT8HMdMATwYiBtkRza0yRd8FyyGZiFM
	 p5gvq5ogsQXlg/lmCBt5CzgSn0fZf4xVOeDoPW0D2RLDvEMV0ZCdgr+4JK21oB3q9p
	 Z9GXN1NnPDKMHAf+eYAvGjZebFZxH+GHa++fOEQbAli5Ru/kw3j4sulrvcW9Urhziu
	 m+NWsTW5F6DZwTMgAXopF8zxMiOX7D42fBMAV0E+rtRNfNNMPZHMWuZ6/jYK/fB/8z
	 YfLeRF4nFcTxgDFOqeUt8I2HDFyiXwxxfglxCt7P82RDEaKMpriqI3VxOhie906WX6
	 3ZZ/G8lWD827w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 70FC23781FEF;
	Tue,  5 Mar 2024 10:20:56 +0000 (UTC)
Message-ID: <e9cc42d7-db7f-4bd8-978e-72b97cfa8d41@collabora.com>
Date: Tue, 5 Mar 2024 11:20:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mailbox: mtk-cmdq: Add support runtime get and set
 GCE event
Content-Language: en-US
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,
 =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
 <Jason-ch.Chen@mediatek.com>, =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
 <Shawn.Sung@mediatek.com>, =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
 <Nancy.Lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240301111126.22035-1-jason-jh.lin@mediatek.com>
 <20240301111126.22035-6-jason-jh.lin@mediatek.com>
 <298c13ff-25a7-4d9c-ab51-4c22c07c245d@collabora.com>
 <35b6915dd195abba009dab64dc6002362292351c.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <35b6915dd195abba009dab64dc6002362292351c.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/03/24 04:09, Jason-JH Lin (林睿祥) ha scritto:
> Hi Angelo,
> 
> Thanks for the reviews.
> 
> On Mon, 2024-03-04 at 11:06 +0100, AngeloGioacchino Del Regno wrote:
>> Il 01/03/24 12:11, Jason-JH.Lin ha scritto:
>>> ISP drivers need to get and set GCE event in their runtime contorl
>>> flow.
>>> So add these functions to support get and set GCE by CPU.
>>>
>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>>> Change-Id: I494c34ebc5ec26c82213f2bc03d2033d60652523
>>
>> Change-Id makes no sense upstream. Please drop.
> 
> OK, I'll drop it.
> 
>>
>>> ---
>>>    drivers/mailbox/mtk-cmdq-mailbox.c       | 37
>>> ++++++++++++++++++++++++
>>>    include/linux/mailbox/mtk-cmdq-mailbox.h |  2 ++
>>>    2 files changed, 39 insertions(+)
>>>
>>> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c
>>> b/drivers/mailbox/mtk-cmdq-mailbox.c
>>> index ead2200f39ba..d7c08249c898 100644
>>> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
>>> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
>>> @@ -25,7 +25,11 @@
>>>    #define CMDQ_GCE_NUM_MAX		(2)
>>>    
>>>    #define CMDQ_CURR_IRQ_STATUS		0x10
>>> +#define CMDQ_SYNC_TOKEN_ID		0x60
>>> +#define CMDQ_SYNC_TOKEN_VALUE		0x64
>>> +#define CMDQ_TOKEN_ID_MASK			GENMASK(9, 0)
>>>    #define CMDQ_SYNC_TOKEN_UPDATE		0x68
>>> +#define CMDQ_TOKEN_UPDATE_VALUE			BIT(16)
>>>    #define CMDQ_THR_SLOT_CYCLES		0x30
>>>    #define CMDQ_THR_BASE			0x100
>>>    #define CMDQ_THR_SIZE			0x80
>>> @@ -83,6 +87,7 @@ struct cmdq {
>>>    	struct cmdq_thread	*thread;
>>>    	struct clk_bulk_data	clocks[CMDQ_GCE_NUM_MAX];
>>>    	bool			suspended;
>>> +	spinlock_t		event_lock; /* lock for gce event */
>>>    };
>>>    
>>>    struct gce_plat {
>>> @@ -113,6 +118,38 @@ u8 cmdq_get_shift_pa(struct mbox_chan *chan)
>>>    }
>>>    EXPORT_SYMBOL(cmdq_get_shift_pa);
>>>    
>>> +void cmdq_set_event(void *chan, u16 event_id)
>>> +{
>>> +	struct cmdq *cmdq = container_of(((struct mbox_chan *)chan)-
>>>> mbox,
>>> +		typeof(*cmdq), mbox);
>>
>> struct mbox_chan *mbc = chan;
>> struct cmdq *cmdq = container_of(mbc->mbox, ... etc); (and this fits
>> in one line)
>>
> OK, I'll change it.
> 
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&cmdq->event_lock, flags);
>>
>> Why do you need irqsave/irqrestore? I think I know, but please
>> explain.
>>
> Because ISP driver may call cmdq_get_event() first than use
> cmdq_set_event() to update the event status in one
> mtk_imgsys_setevent() function frequently.
> 
> And mtk_imgsys_setevent() will be called in SW multi-thread after cmdq
> callback from cmdq_irq_handler, so we use the spin_lock_irqsave to
> avoid the race condition.

I was imagining something like that, yes - thank you for explaining.

Cheers,
Angelo


