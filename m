Return-Path: <linux-kernel+bounces-9784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9579181CB65
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B945E1C2196A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31383208CC;
	Fri, 22 Dec 2023 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XId1mLs9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50820B3E;
	Fri, 22 Dec 2023 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cc6eecd319so23373291fa.1;
        Fri, 22 Dec 2023 06:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703255717; x=1703860517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=19330V05jnim9tqHKI81rhlyn9YLwEeYkPtMUaA5/Ts=;
        b=XId1mLs9waS/iCPC0kdr8be+cCgUTBuwqHek5XDM7nAJe85rUPPaeBD9mWbAfeDTml
         VJ5GYechl4HLIvhPrxcjT1kt4f1ElLtW2RFY5MmzRMKU/Whx/j+HmbeThrfUrBtk5WP1
         zxEvdPbjPbKnyr/1/i8RGeg02q+Et6DY4sgG4StOqls+8ExuBy4wHS4SnGbSosFmoL4i
         hVX/WUDfzfWQvWoPmzqaC3mrepP5jnN1/1RswLrHlBp8RyITfSZkR97r5sCcIsnSJVgJ
         n0ayGRkRc48PoxBCSOqMq+qtgLR4CVqQvu2Xk1ogv0BembC/SI7pvwHtARJrtl/PwMoP
         el6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703255717; x=1703860517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19330V05jnim9tqHKI81rhlyn9YLwEeYkPtMUaA5/Ts=;
        b=cpC21A3DGNlZyKvfbewbYwS4yiEjPEbgtbmy3cZRj1ORyXZ/sSpVFqZOhv0tI0PPNG
         GDs6s9ok+nPCdQYtmQXFrPADFjcM0FBaUIbkVJURbZBwkTuDFy6gD1l/6+wSVX8s8JVb
         8Zy0gx6PQtUdI2QTGPDrdWmEvzNKOVaY0PhTwA1GeElcKdY5K/LF3agzDOXG0o4x5kdF
         xUZXMhQkn+RBxQ81YNfQ8yneWBshcQAcJgwbnd3WdlcPC38wQLll8F4JXtdMRxId49Rb
         MOuEfxmMLesYLSU1e8y3lhblzWqYXMjAtAGqQ9RmzVIyuQpWjH1FCLqgLEazbzpTzJl9
         TtTQ==
X-Gm-Message-State: AOJu0Yz3yFg4Ako3k8m2E9KxNiPH13c1ozCU7ujjw0n68E2aEWITRZvt
	aO8+bIMJxt4gOZK0BQG5DR0=
X-Google-Smtp-Source: AGHT+IFlxZdfsMnhVXkg7K6QHgzJwzt8L6U+FZduAFeGCwFFfJVANfYA42Q8L/dP9lI4kDiqivutKQ==
X-Received: by 2002:a2e:a418:0:b0:2cc:96fd:b79e with SMTP id p24-20020a2ea418000000b002cc96fdb79emr812350ljn.33.1703255716554;
        Fri, 22 Dec 2023 06:35:16 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id p25-20020a2e9ad9000000b002ccaddac048sm161994ljj.64.2023.12.22.06.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:35:15 -0800 (PST)
Date: Fri, 22 Dec 2023 17:35:12 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Prasad Sodagudi <psodagud@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Rob Herring <robh@kernel.org>, kernel@quicinc.com
Subject: Re: [PATCH net-next v8 3/3] net: stmmac: Add driver support for
 DWMAC5 common safety IRQ
Message-ID: <xdcrwxh7e4t2zkgdcfwzjr2z4ouwgv3vr4drwvshadxmpwyqkd@j3kj3p2u7nd7>
References: <20231221073620.232619-1-quic_jsuraj@quicinc.com>
 <20231221073620.232619-4-quic_jsuraj@quicinc.com>
 <yromhtr73rwsr6hizr4tq37vfvyzfue7wzpmufqyscwspzffza@uhfcrn573acd>
 <aec2dc6a-ffa4-4753-a764-77dfe1af995a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec2dc6a-ffa4-4753-a764-77dfe1af995a@quicinc.com>

