Return-Path: <linux-kernel+bounces-56395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C936A84C9A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F5F4B2226B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8678E1B7EE;
	Wed,  7 Feb 2024 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEznwrhH"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BC71AADD;
	Wed,  7 Feb 2024 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305682; cv=none; b=QbvOzpTI2qQbWP1U/cnt/JYf4V5OzCeMHlG5gu4SB2l9SmsAjGk2T8NlfWtsoDm0qLqOQkwHpmQFzH6J8LvYd5H+RsHLaN4lX03S5aUTZzoRRQr3f9YUUwQGn82z/BVGNr3qQ8nQkqdXqF0xm51Kwt9OXG31X4F5aLeNU2umsgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305682; c=relaxed/simple;
	bh=fHEmx2+YD6aSghPKIzxTl0lTC3dy/fynUqTivLKdpsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCDIA9c7W90BsLL9/tu76IZQLoSwIoZ30nNDzynmX2/Nf+rwDx6lVaYCqfolHLakdGh5nq2MGctZIFl/u/pkWzczeQJPLdhaIZX6+aUTcAWcIksbSGhC2mBK1zTAoqf/NetQKtHHOfhZ4VkQlbpAjFHMm2VFtUJ0C1cyMW68Wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEznwrhH; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d09b21a8bbso5667411fa.3;
        Wed, 07 Feb 2024 03:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707305679; x=1707910479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPQzZxl5bE1RItDITVNujm+ZmvjYJeoOtU5sHIw4Szs=;
        b=NEznwrhHXDPNAAxvvge/J5bYcF4/ZEYGwbyWrKIJnhfgjCf3JnqiWyikdnEyGa/taM
         RL1XTjjxeRXJsQEhjIELibcuX9LvO31sowufNZL83MlZk5prHjAFyYeP9dE16VcGRky6
         HDfiTd2RYgmru8tptbBYc1lztVpH2PDr3HYpgbumQ8wViKXEAndzKc8588tyOtX6Q+vd
         dbi3wdRIFsiJGGZT3aKQyxytOfj+LodP32HqClf2Hi6Qp7PWVAmPnBox51LyeczNYJQo
         ZZM76+heNUfga+GCMOx+BZyxbmQylAnmG8XI3/xV3ahjikHCAuxJib12n1WIlS4BeO6n
         ICFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707305679; x=1707910479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPQzZxl5bE1RItDITVNujm+ZmvjYJeoOtU5sHIw4Szs=;
        b=WRO7qD9qFpNB5kUhcUIEVTZMA+9F6oKiyJTzmyWWp6x4emEXCCfqlXhPNoxmZzThq8
         PqtnvosYlWVlJ9D6tjvDTMp1J1spFgqNCUraA8vifqToR8ZHjh7raTf2StBz2OyX4PGq
         JofWq/rfVT/M694zkw4zkgFY+vDZs4khO/IqbPPs++IzcdopEx31zX5tMb3meptsHuxk
         21YG+GazF1gMJHcd2rLrUOaaXRSnyKcnHEn1Wo2FFBJzbfRJ3RE9lVaKiRtFQo67o+dz
         YOxowdh2PWK1f8T1HG3xiPqZdiVEeFNrnwEde5d3WsGoR3SUfGctpOlEuKL2IxrjrCHi
         Hqbw==
X-Gm-Message-State: AOJu0YyvX4eyMF2dg2xB8FJVCNuxHZfLeywiVe6RdD5xwWpyAa0jAn30
	glA4nZ097UVseGUhZs0xDqVqhSLfa8s5z3Bbw8CVFlUWoxNN7Jc3
X-Google-Smtp-Source: AGHT+IFtHTL1sJ/QvAt+78/YRYABzfZKnDNRbo56DjDqklw/3Z6EPdqKy3AIocI3PHi8NhHTSurcFg==
X-Received: by 2002:a2e:9992:0:b0:2d0:9076:e9cc with SMTP id w18-20020a2e9992000000b002d09076e9ccmr4268383lji.29.1707305678385;
        Wed, 07 Feb 2024 03:34:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPe5zFF9e6iqt4dBN6yTi7bU1Mk4W5dqeCN8tJ8xEbbnrz8Gc7cE2oCKwiHti8Gx/YzrcsG5BP0GT+OD+3SPL7hrhSNYfN2cMZ+dhbteqMsmeSVdRvQ8ED4C+NR0zJuO/zgFBHu1k6/CA7leb1eAO3OsvjdwJbgYTjQ+tompJjlsypzA1bZN8g8RnY46/H1MTgrHlDuEnbsnC1aBK+SOipw6QqbqRExkYsWKIZ9u8gGucNRpuJrVQeQ/1pdgnYl/3UDXE6VPZeRuB0p6TxVsbKkIBbXt30aR1JqHgDXn51fdn6pTxk84G1N/zXFL1mwNEoKnu57/1ude+sA/RSXrVyo/JD2G2XB4vAH0Le8bZjfYjtgrEydQn03O9JR7Zx+m3TTyDoj9XM8AFweb5P+YPDD7r75FZURhL4ingHlDtsbCHNYgmkrus/lvQIur4m8IULurTLu6c5svaOEwl5cAWd59WtRSVeFyikZO5v34Bkcu89QD6G7qNrYKNK7nTU
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t1-20020a2e7801000000b002d0a6b9d0casm145443ljc.67.2024.02.07.03.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:34:38 -0800 (PST)
Date: Wed, 7 Feb 2024 14:34:33 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Simon Horman <horms@kernel.org>, Pavel Sakharov <p.sakharov@ispras.ru>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH] stmmac: Fix incorrect dereference in stmmac_*_interrupt()
Message-ID: <tg2au3a524douxq6k37aa73zuotlx5sl6hbcokm7xwy3bumqxc@lothlyjh6ksg>
References: <20240203150323.1041736-1-p.sakharov@ispras.ru>
 <20240206150704.GD1104779@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206150704.GD1104779@kernel.org>

