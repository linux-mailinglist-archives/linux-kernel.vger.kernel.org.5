Return-Path: <linux-kernel+bounces-105587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772787E116
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A212B1F21619
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B394321A0D;
	Sun, 17 Mar 2024 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkbr5BVt"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D5208CA;
	Sun, 17 Mar 2024 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710717981; cv=none; b=X/NTi3dF3FYfi2uSeCJcANKb0/SOQnhFacxPt7hlkFpG6DzcS9PrKjdRQI/mksOUAc20Vu8rgEHVwa4BtlSvWnrQy1PvolYEwOc8vUCP3UiDZ9hC1C4gCmfTRPh3lPcL3UCVOPDZYH4wWL2kwFBJwslQKnfgGqHnMUlxZs/R7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710717981; c=relaxed/simple;
	bh=yJbmtDuAqP/lli7wRxiNr9XN4EGDnOPNt8BBCEgtbtA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4Q5s27IDEKbQ9cu6GHbwkQDwdnnp2E7DYPuUimJL8vE65hYUfC1R5WHHope9McxyWXKXt3kyZqHmMX1TcHvg+SfrSmrb1mMpTN/uP+7HyuzDKvPf1zZx+io/bWMvZ/8skuxYvK4qnbwaWVy7ovj5XxeFcjMETo+EfneSDN8UuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bkbr5BVt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a466a27d30aso479601666b.1;
        Sun, 17 Mar 2024 16:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710717978; x=1711322778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+6mkHILiQfAFfw53RlDGTHQc/Jh7baPT9IsykWK7bc=;
        b=Bkbr5BVtJfLbhkU5pBNorwSWYGPuNFi9znWrqQNa9GyopBMkPEpFSeDPJ1eyGdHZvf
         1lyEn/mkic/dCVIMWNDLXWwBwa6JY/P3KY2mdk3wVard/pyjiX3jP52+pteJrKjvZOlF
         jim0WkHDnhIQslDuqXulfmAHR+CBHbwv3EuzTndnT1so1gekXe0YDvGPvwbU7yopdOt3
         083CM/Uclg3cq6tYEY//UBxdT1vjL1SVGDiJm2McJKlUC5S785dxYezRegfuvtayg87V
         U45l4j28YES8L2aQqvHYR8SP5t0GBd+i+TFQUvi0snbK46HPwBaTtJ2ZgH4LMy4yFhdz
         gsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710717978; x=1711322778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+6mkHILiQfAFfw53RlDGTHQc/Jh7baPT9IsykWK7bc=;
        b=qrUEaLij/5e+Z6c4ICCXz+W6ilyT2bFti5Yup7fBJATbJ972zAFcIqiLaruQ9GJkPh
         oA6IIbXuxdOdk9TdRkdwZq2Ef1urX8bTljuvu0z4e0GrdRDWwanKW577rjJQloWnNh5X
         zJYvi86r9zNE1Fgk1c242jH8pe4PZLPcSJlYz4675blc2zGGLsWrYOz0oSPCwF40E78f
         9bGJ+RxV8fABpAKEhBZoy45MGcdr7DBQlLJ5BhwOqFBEiPRZ4a212vcjoOv8h/37c81U
         b/FlW6dRzZ/fhckbrD+tH/PUdPtOXotXvsKxLsxqIJy+IKUFvI6r6WO3nuzEC1aS44R3
         x2tg==
X-Forwarded-Encrypted: i=1; AJvYcCXG9SF7lDUqFOQg25mf+tTQi9wh5fxByegW0TynsCUT1BNkylBKSqR9tMT88h4a1pCgqJw6sdmBMCvdh8nLsgEbY/Cnq8eb0ablSeDdG7X1SOicjeU3kfdpIM0Bmpid/7zURz1qu8hKCv1kiYtHzt+oQj9cpwdX+rXLBavRNIhW0O4AjmIDfFt5t8vYkiMNT555Ks5mGEGr0YQHCw==
X-Gm-Message-State: AOJu0Yzbaa4ZQfNswcflBN1mg/i4xbIfjDR7X0sKDamIfgh9FaA2Ey2I
	J/SFZkW1faBm8tWoTvTN/1ICsxmEXAK53QlklisrMSBL4V45Qk95
X-Google-Smtp-Source: AGHT+IHyDJ6+V3tdElVtInMQ550m0MOes+J8YEpEEg6j7ceeQZvmwyhF5Zm0A4bO+BPTsaryLFJ/Jw==
X-Received: by 2002:a17:906:ecb2:b0:a46:b028:7dd2 with SMTP id qh18-20020a170906ecb200b00a46b0287dd2mr1869705ejb.48.1710717978225;
        Sun, 17 Mar 2024 16:26:18 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::f845])
        by smtp.gmail.com with ESMTPSA id p20-20020a1709060dd400b00a46a3e4ef11sm2123968eji.92.2024.03.17.16.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 16:26:17 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
