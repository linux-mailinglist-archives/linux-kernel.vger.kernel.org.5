Return-Path: <linux-kernel+bounces-153641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172F98AD0FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31B128CF90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E392153514;
	Mon, 22 Apr 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BqEjHHG5"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686815350D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800076; cv=none; b=nWc0XwhUxcnPEt0PPEC9/eR/SJfxfaK29/KfYbSSIPmYmCGGbLGRwM/coFrPu00H65M5z9x+ZMmOeDZQR7qkDW14WcgJlrVUi6Gyea3rZ0Vxz1xR8I3OQ/qtd4D146fLkR75Rk0oTiGl+UJCb169gcwRMJxPnSYhctZzG5t7+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800076; c=relaxed/simple;
	bh=7rDy8l0sDwyBXfHsO2TUrRhK/INejU/rzcZpBVr/SuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG65HYmNDv1aD5aodSznO/pnD6W6tQGGdnVn2v/3PPtagP0NsNjgfTbGKgYLHIJqQmMvE0j2Loty9eV54v9aoBJ03u3ykaCpUCZPFWANVbqMpEPBc2AIjGayq9SqiAuiy3JKkmWivV3E4hh8ZSH1XND3Zrh2+0PQMvPFUVc45sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BqEjHHG5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso32492225ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713800075; x=1714404875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=337wBwclmpc6tEt1+i4HX8mw2rCsniBI2t8I+UU3Arc=;
        b=BqEjHHG5uqcOa68JJZfN4kB1DlLzkTymvk7fOpaGwQ/O2SRjvfBVyEMvJ64uj7/JyN
         7PwhFG98P0KAJYZiOrSGb6/X8GtiO1U9/e3t60jdGpBEyGamTiei1HgzoXOQOX9zfiRj
         0hpmNmWoloZsmkGl6I60DG2gKbaMleObLm/w38F7MT0BCfnwNvBDUDiFvNQ6iuGrx5jt
         YZ97NGV++jjMY6wSPBEqkOx5bb8Hd/GxYi5PEKewylMB6itsZhrt+iYD/00pkrok3UaO
         wHuPo3migHuCeNEes25vBV5BFLhDNFMInqDifkJ45XbFvgEV7sEZ9JTNuv6niIBQ1V8+
         Lz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800075; x=1714404875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=337wBwclmpc6tEt1+i4HX8mw2rCsniBI2t8I+UU3Arc=;
        b=fy3IENq5Ex/RA/UmO7zvw7ddpCIEmgPkmyWi0D4vkViyp/IwOjnFirqfMppyAbn2w0
         bNtlymo1Q+fkpJ+7Xn9bFn1GQQyrM+XedAKXMXD2bZ05L7ESDgBXD4YYtW0Z1oCLBStW
         OWrr22RgtqVUYdQox0yn4X0xbKb5L37+AQI9VQL0th8jaWEqHIIR03yKkXu7BCXNQKFP
         BgSwC7ZFG6SMGdF0aT52IM8Uffhy7MAFyXbADBHZ6GTOemsSsXk4V0vCywjzBwnNyBWT
         u6gCvLcdhDw0Vh2+wXTI+HD78hXmrKZWhqUs0TSTTmpmV+MNDGYZeUacBL5A4kUPsnop
         2fBw==
X-Forwarded-Encrypted: i=1; AJvYcCX5R9LQQn0xbyZz8RtTkb2l9LKoYfw/7iBMyLd3+vluhwxCXRk9KkhnN7bMGQeJCNVkGFY5JBNJOJWrA+vbGLgGC8fW3nfcJNJr5sX/
X-Gm-Message-State: AOJu0YwC8otQyFqbpoBOnSKOjnHsgwI5d+d5elWRzoZiJSNs4NYDVojL
	TbTY4gwZ5lyRVvPMzVJHfVOTI3B8sibxIiaaxGjvnia3b9ynvIZaR/0ADGpIsM34MidpdVgvquq
	j
X-Google-Smtp-Source: AGHT+IHe1PTjpEIZG7kkFQ9aDxKVX/PgGZxcewaa3UBNjLsLZf2wJj5hQf8t0zLc6uCo7e7GYLuCKA==
X-Received: by 2002:a17:902:b18e:b0:1e9:668d:a446 with SMTP id s14-20020a170902b18e00b001e9668da446mr5566962plr.20.1713800074608;
        Mon, 22 Apr 2024 08:34:34 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:b2a0:f51d:b8f7:33f5])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b001e2bbe87912sm8273478plg.11.2024.04.22.08.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:34:34 -0700 (PDT)
