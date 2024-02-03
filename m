Return-Path: <linux-kernel+bounces-51102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0512384867F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298341C229FF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644E25D72F;
	Sat,  3 Feb 2024 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pmdAF86Q"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25672BAEF
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706966330; cv=none; b=Nu9iF3yMbbY/Z2U95ca730eyLMWRDYPk4zCRbPWuVbjYVZYpll9r4Ci9lUUKhYxsJ4mMl6MoWVD0IlEfJvJI0o2FL5ulzvmQvVqHZJcNDjDOuNMv4vEQaFWhiiggjgKeX/VZ3lOw121lvMk7rPZguT2WyWkMuYK3hjFl7q1k36g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706966330; c=relaxed/simple;
	bh=ebWJCjT30yIAAIxmF96XqYeAeD4KseJ+IIABQegktLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT0De9kHJRh+AckMEbcPTRqgm7ZYgPu3IDX86c5geUyYiXLT5uKen76SRhEqZlCQ+ssJBoG6Bhww/vK7xk6yFc9QWx45nN8aOg+sPuMjt+Tm3mp4g2YThQEA55cq4Z4MyJHCBB8evzu/Wto/Rskh5iMpUOHBF4kZVFqjeZWe/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pmdAF86Q; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b18099411so1796557f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 05:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706966327; x=1707571127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DWfHGvyLS9Vdj8BUW4SV7fQsQn/7GRDVDPI4v8u0+as=;
        b=pmdAF86QQnmX1X3mniABw89pNEUSCB6jA5BOP7aRYZnbKDyOE8AJNrpsPn88JOd3V0
         ku+OyIdCTK1TAe+GpgyJ5DWBjZIapGdbwRbjhJdB4bHlfU6w5SUplHyE0A8ZgtDoWeE6
         EkGXuhGZlzPyEKMpNSJwqVTeRtuFGCuNWjriYkq/FbQh5pS/kJbTBNzbq20go0Ie08Cy
         7gfI6G0pGneyEtew4vnnC2ADIACIT9Ae6vK/WQRnOmuUhcpATsTVERno7g4yNJxODPjJ
         sAkPL8VXAv5XEuTUgDir5RHwG88MuKAXjWKBbdXkuzYp4Ks8HbeweHW+SpPEi0RZ5CQV
         FXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706966327; x=1707571127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWfHGvyLS9Vdj8BUW4SV7fQsQn/7GRDVDPI4v8u0+as=;
        b=WqsN5oc2tw5u30SfuXa7Zbor1a0oQTr3d6UYWgATDpPH+tUaH11EGy3N6Mqvf3dPVU
         Uvr9RJjSq1tbyiYxk2w/Zxpv6BUmSBftRpdIx0bL+LZHgaPGN/POmzlf8+ifpcQkYNR0
         zaYaB9VYScPF/ydrLQxZ+6MEGEidaqvGIRdNcVKdeIdldiXFEg6x8gAYGc9P8kXfo5OM
         7F8n84MkF955Gtn99OHTZNjA+t7uB5TdyAADJ3UR0DFTsTmTzenj1kfsZ09Ye2lffWw3
         f7gNOBL0ARGHYrMB149ahJF2h9Rz5R3cmCsUPXE3ZecFP/69ofRLzAlQjGV1ZjpvgVKR
         XbFw==
X-Gm-Message-State: AOJu0Yw/f60+XYdt1ZZsq2knsNdIzSW6ox46ig9KLIf9ZbDh7POrmOgT
	byQLGK5vc3luG1YTar7zp8rSsZ+DWyewfhdSG2rxlxBPUaS3lfYv1eMK1JByke8=
