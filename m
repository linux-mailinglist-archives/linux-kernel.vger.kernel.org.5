Return-Path: <linux-kernel+bounces-93985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C598737D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F0F1F2742A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A93131722;
	Wed,  6 Mar 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ak1d3DZC"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06745130AD5;
	Wed,  6 Mar 2024 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732275; cv=none; b=Whf0BBRLhepVwm+VbERXK9aAHpelNLnfaXkNp6d/LJURVfLUD8gxsGpMVap19kQcRuWKkOLjSqdDhhvYAB1Wt02k3zsB7fiqUpB1ePvOp5wps4V8GXElhMuKoVRHznGd1+Hnd3Y7/V57yJZnbB9/ZzSxMJa1JwOe8+RyX9HaXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732275; c=relaxed/simple;
	bh=FT0CuWap6zBzxhbKjuZ6jvoFoUhW89ZJUGjASGAUnVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ni6HPf/j/8/WFVCux/9KdNk5NeePW3LP4NTty/u3ISjyMIyav2EDDgfAZ9qep69CjWc9Fcd/74mhwplceHx4Md3XErXlXZJ7yOJ/tSCQ5vtrMD28o+GBD38peNMskP/o6hEK2MKH+Bp22bu61gC10vG+UPsW1drAHyGu9bUEn+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ak1d3DZC; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 45A8DE000C;
	Wed,  6 Mar 2024 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709732264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sy4JIC0/Wgrgbb/8vwfGd+8uG9N2YnNcKef9emZ4Q+Y=;
	b=Ak1d3DZCv1iDyVKudR877bHXBTN+ZKzEpLvMLpUYS11rNFGWn6QCz7Y4vKvg+VsttQFOcy
	EUOJU0z6mFdEMaK3Vn5svoJHos2RJh6c2Y3baSL56GP/WIm48IPKJ5292crTJFgKn+t8kX
	04QLU26nKbvY6BX4Ueqx4qqpcOs6iVBck8F5wLN0CJmR4hDDcVnh1Gea1XBpcS6cgra9Na
	iMAeecizJVBlkQ54fG6izl8hN/Vkmk4tu5NL41zOxg2p3xnxW/Eq2QyCfeeaGXockMMf4H
	B4GZe0coskS+BlgYcUneK34x7mZiTp10lNI71kqub4nXH1vlRIO8TjDI+bwndw==
Date: Wed, 6 Mar 2024 14:37:43 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/5] net: wan: Add support for QMC HDLC
Message-ID: <20240306143743.5732b298@bootlin.com>
In-Reply-To: <20240306105651.1210286-1-rkannoth@marvell.com>
References: <20240306080726.167338-2-herve.codina@bootlin.com>
	<20240306105651.1210286-1-rkannoth@marvell.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Ratheesh

On Wed, 6 Mar 2024 16:26:51 +0530
Ratheesh Kannoth <rkannoth@marvell.com> wrote:

..

> > +static void qmc_hcld_recv_complete(void *context, size_t length, unsigned int flags)
> > +{
> > +	struct qmc_hdlc_desc *desc = context;
> > +	struct net_device *netdev = desc->netdev;
> > +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);  
> Reverse xmas tree

The reverse xmas tree order cannot be used here.
qmc_hdlc depends on netdev, netdev depends on desc.

