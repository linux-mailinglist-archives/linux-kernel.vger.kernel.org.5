Return-Path: <linux-kernel+bounces-76900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F89B85FE5E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712CA1C2572D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87753153BE4;
	Thu, 22 Feb 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dtJdpcTG"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C71E153BD5;
	Thu, 22 Feb 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620310; cv=none; b=PBEs8hTj+g+uUenW2Tuo0/2zpWdiSgFV980zPedo1falMycbG4Qrjni5wIBVXXBHsWhZ1oRz7b1v7Syd41lZqKGVq6WZJz3FU63D8E0UIZXSY4IdAp2EXCVnmO74AwCaFyHdczVQYQ/87stRFRSczflAaqHza+hvxxFIkpGxI/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620310; c=relaxed/simple;
	bh=z6rodNUccQ4xmU7Y7RME1ByXGIc5jRlFUiWlmpZB18Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iILknkK3gcESdL6mz/RXQfLnw+96YxiVMlYyKuyTfqsv5TQt8eYS9Yf1OAUViX9d5AWosvBDLRSlK+57gMxIN/bcGCgFWGxFJHeaeN4G/ppMiZ55HRQkAhJ2bdnTDSP/cfBgZ0phQ/yOgtuOz8j7lCwGEIzkNVJoSwqEj3MjKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dtJdpcTG; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F0FA1C000E;
	Thu, 22 Feb 2024 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708620305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugQVlVJpeQXBsFdN2IMSxN837NOg0+Zdb5sbx96BxmA=;
	b=dtJdpcTGIjeSZZpYrmyBG59jMtXBRcV5N1W+0XWKz/Zk/TuUEsQG4YgGfunYWBIIuCkQij
	7m7qEXCXzlnByoVeJHPniQmq4/X10I+ydMDG1OJnnaHxo9RdSwSwavnAip0d/+9qVJACq6
	hTnI7jGBLT525O3JjOTnwTZApqfq8bb8aLdR1n0obY8hK8e1VDK3qF0VHlXa63q6hIw3Aq
	o1jGlT4P70nIA3vIbCjePvwB8obkynKcAJpZfF81ug1oxMYZuFuwSvcoTMq0uDSfwd4d/a
	AF/R3qkhF/Sq90kMKXtXpFhgG3Y89lm4lIXpWEqTvZ5ON8qkrFA2e/2ps4h4lA==
Date: Thu, 22 Feb 2024 17:45:01 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/5] net: wan: Add support for QMC HDLC
Message-ID: <20240222174501.4cbe03ab@bootlin.com>
In-Reply-To: <ZddoQTg32unJJ_qP@smile.fi.intel.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
	<20240222142219.441767-2-herve.codina@bootlin.com>
	<ZddoQTg32unJJ_qP@smile.fi.intel.com>
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

On Thu, 22 Feb 2024 17:29:05 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Feb 22, 2024 at 03:22:14PM +0100, Herve Codina wrote:
> > The QMC HDLC driver provides support for HDLC using the QMC (QUICC
> > Multichannel Controller) to transfer the HDLC data.  
> 
> ...
> 
> > +struct qmc_hdlc {
> > +	struct device *dev;
> > +	struct qmc_chan *qmc_chan;
> > +	struct net_device *netdev;
> > +	bool is_crc32;
> > +	spinlock_t tx_lock; /* Protect tx descriptors */  
> 
> Just wondering if above tx/rx descriptors should be aligned on a cacheline
> for DMA?

These descriptors are not used by DMA.
Not sure that aligning them to a cacheline is really needed.

> 
> > +	struct qmc_hdlc_desc tx_descs[8];
> > +	unsigned int tx_out;
> > +	struct qmc_hdlc_desc rx_descs[4];
> > +};  
> 
> ...
> 
> > +#define QMC_HDLC_RX_ERROR_FLAGS (QMC_RX_FLAG_HDLC_OVF | \
> > +				 QMC_RX_FLAG_HDLC_UNA | \
> > +				 QMC_RX_FLAG_HDLC_ABORT | \
> > +				 QMC_RX_FLAG_HDLC_CRC)  
> 
> Wouldn't be slightly better to have it as
> 
> #define QMC_HDLC_RX_ERROR_FLAGS				\
> 	(QMC_RX_FLAG_HDLC_OVF | QMC_RX_FLAG_HDLC_UNA |	\
> 	 QMC_RX_FLAG_HDLC_CRC | QMC_RX_FLAG_HDLC_ABORT)
> 
> ?

Will be done in the next iteration.

> 
> ...
> 
> > +	ret = qmc_chan_write_submit(qmc_hdlc->qmc_chan, desc->dma_addr, desc->dma_size,
> > +				    qmc_hdlc_xmit_complete, desc);
> > +	if (ret) {  
> 
> > +		dev_err(qmc_hdlc->dev, "qmc chan write returns %d\n", ret);
> > +		dma_unmap_single(qmc_hdlc->dev, desc->dma_addr, desc->dma_size, DMA_TO_DEVICE);
> > +		return ret;  
> 
> I would do other way around, i.e. release resource followed up by printing
> a message. Printing a message is a slow operation and may prevent the (soon
> freed) resources to be re-used earlier.

Will do that in the next iteration.

> 
> > +	}  
> 
> ...
> 
> > +	spin_lock_irqsave(&qmc_hdlc->tx_lock, flags);  
> 
> Why not using cleanup.h from day 1?

