Return-Path: <linux-kernel+bounces-41842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D077883F878
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6C01C217A0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7589A2D05E;
	Sun, 28 Jan 2024 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AwYolSO+"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC92E630;
	Sun, 28 Jan 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706462018; cv=none; b=CWLa0YizpOqUFS9gzcQV5vwJVJRydTpsHjcrDhBLZw8SKMsi4ry44fGqHRLfm04H0iHT4zK8BWYo44/GMwjc114AA65KhbqRZZ/xZtisWM/lFeYtY4XE51Pmimdt24BD1Bs6nGRNynY1arnmH3lAaYnu2xFlQfMq9ZJqiLymVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706462018; c=relaxed/simple;
	bh=nf6DRFxx7i1k82b+O6czyuhfZJjgaHz50J21iXl04R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxSWT5ikLkCeWvan3hSz/LTu9ZWyJtK6fAg/Z+wRf9DIWmoF9qazpBklI/cfz4zOeM1g+gF1AseD2pQeFOM+TbZOmPHwHEAuc4TwQrGil/Evk4kQaGlrb+qSEngREXSI0D0zmcp5G5PB94ohNDi2RL4045HEhZXc4xvpNJ7zWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AwYolSO+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E95273D9;
	Sun, 28 Jan 2024 18:12:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706461937;
	bh=nf6DRFxx7i1k82b+O6czyuhfZJjgaHz50J21iXl04R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwYolSO+Mi3f4nlRgOjNAL2mAIlNAWKLrUUaW5xbI7gKBsNEBVdEjpED1ce15Q2c2
	 6mbvtLS9uj2pRmXXTFbrfvzl/t+l3OgSyqNbAjXJvCB2Ziek7m3RgPPN4pu/lO1p3i
	 a92h0QgKGyDuVPs+DgN5a61EBDI8H2TZmVWIst+U=
Date: Sun, 28 Jan 2024 19:13:32 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: nxp: imx8-isi: Factor out a variable
Message-ID: <20240128171332.GD27180@pendragon.ideasonboard.com>
References: <20240128-gcc-11-warnings-v1-0-52bbdf492049@chromium.org>
 <20240128-gcc-11-warnings-v1-1-52bbdf492049@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240128-gcc-11-warnings-v1-1-52bbdf492049@chromium.org>

Hi Ricardo,

Thank you for the patch.

On Sun, Jan 28, 2024 at 04:13:56PM +0000, Ricardo Ribalda wrote:
> gcc-11 seems to believe that coffs can be used uninitialized. Refactor

s/coffs/coeffs/

> the code and remove the csen variable to convince gcc that we are doing

s/csen/cscen/

> a good job.
> 
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:218:20: warning: 'coeffs' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
> index 19e80b95ffea..5623914f95e6 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
> @@ -215,8 +215,7 @@ static void mxc_isi_channel_set_csc(struct mxc_isi_pipe *pipe,
>  		[MXC_ISI_ENC_RGB] = "RGB",
>  		[MXC_ISI_ENC_YUV] = "YUV",
>  	};
> -	const u32 *coeffs;
> -	bool cscen = true;
> +	const u32 *coeffs = NULL;
>  	u32 val;
>  
>  	val = mxc_isi_read(pipe, CHNL_IMG_CTRL);
> @@ -235,14 +234,13 @@ static void mxc_isi_channel_set_csc(struct mxc_isi_pipe *pipe,
>  		val |= CHNL_IMG_CTRL_CSC_MODE(CHNL_IMG_CTRL_CSC_MODE_RGB2YCBCR);
>  	} else {
>  		/* Bypass CSC */
> -		cscen = false;
>  		val |= CHNL_IMG_CTRL_CSC_BYPASS;
>  	}
>  
>  	dev_dbg(pipe->isi->dev, "CSC: %s -> %s\n",
>  		encodings[in_encoding], encodings[out_encoding]);
>  
> -	if (cscen) {
> +	if (coeffs) {
>  		mxc_isi_write(pipe, CHNL_CSC_COEFF0, coeffs[0]);
>  		mxc_isi_write(pipe, CHNL_CSC_COEFF1, coeffs[1]);
>  		mxc_isi_write(pipe, CHNL_CSC_COEFF2, coeffs[2]);
> @@ -253,7 +251,7 @@ static void mxc_isi_channel_set_csc(struct mxc_isi_pipe *pipe,
>  
>  	mxc_isi_write(pipe, CHNL_IMG_CTRL, val);
>  
> -	*bypass = !cscen;
> +	*bypass = !coeffs;
>  }
>  
>  void mxc_isi_channel_set_alpha(struct mxc_isi_pipe *pipe, u8 alpha)
> 

-- 
Regards,

Laurent Pinchart

