Return-Path: <linux-kernel+bounces-48221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503A38458B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3ABE28634B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776265B691;
	Thu,  1 Feb 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGeshPGW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C105B668;
	Thu,  1 Feb 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793558; cv=none; b=uyTvvBeHOF1BGxw1vYr0T88XZ5zYhp7Bt/dhwGswzh3ajKTCKU3lZOIB4/yiIkp4l3LmTMRnDWw+aYSYo2QkixgWq6PMLvMKVsDkyX0GAhTtJwrU9UXmePln0QnFyVAnYPOfeL3ScuZ8uzMe2+Bq9k6JhjmBv/HEOS0Z+RwhmmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793558; c=relaxed/simple;
	bh=FFD56dUdbAUbT8JZopy6JG4NEbZIpOLOT2UUi5bvTzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkXVfy5mZIshxEQxX2T6TQKDftrNrWdALqeQvHyVqXCxtb1NcR2fw6RsFr4MeGZV+ddK93UeIWAokFQC96TGT12K3bM+evL5yergMUDsCZtCAjhhCJgrNfLk3+RnFRaegYGw/jC3M3/NlsZXqdzD/xk8edpz9n6qqKnVqE/B8ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGeshPGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC4EC433F1;
	Thu,  1 Feb 2024 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706793557;
	bh=FFD56dUdbAUbT8JZopy6JG4NEbZIpOLOT2UUi5bvTzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KGeshPGWC6fVIh7d1Mnn6i6xGxQ4ZsvSTB3H9RU5Xy1HY4SZnPmFLVt8DTZjr2Pda
	 o3Kw6dyYMIrN3HYGCiMmlovzi7SVUXkXlbCDj4DpMAPpYe0TIuYKBZ+cTkAa7SBPpT
	 c7ctIeDi7jUnMWgs4J/OGOEQpj/xc7HcSlVM0lmuLBbblzfR5n3iRE/ohVnCUroTM3
	 ZLKVm+3YDcyC9Nzo+pMHUvy60eQvmlXBgm29e0KRTu0F0hjMHXk0CV8xBcoXdAKCn1
	 Rw/ojXLAhD4ey4VRfHU7Ta9rBbHTJeGC0kRNXDWri2J3lkSuTsbIi2A8cgWEtsqtes
	 ThbsUVBleuKTA==
Date: Thu, 1 Feb 2024 14:19:12 +0100
From: Simon Horman <horms@kernel.org>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, rogerq@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, srk@ti.com
Subject: Re: [RFC PATCH net-next 2/2] net: ethernet: ti: inter-core-virt-eth:
 Register as network device
Message-ID: <20240201131912.GB530335@kernel.org>
References: <20240130110944.26771-1-r-gunasekaran@ti.com>
 <20240130110944.26771-3-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130110944.26771-3-r-gunasekaran@ti.com>

On Tue, Jan 30, 2024 at 04:39:44PM +0530, Ravi Gunasekaran wrote:
> Register the RPMsg driver as network device and add support for
> basic ethernet functionality by using the shared memory for data
> plane.
> 
> The shared memory layout is as below, with the region between
> PKT_1_LEN to PKT_N modelled as circular buffer.
> 
> -------------------------
> |          HEAD         |
> -------------------------
> |          TAIL         |
> -------------------------
> |       PKT_1_LEN       |
> |         PKT_1         |
> -------------------------
> |       PKT_2_LEN       |
> |         PKT_2         |
> -------------------------
> |           .           |
> |           .           |
> -------------------------
> |       PKT_N_LEN       |
> |         PKT_N         |
> -------------------------
> 
> The offset between the HEAD and TAIL is polled to process the Rx packets.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Hi Ravi,

some feedback, mainly regarding issues flagged by linters and static analysis.

