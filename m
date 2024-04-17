Return-Path: <linux-kernel+bounces-148123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4296A8A7E09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5FC284A19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301D07F479;
	Wed, 17 Apr 2024 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1RmVZYp"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC37D3F0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341952; cv=none; b=LjfBir4vRV4k9sxwq/yav/lgjLVnDLuV5+61Cq3E0OG0eXSJ6AuNH5V57ho8Y6f04M/THlfqeWFd9MqF9np2HZZDn8w6EM8h+zqZKIMYe2uqPQIoCN6TzK3LepFLCfA2d9sJdJ7nvxv3qx1qqhWHsz04+Ufgde1TCx9SP3gOUbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341952; c=relaxed/simple;
	bh=lDaoE5I35Sw8X4gTfjGCdgl4sZqMgly1ov1PL+Jq3Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTgWUyP/1Ca9u6NJQoGSqNiHLyy2nEGIMkO89UXw15j8OrgcQatIkiNqMpxwDuiXB9/+EdQ0y6SFtk5ttNi8DOj1yjNFAmYMDbuGvCZnPLvGfPCqA6eivid3+r+yT2bImTazyErYA+mThyjYh0dYlsUaumIhS3imC5clFi5vcQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y1RmVZYp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6150670d372so48026507b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713341950; x=1713946750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3LRcCO7G0BAlsPsSHwaDpD7NJg45TvAyn9+yoAIm8Y8=;
        b=y1RmVZYpbukWu0GnYfSD9kz0+CsF1ty3mbs6pqJJpqMqFuQVySjdt9bHm4323SwDm/
         uR9NNaLFWYxNuVP+jtgeXt0RR0TIsZIWXPHiTRFilNIcNLtepzFjp1aogA0ifXjwRRtP
         6j7PCEnJ7r8tFzRB1h9jbAHCXieJhzfSEvucOOceRGnP9MXcPnP2X6Wbdt710VD4uO7q
         7i3lWEUoSNh197YHlzBAfqR8op1ndiUn9a1eiiJzWBX3jebkkWZo35Z0DpzJEywNXueJ
         RDTK0JzWAPZD8SBMW5lU+qsx+Ar3cpvCvL+wF2G/W+asVraJhcH/hdiNJKPqN4jDDlGt
         Q0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713341950; x=1713946750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LRcCO7G0BAlsPsSHwaDpD7NJg45TvAyn9+yoAIm8Y8=;
        b=fivNIvsT/Wnr08O0msMzAHPMWNhzew6wDYjqwOien4WP3aCtdSfTr/ok9gp1o+TnSd
         3RThxK5tygewBgRuAtBhSo372x1zSTOJfjlULLlbQSVx3ysFOp1zEYBGs7AtyTfHS4CD
         S+Hr70bXZwYEVwPA2tDIxCPB6MQKeJNnUwP1fDXAjuTc7hF5l669h4BqIGaaApeuTJIv
         KC79tVX/iGIWL35es5FrtQUkqIYRoIZKPu5Q/TQrSQ18Ay3ydbQtP4RsMYC9JTF6cgEm
         BJYcg4BDJc5AT+mDGWIHZMmfxzeu7EVFmmhWXzsJ7f1V4sQR841uPuVaB7GoIDb+LBn5
         HdNA==
X-Forwarded-Encrypted: i=1; AJvYcCXhlJUyFXxF7xHk+GewfIQORDTEHubwoAK6A2TcrS8hZ741S7+IfZZeD+7P6Hg7QBhVH73QxWvw8KZpdIlYqx+tZBbSKdzgFG7gfKVg
X-Gm-Message-State: AOJu0YyVjStego/1/elWiZwoiTno6agEqvtApzEAWRFgGVMWwthatuHT
	hB7pJS7SEMbr8aS9spZYHkuSte+oXDk73XiC3zAhEbb0Fk6hxBKSXaZJZPuVt6Z2Agd6sruNV4C
	1AO9wSxtcHsauh7xW6KEub9Xj1U91RtW5mx6xcg==
