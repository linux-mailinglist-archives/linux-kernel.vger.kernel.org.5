Return-Path: <linux-kernel+bounces-37191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301DB83ACE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A542B34014
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1335286AD3;
	Wed, 24 Jan 2024 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3QnmFrO"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F287E569;
	Wed, 24 Jan 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106978; cv=none; b=sD3vmIVSNgtbyaOx2mMgZ9kjGQtwHyDOWA4cxrLe4FY9/sz04p/VVAGCZW9uPGUoVyT5Qj0JeqpguF7fmCQXZzlTrZf31PHwhAV/25MSBng+XrwR0kDGs92cMwqzJYWV24Qf7c5FvxJApDb2pXThrlB0H/odUffoPf2guMW85Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106978; c=relaxed/simple;
	bh=VE0ZADAnke3P7nnzuHVGyWI/LwZRUKtUnerEfhM/NSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG5f3Xyn2QeX5MbPlh71LBJ4oVUxSDR6vDIjAo189hc2bTpIlIh0L1U4RZk4lW/1vkU1acd2fGBiytzFLTJ8zMojx1SpLpH9ZQJzp7u9EyRDkD2WpROiKvlaTYRx7O8Op6dAvjzFeS+cXcS7ptaQErk4TTxNZ1hxuoQ0p9z9Wx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3QnmFrO; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf13c259f3so18886011fa.2;
        Wed, 24 Jan 2024 06:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706106975; x=1706711775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpDjSBPxR7jul3F3D7fG96de10Q/B8xuAEUwbLIyapo=;
        b=P3QnmFrO9YF7NOGX7E3NLCjwzsgy5ZF/e73alt9eCNkbmVL3MXHSafl6Tyget9wRP2
         cd5aj8P0Vmlt4OZtvoXPyncXoqVbwf61nlPSrWJNTlYcBPYXKLYjZvnKlezhFRHHH9mm
         xia/RJ5sjLj5OYhljPejhRgE2ZNYcU+45JFw4CZLhMIEdo+poDtWTsW/huWXH43WqyNJ
         6u8ztXJ5FZBXAWc7CNTI5B+vrNrM/j/r6AKQR87RLNo4HF0aEaSa0j52kRQbI73D3+GX
         aUsXieUs0TNo8cWCVIEh/67e0tjd68sTCw4twU4tPLz0ZY+3W28NQTDzW5PwQsgbMzmt
         AqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706106975; x=1706711775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpDjSBPxR7jul3F3D7fG96de10Q/B8xuAEUwbLIyapo=;
        b=RPx3vZFvun5Z4qsan+V4A0YwR21n7KARgoE7wPOLM1SP6lvlsPlT9tosrxbiOMBIpN
         pqBhzlfMWpNXx8vRmK/dPZd+Pj9kud2awIm0UwBUx5a8so3PLJE8d43UmkOu5R2g99Pg
         MnpItO/1tOJvDuD2Qda6nJM4SfIdU0iBGd7xsLlSWQ7jnYYhODe2J2LkiYbFUkjOst9h
         zwM7Z+9otQ+KdGxZCeOoeCP9slcPprfNUo2HkhDZGMMATQSeT9S3GgS+jqP7kwv16cWr
         jm1/kjd1NZTL88Unf6lLDCOOBIATJWMf497PqbHzPiY2t1SSbBJ/VDXwpnKg5HbocnDd
         +XfA==
X-Gm-Message-State: AOJu0Yw4l/7VBo1W2xlJM9vdywTtl4sUOqQJUY/4Z/ynCMWYzcQtZ9bl
	+5nV4V8ap1gfWdV5804bF+gUJ97GLZgD/v9xLvhA7k8FTKKorB/o
X-Google-Smtp-Source: AGHT+IE4diP+Bzi1Qt1K35z7Xbr+sJlFYRnMivzS2AX1CTOywsuripJaMAufPOPXgEYRgRWvFi0pXg==
X-Received: by 2002:a2e:870c:0:b0:2cd:f540:e397 with SMTP id m12-20020a2e870c000000b002cdf540e397mr482645lji.55.1706106974534;
        Wed, 24 Jan 2024 06:36:14 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id e22-20020a2e9e16000000b002cd628d6ea3sm4033353ljk.112.2024.01.24.06.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:36:13 -0800 (PST)
Date: Wed, 24 Jan 2024 17:36:10 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net] net: stmmac: xgmac: fix handling of DPP safety error
 for DMA channels
Message-ID: <vsert76o6lxxc676tjiiikir577qobfonyo6sgo5eek6alzxlo@tb6hq5s2qcsp>
References: <20240123095006.979437-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123095006.979437-1-0x1207@gmail.com>

On Tue, Jan 23, 2024 at 05:50:06PM +0800, Furong Xu wrote:
> Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> XGMAC core") checks and reports safety errors, but leaves the
> Data Path Parity Errors for each channel in DMA unhandled at all, lead to
> a storm of interrupt.
> Fix it by checking and clearing the DMA_DPP_Interrupt_Status register.
> 
> Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h      | 1 +
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 207ff1799f2c..188e11683136 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -385,6 +385,7 @@
>  #define XGMAC_DCEIE			BIT(1)
>  #define XGMAC_TCEIE			BIT(0)
>  #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
> +#define XGMAC_DMA_DPP_INT_STATUS	0x00003074
>  #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
>  #define XGMAC_SPH			BIT(24)
>  #define XGMAC_PBLx8			BIT(16)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index eb48211d9b0e..874e85b499e2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -745,6 +745,12 @@ static void dwxgmac3_handle_mac_err(struct net_device *ndev,
>  
>  	dwxgmac3_log_error(ndev, value, correctable, "MAC",
>  			   dwxgmac3_mac_errors, STAT_OFF(mac_errors), stats);
> +
> +	value = readl(ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> +	writel(value, ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> +
> +	if (value)
> +		netdev_err(ndev, "Found DMA_DPP error, status: 0x%x\n", value);

1. Why not to implement this in the same way as the rest of the safety
errors handle code? (with the flags described by the
dwxgmac3_error_desc-based table and the respective counters being
incremented should the errors were detected)

2. I don't see this IRQ being enabled in the dwxgmac3_safety_feat_config()
method. How come the respective event has turned to be triggered
anyway?

-Serge(y) 

>  }
>  
>  static const struct dwxgmac3_error_desc dwxgmac3_mtl_errors[32]= {
> -- 
> 2.34.1
> 
> 

