Return-Path: <linux-kernel+bounces-15880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC5A8234E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C6A1F256BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589651CA93;
	Wed,  3 Jan 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeI406Dh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1301CA84;
	Wed,  3 Jan 2024 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cca5d81826so129221071fa.2;
        Wed, 03 Jan 2024 10:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307749; x=1704912549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSwdtsY61fYy46M5QE5KizBE3QaiBoSxLHAq5Tnp4Uw=;
        b=BeI406DhtL43bJdoswKGH9lYnxQg8I2S8m+gN/oP0d+Bts86WkJnjKvkHR3Zup7Bpl
         XNPzQr183n8N9soX/l+KKUg7kMjIZHouuPzJQ8WKvE3xKlCqBoEunD8anjRLyP1aa+Ve
         ro9Y9YVqqrcqSKI8EOFPC/YdqNMen6+EuHRcUGZE/11DgpoVSM7JfQgW78PP9RsfhHla
         WnJdgXrq9kmPOE687UxbLz+g6Pwupc+3Vdl6o7oiay8rlaTWPg3gdBWtQu0uAc0wW8vd
         fJDnDjM1xxXDKe2LtdEsr7b/7kRh00ccNhzfhsB6fuudYayeytqwYuggv/DRNEQU7UCV
         BfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307749; x=1704912549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSwdtsY61fYy46M5QE5KizBE3QaiBoSxLHAq5Tnp4Uw=;
        b=bMatfZnjyly7FG+XvvFanyGEQFrLTvTvkh7KjYo8aMFZ9Ew7o28o/c+Y9iOFSFhf4J
         OWXfAcRJYP3FxiaHMPRlBVFEVNc1m4FaLROG8/ZhMe1NQeKwEq8pTDxC+IHg194zGbic
         UIDl+2R/oaUGPPEyCO8/F0w1e+sRqaHxfWXC7lw0BbIVV8HNg3nMgjhjidZj2PVa0a7e
         /4skkTh2JDrMLm++E33TGpnSSH06pE57aLEE7qzyRcYGKTiry/5nx2dtDUtUQel3zCNE
         qxiD9mXEXkTDV3DED25xfy69ih3e0otxfmextHJSbiYzCwG6HCnQ/aF7RtEippyVttf1
         /wDQ==
X-Gm-Message-State: AOJu0Yx+n3aDalVLWEAypzDhd0WTFrX0BDNEYjWdFbdcYy//r0NtrQH5
	giKzD5zQXDLVMBvsbhp/MrzPQOpLzMorxfzJ5I0=
X-Google-Smtp-Source: AGHT+IG+OC/fH5CHJHM4KYYgGuSRIAloVFSbQRrYKWlazIMzUbmSodkBi162LLgz+u6vZOa9YXsBO0vakCfp0mrOPbY=
X-Received: by 2002:a05:651c:4c6:b0:2cd:dfe:74bb with SMTP id
 e6-20020a05651c04c600b002cd0dfe74bbmr2277411lji.49.1704307748788; Wed, 03 Jan
 2024 10:49:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102193348.250917-1-robdclark@gmail.com> <fd88a067-63f6-4467-9787-989890287083@linaro.org>
In-Reply-To: <fd88a067-63f6-4467-9787-989890287083@linaro.org>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 3 Jan 2024 10:48:56 -0800
Message-ID: <CAF6AEGtk7qS5hPYDGKVnrcEfcQEkr1J4=UTL7sikVJB3AvDBFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a7xx: Fix LLC typo
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Akhil P Oommen <quic_akhilpo@quicinc.com>, Danylo Piliaiev <dpiliaiev@igalia.com>, 
	Bjorn Andersson <andersson@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 12:12=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> On 2.01.2024 20:33, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > We'd miss actually activating LLC.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/ms=
m/adreno/a6xx_gpu.c
> > index a5660d63535b..54dc5eb37f70 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -1646,7 +1646,7 @@ static int a6xx_gmu_pm_resume(struct msm_gpu *gpu=
)
> >
> >       msm_devfreq_resume(gpu);
> >
> > -     adreno_is_a7xx(adreno_gpu) ? a7xx_llc_activate : a6xx_llc_activat=
e(a6xx_gpu);
> > +     adreno_is_a7xx(adreno_gpu) ? a7xx_llc_activate(a6xx_gpu) : a6xx_l=
lc_activate(a6xx_gpu);
>
> /me cleans glasses
>
> oh..
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

I suppose I should also add,

Fixes: af66706accdf ("drm/msm/a6xx: Add skeleton A7xx support")

> Konrad