X-Google-Original-From: Wadim Mueller <wadim.mueller@continental.com>
Date: Mon, 18 Mar 2024 00:26:15 +0100
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Johannes Zink <j.zink@pengutronix.de>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Swee Leong Ching <leong.ching.swee@intel.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] net: stmmac: Add NXP S32 SoC family support
Message-ID: <20240317232615.GB22886@bhlegrsu.conti.de>
References: <20240315222754.22366-1-wafgo01@gmail.com>
 <20240315222754.22366-3-wafgo01@gmail.com>
 <2316e61d-ad7d-46fb-9f55-67964552855a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2316e61d-ad7d-46fb-9f55-67964552855a@linaro.org>

On Sun, Mar 17, 2024 at 03:53:19PM +0100, Krzysztof Kozlowski wrote:
> On 15/03/2024 23:27, Wadim Mueller wrote:
> > Add support for NXP S32 SoC family's GMAC to the stmmac network driver. This driver implementation is based on the patchset originally contributed by Chester Lin [1], which itself draws heavily from NXP's downstream implementation [2]. The patchset was never merged.
> > 
> > The S32G2/3 SoCs feature multiple Ethernet interfaces (PFE0, PFE1, PFE2, and GMAC) which can be routed through a SerDes Subsystem, supporting various interfaces such as SGMII and RGMII. However, the current Glue Code lacks support for SerDes routing and pinctrl handling, relying solely on correct settings in U-Boot. Clock settings for this SoC are managed by the ATF Firmware.
> 
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
> 
> Read how commit msg should be wrapped.
> 
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> 
> > 
> > Changes made compared to [1]:
> > 
> >     Rebased onto Linux 6.8-rc7
> >     Consolidated into a single commit
> >     Minor adjustments in naming and usage of dev_err()/dev_info()
> > 
> > Test Environment:
> > The driver has been successfully tested on the official S32G-VNP-RDB3 Reference Design Board from NXP, utilizing an S32G3 SoC. The firmware and U-Boot used were from the BSP39 Release. The official BSP39 Ubuntu 22.04 Release was successfully booted. A network stress test using iperf [3] was also executed without issues.
> > 
> > [1] https://patchwork.kernel.org/project/netdevbpf/patch/20221031101052.14956-6-clin@suse.com/#25068228
> > [2] https://github.com/nxp-auto-linux/linux/blob/release/bsp39.0-5.15.129-rt/drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c
> > [3] https://linux.die.net/man/1/iperf
> > [4] https://github.com/nxp-auto-linux/u-boot
> > [5] https://github.com/nxp-auto-linux/arm-trusted-firmware
> > 
> > Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
> >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> 
> That's totally unrelated to DTS. Do not mix independent work in one
> patchset. This targets net-next, not SoC, so please send it as separate
> patchset when net-next reopens, so after merge window.
>

Let me try to explain why I was thinking that both should be part of the
same patchset. 

The DTS file patch [1/3] is refering to a NIC for which there is no
upstream driver (or lets call it better glue code for the real driver) available. 

This patch here is supposed to add support for this driver. So without this part the DT
node named "gmac0" of [1/3] is not of much use. Thats why I was thinking they
should be part of one patchset.

But your statement also totally makes sense to me.

Thanks for the feedback!

> >  drivers/net/ethernet/stmicro/stmmac/common.h  |   3 +
> >  .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 313 ++++++++++++++++++
> >  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   9 +
> >  .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |   3 +
> >  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   5 +
> >  .../net/ethernet/stmicro/stmmac/stmmac_main.c |   7 +
> >  include/linux/stmmac.h                        |   9 +
> >  9 files changed, 362 insertions(+)
> >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > index 85dcda51df05..1cdf2da0251c 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > @@ -142,6 +142,18 @@ config DWMAC_ROCKCHIP
> >  	  This selects the Rockchip RK3288 SoC glue layer support for
> >  	  the stmmac device drive
> 
> 
> ...
> 
> > +
> > +	plat_dat->safety_feat_cfg->tsoee = 1;
> > +	plat_dat->safety_feat_cfg->mrxpee = 1;
> > +	plat_dat->safety_feat_cfg->mestee = 1;
> > +	plat_dat->safety_feat_cfg->mrxee = 1;
> > +	plat_dat->safety_feat_cfg->mtxee = 1;
> > +	plat_dat->safety_feat_cfg->epsi = 1;
> > +	plat_dat->safety_feat_cfg->edpp = 1;
> > +	plat_dat->safety_feat_cfg->prtyen = 1;
> > +	plat_dat->safety_feat_cfg->tmouten = 1;
> > +
> > +	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> > +	if (ret)
> > +		goto err_gmac_exit;
> > +
> > +	return 0;
> > +
> > +err_gmac_exit:
> > +	s32_gmac_exit(pdev, plat_dat->bsp_priv);
> > +	return ret;
> > +}
> > +
> > +static const struct of_device_id s32_dwmac_match[] = {
> > +	{ .compatible = "nxp,s32-dwmac" },
> 
> 
> Missing bindings.
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
> 
> > +	{}
> > +};
> 
> 
> 
> Best regards,
> Krzysztof
> 

