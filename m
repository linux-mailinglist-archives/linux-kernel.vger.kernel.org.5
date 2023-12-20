Return-Path: <linux-kernel+bounces-7085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A87481A175
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62451F2337E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13323DB85;
	Wed, 20 Dec 2023 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI6FEutV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9DD3D965;
	Wed, 20 Dec 2023 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e270639d9so5814645e87.3;
        Wed, 20 Dec 2023 06:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703083811; x=1703688611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQMVlWraizGAsp+Xq1UapuY9LfPT8dVSobx1WZx4NDU=;
        b=QI6FEutVk6GvAbKVAQdytDRu2Vk0cLJQ/6nBacPzBJ503h+d+mU3x4urOsCWM99m13
         56cjrLMO6Ogn3ISpeQAANjWp7xjjTrFhYct1WcS3FakPYVp617xlRLBBwwUcDl0ypBw7
         SvjmRSIqc1FxDXdEuCz7Ujp0tcUaU5dr9WUTWt1Rcw9muib+fIKukIZ+aJzg5pM87IGr
         xuWNclJWOrLO8pCOIaJcvK/QbAiRaJNcr6dsdvjhzoF9Nl7IswvBgA5FF2QqdGEMlQ6K
         1tv5HSbNz1Ba5DMqj1H6iAjTyUmfIV0CcZCdw62UA5IQvwMie4as6yJxUH3QxdTEWxkw
         ZCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703083811; x=1703688611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQMVlWraizGAsp+Xq1UapuY9LfPT8dVSobx1WZx4NDU=;
        b=EnEfIUtDt6qcRDV5wpk/7RsyxmelsuoW3YAMc2s2DR/T5pkz99tvTfmvicqFyWIsLN
         Ik/A+TSd+O1dVYftj5DQhiAr54B4c1aXRydqmSTqRRKEeB/MJLh4x/OZw6zXHcoLOWMz
         4H7v6FGTMHjrifuiFaRWRGlTreo+kzfyT8lDqNR7x77X3mWgttkiE0PCF2ZDL2gI+R1j
         uhAe5W974uBuZ0PvvxKiUxBGPbBK7at20E6/B192tJBm5ItG2EfILN5m/CYiZ0iUAYnO
         ggavaFsnVZ39bBLRxvhKZapcPRbaCEW5QdegtzO2ZhCu/9Y36R218B7k8ucz+4T6mbj9
         jqwQ==
X-Gm-Message-State: AOJu0YzisTBtJSzgzNqTKkzupfzfzVFiYplZhBrfe27K0N5gPB2RTu3G
	njjUQ7auxYUZDcUpFkcntNQ=
X-Google-Smtp-Source: AGHT+IH2QPqNZG3UOvLCupNMT1tPQwsk3NsXXG5geXiKr9gUlC2O7XrU3eI+6JRjQfPd86pupnKiYw==
X-Received: by 2002:a05:6512:239a:b0:50e:4ec6:ed15 with SMTP id c26-20020a056512239a00b0050e4ec6ed15mr1194151lfv.107.1703083810905;
        Wed, 20 Dec 2023 06:50:10 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b11-20020a0565120b8b00b0050e40a2bc97sm615311lfv.13.2023.12.20.06.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 06:50:10 -0800 (PST)
Date: Wed, 20 Dec 2023 17:50:05 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Prasad Sodagudi <psodagud@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Rob Herring <robh@kernel.org>, kernel@quicinc.com
Subject: Re: [PATCH net-next v7 3/3] net: stmmac: Add driver support for
 DWMAC5 common safety IRQ
Message-ID: <irmn42brbxjwz45gh7hoay4aeollnq7gnzkuyuzjxjyh3syrst@mvgm7vecrhna>
References: <20231219104815.3443231-1-quic_jsuraj@quicinc.com>
 <20231219104815.3443231-4-quic_jsuraj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lffsxbm2gt2npdfi"
Content-Disposition: inline
In-Reply-To: <20231219104815.3443231-4-quic_jsuraj@quicinc.com>


--lffsxbm2gt2npdfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Suraj