On Fri, Dec 22, 2023 at 02:13:49PM +0530, Suraj Jaiswal wrote:
> HI Serge,
> please find commnet inline.
> 
> Thanks
> Suraj
> 
> On 12/21/2023 6:19 PM, Serge Semin wrote:
> > Hi Suraj
> > 
> > On Thu, Dec 21, 2023 at 01:06:20PM +0530, Suraj Jaiswal wrote:
> >> Add support to listen HW safety IRQ like ECC(error
> >> correction code), DPP(data path parity), FSM(finite state
> >> machine) fault in common IRQ line.
> >>
> >> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
> > 
> > Thanks for taking my notes into account. One more comment is further
> > below.
> > 
> >> ---
> >>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
> >>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 ++
> >>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++++++++++++
> >>  .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 ++++
> >>  4 files changed, 49 insertions(+)
> >>
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> >> index 721c1f8e892f..b9233b09b80f 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> >> @@ -344,6 +344,7 @@ enum request_irq_err {
> >>  	REQ_IRQ_ERR_ALL,
> >>  	REQ_IRQ_ERR_TX,
> >>  	REQ_IRQ_ERR_RX,
> >> +	REQ_IRQ_ERR_SFTY,
> >>  	REQ_IRQ_ERR_SFTY_UE,
> >>  	REQ_IRQ_ERR_SFTY_CE,
> >>  	REQ_IRQ_ERR_LPI,
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> >> index 9f89acf31050..ca3d93851bed 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> >> @@ -31,6 +31,7 @@ struct stmmac_resources {
> >>  	int wol_irq;
> >>  	int lpi_irq;
> >>  	int irq;
> >> +	int sfty_irq;
> >>  	int sfty_ce_irq;
> >>  	int sfty_ue_irq;
> >>  	int rx_irq[MTL_MAX_RX_QUEUES];
> >> @@ -297,6 +298,7 @@ struct stmmac_priv {
> >>  	void __iomem *ptpaddr;
> >>  	void __iomem *estaddr;
> >>  	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
> >> +	int sfty_irq;
> >>  	int sfty_ce_irq;
> >>  	int sfty_ue_irq;
> >>  	int rx_irq[MTL_MAX_RX_QUEUES];
> >> @@ -305,6 +307,7 @@ struct stmmac_priv {
> >>  	char int_name_mac[IFNAMSIZ + 9];
> >>  	char int_name_wol[IFNAMSIZ + 9];
> >>  	char int_name_lpi[IFNAMSIZ + 9];
> >> +	char int_name_sfty[IFNAMSIZ + 10];
> >>  	char int_name_sfty_ce[IFNAMSIZ + 10];
> >>  	char int_name_sfty_ue[IFNAMSIZ + 10];
> >>  	char int_name_rx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 14];
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> index 47de466e432c..7d4e827dfeab 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> @@ -3592,6 +3592,10 @@ static void stmmac_free_irq(struct net_device *dev,
> >>  		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
> >>  			free_irq(priv->wol_irq, dev);
> >>  		fallthrough;
> >> +	case REQ_IRQ_ERR_SFTY:
> >> +		if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq)
> >> +			free_irq(priv->sfty_irq, dev);
> >> +		fallthrough;
> >>  	case REQ_IRQ_ERR_WOL:
> >>  		free_irq(dev->irq, dev);
> >>  		fallthrough;
> >> @@ -3661,6 +3665,23 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
> >>  		}
> >>  	}
> >>  
> >> +	/* Request the common Safety Feature Correctible/Uncorrectible
> >> +	 * Error line in case of another line is used
> >> +	 */
> >> +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
> >> +		int_name = priv->int_name_sfty;
> >> +		sprintf(int_name, "%s:%s", dev->name, "safety");
> >> +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
> >> +				  0, int_name, dev);
> >> +		if (unlikely(ret < 0)) {
> >> +			netdev_err(priv->dev,
> >> +				   "%s: alloc sfty MSI %d (error: %d)\n",
> >> +				   __func__, priv->sfty_irq, ret);
> >> +			irq_err = REQ_IRQ_ERR_SFTY;
> >> +			goto irq_error;
> >> +		}
> >> +	}
> >> +
> >>  	/* Request the Safety Feature Correctible Error line in
> >>  	 * case of another line is used
> >>  	 */
> >> @@ -3798,6 +3819,21 @@ static int stmmac_request_irq_single(struct net_device *dev)
> >>  		}
> >>  	}
> >>  
> >> +	/* Request the common Safety Feature Correctible/Uncorrectible
> >> +	 * Error line in case of another line is used
> >> +	 */
> >> +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
> > 
> >> +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
> >> +				  IRQF_SHARED, dev->name, dev);
> > 
> > Just noticed yesterday that stmmac_safety_interrupt() is also called
> > from the stmmac_interrupt() handler which is supposed to be registered
> > on the generic "mac" IRQ. Won't it cause races around the CSRs
> > (doubtfully but still worth to note) and the errors handling
> > (stmmac_global_err()) in case if both IRQs are raised simultaneously?
> > At the very least it looks suspicious and worth double-checking.
> > 
> > I also found out that nobody seemed to care that the same handler is
> > registered on MAC, WoL and LPI IRQ lines. Hmm, no race-related
> > problems have been reported so far for the platforms with separate
> > WoL/LPI IRQs. It's either a lucky coincident or the IRQs are always
> > assigned to the same CPU or the IRQs handle is indeed free of races.
> > In anyway it looks suspicious too. At the very least AFAICS the DMA
> > IRQ-handler is indeed racy on the status CSR access. It isn't
> > cleared-on-read, but write-one-to-clear. So the statistics might be
> > calculated more than once for the same CSR state. There might be some
> > other problems I failed to spot on the first glance.
> > 
> > David, Eric, Jacub, Paolo, your opinion about the note above?
> > 
> > -Serge(y)
> > 

