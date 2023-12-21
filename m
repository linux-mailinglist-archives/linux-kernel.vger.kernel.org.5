Return-Path: <linux-kernel+bounces-8398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900DD81B69B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3EC41C2591B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D1A745F7;
	Thu, 21 Dec 2023 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnLq2VqO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF9745D9;
	Thu, 21 Dec 2023 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e239c49d0so974511e87.2;
        Thu, 21 Dec 2023 04:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703162968; x=1703767768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/mzU2hT9PSnrGwqsNWl+y1l0fBpKuzZ5AOH7TNPFbk=;
        b=fnLq2VqOvubnI8OOe7cTti8MNmir99Kh7WN5EiRLxEUiuqXej2pmYOYI3CQjYKl31L
         kcSVzHzIi7d6mAvvCZ9XWX/HGV9Zk5Ubnul/g6EPGQvVWPxKh0VDHCmckSJOUWxpITRz
         YjKXmkKBs48lSP7CRkIMSmYXt4hHZthXyfhJE04aWHwmAc4YkfLm9jPEGzql08N6eFbG
         GCblC+yfyQjTT+/WEGTCGaqHyiO3/amrWgQi1+pg74jQ8FLlBWLOyn8qMjlolqXMMQCD
         uBP1S/ljkVIX08nALp+zMXPRqe4aHzhiPYdiF1WaNZNbiqud+e8NKas+YSrrh7vZe+k1
         6POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703162968; x=1703767768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/mzU2hT9PSnrGwqsNWl+y1l0fBpKuzZ5AOH7TNPFbk=;
        b=Sp7n2jRdjaw5gABaYWKH2Y0qmAmNyJG/r+NMY0Cb6kzwMUztp1VD3NYSzN/yAdVqau
         o5EJrWLF0f2NA94mFQ0Oj69dQM4jsF7vKuBjpXLoQIpT0OOcWvMpySCFYvlqOQiFbeCU
         Vw8+benvlZcsZh0C2lZj8Rmd91XBgXDpuJZP/+3UTPJ+u8hL8KTVSXceJ+z84y1AH1tg
         8OwAELO4CYbWlqCFD1ZbA7WiwyGTwxqHd5v4VYAQH3XyDjOEeUV6kf/p0Z+6y25QkvEr
         eFRzuD6unVsu8j5u5FF/olz9wpjszMgvl21RPmJ9uzkBUK2oDV+/oiWhoErviF+r4TMt
         LESw==
X-Gm-Message-State: AOJu0YxNU7A7SMrLOmi5Vongf7kq7DBtn+rY6x6bma6UItSeo5u9UIhR
	J23wM/v6OjwNdoakVV9lKqA=
X-Google-Smtp-Source: AGHT+IGyV6f8UBheAjNEECK8PtWI9VmNULPlJgekTe+vJCU+PbbS1a1JmkG5ZHVdEmvAloCVKJ4sGA==
X-Received: by 2002:ac2:596d:0:b0:50d:179b:b38d with SMTP id h13-20020ac2596d000000b0050d179bb38dmr8710227lfp.45.1703162967896;
        Thu, 21 Dec 2023 04:49:27 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d19-20020a193853000000b0050bf16efc9csm266216lfj.308.2023.12.21.04.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 04:49:27 -0800 (PST)
Date: Thu, 21 Dec 2023 15:49:23 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
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
Message-ID: <yromhtr73rwsr6hizr4tq37vfvyzfue7wzpmufqyscwspzffza@uhfcrn573acd>
References: <20231221073620.232619-1-quic_jsuraj@quicinc.com>
 <20231221073620.232619-4-quic_jsuraj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221073620.232619-4-quic_jsuraj@quicinc.com>

Hi Suraj

On Thu, Dec 21, 2023 at 01:06:20PM +0530, Suraj Jaiswal wrote:
> Add support to listen HW safety IRQ like ECC(error
> correction code), DPP(data path parity), FSM(finite state
> machine) fault in common IRQ line.
> 
> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>

Thanks for taking my notes into account. One more comment is further
below.

> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 ++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++++++++++++
>  .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 ++++
>  4 files changed, 49 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index 721c1f8e892f..b9233b09b80f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -344,6 +344,7 @@ enum request_irq_err {
>  	REQ_IRQ_ERR_ALL,
>  	REQ_IRQ_ERR_TX,
>  	REQ_IRQ_ERR_RX,
> +	REQ_IRQ_ERR_SFTY,
>  	REQ_IRQ_ERR_SFTY_UE,
>  	REQ_IRQ_ERR_SFTY_CE,
>  	REQ_IRQ_ERR_LPI,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 9f89acf31050..ca3d93851bed 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -31,6 +31,7 @@ struct stmmac_resources {
>  	int wol_irq;
>  	int lpi_irq;
>  	int irq;
> +	int sfty_irq;
>  	int sfty_ce_irq;
>  	int sfty_ue_irq;
>  	int rx_irq[MTL_MAX_RX_QUEUES];
> @@ -297,6 +298,7 @@ struct stmmac_priv {
>  	void __iomem *ptpaddr;
>  	void __iomem *estaddr;
>  	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
> +	int sfty_irq;
>  	int sfty_ce_irq;
>  	int sfty_ue_irq;
>  	int rx_irq[MTL_MAX_RX_QUEUES];
> @@ -305,6 +307,7 @@ struct stmmac_priv {
>  	char int_name_mac[IFNAMSIZ + 9];
>  	char int_name_wol[IFNAMSIZ + 9];
>  	char int_name_lpi[IFNAMSIZ + 9];
> +	char int_name_sfty[IFNAMSIZ + 10];
>  	char int_name_sfty_ce[IFNAMSIZ + 10];
>  	char int_name_sfty_ue[IFNAMSIZ + 10];
>  	char int_name_rx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 14];
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 47de466e432c..7d4e827dfeab 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3592,6 +3592,10 @@ static void stmmac_free_irq(struct net_device *dev,
>  		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
>  			free_irq(priv->wol_irq, dev);
>  		fallthrough;
> +	case REQ_IRQ_ERR_SFTY:
> +		if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq)
> +			free_irq(priv->sfty_irq, dev);
> +		fallthrough;
>  	case REQ_IRQ_ERR_WOL:
>  		free_irq(dev->irq, dev);
>  		fallthrough;
> @@ -3661,6 +3665,23 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  		}
>  	}
>  
> +	/* Request the common Safety Feature Correctible/Uncorrectible
> +	 * Error line in case of another line is used
> +	 */
> +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
> +		int_name = priv->int_name_sfty;
> +		sprintf(int_name, "%s:%s", dev->name, "safety");
> +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
> +				  0, int_name, dev);
> +		if (unlikely(ret < 0)) {
> +			netdev_err(priv->dev,
> +				   "%s: alloc sfty MSI %d (error: %d)\n",
> +				   __func__, priv->sfty_irq, ret);
> +			irq_err = REQ_IRQ_ERR_SFTY;
> +			goto irq_error;
> +		}
> +	}
> +
>  	/* Request the Safety Feature Correctible Error line in
>  	 * case of another line is used
>  	 */
> @@ -3798,6 +3819,21 @@ static int stmmac_request_irq_single(struct net_device *dev)
>  		}
>  	}
>  
> +	/* Request the common Safety Feature Correctible/Uncorrectible
> +	 * Error line in case of another line is used
> +	 */
> +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {

> +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
> +				  IRQF_SHARED, dev->name, dev);

Just noticed yesterday that stmmac_safety_interrupt() is also called
from the stmmac_interrupt() handler which is supposed to be registered
on the generic "mac" IRQ. Won't it cause races around the CSRs
(doubtfully but still worth to note) and the errors handling
(stmmac_global_err()) in case if both IRQs are raised simultaneously?
At the very least it looks suspicious and worth double-checking.

I also found out that nobody seemed to care that the same handler is
registered on MAC, WoL and LPI IRQ lines. Hmm, no race-related
problems have been reported so far for the platforms with separate
WoL/LPI IRQs. It's either a lucky coincident or the IRQs are always
assigned to the same CPU or the IRQs handle is indeed free of races.
In anyway it looks suspicious too. At the very least AFAICS the DMA
IRQ-handler is indeed racy on the status CSR access. It isn't
cleared-on-read, but write-one-to-clear. So the statistics might be
calculated more than once for the same CSR state. There might be some
other problems I failed to spot on the first glance.

David, Eric, Jacub, Paolo, your opinion about the note above?

-Serge(y)

> +		if (unlikely(ret < 0)) {
> +			netdev_err(priv->dev,
> +				   "%s: ERROR: allocating the sfty IRQ %d (%d)\n",
> +				   __func__, priv->sfty_irq, ret);
> +			irq_err = REQ_IRQ_ERR_SFTY;
> +			goto irq_error;
> +		}
> +	}
> +
>  	return 0;
>  
>  irq_error:
> @@ -7462,6 +7498,7 @@ int stmmac_dvr_probe(struct device *device,
>  	priv->dev->irq = res->irq;
>  	priv->wol_irq = res->wol_irq;
>  	priv->lpi_irq = res->lpi_irq;
> +	priv->sfty_irq = res->sfty_irq;
>  	priv->sfty_ce_irq = res->sfty_ce_irq;
>  	priv->sfty_ue_irq = res->sfty_ue_irq;
>  	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 70eadc83ca68..ab250161fd79 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -743,6 +743,14 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>  		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
>  	}
>  
> +	stmmac_res->sfty_irq =
> +		platform_get_irq_byname_optional(pdev, "sfty");
> +	if (stmmac_res->sfty_irq < 0) {
> +		if (stmmac_res->sfty_irq == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_info(&pdev->dev, "IRQ safety IRQ not found\n");
> +	}
> +
>  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
>  
>  	return PTR_ERR_OR_ZERO(stmmac_res->addr);
> -- 
> 2.25.1
> 
> 