> ---
>  drivers/net/ethernet/ti/inter-core-virt-eth.c | 316 ++++++++++++++++++
>  drivers/net/ethernet/ti/inter-core-virt-eth.h |  16 +
>  2 files changed, 332 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/inter-core-virt-eth.c b/drivers/net/ethernet/ti/inter-core-virt-eth.c
> index d3b689eab1c0..735482001f4d 100644
> --- a/drivers/net/ethernet/ti/inter-core-virt-eth.c
> +++ b/drivers/net/ethernet/ti/inter-core-virt-eth.c
> @@ -6,6 +6,50 @@
>  
>  #include "inter-core-virt-eth.h"
>  
> +#define ICVE_MIN_PACKET_SIZE	ETH_ZLEN
> +#define ICVE_MAX_PACKET_SIZE	(ETH_FRAME_LEN + ETH_FCS_LEN)
> +#define ICVE_MAX_TX_QUEUES	1
> +#define ICVE_MAX_RX_QUEUES	1
> +
> +#define TEST_DEBUG		1

Please remove TEST_DEBUG and associated code.
This does not seem appropriate for upstream.

> +
> +#ifdef TEST_DEBUG
> +#define ICVE_MAX_BUFFERS	100 //TODO : Set to power of 2 to leverage shift operations
> +#endif
> +
> +#define PKT_LEN_SIZE_TYPE	sizeof(u32)
> +
> +/* 4 bytes to hold packet length and ICVE_MAX_PACKET_SIZE to hold packet */
> +#define ICVE_BUFFER_SIZE	(ICVE_MAX_PACKET_SIZE + PKT_LEN_SIZE_TYPE)
> +
> +#define RX_POLL_TIMEOUT		250
> +
> +#define icve_ndev_to_priv(ndev) \
> +	((struct icve_ndev_priv *)netdev_priv(ndev))
> +#define icve_ndev_to_port(ndev) (icve_ndev_to_priv(ndev)->port)
> +#define icve_ndev_to_common(ndev) (icve_ndev_to_port(ndev)->common)
> +
> +static void icve_rx_timer(struct timer_list *timer)
> +{
> +	struct icve_port *port = from_timer(port, timer, rx_timer);
> +	struct napi_struct *napi;
> +	int num_pkts = 0;
> +	u32 head, tail;
> +
> +	head = port->rx_buffer->head;
> +	tail = port->rx_buffer->tail;
> +
> +	num_pkts = tail - head;
> +	num_pkts = num_pkts >= 0 ? num_pkts : (num_pkts + port->icve_max_buffers);

Networking (still) prefers code to be < 80 columns wide.
In this case I'd probably go for (completely untested!):

	num_pkts = tail - head;
	if (num_pkts <= 0)
		num_pkts = num_pkts + port->icve_max_buffers;

Please consider running checkpatch as it is run by the CI.

[1] https://github.com/linux-netdev/nipa/blob/main/tests/patch/checkpatch/checkpatch.sh`

> +
> +	napi = &port->rx_napi;
> +	if (num_pkts && likely(napi_schedule_prep(napi))) {
> +		__napi_schedule(napi);
> +	} else {
> +		mod_timer(&port->rx_timer, RX_POLL_TIMEOUT);

Smatch warns that mod_timer takes an absolute time rather than an offset.
So, perhaps (completely untested!):

		mod_timer(&port->rx_timer, jiffies + RX_POLL_TIMEOUT);

> +	}

If any arm of an if statement has {} then all should,
but {} is not needed unless there is more than one statement
convered by conditions.

So (completely untested!):

	if (num_pkts && likely(napi_schedule_prep(napi)))
		__napi_schedule(napi);
	else
		mod_timer(&port->rx_timer, jiffies + RX_POLL_TIMEOUT);

..

> @@ -85,11 +145,262 @@ static int create_request(struct icve_common *common, enum icve_rpmsg_type rpmsg
>  	return ret;
>  }
>  
> +static int icve_rx_packets(struct napi_struct *napi, int budget)
> +{
> +	struct icve_port *port = container_of(napi, struct icve_port, rx_napi);
> +	u32 count, process_pkts;
> +	struct sk_buff *skb;
> +	u32 head, tail;
> +	u32 pkt_len;
> +	int num_pkts;

nit: Please use reverse xmas tree - longest line to shortest - for local
     variables in Networking code.

This tool can help achieve that.
* https://github.com/ecree-solarflare/xmastree

> +
> +	head = port->rx_buffer->head;
> +	tail = port->rx_buffer->tail;
> +
> +	num_pkts = tail - head;
> +	num_pkts = num_pkts >= 0 ? num_pkts : (num_pkts + port->icve_max_buffers);
> +	process_pkts = min(num_pkts, budget);
> +	count = 0;
> +	while (count < process_pkts) {
> +		memcpy((void *)&pkt_len,
> +		       (void *)port->rx_buffer->base_addr + ((head + count) * ICVE_BUFFER_SIZE),
> +		       PKT_LEN_SIZE_TYPE);

I don't think there is any need to cast to (void *) like this.

..

> +static netdev_tx_t icve_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct icve_port *port = icve_ndev_to_port(ndev);
> +	struct ethhdr *ether;
> +	u32 head, tail;
> +	u32 num_pkts;
> +	u32 len;
> +
> +	ether = eth_hdr(skb);

ether is assigned but otherwise unused in this function.

Flaged by W=1 builds using both gcc-13 and clang-17.

> +	len = skb_headlen(skb);
> +
> +	head = port->tx_buffer->head;
> +	tail = port->tx_buffer->tail;
> +
> +	/* If the buffer queue is full, then drop packet */
> +	num_pkts = tail - head;
> +	num_pkts = num_pkts >= 0 ? num_pkts : (num_pkts + port->icve_max_buffers);

num_pkts is unsigned, so the condition above is always true.

Flagged by Coccinelle and Smatch.

> +	if ((num_pkts + 1) == port->icve_max_buffers) {
> +		netdev_warn(ndev, "Tx buffer full\n");
> +		goto ring_full;
> +	}
> +
> +	/* Copy length */
> +	memcpy((void *)port->tx_buffer->base_addr + (port->tx_buffer->tail * ICVE_BUFFER_SIZE),
> +	       (void *)&len, PKT_LEN_SIZE_TYPE);
> +
> +	/* Copy data to shared mem */
> +	memcpy((void *)(port->tx_buffer->base_addr + PKT_LEN_SIZE_TYPE) +
> +	       (port->tx_buffer->tail * ICVE_BUFFER_SIZE),
> +	       (void *)skb->data, len);
> +
> +#ifdef TEST_DEBUG
> +	/* For quick Rx path testing, inject Tx pkt back into network */
> +	test_tx_rx_path(skb, ndev);
> +#endif
> +	port->tx_buffer->tail = (port->tx_buffer->tail + 1) % port->icve_max_buffers;
> +
> +	dev_consume_skb_any(skb);
> +
> +	return NETDEV_TX_OK;
> +
> +ring_full:
> +	return NETDEV_TX_BUSY;
> +}
> +
> +static int icve_set_mac_address(struct net_device *ndev, void *addr)
> +{
> +	eth_mac_addr(ndev, addr);
> +
> +	/* TODO : Inform remote core about MAC address change */
> +	return 0;
> +}
> +
> +static const struct net_device_ops icve_netdev_ops = {
> +	.ndo_open		= icve_ndo_open,
> +	.ndo_stop		= icve_ndo_stop,
> +	.ndo_start_xmit		= icve_start_xmit,
> +	.ndo_set_mac_address	= icve_set_mac_address,
> +};
> +
> +static int icve_init_ndev(struct icve_common *common)
> +{
> +	struct device *dev = &common->rpdev->dev;
> +	struct icve_ndev_priv *ndev_priv;
> +	struct icve_port *port;
> +	static u32 port_id;
> +	int err;
> +
> +	port = common->port;
> +	port->common = common;
> +	port->port_id = port_id++;
> +
> +	port->ndev = devm_alloc_etherdev_mqs(common->dev, sizeof(*ndev_priv),
> +					     ICVE_MAX_TX_QUEUES,
> +					     ICVE_MAX_RX_QUEUES);
> +
> +	if (!port->ndev) {
> +		dev_err(dev, "error allocating net_device\n");
> +		return -ENOMEM;
> +	}
> +
> +	ndev_priv = netdev_priv(port->ndev);
> +	ndev_priv->port = port;
> +	SET_NETDEV_DEV(port->ndev, dev);
> +
> +	port->ndev->min_mtu = ICVE_MIN_PACKET_SIZE;
> +	port->ndev->max_mtu = ICVE_MAX_PACKET_SIZE;
> +	port->ndev->netdev_ops = &icve_netdev_ops;
> +
> +#ifdef TEST_DEBUG
> +	/* Allocate memory to test without actual RPMsg handshaking */
> +	port->tx_buffer = devm_kzalloc(dev, sizeof(port->tx_buffer),
> +				       GFP_KERNEL);

(I think this code should be removed, but in any case I'll flag
 the problems that I am aware of.)

This allocates the size of the port->tx_buffer pointer, rather than the
size of port->tx_buffer itself (4 or 8 bytes instead of 12 or 16 bytes).
So perhaps it should be (completely untested!):

	port->tx_buffer = devm_kzalloc(dev, sizeof(*port->tx_buffer),
				       GFP_KERNEL);

Flagged by Sparse.


> +	if (!port->tx_buffer) {
> +		dev_err(dev, "Memory not available\n");

Out of memory messages will be logged by the code.
So there is no need for the dev_err() call above.

> +		return -ENOMEM;
> +	}
> +
> +	port->tx_buffer->base_addr = devm_kzalloc(dev, ICVE_BUFFER_SIZE * ICVE_MAX_BUFFERS,
> +						  GFP_KERNEL);
> +	if (!port->tx_buffer->base_addr) {
> +		dev_err(dev, "Memory not available\n");
> +		return -ENOMEM;
> +	}
> +
> +	port->rx_buffer = devm_kzalloc(dev, sizeof(port->rx_buffer),
> +				       GFP_KERNEL);
> +	if (!port->rx_buffer) {
> +		dev_err(dev, "Memory not available\n");
> +		return -ENOMEM;
> +	};
> +
> +	port->rx_buffer->base_addr = devm_kzalloc(dev, ICVE_BUFFER_SIZE * ICVE_MAX_BUFFERS,
> +						  GFP_KERNEL);
> +	if (!port->rx_buffer->base_addr) {
> +		dev_err(dev, "Memory not available\n");
> +		return -ENOMEM;
> +	}
> +
> +	port->icve_max_buffers = ICVE_MAX_BUFFERS;
> +#else
> +	/* Shared memory details will be sent by the remote core.
> +	 * So turn off the carrier, until both the virtual port and
> +	 * remote core is ready
> +	 */
> +	netif_carrier_off(port->ndev);
> +
> +#endif
> +	err = register_netdev(port->ndev);
> +
> +	if (err)
> +		dev_err(dev, "error registering icve net device %d\n", err);
> +
> +	return 0;
> +}
> +

..

> diff --git a/drivers/net/ethernet/ti/inter-core-virt-eth.h b/drivers/net/ethernet/ti/inter-core-virt-eth.h

..

> @@ -70,7 +78,11 @@ struct shared_mem {
>  struct icve_port {
>  	struct shared_mem *tx_buffer; /* Write buffer for data to be consumed remote side */
>  	struct shared_mem *rx_buffer; /* Read buffer for data to be consumed by this driver */
> +	struct timer_list rx_timer;
>  	struct icve_common *common;
> +	struct napi_struct rx_napi;
> +	u8 local_mac_addr[ETH_ALEN];

local_mac_addr does not appear to be used in this patch.
If so, please drop it and add it when it is needed.

> +	struct net_device *ndev;
>  	u32 icve_max_buffers;
>  	u32 port_id; /* Unique ID for the port : TODO: Define range for use by Linux and non linux */
>  

..

