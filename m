Return-Path: <linux-kernel+bounces-37890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FB083B72E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70271C21135
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EA66FB6;
	Thu, 25 Jan 2024 02:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNZT4bTh"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02926FB5;
	Thu, 25 Jan 2024 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706150110; cv=none; b=jlTAiF8hgVRmpK3Jha8f/G7UyXWoALEh4+XGTsBQ62pTn/XJKvi8C+yaOut6x8m6HNZnlQ/Qf8Fwj3NtO1D3EcatCT88fmZTLHY1uHKWcFtFxuJTsDY44m821i0L0CDuYUC4llsrwLEDw7D0292GYpIR/5+HT8FRvfr6pR8lBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706150110; c=relaxed/simple;
	bh=XYlohPcYkZZG3N7LFgbcX46ub+cimlttqnW2msr9Xzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFaq8AcTcfirS4+UB1DIh6ihs1enKXSmM19KOSZu9jodDKHsYMBZpyvqg+1hOcsnCMl+THns6cwuWtxhC8vkj9myeWsQPY2ENdu6PnpvNe/+1TspEjv9DtnjbKaz18bidFiUMU9n2v32w3irPaTnEECdxw10gP+XcsAsxo0pnKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNZT4bTh; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29065efa06fso3767308a91.1;
        Wed, 24 Jan 2024 18:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706150108; x=1706754908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElI5s79820kPutuntGaxiQesjo2hgbJF7ifEMpPB0Eg=;
        b=RNZT4bThZuJ1/AnhwTTouTUaqbgTzAwcMfYjX1Pa/R8yQXqsClACLt7nt4F+QLI48l
         4kR8h5bW+lo55vtrdEFXfSSTKmWRWPp+kDkX66g8lIM57+jWLy5jqTWXHOpJKAaeBfaD
         dQ3Yns2iMbAkw+4aEzYFI2nxk+Qp67FJ4U3viosWOlMJ3dZvc03E3ZzJHHWngBZGJsAV
         GandcWDiS4Kn5UkTaapFyeCvxj1YtQWJKAVzZRb0gx4SVakC+U0ofpmrZTPixwrgGh9L
         mqiRX7pXXuxIrP1hWPYjU6nx9/EYerQ9ZuUwVX10y7l7YHVm4YL/1v0onsinnnSxOWX7
         UYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706150108; x=1706754908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElI5s79820kPutuntGaxiQesjo2hgbJF7ifEMpPB0Eg=;
        b=NT2qxxvhrtHtABON5sMzVuqkF9KDcdiSOaohNVp4Hw5g+peX8gacr7tnQSBhr3N1Nh
         JbH9dp4KPU/qElpocpKvc/cnll92ApW7EYvJrmYUoA+FnPmNrNcKMfTMTUqcEtwCBf51
         TNLd5I9NznFWUXEztfWVMvJ95XqWoShlWe8WtPVn/eCpFWTABOP8Z3RBc+j503wxhIO2
         v2HWF3nvrD+EEHMadd6QYi1Gsm5+UFPuHwOzI/c9lB2rTqqiBX7uoD18q4k8dbMfMXw0
         JfAtznraQt9qzfUcyE4fYWopnhTr/hwYRnv1koxJRRDWCJ+OtrKt3Ku/yyWBT+gxuHUv
         vzxA==
X-Gm-Message-State: AOJu0YxmYAKxJvvZZd18wSJ2d8DY8RgxGBpdHpIdSQP1vIjbRMcyKNr2
	HibD+NsK/t+PMpvAEfVdCpn+m7ZbvBh5o6bCbyiL6iWCgk9jMj6o
X-Google-Smtp-Source: AGHT+IH0qJiBgXBUOvhArhS7A5BZqdhwGL4PVANneN5oH8MrPA9qqy+6X4q55NX/xqbSsqPnc7Qb7A==
X-Received: by 2002:a17:90a:e543:b0:28d:dbe8:aa6c with SMTP id ei3-20020a17090ae54300b0028ddbe8aa6cmr255558pjb.36.1706150107884;
        Wed, 24 Jan 2024 18:35:07 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id sx8-20020a17090b2cc800b0028ac1112124sm358775pjb.30.2024.01.24.18.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 18:35:07 -0800 (PST)
Date: Thu, 25 Jan 2024 10:34:54 +0800
From: Furong Xu <0x1207@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net] net: stmmac: xgmac: fix safety error descriptions
Message-ID: <20240125103454.0000312a@gmail.com>
In-Reply-To: <ii3muj3nmhuo6s5hm3g7wuiubtyzr632klrcesubtuaoyifogb@ohmunpxvdtsv>
References: <20240123085037.939471-1-0x1207@gmail.com>
	<ii3muj3nmhuo6s5hm3g7wuiubtyzr632klrcesubtuaoyifogb@ohmunpxvdtsv>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 17:25:27 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> On Tue, Jan 23, 2024 at 04:50:37PM +0800, Furong Xu wrote:
> > Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> > XGMAC core") prints safety error descriptions when safety error assert,
> > but missed some special errors, and mixed correctable errors and
> > uncorrectable errors together.
> > This patch complete the error code list and print the type of errors.  
> 
> The XGMAC ECC Safety code has likely been just copied from the DW GMAC
> v5 (DW QoS Eth) part. So this change is partly relevant to that code too. I
> can't confirm that the special errors support is relevant to the DW
> QoS Eth too (it likely is though), so what about splitting this patch
> up into two:
> 1. Elaborate the errors description for DW GMAC v5 and DW XGMAC.
> 2. Add new ECC safety errors support.
> ?
> 
> On the other hand if we were sure that both DW QoS Eth and XGMAC
> safety features implementation match the ideal solution would be to
> refactor out the common code into a dedicated module.
> 
> -Serge(y)
> 