On Tue, Dec 19, 2023 at 04:18:15PM +0530, Suraj Jaiswal wrote:
> Add support to listen HW safety IRQ like ECC(error
> correction code), DPP(data path parity), FSM(finite state
> machine) fault in common IRQ line.
> 
> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35 +++++++++++++++++++
>  .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 +++++
>  4 files changed, 46 insertions(+)
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
> index 9f89acf31050..9aeaca01cace 100644
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
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 47de466e432c..f6639ffb017e 100644
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
> @@ -3661,6 +3665,21 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  		}
>  	}
>  
> +	/* Request the common Safety Feature Correctible/Uncorrectible
> +	 * Error line in case of another line is used
> +	 */

> +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
> +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
> +				  0, dev->name, dev);

Not entirely what I asked. What I asked was to make the code unified in
the respective IRQ-request methods. You just copy-and-pasted the same
code snippet in both functions. To see what I meant please find the
diff attached to this message. It's applicable on top of this patch.

> +		if (unlikely(ret < 0)) {
> +			netdev_err(priv->dev,

> +				   "%s: alloc safety failed %d (error: %d)\n",
> +				   __func__, priv->sfty_irq, ret);

This looks different than the rest of the error messages in this
method (see the attached diff).

> +			irq_err = REQ_IRQ_ERR_SFTY;
> +			goto irq_error;
> +		}
> +	}
> +
>  	/* Request the Safety Feature Correctible Error line in
>  	 * case of another line is used
>  	 */
> @@ -3798,6 +3817,21 @@ static int stmmac_request_irq_single(struct net_device *dev)
>  		}
>  	}
>  
> +	/* Request the common Safety Feature Correctible/Uncorrectible
> +	 * Error line in case of another line is used
> +	 */
> +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {

> +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
> +				  0, dev->name, dev);

IRQF_SHARED?

> +		if (unlikely(ret < 0)) {

> +			netdev_err(priv->dev,
> +				   "%s: alloc safety failed %d (error: %d)\n",
> +				   __func__, priv->sfty_irq, ret);

This also looks different than the rest of the error messages in this 
method (see the attached diff).

Some other comments I'll send to v8 after all the above finally fixed.

-Serge(y)

> +			irq_err = REQ_IRQ_ERR_SFTY;
> +			goto irq_error;
> +		}
> +	}
> +
>  	return 0;
>  
>  irq_error:
> @@ -7462,6 +7496,7 @@ int stmmac_dvr_probe(struct device *device,
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

--lffsxbm2gt2npdfi
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="common_sfty_irq.diff"

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index f9d80fc00cb8..2bb3f1adbb61 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -329,6 +329,7 @@ struct stmmac_priv {
 	char int_name_mac[IFNAMSIZ + 9];
 	char int_name_wol[IFNAMSIZ + 9];
 	char int_name_lpi[IFNAMSIZ + 9];
+	char int_name_sfty[IFNAMSIZ + 10];
 	char int_name_sfty_ce[IFNAMSIZ + 10];
 	char int_name_sfty_ue[IFNAMSIZ + 10];
 	char int_name_rx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 14];
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e49b1306b338..93439a14378f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3539,11 +3539,13 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	 * Error line in case of another line is used
 	 */
 	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
+		int_name = priv->int_name_sfty;
+		sprintf(int_name, "%s:%s", dev->name, "safety");
 		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
-				  0, dev->name, dev);
+				  0, int_name, dev);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
-				   "%s: alloc safety failed %d (error: %d)\n",
+				   "%s: alloc sfty MSI %d (error: %d)\n",
 				   __func__, priv->sfty_irq, ret);
 			irq_err = REQ_IRQ_ERR_SFTY;
 			goto irq_error;
@@ -3692,10 +3694,10 @@ static int stmmac_request_irq_single(struct net_device *dev)
 	 */
 	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
 		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
-				  0, dev->name, dev);
+				  IRQF_SHARED, dev->name, dev);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
-				   "%s: alloc safety failed %d (error: %d)\n",
+				   "%s: ERROR: allocating the sfty IRQ %d (%d)\n",
 				   __func__, priv->sfty_irq, ret);
 			irq_err = REQ_IRQ_ERR_SFTY;
 			goto irq_error;

--lffsxbm2gt2npdfi--

