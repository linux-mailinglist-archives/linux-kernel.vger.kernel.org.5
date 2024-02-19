Return-Path: <linux-kernel+bounces-71121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B047985A0E8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66ED2282C76
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94682C190;
	Mon, 19 Feb 2024 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXziVmJy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBFF25614;
	Mon, 19 Feb 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338314; cv=none; b=oKKKjLGHPgylUkaYanNhzzpIt2b0cZVbpfSnQmV8/UsmQk01ni+nQP83IpgzCzYbvbXoFRfP6QlW+9Zu2BtWTyt4KVzoZLyVgKKGd1Q7k+OLN+xzsj6gmN0UUl1ZAyMacqxEOVhkUPc/avVhYCi0TF3YpWk/Vu/8FDaC/8mjsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338314; c=relaxed/simple;
	bh=p1tLn3Yrs92lQ8kD/e1MBVf6hxU6mcgV7cfVI6sPNI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPcTb+iGvDzfKYu8lqguBBbVmRbnxE02nshzf2HKb0m6HOSGb8Atc3bzRJ8TbsupwzpwKWM6hl4DQCPJsojI8j4nHmxQ6DoVtjptg57pzhh5AFdBPfM3dY2OuPy9ojcZ1BBKF4RCw07KwIU2LU1XSgb1+bmMS89MAL6MLLHOVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXziVmJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7209FC433F1;
	Mon, 19 Feb 2024 10:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708338313;
	bh=p1tLn3Yrs92lQ8kD/e1MBVf6hxU6mcgV7cfVI6sPNI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OXziVmJysu+PHLz5OXKIs6IJE/RCI10RctyDG4T+DED6qGXVVOGSpjWadnai/N0wH
	 9vHBAqxIXTJ+ZFPIchcVlxJq3joQpOJbUUdpoUwNRY6jW64jhHrV8IMLjU9YFyvawW
	 SSM2YJ1myPlYLDDPEnpQjd82+JYtkMMhsoPnDtfSevtkmQuIXi8TNVVyDR5hY+tuXz
	 TnbhuaG068lh0A3j/gZcwqQspaQ2vOvc+j3yPO5aDEiKGz0chFX03amjohxNYv2eRS
	 IGwbCUvJ7J0Y1p5jVtJ09UxzXbTBF90RdVbv4mavyaY9uT0jCJu84MtVeZZY0yIYx5
	 XMuvK+cq7PRHg==
Message-ID: <84e913c6-8dc9-464b-a2d9-2a9c95bd47e6@kernel.org>
Date: Mon, 19 Feb 2024 12:25:08 +0200
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
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240215110953.3225099-1-c-vankar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/02/2024 13:09, Chintan Vankar wrote:
> CPTS module supports capturing timestamp for every packet it receives,
> add a new function named "am65_cpts_rx_find_ts()" to get the timestamp
> of received packets from CPTS FIFO.
> 
> Add another function named "am65_cpts_rx_timestamp()" which internally
> calls "am65_cpts_rx_find_ts()" function and timestamps the received
> PTP packets.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>  drivers/net/ethernet/ti/am65-cpts.c | 84 +++++++++++++++++++++--------
>  drivers/net/ethernet/ti/am65-cpts.h | 11 ++--
>  2 files changed, 67 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
> index c66618d91c28..92a3b40e60d6 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.c
> +++ b/drivers/net/ethernet/ti/am65-cpts.c
> @@ -859,29 +859,6 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp)
>  	return delay;
>  }
>  
> -/**
> - * am65_cpts_rx_enable - enable rx timestamping
> - * @cpts: cpts handle
> - * @en: enable
> - *
> - * This functions enables rx packets timestamping. The CPTS can timestamp all
> - * rx packets.
> - */
> -void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
> -{
> -	u32 val;
> -
> -	mutex_lock(&cpts->ptp_clk_lock);
> -	val = am65_cpts_read32(cpts, control);
> -	if (en)
> -		val |= AM65_CPTS_CONTROL_TSTAMP_EN;
> -	else
> -		val &= ~AM65_CPTS_CONTROL_TSTAMP_EN;
> -	am65_cpts_write32(cpts, val, control);
> -	mutex_unlock(&cpts->ptp_clk_lock);
> -}
> -EXPORT_SYMBOL_GPL(am65_cpts_rx_enable);
> -

This function is used in am65-cpsw-nuss.c so this patch will
break build.