Date: Mon, 22 Apr 2024 09:34:31 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: remoteproc: xlnx: Add Versal and Versal-NET
 support
Message-ID: <ZiaDh7kRnK+qkaZn@p14s>
References: <20240418220125.744322-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418220125.744322-1-tanmay.shah@amd.com>

On Thu, Apr 18, 2024 at 03:01:25PM -0700, Tanmay Shah wrote:
> AMD-Xilinx Versal platform is successor of ZynqMP platform.
> Real-time Processing Unit R5 cluster IP on Versal is same as
> of ZynqMP Platform. Power-domains ids for Versal platform is
> different than ZynqMP.
> 
> AMD-Xilinx Versal-NET platform is successor of Versal platform.
> Versal-NET Real-Time Processing Unit has two clusters and each
> cluster contains dual core ARM Cortex-R52 processors. Each R52
> core is assigned 128KB of TCM memory.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 53 ++++++++-----------------
>  1 file changed, 17 insertions(+), 36 deletions(-)
>

Applied.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 7b1c12108bff..a6d8ac7394e7 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -300,36 +300,6 @@ static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
>  		dev_warn(dev, "failed to send message\n");
>  }
>  
> -/*
> - * zynqmp_r5_set_mode()
> - *
> - * set RPU cluster and TCM operation mode
> - *
> - * @r5_core: pointer to zynqmp_r5_core type object
> - * @fw_reg_val: value expected by firmware to configure RPU cluster mode
> - * @tcm_mode: value expected by fw to configure TCM mode (lockstep or split)
> - *
> - * Return: 0 for success and < 0 for failure
> - */
> -static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
> -			      enum rpu_oper_mode fw_reg_val,
> -			      enum rpu_tcm_comb tcm_mode)
> -{
> -	int ret;
> -
> -	ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
> -	if (ret < 0) {
> -		dev_err(r5_core->dev, "failed to set RPU mode\n");
> -		return ret;
> -	}
> -
> -	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
> -	if (ret < 0)
> -		dev_err(r5_core->dev, "failed to configure TCM\n");
> -
> -	return ret;
> -}
> -
>  /*
>   * zynqmp_r5_rproc_start()
>   * @rproc: single R5 core's corresponding rproc instance
> @@ -941,7 +911,7 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  	/* Maintain backward compatibility for zynqmp by using hardcode TCM address. */
>  	if (of_find_property(r5_core->np, "reg", NULL))
>  		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> -	else
> +	else if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))
>  		ret = zynqmp_r5_get_tcm_node(cluster);
>  
>  	if (ret) {
> @@ -960,12 +930,21 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  			return ret;
>  		}
>  
> -		ret = zynqmp_r5_set_mode(r5_core, fw_reg_val, tcm_mode);
> -		if (ret) {
> -			dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
> -				cluster->mode, ret);
> +		ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
> +		if (ret < 0) {
> +			dev_err(r5_core->dev, "failed to set RPU mode\n");
>  			return ret;
>  		}
> +
> +		if (of_find_property(dev_of_node(dev), "xlnx,tcm-mode", NULL) ||
> +		    device_is_compatible(dev, "xlnx,zynqmp-r5fss")) {
> +			ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id,
> +						       tcm_mode);
> +			if (ret < 0) {
> +				dev_err(r5_core->dev, "failed to configure TCM\n");
> +				return ret;
> +			}
> +		}
>  	}
>  
>  	return 0;
> @@ -1022,7 +1001,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>  		ret = of_property_read_u32(dev_node, "xlnx,tcm-mode", (u32 *)&tcm_mode);
>  		if (ret)
>  			return ret;
> -	} else {
> +	} else if (device_is_compatible(dev, "xlnx,zynqmp-r5fss")) {
>  		if (cluster_mode == LOCKSTEP_MODE)
>  			tcm_mode = PM_RPU_TCM_COMB;
>  		else
> @@ -1212,6 +1191,8 @@ static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
>  
>  /* Match table for OF platform binding */
>  static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
> +	{ .compatible = "xlnx,versal-net-r52fss", },
> +	{ .compatible = "xlnx,versal-r5fss", },
>  	{ .compatible = "xlnx,zynqmp-r5fss", },
>  	{ /* end of list */ },
>  };
> 
> base-commit: 912ebe48bec5927e2049e91b0e8a9cc682a709d2
> -- 
> 2.25.1
> 