> <Suraj> We are adding common IRQ similar to already present code for correcteable/uncorrecable https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c#L3592.

From that perspective your change in stmmac_request_irq_multi_msi() is
correct, but stmmac_request_irq_single() is another story. The first
one method implies assigning the individual IRQ handlers to all
available lines. The later method assigns the _common_ handler to all
the lines. The common handler already calls the Safety IRQ handler -
stmmac_safety_feat_interrupt(). So should the safety IRQ line is
separately available it's possible to have the Safety IRQ handlers
executed concurrently - in framework of the common IRQ events handling
(if safety IRQ is raised during the common IRQ being handled) and
individual Safety IRQ. It's prune to the race condition I pointed out
to in my message above. Did you consider that problem?

> Also, we need the sfty IRQ handling as soon as the fault occured & that can only be handled if we have handler attached with sfty IRQ.
> stmmac_interrupt() will only be triggerd when interrupt triggered for rx/tx packet .
> while registerting with sfty IRQ will get triggered as soon as emac HW detect the fault. 

Please read my comment more carefully. The safety IRQ can be raised
during the common IRQ handling, thus the
stmmac_safety_feat_interrupt() method might get to be concurrently
executed.

-Serge(y)

>    
> >> +		if (unlikely(ret < 0)) {
> >> +			netdev_err(priv->dev,
> >> +				   "%s: ERROR: allocating the sfty IRQ %d (%d)\n",
> >> +				   __func__, priv->sfty_irq, ret);
> >> +			irq_err = REQ_IRQ_ERR_SFTY;
> >> +			goto irq_error;
> >> +		}
> >> +	}
> >> +
> >>  	return 0;
> >>  
> >>  irq_error:
> >> @@ -7462,6 +7498,7 @@ int stmmac_dvr_probe(struct device *device,
> >>  	priv->dev->irq = res->irq;
> >>  	priv->wol_irq = res->wol_irq;
> >>  	priv->lpi_irq = res->lpi_irq;
> >> +	priv->sfty_irq = res->sfty_irq;
> >>  	priv->sfty_ce_irq = res->sfty_ce_irq;
> >>  	priv->sfty_ue_irq = res->sfty_ue_irq;
> >>  	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> >> index 70eadc83ca68..ab250161fd79 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> >> @@ -743,6 +743,14 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
> >>  		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
> >>  	}
> >>  
> >> +	stmmac_res->sfty_irq =
> >> +		platform_get_irq_byname_optional(pdev, "sfty");
> >> +	if (stmmac_res->sfty_irq < 0) {
> >> +		if (stmmac_res->sfty_irq == -EPROBE_DEFER)
> >> +			return -EPROBE_DEFER;
> >> +		dev_info(&pdev->dev, "IRQ safety IRQ not found\n");
> >> +	}
> >> +
> >>  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
> >>  
> >>  	return PTR_ERR_OR_ZERO(stmmac_res->addr);
> >> -- 
> >> 2.25.1
> >>
> >>

