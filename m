Return-Path: <linux-kernel+bounces-117064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE7A88A69C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CFF1F3AE5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D1313E6A2;
	Mon, 25 Mar 2024 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjEkskaN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5E1758F;
	Mon, 25 Mar 2024 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371125; cv=none; b=P8KBE8FVujoZoapGGCLtfuDlnZ9B7ecP8doRENTJPgih1poACjlZT1hUp4Dlu6+OSWaHyLPuhtZ0YofsDEmn0QGuPggtsHRjOGrfjGRrpmR07rJJT9lO6IB3QndGCw73d8oFeZ9k464Kr9BM2B7nJtFvOrb6Xquz7T6F8O4Gmjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371125; c=relaxed/simple;
	bh=z7bubkzo/8afvma6VWnGGJWecFbVMzL8InhXPHF7K4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEO2mnDmDhf2fm4VFGsLT9A+t7tXdSJo7OMtAy+L4lBLgJi9Apa7Romdz1CSYrI/s/ANiaUnfoLRJfCYOIAhK9kGzg/JAWiQaKaFRvQd3+MWKJFv6pG5r/uuBT+xSCmj+4ooWyLneQH2PqCHWosb1NovhgvBN7eYowbaCV1iXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjEkskaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF5DC433F1;
	Mon, 25 Mar 2024 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711371124;
	bh=z7bubkzo/8afvma6VWnGGJWecFbVMzL8InhXPHF7K4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjEkskaN+XBX1N15X1iMx9EMIBDV3dNY8N4xj6KRatZfxr667kpq+5UmzRlxd+MZI
	 JLWxkZzpx/LuNezMvTkljkVpA+C7pgH6GWIA64WEumoaPxfyzfupBtdR35g/Q+mdfO
	 OAZtyohFAPL8vYXhMAqlMBtHHeqWD1+E0ImR/LKZ7gZi3dRM5T/KyyMqI423BTOWSH
	 urWsyMIqPIVAMV1TZOQHPHHgqsFwSodo/oLBtkMLpqg7ihaA4ZRqdkgZ+r3dh8Ywfd
	 EqQOW26mo5+KjHGTZoOU4dBkmXPF4+eKUB9AnRAYdslJERcCsbtcawjUHa7VY9D8bB
	 T//3yh3JAXMxA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rojoB-000000001W0-1eHc;
	Mon, 25 Mar 2024 13:52:11 +0100
Date: Mon, 25 Mar 2024 13:52:11 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH v16 9/9] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Message-ID: <ZgFze1UXm5vwCjHc@hovoldconsulting.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-10-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307062052.2319851-10-quic_kriskura@quicinc.com>

On Thu, Mar 07, 2024 at 11:50:52AM +0530, Krishna Kurapati wrote:
> Power event IRQ is used for wakeup in cases:
> a) where the controller is super speed capable and missing an
> ss_phy interrupt.
> b) where the GIC is not capable of detecting DP/DM hs phy irq's.
> 
> Power event IRQ stat register indicates whether high speed phy
> entered and exited L2 successfully during suspend and resume.
> Indicate the same for all ports of multiport.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

> @@ -471,9 +480,12 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
>  	if (ret)
>  		dev_warn(qcom->dev, "failed to enable interconnect: %d\n", ret);
>  
> +	for (i = 0; i < qcom->num_ports; i++) {
>  	/* Clear existing events from PHY related to L2 in/out */

This comment either needs to be moved above the for-loop or be indented
one level in.

> -	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
> -			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
> +		dwc3_qcom_setbits(qcom->qscratch_base,
> +				  pwr_evnt_irq_stat_reg[i],
> +				  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
> +	}
>  
>  	qcom->is_suspended = false;

With the above fixed:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

