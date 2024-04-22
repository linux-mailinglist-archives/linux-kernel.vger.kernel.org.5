Return-Path: <linux-kernel+bounces-153272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 201CE8ACBC4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94E01F24527
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A281465AA;
	Mon, 22 Apr 2024 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sqkpgcbg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7BF145FEE;
	Mon, 22 Apr 2024 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784440; cv=none; b=pI2GXDgNjTXQSGJphikB/yJvkMIslMSs/MOzl7bfJYlr6jgEDrRfVktLoLBPXImRdCtpoyltF/B0DUcwODDvmDUsuryGHan0A6csFnUJl/TklLcg/UC6rd1VxkuSFvcgH3BpkC0miiUzIPDg3HXMOoP/DowHpte0KQvML5PtkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784440; c=relaxed/simple;
	bh=Zdgd6Fj5wUDm/hSh8fpDnEnjpUDlT+CuNtJ1yiPZDh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5LWHt4EkpkS0LyoO+bpVxNIFkV2tMksaN3iVrhwFL5rWkLw6WspRiPaEZgYqXGEoTtZXgvC/5uLZSHCIqlKLl7Mpz1KYl0ebDEwuOlHaxTRZjqpbvPRw6iXyd8eODjUPUg6wNgQIK5IqFPGica7ogiiY1MVcHtlS8FyIsxC/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sqkpgcbg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713784439; x=1745320439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zdgd6Fj5wUDm/hSh8fpDnEnjpUDlT+CuNtJ1yiPZDh8=;
  b=SqkpgcbgM3rpvAywqse7i02x6QveAKJ0E1JlzLFZxTfSXIVGCfS89sZp
   M6geA4fjdcTAdhdsfaDJRKFNckLjeLIr1/azKKyim5L+NlhedFYcdXghy
   JWLKcbIt3EtVaX7P1Q/i1qiy1XKsGem7smwB2bWHlTFBIbVYAc7hmXgzo
   gtOHtGhRhDt6c5ZA2Ccw9LG8BQ4HfoeUKfySemD8L6mrF1YbCSHhHbMN8
   O7FsIWVg5ZTpPr3qLl0pdAfDV6YH9op6Kt0FJ/+ZJ8m/g/yYqf1Nk0Q55
   /AVIsz3AF19+uZ9oKvV8yjp/VnZ9xMbYoMAqrF8ggUBMLw0wFsSuVdFvp
   w==;
X-CSE-ConnectionGUID: F4kCHlZaTC+15N7YdWEXNA==
X-CSE-MsgGUID: s+n5UrveSwG2/vIaR+0zlw==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="19868743"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="19868743"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:13:58 -0700
X-CSE-ConnectionGUID: 59KrG3F5Svasv566kQDXJg==
X-CSE-MsgGUID: jiOK+9VtQV+MSJDUnNQ9hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28649184"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa004.fm.intel.com with SMTP; 22 Apr 2024 04:13:55 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Apr 2024 14:13:54 +0300
Date: Mon, 22 Apr 2024 14:13:54 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: qcom-pmic: fix use-after-free on late
 probe errors
Message-ID: <ZiZGciWjmA5SfjUD@kuha.fi.intel.com>
References: <20240418145730.4605-1-johan+linaro@kernel.org>
 <20240418145730.4605-2-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418145730.4605-2-johan+linaro@kernel.org>

On Thu, Apr 18, 2024 at 04:57:29PM +0200, Johan Hovold wrote:
> Make sure to stop and deregister the port in case of late probe errors
> to avoid use-after-free issues when the underlying memory is released by
> devres.
> 
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Cc: stable@vger.kernel.org	# 6.5
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> index e48412cdcb0f..d3958c061a97 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> @@ -104,14 +104,18 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>  
>  	ret = tcpm->port_start(tcpm, tcpm->tcpm_port);
>  	if (ret)
> -		goto fwnode_remove;
> +		goto port_unregister;
>  
>  	ret = tcpm->pdphy_start(tcpm, tcpm->tcpm_port);
>  	if (ret)
> -		goto fwnode_remove;
> +		goto port_stop;
>  
>  	return 0;
>  
> +port_stop:
> +	tcpm->port_stop(tcpm);
> +port_unregister:
> +	tcpm_unregister_port(tcpm->tcpm_port);
>  fwnode_remove:
>  	fwnode_remove_software_node(tcpm->tcpc.fwnode);
>  
> -- 
> 2.43.2

-- 
heikki

