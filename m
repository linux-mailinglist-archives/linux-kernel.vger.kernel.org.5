Return-Path: <linux-kernel+bounces-58946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE8284EEFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42659B24BCB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4E01C32;
	Fri,  9 Feb 2024 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRLbXTwx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C221C27;
	Fri,  9 Feb 2024 02:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446769; cv=none; b=LwXgQ+o67F72oqt743Sru4nnsdwfXob6yTXNN4OHU1GgoGcn6IxhfkUj/W01m2Ko0ie8i/g6WiPhu+x9X1nRK+aUB3+9MeVlW2p0aZjucSxKqXbdm3XHPPEK6auI7mKIFOk8YxiWaWantiWjTlNo9tgt+u/+Y/XlZ+bSzKgUhxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446769; c=relaxed/simple;
	bh=+jDlR+fy0YI8uizn8b/8Ith4qzKH8NBzerA/is5ZlIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxsKb5DIvMwW5iVAMw+510/+JaoXd+Nl9mUycZEQU6zyFTOmLb8dEmR2bYtjRlrp0AWFcMK02wMRhLlbHcWF92TH4rrkLCCk0Pk9V8BTzCR5K4EVFf+23t+yxsjKfwHQaNtM2b5U0dcEqyq+8V/RarnVHhwqLsX/oTufFgTdV5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRLbXTwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12BEC433F1;
	Fri,  9 Feb 2024 02:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707446769;
	bh=+jDlR+fy0YI8uizn8b/8Ith4qzKH8NBzerA/is5ZlIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRLbXTwxj1gUy2X+LJipT5mGbQlPhev7F0h9KX2r0On98CRXnyH7gf1+XdV1f7hxK
	 mUWQ110dYj2RYfPs3HGMHOeZ9UCiykrF4ijlheE914WgspWiSl/WxPRmvV2lwbLLuO
	 lPssFBTUmYebxMNNwQCJOWI+ZkJXBuG+BhYY6uI/z34I0mpLNliuN3Z46Kj0g3ien4
	 7JUgWWPs9wv3GI0aTTgRW+EuxUafNyOP4kW/Dq/r0XRZ1Qk76YmO/VXqPqrRgu/fMT
	 QJGGbvA1cPVl5h9eRDoxjLpvT98kl54JuaevHeJlNxrHgfG9aQbHSvG6Zry+exko7C
	 YivzToFlwvtPg==
Date: Thu, 8 Feb 2024 20:46:05 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com, Johan Hovold <johan@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v14 3/9] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Message-ID: <nty2l5b6fsu3owmnwrfcrp7w67zmfi3guvxqy2cwjtchnerjkp@n42o34comila>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-4-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206051825.1038685-4-quic_kriskura@quicinc.com>

On Tue, Feb 06, 2024 at 10:48:19AM +0530, Krishna Kurapati wrote:
> On some SoC's like SA8295P where the tertiary controller is host-only
> capable, GEVTADDRHI/LO, GEVTSIZ, GEVTCOUNT registers are not accessible.
> Trying to access them leads to a crash.
> 
> For DRD/Peripheral supported controllers, event buffer setup is done
> again in gadget_pullup. Skip setup or cleanup of event buffers if
> controller is host-only capable.
> 
> Suggested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/usb/dwc3/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 965eaad195fb..c47fec10b231 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -486,6 +486,13 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
>  static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
>  {
>  	struct dwc3_event_buffer *evt;
> +	unsigned int hw_mode;
> +
> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
> +		dwc->ev_buf = NULL;
> +		return 0;
> +	}
>  
>  	evt = dwc3_alloc_one_event_buffer(dwc, length);
>  	if (IS_ERR(evt)) {
> @@ -507,6 +514,9 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>  {
>  	struct dwc3_event_buffer	*evt;
>  
> +	if (!dwc->ev_buf)
> +		return 0;
> +
>  	evt = dwc->ev_buf;
>  	evt->lpos = 0;
>  	dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
> @@ -524,6 +534,9 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
>  {
>  	struct dwc3_event_buffer	*evt;
>  
> +	if (!dwc->ev_buf)
> +		return;
> +
>  	evt = dwc->ev_buf;
>  
>  	evt->lpos = 0;
> -- 
> 2.34.1
> 

