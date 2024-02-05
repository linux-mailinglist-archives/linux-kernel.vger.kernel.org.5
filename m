Return-Path: <linux-kernel+bounces-51967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F069849216
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3697E282264
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C8F28FC;
	Mon,  5 Feb 2024 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKH3BHQF"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457F3A94A;
	Mon,  5 Feb 2024 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707093857; cv=none; b=rnKhseG/dhtqjuHhK7Smvnuz3f1A06HuVNk+RzUyxHOJF94EEfHcFFAjghti+F72vL5c7m38zrJB12L6S5Pglr4IqwopIUOuDejdNpoZBQqRmbxrDDYUTpmYTX00XFVe0YL+fTTACA/kJnX8ytDUPJW0vazeMsKdkpFlMYMbczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707093857; c=relaxed/simple;
	bh=2Z5QksJq+eDLpg7FYQtmjE2jPrkh5Zzk4bJ79okWTyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcyPYgHr4nSlljrnt4C8wCUO88gDx/sjuCJUPbTek2hnYbn37RTXsNaTyAr2OHVMomtBOGyykg+oZNgaEAQ2+ulozDQfTmrm4OtXu0Vu+y5TXSeAy/Hq6hvcs0vg2MzWCwGUSqe89kEEKXH87VR6tiEk5bR7b+CJsK5bTHlfIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKH3BHQF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5111c7d40deso6369690e87.1;
        Sun, 04 Feb 2024 16:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707093853; x=1707698653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8pRLyNXA1Vc52Lsv+SyI/OT6snOptfaP6otyX8bc0Yg=;
        b=nKH3BHQFsSsHTg6d79ddZLhF99zKnu4VYh4J4baVoBp6W+zggiVuAGxpAvgnQNgjMc
         UYHBR1C/6cQYadUzeIqp2lmv8SNx2nAy9xsBKpLx1gt76ELr+rrhAsOJK55WArM0aulg
         4UNEtnJgBTtnunpU+7VrUHhPTeA10++ZsuugFQtljG6WPUfGisTrGm+Y/Ahv/fCpPEk1
         h0jZiGXD3IhUMqntXPfkjyWLd0l4GPeXnUQ4sHAos5kx5WqXIri8+7fkk5oGFqrE+7G2
         9fNMooogMpaqMyBey6bDyiS86Y1g/jsRiMsT5NCElZbRgcRUBw+s7W3ekKErXJOaArKx
         hulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707093853; x=1707698653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pRLyNXA1Vc52Lsv+SyI/OT6snOptfaP6otyX8bc0Yg=;
        b=fo697HJbt7MwQTBP3SiomPLFD603ixUHNqtEaB8+WyVFdKk/B7+GJb4poafMhU54bA
         1vy1iXw0bohJCZhHQiTDCPEUFxM1NYrjKpP/lZOdOoeIzb7LHq+Mw8gBRXWKKYaTPEK5
         CwVNB2DHcetEmuJpYClVKM8zMpFrInipK/EBRvdHleckVLy+8+TI2RzrJO7gJg/ow6mc
         iIlKq525iMoXafz2OF9TmBEmee3bIurGs3FsLTMbdU4gxxv4b7i3wdlBp06/sHBJzPpJ
         W2vjijPiOuiazFgHndR+DO1+b255Ik4dE/yQ9lJ4VIZ43WxwR4GGcgqAOCGdyG1dbMUs
         9b5g==
X-Gm-Message-State: AOJu0YxUWgNXY6+S2Y22TMiNb42IpNsYbkCgptvmWcITJ40SeOSTYJG1
	qxi0+SANtwXfPJLN+js7wUrYGGxhOKHcYXjbwShpvSkeoA90Fahq
