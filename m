Return-Path: <linux-kernel+bounces-37903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD52083B771
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD36287F01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445EB79E2;
	Thu, 25 Jan 2024 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfk6GtdQ"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE5F7490;
	Thu, 25 Jan 2024 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151394; cv=none; b=IKCg8POmvhy0HRN5phJB7NSJFtWdXbpFTgXy+RpWl1S1zQRjnbDhherVg9moB/Da1dWIi8pmAP48+X1FsVyNqnRSSk/VyuhvPWSC/yppHoH+IrjfVrlIxdW+6vlj0CbiUI3l4eadGtcXH1AqDDVyZ4U+DxnJUjC7+9PDUSKzEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151394; c=relaxed/simple;
	bh=U+8IqdKN9RQo2JOe0Y+0UfkFFnCKJ+iLubOQ9J+Wd7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q21IhpcQj/upUFicDlJzg1TTK8+g0WnhuCfZfkSI5WkaVt9AqzGYQtEsNmCVKJjpslQBg3g8eRycmjktympIFAmpbI81jv+0rtVnKNjx+OvxWNM3rQ+V5qQYejNQrMvejWIdPNbmdwfW2eiq4XZxfJpW3mIoi/QaTQwo70FM4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfk6GtdQ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso4776382a12.3;
        Wed, 24 Jan 2024 18:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706151392; x=1706756192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAtjtX8uRHdeTdOQ8Q4YA1xyY3aCTVDq4V147zUqCqw=;
        b=kfk6GtdQPZ7G8E7HkKcYf0uvUviQRfFV3zGneMzEKJS1gQKu1ieFXTfPLF3XTqYnOL
         hv3eLXyn+XtomoScWsENg5QK+81HNEqFhk0iO4oBHANaS6eITZ/17qwp6xGvBwFi93Pc
         Ajr3omyUSOzurXrg0xhHjDBUJ3Xr4XuSTXT3lUCu9I/45Uq32ohShHL+rM2HqcOap5MB
         pGEmNGFwJMep5FXB5MK9VxS0pqxQRQQvK+TyPkfB+gt68b6wZXnLFb2PylFfb08Iid3X
         QQEp6KmlWbwwNX33O3QEmrYSbS2EOk8IBWueZ9UgEMQRUdbSNBiZ446yF/HCFsMNYE9T
         H8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706151392; x=1706756192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAtjtX8uRHdeTdOQ8Q4YA1xyY3aCTVDq4V147zUqCqw=;
        b=kMRCUnQsCb7RJ/dUejdodAoaIETk5tNfvD9oG3wcSJQZH3y0VWZCsbAATO9yg+EKlI
         t/F6+JlzDan1sMmnY1ztZi4gWrXWySp+JZ4qdI+bLdMmndno4nAfhosLfCv1oFTJpRqS
         MFSLy1KbjAQMI5bqmHr1F+1eURwEZqWQLdvq0nTkcDg2FnITxiXMxKTTQwKaUn3Ta7K8
         q51YQRmUNLYj6BaC7I6Qur9SxAnjLNU9agbNNVnkrck18m0TwpAlZcwa6Hx9r71lle/7
         gl0sq1SvqKwC1rGe6PUO43GVv+4FF2Kw5M6bFRHhGYtD/grhuke/ecmTrq21clgqsk5w
         d+vg==
X-Gm-Message-State: AOJu0YwajEQqc/nGUdsN+DH+XcoFN0A/CcpDN7bqHtOuc1C0Tp3q/kxn
	NgW/7JP8daJ9dpmp+lYZzwimwEn/kbGPKvX5uOB3r/rq0AFShueZhTc5l15SJAM=
X-Google-Smtp-Source: AGHT+IHmOZl3WFAS3aX7eXdFgA5GZQc6ihdPemj+TBpuUr5gXwegwYuc5rfG68dVm8ND54WylOQJPg==
X-Received: by 2002:a05:6a20:54a4:b0:19c:700b:a164 with SMTP id i36-20020a056a2054a400b0019c700ba164mr646602pzk.49.1706151392331;
        Wed, 24 Jan 2024 18:56:32 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id m5-20020a62f205000000b006ddc5d8ecd7sm507224pfh.32.2024.01.24.18.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 18:56:32 -0800 (PST)
Date: Thu, 25 Jan 2024 10:56:20 +0800
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
Message-ID: <20240125105620.000040b7@gmail.com>
In-Reply-To: <vsert76o6lxxc676tjiiikir577qobfonyo6sgo5eek6alzxlo@tb6hq5s2qcsp>
References: <20240123095006.979437-1-0x1207@gmail.com>
	<vsert76o6lxxc676tjiiikir577qobfonyo6sgo5eek6alzxlo@tb6hq5s2qcsp>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 17:36:10 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> On Tue, Jan 23, 2024 at 05:50:06PM +0800, Furong Xu wrote:
> > Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> > XGMAC core") checks and reports safety errors, but leaves the
> > Data Path Parity Errors for each channel in DMA unhandled at all, lead to
> > a storm of interrupt.
> > Fix it by checking and clearing the DMA_DPP_Interrupt_Status register.
> > 
> > Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> > Signed-off-by: Furong Xu <0x1207@gmail.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h      | 1 +
> >  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 6 ++++++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > index 207ff1799f2c..188e11683136 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > @@ -385,6 +385,7 @@
> >  #define XGMAC_DCEIE			BIT(1)
> >  #define XGMAC_TCEIE			BIT(0)
> >  #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
> > +#define XGMAC_DMA_DPP_INT_STATUS	0x00003074
> >  #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
> >  #define XGMAC_SPH			BIT(24)
> >  #define XGMAC_PBLx8			BIT(16)
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > index eb48211d9b0e..874e85b499e2 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > @@ -745,6 +745,12 @@ static void dwxgmac3_handle_mac_err(struct net_device *ndev,
> >  
> >  	dwxgmac3_log_error(ndev, value, correctable, "MAC",
> >  			   dwxgmac3_mac_errors, STAT_OFF(mac_errors), stats);
> > +
> > +	value = readl(ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> > +	writel(value, ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> > +
> > +	if (value)
> > +		netdev_err(ndev, "Found DMA_DPP error, status: 0x%x\n", value);  
> 
> 1. Why not to implement this in the same way as the rest of the safety
> errors handle code? (with the flags described by the
> dwxgmac3_error_desc-based table and the respective counters being
> incremented should the errors were detected)
> 
XGMAC_DMA_DPP_INT_STATUS is just a bitmap of DMA RX and TX channels,
bottom 16 bits for 16 DMA TX channels and top 16 bits for 16 DMA RX channels.
No other descriptions.

And the counters should be updated, I will send a new patch.

> 2. I don't see this IRQ being enabled in the dwxgmac3_safety_feat_config()
> method. How come the respective event has turned to be triggered
> anyway?
This error report is enabled by default, and cannot be disabled or marked(as Synopsys Databook says).
What we can do is clearing it when it asserts.
> 
> -Serge(y) 
> 
> >  }
> >  
> >  static const struct dwxgmac3_error_desc dwxgmac3_mtl_errors[32]= {
> > -- 
> > 2.34.1
> > 
> >   