On Tue, Feb 06, 2024 at 03:07:04PM +0000, Simon Horman wrote:
> On Sat, Feb 03, 2024 at 06:03:21PM +0300, Pavel Sakharov wrote:
> > If 'dev' is NULL, the 'priv' variable has an incorrect address when
> > dereferencing calling netdev_err().
> > 
> > Pass 'dev' instead of 'priv->dev" to the function.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Signed-off-by: Pavel Sakharov <p.sakharov@ispras.ru>
> 
> Thanks Pavel,
> 
> I agree with your analysis that this can result in a NULL dereference.
> And that your proposed fix is good: netdev_err() can handle a NULL
> dev argument.
> 
> As this seems to be a fix I suggest it should be for net.
> And that it should be based on that tree and designated as such
> in the subject:
> 
> Subject: [PATCH net] ...
> 
> Also if it is a fix, it should have a fixes tag.
> Perhaps this one:
> 
> Fixes: 8532f613bc78 ("net: stmmac: introduce MSI Interrupt routines for mac, safety, RX & TX")
> 
> 
> I don't think there is a need to respin for the above, though please
> keep this in mind when posting Networking patches in future.
> 
> 
> Looking at the patch above, and stmmac_main.c, it seems that the following
> functions also suffer from a similar problem:
> 
> static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
> {
> 	struct stmmac_tx_queue *tx_q = (struct stmmac_tx_queue *)data;
> 	...
> 	dma_conf = container_of(tx_q, struct stmmac_dma_conf, tx_queue[chan]);
> 	priv = container_of(dma_conf, struct stmmac_priv, dma_conf);
> 
> 	if (unlikely(!data)) {
> 		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
> 		...
> 
> And stmmac_msi_intr_rx(), which follows a similar pattern
> to stmmac_msi_intr_tx().
> 
> I also note that in those functions "invalid dev pointer" seems misleading,
> perhaps it ought to be "invalid queue" pointer.
> 
> As these problems seem to all have been introduced at the same time,
> perhaps it is appropriate to fix them all in one patch?

IMO we can just drop these and the noted in the patch checks. Before
actually making a decision about that there are three general
questions we'd need to answer to:

1. Do we trust the IRQ-subsystem to supply a correct cookie pointer
specified during the IRQ request procedure?

2. Do we trust the driver code for correctly performing the IRQs
request?

3. If we don't trust to any of that then what is caused if the problem
happens and there is no sanity checks implemented?

Here are my thoughts regarding that:

1. If no dev_id sanity checks implemented in the handlers then having
the IRQ requested with NULL argument passed even though the handlers
imply the netdev pointer will for sure cause troubles right away since
the driver won't work and the system will likely crash. So it will be
spotted during the initial test/debug stage of the respective change.

2. If for some reason the IRQ subsystem supplied a NULL pointer
instead of the cookie pointer, then something is really wrong and the
entire system likely won't work correctly. If this case is possible
to happen then all the kernel IRQ handlers should have been
implemented with such sanity check, which I don't see in practice.

3. If IRQ was caused by the DW *MAC controller, but NULL pointer is
passed and the handler returns IRQ_NONE state, then the actual IRQ
won't be handled AFAICS causing the spurious IRQs detected. Eventually
the IRQ will be effectively disabled. In anyway the driver will stop
working. But even if this happens see points 1. and 2. for the
problem cause implications.

4. The common IRQ handler doesn't have such check in the driver.
Though unlike the rest of the handlers it's assigned with the
IRQF_SHARED flag which requires the cookie pointer passed. Anyway the
sanity check was removed from the common IRQ handler in the commit
f42234ffd531 ("stmmac: fix pointer check after utilization in
stmmac_interrupt") with a justification as being _paranoidal_ and
pointless in the respective context. But in about a year afterwards
the individual IRQ handlers were introduced with the same check but
this time in a bit more reasonable context. Still it doesn't make
the check existence less paranoidal.

5. I took a look at first 20 Ethernet device drivers. None of them has
such checks implemented even though about half of them request IRQs as
non-shared (so the cookie pointer is optional).

6. Finally the checks are implemented in the hard IRQ handlers for
which the less code the better.

To sum all the above up from my point of view the checks are redundant
of course unless we turn on the paranoidal mode and stop trusting the
driver code and the IRQ subsystem.

-Serge(y)

> 
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 4727f7be4f86..5ab5148013cd 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5848,7 +5848,7 @@ static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id)
> >  	struct stmmac_priv *priv = netdev_priv(dev);
> > 
> >  	if (unlikely(!dev)) {
> > -		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
> > +		netdev_err(dev, "%s: invalid dev pointer\n", __func__);
> >  		return IRQ_NONE;
> >  	}
> > 
> > @@ -5868,7 +5868,7 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
> >  	struct stmmac_priv *priv = netdev_priv(dev);
> > 
> >  	if (unlikely(!dev)) {
> > -		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
> > +		netdev_err(dev, "%s: invalid dev pointer\n", __func__);
> >  		return IRQ_NONE;
> >  	}
> > 
> > 
> 

