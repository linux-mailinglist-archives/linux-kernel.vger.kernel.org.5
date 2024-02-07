Return-Path: <linux-kernel+bounces-56997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D1184D283
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257901F25DC8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EFD84A21;
	Wed,  7 Feb 2024 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJByh9QL"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A8685943
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707335982; cv=none; b=iuw9JfAVV2c6dojhrKJe7fL2+ejP1ByzZMBc6rtwOf3y++s/AFnmoqG9WwWOcSi4jtUuUGDajFpnTwrXOfPOFrBkYAayUoVAmjXOXdAqv84miGPqHw/J6H/bf2MEEiRRUW6d4TVnf18usHB5U0nhPSPArFHeMIBWY8esC8+d6us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707335982; c=relaxed/simple;
	bh=UkQx4KYTSb6zos+CY9uB4ZKRtoH3ayU53Ahbx0ztcHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHx6gKPCLhM8uL6F0i0BCifNLJHk2A6BUM74j/rUXh0tvCwkx2mpXRO7DLR3SU2bOdWM0P56HLSZKxmn4Dw1isjhypgQH/gNf8zZU0tGLcytm5GhkyjHuu4q1HGDfltgIngygMMa8ZuNKRmaWMoDWJyzkhgfl+FpD0uYI1mb/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tJByh9QL; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6047a616bfeso10447957b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 11:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707335979; x=1707940779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GwkfJHLn8/HfkCk/r+wwlW1fJAVG5oLG8A4VHYAkrHI=;
        b=tJByh9QLL6QLI93LI3k+Cxp8i2axsgx29j5qZRlpKPs3LnWp20rZGaPFcYOGwDP7GD
         7cqZ+Q9hUfGGSS3aI6MEq4zptxfymqLGCe8qg3BeSSBTKpTy1yxphkpmraN0Sq62WQru
         Pg6+nsILS03vvprIuJQ/q/d2TygebWj5jP6OhlU++oOcqDd8okezL4xpoquahSPDul1u
         pP1Avv4YLkYnHRLhf9jWRm9awutzptLqM/7Sz2RjIRS7EfNjaKRZCwfIOVYdiLZfvpeM
         /X0nJWNYzuAvdJ1+beUCjF55mPOR7lxlZXoL7HxUoh5broHQ1J6Gmg97nLYuXxtW5JOo
         btjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707335979; x=1707940779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwkfJHLn8/HfkCk/r+wwlW1fJAVG5oLG8A4VHYAkrHI=;
        b=lEwwojfnsMxCKfInAqW0+FDcnHJQ6BS4btQHiK4/6QMSC7prYibojF3Fm/BS9JIq3H
         Mu1ha3qwNxKskrkisDjNjW0RU0E4kI/zwVijlm0VNBmoY1Jp1+wCfkKAnRHAIvBtp76/
         n0htRzW/U5zd/cyDKqMptYiTnc3MA5Z+YM9X4PQal06q/2Nm0wo9B2lxITdHn1HVo7F4
         RdBYwzqP3VZeZwKfWRT18CmxYQR1yjgUm+MxjuI2e1Gr064UQk4xvYUr7lCmro4dg5WJ
         TtrnPvQE96qklKCaYon2ZkaMnaBsH8ET7grjO09izO8jFiVQ3Fdw3SR+W568F4xGBV4j
         CGWA==
X-Gm-Message-State: AOJu0Yyz9djafMp/QEd+mQom0ho/cCIMIll+iPSHpgUtFNebBEsvbvNl
	pIjogSm1cMkneaOnxc7c7Os3GUFnF0qwSkhIKfUyhUWSHWxoGF376vBtbaud6JCEiZMDcX+5rFn
	SHZ/8cYyXwlpNRfHPnkrDJdMmOkTlnsprOPICtA==
X-Google-Smtp-Source: AGHT+IEuEU6FhY/I616wY+eWpvyqJscoEtGa/IwbEkSleqQN6CLz65NvHcecJWfYtSCQAm6B9A1dkykyMc95djTRxCc=
X-Received: by 2002:a5b:c0d:0:b0:dc2:4f96:fc38 with SMTP id
 f13-20020a5b0c0d000000b00dc24f96fc38mr5720301ybq.50.1707335979137; Wed, 07
 Feb 2024 11:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106-fd-migrate-mdp5-v3-0-3d2750378063@linaro.org>
 <20240106-fd-migrate-mdp5-v3-1-3d2750378063@linaro.org> <89d02d5c-4af1-9f40-483f-1efb39b2a33d@quicinc.com>
