Return-Path: <linux-kernel+bounces-89557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8133786F202
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59821C20FBA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC913FE35;
	Sat,  2 Mar 2024 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7EzRZxa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492051DA22;
	Sat,  2 Mar 2024 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709406582; cv=none; b=mSl3NSlmKrVdJRM+BSNocq8RWi6Wb/llabHy7t7Zwoi2Cl9snnX9Myo9sDQhQMwqdFB1s/uIBTF1eIn9XLCeMjl5HpsGVtR5fz5YcKDsj0558gVtYfsKDhO4nakchYdJIF5o1tB/Dsn2tl31fJLcNFSOBrHMK64v6lAKFG9AwtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709406582; c=relaxed/simple;
	bh=YUV1jSg7pPiXDQxF+2gt5c1XstGEUu5XvgwnYapGK+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGTetCNt6f69AbkJXSzWMj3ohv0Csokp4QQOBtuvYXR2uceSdWel305ObYN0Nb7hkerYJmGBUd+OZl2Rx98KIECZf7KiM5NOFlIupbLCoLz/JOQTxXuMEnQmcOgPz3/I1gTEuoP7YvtQbf9XNoYnvVKX/zT8JVUImM8D8tyqmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7EzRZxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79871C433F1;
	Sat,  2 Mar 2024 19:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709406582;
	bh=YUV1jSg7pPiXDQxF+2gt5c1XstGEUu5XvgwnYapGK+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7EzRZxahRFtRwvzjhus5PHn0UEG/P4MGyzQjC02QgDEVx0C7jOcOKRzJh5F0KEWg
	 5iBpCBYL9MX9fZwd/tTFfUtKOCtFERIaEZDjODeSNSLxWbVIoyfZjRzhxlL/t/ByRF
	 YNkETumECaVuO/hvz4U8g0E2m93ztVL9O84F4z9DhM8ZlpB85PXsFf26aHQo64pU52
	 4MRV9sLoOJ2zmMgcbiCi0BlrL6mRXYbxJSE0mm5UAdlqsMQ2f/XWVUDWPsQQ4ogpQH
	 NrW9FC+vtBx3PZuqYEQeLvLMki7bTF1PRn/NAq4Z4WTyYFhfUAgMmHheDW/+rZNxdN
	 8bg5QZ/3vo5qQ==
Date: Sat, 2 Mar 2024 13:09:39 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: Re: [PATCH v12 2/9] firmware: qcom: scm: provide a read-modify-write
 function
Message-ID: <xht25xxxzxmb24yobz4drmo5u4btlqo4akhscow7g5to7zyh3g@75bl5ddhib43>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-3-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227155308.18395-3-quic_mojha@quicinc.com>

On Tue, Feb 27, 2024 at 09:23:01PM +0530, Mukesh Ojha wrote:
> It is possible that different bits of a secure register is used
> for different purpose and currently, there is no such available
> function from SCM driver to do that; one similar usage was pointed
> by Srinivas K. inside pinctrl-msm where interrupt configuration
> register lying in secure region and written via read-modify-write
> operation.
> 
> Export qcom_scm_io_rmw() to do read-modify-write operation on secure
> register and reuse it wherever applicable, also document scm_lock
> to convey its usage.
> 
> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
> ---
>  drivers/firmware/qcom/qcom_scm.c       | 33 ++++++++++++++++++++++++++
>  include/linux/firmware/qcom/qcom_scm.h |  1 +
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 2d0ba529cf56..8f766fce5f7c 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -193,6 +193,11 @@ static void qcom_scm_bw_disable(void)
>  }
>  
>  enum qcom_scm_convention qcom_scm_convention = SMC_CONVENTION_UNKNOWN;
> +/*
> + * scm_lock to serialize call to query SMC convention and
> + * to atomically operate(read-modify-write) on different
> + * bits of secure register.
> + */
>  static DEFINE_SPINLOCK(scm_lock);
>  
>  static enum qcom_scm_convention __get_convention(void)
> @@ -481,6 +486,34 @@ static int qcom_scm_disable_sdi(void)
>  	return ret ? : res.result[0];
>  }
>  
> +int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val)
> +{
> +	unsigned long flags;
> +	unsigned int old;
> +	unsigned int new;
> +	int ret;
> +
> +	if (!__scm)
> +		return -EPROBE_DEFER;
> +
> +	/*
> +	 * Lock to atomically do rmw operation on different bits
> +	 * of secure register
> +	 */

A spinlock does not make something globally atomic, all you have made
sure is that:
1) qcom_scm_io_rmw() can not happen concurrently with __get_convention()

The reuse of the lock makes me wonder what the use case you're having a
need to protect #1... When is rmw happening concurrently with convention
detection?

2) Two qcom_scm_io_rmw() can not happen concurrently

What happens if a separate process invokes qcom_scm_io_write() of the
same address concurrently with qcom_scm_io_rmw()?


Quite likely neither of these will happen in practice, and I'm guessing
that there will not be any caching issues etc among different calls to
qcom_scm_io_*(), and hence this spinlock serves just to complicate the
implementation.

Please add a kernel-doc comment to this function (and perhaps
qcom_scm_io_write()) and describe that we don't guarantee this operation
to happen atomically - or if you have a valid reason, document that and
it's exact limitations.


PS. I would have been perfectly happy with us not adding a rmw function.
You're adding 34 lines of code to save 2*3 lines of duplicated, easy to
understand, code.

Regards,
Bjorn

> +	spin_lock_irqsave(&scm_lock, flags);
> +	ret = qcom_scm_io_readl(addr, &old);
> +	if (ret)
> +		goto unlock;
> +
> +	new = (old & ~mask) | (val & mask);
> +
> +	ret = qcom_scm_io_writel(addr, new);
> +unlock:
> +	spin_unlock_irqrestore(&scm_lock, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_scm_io_rmw);
> +
>  static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>  {
>  	struct qcom_scm_desc desc = {
> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> index ccaf28846054..3a8bb2e603b3 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -82,6 +82,7 @@ bool qcom_scm_pas_supported(u32 peripheral);
>  
>  int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
>  int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
> +int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val);
>  
>  bool qcom_scm_restore_sec_cfg_available(void);
>  int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
> -- 
> 2.43.0.254.ga26002b62827
> 