X-Google-Smtp-Source: AGHT+IHbhiTWLBl6YahL3JztbgGYK6YB780/wlpqRr77AzqPbB4zWyVEyfXchL5cgCYGdII6nMrG2w==
X-Received: by 2002:adf:fd45:0:b0:33a:e56f:1ddb with SMTP id h5-20020adffd45000000b0033ae56f1ddbmr3178428wrs.46.1706966326943;
        Sat, 03 Feb 2024 05:18:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX8boruPRGCZlECRQFcP7XDgA7uXo0XyWVGVmXTuh79Q8jTdX7LTleA+Kmy8ecCa7gYnyawFJUfOGf7YK4k0mXE9M0sARfiyGnPPXQplpXIfF3PumEU7SNPYCLOnpvAiDwylGD2nvgqJA7odDPvgNY2XcYbigJx7JsdXGMo6/fNe7fmEI92Qn/M3FEBfMHgoMMEQK4gkSDxXz213p4Jf7WGlwY2aJWz4elfy+2MYDVb+vLDpira3eEBq7dgeMDsXQClnsaCgJEvd668GohgqIsWKU6zshmBGvOLTNxAsCa+ONdEEu71kfrwfinkI4ZoT3hnE0GeOim2oXmtYDs+B3mNYMyz0w57NkRwKC9CvyWh77yFKFdXYhj99/ZIU4Mnb6fT4r8H3Gr8Wm/TTzh1VY9MM1W+lZIAstMUREHZfOWiMrLDjv9ILLWxdyZcs3lL1sbRIaG3f/nv4V3aweMSBgXb4ksqXuu82PUIU8StcD8oEqPaSGVopkrptkmFtuO5wE7SCsjNzOu4aLpYMzsiSX+FM7gZCLfV6GSILppQhIvkJWiYIFHJ8OkW/+JJ1Fy9zEk=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id s2-20020a056402164200b0055f2af9b01bsm1729280edx.17.2024.02.03.05.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 05:18:46 -0800 (PST)
Date: Sat, 3 Feb 2024 14:18:43 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net] net: stmmac: xgmac: fix a typo of register name in
 DPP safety handling
Message-ID: <Zb49M9fKRR2HeGhR@nanopsycho>
References: <20240203053133.1129236-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203053133.1129236-1-0x1207@gmail.com>

Sat, Feb 03, 2024 at 06:31:33AM CET, 0x1207@gmail.com wrote:
>DDPP is copied from Synopsys Data book:
>
>DDPP: Disable Data path Parity Protection.
>    When it is 0x0, Data path Parity Protection is enabled.
>    When it is 0x1, Data path Parity Protection is disabled.
>
>The macro name should be XGMAC_DPP_DISABLE.
>
>Fixes: 46eba193d04f ("net: stmmac: xgmac: fix handling of DPP safety error for DMA channels")
>Signed-off-by: Furong Xu <0x1207@gmail.com>

Looks okay, but this is net-next material.


>---
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h      | 2 +-
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
>index 5c67a3f89f08..6a2c7d22df1e 100644
>--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
>+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
>@@ -304,7 +304,7 @@
> #define XGMAC_TXCEIE			BIT(0)
> #define XGMAC_MTL_ECC_INT_STATUS	0x000010cc
> #define XGMAC_MTL_DPP_CONTROL		0x000010e0
>-#define XGMAC_DDPP_DISABLE		BIT(0)
>+#define XGMAC_DPP_DISABLE		BIT(0)
> #define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
> #define XGMAC_TQS			GENMASK(25, 16)
> #define XGMAC_TQS_SHIFT			16
>diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>index 04d7c4dc2e35..323c57f03c93 100644
>--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>@@ -928,7 +928,7 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
> 	/* 5. Enable Data Path Parity Protection */
> 	value = readl(ioaddr + XGMAC_MTL_DPP_CONTROL);
> 	/* already enabled by default, explicit enable it again */
>-	value &= ~XGMAC_DDPP_DISABLE;
>+	value &= ~XGMAC_DPP_DISABLE;
> 	writel(value, ioaddr + XGMAC_MTL_DPP_CONTROL);
> 
> 	return 0;
>-- 
>2.34.1
>
>

