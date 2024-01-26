Return-Path: <linux-kernel+bounces-39528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D106983D25D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E1A290BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFE3522E;
	Fri, 26 Jan 2024 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFyqzXlq"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B587310FF;
	Fri, 26 Jan 2024 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706234941; cv=none; b=KQAG7iPzeKK2zFh66AtXeXFlZ8btjxB/wkEBlsoRj7/d2PiAKvsEPcmY5HGENj8twP31hZMLVOGldCSLCn54mbXSObC1qhVDLfZiSkxgh3C1AL4AutzX+QcAvYdHU3p4zR8MTsr6123ZqRkw9aokpMNGTLdVdNXwQAhvGBAvDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706234941; c=relaxed/simple;
	bh=2quk6pAK35xPyF+//fszvVnj+Kvkjm4JH5d5PC4eOWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YN+tLXSWMqd6Putx+RvEiO8iRGvlyf+iBCjMJI2NGqyrdxWhQsTYvBxfO691cfjLLw1fbfWK4a0Kek3kuowBJU/TwWWfPEQSYATAbVsDYunLVKJPooH5XzbTwjml8fWtRldehHSPvR+IDCavJmNIrwVcbZcxFoX5afNmpJ0oN1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFyqzXlq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dd72c4eb4aso202096b3a.2;
        Thu, 25 Jan 2024 18:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706234939; x=1706839739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br6VJLagRb3AfSDX41gJAp6j1fOegiaHY5+r3X1kYKU=;
        b=QFyqzXlq8Jp3AeDiiMlzeM2Wx/2XbfAgJxe/i/XlXLWj52J+92VpqswSke8sW/wPPx
         2CcnfGldF9DHl2d/pUBXnVDjZRpOX/pR3YEs4g8DgCeunSem7k7wIbKbQazfJANdJL9f
         imRYe9+zX2dg4TpGP0FvrXgw1wCXaGitIgle6yByqod2WAj+TDmGy44+bFXWTm/yfCMC
         nZvi/APXep0veWgoqF/fwakOmOF29h2OZg0x9Ph1u8ov6NEpr/DMIgW3blBMO3uDX9uH
         u2wvxgavQSHlaU8nM4Ps7A+Rlvn5yp9G6o6Fppv2f2CR+HKP4tKHHNTuMexrB/SgQ5Ty
         SwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706234939; x=1706839739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Br6VJLagRb3AfSDX41gJAp6j1fOegiaHY5+r3X1kYKU=;
        b=WW/vjtHEQtotBIVEfrOcbFbvn50aIOQnfKqRdoy3QF0LeievC46tRwXsN4wGDkSFCa
         YlQqBhn7jfCKHoWn3EYOZ1VuCyXfG/wCSCFCftQyuF4lJ9+tU3cQZm93zdcz0qiMnMD4
         uoJxktrBV7gInPkfjxm7XZzmwhntMmQvM+sGG9FHnPAzCOALeBAOHo6FEPOPrxHJWHFU
         2PqNjlhywvPUaWFhp+GSMfJNaFss3U7bgf3G4HWaa0gd32d9kbUTkDZ8fmIaQw8dgZVK
         gsQGcEyKc29w/6B1dk+QhijSBES8NfzoOthPqAAE4i84Ffb84svgACMJuq1M2PTclp+X
         SGWg==
X-Gm-Message-State: AOJu0YzvMEwIlAeijOAqjVXUMc04Y/Fw2LcYgU8ohJsY6tD6U8dPT5Gh
	d6TVEq2iIRxLrj6l1HPgX6/yo39VWdl4Kx0Ijsw6713NZUTPyFYN
X-Google-Smtp-Source: AGHT+IFpXDfDdLfol3GnedT7BVcJU3Lg5lPS/W1n8oFL0fn5cIeJRsE+SQKAsKBssVzbjlUXZm9qHA==
X-Received: by 2002:a05:6a20:6a03:b0:19a:404b:86c3 with SMTP id p3-20020a056a206a0300b0019a404b86c3mr631310pzk.70.1706234938867;
        Thu, 25 Jan 2024 18:08:58 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090ade0d00b0028ddfb484bfsm2251209pjv.49.2024.01.25.18.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 18:08:58 -0800 (PST)
