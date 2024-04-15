Return-Path: <linux-kernel+bounces-145048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90A18A4EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F72428356D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9363B6BFA1;
	Mon, 15 Apr 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="c6JteyBP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pYvPM8TT"
Received: from flow4-smtp.messagingengine.com (flow4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B495CDE4;
	Mon, 15 Apr 2024 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183393; cv=none; b=kWUAN3QddrJ0AX7+sLPmfRM/IdGJbdj5y9Rx4z6c85rQYZ4s5fUE7xHPnCLtqW1Y/vTMAasSPdH4PIwMRULmG0ANLDSQ3VlIzFlhdMpfGYCz1H9GS4q0BqFILw1djbcCO1E1zD5nhYVmrIJXCHniDDhTAnY/gfEtmO2K4Pi3VYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183393; c=relaxed/simple;
	bh=5o4QV+AXnp+GTkThdr08xL+gf3k1Go1VLweGvzXihaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6k40xsJYxk8CJBzHYhgIXeEa4GVbkGWBy6H0I1vDzJyNGYsSPty+P6Ppd8fi9/9y2rQiGVTcI6NCcgfbQNb/rtGHg9aUCiiTmXk+07aN8OVYpq3UFDtch2x96u6Cg8Nx9oXKCsOUtpO5zdhRgfHZHCJNUkBAsALVIcrE62QLG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=c6JteyBP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pYvPM8TT; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.nyi.internal (Postfix) with ESMTP id E57AE2002D2;
	Mon, 15 Apr 2024 08:16:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 15 Apr 2024 08:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1713183384;
	 x=1713186984; bh=aOHnXwU/IwDpEpbUOpZg5QGXO1P+AAhaQ52M2fGjheo=; b=
	c6JteyBPguhIK5v42CcqfPro3rl1jW6wWKjvihZZ/ocnotd+srSDsWMnS3BN/A4w
	af3F8sJUjiu8GkGeimbzzCsGNr9NfbtZZINQ7bFgP0ueTLZCyifR0bYLHbDn57mJ
	dR+Uh5nktcoTx2zoJ+kkw3oJq58qZ9ap6LvEqT74S0hYGKts+7Gx3GXXg6e8fZmK
	2oRQN+FdmQEna9fcgHQflOAO38XvFMobYPucTkxnXh9qrxhelsoNLDIuq/1jZgpJ
	gpeKHfZYG6S4t7WDXQun9lDZOj5sutf0ECYHU/JJZXm8ILhwcmd5nTnHEh+OloOW
	yBTJSZRHpSO0pkAwkLggQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713183384; x=
	1713186984; bh=aOHnXwU/IwDpEpbUOpZg5QGXO1P+AAhaQ52M2fGjheo=; b=p
	YvPM8TT1pMvLp9EC0wfUfnk5/y4VGUIXNHvTFtMvmGPJtSmW0QqS2PNyciEMAIFF
	EJDzhEW7C9KpNZIJ8JX6wzIyCOEgZf8UMrt4GT5Q2ZiqbXSQXUGwdqIjWe8VK8wb
	sAinzPoT66wk9PfVRHF9VCMLvemswLS5V8rmgx1q9cgju01eT8lgXv98xSJEGgA6
	RD0x8pR9JjB/0YkwRsztUoTUdauk52MPOpuIbNK8unIAGPG8rAFcg51fwNEqvfqR
	tFQeq3npMif7mx9+EmI1eN3Ryc6s4nZzWDWgEYTDI7zg0Nk4mpRwHMmJ0jwl5tgA
	oIKX45gvOf/6y5pjSC/Tg==
X-ME-Sender: <xms:lxodZh41p0UtzkobInx3cP0ME_aIMIz21wCB0vXt6PQiwOo-h67pMg>
    <xme:lxodZu6tiCXaiFnb9V7NAXXNR4VLkFoLnqAkOm6w2LD_7Mafv33Iv0xGIeFpHa5it
    oXV1SG68PIX6AFMpak>
X-ME-Received: <xmr:lxodZoc6PnqFZPTXbpi5rEmBlVIuyxb-Az9A1S77R1waDFXgXbmpB8X43R_1UfJGqHW-FquUC9pYXVWY8w9weUYOL1ZKIXo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeejuefhtdeh
    feeuiedtffeuudevvdegteeffefggefhgedvtefgjeehfeetueetvdenucffohhmrghinh
    eprhgrvhgspghgvghnfegphhifpghinhhfohdrnhgvthdprhgrvhgspghgvghnvdgphhif
    pghinhhfohdrnhgvthdprhgrvhgspghriihvvdhmpghhfigpihhnfhhordhnvghtpdhgsg
    gvthhhpghhfigpihhnfhhordhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohguvghrlhhunhguodhrvghnvghsrg
    hssehrrghgnhgrthgvtghhrdhsvg
X-ME-Proxy: <xmx:lxodZqKha0Cwx3DPBPIIPObBuUhnxy3bgE21ZsSKcNYM_uDBhAOvUw>
    <xmx:lxodZlIip9o_Qz127kW7D1GJg22e58lRrYc0ZoSX-j2D5d7k9brt3Q>
    <xmx:lxodZjzlfYK_FsOjbdGP2lU4caZZitj1vvkGN4ggvxr8JYZzDXe2Lw>
    <xmx:lxodZhIUfHlfZ81Zb75RbmMQ70Zqd3rMUrWV7uZJM2WZcHAVQ1N3yw>
    <xmx:mBodZqqPUZto_sBvO7pR14J0k6pLLBYqq-n9mPina2QlLGtF0er17EOu>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 08:16:23 -0400 (EDT)
Date: Mon, 15 Apr 2024 14:16:21 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC v3 7/7] net: ravb: Allocate RX buffers via page
 pool
