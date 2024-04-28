Return-Path: <linux-kernel+bounces-161581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 664E58B4DF9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0A51C20846
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4559B660;
	Sun, 28 Apr 2024 21:45:19 +0000 (UTC)
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B617D2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714340719; cv=none; b=XLlY+otXjj68TjNQOgJdl9QbCO2WPw+skupGE0PbOjEg6axdawHYwkBLsi19x/1YeVcYtThPImtaN7+GseiBWyqRgTbzuiiWzGJebyEHZuABXTtBkSdmx9iaco9vDjEXtY7S8p1w77fuWqQeM0aycZgKjiTVV67+MrRYue749+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714340719; c=relaxed/simple;
	bh=kAVP55YO4U/ubSBWbaDMVA8lpzhP6ZAkZbi2R0GkA5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6ntfPdwebzJ+kBCic2afhMuXlixnp0PmgbkqMKTFRKkb4fiWNcqgG/RtNvG5xEr1fV2p7sSQz9y/7e/ln+5WQiXgTv0qJEK0rg2O7IsIIofhVyKn9kcfzNIDDy2fT1WRhA5wZKYKW74QD9i5lyy0aUW8E24Qr2Evyukjom5O+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 9A1D21F62F;
	Sun, 28 Apr 2024 23:06:35 +0200 (CEST)
Date: Sun, 28 Apr 2024 23:06:34 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Archit Taneja <architt@codeaurora.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Vinod Koul <vkoul@kernel.org>, 
	Sravanthi Kollukuduru <skolluku@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jordan Crouse <jordan@cosmicpenguin.net>, Rajesh Yadav <ryadav@codeaurora.org>, 
	Jeykumar Sankaran <jsanka@codeaurora.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Martin Botka <martin.botka@somainline.org>, Jami Kettunen <jami.kettunen@somainline.org>
Subject: Re: [PATCH 5/7] drm/msm/dpu: Correct dual-ctl -> dual-intf typo in
 comment
Message-ID: <mrg3m7awzvozhyg2zwwbawfa6cb6xo7obzooiq3iph6mu3ybfc@b5h2pzxvcjvf>
References: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
 <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-5-78ae3ee9a697@somainline.org>
 <76hjmo4sq6sfjgmnvjoienc5aij74pfjtwevnnls65kxinyaxu@y3yydacvcflm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76hjmo4sq6sfjgmnvjoienc5aij74pfjtwevnnls65kxinyaxu@y3yydacvcflm>

On 2024-04-18 02:30:59, Dmitry Baryshkov wrote:
> On Wed, Apr 17, 2024 at 01:57:45AM +0200, Marijn Suijten wrote:
> > This comment one line down references a single, "same CTL" that controls
> > two interfaces, so the comment should clearly describe two interfaces
> > used with a single active CTL and not "two CTLs".
> > 
> > Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > index d9e7dbf0499c..7e849fe74801 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > @@ -428,7 +428,7 @@ static void dpu_encoder_phys_vid_enable(struct dpu_encoder_phys *phys_enc)
> >  	dpu_encoder_phys_vid_setup_timing_engine(phys_enc);
> >  
> >  	/*
> > -	 * For single flush cases (dual-ctl or pp-split), skip setting the
> > +	 * For single flush cases (dual-intf or pp-split), skip setting the
> 
> It should be fixed, but in the other way: it's 'single-ctl'. See
> sde_encoder_phys_needs_single_flush().

As written in the cover letter I was unsure about this comment.

You are right that sde_encoder_phys_needs_single_flush() is supposed to return
true in pp-split or single-ctl.  However, the second part of the comment (right
below) is in conflict with another patch that I've sent as part of these series:
on a single-ctl setup with dual interfaces, the second INTF needs to be marked
for flushing.

While that observation and fix is for CMD-mode, the exact same comment is found
downstream for video mode:

https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/-/blob/display-kernel.lnx.5.4.r1-rel/msm/sde/sde_encoder_phys_vid.c?ref_type=heads#L794-804

You were fixing exactly that in one of your preliminary Active-CTL patches by
making dpu_encoder_phys_vid_needs_single_flush() return for Active-CTL, so we
should probably update this comment in the same patch when you send it?

(that is: the flush bit needs to be set for the slave intf in Active-CTL. Before
Active-CTL, a slave encoder would actually have two CTLs and two INTFs where the
flush bit was probably skipped on both slaves?)

On a side-note, since the needs_single_flush callback is used elsehwere, I'm
unsure if that patch affects things in the wrong way since the downstream file
linked above applies the check for CTL_ACTIVE_CFG directly in-line without
affecting the callback.

- Marijn

> >  	 * flush bit for the slave intf, since both intfs use same ctl
> >  	 * and HW will only flush the master.
> >  	 */
> > 
> > -- 
> > 2.44.0
> > 
> 
> -- 
> With best wishes
> Dmitry

