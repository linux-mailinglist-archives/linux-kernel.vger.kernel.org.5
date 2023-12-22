Return-Path: <linux-kernel+bounces-10055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 811EA81CF38
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350C01F222C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75402E84F;
	Fri, 22 Dec 2023 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbPa1MXk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CE12E83C;
	Fri, 22 Dec 2023 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so29578961fa.1;
        Fri, 22 Dec 2023 12:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703276146; x=1703880946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ygL4Wx9Bl2DM0Q4f0AKktDrprui5Ry1y7UrcnazkqU=;
        b=KbPa1MXkPoOm+cuCYly2l0vjOpzFx2cn6N5UKJmL43OvGBEs9/PVV8b0Cd1KpfR283
         /HEnUZwgXhbCFjv1rFHxbTErWDaGT0KkVz5kt5Y8MUEhIxv+MCdsKPIGDcwN5jWcbFlM
         cyOtHEYjxti2CRz/O2XaSMa3uuBdqYq3kOB2lT7NyS3xJcTBQT5CRO8ftZ3bdMTjXexA
         sA9CgznRJZM/ggCdiGaF4aZ9pDKLbUx5PbjZ69UpPPT7aFhGMqiJnGa1rmiIHY6xzMDf
         en1Gj3LW5oo+CCObfpt4ZF9BpxEeG4ekfApUTlNUarsiJUiRJXWo/yS86QyF6cT5fQE+
         eV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703276146; x=1703880946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ygL4Wx9Bl2DM0Q4f0AKktDrprui5Ry1y7UrcnazkqU=;
        b=pW+5bBDXisC8zaHbkxMITnBlaQQMbT1GilHyXdFAMMzV4Eo/b/Vftnj9227Eyp8KND
         UiB5VkF0VTZ5RabHKjz6+sn/gGkTwP8hxpJiLGP2Ql+aNVIjvVERM984x9OJjIwfXff9
         HaI89oG8+Haoa4fxxLWeSsTycEBSjyknv73OaGNy0ar7be2Tl2BoZuSeZQOZbSVGZLAE
         jwTa5O18qxxjt08Bo5Mwk+57JSNOLVs40n+O6sMuph8fXbaRYqXfacZTmumE9FT6edd9
         NP7YHx2Fn+l+yqNM4qXLkOP4En0Bbvms4gHW0SD69dpKpK7FhKxVuOd7t2URsnjGrw4R
         bAGQ==
X-Gm-Message-State: AOJu0YxMyWb2VAJH9PWOcn5GGJAJ8K5IP82v/MUZ2k/iXqtnyUvXxqHY
	gOhEpDpvoc0jhIBfV0PSg5l3rtrqr+nKdD6STkI=
X-Google-Smtp-Source: AGHT+IHFARuWO9e6tsxeCHbimi5W/lhmlrVdA5FVHtIP1NdBW8nVW3leta3TW5QGKMmBSt38nVtMR7Vr8vsyqbpDmlU=
X-Received: by 2002:a05:651c:102f:b0:2cc:6efe:6f3d with SMTP id
 w15-20020a05651c102f00b002cc6efe6f3dmr907916ljm.43.1703276146242; Fri, 22 Dec
 2023 12:15:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218155927.368881-1-robdclark@gmail.com> <k5yte4b36j23p3pfqmflhpkfesyiwoczi3avs2vavvzb3i2oct@zhssj7u5a6og>
In-Reply-To: <k5yte4b36j23p3pfqmflhpkfesyiwoczi3avs2vavvzb3i2oct@zhssj7u5a6og>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 22 Dec 2023 12:15:34 -0800
Message-ID: <CAF6AEGvGwXU5Qf-bgPfoiwDf9AdFSUERger_gk-pogOo4=hWSA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: Fix recovery vs runpm race
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>, 
	David Heidelberg <david.heidelberg@collabora.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Danylo Piliaiev <dpiliaiev@igalia.com>, Bjorn Andersson <andersson@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 11:58=E2=80=AFAM Akhil P Oommen
<quic_akhilpo@quicinc.com> wrote:
>
> On Mon, Dec 18, 2023 at 07:59:24AM -0800, Rob Clark wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > a6xx_recover() is relying on the gpu lock to serialize against incoming
> > submits doing a runpm get, as it tries to temporarily balance out the
> > runpm gets with puts in order to power off the GPU.  Unfortunately this
> > gets worse when we (in a later patch) will move the runpm get out of th=
e
> > scheduler thread/work to move it out of the fence signaling path.
> >
> > Instead we can just simplify the whole thing by using force_suspend() /
> > force_resume() instead of trying to be clever.
>
> At some places, we take a pm_runtime vote and access the gpu
> registers assuming it will be powered until we drop the vote.  a6xx_get_t=
imestamp()
> is an example. If we do a force suspend, it may cause bus errors from
> those threads. Now you have to serialize every place we do runtime_get/pu=
t with a
> mutex. Or is there a better way to handle the 'later patch' you
> mentioned?

So I was running into issues, when I started adding an igt test to
stress test recovery vs multi-threaded submit, with cxpd not always
suspending and getting "cx gdsc did not collapse", which may be
related.

I was considering using force_suspend() on the gmu and cxpd if
gpu->hang=3D=3Dtrue, I'm not sure.  I ran out of time to play with this
when I was in the office.

The issue the 'later patch' is trying to deal with is getting memory
allocations out of the "fence signaling path", ie. out from the
drm/sched kthread/worker.  One way to do that, without dragging all of
runpm/device-link/etc into it is to do the runpm get in the submit
ioctl before enqueuing the job to the scheduler.  But then we can hold
a lock to protect against racing with recovery.

BR,
-R

> -Akhil.
>
> >
> > Reported-by: David Heidelberg <david.heidelberg@collabora.com>
> > Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/10272
> > Fixes: abe2023b4cea ("drm/msm/gpu: Push gpu lock down past runpm")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/ms=
m/adreno/a6xx_gpu.c
> > index 268737e59131..a5660d63535b 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -1244,12 +1244,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
> >       dev_pm_genpd_add_notifier(gmu->cxpd, &gmu->pd_nb);
> >       dev_pm_genpd_synced_poweroff(gmu->cxpd);
> >
> > -     /* Drop the rpm refcount from active submits */
> > -     if (active_submits)
> > -             pm_runtime_put(&gpu->pdev->dev);
> > -
> > -     /* And the final one from recover worker */
> > -     pm_runtime_put_sync(&gpu->pdev->dev);
> > +     pm_runtime_force_suspend(&gpu->pdev->dev);
> >
> >       if (!wait_for_completion_timeout(&gmu->pd_gate, msecs_to_jiffies(=
1000)))
> >               DRM_DEV_ERROR(&gpu->pdev->dev, "cx gdsc didn't collapse\n=
");
> > @@ -1258,10 +1253,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
> >
> >       pm_runtime_use_autosuspend(&gpu->pdev->dev);
> >
> > -     if (active_submits)
> > -             pm_runtime_get(&gpu->pdev->dev);
> > -
> > -     pm_runtime_get_sync(&gpu->pdev->dev);
> > +     pm_runtime_force_resume(&gpu->pdev->dev);
> >
> >       gpu->active_submits =3D active_submits;
> >       mutex_unlock(&gpu->active_lock);
> > --
> > 2.43.0
> >

