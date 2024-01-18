Return-Path: <linux-kernel+bounces-30227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B355831BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52856284BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391181DDD6;
	Thu, 18 Jan 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iYhp9ce+"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111F1DA2C;
	Thu, 18 Jan 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589468; cv=none; b=K1JrghzpB5PZuqxvkIW6oEaSlCNb0INg+6jzvFxuagAsU+03JRaxVChCFwrpI/nBYHPERF3bCcJXdv7K43SNt1wX6gkGWOrYNG4ZMPbt+/p2R28V566TQVuMdCHug/D4KcYSQL7ej882Se9x0sVq9IdQl+EGMP9oeUzm0/9F/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589468; c=relaxed/simple;
	bh=9HT/J2YrGV32WG9ndtwBMjG87bXMcxVYdGZQI50FypA=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-GND-Sasl; b=gTpVlnIUEASLpanrDYp+zrMnV+nqMmelgYl//bPpq8ypcYh9W1UH7pTUej2DhCjHuP7yiI7ooaybvpSl+I3jh6HiZJTKcsjQT0yQKzFwaVYkxXAmrp3xLAK+vBLqHJuQ5gbOIS/w5oLZknjNN2NH4EHKS6TEaFbi4FCnkAoIHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iYhp9ce+; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFD94240008;
	Thu, 18 Jan 2024 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705589458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMhcaK2e3PZz/7cegmKl+hjKc6UEroUDTsWP92eg0Lc=;
	b=iYhp9ce+WpA2LL4JkDtR+OWQCdemg9gc7voU055UzmHdrg0430KMV6KuCsMoTln51RxvnK
	zW+FNFV0oUtO2UncdqZYKkgXRo6n0QFWm6R+IvonyPYam+bU4wxZ2MyrbTRN2TCXLEohB9
	8qdKn+PGWHCzkB/sTjK1S880ZprmYDKvJDnxipQh6VQHWzOqw6yLb+z1u37v6Y6PubMq7a
	7t1pYgwL1cdnbZLb9ZCNR7uDl/4KwS/E6aV3EvNEllymjAZ3l3ZUJIfNFq1NcgMgz3l6ow
	9ND9o8/RCk3A55nF6VMVuLLLLZZ0IWa4A/1r11lSvOsaHRoKciy+qfHjgIyK5Q==
Date: Thu, 18 Jan 2024 15:50:53 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: <marcin.s.wojtas@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [net v3 PATCH 1/1] net: mvpp2: clear BM pool before
 initialization
Message-ID: <20240118155053.6c1bc52a@device-28.home>
In-Reply-To: <20240118081447.3884278-1-jpatel2@marvell.com>
References: <20240118081447.3884278-1-jpatel2@marvell.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Thu, 18 Jan 2024 00:14:47 -0800
Jenishkumar Maheshbhai Patel <jpatel2@marvell.com> wrote:

> Register value persist after booting the kernel using
> kexec which results in kernel panic. Thus clear the
> BM pool registers before initialisation to fix the issue.

[...]

> +/* Cleanup pool before actual initialization in the OS */
> +static void mvpp2_bm_pool_cleanup(struct mvpp2 *priv, int pool_id)
> +{
> +	u32 val;
> +	int i;
> +	unsigned int thread = mvpp2_cpu_to_thread(priv, get_cpu());

Please sort these lines with the longest line at the top, following the
reverse christmas-tree style.

> +
> +	/* Drain the BM from all possible residues left by firmware */
> +	for (i = 0; i < MVPP2_BM_POOL_SIZE_MAX; i++)
> +		mvpp2_thread_read(priv, thread, MVPP2_BM_PHY_ALLOC_REG(pool_id));

Since you don't need to use the thread-based accessors after this, you
can call put_cpu() right now to avoid keeping preemption disabled
unnecessarily for too long.

> +	/* Stop the BM pool */
> +	val = mvpp2_read(priv, MVPP2_BM_POOL_CTRL_REG(pool_id));
> +	val |= MVPP2_BM_STOP_MASK;
> +	mvpp2_write(priv, MVPP2_BM_POOL_CTRL_REG(pool_id), val);
> +
> +	/* Mask BM all interrupts */
> +	mvpp2_write(priv, MVPP2_BM_INTR_MASK_REG(pool_id), 0);
> +
> +	/* Clear BM cause register */
> +	mvpp2_write(priv, MVPP2_BM_INTR_CAUSE_REG(pool_id), 0);

These two registers dealing with interrupt masking and cause are
already cleared in mvpp2_bm_init(), not shown in the diff context, so
either you can remove these or the ones in mvpp2_bm_init().

> +	put_cpu();
> +}
> +
>  static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)
>  {
>  	enum dma_data_direction dma_dir = DMA_FROM_DEVICE;
>  	int i, err, poolnum = MVPP2_BM_POOLS_NUM;
>  	struct mvpp2_port *port;
>  
> +	if (priv->percpu_pools)
> +		poolnum = mvpp2_get_nrxqs(priv) * 2;
> +
> +	/* Clean up the pool state in case it contains stale state */
> +	for (i = 0; i < poolnum; i++)
> +		mvpp2_bm_pool_cleanup(priv, i);
> +
>  	if (priv->percpu_pools) {
>  		for (i = 0; i < priv->port_count; i++) {
>  			port = priv->port_list[i];
> @@ -629,7 +661,6 @@ static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)
>  			}
>  		}
>  
> -		poolnum = mvpp2_get_nrxqs(priv) * 2;
>  		for (i = 0; i < poolnum; i++) {
>  			/* the pool in use */
>  			int pn = i / (poolnum / 2);

Thanks,

Maxime

