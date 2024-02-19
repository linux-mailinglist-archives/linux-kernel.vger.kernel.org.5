Return-Path: <linux-kernel+bounces-71810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5835E85AB02
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9C01F22784
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76DE1079B;
	Mon, 19 Feb 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brm9i47H"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561CC524A;
	Mon, 19 Feb 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367570; cv=none; b=dtkNASEHv2K6X7lY3vzpBZ/hZgTSm+bwB+0ocUVvArFDVv8Ej9bTu/ZWskWZuPGqWOyBM/3GLWFGqfMEIuEqEPFHbiYwwHtRsGiY6KSmzRK1H+FcG3OOB36R2xroVmqBT8gPewpsnLmLJJoxAZnijZ38blMHkfP1r47uROYhhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367570; c=relaxed/simple;
	bh=YrLX6h6zpUU+pvvsz6souDjSY0pfdoaPwuIuZPiNpKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WODYqCv2mXB2FENCqxCoMJozI8V01AsMnD/N4Al+2q2Wofe5ZSXKAmcyweFKSgNnGb//EJ76deFQUWMIi0Oe3x7/GpU3itIl/NTSTX+1vasGJ4AKPUdSsWNDL1Dzjf/oNffcQeCnlB8UGM9liyO4V4aCtYJ/2m/kaitmon5LOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Brm9i47H; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512b13bf764so1659595e87.0;
        Mon, 19 Feb 2024 10:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708367566; x=1708972366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQmnFQAFKA09Z157wegtMc6k6Apxcc2vInoqwQQtLPM=;
        b=Brm9i47HHywAaOZgyepjTpAreD++QgPbpeuE++ZLoimru2iyjbTe58Tj7Jo6FUH45A
         ID4Ii6iXTEVCony6A9fXJy4EAkElfPdPaXwNH33oioMRhgJMp58C7NAj+tj7APagwieM
         Wsz+G/DX5ZidKfEKpj6PMKcRuPuoP+G+PnhnLit+V+Kz06MOdMekzDgpAa9EJ6+8o8Ij
         GlWrCMtd84zAc/nzy7R3/tHMQZsl/i2GNHEVOnWH9eeBAWYCB+rSfjaWA9HpGXqIIdWK
         6idwiNBne0/g3ughiAL36uXQDd0v2fCsb5z/EW86WMupU3F0eVPojV3dgB0kTeE4GZyC
         faJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708367566; x=1708972366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQmnFQAFKA09Z157wegtMc6k6Apxcc2vInoqwQQtLPM=;
        b=hw83UODRRrK7CsU04kLXK8FTq1Te6op/1WTeztNh297v7VbRLhkiBWKsiZp9vkmKN9
         +ZlAO10lprRf1UaJVZ7aBjZZmaXxtUa6fJO9kj3Kqaiew34sQQ32GNAugO+m8d2Ni7Yd
         kCGInElOKhpXRgf13Femq9mR+M078ZFnaGeXFxFKjgELKqJuu4gYZWPUttpg1wiD6afN
         pudPizsSHuEahoKjMPIs59YMiS3rPgKW0pawC6wi6QkAMQwh1hsNN0/odnTBkc1/+Gl7
         m45NrwEZLqT2Q3XBElSZteSkl9hbqGUlSQNauPq7+HIGOPFk3IcLJik8MfKAbaR+/O/A
         j0KA==
X-Forwarded-Encrypted: i=1; AJvYcCWxJFTghu6FBUcfXW1FrLRzDD18UfE+6I7RDaSw/UN71nG/eeOY6rCGa8PE0RhvIBSIPRdkLb9j8bD6hzB416weQtH8ZzaSsTmNo0mHlIYLubebOQtSvXUQGaSfsLuDJZRnUjltI3u4bwmoddjWo7IzU4fyUE4E4mgmuadB8Fz3PNI=
X-Gm-Message-State: AOJu0YyAPZ+kW7HLnq3TbOfnPjrbHieBZIYYtrFaV5tgwIWNQmAoJ9ap
	2GCdohRghc3fEUifhiaP4hLsKbopRJSIiehh93uuCwQl0KdwmOj6
