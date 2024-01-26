Return-Path: <linux-kernel+bounces-39569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A283D2F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DEB1F24A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68A6AD5C;
	Fri, 26 Jan 2024 03:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcQKckUI"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5A6AD6;
	Fri, 26 Jan 2024 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706239881; cv=none; b=E8cXki3ry8pFCStwVR/iTvgyu0qTm690Gn1qCwkShuTdRUCxDu+hdRnDz3X+Hy5bJcwdeba2f4wo571e5gLDotGLyYZoVkijzk0kRZJ7F1OF78cJy0PjxvoYbGGjLCUEl5bNUZxsZDISyxQYBR3U8RUHfwgyyO2YvzL5z+Xzj6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706239881; c=relaxed/simple;
	bh=QTsr8iY178qNv6DLK5SoRZtgZGa29bnsjo2XqVC4Jao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ak+RFWhXftZFYv7TWCOHrDi7qOcKGBykOCTM7duNHJv190a4cTbmbpbF07nu3fVlxlvBgdYNVfgqLZDC+G7mE316nz3gAZ6Uqkrz+6yqpTrWASV+86xIoqjKi9x3iBzDcHzGx9NkcRttkdEKgJYzy3CHNlU/yuWvpaDaUF3Ayo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcQKckUI; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbed0710c74so6842176276.1;
        Thu, 25 Jan 2024 19:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706239879; x=1706844679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cu5uJIW+PgmWmPkTx7ElNgWaV5SHadIfkDdLydfJ9xw=;
        b=kcQKckUIgPszDdtiMLt/1RyKpsI7HNBHuX1pfqiKPqmfjK8oBr4qJO6/1bZCHZrlRR
         S+gD9m1lmbD4FGR6Z0Vlc8jbqbnOWrYd0UnFOMMf079DXcX9C1tdAjnGWmc4vELODI9M
         5/cfAutCUt50bhK0IHbG5iP3c3AlFGMoK8A8cnXOFxNDEksGy8zEgUKbM8ssFYako+Zc
         9FIeeDh3G5tCOKJjbBAv2NDSXWW0rYAxKwsZqb3nw929HGvgr8/um2t6I/8Yc4TR5srQ
         InCwd9/foBol8sYZ1KYzk7PH0iP9BZnshyW2FkPqdqMQmu++o2XRqcYZ87tHzCk6Q+pQ
         6A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706239879; x=1706844679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cu5uJIW+PgmWmPkTx7ElNgWaV5SHadIfkDdLydfJ9xw=;
        b=nGRHdycNGWxrALlGmBgTE8scv9pMlHHe6Ywtu/7x0/vNbe3dT3swd6qVhkTITkWqW6
         OrqDk2Y3UANVXNpAa6FIBKUujgqxZ+Xuz+Ilsr91rJsZPCXJFYqM3C2t/nlN7+cJxYbq
         /hcLNATH292bNE4O4nd2I3ChokWE4ZlD8fa3wi1uK71F7jUzHU7D1Qj27nOZfBBNn+9f
         4amiBBOiDfDFpJPa0wBhkgvmnUKWoA+0IEq7Vi/OkImgO+lBnkQnGZ8VB24JB5NDk8Bd
         hTrH1ssiLFwl+7BEmSvz+JqF6657hRkBLBx/lDeSx2U7oKkWs8wqx8NdQ2RRo8WOjyp5
         4qIQ==
X-Gm-Message-State: AOJu0Yx30C5CXmletLaHAFbXs0+8kmgx6wyx/FccV5LD3hI/vpTDsmDn
	vQuYSc/bnnjDU89ZuH8sGKx4e74en+0Nl6OOdZ3dAoEFLK1WO8eI
X-Google-Smtp-Source: AGHT+IEcxOysEBQ87WgKxyfi1nNa59mDc0u82AOGzSYqQQM2UlemhexgEizS4szo4pFI7f9NW/PyVA==
X-Received: by 2002:a05:690c:fd1:b0:5f3:7df:563a with SMTP id dg17-20020a05690c0fd100b005f307df563amr1055527ywb.16.1706239879226;
        Thu, 25 Jan 2024 19:31:19 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902eb0600b001d76ced199esm224183plb.31.2024.01.25.19.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 19:31:18 -0800 (PST)
Date: Fri, 26 Jan 2024 11:31:07 +0800
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
Subject: Re: [PATCH net] net: stmmac: xgmac: fix handling of DPP safety
 error for DMA channels
