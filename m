Return-Path: <linux-kernel+bounces-66355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB34C855B85
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A14E1F22B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74674DDDF;
	Thu, 15 Feb 2024 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWC2P15Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DF33CF;
	Thu, 15 Feb 2024 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707981708; cv=none; b=iUvqiuqyowXMmuWcUfVZu5rh3PxRRSnHFsppPiKaJLdus//8RoEeGIkJpmP2WskUo32pZJ34VJ52i+F5BSPE8TsbRGL1x54yRYKXiMsGEb3dk7Q0Cocy6P3xYe07k0BLCjJwRluU62Eco0z91Te/YJSREoC7S6h+mf3NTWFjFeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707981708; c=relaxed/simple;
	bh=QKpRsp1RwTdcyAJM3bUrM0Ffhxf1+M/TAhIk32zyMRs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ux2qRhWvPiB9bNnb/bj64RRwjJpYP7KWGzmCb+Ju4AeEyiOVnnGEZa6uStVE3/w2OjLWZkPz9bkXjl6JjNruqCUpCA5s+gHmMPohryqoohrkjCOiD+KX9hgN/ccPBA8TZSUqy86wQQabOp8E09yR1RJBbYRXkR97br75ynMjGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWC2P15Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A8FC433C7;
	Thu, 15 Feb 2024 07:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707981708;
	bh=QKpRsp1RwTdcyAJM3bUrM0Ffhxf1+M/TAhIk32zyMRs=;
	h=Date:From:To:Cc:Subject:From;
	b=EWC2P15Y1fQ/JTT9auxop0Kb73/apngE0JaFj/x3RqcAuswivKAAwWZh0c+k8GEaL
	 MDaLwYzPVWGAcRbTMl3xqgqbUA2g2haC1rakhO8FrvgC506xbADeAa4pE7/wBGsKzV
	 9k8Yjm4mv0rU6k/vC78rvWzcRYbFDjO23Y2orx4//6oAyA0SRKzNo40npD7IT3lpiO
	 G/ed52SdH5tpcaOPiki5obe+Y7HYTZnTnKmc7nuL6cVP7B4DFvzc3HBPYAH5etQwyu
	 qRZUQIUau2QWQm0cTOLFzl0lr2tEs3MN4y2ykE/6wi4Ow+WIDnT1DGvwR/xgCnEMCQ
	 7augH/wyW7Ugg==
Date: Thu, 15 Feb 2024 15:21:38 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, peter.chen@cixtech.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdnsp: blocked some cdns3 specific code
Message-ID: <20240215072138.GB1256251@nchen-desktop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It is for both cdns3 and cdnsp.

Reply-To: 
In-Reply-To: <20240206104018.48272-1-pawell@cadence.com>

On 24-02-06 11:40:18, Pawel Laszczak wrote:
> host.c file has some parts of code that were introduced for CDNS3 driver
> and should not be used with CDNSP driver.
> This patch blocks using these parts of codes by CDNSP driver.
> These elements include:
> - xhci_plat_cdns3_xhci object
> - cdns3 specific XECP_PORT_CAP_REG register
> - cdns3 specific XECP_AUX_CTRL_REG1 register
> 
> cc: <stable@vger.kernel.org>
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/host.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
> index 6164fc4c96a4..ceca4d839dfd 100644
> --- a/drivers/usb/cdns3/host.c
> +++ b/drivers/usb/cdns3/host.c
> @@ -18,6 +18,11 @@
>  #include "../host/xhci.h"
>  #include "../host/xhci-plat.h"
>  
> +/*
> + * The XECP_PORT_CAP_REG and XECP_AUX_CTRL_REG1 exist only
> + * in Cadence USB3 dual-role controller, so it can't be used
> + * with Cadence CDNSP dual-role controller.
> + */
>  #define XECP_PORT_CAP_REG	0x8000
>  #define XECP_AUX_CTRL_REG1	0x8120
>  
> @@ -57,6 +62,8 @@ static const struct xhci_plat_priv xhci_plat_cdns3_xhci = {
>  	.resume_quirk = xhci_cdns3_resume_quirk,
>  };
>  
> +static const struct xhci_plat_priv xhci_plat_cdnsp_xhci;
> +
>  static int __cdns_host_init(struct cdns *cdns)
>  {
>  	struct platform_device *xhci;
> @@ -81,8 +88,13 @@ static int __cdns_host_init(struct cdns *cdns)
>  		goto err1;
>  	}
>  
> -	cdns->xhci_plat_data = kmemdup(&xhci_plat_cdns3_xhci,
> -			sizeof(struct xhci_plat_priv), GFP_KERNEL);
> +	if (cdns->version < CDNSP_CONTROLLER_V2)
> +		cdns->xhci_plat_data = kmemdup(&xhci_plat_cdns3_xhci,
> +				sizeof(struct xhci_plat_priv), GFP_KERNEL);
> +	else
> +		cdns->xhci_plat_data = kmemdup(&xhci_plat_cdnsp_xhci,
> +				sizeof(struct xhci_plat_priv), GFP_KERNEL);
> +

You may explain why you duplicate another structure for cdnsp at commit
log.

>  	if (!cdns->xhci_plat_data) {
>  		ret = -ENOMEM;
>  		goto err1;
> 

Others are okay for me.

-- 

Thanks,
Peter Chen

