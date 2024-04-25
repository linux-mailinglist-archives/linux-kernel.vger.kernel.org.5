Return-Path: <linux-kernel+bounces-158335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595F38B1E81
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6891C2222E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F1E8529B;
	Thu, 25 Apr 2024 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWlnuRmF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702C84D29;
	Thu, 25 Apr 2024 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038816; cv=none; b=rOC+W2ed307Sv1m64A6Uvuz8ODgZToeqJOkuBQXILzFZ3Yb4bB4Y+T+Of195r+8WGm7H70WCoge5/OB3iLNLFDYMWx8zM7aGc9/ppKa3jyyUPdPkd3ynZtqDIsGaTpKxgjtAvHOwbffWAk0xRGqM3Pd8eRXHS4a1/khhqXoXUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038816; c=relaxed/simple;
	bh=hiOGPHU/d3iFGM3hRu8dm2Ff9CciCTpBibxgJppXfnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEw5JSmAbr9v7hD7SB3Va4dmgeg124UQGFfZGREWltop+f/n9dSsWST3hrT4l/kU/l7B+RsAM5WGSq0sDDo4uRCaxuBNRfWzg3iG1Oo7rXzrZuHIFRMQP2IOxRc/9JetAMxmQHWNatqj1B2auBmoWXxXzTSEgMkckcSwu/rni/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWlnuRmF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714038815; x=1745574815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hiOGPHU/d3iFGM3hRu8dm2Ff9CciCTpBibxgJppXfnU=;
  b=kWlnuRmF/5KVHWQYshIj7jg9hS/XQ5z8nFsdsN4UH1nqY3Oa0LRzrAFH
   tCy4kaz6QnlX/crlm4DTv4AaxVnO3qy0Gj1bKq38e/THP1t3BfrKWQWwq
   6zcuWPRJkdJI3oZGKGMJJBSo5hM/S+u6Dz8sfnCfRgCMRhR3I/Javu1Cv
   ISE45JJec2QhNamX0MpfQA+PYGqGi+6xTq1ChRAx0rTl5fSBwSuOQcCAK
   9+TiDLVuKhRnhypODjP3YCbuIu3lEC0F71p7gC8Ffw1M8c4+QJqOhd3oc
   +7iQHWoi7Rv7DrKnVA06vML6reJ7O07clIFsTinoBVF6RqAY3zqv1OMzD
   g==;
X-CSE-ConnectionGUID: Z1o/iYoMQq+SwjtQAGfwNQ==
X-CSE-MsgGUID: Gq7+Z8vxSvqKSkPOPQL7NQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9835235"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9835235"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:53:34 -0700
X-CSE-ConnectionGUID: I52OuNV+SlenBcI/qLv9/w==
X-CSE-MsgGUID: Ca12pHXJTp6i+RIBDr3UNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="55966305"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa002.jf.intel.com with SMTP; 25 Apr 2024 02:53:31 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 25 Apr 2024 12:53:29 +0300
Date: Thu, 25 Apr 2024 12:53:29 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v4] usb: typec: qcom-pmic-typec: split HPD bridge alloc
 and registration
Message-ID: <ZiooGUdEo7CTjczK@kuha.fi.intel.com>
References: <20240424-qc-pmic-typec-hpd-split-v4-1-f7e10d147443@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-qc-pmic-typec-hpd-split-v4-1-f7e10d147443@linaro.org>

On Wed, Apr 24, 2024 at 05:16:57AM +0300, Dmitry Baryshkov wrote:
> If a probe function returns -EPROBE_DEFER after creating another device
> there is a change of ending up in a probe deferral loop, (see commit
> fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER"). In case
> of the qcom-pmic-typec driver the tcpm_register_port() function looks up
> external resources (USB role switch and inherently via called
> typec_register_port() USB-C muxes, switches and retimers).
> 
> In order to prevent such probe-defer loops caused by qcom-pmic-typec
> driver, use the API added by Johan Hovold and move HPD bridge
> registration to the end of the probe function.
> 
> The devm_drm_dp_hpd_bridge_add() is called at the end of the probe
> function after all TCPM start functions. This is done as a way to
> overcome a different problem, the DRM subsystem can not properly cope
> with the DRM bridges being destroyed once the bridge is attached. Having
> this function call at the end of the probe function prevents possible
> DRM bridge device creation followed by destruction in case one of the
> TCPM start functions returns an error.
> 
> Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
> Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Dependency: https://lore.kernel.org/lkml/20240418145730.4605-2-johan+linaro@kernel.org/
> ---
> Changes in v4:
> - Rebased on top of Johan's patches
> - Link to v3: https://lore.kernel.org/r/20240416-qc-pmic-typec-hpd-split-v3-1-fd071e3191a1@linaro.org
> 
> Changes in v3:
> - Updated commit message to explain my decisions (Johan).
> - Link to v2: https://lore.kernel.org/r/20240408-qc-pmic-typec-hpd-split-v2-1-1704f5321b73@linaro.org
> 
> Changes in v2:
> - Fix commit message (Bryan)
> - Link to v1: https://lore.kernel.org/r/20240405-qc-pmic-typec-hpd-split-v1-1-363daafb3c36@linaro.org
> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> index d3958c061a97..501eddb294e4 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> @@ -41,7 +41,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>  	struct device_node *np = dev->of_node;
>  	const struct pmic_typec_resources *res;
>  	struct regmap *regmap;
> -	struct device *bridge_dev;
> +	struct auxiliary_device *bridge_dev;
>  	u32 base;
>  	int ret;
>  
> @@ -92,7 +92,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>  	if (!tcpm->tcpc.fwnode)
>  		return -EINVAL;
>  
> -	bridge_dev = drm_dp_hpd_bridge_register(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
> +	bridge_dev = devm_drm_dp_hpd_bridge_alloc(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
>  	if (IS_ERR(bridge_dev))
>  		return PTR_ERR(bridge_dev);
>  
> @@ -110,8 +110,14 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto port_stop;
>  
> +	ret = devm_drm_dp_hpd_bridge_add(tcpm->dev, bridge_dev);
> +	if (ret)
> +		goto pdphy_stop;
> +
>  	return 0;
>  
> +pdphy_stop:
> +	tcpm->pdphy_stop(tcpm);
>  port_stop:
>  	tcpm->port_stop(tcpm);
>  port_unregister:
> 
> ---
> base-commit: 15d419fa23ecc51e388a369bbeaf3b47b0b5c76a
> change-id: 20240405-qc-pmic-typec-hpd-split-22804201902b
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
heikki