Message-ID: <20240126113107.000064dc@gmail.com>
In-Reply-To: <czebrzszux2gdik3ey54tr3iewsxs4hjom432eb527jcpftnnr@ftiiwofakorj>
References: <20240123095006.979437-1-0x1207@gmail.com>
	<vsert76o6lxxc676tjiiikir577qobfonyo6sgo5eek6alzxlo@tb6hq5s2qcsp>
	<20240125105620.000040b7@gmail.com>
	<czebrzszux2gdik3ey54tr3iewsxs4hjom432eb527jcpftnnr@ftiiwofakorj>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 22:07:15 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> On Thu, Jan 25, 2024 at 10:56:20AM +0800, Furong Xu wrote:
> > On Wed, 24 Jan 2024 17:36:10 +0300
> > Serge Semin <fancer.lancer@gmail.com> wrote:
> >   
> > > On Tue, Jan 23, 2024 at 05:50:06PM +0800, Furong Xu wrote:  
> > > > Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> > > > XGMAC core") checks and reports safety errors, but leaves the
> > > > Data Path Parity Errors for each channel in DMA unhandled at all, lead to
> > > > a storm of interrupt.
> > > > Fix it by checking and clearing the DMA_DPP_Interrupt_Status register.
> > > > 
> > > > Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> > > > Signed-off-by: Furong Xu <0x1207@gmail.com>
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h      | 1 +
> > > >  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 6 ++++++
> > > >  2 files changed, 7 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > > > index 207ff1799f2c..188e11683136 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > > > @@ -385,6 +385,7 @@
> > > >  #define XGMAC_DCEIE			BIT(1)
> > > >  #define XGMAC_TCEIE			BIT(0)
> > > >  #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
> > > > +#define XGMAC_DMA_DPP_INT_STATUS	0x00003074
> > > >  #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
> > > >  #define XGMAC_SPH			BIT(24)
> > > >  #define XGMAC_PBLx8			BIT(16)
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > > index eb48211d9b0e..874e85b499e2 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > > @@ -745,6 +745,12 @@ static void dwxgmac3_handle_mac_err(struct net_device *ndev,
> > > >  
> > > >  	dwxgmac3_log_error(ndev, value, correctable, "MAC",
> > > >  			   dwxgmac3_mac_errors, STAT_OFF(mac_errors), stats);
> > > > +
> > > > +	value = readl(ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> > > > +	writel(value, ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> > > > +
> > > > +	if (value)
> > > > +		netdev_err(ndev, "Found DMA_DPP error, status: 0x%x\n", value);    
> > > 
> > > 1. Why not to implement this in the same way as the rest of the safety
> > > errors handle code? (with the flags described by the
> > > dwxgmac3_error_desc-based table and the respective counters being
> > > incremented should the errors were detected)
> > >   
> 
> > XGMAC_DMA_DPP_INT_STATUS is just a bitmap of DMA RX and TX channels,
> > bottom 16 bits for 16 DMA TX channels and top 16 bits for 16 DMA RX channels.
> > No other descriptions.
> > 
> > And the counters should be updated, I will send a new patch.  
> 
> Ok. I'll wait for this patch v2 then with the counters fixed. Please
> also note that you are adding the _DMA_ DPP events handling support.
> Thus the more suitable place for this change would be
> dwmac5_handle_dma_err().
> 
> >   
> > > 2. I don't see this IRQ being enabled in the dwxgmac3_safety_feat_config()
> > > method. How come the respective event has turned to be triggered
> > > anyway?  
> > This error report is enabled by default, and cannot be disabled or marked(as Synopsys Databook says).
> > What we can do is clearing it when it asserts.  
> 
> This sounds so strange that I can barely believe in it. The DW QoS Eth
> MTL DPP feature can be enabled/disabled, but the DW XGMAC DMA DPP
> can't? This doesn't look logical. What's the point in having a never
> maskable IRQ for not that much crucial but optional feature? Moreover
> DPP adds some data flow overhead. If we are sure that no problem with
> the device data paths, then it seems redundant to have it always
> enabled. So I guess it must be switchable. Are you completely sure it
> isn't?

Sorry for my bad explanation.

Double checked DMA_DPP error report path on my device.

XGMAC DMA_DPP is enable by DDPP bit of MTL_DPP_Control.
DDPP bit is default to 0(Data path Parity Protection is enabled).
When DDPP bit is set to 1(Data path Parity Protection is disabled), no DMA_DPP interrupt is reported.

Once DMA_DPP interrupt is reported, there is no control bit to disable it or mask it.
DMA_DPP error is unrecoverable type, and unrecoverable error interrupt cannot be disabled or masked,
this is a design(as Synopsys Databook says).

A explicit ops on MTL_DPP_Control to clear DDPP bit can add to dwxgmac3_safety_feat_config
to make code looks better.

> 
> -Serge(y)
> 
> > > 
> > > -Serge(y) 
> > >   
> > > >  }
> > > >  
> > > >  static const struct dwxgmac3_error_desc dwxgmac3_mtl_errors[32]= {
> > > > -- 
> > > > 2.34.1
> > > > 
> > > >     
> >   