Checked XGMAC Version 3.20a and DW QoS Eth Version 5.20a, the safety error
code definitions are not identical at all, they do have some differences,
about more than 20 bits of status register are different.
I think we should just leave them in individual implementations.

> > 
> > Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> > Signed-off-by: Furong Xu <0x1207@gmail.com>
> > ---
> >  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 36 +++++++++----------
> >  1 file changed, 18 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > index eb48211d9b0e..ad812484059e 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > @@ -748,29 +748,29 @@ static void dwxgmac3_handle_mac_err(struct net_device *ndev,
> >  }
> >  
> >  static const struct dwxgmac3_error_desc dwxgmac3_mtl_errors[32]= {
> > -	{ true, "TXCES", "MTL TX Memory Error" },
> > +	{ true, "TXCES", "MTL TX Memory Correctable Error" },
> >  	{ true, "TXAMS", "MTL TX Memory Address Mismatch Error" },
> > -	{ true, "TXUES", "MTL TX Memory Error" },
> > +	{ true, "TXUES", "MTL TX Memory Uncorrectable Error" },
> >  	{ false, "UNKNOWN", "Unknown Error" }, /* 3 */
> > -	{ true, "RXCES", "MTL RX Memory Error" },
> > +	{ true, "RXCES", "MTL RX Memory Correctable Error" },
> >  	{ true, "RXAMS", "MTL RX Memory Address Mismatch Error" },
> > -	{ true, "RXUES", "MTL RX Memory Error" },
> > +	{ true, "RXUES", "MTL RX Memory Uncorrectable Error" },
> >  	{ false, "UNKNOWN", "Unknown Error" }, /* 7 */
> > -	{ true, "ECES", "MTL EST Memory Error" },
> > +	{ true, "ECES", "MTL EST Memory Correctable Error" },
> >  	{ true, "EAMS", "MTL EST Memory Address Mismatch Error" },
> > -	{ true, "EUES", "MTL EST Memory Error" },
> > +	{ true, "EUES", "MTL EST Memory Uncorrectable Error" },
> >  	{ false, "UNKNOWN", "Unknown Error" }, /* 11 */
> > -	{ true, "RPCES", "MTL RX Parser Memory Error" },
> > +	{ true, "RPCES", "MTL RX Parser Memory Correctable Error" },
> >  	{ true, "RPAMS", "MTL RX Parser Memory Address Mismatch Error" },
> > -	{ true, "RPUES", "MTL RX Parser Memory Error" },
> > +	{ true, "RPUES", "MTL RX Parser Memory Uncorrectable Error" },
> >  	{ false, "UNKNOWN", "Unknown Error" }, /* 15 */
> > -	{ false, "UNKNOWN", "Unknown Error" }, /* 16 */
> > -	{ false, "UNKNOWN", "Unknown Error" }, /* 17 */
> > -	{ false, "UNKNOWN", "Unknown Error" }, /* 18 */
> > +	{ true, "SCES", "MTL SGF GCL Memory Correctable Error" },
> > +	{ true, "SAMS", "MTL SGF GCL Memory Address Mismatch Error" },
> > +	{ true, "SUES", "MTL SGF GCL Memory Uncorrectable Error" },
> >  	{ false, "UNKNOWN", "Unknown Error" }, /* 19 */
> > -	{ false, "UNKNOWN", "Unknown Error" }, /* 20 */
> > -	{ false, "UNKNOWN", "Unknown Error" }, /* 21 */
> > -	{ false, "UNKNOWN", "Unknown Error" }, /* 22 */
> > +	{ true, "RXFCES", "MTL RXF Memory Correctable Error" },
> > +	{ true, "RXFAMS", "MTL RXF Memory Address Mismatch Error" },
> > +	{ true, "RXFUES", "MTL RXF Memory Uncorrectable Error" },
> >  	{ false, "UNKNOWN", "Unknown Error" }, /* 23 */
> >  	{ false, "UNKNOWN", "Unknown Error" }, /* 24 */
> >  	{ false, "UNKNOWN", "Unknown Error" }, /* 25 */
> > @@ -796,13 +796,13 @@ static void dwxgmac3_handle_mtl_err(struct net_device *ndev,
> >  }
> >  
> >  static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
> > -	{ true, "TCES", "DMA TSO Memory Error" },
> > +	{ true, "TCES", "DMA TSO Memory Correctable Error" },
> >  	{ true, "TAMS", "DMA TSO Memory Address Mismatch Error" },
> > -	{ true, "TUES", "DMA TSO Memory Error" },
> > +	{ true, "TUES", "DMA TSO Memory Uncorrectable Error" },
> >  	{ false, "UNKNOWN", "Unknown Error" }, /* 3 */
> > -	{ true, "DCES", "DMA DCACHE Memory Error" },
> > +	{ true, "DCES", "DMA DCACHE Memory Correctable Error" },
> >  	{ true, "DAMS", "DMA DCACHE Address Mismatch Error" },
> > -	{ true, "DUES", "DMA DCACHE Memory Error" },
> > +	{ true, "DUES", "DMA DCACHE Memory Uncorrectable Error" },
> >  	{ false, "UNKNOWN", "Unknown Error" }, /* 7 */
> >  	{ false, "UNKNOWN", "Unknown Error" }, /* 8 */
> >  	{ false, "UNKNOWN", "Unknown Error" }, /* 9 */
> > -- 
> > 2.34.1
> > 
> >   


