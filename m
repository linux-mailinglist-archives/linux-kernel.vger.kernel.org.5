Return-Path: <linux-kernel+bounces-69145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DA085850B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DDF1C215BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13221350DE;
	Fri, 16 Feb 2024 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERjQRRjg"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4AA131722;
	Fri, 16 Feb 2024 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107848; cv=none; b=PFXuEOuny1WLafaJwC67g/2guzNYNMyIjV7frtZJ+jHck/kBdVAuzNpUi+GcbBJawPRr+jSN2D8xeW0ihmrH51p4HnMv6Eb0DuRZ+/PBoAkvxqy5PuzemF7crDXtSy2wHNV2ojKCd3Xj/ZUNv0sgxwmwK4sKYb3My1ieRXNLajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107848; c=relaxed/simple;
	bh=SqYPKWDLnuGJK5U2Ewke7cCIfy9hQPIkVCWR4ZEMhwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsbUTFKfP6DRcKEOvq7QcN2r/JEQsP2acfnn8QBcrQcgRjwcsB/+rfb3YM71ThOsJN3Na5wHKNYVZ4xol7wVDJ7hbIXwXi4roiaKwPkXfY6V9rm+5ReAxqPBcgAcR+sKpIdmg6KG5fw4ef/cwVfto69LF37vmQNvYSCzLFQTqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERjQRRjg; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0b4ea773eso29564231fa.0;
        Fri, 16 Feb 2024 10:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708107845; x=1708712645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cVDKfJQ+tCuSdXhY6TiavPFjaspEvu7Ad4BGUjaCUAE=;
        b=ERjQRRjgn+x/cAaNSK9JRMsxB2vlBL0NqUMggOC3/t8xAulkX2Oz8vuTV06PC9IRyl
         sey0Ve5nzE7NUVWp+rrNfxM+fYAQfBoqtFGSi0hrFvRAuzQLhC6jmCek0hz06fF75Wto
         VbVTEearJco9HJUKdoewMRR9iq53NLQxbUdFnxl5pmfNooEvYvlYf22jbtWAPLWNlpQD
         P1f4BwZWm7MB4if5CNxtsEXDFYa+ryq8OZG2yNmEVEt+uvhbWZ9Nbnz/m1w8813QD/rM
         RnQ4ekDO9D40fwydnxLHe1rYkj8nJFTZZfz2LNY1qjOMBb//buOuckiMjZCOSlkrBp0K
         1MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708107845; x=1708712645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVDKfJQ+tCuSdXhY6TiavPFjaspEvu7Ad4BGUjaCUAE=;
        b=dPZsbdg3RcrjqswWaLFvZVMo9AjsbdU9WAhiP5KtzzBd4KCtddkpQVi3VgEIcTjHd9
         GVBW0svlHt780Frj8QaNVeINBcQYn9wzkDha1Rvx58O46hC56KtLMw26DYAOisrhPgnq
         AAPa+KKmFpTixs1DG0D5PRQthYPlJNI3ekdwjq6MJlvU5CeIl/iAKhela3wGBFunL0v/
         VZjI8tvCo6dcrEMHN/qLeX1hLTuUAw5XK5w959Tird93I8i7fAz7NOdNSe3kW2bTdOrd
         sPeUMdZrs8wvbbLo4IwFhYnNbpQVNZF/QuKUfzEvefMjZBYqo1HgPsbbRuZW8hgBVjLr
         Zr1g==
X-Forwarded-Encrypted: i=1; AJvYcCWX5A3hrEJnTwL90NLLpO6ggIVAsbOslYdre15l70hv3GX5bm0LEVpKcGPVPAqJ9hHv94RD/ToByzxAg5Pxk/D0llDRySgPPqRgSJWw/+GZwvzu3008j1TwfbHJYQurtUITBr+1
X-Gm-Message-State: AOJu0YwRggaiRU4qm3P5ISQ/w6skovBIZ9bai3nSXmvVY/KCRaXJb8y5
	827lPLlUkVRKB9teE4/FXBgWsZo1aCYBCSqxPWoiVQuQre/ZJDnh
