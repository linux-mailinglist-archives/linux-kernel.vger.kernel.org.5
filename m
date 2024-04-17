Return-Path: <linux-kernel+bounces-148492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B69E88A836C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D421282A70
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0A813D290;
	Wed, 17 Apr 2024 12:50:17 +0000 (UTC)
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36F84E01;
	Wed, 17 Apr 2024 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358217; cv=none; b=gKUWojkymmPk43dOtZJwSRHghEUwPbCuvwHpTlEV0WUhHn6tknfp8rA/nqnTESUXVr3z1MLb//nJqmdQJCDPp3Z5nLqs/gX/7gE9GnlWSMOiFvKetJn7En/5uG7yjf4NIirEQv14oxf3f5+xfhOfUOQninDE7BOMjQjoXMDjEOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358217; c=relaxed/simple;
	bh=pmzhT20nSauiIOnj8ZHoK6RV/jEaeeK1HB/dKaWduKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgfInzUOgzxAhskw7F30Adb77aUPXxkx0g0cbIL2mIrLSnZzLto8gt1OmPGRbhviIO9HoaE5t1FpPsZrATI6pAb7PUxFy0GInTyMY3E9I4ldNDffI/SVuRhq5JSCOONdFPmI4ZC8DSM+EJKflLqDU9qc9XUJkuX0Ko/bM3fQFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2AB341F68B;
	Wed, 17 Apr 2024 14:50:05 +0200 (CEST)
Date: Wed, 17 Apr 2024 14:50:03 +0200
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
Subject: Re: [PATCH 6/7] drm/msm/dsi: Set PHY usescase before registering DSI
 host
Message-ID: <dwda6pf5e5k2ohxexxxrqdzvcgaxp3p7g3erqoqha4ouhtvzez@dmuxgqlvyp6x>
References: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
 <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-6-78ae3ee9a697@somainline.org>
 <CAA8EJpry5Gct7Q2sAwFBVYV163X9BOcuKu9So47FEJaeXcdSaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpry5Gct7Q2sAwFBVYV163X9BOcuKu9So47FEJaeXcdSaQ@mail.gmail.com>

On 2024-04-17 11:18:58, Dmitry Baryshkov wrote:
> On Wed, 17 Apr 2024 at 02:57, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > Ordering issues here cause an uninitalized (default STANDALONE)
> > usecase to be programmed (which appears to be a MUX) in some cases
> > when msm_dsi_host_register() is called, leading to the slave PLL in
> > bonded-DSI mode to source from a clock parent (dsi1vco) that is off.
> >
> > This should seemingly not be a problem as the actual dispcc clocks from
> > DSI1 that are muxed in the clock tree of DSI0 are way further down, this
> > bit still seems to have an effect on them somehow and causes the right
> > side of the panel controlled by DSI1 to not function.
> >
> > In an ideal world this code is refactored to no longer have such
> > error-prone calls "across subsystems", and instead model the "PLL src"
> > register field as a regular mux so that changing the clock parents
> > programmatically or in DTS via `assigned-clock-parents` has the
> > desired effect.
> > But for the avid reader, the clocks that we *are* muxing into DSI0's
> > tree are way further down, so if this bit turns out to be a simple mux
> > between dsiXvco and out_div, that shouldn't have any effect as this
> > whole tree is off anyway.
> >
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >  drivers/gpu/drm/msm/dsi/dsi_manager.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > index af2a287cb3bd..17f43b3c0494 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > @@ -85,6 +85,17 @@ static int dsi_mgr_setup_components(int id)
> >                                                         msm_dsi : other_dsi;
> >                 struct msm_dsi *slave_link_dsi = IS_MASTER_DSI_LINK(id) ?
> >                                                         other_dsi : msm_dsi;
> > +
> > +               /* PLL0 is to drive both 2 DSI link clocks in bonded DSI mode.
> > +                *
> > +                * Set the usecase before calling msm_dsi_host_register() to prevent it from
> > +                * enabling and configuring the usecase (which is just a mux bit) first.
> > +                */
> > +               msm_dsi_phy_set_usecase(clk_master_dsi->phy,
> > +                                       MSM_DSI_PHY_MASTER);
> > +               msm_dsi_phy_set_usecase(clk_slave_dsi->phy,
> > +                                       MSM_DSI_PHY_SLAVE);
> > +
> >                 /* Register slave host first, so that slave DSI device
> >                  * has a chance to probe, and do not block the master
> >                  * DSI device's probe.
> > @@ -100,10 +111,6 @@ static int dsi_mgr_setup_components(int id)
> >                         return ret;
> >
> >                 /* PLL0 is to drive both 2 DSI link clocks in bonded DSI mode. */
> > -               msm_dsi_phy_set_usecase(clk_master_dsi->phy,
> > -                                       MSM_DSI_PHY_MASTER);
> > -               msm_dsi_phy_set_usecase(clk_slave_dsi->phy,
> > -                                       MSM_DSI_PHY_SLAVE);
> >                 msm_dsi_host_set_phy_mode(msm_dsi->host, msm_dsi->phy);
> >                 msm_dsi_host_set_phy_mode(other_dsi->host, other_dsi->phy);
> 
> Please move msm_dsi_host_set_phy_mode() calls too.

Ack.  Yeah, given that msm_dsi_host_register() causes a modeset and finally the
PLL turning on, these should be set up as well.

For anyone else following along, I have pasted the stacktrace that showcases
the execution flow in the drm/msm tracker:

https://gitlab.freedesktop.org/drm/msm/-/issues/41#note_2376115

Abhinav also pointed out that this PLL source was correctly set in earlier
devcoredump reports, so it might have been a recent development/regression?
This seems to be the only issue originating from it, but folks were adamant that
dsi_mgr_setup_components() (ultimately) would never turn the PLL on, which is
"debunked" by said stacktrace.  Maybe other assumptions are affected by this
change?

> Also please update the non-bonded case.

Definitely, as suggested in the cover letter.  A similar stacktrace to the above
is acquired on a non-bonded setup, which is also relying on the variable to be
initialized to 0 to select the "local PLL source", rather than being correctly
set via this msm_dsi_phy_set_usecase() configuration.

- Marijn

> >         }
> >
> > --
> > 2.44.0
> >
> 
> 
> -- 
> With best wishes
> Dmitry

