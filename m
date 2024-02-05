Return-Path: <linux-kernel+bounces-52806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F210849CE3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C07D1F255D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC0B24A19;
	Mon,  5 Feb 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WdMAS6Pl"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A2208CF;
	Mon,  5 Feb 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142947; cv=none; b=Sm+i+4ywVn4nKcmFPsP+597qPzc/A70bQLMoFe1fsCuo66WcQolvDxJQi4PQEOtvPvwyt6AHi9H1OtEMf/+B9Bz+hbDp+L41r9rAlIIrU0FOR4r9ShBPpN+0eDd6mpgv3eJiWYKEKzcphjJk/T30M5bKAeyKUKvcwC3wSoS8PJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142947; c=relaxed/simple;
	bh=Vw2SAecBla8SZnOrBn7LhxnEfGK2jVWevzfkWLpQbyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYnzvStT9kkQq2BA/6FfIvioZy6QCiXQGyWPJNBuI28VaVikcmY8Ox23i/RWhkmFtLYGy+n6bfEQCUwfauSMBowA4Hm/V48Xxstl3DaEi4PnKY8CRG5yMvncAOydBgA6FDK6lJC7tGkuRgM+p38jQjeSNDAGwp84yYHEsR7PmPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WdMAS6Pl; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B0CD1BF207;
	Mon,  5 Feb 2024 14:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707142935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X2lRUb3hksFq0yfXVR20ELEXLC5m7R4eEvD1161wPtg=;
	b=WdMAS6PlW2bnMePzgM6xEUHFKbQpsK4l7I/RklZs+yFf7G3x3LNLqzH6/eXQ4wk/qSV+ZH
	+6qibOM+9FntESYWxTuAcQNBqOq3A5Nd2SlaeYqAFsibQnE4roQHGyKDfvxFJi0uFhupVr
	RGMjwnie8DBep4z5og7UbQDoAHhlz4eJe7gcGw2todrNHvxTE/l3bBGzmXFHKaBOK2foLC
	VEW/3doORkGTr+/mrjW4QsxUMoloETwRldasNYuCYKYXi5Ef8iwxH0g9yISE3yk5fM/D6x
	TtwHGzwLvp/N7+U5KLqkYV5pxIl4ZFent2eL2dtTVVeacPk8iVDVQ2J6g34iZA==
Date: Mon, 5 Feb 2024 15:22:08 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Vadim Fedorenko  <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/6] net: wan: Add support for QMC HDLC
Message-ID: <20240205152208.73535549@bootlin.com>
In-Reply-To: <b1968b5c7e88edd448d5f55b57dfa40257b2b06c.camel@redhat.com>
References: <20240130084035.115086-1-herve.codina@bootlin.com>
	<20240130084035.115086-2-herve.codina@bootlin.com>
	<b1968b5c7e88edd448d5f55b57dfa40257b2b06c.camel@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Paolo,

On Thu, 01 Feb 2024 12:41:32 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

[...]
> > +static inline struct qmc_hdlc *netdev_to_qmc_hdlc(struct net_device *netdev)
> > +{
> > +	return dev_to_hdlc(netdev)->priv;
> > +}  
> 
> Please, no 'inline' function in c files. You could move this function
> and the struct definition into a new, local, header file.

'inline' function specifier will be removed in the next iteration on the series.

> 
> > +static int qmc_hdlc_recv_queue(struct qmc_hdlc *qmc_hdlc, struct qmc_hdlc_desc *desc, size_t size);
> > +
> > +#define QMC_HDLC_RX_ERROR_FLAGS (QMC_RX_FLAG_HDLC_OVF | \
> > +				 QMC_RX_FLAG_HDLC_UNA | \
> > +				 QMC_RX_FLAG_HDLC_ABORT | \
> > +				 QMC_RX_FLAG_HDLC_CRC)
> > +
> > +static void qmc_hcld_recv_complete(void *context, size_t length, unsigned int flags)
> > +{
> > +	struct qmc_hdlc_desc *desc = context;
> > +	struct net_device *netdev = desc->netdev;
> > +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> > +	int ret;  
> 
> Please, respect the reverse x-mas tree order for local variable
> definition.

desc depends on context, netdev depends on desc and qmc_hdlc depends on netdev.
I think the declaration order is correct here even it doesn't respect the reverse
x-mas tree.

[...]
> > +static netdev_tx_t qmc_hdlc_xmit(struct sk_buff *skb, struct net_device *netdev)
> > +{
> > +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> > +	struct qmc_hdlc_desc *desc;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&qmc_hdlc->tx_lock, flags);
> > +	desc = &qmc_hdlc->tx_descs[qmc_hdlc->tx_out];
> > +	if (WARN_ONCE(!desc->skb, "No tx descriptors available\n")) {
> > +		/* Should never happen.
> > +		 * Previous xmit should have already stopped the queue.
> > +		 */
> > +		netif_stop_queue(netdev);
> > +		spin_unlock_irqrestore(&qmc_hdlc->tx_lock, flags);
> > +		return NETDEV_TX_BUSY;
> > +	}
> > +	spin_unlock_irqrestore(&qmc_hdlc->tx_lock, flags);
> > +
> > +	desc->netdev = netdev;
> > +	desc->dma_size = skb->len;
> > +	desc->skb = skb;
> > +	ret = qmc_hdlc_xmit_queue(qmc_hdlc, desc);
> > +	if (ret) {
> > +		desc->skb = NULL; /* Release the descriptor */
> > +		if (ret == -EBUSY) {
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
> > +	spin_lock_irqsave(&qmc_hdlc->tx_lock, flags);
> > +	if (qmc_hdlc->tx_descs[qmc_hdlc->tx_out].skb)
> > +		netif_stop_queue(netdev);
> > +	spin_unlock_irqrestore(&qmc_hdlc->tx_lock, flags);  
> 
> The locking schema is quite bad, as the drivers acquires and releases 3
> locks for each tx packet. You could improve that using the qmc_chan-
> >tx_lock to protect the whole qmc_hdlc_xmit() function, factoring out a  
> lockless variant of qmc_hdlc_xmit_queue(), and using it here.

I will change on next iteration and keep 2 lock/unlock instead of 3:
  - one in qmc_hdlc_xmit()
  - one in qmc_hdlc_xmit_complete() 
to protect the descriptors accesses.

> 
> In general is quite bad that the existing infra does not allow
> leveraging NAPI. Have you considered expanding the QMC to accomodate
> such user?

I cannot mask/unmask the 'end of transfer' interrupt.
Indeed, other streams use this interrupt among them audio streams and so
masking the interrupt for HDLC data will also mask the interrupt for audio
data.

At the HDLC driver level, the best I can to is to store a queue of complete
HDLC skbs (queue filled on interrupts) and send them to the network stack
when the napi poll() is called.

I am not sure that this kind of queue (additional level between always
enabled interrupts and the network stack) makes sense.

Do you have any opinion about this additional queue management for NAPI
support?

Best regards,
Hervé

