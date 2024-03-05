Return-Path: <linux-kernel+bounces-91766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D84871644
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A891F2413C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74657D411;
	Tue,  5 Mar 2024 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZZKx7aq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D845005;
	Tue,  5 Mar 2024 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622565; cv=none; b=gOzRmBZ7raIUvDMsBPGRspOmtZMeaISA6F8CWsaHj++liyY0nmAjKbnT2Kcdznz3LKV32UMTVG4+/rg7/SVAzDQczMRLwVY/YwFQvPKOtHdf94QH5HjDr3Uj/G7aSqJh57CE98zlXrwR50VzS9DUnx7hke7wB6C6qaERastk/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622565; c=relaxed/simple;
	bh=iLJtfJRG3AykwJvs44aX4uKsd63Qlq1YiC9OCMcC31U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOsAmeABDx/TZ9DfbtNODYS0Un2SuLv+rOvc80l/b696z3jk+HiI+HxtcVOQNHlO8/AOjb7p56Lmhu8bgX9FcQwrZabBaqxEbxRMx/6GtpC7ZBEMLRk94GPeJYh1IWRU2gfl8qsyjDy51B1E5TGaC3x1cA14JtmZSA1BcB9GIYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZZKx7aq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FF9C433F1;
	Tue,  5 Mar 2024 07:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709622564;
	bh=iLJtfJRG3AykwJvs44aX4uKsd63Qlq1YiC9OCMcC31U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZZKx7aqHcP6Ly6lUphCoXqjWxAvksTF4ak3Y8fCg05LhRVZROMttCjmSkrJcPcnJ
	 okAGM0RW/vHxwON1IvSMvVooywP0aEW/hsroPF4j6lU3rps8BnLdky865zVkUtzR5t
	 QrVzxGgVK9ZQotLuqbUiFf69AvuQBaFj4NmeQdfLi8nEZkOH7UQS9EFNia1cA2FCpK
	 uZca0/iiOLhTvkxsdGHf5B7BA1UAE6Vu5YEemVMlLa72Lb1U959dPH1lpuRdX6i2Ta
	 JPKXxsTxF9ua9qzQ5Mb4qhJrJ2TEH9H5uEC5JHX/BRYvIYz7klwHNcIggsxcLO78y9
	 afRcy0E/4hghA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rhOva-000000002G7-0EMj;
	Tue, 05 Mar 2024 08:09:30 +0100
Date: Tue, 5 Mar 2024 08:09:30 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH] usb: dwc3: qcom: Remove ACPI support from glue driver
Message-ID: <ZebFKlae0a-deBKl@hovoldconsulting.com>
References: <20240305042143.3455101-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305042143.3455101-1-quic_kriskura@quicinc.com>

On Tue, Mar 05, 2024 at 09:51:43AM +0530, Krishna Kurapati wrote:
> Minimal ACPI support was added to the Qualcomm DWC3 glue driver in order to
> enable USB on SDM850 and SC8180X compute platforms. The support is still
> functional, but unnoticed regressions in other drivers indicates that no
> one actually booting any of platforms dependent on this implementation.
> 
> The functionality provides is the bare minimum and is not expected to aid
> in the effort of bringing full ACPI support to the driver in the future.
> 
> Remove the ACPI code from the Qualcomm DWC3 glue driver to aid in the
> implementation of improvements that are actually used like multiport and
> flattening device tree.

With a simple lookup function that returns the ACPI index based on name
this shouldn't be required to add multiport support even if it may
simplify it slightly. But IIRC it would help more with the devicetree
binding rework.
 
> Commit message by Bjorn Andersson.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 273 ++---------------------------------
>  1 file changed, 11 insertions(+), 262 deletions(-)

You should update the Kconfig entry for USB_DWC3_QCOM as well and drop
the ACPI dependency.

>  static int dwc3_qcom_probe(struct platform_device *pdev)
>  {
>  	struct device_node	*np = pdev->dev.of_node;
>  	struct device		*dev = &pdev->dev;
>  	struct dwc3_qcom	*qcom;
>  	struct resource		*res, *parent_res = NULL;

You should drop parent_res as well.

> -	struct resource		local_res;
>  	int			ret, i;
>  	bool			ignore_pipe_clk;
>  	bool			wakeup_source;
> @@ -825,14 +659,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, qcom);
>  	qcom->dev = &pdev->dev;
>  
> -	if (has_acpi_companion(dev)) {
> -		qcom->acpi_pdata = acpi_device_get_match_data(dev);
> -		if (!qcom->acpi_pdata) {
> -			dev_err(&pdev->dev, "no supporting ACPI device data\n");
> -			return -EINVAL;
> -		}
> -	}
> -
>  	qcom->resets = devm_reset_control_array_get_optional_exclusive(dev);
>  	if (IS_ERR(qcom->resets)) {
>  		return dev_err_probe(&pdev->dev, PTR_ERR(qcom->resets),
> @@ -860,41 +686,18 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	if (np) {
> -		parent_res = res;
> -	} else {
> -		memcpy(&local_res, res, sizeof(struct resource));
> -		parent_res = &local_res;
> -
> -		parent_res->start = res->start +
> -			qcom->acpi_pdata->qscratch_base_offset;
> -		parent_res->end = parent_res->start +
> -			qcom->acpi_pdata->qscratch_base_size;
> -
> -		if (qcom->acpi_pdata->is_urs) {
> -			qcom->urs_usb = dwc3_qcom_create_urs_usb_platdev(dev);
> -			if (IS_ERR_OR_NULL(qcom->urs_usb)) {
> -				dev_err(dev, "failed to create URS USB platdev\n");
> -				if (!qcom->urs_usb)
> -					ret = -ENODEV;
> -				else
> -					ret = PTR_ERR(qcom->urs_usb);
> -				goto clk_disable;
> -			}
> -		}
> -	}
> +	parent_res = res;
>  
>  	qcom->qscratch_base = devm_ioremap_resource(dev, parent_res);

And just use res here.

>  	if (IS_ERR(qcom->qscratch_base)) {
>  		ret = PTR_ERR(qcom->qscratch_base);
> -		goto free_urs;
> +		goto clk_disable;
> }

Looks good to me otherwise.

Johan