X-Google-Smtp-Source: AGHT+IHz8SLuj0HeZjrA59fbpHxEZQx4CNdTDrSGjiJcc/KB/eOtXjEXu1w0IDtU5LUHJY6IknyBAg==
X-Received: by 2002:a2e:7202:0:b0:2d0:e730:b7d5 with SMTP id n2-20020a2e7202000000b002d0e730b7d5mr3975909ljc.1.1708107844735;
        Fri, 16 Feb 2024 10:24:04 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t25-20020a2e9d19000000b002d100bd4cdbsm40573lji.45.2024.02.16.10.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:24:04 -0800 (PST)
Date: Fri, 16 Feb 2024 21:24:01 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>, 
	Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] net: stmmac: mmc_core: Assign, don't add interrupt
 registers
Message-ID: <53fctveh4pl3c5wys37c2wcpbsxr7tggw3d3y5eudgrbvr2vdl@fbqc2meg5yv3>
References: <20240216-stmmac_stats-v1-1-7065fa4613f8@axis.com>
 <61bdd802-abe4-4544-8e48-9493a6bb99c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61bdd802-abe4-4544-8e48-9493a6bb99c8@gmail.com>

On Fri, Feb 16, 2024 at 09:13:51AM -0800, Florian Fainelli wrote:
> On 2/16/24 07:24, Jesper Nilsson wrote:
> > The MMC IPC interrupt status and interrupt mask registers are of
> > little use as Ethernet statistics, but incrementing counters
> > based on the current interrupt and interrupt mask registers
> > makes them worse than useless.
> > 
> > For example, if the interrupt mask is set to 0x08420842,
> > the current code will increment by that amount each iteration,
> > leading to the following sequence of nonsense:
> > 
> > mmc_rx_ipc_intr_mask: 969816526
> > mmc_rx_ipc_intr_mask: 1108361744
> > 
> > Change the increment to a straight assignment to make the
> > statistics at least nominally useful.
> > 
> > Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> > index 6a7c1d325c46..6051a22b3cec 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> > @@ -280,8 +280,8 @@ static void dwmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
> >   	mmc->mmc_rx_vlan_frames_gb += readl(mmcaddr + MMC_RX_VLAN_FRAMES_GB);
> >   	mmc->mmc_rx_watchdog_error += readl(mmcaddr + MMC_RX_WATCHDOG_ERROR);
> >   	/* IPC */
> > -	mmc->mmc_rx_ipc_intr_mask += readl(mmcaddr + MMC_RX_IPC_INTR_MASK);
> > -	mmc->mmc_rx_ipc_intr += readl(mmcaddr + MMC_RX_IPC_INTR);
> > +	mmc->mmc_rx_ipc_intr_mask = readl(mmcaddr + MMC_RX_IPC_INTR_MASK);
> > +	mmc->mmc_rx_ipc_intr = readl(mmcaddr + MMC_RX_IPC_INTR);
> 

> So in premise I agree with the patch, that incrementing those is not the
> right way to go about them. However these registers are currently provided
> as part of the statistics set, but they should instead be accessed via the
> register dumping method.
> 
> In either case you will get at best a snapshot of those two registers at any
> given time and I suppose this can help diagnose a stuck RX condition, but
> not much more than that.

Could you please clarify why do those CSRs state need to be exposed in
the statistics anyway? Who would need such information really?
Wouldn't that be better to just drop the
stmmac_counters::{mmc_rx_ipc_intr_mask,mmc_rx_ipc_intr}
fields? Is it because of the statistics nodes are a kind of kernel
ABI? Even in that case I don't see much reason to support something
that has been absolutely useless so far seeing the nodes currently
returning basically some random values.

-Serge(y)

> -- 
> Florian
> 
> 

