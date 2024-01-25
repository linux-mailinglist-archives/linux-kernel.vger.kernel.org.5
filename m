Return-Path: <linux-kernel+bounces-39171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE3783CBE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F1DB23535
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4E134757;
	Thu, 25 Jan 2024 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUGtQ9dw"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052EE13472F;
	Thu, 25 Jan 2024 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209642; cv=none; b=amXsiaFeK6HCTQuzhMIMli2115OmGr339jGuu9Pso/W7PQ+B1ntLMzs4dvQj3W4vc7jMIXIfOJcSE2BX5bT6eKcToS0+toO6RNNbp4+Wgx9MghFJujN34+GKMI0DpTtCyye2VduOAhHrXxviC3f7zRp2kuHznhdw4qqam9LvLY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209642; c=relaxed/simple;
	bh=RnD7tYCwHSLN/q0PwDQwMfAmXnWnTGqNIuvwuelXl9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5cNLAqO0nt+8N9ezYDq4Urj6sL3aebYg2VXHsZg/MP2LiThNTafyuypgmFL0zCPG+G0SwdpsfMF63Ktmw9RTJracI+BEdQezj5qi1wJHDrlnJXEMAlX2pgGWtH3Rw9oUIF/IxkcvJM6GQklAETnzqM3QJbshT3yph826Qz50sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUGtQ9dw; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf354613easo13908031fa.1;
        Thu, 25 Jan 2024 11:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706209639; x=1706814439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXr+6RTm2y0jFaSgxtjxgqNsWNZTUA5ivbr5rQKXoKM=;
        b=BUGtQ9dwSOUYnSSRj1j91Cnssy5HvVDYYNzVDsUzyg10r3S2GpjXZFpIR/d+fi1JhW
         BXCK8yrE6e/A9gBvO9XAGuRwLDhX5xOMOdj8RaU/vgzNC2mDbbM1YGNyDes4W9UGMMr2
         PVeuCu9FM5r9yBdnPgd/mKWQ8xfRwmjOtzYNoY+bZIV5VhVfTllpYeYqNDicohhfiOPl
         qh2n4YIWIIGKMqpx+7+6FiV3OkygodtpdMniyzgw2l+Q8gx65ED4lT34UR3FOsArR/eR
         LCTwypBCqe87gHzfKu8Lwbir56wuzFWcqDLsNazkSti0ZLQE3PBYKEfYBlJ8CI99g/iK
         KqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706209639; x=1706814439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXr+6RTm2y0jFaSgxtjxgqNsWNZTUA5ivbr5rQKXoKM=;
        b=dYTLzgXin8rECAxAxiFqNNq2S3CCFpzCSa7vBaKq90uYE93H6ykznCDMPjsVnei/gD
         R+VLz7REUPhRHo4muCSLXMSIzrF8e8PVYIJuGThfCl9mxKl7brYOEiSdcrn8ac2RkBF1
         fyBy/GpRfK5JiMTKNETlve9KlP7QgbFouPsuItklBR0QBTDH7N86B3n7LJpUYIgZBgFR
         XhNr5cwflUYQpfYYJwTxIw0QAszBPUSdDp9IafIVokbLQnm2QcYqCT3lotxi7lmdwscp
         ayYnaL/WK+eVuW2iM1r4UaspjyFDow3/NBJuBcnMdA1x097ufbRbWNESF7E0JCVQgqZx
         G9+g==
X-Gm-Message-State: AOJu0YzWyBBPMEjYwIbh7N2F+z4gwi2jFBD0QwvPgLvm4xMCV3PgEh/f
	dOJ+KysrzN9H94hAhRP17JJfWdCgQuPeWrYkB23A6EHSRvxjO13W
X-Google-Smtp-Source: AGHT+IGRO7XLqxNPmXpytHm/jv8xSj2MEwW928f4bFwxrqq6A1bFNX0EYOUDQ4O2bEA5tfrTPBuSyg==
X-Received: by 2002:a2e:be1f:0:b0:2cd:a311:6aec with SMTP id z31-20020a2ebe1f000000b002cda3116aecmr115609ljq.21.1706209638688;
        Thu, 25 Jan 2024 11:07:18 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id l15-20020a2ea30f000000b002cf1033e8bdsm363582lje.30.2024.01.25.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:07:18 -0800 (PST)