I don't know about cleanup.h.
Can you tell me more ?
How should I use it ?

> 
> > +end:  
> 
> This label, in particular, will not be needed with above in place.
> 
> > +	spin_unlock_irqrestore(&qmc_hdlc->tx_lock, flags);
> > +	return ret;
> > +}  
> 
> ...
> 
> > +	/* Queue as many recv descriptors as possible */
> > +	for (i = 0; i < ARRAY_SIZE(qmc_hdlc->rx_descs); i++) {
> > +		desc = &qmc_hdlc->rx_descs[i];
> > +
> > +		desc->netdev = netdev;
> > +		ret = qmc_hdlc_recv_queue(qmc_hdlc, desc, chan_param.hdlc.max_rx_buf_size);  
> 
> > +		if (ret) {
> > +			if (ret == -EBUSY && i != 0)
> > +				break; /* We use all the QMC chan capability */
> > +			goto free_desc;
> > +		}  
> 
> Can be unfolded to
> 
> 		if (ret == -EBUSY && i)
> 			break; /* We use all the QMC chan capability */
> 		if (ret)
> 			goto free_desc;
> 
> Easy to read and understand.

Sure, will be changed.

> 
> > +	}  
> 
> ...
> 
> > +static int qmc_hdlc_probe(struct platform_device *pdev)
> > +{  
> 
> With
> 
> 	struct device *dev = &pdev->dev;
> 
> the below code will be neater (see other comments for the examples).

Will use that.

> 
> > +	struct device_node *np = pdev->dev.of_node;  
> 
> It is used only once, drop it (see below).

Ok.

> 
> > +	struct qmc_hdlc *qmc_hdlc;
> > +	struct qmc_chan_info info;
> > +	hdlc_device *hdlc;
> > +	int ret;
> > +
> > +	qmc_hdlc = devm_kzalloc(&pdev->dev, sizeof(*qmc_hdlc), GFP_KERNEL);
> > +	if (!qmc_hdlc)
> > +		return -ENOMEM;
> > +
> > +	qmc_hdlc->dev = &pdev->dev;
> > +	spin_lock_init(&qmc_hdlc->tx_lock);
> > +
> > +	qmc_hdlc->qmc_chan = devm_qmc_chan_get_bychild(qmc_hdlc->dev, np);  
> 
> 	qmc_hdlc->qmc_chan = devm_qmc_chan_get_bychild(dev, dev->of_node);
> 
> > +	if (IS_ERR(qmc_hdlc->qmc_chan)) {
> > +		ret = PTR_ERR(qmc_hdlc->qmc_chan);
> > +		return dev_err_probe(qmc_hdlc->dev, ret, "get QMC channel failed\n");  
> 
> 		return dev_err_probe(dev, PTR_ERR(qmc_hdlc->qmc_chan), "get QMC channel failed\n");
> 
> > +	}
> > +
> > +	ret = qmc_chan_get_info(qmc_hdlc->qmc_chan, &info);
> > +	if (ret) {  
> 
> > +		dev_err(qmc_hdlc->dev, "get QMC channel info failed %d\n", ret);
> > +		return ret;  
> 
> Why not using same message pattern everywhere, i.e. dev_err_probe()?
> 
> 		return dev_err_probe(dev, ret, "get QMC channel info failed\n");
> 
> (and so on...)

No reason. Just because I missed them.
Will be updated using dev_err_probe().

> 
> > +	}
> > +
> > +	if (info.mode != QMC_HDLC) {
> > +		dev_err(qmc_hdlc->dev, "QMC chan mode %d is not QMC_HDLC\n",
> > +			info.mode);
> > +		return -EINVAL;
> > +	}
> > +
> > +	qmc_hdlc->netdev = alloc_hdlcdev(qmc_hdlc);
> > +	if (!qmc_hdlc->netdev) {  
> 
> > +		dev_err(qmc_hdlc->dev, "failed to alloc hdlc dev\n");
> > +		return -ENOMEM;  
> 
> We do not issue a message for -ENOMEM.

And I know :(
Will be updated.

> 
> > +	}
> > +
> > +	hdlc = dev_to_hdlc(qmc_hdlc->netdev);
> > +	hdlc->attach = qmc_hdlc_attach;
> > +	hdlc->xmit = qmc_hdlc_xmit;
> > +	SET_NETDEV_DEV(qmc_hdlc->netdev, qmc_hdlc->dev);
> > +	qmc_hdlc->netdev->tx_queue_len = ARRAY_SIZE(qmc_hdlc->tx_descs);
> > +	qmc_hdlc->netdev->netdev_ops = &qmc_hdlc_netdev_ops;
> > +	ret = register_hdlc_device(qmc_hdlc->netdev);
> > +	if (ret) {
> > +		dev_err(qmc_hdlc->dev, "failed to register hdlc device (%d)\n", ret);
> > +		goto free_netdev;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, qmc_hdlc);
> > +
> > +	return 0;
> > +
> > +free_netdev:
> > +	free_netdev(qmc_hdlc->netdev);
> > +	return ret;
> > +}  
> 
> 

Thanks for the review.

Hervé

