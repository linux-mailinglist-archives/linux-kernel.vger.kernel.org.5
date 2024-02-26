Return-Path: <linux-kernel+bounces-81410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF4867595
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65E728FFBF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6647180020;
	Mon, 26 Feb 2024 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXWqTQMe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5660860;
	Mon, 26 Feb 2024 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951758; cv=none; b=N+A83zAB7sllAg9rVvzgjk7j++kGSWS5uxB1zAyoy4u2SzFiXtuUX73X2JiGKsNx71i1FNWleSEcrtlAAtHdL0OI9RBQHtH8yNod+PuELvNNYgxux/Y2iDFrQf/NlA7mrRB/aqo8j8rbcmL29WXULggMHzZ+aWVK8MlL/Kz9O9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951758; c=relaxed/simple;
	bh=YaQ7iie46bN8OA3waDtVulhSF25jw18+2/GwG6SNbMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7HO2mWcEQNVDKk4dLHOhcqrCAgIuhjtB3QfNrL/O7qNspVbPadHc2etZdi6Dzh3luWznPxWMA8GeVpAh06XK4KS0l2HlIpAJj5ZYpPjZzA2Mj3yzL6ENabek3uXmBrvufYUza+jpng9IDDViOiReP/+mc/YFZsgZVtR7aWErDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXWqTQMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9030C433F1;
	Mon, 26 Feb 2024 12:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708951758;
	bh=YaQ7iie46bN8OA3waDtVulhSF25jw18+2/GwG6SNbMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eXWqTQMekHtX30LLTD9EqjgnQyS0vdfBPUSwkthjObi2pqZFZq/iVrgG5/6I5+4na
	 hK6H3VJYhyxSKOC4AN1D8LHNX96LGPg5CKMY2ld74rhSkpzyl+k2xh9vUVPj42lN2S
	 GnsjLmaoBoYerfyrD1KGfr3aSiiwj2jGVviDHMCW8kzncZWrSnTOdRX/JnsDnGEGET
	 OX7tv1au0C35gA6ZxCOWCf+8xAvO0db+pyzbq1tFQlkSd8ufE/U+6T8qX2PNA3zI52
	 r7pt/zOhV5e2wDG23Z3BMsv4smrhg8TPbdhtrMS1wj+GmlcY4AYvqg4IUyPUwl014o
	 sK58XYh0VIbFQ==
Message-ID: <0f62faa4-608f-4e8e-98e5-7e6e50e20308@kernel.org>
Date: Mon, 26 Feb 2024 14:49:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: ethernet: ti: am65-cpts: Enable PTP RX
 HW timestamp using CPTS FIFO
Content-Language: en-US
To: Chintan Vankar <c-vankar@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Richard Cochran <richardcochran@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240215110953.3225099-1-c-vankar@ti.com>
 <52ff5e18-3616-478a-ab40-8f9a6f7f3e37@kernel.org>
 <3713e01e-1e48-489b-8ec2-e98471ca22f0@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <3713e01e-1e48-489b-8ec2-e98471ca22f0@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2024 11:08, Chintan Vankar wrote:
> 
> On 19/02/24 16:54, Roger Quadros wrote:
>>
>> On 15/02/2024 13:09, Chintan Vankar wrote:
>>> CPTS module supports capturing timestamp for every packet it receives,
>>> add a new function named "am65_cpts_rx_find_ts()" to get the timestamp
>>> of received packets from CPTS FIFO.
>>>
>>> Add another function named "am65_cpts_rx_timestamp()" which internally
>>> calls "am65_cpts_rx_find_ts()" function and timestamps the received
>>> PTP packets.
>>>
>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>> ---
>>>   drivers/net/ethernet/ti/am65-cpts.c | 84 +++++++++++++++++++++--------
>>>   drivers/net/ethernet/ti/am65-cpts.h | 11 ++--
>>>   2 files changed, 67 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
>>> index c66618d91c28..92a3b40e60d6 100644
>>> --- a/drivers/net/ethernet/ti/am65-cpts.c
>>> +++ b/drivers/net/ethernet/ti/am65-cpts.c
>>> @@ -859,29 +859,6 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp)
>>>       return delay;
>>>   }
>>>   -/**
>>> - * am65_cpts_rx_enable - enable rx timestamping
>>> - * @cpts: cpts handle
>>> - * @en: enable
>>> - *
>>> - * This functions enables rx packets timestamping. The CPTS can timestamp all
>>> - * rx packets.
>>> - */
>>> -void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
>>> -{
>>> -    u32 val;
>>> -
>>> -    mutex_lock(&cpts->ptp_clk_lock);
>>> -    val = am65_cpts_read32(cpts, control);
>>> -    if (en)
>>> -        val |= AM65_CPTS_CONTROL_TSTAMP_EN;
>>> -    else
>>> -        val &= ~AM65_CPTS_CONTROL_TSTAMP_EN;
>>> -    am65_cpts_write32(cpts, val, control);
>>> -    mutex_unlock(&cpts->ptp_clk_lock);
>>> -}
>>> -EXPORT_SYMBOL_GPL(am65_cpts_rx_enable);
>>> -
>>>   static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
>>>   {
>>>       unsigned int ptp_class = ptp_classify_raw(skb);
>>> @@ -906,6 +883,67 @@ static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
>>>       return 1;
>>>   }
>>>   +static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, struct sk_buff *skb,
>>> +                int ev_type, u32 skb_mtype_seqid)
>>> +{
>>> +    struct list_head *this, *next;
>>> +    struct am65_cpts_event *event;
>>> +    unsigned long flags;
>>> +    u32 mtype_seqid;
>>> +    u64 ns = 0;
>>> +
>>> +    am65_cpts_fifo_read(cpts);
>> am65_cpts_fifo_read() is called from the CPTS interrupt handler and the
>> event is popped out of the FIFO and pushed into an event list.
>>
>> Doesn't this race with that interrupt handler?
> Could you clarify why there be a race condition ?

I'm not sure so was asking. The question is, do you have to call
am65_cpts_fifo_read() here? If yes, could you please add a comment why.

>> Can't you use that event list instead of reading cpts_fifo directly?
>>
>> Something like am65_cpts_match_tx_ts()?
>>
>>> +    spin_lock_irqsave(&cpts->lock, flags);
>>> +    list_for_each_safe(this, next, &cpts->events) {
>>> +        event = list_entry(this, struct am65_cpts_event, list);
>>> +        if (time_after(jiffies, event->tmo)) {
>>> +            list_del_init(&event->list);
>>> +            list_add(&event->list, &cpts->pool);
>>> +            continue;
>>> +        }
>>> +
>>> +        mtype_seqid = event->event1 &
>>> +                  (AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK |
>>> +                   AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK |
>>> +                   AM65_CPTS_EVENT_1_EVENT_TYPE_MASK);
>>> +
>>> +        if (mtype_seqid == skb_mtype_seqid) {
>>> +            ns = event->timestamp;
>>> +            list_del_init(&event->list);
>>> +            list_add(&event->list, &cpts->pool);
>>> +            break;
>>> +        }
>>> +    }
>>> +    spin_unlock_irqrestore(&cpts->lock, flags);
>>> +
>>> +    return ns;
>>> +}
>>> +
>>> +void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb)
>>> +{
>>> +    struct am65_cpts_skb_cb_data *skb_cb = (struct am65_cpts_skb_cb_data *)skb->cb;
>>> +    struct skb_shared_hwtstamps *ssh;
>>> +    int ret;
>>> +    u64 ns;
>>> +
>>> +    ret = am65_skb_get_mtype_seqid(skb, &skb_cb->skb_mtype_seqid);
>>> +    if (!ret)
>>> +        return; /* if not PTP class packet */
>>> +
>>> +    skb_cb->skb_mtype_seqid |= (AM65_CPTS_EV_RX << AM65_CPTS_EVENT_1_EVENT_TYPE_SHIFT);
>>> +
>>> +    dev_dbg(cpts->dev, "%s mtype seqid %08x\n", __func__, skb_cb->skb_mtype_seqid);
>>> +
>>> +    ns = am65_cpts_find_rx_ts(cpts, skb, AM65_CPTS_EV_RX, skb_cb->skb_mtype_seqid);
>>> +    if (!ns)
>>> +        return;
>>> +
>>> +    ssh = skb_hwtstamps(skb);
>>> +    memset(ssh, 0, sizeof(*ssh));
>>> +    ssh->hwtstamp = ns_to_ktime(ns);
>>> +}
>>> +EXPORT_SYMBOL_GPL(am65_cpts_rx_timestamp);
>>> +
>>>   /**
>>>    * am65_cpts_tx_timestamp - save tx packet for timestamping
>>>    * @cpts: cpts handle
>>> diff --git a/drivers/net/ethernet/ti/am65-cpts.h b/drivers/net/ethernet/ti/am65-cpts.h
>>> index 6e14df0be113..6099d772799d 100644
>>> --- a/drivers/net/ethernet/ti/am65-cpts.h
>>> +++ b/drivers/net/ethernet/ti/am65-cpts.h
>>> @@ -22,9 +22,9 @@ void am65_cpts_release(struct am65_cpts *cpts);
>>>   struct am65_cpts *am65_cpts_create(struct device *dev, void __iomem *regs,
>>>                      struct device_node *node);
>>>   int am65_cpts_phc_index(struct am65_cpts *cpts);
>>> +void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
>>>   void am65_cpts_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
>>>   void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
>>> -void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en);
>>>   u64 am65_cpts_ns_gettime(struct am65_cpts *cpts);
>>>   int am65_cpts_estf_enable(struct am65_cpts *cpts, int idx,
>>>                 struct am65_cpts_estf_cfg *cfg);
>>> @@ -48,17 +48,18 @@ static inline int am65_cpts_phc_index(struct am65_cpts *cpts)
>>>       return -1;
>>>   }
>>>   -static inline void am65_cpts_tx_timestamp(struct am65_cpts *cpts,
>>> +static inline void am65_cpts_rx_timestamp(struct am65_cpts *cpts,
>>>                         struct sk_buff *skb)
>>>   {
>>>   }
>>>   -static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
>>> -                           struct sk_buff *skb)
>>> +static inline void am65_cpts_tx_timestamp(struct am65_cpts *cpts,
>>> +                      struct sk_buff *skb)
>>>   {
>>>   }
>>>   -static inline void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
>>> +static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
>>> +                           struct sk_buff *skb)
>>>   {
>>>   }
>>>   

-- 
cheers,
-roger