Date: Thu, 25 Jan 2024 22:07:15 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net] net: stmmac: xgmac: fix handling of DPP safety error
 for DMA channels
Message-ID: <czebrzszux2gdik3ey54tr3iewsxs4hjom432eb527jcpftnnr@ftiiwofakorj>
References: <20240123095006.979437-1-0x1207@gmail.com>
 <vsert76o6lxxc676tjiiikir577qobfonyo6sgo5eek6alzxlo@tb6hq5s2qcsp>
 <20240125105620.000040b7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125105620.000040b7@gmail.com>

On Thu, Jan 25, 2024 at 10:56:20AM +0800, Furong Xu wrote:
> On Wed, 24 Jan 2024 17:36:10 +0300
> Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> > On Tue, Jan 23, 2024 at 05:50:06PM +0800, Furong Xu wrote:
> > > Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> > > XGMAC core") checks and reports safety errors, but leaves the
> > > Data Path Parity Errors for each channel in DMA unhandled at all, lead to
> > > a storm of interrupt.
> > > Fix it by checking and clearing the DMA_DPP_Interrupt_Status register.
> > > 
> > > Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> > > Signed-off-by: Furong Xu <0x1207@gmail.com>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h      | 1 +
> > >  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 6 ++++++
> > >  2 files changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > > index 207ff1799f2c..188e11683136 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > > @@ -385,6 +385,7 @@
> > >  #define XGMAC_DCEIE			BIT(1)
> > >  #define XGMAC_TCEIE			BIT(0)
> > >  #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
> > > +#define XGMAC_DMA_DPP_INT_STATUS	0x00003074
> > >  #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
> > >  #define XGMAC_SPH			BIT(24)
> > >  #define XGMAC_PBLx8			BIT(16)
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > index eb48211d9b0e..874e85b499e2 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > @@ -745,6 +745,12 @@ static void dwxgmac3_handle_mac_err(struct net_device *ndev,
> > >  
> > >  	dwxgmac3_log_error(ndev, value, correctable, "MAC",
> > >  			   dwxgmac3_mac_errors, STAT_OFF(mac_errors), stats);
> > > +
> > > +	value = readl(ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> > > +	writel(value, ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> > > +
> > > +	if (value)
> > > +		netdev_err(ndev, "Found DMA_DPP error, status: 0x%x\n", value);  
> > 
> > 1. Why not to implement this in the same way as the rest of the safety
> > errors handle code? (with the flags described by the
> > dwxgmac3_error_desc-based table and the respective counters being
> > incremented should the errors were detected)
> > 

> XGMAC_DMA_DPP_INT_STATUS is just a bitmap of DMA RX and TX channels,
> bottom 16 bits for 16 DMA TX channels and top 16 bits for 16 DMA RX channels.
> No other descriptions.
> 
> And the counters should be updated, I will send a new patch.

Ok. I'll wait for this patch v2 then with the counters fixed. Please
also note that you are adding the _DMA_ DPP events handling support.
Thus the more suitable place for this change would be
dwmac5_handle_dma_err().

> 
> > 2. I don't see this IRQ being enabled in the dwxgmac3_safety_feat_config()
> > method. How come the respective event has turned to be triggered
> > anyway?
> This error report is enabled by default, and cannot be disabled or marked(as Synopsys Databook says).
> What we can do is clearing it when it asserts.

This sounds so strange that I can barely believe in it. The DW QoS Eth
MTL DPP feature can be enabled/disabled, but the DW XGMAC DMA DPP
can't? This doesn't look logical. What's the point in having a never
maskable IRQ for not that much crucial but optional feature? Moreover
DPP adds some data flow overhead. If we are sure that no problem with
the device data paths, then it seems redundant to have it always
enabled. So I guess it must be switchable. Are you completely sure it
isn't?

-Serge(y)

> > 
> > -Serge(y) 
> > 
> > >  }
> > >  
> > >  static const struct dwxgmac3_error_desc dwxgmac3_mtl_errors[32]= {
> > > -- 
> > > 2.34.1
> > > 
> > >   
> 