X-Google-Smtp-Source: AGHT+IEFvRNEOvL4TW43JBOrJ42lWSMt0EtFuLCI7i2L2aDTBb6BqadOD2oDwoUbchIwtj4xKHaTtA==
X-Received: by 2002:a19:7415:0:b0:50e:cd02:b53d with SMTP id v21-20020a197415000000b0050ecd02b53dmr4698829lfe.15.1707093852945;
        Sun, 04 Feb 2024 16:44:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXtEWkAkHkm+tUMqIYOWc5ZHxjzdMxzIraTcDNQSS1b1z8fIWYxqFaAE2AMCZUw3GIhLPTmypIs4SGmA1JSmC6+cW8KF3II/ISMxwx43/15Z7qShRtowsW1TAMyL1PxvX357kC4gLy+8C9qrrrjHO4BMjrLjxODgxzYgkHLeZWIcOQpbdxPis9HMqWDg43V3JNUlD5G4yEo9XaAgn6WRBIGw3s44gzgzJyHs05W8/gaRxArhumHNdWGbrAOjtEVaOZxyaz3Epo8jcd46vHC2K3dk49L47E1kDJAEe5jSFt2DTQ+yqowkicHPDf8RumNywuaNTfuc1lTbiUuUAZaG5Z159TKaUrfA4siRSE4SEo1EkUTFZVwjEX1K/mKS9h5qwhUQNNaU4SijUXJWfVAlBkzEsLCrfA=
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id g16-20020ac25390000000b0051149482328sm500715lfh.26.2024.02.04.16.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 16:44:12 -0800 (PST)
Date: Mon, 5 Feb 2024 03:44:10 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: Configure AXI on Tegra234
 MGBE
Message-ID: <uzzzxx3mv6yoslijhhzdzyossvcvi52jgbulza54uqh2wrm5kd@ddd5o56b2dhu>
References: <20240202-stmmac-axi-config-v2-0-64eab2bab17b@nvidia.com>
 <20240202-stmmac-axi-config-v2-3-64eab2bab17b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-stmmac-axi-config-v2-3-64eab2bab17b@nvidia.com>

On Fri, Feb 02, 2024 at 12:53:35PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Allow the device to use bursts and increase the maximum number of
> outstanding requests to improve performance. Measurements show an
> increase in throughput of around 5x on a 1 Gbps link.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> index bab57d1675df..b6bfa48f279d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
> @@ -199,6 +199,12 @@ static void mgbe_uphy_lane_bringup_serdes_down(struct net_device *ndev, void *mg
>  	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
>  }
>  
> +static const struct stmmac_axi tegra234_mgbe_axi = {
> +	.axi_wr_osr_lmt = 63,
> +	.axi_rd_osr_lmt = 63,
> +	.axi_blen = { 256, },
> +};
> +
>  static int tegra_mgbe_probe(struct platform_device *pdev)
>  {
>  	struct plat_stmmacenet_data *plat;
> @@ -284,6 +290,9 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
>  	if (err < 0)
>  		goto disable_clks;
>  
> +	/* setup default AXI configuration */
> +	res.axi = &tegra234_mgbe_axi;
> +
>  	plat = devm_stmmac_probe_config_dt(pdev, &res);
>  	if (IS_ERR(plat)) {
>  		err = PTR_ERR(plat);

The entire series can be converted to just a few lines of change:

 	plat = devm_stmmac_probe_config_dt(pdev, res.mac);
 	if (IS_ERR(plat)) {
 		err = PTR_ERR(plat);
 		goto disable_clks;
 	}
+
+	if (IS_ERR_OR_NULL(plat->axi)) {
+		plat->axi = devm_kzalloc(&pdev->dev, sizeof(*axi), GFP_KERNEL);
+		if (!plat->axi) {
+			ret = -ENOMEM;
+			goto disable_clks;
+		}
+	} /* else memset plat->axi with zeros if you wish */
+
+	plat->axi->axi_wr_osr_lmt = 63;
+	plat->axi->axi_rd_osr_lmt = 63;
+	plat->axi->axi_blen[0] = 256;
 
 	plat->has_xgmac = 1;
 	plat->flags |= STMMAC_FLAG_TSO_EN;
 	plat->pmt = 1;

Please don't overcomplicate the already overcomplicated driver with a
functionality which can be reached by the default one. In this case
the easiest way is to let the generic code work and then
override/replace/fix/etc the retrieved values. Thus there won't be
need in adding the redundant functionality and keep the generic
DT-platform code a bit simpler to read.

-Serge(y)

> 
> -- 
> 2.43.0
> 
> 

