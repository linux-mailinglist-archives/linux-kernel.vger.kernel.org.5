Return-Path: <linux-kernel+bounces-110533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FAE88603B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5CD1F23717
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39601332AA;
	Thu, 21 Mar 2024 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxSiIFgl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130378613B;
	Thu, 21 Mar 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044206; cv=none; b=VOzrD3NdudN3N8+jcyx92uB6THQUqj6fY1KSeKb3zoUKTmMhIJuK7YpMF1GbtaLIOSbnUNVj789NJ7q1SUwgEjXW8FlSMaCoye3y3JsQOYsLh6FK1GfIsXL/dyYJSU29CJQmH2IgU852DxNNdOhFhta7ROOk8REhjWP42k14ITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044206; c=relaxed/simple;
	bh=sCdLXz2FGoLIYbxZ6Ggaxi6+JlxzyXAOAvvDKudzdu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmXJUSJQ03uL+rCij7PeVQgl6rJSpoAxFv5LJzsPvEQ9/zSS49JKCvZT8mqFrc5QhPGD0JaxPMGt1wAXdduA+XtCmmBcNqSqY2fwRWRem+glTdEEmZsfocoDcdd+4dhIB1rBKqN1ejhuKBZo6oFBFEM1QV5yoZ0tdRvrfLLxCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxSiIFgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A910CC433C7;
	Thu, 21 Mar 2024 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711044205;
	bh=sCdLXz2FGoLIYbxZ6Ggaxi6+JlxzyXAOAvvDKudzdu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxSiIFgly+OkYViveqUiMzJ2xWwvoS+z9vzxkK4K4SZ9gLpnlrElKDt1xXlSXoTil
	 9o644uhspGUGlBY1JjiHTr4lkFAdyHvUa3zfQn917aA8r+zC48Lmg3/VLdL6ni9l7g
	 dhRGYoHaV3yLYN+DYuFOBd6l0+DEa3vHAjTpUinaPJNAnjgpkfBIsNxtdi0vr+3ONQ
	 z3CWv5ORPZ7Tey2roNPv/yKBVPMNvCkWN4VLoH6CT3TdFGMbT6r2HUjBagm1iv1VWd
	 aHeWePNyeWxQArVxZfpR1pTn9bSNMr5MMfrE15jBwTRYA9WZaxEpiv4pluzNHTkFHH
	 rBizgE2hR1Z1w==
Date: Thu, 21 Mar 2024 11:08:19 -0700
From: Bjorn Andersson <andersson@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Davis <afd@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Joakim Zhang <joakim.zhang@cixtech.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [GIT PULL] remoteproc updates for v6.9
Message-ID: <yniwjzjynmyndzqglfmwpy2th3vtadmms6ifxqs2ojo7wr66ne@ydnr3rltaddn>
References: <20240321125518.1675903-1-andersson@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321125518.1675903-1-andersson@kernel.org>

On Thu, Mar 21, 2024 at 05:55:13AM -0700, Bjorn Andersson wrote:
> I'm sorry for the late pull request, I apparently had managed to get git
> send-email to only deliver my mail to /dev/null on the machine where I prepared
> this.
> 

I was further notified that this conflicts with your tree, Linus. Below
is the resolution for this conflict.

Please let me know if you'd like me to create some form of merge commit
for this.

Regards,
Bjorn

diff --cc drivers/remoteproc/imx_dsp_rproc.c
index d73727a5828a,56a799cb8b36..087506e21508
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@@ -1090,9 -1154,7 +1090,7 @@@ static int imx_dsp_rproc_probe(struct p
  	return 0;
  
  err_detach_domains:
 -	imx_dsp_detach_pm_domains(priv);
 +	dev_pm_domain_detach_list(priv->pd_list);
- err_put_rproc:
- 	rproc_free(rproc);
  
  	return ret;
  }
@@@ -1104,8 -1166,7 +1102,7 @@@ static void imx_dsp_rproc_remove(struc
  
  	pm_runtime_disable(&pdev->dev);
  	rproc_del(rproc);
 -	imx_dsp_detach_pm_domains(priv);
 +	dev_pm_domain_detach_list(priv->pd_list);
- 	rproc_free(rproc);
  }
  
  /* pm runtime functions */
diff --cc drivers/remoteproc/qcom_q6v5_adsp.c
index 93f9a1537ec6,34ac996a93b2..1d24c9b656a8
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@@ -704,13 -713,15 +704,13 @@@ static int adsp_probe(struct platform_d
  
  	ret = adsp_init_clock(adsp, desc->clk_ids);
  	if (ret)
- 		goto free_rproc;
+ 		return ret;
  
 -	ret = qcom_rproc_pds_attach(adsp->dev, adsp,
 -				    desc->proxy_pd_names);
 +	ret = qcom_rproc_pds_attach(adsp, desc->pd_names, desc->num_pds);
  	if (ret < 0) {
  		dev_err(&pdev->dev, "Failed to attach proxy power domains\n");
- 		goto free_rproc;
+ 		return ret;
  	}
 -	adsp->proxy_pd_count = ret;
  
  	ret = adsp_init_reset(adsp);
  	if (ret)
@@@ -742,11 -753,8 +742,8 @@@
  	return 0;
  
  disable_pm:
 -	qcom_rproc_pds_detach(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
 +	qcom_rproc_pds_detach(adsp);
  
- free_rproc:
- 	rproc_free(rproc);
- 
  	return ret;
  }
  
@@@ -760,8 -768,7 +757,7 @@@ static void adsp_remove(struct platform
  	qcom_remove_glink_subdev(adsp->rproc, &adsp->glink_subdev);
  	qcom_remove_sysmon_subdev(adsp->sysmon);
  	qcom_remove_ssr_subdev(adsp->rproc, &adsp->ssr_subdev);
 -	qcom_rproc_pds_detach(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
 +	qcom_rproc_pds_detach(adsp);
- 	rproc_free(adsp->rproc);
  }
  
  static const struct adsp_pil_data adsp_resource_init = {

