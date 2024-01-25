Return-Path: <linux-kernel+bounces-38537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0326883C12E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056501C23CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC5545025;
	Thu, 25 Jan 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNtFBgEM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC4944363;
	Thu, 25 Jan 2024 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182899; cv=none; b=Sq5Bdp7RnCjaHNy9Nv/sTE59yez1NwqxTx2ZXHxcas0aaKOjMALwZzY/O4r63cXUoiV1yVk+0ZEODoG2Jk3BocARXBGYesvuYuQwXMHOuToIAkE1Q+c1+2e1MWYu9OKikLUkW1gcaNXlTycV2+ILOCHQ4rmTh3uCovcDie0At3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182899; c=relaxed/simple;
	bh=MKey3YQTd92e4aAsfwfIM20Iq3jFKrjkcDjDuS9hx1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld1sXg+m6v2XsACLkBCESnnaZEG1UCP2ROCcPoFMhlIL2y/TuYt7nfrjFNQI0pOEDP+IloOIvwgIEj0qoBrzse7cyZj71jwjNSM72rnF1Vcq88gd+bxJVdr3bLafMMRQ5Y5PWeI8503Kc/cKLT/xmrP1rajuG1I4jiL36TpIXxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNtFBgEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550F4C433F1;
	Thu, 25 Jan 2024 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706182898;
	bh=MKey3YQTd92e4aAsfwfIM20Iq3jFKrjkcDjDuS9hx1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNtFBgEMv1Ev5WK11pfPhwcDRyYz5zgqGlmBqM5RNoLy7aouMQ2cPj8SpuJRmpotL
	 BZI39nNFua6PUr1E+Lcig8cp74shLSM4R6b8sTezKK1XWh6TymeOuRg5Wm1QZj29os
	 mga/3J/MnBbSzzyctaDAFQHBLEl/W4y0XcU3gXAo/Q1VY4XcikM9hYMQNrqubZ3bN2
	 mb94Eq0FiN8uCzAypzjgyerqm82+2WSExpBp91zBFhTfuFLXX/jLVdEWNM+8d49oD/
	 JnPnbvnfAT0Qpf7ksYfkcioS1nmYPr0f/br5Q6s5htilAxTG5oSba6VfGf+2cq+g60
	 J/k51Rvw4gCxw==
Date: Thu, 25 Jan 2024 17:11:35 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Mantas Pucka <mantas@8devices.com>
Subject: Re: linux-next: manual merge of the phy-next tree with the phy tree
Message-ID: <ZbJI7437Hd22EuF3@matsya>
References: <20240125123327.4e2825ab@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125123327.4e2825ab@canb.auug.org.au>

On 25-01-24, 12:33, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the phy-next tree got a conflict in:
> 
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> 
> between commit:
> 
>   f74c35b630d4 ("phy: qcom-qmp-usb: fix register offsets for ipq8074/ipq6018")
> 
> from the phy tree and commit:
> 
>   52cfdc9c6c33 ("phy: qcom: qmp-usb: drop dual-lane handling")
> 
> from the phy-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks Stephen, this looks good to me. I will notify Linus when he pulls
this

BR

> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index 6621246e4ddf,e62539ce99a6..25d8d881b2f3
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@@ -1621,28 -1385,8 +1393,24 @@@ static const struct qmp_usb_offsets qmp
>   	.rx		= 0x1000,
>   };
>   
>  +static const struct qmp_phy_cfg ipq6018_usb3phy_cfg = {
> - 	.lanes			= 1,
> - 
>  +	.offsets		= &qmp_usb_offsets_ipq8074,
>  +
>  +	.serdes_tbl		= ipq9574_usb3_serdes_tbl,
>  +	.serdes_tbl_num		= ARRAY_SIZE(ipq9574_usb3_serdes_tbl),
>  +	.tx_tbl			= msm8996_usb3_tx_tbl,
>  +	.tx_tbl_num		= ARRAY_SIZE(msm8996_usb3_tx_tbl),
>  +	.rx_tbl			= ipq8074_usb3_rx_tbl,
>  +	.rx_tbl_num		= ARRAY_SIZE(ipq8074_usb3_rx_tbl),
>  +	.pcs_tbl		= ipq8074_usb3_pcs_tbl,
>  +	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_usb3_pcs_tbl),
>  +	.vreg_list		= qmp_phy_vreg_l,
>  +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>  +	.regs			= qmp_v3_usb3phy_regs_layout,
>  +};
>  +
>   static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
> - 	.lanes			= 1,
> - 
>  -	.offsets		= &qmp_usb_offsets_v3,
>  +	.offsets		= &qmp_usb_offsets_ipq8074,
>   
>   	.serdes_tbl		= ipq8074_usb3_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_usb3_serdes_tbl),



-- 
~Vinod

