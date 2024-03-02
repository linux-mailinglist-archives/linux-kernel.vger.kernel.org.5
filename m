Return-Path: <linux-kernel+bounces-89559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4861686F20A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBD2B225B9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1757B3FE35;
	Sat,  2 Mar 2024 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI1hou6r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5584E2BB1E;
	Sat,  2 Mar 2024 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709406814; cv=none; b=sjuwKyQBZ3bUfijQg2bS7hQhKZ3ah27ZgqlhbjKV283Bko0ip/fNGXhtN56EDQzyoDt16N2ONSrmrlFZqjyFQGdnyqmP5G0BrqpK02JQmiSeWF+gsMqE3VEWAihlzBDOgJuMGhvumlVgG7tWxrijvrkxPMPhwVoNbT/6hlzpxlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709406814; c=relaxed/simple;
	bh=/ZJsIWMUy/R/fRXQvzHdLDgIj2F1D/SVsTiYDZVkl14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ty7lxdN25jcZS6wOW9XknQB/MiyLlT1Hd2/pIIm12I/z35O/r2Actwk21Zds7VKwaymahkHeEoAhMbVlZHyFT4Z8oP9UqVhsIQWWm45dYJI0nKYqoMTXXgOvv+eQwW/wH+L91Al3ulaEhZmK5WXjwIqtB5u3ozEB3o1aGaXmtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI1hou6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48861C433C7;
	Sat,  2 Mar 2024 19:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709406814;
	bh=/ZJsIWMUy/R/fRXQvzHdLDgIj2F1D/SVsTiYDZVkl14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sI1hou6r9k2/74DY4NtgNvhAyFsAjKla+NaPWIzYivKipJ7TmdAVvuQpCo1XdaSHP
	 wNlwD39aJG6z/lufj5npuRBBm1fs/NPeXNgDNcnsIaUsDRV5f9BiLlBco+qcUiVADl
	 a0ksR7jx+JyvjpinfvXEHrfWP1IpX9TZLsqDLLi3Odef+dQ0EbbykOAnzrYa6seNvc
	 K9douC+9qi2w2jEQOjaKdiWPucKlzaSP159nIyO85x3KQVTgV5B7xohg0TS7a3Ew12
	 TJ8n/pIOm6xm1aKPOVfuS1fptFAMuUmUXdsmS2P2rgJu0g/UsEEVyDGO9FOw0WBEcU
	 igicFkCf8bGSA==
Date: Sat, 2 Mar 2024 13:13:31 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	Poovendhan Selvaraj <quic_poovendh@quicinc.com>, Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v12 3/9] firmware: qcom: scm: Modify only the download
 bits in TCSR register
Message-ID: <ncyanjtxtqyx236d5tfm46nepvy6ncxikonc6g6hlddhx2joee@jqjhfxtu3sr6>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-4-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227155308.18395-4-quic_mojha@quicinc.com>

On Tue, Feb 27, 2024 at 09:23:02PM +0530, Mukesh Ojha wrote:
> Crashdump collection is done based on DLOAD bits of TCSR register.
> To retain other bits, scm driver need to read the register and
> modify only the DLOAD bits, as other bits in TCSR may have their
> own significance.
> 
> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 8f766fce5f7c..bd6bfdf2d828 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -4,6 +4,8 @@
>   */
>  
>  #include <linux/arm-smccc.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/cpumask.h>
> @@ -114,6 +116,12 @@ static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
>  #define QCOM_SMC_WAITQ_FLAG_WAKE_ONE	BIT(0)
>  #define QCOM_SMC_WAITQ_FLAG_WAKE_ALL	BIT(1)
>  
> +#define QCOM_DLOAD_MASK		GENMASK(5, 4)
> +enum qcom_dload_mode {
> +	QCOM_DLOAD_NODUMP	= 0,
> +	QCOM_DLOAD_FULLDUMP	= 1,

These values are not enumerations, they represent fixed/defined values
in the interface. As such it's appropriate to use #define.

Regards,
Bjorn

> +};
> +
>  static const char * const qcom_scm_convention_names[] = {
>  	[SMC_CONVENTION_UNKNOWN] = "unknown",
>  	[SMC_CONVENTION_ARM_32] = "smc arm 32",
> @@ -531,6 +539,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>  
>  static void qcom_scm_set_download_mode(bool enable)
>  {
> +	u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
>  	bool avail;
>  	int ret = 0;
>  
> @@ -540,8 +549,9 @@ static void qcom_scm_set_download_mode(bool enable)
>  	if (avail) {
>  		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>  	} else if (__scm->dload_mode_addr) {
> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +		ret = qcom_scm_io_rmw(__scm->dload_mode_addr,
> +				      QCOM_DLOAD_MASK,
> +				      FIELD_PREP(QCOM_DLOAD_MASK, val));
>  	} else {
>  		dev_err(__scm->dev,
>  			"No available mechanism for setting download mode\n");
> -- 
> 2.43.0.254.ga26002b62827
> 