X-Google-Smtp-Source: AGHT+IE2lKg2BSkdW3aFZxTMV4gr/x3dbq3U7YbGvWBPNOlVvmP5HPCh/lfty+hy19RjhqRJv46ueaHdDZUJSm/+bS0=
X-Received: by 2002:a81:430f:0:b0:615:1e99:bd6e with SMTP id
 q15-20020a81430f000000b006151e99bd6emr14355086ywa.35.1713341949713; Wed, 17
 Apr 2024 01:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
 <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-6-78ae3ee9a697@somainline.org>
In-Reply-To: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-6-78ae3ee9a697@somainline.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Apr 2024 11:18:58 +0300
Message-ID: <CAA8EJpry5Gct7Q2sAwFBVYV163X9BOcuKu9So47FEJaeXcdSaQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/msm/dsi: Set PHY usescase before registering DSI host
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Archit Taneja <architt@codeaurora.org>, Chandan Uddaraju <chandanu@codeaurora.org>, 
	Vinod Koul <vkoul@kernel.org>, Sravanthi Kollukuduru <skolluku@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jordan Crouse <jordan@cosmicpenguin.net>, Rajesh Yadav <ryadav@codeaurora.org>, 
	Jeykumar Sankaran <jsanka@codeaurora.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Martin Botka <martin.botka@somainline.org>, 
	Jami Kettunen <jami.kettunen@somainline.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 02:57, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Ordering issues here cause an uninitalized (default STANDALONE)
> usecase to be programmed (which appears to be a MUX) in some cases
> when msm_dsi_host_register() is called, leading to the slave PLL in
> bonded-DSI mode to source from a clock parent (dsi1vco) that is off.
>
> This should seemingly not be a problem as the actual dispcc clocks from
> DSI1 that are muxed in the clock tree of DSI0 are way further down, this
> bit still seems to have an effect on them somehow and causes the right
> side of the panel controlled by DSI1 to not function.
>
> In an ideal world this code is refactored to no longer have such
> error-prone calls "across subsystems", and instead model the "PLL src"
> register field as a regular mux so that changing the clock parents
> programmatically or in DTS via `assigned-clock-parents` has the
> desired effect.
> But for the avid reader, the clocks that we *are* muxing into DSI0's
> tree are way further down, so if this bit turns out to be a simple mux
> between dsiXvco and out_div, that shouldn't have any effect as this
> whole tree is off anyway.
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_manager.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index af2a287cb3bd..17f43b3c0494 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -85,6 +85,17 @@ static int dsi_mgr_setup_components(int id)
>                                                         msm_dsi : other_dsi;
>                 struct msm_dsi *slave_link_dsi = IS_MASTER_DSI_LINK(id) ?
>                                                         other_dsi : msm_dsi;
> +
> +               /* PLL0 is to drive both 2 DSI link clocks in bonded DSI mode.
> +                *
> +                * Set the usecase before calling msm_dsi_host_register() to prevent it from
> +                * enabling and configuring the usecase (which is just a mux bit) first.
> +                */
> +               msm_dsi_phy_set_usecase(clk_master_dsi->phy,
> +                                       MSM_DSI_PHY_MASTER);
> +               msm_dsi_phy_set_usecase(clk_slave_dsi->phy,
> +                                       MSM_DSI_PHY_SLAVE);
> +
>                 /* Register slave host first, so that slave DSI device
>                  * has a chance to probe, and do not block the master
>                  * DSI device's probe.
> @@ -100,10 +111,6 @@ static int dsi_mgr_setup_components(int id)
>                         return ret;
>
>                 /* PLL0 is to drive both 2 DSI link clocks in bonded DSI mode. */
> -               msm_dsi_phy_set_usecase(clk_master_dsi->phy,
> -                                       MSM_DSI_PHY_MASTER);
> -               msm_dsi_phy_set_usecase(clk_slave_dsi->phy,
> -                                       MSM_DSI_PHY_SLAVE);
>                 msm_dsi_host_set_phy_mode(msm_dsi->host, msm_dsi->phy);
>                 msm_dsi_host_set_phy_mode(other_dsi->host, other_dsi->phy);

Please move msm_dsi_host_set_phy_mode() calls too. Also please update
the non-bonded case.

>         }
>
> --
> 2.44.0
>


-- 
With best wishes
Dmitry

