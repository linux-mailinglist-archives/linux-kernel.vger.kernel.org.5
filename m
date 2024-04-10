Return-Path: <linux-kernel+bounces-138570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154B689F3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F171D1C25859
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CCC15ECFD;
	Wed, 10 Apr 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="og5GYbOI"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1409015B130
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755073; cv=none; b=Dt/Z1E0ao+hju98NxowXRvOBVhHoAoppGyr795Lg9CIoxuFQaWNFa6i7NPR+mQVcQrWMWDUingWJ5MMQlPO44U1lA7LZtt3KW+ME8LjUoK7Ra0iylJ8Vicyi1jZ9BHjuFn9PteUMn9tP2BoFmZSTVsH2VZYLMzKmM9QwG2jfUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755073; c=relaxed/simple;
	bh=1QDD3y3qM7HlBKSXJCRxQMLwFvl5giujRZkYMfTxqO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JszPSxHixgBjSrDsO6Zva/ijMyZLFir4RD+rKYEG0qDFQwFNBqPCmDpcCWnln4NMCG68zEu/UHFT6DYg5OE/SmHwm16LHHRBjhrFH7jxgshnubdmep2XvJuJT8nr0lIQO8S7FWFZVBoZP4Gsaf3xCHJEf+0obFPxQB7pWI4WoA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=og5GYbOI; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-614b02f8ed6so66561167b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712755071; x=1713359871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aaut2pBnJQwsZ84leifBiD3Jd/zh/CW3q55Aw0Cq/FM=;
        b=og5GYbOIbXh6aNiBj5nSUonq+00pedMYqiVKpfMvDDvTrVykmaRZScxNh+AsiC+QWm
         +u62HkSXBJG2GzRzBpp3dYbHrpFM85KjbLJrzJOqjYMrheZAyzLqk2KAJGrx5x/EChoO
         ZAsfvIT82I2fushCahd+yAJ5LAjbdlK0uXnZ29k+h8HJ3xChwQgf2SSf0ViVqt6U7byL
         IqsltI2O7/kmykWsuZ6W2xY1a/tzjGrUXmvVzYUn/Vo4iIPcdADk7bZWW52ldzpIddk8
         5bG5Z4OUm2hxFs1aiU3RzCS76pJR/xHVmSgOa1sAFxwNPQYDEWP/PkTzx1c34Y1h9JE2
         fsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755071; x=1713359871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaut2pBnJQwsZ84leifBiD3Jd/zh/CW3q55Aw0Cq/FM=;
        b=Xn9pxFKowcm4KTu/Dx88BJBMMvsg8uiZX+xf21FQzEnH0I6ak7M6rr74Gt5ik1o5n8
         HZWGVYlm026o/ER14hsJ85lDT+eI8zoGaoMrHAh9sfOpwlAOV/pLAIoH20yzIvCRJ8Mc
         J3r1zXR4u1mpWgCXl1nTTuVQWXc/tbedyvqEwGCpzGAcVP27pU8OhhUwRPnLzav4lkQe
         FOuHb4ngjpngH7Momb3BJgc116M4uGeLfc2fNqd0vyqr0fITdW3zxCiCFTiv5zcHju9b
         xHVo/tYFqyX5P+e6HsUrL7+zi1W0cbU6G3NOpgdQtwuHesOVucc9PPxcEoe43PfunRg/
         ZyMA==
X-Forwarded-Encrypted: i=1; AJvYcCXgkZwCoXfnH3PcUm4uil4M3fYvpG3hhwwcIx9WsSNBzDpblZ5/ntbuFlCxn5UIzcBOBe6ywuSHOtSuRN/AyGT4UtVWbiMkFz4H3B3d
X-Gm-Message-State: AOJu0Yz+DR3QoTf6vxtK6OF90p2ydhSI8aQ7lb1tbKecIFg8327EqN0F
	IQeqYLx03ERLU8W21i/neAuq3KafgjU5E/DusS1MRNoKFK2T4AeffjskDNRLB1ClK47f776A+zW
	+f4Elx4wjF4pF2PDfCHM9mWPj1CBQLPwFgm29Lg==
X-Google-Smtp-Source: AGHT+IFmS5w8AhK8kbcytc2bVAvW9AcSbo4jeQurDEFNC0cSxmV8ZNFN2AK5/kDoM6WitX7Tu3IUL/kE2njb2JKBLgs=
X-Received: by 2002:a25:8b08:0:b0:dcc:623e:1b5d with SMTP id
 i8-20020a258b08000000b00dcc623e1b5dmr1525941ybl.31.1712755070932; Wed, 10 Apr
 2024 06:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408085523.12231-1-amishin@t-argos.ru> <CAA8EJppTM4tpsFaZKupPe=0Oc9qDp7dBqHyHGP4E5bTHKT=hSw@mail.gmail.com>
 <2b06e6b2-6fa0-48fa-800b-7aad6735daa6@t-argos.ru>
In-Reply-To: <2b06e6b2-6fa0-48fa-800b-7aad6735daa6@t-argos.ru>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 10 Apr 2024 16:17:39 +0300
Message-ID: <CAA8EJpq2=wFEY6GnKBHqnXPdrMs-g-iNuT=DaJddKbFCyBb=Sg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Add callback function pointer check before
 its call
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Stephen Boyd <swboyd@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 14:53, Aleksandr Mishin <amishin@t-argos.ru> wrote:
> On 08.04.2024 12:03, Dmitry Baryshkov wrote:
> > On Mon, 8 Apr 2024 at 11:57, Aleksandr Mishin <amishin@t-argos.ru> wrote:
> >>
> >> In dpu_core_irq_callback_handler() callback function pointer is compared to NULL,
> >> but then callback function is unconditionally called by this pointer.
> >> Fix this bug by adding conditional return.
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > This should be converted to a proper Reported-by: trailer.
> >
>
> It is an established practice for our project, you can find 700+ applied
> patches with similar line:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=linuxtesting.org

Is there any reason why your project doesn't follow established
guidelines? Compare this to other robots.

Anyway:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> >>
> >> Fixes: c929ac60b3ed ("drm/msm/dpu: allow just single IRQ callback")
> >> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> >> index 946dd0135dff..03a16fbd4c99 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> >> @@ -223,9 +223,11 @@ static void dpu_core_irq_callback_handler(struct dpu_kms *dpu_kms, unsigned int
> >>
> >>          VERB("IRQ=[%d, %d]\n", DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
> >>
> >> -       if (!irq_entry->cb)
> >> +       if (!irq_entry->cb) {
> >>                  DRM_ERROR("no registered cb, IRQ=[%d, %d]\n",
> >>                            DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
> >> +               return;
> >> +       }
> >>
> >>          atomic_inc(&irq_entry->count);
> >>
> >> --
> >> 2.30.2
> >>
> >>
> >
> >
>
> --
> Kind regards
> Aleksandr



-- 
With best wishes
Dmitry

