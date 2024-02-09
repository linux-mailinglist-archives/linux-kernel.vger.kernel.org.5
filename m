Return-Path: <linux-kernel+bounces-58950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6621484EF0F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01ED91F21B7B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867BE4A33;
	Fri,  9 Feb 2024 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPss0lYc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F07184D;
	Fri,  9 Feb 2024 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447205; cv=none; b=eht9WV7uZ4mLlZNQ/q8PJzYUv9tirJzJYkQUaDDXKf8gOG1VarWL5XgGGYy3peBtuuVt21U5bufjN1zyL5gMU2vUObk3R4ZtiUJoa5AOWeO3YE17f7b9PHa7aJqVTmNzOS55O8qOkLDY9/h+Hl/vjtTOCmmPOdFhv5e/8FE2+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447205; c=relaxed/simple;
	bh=tmsVePUwEMwE0c2Orl8P4NQW8MDi8IVCRIWTHlgw1tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3i6P+IgnPDhGAhostOB906u/TPgZQf87d0zbUmJsIhZ5yUp2Zu8Q20ybKaeklsqp1510ItoKwcW8D2H1UAi+4cAmnRCQ04HmFCAard312T89NGjDH40aAO32lB/MMfQuzYneJQxzFZ+hivW2DuQyjJj61Wf4K0+PTM31G/w4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPss0lYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE372C433F1;
	Fri,  9 Feb 2024 02:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707447205;
	bh=tmsVePUwEMwE0c2Orl8P4NQW8MDi8IVCRIWTHlgw1tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPss0lYcR8l++YP+zQQm2jC/agXxJpvchQtFePsZ6euZ35B6ThUK/pDpO0inpnxF4
	 wWv89zFT7ajv52quAFY+eKpz/KowwV74yvTSiutBzD14ZmSdZNcg/WcdMC6Pvvsfk7
	 +z+AuhQjggk9L6fZRh0hrmEyqRg8Q1EM2UgpaMnVZTOx4l1c5zffx9KORXuMBL+Sbb
	 6r2GwUGlM7FQQKM2HNa6PN8ONtz7+OadF8T2vhLNrTpZl4GPZaVDI7VEB+zvYj35/C
	 9efmwKW7ruqd3h0Jxhcw1lFaKIFppkNlF+Xd4cMESK3bzN1ZOnJEl5J6Bl1yk/6Bvi
	 qchjUhEC1rYFw==
Date: Thu, 8 Feb 2024 20:53:22 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com, Harsh Agarwal <quic_harshq@quicinc.com>
Subject: Re: [PATCH v14 4/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <3sz47d75gpt76vqajuvdz2jo5y53pp72w7gsxwiywsbuuwwpzg@gsqcjqyuakfd>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-5-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206051825.1038685-5-quic_kriskura@quicinc.com>

On Tue, Feb 06, 2024 at 10:48:20AM +0530, Krishna Kurapati wrote:
> From: Harsh Agarwal <quic_harshq@quicinc.com>
> 
> Currently the DWC3 driver supports only single port controller
> which requires at least one HS PHY and at most one SS PHY.
> 
> But the DWC3 USB controller can be connected to multiple ports and
> each port can have their own PHYs. Each port of the multiport
> controller can either be HS+SS capable or HS only capable
> Proper quantification of them is required to modify GUSB2PHYCFG
> and GUSB3PIPECTL registers appropriately.
> 
> Add support for detecting, obtaining and configuring PHYs supported
> by a multiport controller. Limit support to multiport controllers
> with up to four ports for now (e.g. as needed for SC8280XP).
> 
> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> Co-developed-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
[..]
> @@ -740,7 +745,35 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>  	if (dwc->ulpi_ext_vbus_drv)
>  		reg |= DWC3_GUSB2PHYCFG_ULPIEXTVBUSDRV;
>  
> -	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
> +
> +	return 0;
> +}
> +
> +/**

The format of this kernel-doc comment is not correct, but it's only
moved in this patchset so I think it should be fixed in a separate
patch.

Regards,
Bjorn

> + * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
> + * @dwc: Pointer to our controller context structure
> + *
> + * Returns 0 on success. The USB PHY interfaces are configured but not
> + * initialized. The PHY interfaces and the PHYs get initialized together with
> + * the core in dwc3_core_init.
> + */
> +static int dwc3_phy_setup(struct dwc3 *dwc)