Date: Fri, 26 Jan 2024 10:08:47 +0800
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
Message-ID: <20240126100847.0000370e@gmail.com>
In-Reply-To: <4coefc2fqtc2eoereds3rf7vudci5l7ahme2wydocjepk2wrwy@ncgwl3j3koyu>
References: <20240123085037.939471-1-0x1207@gmail.com>
	<ii3muj3nmhuo6s5hm3g7wuiubtyzr632klrcesubtuaoyifogb@ohmunpxvdtsv>
	<20240125103454.0000312a@gmail.com>
	<4coefc2fqtc2eoereds3rf7vudci5l7ahme2wydocjepk2wrwy@ncgwl3j3koyu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 16:48:23 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> On Thu, Jan 25, 2024 at 10:34:54AM +0800, Furong Xu wrote:
> > On Wed, 24 Jan 2024 17:25:27 +0300
> > Serge Semin <fancer.lancer@gmail.com> wrote:
> >   
> > > On Tue, Jan 23, 2024 at 04:50:37PM +0800, Furong Xu wrote:  
> > > > Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> > > > XGMAC core") prints safety error descriptions when safety error assert,
> > > > but missed some special errors, and mixed correctable errors and
> > > > uncorrectable errors together.
> > > > This patch complete the error code list and print the type of errors.    
> > > 
> > > The XGMAC ECC Safety code has likely been just copied from the DW GMAC
> > > v5 (DW QoS Eth) part. So this change is partly relevant to that code too. I
> > > can't confirm that the special errors support is relevant to the DW
> > > QoS Eth too (it likely is though), so what about splitting this patch
> > > up into two:
> > > 1. Elaborate the errors description for DW GMAC v5 and DW XGMAC.
> > > 2. Add new ECC safety errors support.
> > > ?
> > > 
> > > On the other hand if we were sure that both DW QoS Eth and XGMAC
> > > safety features implementation match the ideal solution would be to
> > > refactor out the common code into a dedicated module.
> > > 
> > > -Serge(y)
> > >   
> >   
> 
> > Checked XGMAC Version 3.20a and DW QoS Eth Version 5.20a, the safety error
> > code definitions are not identical at all, they do have some differences,
> > about more than 20 bits of status register are different.
> > I think we should just leave them in individual implementations.  
> 
> For some reason you answered to the last part of my comment and
> completely ignored the first part which was the main point of my
> message.
> 
> Regarding the Safety Feature support implemented in QoS Eth and XGMAC
> STMMAC modules. You were wrong in using the statement "at all". Except
> the optional events enable/disable procedure introduced in the commit
> 5ac712dcdfef ("net: stmmac: enable platform specific safety
> features"), there aren't many differences: at least the errors
> handling and report are identical, MTL and DMA error flags match, even
> MTL and DMA ECC/Safety IRQ flags match. The only difference is in the
> MTL/MAC DPP (Data Parity Protection) part which can be easily factored
> out based on the device ID should we attempt to refactor the safety
> feature code. See the attached html-diff for more details of what
> match and what is different.
> 
> Anyway I am not insisting on the refactoring. That was just a
> proposal, a more preferred alternative to simultaneously patching two
> parts of the drivers looking very much alike. Such refactoring would
> improve the code maintainability. The main point of my comment was to
> extend your patch for DW QoS Eth safety feature implementation too
> since some of the changes you introduced were useful for it too, and
> in splitting the patch up since your patch added new flags support
> which was unrelated change.  Thus your patch would turned into the
> two-patches patchset like this:
> [Patch 1] would provide an elaborated errors description for both DW
> QOS Eth (GMAC v5.x) and DW XGMAC.
> [Patch 2] would introduce the new ECC safety errors support.
> 
> See my further comments about the respective changes.
> 
> >   
> > > > 
> > > > Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> > > > Signed-off-by: Furong Xu <0x1207@gmail.com>
> > > > ---
> > > >  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 36 +++++++++----------
> > > >  1 file changed, 18 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > > index eb48211d9b0e..ad812484059e 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > > @@ -748,29 +748,29 @@ static void dwxgmac3_handle_mac_err(struct net_device *ndev,
> > > >  }
> > > >  
> > > >  static const struct dwxgmac3_error_desc dwxgmac3_mtl_errors[32]= {  
> 
> > > > -	{ true, "TXCES", "MTL TX Memory Error" },
> > > > +	{ true, "TXCES", "MTL TX Memory Correctable Error" },  
> 
> Applicable for both IP-cores
> [Patch 1] +QoS, +XGMAC
> please apply this change to dwmac5.c too.
> 
> > > >  	{ true, "TXAMS", "MTL TX Memory Address Mismatch Error" },  
> 
> > > > -	{ true, "TXUES", "MTL TX Memory Error" },
> > > > +	{ true, "TXUES", "MTL TX Memory Uncorrectable Error" },  
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 3 */  
> 
> > > > -	{ true, "RXCES", "MTL RX Memory Error" },
> > > > +	{ true, "RXCES", "MTL RX Memory Correctable Error" },  
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ true, "RXAMS", "MTL RX Memory Address Mismatch Error" },  
> 
> > > > -	{ true, "RXUES", "MTL RX Memory Error" },
> > > > +	{ true, "RXUES", "MTL RX Memory Uncorrectable Error" },  
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 7 */  
> 
> > > > -	{ true, "ECES", "MTL EST Memory Error" },
> > > > +	{ true, "ECES", "MTL EST Memory Correctable Error" },  
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ true, "EAMS", "MTL EST Memory Address Mismatch Error" },  
> 
> > > > -	{ true, "EUES", "MTL EST Memory Error" },
> > > > +	{ true, "EUES", "MTL EST Memory Uncorrectable Error" },  
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 11 */  
> 
> > > > -	{ true, "RPCES", "MTL RX Parser Memory Error" },
> > > > +	{ true, "RPCES", "MTL RX Parser Memory Correctable Error" },  
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ true, "RPAMS", "MTL RX Parser Memory Address Mismatch Error" },  
> 
> > > > -	{ true, "RPUES", "MTL RX Parser Memory Error" },
> > > > +	{ true, "RPUES", "MTL RX Parser Memory Uncorrectable Error" },  
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 15 */  
> 
> > > > -	{ false, "UNKNOWN", "Unknown Error" }, /* 16 */
> > > > -	{ false, "UNKNOWN", "Unknown Error" }, /* 17 */
> > > > -	{ false, "UNKNOWN", "Unknown Error" }, /* 18 */
> > > > +	{ true, "SCES", "MTL SGF GCL Memory Correctable Error" },
> > > > +	{ true, "SAMS", "MTL SGF GCL Memory Address Mismatch Error" },
> > > > +	{ true, "SUES", "MTL SGF GCL Memory Uncorrectable Error" },
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 19 */
> > > > -	{ false, "UNKNOWN", "Unknown Error" }, /* 20 */
> > > > -	{ false, "UNKNOWN", "Unknown Error" }, /* 21 */
> > > > -	{ false, "UNKNOWN", "Unknown Error" }, /* 22 */
> > > > +	{ true, "RXFCES", "MTL RXF Memory Correctable Error" },
> > > > +	{ true, "RXFAMS", "MTL RXF Memory Address Mismatch Error" },
> > > > +	{ true, "RXFUES", "MTL RXF Memory Uncorrectable Error" },  
> 
> This introduces the new flags support. Please move this change into a
> separate patch (Patch 2):
> [Patch 2] +XGMAC only.
> 
> My DW QoS Eth v5.10a databook doesn't have these flags defined. If
> your 5.20a HW-manual have them described then please add them for DW
> QoS Eth too.
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 23 */
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 24 */
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 25 */
> > > > @@ -796,13 +796,13 @@ static void dwxgmac3_handle_mtl_err(struct net_device *ndev,
> > > >  }
> > > >  
> > > >  static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {  
> 
> > > > -	{ true, "TCES", "DMA TSO Memory Error" },
> > > > +	{ true, "TCES", "DMA TSO Memory Correctable Error" },  
> 
> Applicable for both IP-cores
> [Patch 1] +QoS, +XGMAC
> please apply this change to dwmac5.c too.
> 
> > > >  	{ true, "TAMS", "DMA TSO Memory Address Mismatch Error" },  
> 
> > > > -	{ true, "TUES", "DMA TSO Memory Error" },
> > > > +	{ true, "TUES", "DMA TSO Memory Uncorrectable Error" },  
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 3 */  
> 
> > > > -	{ true, "DCES", "DMA DCACHE Memory Error" },
> > > > +	{ true, "DCES", "DMA DCACHE Memory Correctable Error" },
> > > >  	{ true, "DAMS", "DMA DCACHE Address Mismatch Error" },
> > > > -	{ true, "DUES", "DMA DCACHE Memory Error" },
> > > > +	{ true, "DUES", "DMA DCACHE Memory Uncorrectable Error" },  
> 
> AFAICS applicable for XGMAC only
> [Patch 1] +XGMAC only.
> Once again, My DW QoS Eth v5.10a databook doesn't have these flags
> defined. So if your DW QoS Eth 5.20a HW-manual do have them described
> please add them for DW QoS Eth with the elaborated description in the
> framework of the Patch 2.
> 
> -Serge(y)
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 7 */
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 8 */
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 9 */
> > > > -- 
> > > > 2.34.1
> > > > 
> > > >     
> >   

Hi Serge:
Thanks for your detailed explanation, new refactoring will be sent to net-next.