X-Google-Smtp-Source: AGHT+IECKkeoUmhv41g+UvxvTA6mP8LU7x576Bj2xMF5yqj4MUnSM2YoGVzChUo5R6uJ/18ng8WRFQ==
X-Received: by 2002:a05:6512:3f08:b0:512:b087:4de0 with SMTP id y8-20020a0565123f0800b00512b0874de0mr3768185lfa.57.1708367566156;
        Mon, 19 Feb 2024 10:32:46 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f26-20020a19ae1a000000b00512b9147a7esm324479lfc.83.2024.02.19.10.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 10:32:45 -0800 (PST)
Date: Mon, 19 Feb 2024 21:32:43 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Configure AXI on Tegra234
 MGBE
Message-ID: <xne2i6jwqaptsrd2hjdahxbscysgtj7iabqendyjb75fnrjc5z@js7n7qngtzym>
References: <20240219-stmmac-axi-config-v3-0-fca7f046e6ee@nvidia.com>
 <20240219-stmmac-axi-config-v3-3-fca7f046e6ee@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219-stmmac-axi-config-v3-3-fca7f046e6ee@nvidia.com>

On Mon, Feb 19, 2024 at 05:46:06PM +0100, Thierry Reding wrote:
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

Let's get back to the v2 discussion:

On Mon Feb 5, 2024 at 1:44 AM CET, Serge Semin wrote:
> The entire series can be converted to just a few lines of change:
>     plat = devm_stmmac_probe_config_dt(pdev, res.mac);
>     if (IS_ERR(plat)) {
>             err = PTR_ERR(plat);
>             goto disable_clks;
>     }
> +
> +   if (IS_ERR_OR_NULL(plat->axi)) {
> +           plat->axi = devm_kzalloc(&pdev->dev, sizeof(*axi), GFP_KERNEL);
> +           if (!plat->axi) {
> +                   ret = -ENOMEM;
> +                   goto disable_clks;
> +           }
> +   } /* else memset plat->axi with zeros if you wish */
> +
> +   plat->axi->axi_wr_osr_lmt = 63;
> +   plat->axi->axi_rd_osr_lmt = 63;
> +   plat->axi->axi_blen[0] = 256;
>  
>     plat->has_xgmac = 1;
>     plat->flags |= STMMAC_FLAG_TSO_EN;
>     plat->pmt = 1;
>
> Please don't overcomplicate the already overcomplicated driver with a
> functionality which can be reached by the default one. In this case
> the easiest way is to let the generic code work and then
> override/replace/fix/etc the retrieved values. Thus there won't be
> need in adding the redundant functionality and keep the generic
> DT-platform code a bit simpler to read.

You responded with:

On Tue, Feb 13, 2024 at 04:51:34PM +0100, Thierry Reding wrote:
> I'm not sure I understand how this is overcomplicating things. The code
> is pretty much unchanged, except that the AXI configuration can now have
> driver-specified defaults before the DT is parsed. Perhaps I need to add
> comments to make that a bit clearer?
> 
> While your version is certainly simpler it has the drawback that it no
> longer allows the platform defaults to be overridden in device tree. I
> would prefer if the defaults can be derived from the compatible string
> but if need be for those defaults to still be overridable from device
> tree.

Currently available functionality is easier to read and understand: by
default the data is retrieved from the DT, if no AXI DT-node found you
can allocate/create your own AXI-configs, if there is AXI DT-node you
can fix it up in whatever way your wish. Thus the default behavior is
straightforward. You on the contrary suggest to add an additional
field to the resources structure which would need to be merged in with
the data retrieved from DT. It makes the stmmac_axi_setup() method and
the entire logic more complex and thus harder to comprehend. The
driver is already overwhelmed with flags and private/platform data
fixing the code here and there (see plat_stmmacenet_data, it's a
madness). So please justify in more details why do you need one more
complexity added instead of:
1. overriding the AXI-configs retrieved from DT,
2. updating DT on your platform
?

-Serge(y)

> 
> -- 
> 2.43.2
> 

