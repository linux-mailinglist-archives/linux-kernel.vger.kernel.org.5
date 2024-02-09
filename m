Return-Path: <linux-kernel+bounces-58952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF9A84EF19
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0E31C260B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC354A39;
	Fri,  9 Feb 2024 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVEuHylp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2383FDF;
	Fri,  9 Feb 2024 02:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447318; cv=none; b=RHRehTsmnnNH4dArDzzO67j+DMSdIxckBxbhTHbqnFZZUNJWx/NZYV+qGB/CII0UQoPCVN2dhiz5soCN6mdRO8DxOF1ONA4obLvcRgxDZKip3Asoy5dpY8gIT5afFIopi+xSUZT1FrarIAowG7SeSD8KFk0KMoPTZ+uQbAilyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447318; c=relaxed/simple;
	bh=Zgk96p8bo054L9NR9mHJ6MMgf6RUQhISYqQR+ZNQnK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeY3SoiO/jy/0gJkl4MaLxy0806fkdiv3hI4KXyCfPIBpV/SoB5KU+zHbqyRaNxGzFsJh93wMyHGzNtAq+g4/givrg5CesMmenYQu7jhRXXi6m0mzhVD9buT+2AtNvznkseXPyPhggsCoQ/NdE83A1EkjSzVuDj+C+lsa0LLYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVEuHylp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCEDC433C7;
	Fri,  9 Feb 2024 02:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707447318;
	bh=Zgk96p8bo054L9NR9mHJ6MMgf6RUQhISYqQR+ZNQnK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVEuHylpczBS+FEKw94du99WpP7oV7JWS/wuxKr5pv3pFZ/doP2ZNjX0rgjVhuecz
	 g5/w3dsY18dkddg4hJLDPfxLnDxAopYVvlQ3EP6gfQzEcLd4LyU4wxv4AEnQWYeBsk
	 5ZoTBf1CnHtJ9dz1f1KlRZSZPbOoTB7beu3oHBInF86mc8vUmd5AP2iVRRRDStIiBl
	 Ihc2aQCjSEUpZI8WhnvCdH0dMa3xAkd9TUwctuDLYJ1hOnP6VN+KwPisYy+BhRXu8u
	 GK4Dx4ZZPp9tqYlxWf5njnEinFxzIzwVjrH+GjaHs41Iv2TE7T2QcBSCXqKy2YLTW9
	 oXJ0Y4upMwqUQ==
Date: Thu, 8 Feb 2024 20:55:15 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: [PATCH v14 6/9] usb: dwc3: qcom: Add helper function to request
 wakeup interrupts
Message-ID: <emhh7z7dy7jgnmjcefdzmpwz4nf6657zhzow3uxrc2rd347ooi@ks7rfyac56vv>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-7-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206051825.1038685-7-quic_kriskura@quicinc.com>

On Tue, Feb 06, 2024 at 10:48:22AM +0530, Krishna Kurapati wrote:
> The logic for requesting interrupts is duplicated for each interrupt. In
> the upcoming patches that introduces support for multiport, it would be
> better to clean up the duplication before reading mulitport related
> interrupts.
> 
> Refactor interrupt setup call by adding a new helper function for
> requesting the wakeup interrupts. To simplify implementation, make
> the display name same as the interrupt name expected in DT.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 53 ++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index dbd6a5b2b289..08df29584366 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -535,6 +535,22 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int dwc3_qcom_request_irq(struct dwc3_qcom *qcom, int irq,
> +				 const char *name)
> +{
> +	int ret;
> +
> +	/* Keep wakeup interrupts disabled until suspend */
> +	ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> +					qcom_dwc3_resume_irq,
> +					IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					name, qcom);
> +	if (ret)
> +		dev_err(qcom->dev, "failed to request irq %s: %d\n", name, ret);
> +
> +	return ret;
> +}
> +
>  static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  {
>  	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> @@ -545,57 +561,36 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  	irq = dwc3_qcom_get_irq(pdev, "qusb2_phy",
>  				pdata ? pdata->qusb2_phy_irq_index : -1);
>  	if (irq > 0) {
> -		/* Keep wakeup interrupts disabled until suspend */
> -		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> -					qcom_dwc3_resume_irq,
> -					IRQF_ONESHOT | IRQF_NO_AUTOEN,
> -					"qcom_dwc3 QUSB2", qcom);
> -		if (ret) {
> -			dev_err(qcom->dev, "qusb2_phy_irq failed: %d\n", ret);
> +		ret = dwc3_qcom_request_irq(qcom, irq, "hs_phy_irq");
> +		if (ret)
>  			return ret;
> -		}
>  		qcom->qusb2_phy_irq = irq;
>  	}
>  
>  	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
>  				pdata ? pdata->dp_hs_phy_irq_index : -1);
>  	if (irq > 0) {
> -		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> -					qcom_dwc3_resume_irq,
> -					IRQF_ONESHOT | IRQF_NO_AUTOEN,
> -					"qcom_dwc3 DP_HS", qcom);
> -		if (ret) {
> -			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
> +		ret = dwc3_qcom_request_irq(qcom, irq, "dp_hs_phy_irq");
> +		if (ret)
>  			return ret;
> -		}
>  		qcom->dp_hs_phy_irq = irq;
>  	}
>  
>  	irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
>  				pdata ? pdata->dm_hs_phy_irq_index : -1);
>  	if (irq > 0) {
> -		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> -					qcom_dwc3_resume_irq,
> -					IRQF_ONESHOT | IRQF_NO_AUTOEN,
> -					"qcom_dwc3 DM_HS", qcom);
> -		if (ret) {
> -			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
> +		ret = dwc3_qcom_request_irq(qcom, irq, "dm_hs_phy_irq");
> +		if (ret)
>  			return ret;
> -		}
>  		qcom->dm_hs_phy_irq = irq;
>  	}
>  
>  	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
>  				pdata ? pdata->ss_phy_irq_index : -1);
>  	if (irq > 0) {
> -		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
> -					qcom_dwc3_resume_irq,
> -					IRQF_ONESHOT | IRQF_NO_AUTOEN,
> -					"qcom_dwc3 SS", qcom);
> -		if (ret) {
> -			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
> +		ret = dwc3_qcom_request_irq(qcom, irq, "ss_phy_irq");
> +		if (ret)
>  			return ret;
> -		}
>  		qcom->ss_phy_irq = irq;
>  	}
>  
> -- 
> 2.34.1
> 

