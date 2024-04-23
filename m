Return-Path: <linux-kernel+bounces-155519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD8E8AF37A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C441F26207
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FAB13D51F;
	Tue, 23 Apr 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MScQIxiM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28113CA9B;
	Tue, 23 Apr 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888407; cv=none; b=tqhrUtrqbHKrYnquVB/k9dVHRsufZSfMciUpF4r4BREtUAvw2eVNyUTUERpysTUfu+aRlgzYvXEGRr3OqU4kwLh+VyV+tXm6pbh+JK1exJrdSHtSU/ZyiolOyKB9yuarKJpDjRM1VYJ2iwSSDL5LVxioaK8oJsGQzq3kgmjtLh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888407; c=relaxed/simple;
	bh=y/eJkeltGXzOH5ZU8dL3BCx95AxNIjYl29rEKnEwgE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGApukn/igP4lmBfcqxARL6OfgmyM8a0ualEenlTHZ1UQLnZM3x1HGp1mJMVSdVpmQd2RnWtozlMSs1Z+5256k47O3VyInvlBiw6ePhjMLU26ZA4tI5FjrgCcp5VWk7TmxwYa+AfK0EWt27x+5fDZzxCZuAW13U1pjFylwsldXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MScQIxiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C6DC32781;
	Tue, 23 Apr 2024 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713888406;
	bh=y/eJkeltGXzOH5ZU8dL3BCx95AxNIjYl29rEKnEwgE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MScQIxiM0tzGUA0XBnhwPA5S+t0j3M9v9mJ2AUrhs21I/T0ulS1cgOYVd2LRJUfpv
	 yy/Z4ekB9MV8FYnWRm4ZQvuLBIK3/soXgpcsKqyZgm8zcbat26ZDfoc0bmyV4THk4c
	 25N/Y9Kdr8aOUWx1iDXOmG13KeVF6n//547GEObEXRcC3zppKYRfTajqM8UquLUMeW
	 jr1N6RSFy5MstMnuFOKdMPf7jcfiLdXGTcODQohK1mdjNbCgPlM8IBnhEyTi2RUdnV
	 NNuujHz8aKDaA8SQBJE6eYGpWeQQtPZxQdoeVqdcwKmFxKumaZJFCIf2Z6m50mav61
	 iGhh3KX+lu0tQ==
Date: Tue, 23 Apr 2024 09:06:44 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] drivers: remoteproc: xlnx: Add Versal and Versal-NET
 support
Message-ID: <20240423160644.GA554932@dev-arch.thelio-3990X>
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

Hi Tanmay,

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

This change breaks the build with clang:

  drivers/remoteproc/xlnx_r5_remoteproc.c:914:11: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
    914 |         else if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))
        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/remoteproc/xlnx_r5_remoteproc.c:917:6: note: uninitialized use occurs here
    917 |         if (ret) {
        |             ^~~
  drivers/remoteproc/xlnx_r5_remoteproc.c:914:7: note: remove the 'if' if its condition is always true
    914 |         else if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))
        |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    915 |                 ret = zynqmp_r5_get_tcm_node(cluster);
  drivers/remoteproc/xlnx_r5_remoteproc.c:907:9: note: initialize the variable 'ret' to silence this warning
    907 |         int ret, i;
        |                ^
        |                 = 0
  1 error generated.

Should ret be initialized to zero or should there be an else statement?

Cheers,
Nathan

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