Message-ID: <20240415121621.GI3156415@ragnatech.se>
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-8-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415094804.8016-8-paul.barker.ct@bp.renesas.com>

Hi Paul,

I think using page pool is a good idea!

On 2024-04-15 10:48:04 +0100, Paul Barker wrote:
> This patch makes multiple changes that can't be separated:
> 
>   1) Allocate plain RX buffers via a page pool instead of allocating
>      SKBs, then use build_skb() when a packet is received.
>   2) For GbEth IP, reduce the RX buffer size to 2kB.
>   3) For GbEth IP, merge packets which span more than one RX descriptor
>      as SKB fragments instead of copying data.
> 
> Implementing (1) without (2) would require the use of an order-1 page
> pool (instead of an order-0 page pool split into page fragments) for
> GbEth.
> 
> Implementing (2) without (3) would leave us no space to re-assemble
> packets which span more than one RX descriptor.
> 
> Implementing (3) without (1) would not be possible as the network stack
> expects to use put_page() or page_pool_put_page() to free SKB fragments
> after an SKB is consumed.
> 
> This patch gives the following improvements during testing with iperf3.
> 
>   * RZ/G2L:
>     * TCP RX: same bandwidth at -43% CPU load (70% -> 40%)
>     * UDP RX: same bandwidth at -17% CPU load (88% -> 74%)
> 
>   * RZ/G2UL:
>     * TCP RX: +30% bandwidth (726Mbps -> 941Mbps)
>     * UDP RX: +417% bandwidth (108Mbps -> 558Mbps)
> 
>   * RZ/G3S:
>     * TCP RX: +64% bandwidth (562Mbps -> 920Mbps)
>     * UDP RX: +420% bandwidth (90Mbps -> 468Mbps)
> 
>   * RZ/Five:
>     * TCP RX: +217% bandwidth (145Mbps -> 459Mbps)
>     * UDP RX: +470% bandwidth (20Mbps -> 114Mbps)
> 
> There is no significant impact on bandwidth or CPU load in testing on
> RZ/G2H or R-Car M3N.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb.h      |  10 +-
>  drivers/net/ethernet/renesas/ravb_main.c | 209 +++++++++++++----------
>  2 files changed, 128 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> index 9c6392ade2f1..4348366c3dc7 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h
> @@ -1050,8 +1050,8 @@ struct ravb_hw_info {
>  	netdev_features_t net_features;
>  	int stats_len;
>  	u32 tccr_mask;
> +	u32 rx_buffer_size;
>  	u32 rx_max_frame_size;
> -	u32 rx_max_desc_use;
>  	u32 rx_desc_size;
>  	unsigned aligned_tx: 1;
>  	unsigned needs_irq_coalesce:1;	/* Needs software IRQ coalescing */
> @@ -1071,6 +1071,11 @@ struct ravb_hw_info {
>  	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
>  };
>  
> +struct ravb_rx_buffer {
> +	struct page *page;
> +	unsigned int offset;
> +};
> +
>  struct ravb_private {
>  	struct net_device *ndev;
>  	struct platform_device *pdev;
> @@ -1094,7 +1099,8 @@ struct ravb_private {
>  	struct ravb_tx_desc *tx_ring[NUM_TX_QUEUE];
>  	void *tx_align[NUM_TX_QUEUE];
>  	struct sk_buff *rx_1st_skb;
> -	struct sk_buff **rx_skb[NUM_RX_QUEUE];
> +	struct page_pool *rx_pool;

Don't we need a page pool per queue? Else multiple calls to 
ravb_ring_init() and ravb_ring_free() for different queues will 
otherwise risk allocating over a previous queue and multiple free the 
same one.

> +	struct ravb_rx_buffer *rx_buffers[NUM_RX_QUEUE];
>  	struct sk_buff **tx_skb[NUM_TX_QUEUE];
>  	u32 rx_over_errors;
>  	u32 rx_fifo_errors;
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 7434faf0820c..892a3eadef1e 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -30,6 +30,7 @@
>  #include <linux/reset.h>
>  #include <linux/math64.h>
>  #include <net/ip.h>
> +#include <net/page_pool/helpers.h>
>  
>  #include "ravb.h"
>  
> @@ -113,25 +114,6 @@ static void ravb_set_rate_rcar(struct net_device *ndev)
>  	}
>  }
>  
> -static struct sk_buff *
> -ravb_alloc_skb(struct net_device *ndev, const struct ravb_hw_info *info,
> -	       gfp_t gfp_mask)
> -{
> -	struct sk_buff *skb;
> -	u32 reserve;
> -
> -	skb = __netdev_alloc_skb(ndev, info->rx_max_frame_size + RAVB_ALIGN - 1,
> -				 gfp_mask);
> -	if (!skb)
> -		return NULL;
> -
> -	reserve = (unsigned long)skb->data & (RAVB_ALIGN - 1);
> -	if (reserve)
> -		skb_reserve(skb, RAVB_ALIGN - reserve);
> -
> -	return skb;
> -}
> -
>  /* Get MAC address from the MAC address registers
>   *
>   * Ethernet AVB device doesn't have ROM for MAC address.
> @@ -257,21 +239,10 @@ static void ravb_rx_ring_free(struct net_device *ndev, int q)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	unsigned int ring_size;
> -	unsigned int i;
>  
>  	if (!priv->rx_ring[q].raw)
>  		return;
>  
> -	for (i = 0; i < priv->num_rx_ring[q]; i++) {
> -		struct ravb_rx_desc *desc = ravb_rx_get_desc(priv, q, i);
> -
> -		if (!dma_mapping_error(ndev->dev.parent,
> -				       le32_to_cpu(desc->dptr)))
> -			dma_unmap_single(ndev->dev.parent,
> -					 le32_to_cpu(desc->dptr),
> -					 priv->info->rx_max_frame_size,
> -					 DMA_FROM_DEVICE);
> -	}
>  	ring_size = priv->info->rx_desc_size * (priv->num_rx_ring[q] + 1);
>  	dma_free_coherent(ndev->dev.parent, ring_size, priv->rx_ring[q].raw,
>  			  priv->rx_desc_dma[q]);
> @@ -298,13 +269,14 @@ static void ravb_ring_free(struct net_device *ndev, int q)
>  		priv->tx_ring[q] = NULL;
>  	}
>  
> -	/* Free RX skb ringbuffer */
> -	if (priv->rx_skb[q]) {
> -		for (i = 0; i < priv->num_rx_ring[q]; i++)
> -			dev_kfree_skb(priv->rx_skb[q][i]);
> +	/* Free RX buffers */
> +	for (i = 0; i < priv->num_rx_ring[q]; i++) {
> +		if (priv->rx_buffers[q][i].page)
> +			page_pool_put_page(priv->rx_pool, priv->rx_buffers[q][i].page, 0, true);
>  	}
> -	kfree(priv->rx_skb[q]);
> -	priv->rx_skb[q] = NULL;
> +	kfree(priv->rx_buffers[q]);
> +	priv->rx_buffers[q] = NULL;
> +	page_pool_destroy(priv->rx_pool);
>  
>  	/* Free aligned TX buffers */
>  	kfree(priv->tx_align[q]);
> @@ -317,35 +289,54 @@ static void ravb_ring_free(struct net_device *ndev, int q)
>  	priv->tx_skb[q] = NULL;
>  }
>  
> +static int
> +ravb_alloc_rx_buffer(struct net_device *ndev, int q, u32 entry, gfp_t gfp_mask,
> +		     __le32 *dptr)

Why not pass the struct ravb_rx_desc instead of a dptr? Then the 
function can deal with the error case and fill in rx_desc->dptr and 
rx_desc->ds_cc directly making the caller simpler.

> +{
> +	struct ravb_private *priv = netdev_priv(ndev);
> +	const struct ravb_hw_info *info = priv->info;
> +	struct ravb_rx_buffer *rx_buff = &priv->rx_buffers[q][entry];
> +	dma_addr_t dma_addr;
> +	unsigned int size;
> +
> +	size = info->rx_buffer_size;
> +	rx_buff->page = page_pool_alloc(priv->rx_pool, &rx_buff->offset, &size,
> +					gfp_mask);
> +	if (unlikely(!rx_buff->page))
> +		return -ENOMEM;
> +
> +	dma_addr = page_pool_get_dma_addr(rx_buff->page) + rx_buff->offset;
> +	dma_sync_single_for_device(ndev->dev.parent, dma_addr,
> +				   info->rx_buffer_size, DMA_FROM_DEVICE);
> +	*dptr = cpu_to_le32(dma_addr);
> +	return 0;
> +}
> +
>  static u32
>  ravb_rx_ring_refill(struct net_device *ndev, int q, u32 count, gfp_t gfp_mask)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
>  	struct ravb_rx_desc *rx_desc;
> -	dma_addr_t dma_addr;
>  	u32 i, entry;
>  
>  	for (i = 0; i < count; i++) {
>  		entry = (priv->dirty_rx[q] + i) % priv->num_rx_ring[q];
>  		rx_desc = ravb_rx_get_desc(priv, q, entry);
> -		rx_desc->ds_cc = cpu_to_le16(info->rx_max_desc_use);
>  
> -		if (!priv->rx_skb[q][entry]) {
> -			priv->rx_skb[q][entry] = ravb_alloc_skb(ndev, info, gfp_mask);
> -			if (!priv->rx_skb[q][entry])
> -				break;
> -			dma_addr = dma_map_single(ndev->dev.parent,
> -						  priv->rx_skb[q][entry]->data,
> -						  priv->info->rx_max_frame_size,
> -						  DMA_FROM_DEVICE);
> -			skb_checksum_none_assert(priv->rx_skb[q][entry]);
> -			/* We just set the data size to 0 for a failed mapping
> -			 * which should prevent DMA from happening...
> -			 */
> -			if (dma_mapping_error(ndev->dev.parent, dma_addr))
> +		if (!priv->rx_buffers[q][entry].page) {
> +			if (unlikely(ravb_alloc_rx_buffer(ndev, q, entry, gfp_mask,
> +							  &rx_desc->dptr))) {
> +				/* We just set the data size to 0 for a failed mapping
> +				 * which should prevent DMA from happening...
> +				 */
>  				rx_desc->ds_cc = cpu_to_le16(0);
> -			rx_desc->dptr = cpu_to_le32(dma_addr);
> +				break;
> +			}
> +
> +			rx_desc->ds_cc = cpu_to_le16(info->rx_buffer_size
> +						     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
> +						     - ETH_FCS_LEN + sizeof(__sum16));

Can a comment be added to why we subtract and add things to the size?

>  		}
>  		/* Descriptor type must be set after all the above writes */
>  		dma_wmb();
> @@ -423,15 +414,32 @@ static int ravb_ring_init(struct net_device *ndev, int q)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	unsigned int num_tx_desc = priv->num_tx_desc;
> +	struct page_pool_params params = {
> +		.order = 0,
> +		.flags = PP_FLAG_DMA_MAP,
> +		.pool_size = priv->num_rx_ring[q],
> +		.nid = NUMA_NO_NODE,
> +		.dev = ndev->dev.parent,
> +		.dma_dir = DMA_FROM_DEVICE,
> +	};
>  	unsigned int ring_size;
>  	u32 num_filled;
>  
> -	/* Allocate RX and TX skb rings */
> -	priv->rx_skb[q] = kcalloc(priv->num_rx_ring[q],
> -				  sizeof(*priv->rx_skb[q]), GFP_KERNEL);
> +	/* Allocate RX page pool and buffers */
> +	priv->rx_pool = page_pool_create(&params);

I think we need one pool per queue.

> +	if (IS_ERR(priv->rx_pool))
> +		goto error;
> +
> +	/* Allocate RX buffers */
> +	priv->rx_buffers[q] = kcalloc(priv->num_rx_ring[q],
> +				      sizeof(*priv->rx_buffers[q]), GFP_KERNEL);
> +	if (!priv->rx_buffers[q])
> +		goto error;
> +
> +	/* Allocate TX skb rings */
>  	priv->tx_skb[q] = kcalloc(priv->num_tx_ring[q],
>  				  sizeof(*priv->tx_skb[q]), GFP_KERNEL);
> -	if (!priv->rx_skb[q] || !priv->tx_skb[q])
> +	if (!priv->tx_skb[q])
>  		goto error;
>  
>  	if (num_tx_desc > 1) {
> @@ -755,25 +763,11 @@ static void ravb_rx_csum(struct sk_buff *skb)
>  	skb_trim(skb, skb->len - sizeof(__sum16));
>  }
>  
> -static struct sk_buff *ravb_get_skb_gbeth(struct net_device *ndev, int entry,
> -					  struct ravb_rx_desc *desc)
> -{
> -	struct ravb_private *priv = netdev_priv(ndev);
> -	struct sk_buff *skb;
> -
> -	skb = priv->rx_skb[RAVB_BE][entry];
> -	priv->rx_skb[RAVB_BE][entry] = NULL;
> -	dma_unmap_single(ndev->dev.parent, le32_to_cpu(desc->dptr),
> -			 ALIGN(priv->info->rx_max_frame_size, 16),
> -			 DMA_FROM_DEVICE);
> -
> -	return skb;
> -}
> -
>  /* Packet receive function for Gigabit Ethernet */
>  static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
> +	const struct ravb_hw_info *info = priv->info;
>  	struct net_device_stats *stats;
>  	struct ravb_rx_desc *desc;
>  	struct sk_buff *skb;
> @@ -817,12 +811,23 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
>  			if (desc_status & MSC_CEEF)
>  				stats->rx_missed_errors++;
>  		} else {
> +			struct ravb_rx_buffer *rx_buff = &priv->rx_buffers[q][entry];
> +			void *rx_addr = page_address(rx_buff->page) + rx_buff->offset;
>  			die_dt = desc->die_dt & 0xF0;
> -			skb = ravb_get_skb_gbeth(ndev, entry, desc);
> +			dma_sync_single_for_cpu(ndev->dev.parent, le32_to_cpu(desc->dptr),
> +						desc_len, DMA_FROM_DEVICE);
> +
>  			if (die_dt == DT_FSINGLE || die_dt == DT_FSTART) {
>  				/* Start of packet:
> -				 * Set initial data length.
> +				 * Prepare an SKB and add initial data.
>  				 */
> +				skb = napi_build_skb(rx_addr, info->rx_buffer_size);
> +				if (unlikely(!skb)) {
> +					stats->rx_errors++;
> +					page_pool_put_page(priv->rx_pool, rx_buff->page, 0, true);
> +					break;
> +				}
> +				skb_mark_for_recycle(skb);
>  				skb_put(skb, desc_len);
>  
>  				/* Save this SKB if the packet spans multiple
> @@ -832,14 +837,23 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
>  					priv->rx_1st_skb = skb;
>  			} else {
>  				/* Continuing a packet:
> -				 * Move data into the saved SKB.
> +				 * Add this buffer as an RX frag.
>  				 */
> -				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
> -							       priv->rx_1st_skb->len,
> -							       skb->data,
> -							       desc_len);
> -				skb_put(priv->rx_1st_skb, desc_len);
> -				dev_kfree_skb(skb);
> +
> +				/* rx_1st_skb will be NULL if napi_build_skb()
> +				 * failed for the first descriptor of a
> +				 * multi-descriptor packet.
> +				 */
> +				if (unlikely(!priv->rx_1st_skb)) {
> +					stats->rx_errors++;
> +					page_pool_put_page(priv->rx_pool, rx_buff->page, 0, true);
> +					break;
> +				}
> +
> +				skb_add_rx_frag(priv->rx_1st_skb,
> +						skb_shinfo(priv->rx_1st_skb)->nr_frags,
> +						rx_buff->page, rx_buff->offset,
> +						desc_len, info->rx_buffer_size);
>  
>  				/* Set skb to point at the whole packet so that
>  				 * we only need one code path for finishing a
> @@ -859,7 +873,16 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
>  				stats->rx_bytes += skb->len;
>  				napi_gro_receive(&priv->napi[q], skb);
>  				rx_packets++;
> +
> +				/* Clear rx_1st_skb so that it will only be
> +				 * non-NULL when valid.
> +				 */
> +				if (die_dt == DT_FEND)
> +					priv->rx_1st_skb = NULL;
>  			}
> +
> +			/* Mark this RX buffer as consumed. */
> +			rx_buff->page = NULL;
>  		}
>  	}
>  
> @@ -875,6 +898,7 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
>  static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
> +	const struct ravb_hw_info *info = priv->info;
>  	struct net_device_stats *stats = &priv->stats[q];
>  	struct ravb_ex_rx_desc *desc;
>  	struct sk_buff *skb;
> @@ -917,13 +941,20 @@ static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
>  			if (desc_status & MSC_CEEF)
>  				stats->rx_missed_errors++;
>  		} else {
> +			struct ravb_rx_buffer *rx_buff = &priv->rx_buffers[q][entry];
> +			void *rx_addr = page_address(rx_buff->page) + rx_buff->offset;
>  			u32 get_ts = priv->tstamp_rx_ctrl & RAVB_RXTSTAMP_TYPE;
>  
> -			skb = priv->rx_skb[q][entry];
> -			priv->rx_skb[q][entry] = NULL;
> -			dma_unmap_single(ndev->dev.parent, le32_to_cpu(desc->dptr),
> -					 priv->info->rx_max_frame_size,
> -					 DMA_FROM_DEVICE);
> +			skb = napi_build_skb(rx_addr, info->rx_buffer_size);
> +			if (unlikely(!skb)) {
> +				stats->rx_errors++;
> +				page_pool_put_page(priv->rx_pool, rx_buff->page, 0, true);
> +				break;
> +			}
> +			dma_sync_single_for_cpu(ndev->dev.parent, le32_to_cpu(desc->dptr),
> +						pkt_len, DMA_FROM_DEVICE);
> +			rx_buff->page = NULL;
> +			skb_mark_for_recycle(skb);
>  			get_ts &= (q == RAVB_NC) ?
>  					RAVB_RXTSTAMP_TYPE_V2_L2_EVENT :
>  					~RAVB_RXTSTAMP_TYPE_V2_L2_EVENT;
> @@ -2588,8 +2619,8 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
>  	.net_features = NETIF_F_RXCSUM,
>  	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
>  	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
> +	.rx_buffer_size = SZ_2K + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
>  	.rx_max_frame_size = SZ_2K,
> -	.rx_max_desc_use = SZ_2K - ETH_FCS_LEN + sizeof(__sum16),
>  	.rx_desc_size = sizeof(struct ravb_ex_rx_desc),
>  	.internal_delay = 1,
>  	.tx_counters = 1,
> @@ -2612,8 +2643,8 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
>  	.net_features = NETIF_F_RXCSUM,
>  	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
>  	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
> +	.rx_buffer_size = SZ_2K + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
>  	.rx_max_frame_size = SZ_2K,
> -	.rx_max_desc_use = SZ_2K - ETH_FCS_LEN + sizeof(__sum16),
>  	.rx_desc_size = sizeof(struct ravb_ex_rx_desc),
>  	.aligned_tx = 1,
>  	.gptp = 1,
> @@ -2633,8 +2664,8 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
>  	.net_features = NETIF_F_RXCSUM,
>  	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
>  	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
> +	.rx_buffer_size = SZ_2K + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
>  	.rx_max_frame_size = SZ_2K,
> -	.rx_max_desc_use = SZ_2K - ETH_FCS_LEN + sizeof(__sum16),
>  	.rx_desc_size = sizeof(struct ravb_ex_rx_desc),
>  	.multi_irqs = 1,
>  	.err_mgmt_irqs = 1,
> @@ -2656,8 +2687,8 @@ static const struct ravb_hw_info gbeth_hw_info = {
>  	.net_features = NETIF_F_RXCSUM | NETIF_F_HW_CSUM,
>  	.stats_len = ARRAY_SIZE(ravb_gstrings_stats_gbeth),
>  	.tccr_mask = TCCR_TSRQ0,
> +	.rx_buffer_size = SZ_2K,
>  	.rx_max_frame_size = SZ_8K,
> -	.rx_max_desc_use = 4080,
>  	.rx_desc_size = sizeof(struct ravb_rx_desc),
>  	.aligned_tx = 1,
>  	.tx_counters = 1,
> -- 
> 2.39.2
> 

-- 
Kind Regards,
Niklas Söderlund

