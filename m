Return-Path: <linux-kernel+bounces-71254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD16985A286
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D651C21FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61AB2E832;
	Mon, 19 Feb 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHlmVRVs"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28F2E645
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343582; cv=none; b=gRAYuoXYp2Gs+WUAmczxuEos0utukrielPbFetVzqFmo8m1efGKdCTfUXx4AfPUFPbp5DlUgHg3jqCPpLYajZl8e6Y62457LjI3kFZoP4JgrBuWFtJ66H7PeI4booKgcsp9stp2xgC3cJBW1U8OdB6DzEEc4W2WXRx/c7F3/vR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343582; c=relaxed/simple;
	bh=psLxC6s9LHoyLa6JFtDB3Lh1RZsR5Kss2pXXzs/r4iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejiHvnNyrNgaBLVPAMRIFIwnNzirOl3qBY8bVRgOeKAGAl+rOWK9TxHhh6oZ6PZ1Ft4X6zNyxSt+dLak8C1IYGPSd74q2tIjOwZu11da6Ke/l1P71y1hy9e3QRdY97ltv6aJJMmWuQ0Nz+4pGs6apEwswotK221BzuHbK8u6j90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WHlmVRVs; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so3574898276.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708343579; x=1708948379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eDlnERxsGwtLXki6krZHreIryztOLvxcnQnuu/21/BE=;
        b=WHlmVRVs0RxyaTX9lCDGXBbBcS3spZQ28Rt+fU70oFTsdWz85VoXZfakojk+g44EUm
         6rgvYh6orQjTvMIObP/joX5DO+o8WRXLjdE8tBmwx1dN+xwzPoC9Lg1ZxKFIxIjw8bI6
         ERpoufPL8GcdsqJOWXLVpzoIUWS3334N9pDd9LhYiqdDDAMHz5z1qXpI8E8NswOiPQ85
         GYuT2/4pA4Of/rQDZUpwvujkskiq1grB2feKfxKqbWlEZCJfw0a6bgz+GEJ2WB5lEn+4
         xNAhKPX4QmJ88UYxMOmjOjBYSOwjMHj9SaLr1UPolMdEzu/gfa0ydNsbPaG66yfbUPKK
         zzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343579; x=1708948379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDlnERxsGwtLXki6krZHreIryztOLvxcnQnuu/21/BE=;
        b=jTqHGprJLm1LVL/rpiSPE+QtEgbYopqeGA5ckQkCIi8GdWhxQ8OQklvSRNuv/aT1z5
         O4A8jqFrUYWmPwNdIaYbFk2wVtU42l9u6Q6iGqTZv0hvikKsb1of7CvzipwQwZ71YA/C
         yP6oQwY6cCrNkUZlZZQuSbGW1MluJn/i0VVs5xOKY2RJoyKY0Nw4SKZSvrUpRCHoPXlp
         eTKGl/S1iyrBJwU3c0RMJ++3pUjgxTfryueCrimgYWUepI4oRzbkgRsjD3u1pHmrvPHk
         AiZMkgjupypLXJuaBiMOTqQ123y5Rn8uou5xpNu/FiISy+fIK0utJxzWdmTQ/bthIEDL
         jGiw==
X-Forwarded-Encrypted: i=1; AJvYcCWYXsHwJ8ArXjH2hWlXdy/GGZsBtyL8Y6jUBHhy55RzvBiGzhzeiyNWomMum/oIHXpS6P3oqy2Ikjz9XCAC6H6OdUi6bEzHtCAEp6wJ
X-Gm-Message-State: AOJu0YykHvRDM0eJCuv1EcQKFknPnD+s3TvgWfUpt261vJ1Qyy4aLuUg
	S3DMiDehZ5Lb6z1Rjnsh8etHMFpaphXmlrCWVgFS3S27NuORZOTlOqTSZJ/yNdhbBAaDKRkG71G
	bEHimnnVYIA1vINzUAERSJ+qjVSryxTV1yg3ZxsNEvD5ofnZa
X-Google-Smtp-Source: AGHT+IEPnDswYQFtDH941jPPgVJlGCvd1CpCQH5qqUk8Fa/hDLMhAwQb5bV+etm3XhmW+ddV9H3F2J9t1vD4jdi3+lU=
X-Received: by 2002:a25:b322:0:b0:dcd:2aa3:d73b with SMTP id
 l34-20020a25b322000000b00dcd2aa3d73bmr9660313ybj.50.1708343579395; Mon, 19
 Feb 2024 03:52:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-fd-dpu-debug-timeout-v2-1-9f907f1bdd87@linaro.org>
 <1cb90bff-ce5b-c6d1-a3df-24f6306f833a@quicinc.com> <CAA8EJpotiHKT_NYphDs0-vhpvsybgTW281XDYbteUx8qOX=v4g@mail.gmail.com>
 <63bba15b-6d8d-5ba8-d99d-8cd2dd763262@quicinc.com>
In-Reply-To: <63bba15b-6d8d-5ba8-d99d-8cd2dd763262@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 13:52:48 +0200
Message-ID: <CAA8EJpqHmVBry9FyJ6HRB+qdVcVNN3Q7rHZz1daZL1Sz6yeZ=A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dpu: make "vblank timeout" more useful
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 22:36, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 2/14/2024 11:20 AM, Dmitry Baryshkov wrote:
> > On Wed, 14 Feb 2024 at 20:02, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 2/8/2024 6:50 AM, Dmitry Baryshkov wrote:
> >>> We have several reports of vblank timeout messages. However after some
> >>> debugging it was found that there might be different causes to that.
> >>> To allow us to identify the DPU block that gets stuck, include the
> >>> actual CTL_FLUSH value into the timeout message and trigger the devcore
> >>> snapshot capture.
> >>>
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> ---
> >>> Changes in v2:
> >>> - Added a call to msm_disp_snapshot_state() to trigger devcore dump
> >>>     (Abhinav)
> >>> - Link to v1: https://lore.kernel.org/r/20240106-fd-dpu-debug-timeout-v1-1-6d9762884641@linaro.org
> >>> ---
> >>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 3 ++-
> >>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> >>> index d0f56c5c4cce..a8d6165b3c0a 100644
> >>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> >>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> >>> @@ -489,7 +489,8 @@ static int dpu_encoder_phys_vid_wait_for_commit_done(
> >>>                (hw_ctl->ops.get_flush_register(hw_ctl) == 0),
> >>>                msecs_to_jiffies(50));
> >>>        if (ret <= 0) {
> >>> -             DPU_ERROR("vblank timeout\n");
> >>> +             DPU_ERROR("vblank timeout: %x\n", hw_ctl->ops.get_flush_register(hw_ctl));
> >>> +             msm_disp_snapshot_state(phys_enc->parent->dev);
> >>
> >>
> >> There is no rate limiting in this piece of code unfortunately. So this
> >> will flood the number of snapshots.
> >
> > Well... Yes and no. The devcoredump will destroy other snapshots if
> > there is a pending one. So only the console will be flooded and only
> > in case when MSM_DISP_SNAPSHOT_DUMP_IN_CONSOLE is enabled.
> >
>
> Yes, true but at the same time this makes it hard to capture a good dump
> as potentially every vblank you could timeout so this destroy/create
> cycle wont end.

Excuse me, maybe I miss something. On the first timeout the snapshot
is created. It is held by the kernel until it is fully read out from
the userspace. Other snapshots will not interfere with this snapshot.

Or are you worried that snapshotting takes time, so taking a snapshot
will also interfere with the vblank timings for the next vblank?

-- 
With best wishes
Dmitry

