Return-Path: <linux-kernel+bounces-44145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC98841DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCF128B47B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C656B71;
	Tue, 30 Jan 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stIGp61e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A683F9E7;
	Tue, 30 Jan 2024 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603742; cv=none; b=XLI5qXr8NjnAvSpN0hnKdb443mDfW+8WUo46anBGgvgN8bpQrLSD5qzhDbh1D8UxZNbeh5VFA5axPyiBPcIAahXafJMRR66AZjOhAoEEPXZQynOTHf07OS9ajk3r8YbA9afWFfdnmF22nP6r9bUlN29nssbwdbSo1HNhaE9yqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603742; c=relaxed/simple;
	bh=N0kg3YjJSti8U3lrmYd2PIZvWMjVDyjRAbAKeR5/VQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIiw0lR3SVF2oMvgnlikhPPZt9eaU3zmG67COdptYXclJ9WI18AB00UQvb9QDNYlafkeivBeIYR33vP4FTdbRVBGJjhe0aktbXi9fZMS7Qlo7pQu1yQz6HDLkAIG0/lfDazyLYYtvEbWOV9Bi4F28HDYCveJULb5ZzPkYMZUZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stIGp61e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D69BC433C7;
	Tue, 30 Jan 2024 08:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706603741;
	bh=N0kg3YjJSti8U3lrmYd2PIZvWMjVDyjRAbAKeR5/VQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stIGp61ecKDJCp1aKRrgyOnjdbW+DOKiNvEnjoYFJMS3mAwrPVRuj/Y9kajPVMGmf
	 TR6tosqeQN0mmn/BsIWJvq69h6P937eA+qeluljHRzp/yik8a/kiiXPx+0eipPTHji
	 9cAQ8Mv+DpGyjxnJI9UQIms/uGRXSjIdpnggugM//gmoGIQCV8ZcAJwtjnWl2h7zXI
	 zRDs2FwSPcer4UfsteWT/XqwWQidtlDu/DXJ77yYe6miDSvUmD2OZ2VDw1IZVj7UVI
	 160/yowj4poODko5QTeP0qaC9TE4u9bcCcDDI0ZzIcx56f/KCu8J/9kJESmmmOP+R1
	 UnzJlR/YtXBaQ==
Date: Tue, 30 Jan 2024 14:05:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Elder <elder@linaro.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] bus: mhi: ep: Use kcalloc() instead of kzalloc()
Message-ID: <20240130083533.GN32821@thinkpad>
References: <20240128112722.4334-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240128112722.4334-1-erick.archer@gmx.com>

On Sun, Jan 28, 2024 at 12:27:22PM +0100, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe because the "event_rings"
> member never can have a value greater than 255 (8 bits). This member
> is set twice using always FIELD_GET:
> 
> mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
> mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
> 
> And the MHICFG_NER_MASK macro defines the 8 bits mask that guarantees
> a maximum value of 255.
> 
> However, using kcalloc() is more appropriate [1] and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes in v2:
> - Add more info in the commit message to better explain the change.
>   (Dan Carpenter)
> - Add the "Reviewed-by:" tag.
> 
> Previous versions:
> v1 - https://lore.kernel.org/linux-hardening/20240120152518.13006-1-erick.archer@gmx.com/
> ---
>  drivers/bus/mhi/ep/main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 65fc1d738bec..8d7a4102bdb7 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1149,8 +1149,9 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
>  	mhi_ep_mmio_mask_interrupts(mhi_cntrl);
>  	mhi_ep_mmio_init(mhi_cntrl);
> 
> -	mhi_cntrl->mhi_event = kzalloc(mhi_cntrl->event_rings * (sizeof(*mhi_cntrl->mhi_event)),
> -					GFP_KERNEL);
> +	mhi_cntrl->mhi_event = kcalloc(mhi_cntrl->event_rings,
> +				       sizeof(*mhi_cntrl->mhi_event),
> +				       GFP_KERNEL);
>  	if (!mhi_cntrl->mhi_event)
>  		return -ENOMEM;
> 
> --
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