This looks like preparation for the workaround in next patch
which affects only some platforms. So please restrict this limitation
only to those platforms that are affected.

>  static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
>  {
>  	unsigned int ptp_class = ptp_classify_raw(skb);
> @@ -906,6 +883,67 @@ static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
>  	return 1;
>  }
>  
> +static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, struct sk_buff *skb,
> +				int ev_type, u32 skb_mtype_seqid)
> +{
> +	struct list_head *this, *next;
> +	struct am65_cpts_event *event;
> +	unsigned long flags;
> +	u32 mtype_seqid;
> +	u64 ns = 0;
> +
> +	am65_cpts_fifo_read(cpts);
> +	spin_lock_irqsave(&cpts->lock, flags);
> +	list_for_each_safe(this, next, &cpts->events) {
> +		event = list_entry(this, struct am65_cpts_event, list);
> +		if (time_after(jiffies, event->tmo)) {
> +			list_del_init(&event->list);
> +			list_add(&event->list, &cpts->pool);
> +			continue;
> +		}
> +
> +		mtype_seqid = event->event1 &
> +			      (AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK |
> +			       AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK |
> +			       AM65_CPTS_EVENT_1_EVENT_TYPE_MASK);
> +
> +		if (mtype_seqid == skb_mtype_seqid) {
> +			ns = event->timestamp;
> +			list_del_init(&event->list);
> +			list_add(&event->list, &cpts->pool);
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&cpts->lock, flags);
> +
> +	return ns;
> +}
> +
> +void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb)
> +{
> +	struct am65_cpts_skb_cb_data *skb_cb = (struct am65_cpts_skb_cb_data *)skb->cb;
> +	struct skb_shared_hwtstamps *ssh;
> +	int ret;
> +	u64 ns;
> +
> +	ret = am65_skb_get_mtype_seqid(skb, &skb_cb->skb_mtype_seqid);
> +	if (!ret)
> +		return; /* if not PTP class packet */
> +
> +	skb_cb->skb_mtype_seqid |= (AM65_CPTS_EV_RX << AM65_CPTS_EVENT_1_EVENT_TYPE_SHIFT);
> +
> +	dev_dbg(cpts->dev, "%s mtype seqid %08x\n", __func__, skb_cb->skb_mtype_seqid);
> +
> +	ns = am65_cpts_find_rx_ts(cpts, skb, AM65_CPTS_EV_RX, skb_cb->skb_mtype_seqid);
> +	if (!ns)
> +		return;
> +
> +	ssh = skb_hwtstamps(skb);
> +	memset(ssh, 0, sizeof(*ssh));
> +	ssh->hwtstamp = ns_to_ktime(ns);
> +}
> +EXPORT_SYMBOL_GPL(am65_cpts_rx_timestamp);
> +
>  /**
>   * am65_cpts_tx_timestamp - save tx packet for timestamping
>   * @cpts: cpts handle
> diff --git a/drivers/net/ethernet/ti/am65-cpts.h b/drivers/net/ethernet/ti/am65-cpts.h
> index 6e14df0be113..6099d772799d 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.h
> +++ b/drivers/net/ethernet/ti/am65-cpts.h
> @@ -22,9 +22,9 @@ void am65_cpts_release(struct am65_cpts *cpts);
>  struct am65_cpts *am65_cpts_create(struct device *dev, void __iomem *regs,
>  				   struct device_node *node);
>  int am65_cpts_phc_index(struct am65_cpts *cpts);
> +void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
>  void am65_cpts_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
>  void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
> -void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en);
>  u64 am65_cpts_ns_gettime(struct am65_cpts *cpts);
>  int am65_cpts_estf_enable(struct am65_cpts *cpts, int idx,
>  			  struct am65_cpts_estf_cfg *cfg);
> @@ -48,17 +48,18 @@ static inline int am65_cpts_phc_index(struct am65_cpts *cpts)
>  	return -1;
>  }
>  
> -static inline void am65_cpts_tx_timestamp(struct am65_cpts *cpts,
> +static inline void am65_cpts_rx_timestamp(struct am65_cpts *cpts,
>  					  struct sk_buff *skb)
>  {
>  }
>  
> -static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
> -					       struct sk_buff *skb)
> +static inline void am65_cpts_tx_timestamp(struct am65_cpts *cpts,
> +					  struct sk_buff *skb)
>  {
>  }
>  
> -static inline void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
> +static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
> +					       struct sk_buff *skb)
>  {
>  }
>  

-- 
cheers,
-roger