..
> > +static void qmc_hdlc_xmit_complete(void *context)
> > +{
> > +	struct qmc_hdlc_desc *desc = context;
> > +	struct net_device *netdev = desc->netdev;
> > +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> > +	struct sk_buff *skb;  
> Reverse xmas tree

Ditto

> > +
> > +	scoped_guard(spinlock_irqsave, &qmc_hdlc->tx_lock) {
> > +		dma_unmap_single(qmc_hdlc->dev, desc->dma_addr, desc->dma_size, DMA_TO_DEVICE);
> > +		skb = desc->skb;
> > +		desc->skb = NULL; /* Release the descriptor */
> > +		if (netif_queue_stopped(netdev))
> > +			netif_wake_queue(netdev);
> > +	}
> > +
> > +	netdev->stats.tx_packets++;
> > +	netdev->stats.tx_bytes += skb->len;
> > +
> > +	dev_consume_skb_any(skb);
> > +}
> > +
..
> > +
> > +static netdev_tx_t qmc_hdlc_xmit(struct sk_buff *skb, struct net_device *netdev)
> > +{
> > +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> > +	struct qmc_hdlc_desc *desc;
> > +	int err;
> > +
> > +	guard(spinlock_irqsave)(&qmc_hdlc->tx_lock);
> > +
> > +	desc = &qmc_hdlc->tx_descs[qmc_hdlc->tx_out];
> > +	if (WARN_ONCE(desc->skb, "No tx descriptors available\n")) {
> > +		/* Should never happen.
> > +		 * Previous xmit should have already stopped the queue.
> > +		 */
> > +		netif_stop_queue(netdev);
> > +		return NETDEV_TX_BUSY;
> > +	}
> > +
> > +	desc->netdev = netdev;
> > +	desc->dma_size = skb->len;
> > +	desc->skb = skb;
> > +	err = qmc_hdlc_xmit_queue(qmc_hdlc, desc);
> > +	if (err) {
> > +		desc->skb = NULL; /* Release the descriptor */
> > +		if (err == -EBUSY) {
> > +			netif_stop_queue(netdev);
> > +			return NETDEV_TX_BUSY;
> > +		}
> > +		dev_kfree_skb(skb);
> > +		netdev->stats.tx_dropped++;
> > +		return NETDEV_TX_OK;
> > +	}
> > +
> > +	qmc_hdlc->tx_out = (qmc_hdlc->tx_out + 1) % ARRAY_SIZE(qmc_hdlc->tx_descs);
> > +
> > +	if (qmc_hdlc->tx_descs[qmc_hdlc->tx_out].skb)  
> wont it race if tx completion and this function context run in different cpu ?

We are protected by the qmc_hdlc->tx_lock spinlock.

guard() call in this function and scoped_guard() call in qmc_hdlc_xmit_complete().

What is the race you thought of ?

> 
> > +		netif_stop_queue(netdev);
> > +
> > +	return NETDEV_TX_OK;
> > +}
> > +
..
> > +	/* Queue as many recv descriptors as possible */
> > +	for (i = 0; i < ARRAY_SIZE(qmc_hdlc->rx_descs); i++) {
> > +		desc = &qmc_hdlc->rx_descs[i];
> > +
> > +		desc->netdev = netdev;
> > +		ret = qmc_hdlc_recv_queue(qmc_hdlc, desc, chan_param.hdlc.max_rx_buf_size);
> > +		if (ret == -EBUSY && i != 0)
> > +			break; /* We use all the QMC chan capability */
> > +		if (ret)
> > +			goto free_desc;
> > +	}
> > +
> > +	ret = qmc_chan_start(qmc_hdlc->qmc_chan, QMC_CHAN_ALL);
> > +	if (ret) {
> > +		dev_err(qmc_hdlc->dev, "qmc chan start failed (%d)\n", ret);
> > +		goto free_desc;
> > +	}
> > +
> > +	netif_start_queue(netdev);
> > +
> > +	return 0;
> > +
> > +free_desc:
> > +	qmc_chan_reset(qmc_hdlc->qmc_chan, QMC_CHAN_ALL);
> > +	while (i--) {  
> Double free ? i'th descriptor skb is freed in qmc_hdlc_recv_queue() function's error handler itself.
> Should we be predecrement of i ?

Suppose a failure on i = 5. The item 5 is already cleaned (done by 
qmc_hdlc_recv_queue() itself).
The 'while (i--)' set i to 4 and operations are performed with i = 4, 3, 2, 1 and 0.

Where is the double free ?
Do I miss something ?

> 
> > +		desc = &qmc_hdlc->rx_descs[i];
> > +		dma_unmap_single(qmc_hdlc->dev, desc->dma_addr, desc->dma_size,
> > +				 DMA_FROM_DEVICE);
> > +		kfree_skb(desc->skb);
> > +		desc->skb = NULL;
> > +	}
> > +hdlc_close:
> > +	hdlc_close(netdev);
> > +	return ret;
> > +}
> > +
> > +

Best regards,
Hervé

