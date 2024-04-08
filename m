Return-Path: <linux-kernel+bounces-135099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A654389BB26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A83283BC0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BEB47F7C;
	Mon,  8 Apr 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UdxL14xH"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172747F48
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566997; cv=none; b=jqRwzyc3Ph9pb+pP5rPMUt1XNLlRxjDU+o39N6LWFZ6OWkZ7FtrqqSFQB9Yin+m+0GDpCgJi32qKBiCSbxUl/LIsACwRc82L174+AssGlB5V6yx8HGsM8zZj5PbQrw1zeCPo0P79wVyXJ1ElM83GYA8eSaW4VBTOpJyve5trwBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566997; c=relaxed/simple;
	bh=5pJi876MPxKlZmvwxtA6hQBBCKOCbQkd0UdHGkb24lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfPw512B5U1AQYtoOWq1vk0FPf4wH89ZHakHkuJTqNqoDZrMXvg9Vct45Gmr/5ixVLk5S27BseKR3fg2+sPg7HkYI+yq6bf8XyjpaPZuNIstfAYkMKqbT1LaP8Xi0cIebFB23q5JYqv+wYsUF4IEDWnUU6qEh9rr49OJPhJqANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UdxL14xH; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso3318471276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712566995; x=1713171795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aCQgRHW7r77MxQqZTezP2GVYmRv+i8mKc4OgUigdufA=;
        b=UdxL14xHLrB/TLyngQCvyxrXWXguDByPkud8hW/s+H1N5N2MImT48dSBQ4t/pd4J6L
         t71e8kRZwQtNhvvXCPOb05OF6SqPI/8YP6eFQy73bRcOvqAkpoDL1xAMrvr/nqJdQ13+
         Q/OtK9Sdj1rhy3Hg+snq92/c/uriiAjNzbjzcwF2FNyhDxP3Or0svbxu0/CkUFCEFpvK
         kjb1QFnuloGBpc9KjzNFts8IOYc+SKivDWCr45DnLcPO/7JwqneVauUQZ3juC0tPnB1g
         S9UiEPjoQu6a3G9X3LasvfBFWqJwvaiX37Db7RtVmGBw4GMziwlCYHp+bIPTFR7QoxzN
         H4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712566995; x=1713171795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCQgRHW7r77MxQqZTezP2GVYmRv+i8mKc4OgUigdufA=;
        b=w86wVtimoyHerRE+HUbjKN765uvIPnZk455DGxhXThgg5OFeA02sHIPHB1P7+7agcq
         oT4CefK7ddSHLTcP/B/2WIDTLd2lvR2lZw2SxuzyLosR5IaGfH1ZOt4BZ5GtlOKh36t+
         MCGQSV8OuCibPZJlCCPo9+ijxGXgcCzb19QoLAJf+iwi0n480cKogQ9G0rg6znwhMf53
         AcvS4lVo5UluCZFXdOHNMUV2/zbANeeLcELojEJtmvvJLQjcRa+QR04j1FjZjMY9Wugy
         wz7XVpnah25zpOIX9wlNllU2eLhG71eal6FE9dWOBpo8D6r05RSC3lm08LDIWI2x6hE5
         mWlw==
X-Forwarded-Encrypted: i=1; AJvYcCWQmb31LNPDNk+1UzvJfFJ1+IrDNSadDDBjlkPdcmDuDIWKnBZX16R0Kv8EyueIRz3I8ImpOBkONK6an/ywcIsh3tfQmPfCPtLuIb8F
X-Gm-Message-State: AOJu0YwV/IdDzpPa03iowT72n8K+2gnrPVuNRSjV8ThA4wmaXXmHaZfM
	JvL50r31DnJCv3b4hPDAGjSI+5ojjNIAWvmhKTYeuzc0IxBWG68wrFDjv+g6HBI+2p6CttXqyJT
	pemQ3g2fs5mt7WgEPvJNldfgndbjyuWsw/kcI+w==
X-Google-Smtp-Source: AGHT+IFZJ9m4KwrMQclgS3pdMGserVsWA/uepMAkYkmTnJlObRmstHDdU51+G69xsZ5HR/xHo/fjR/LGWzIt8jOomIE=
X-Received: by 2002:a25:6ec3:0:b0:dc6:d258:c694 with SMTP id
 j186-20020a256ec3000000b00dc6d258c694mr5932139ybc.19.1712566995186; Mon, 08
 Apr 2024 02:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408085523.12231-1-amishin@t-argos.ru>
In-Reply-To: <20240408085523.12231-1-amishin@t-argos.ru>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 8 Apr 2024 12:03:04 +0300
Message-ID: <CAA8EJppTM4tpsFaZKupPe=0Oc9qDp7dBqHyHGP4E5bTHKT=hSw@mail.gmail.com>
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

On Mon, 8 Apr 2024 at 11:57, Aleksandr Mishin <amishin@t-argos.ru> wrote:
>
> In dpu_core_irq_callback_handler() callback function pointer is compared to NULL,
> but then callback function is unconditionally called by this pointer.
> Fix this bug by adding conditional return.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

This should be converted to a proper Reported-by: trailer.

>
> Fixes: c929ac60b3ed ("drm/msm/dpu: allow just single IRQ callback")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> index 946dd0135dff..03a16fbd4c99 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> @@ -223,9 +223,11 @@ static void dpu_core_irq_callback_handler(struct dpu_kms *dpu_kms, unsigned int
>
>         VERB("IRQ=[%d, %d]\n", DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
>
> -       if (!irq_entry->cb)
> +       if (!irq_entry->cb) {
>                 DRM_ERROR("no registered cb, IRQ=[%d, %d]\n",
>                           DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
> +               return;
> +       }
>
>         atomic_inc(&irq_entry->count);
>
> --
> 2.30.2
>
>


-- 
With best wishes
Dmitry