In-Reply-To: <89d02d5c-4af1-9f40-483f-1efb39b2a33d@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 7 Feb 2024 21:59:28 +0200
Message-ID: <CAA8EJpro3jVPDAGWdpFiukCHTVif--Y-ZhEw=ir7U3ABsa_qbA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/msm/mdss: generate MDSS data for MDP5 platforms
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 20:25, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 1/5/2024 3:34 PM, Dmitry Baryshkov wrote:
> > Older (mdp5) platforms do not use per-SoC compatible strings. Instead
> > they use a single compat entry 'qcom,mdss'. To facilitate migrating
> > these platforms to the DPU driver provide a way to generate the MDSS /
> > UBWC data at runtime, when the DPU driver asks for it.
> >
> > It is not possible to generate this data structure at the probe time,
> > since some platforms might not have MDP_CLK enabled, which makes reading
> > HW_REV register return 0.
> >
>
> I would have expected a crash if clock was not enabled and we tried to
> access the hw_rev register.

No, for all the platforms I tested it returns 0 instead.
However this doesn't make any difference, we don't read the register
in MDP5 case until all clocks are enabled.

>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/msm_mdss.c | 51 ++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 51 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> > index 455b2e3a0cdd..566a5dd5b8e8 100644
> > --- a/drivers/gpu/drm/msm/msm_mdss.c
> > +++ b/drivers/gpu/drm/msm/msm_mdss.c
> > @@ -3,6 +3,7 @@
> >    * Copyright (c) 2018, The Linux Foundation
> >    */
> >
> > +#include <linux/bitfield.h>
> >   #include <linux/clk.h>
> >   #include <linux/delay.h>
> >   #include <linux/interconnect.h>
> > @@ -213,6 +214,49 @@ static void msm_mdss_setup_ubwc_dec_40(struct msm_mdss *msm_mdss)
> >       }
> >   }
> >
> > +#define MDSS_HW_MAJ_MIN              GENMASK(31, 16)
> > +
> > +#define MDSS_HW_MSM8996              0x1007
> > +#define MDSS_HW_MSM8937              0x100e
> > +#define MDSS_HW_MSM8956              0x1010
>
> This should be 0x100B in the docs I see.

Yes, I mixed MSM8956 and MSM8953 here. The code support the latter one.

>
> > +#define MDSS_HW_MSM8998              0x3000
> > +#define MDSS_HW_SDM660               0x3002
> > +#define MDSS_HW_SDM630               0x3003
> > +
> > +/*
> > + * MDP5 platforms use generic qcom,mdp5 compat string, so we have to generate this data
> > + */
> > +static const struct msm_mdss_data *msm_mdss_generate_mdp5_mdss_data(struct msm_mdss *mdss)
> > +{
> > +     struct msm_mdss_data *data;
> > +     u32 hw_rev;
> > +
> > +     data = devm_kzalloc(mdss->dev, sizeof(*data), GFP_KERNEL);
> > +     if (!data)
> > +             return NULL;
> > +
> > +     hw_rev = readl_relaxed(mdss->mmio + HW_REV);
> > +     hw_rev = FIELD_GET(MDSS_HW_MAJ_MIN, hw_rev);
> > +
> > +     if (hw_rev == MDSS_HW_MSM8996 ||
> > +         hw_rev == MDSS_HW_MSM8937 ||
> > +         hw_rev == MDSS_HW_MSM8956 ||
> > +         hw_rev == MDSS_HW_MSM8998 ||
> > +         hw_rev == MDSS_HW_SDM660 ||
> > +         hw_rev == MDSS_HW_SDM630) {
> > +             data->ubwc_dec_version = UBWC_1_0;
> > +             data->ubwc_enc_version = UBWC_1_0;
> > +     }
> > +
> > +     if (hw_rev == MDSS_HW_MSM8996 ||
> > +         hw_rev == MDSS_HW_MSM8998)
> > +             data->highest_bank_bit = 2;
> > +     else
> > +             data->highest_bank_bit = 1;
> > +
> > +     return data;
> > +}
> > +
> >   const struct msm_mdss_data *msm_mdss_get_mdss_data(struct device *dev)
> >   {
> >       struct msm_mdss *mdss;
> > @@ -222,6 +266,13 @@ const struct msm_mdss_data *msm_mdss_get_mdss_data(struct device *dev)
> >
> >       mdss = dev_get_drvdata(dev);
> >
> > +     /*
> > +      * We could not do it at the probe time, since hw revision register was
> > +      * not readable. Fill data structure now for the MDP5 platforms.
> > +      */
> > +     if (!mdss->mdss_data && mdss->is_mdp5)
> > +             mdss->mdss_data = msm_mdss_generate_mdp5_mdss_data(mdss);
> > +
> >       return mdss->mdss_data;
> >   }
> >
> >



-- 
With best wishes
Dmitry

