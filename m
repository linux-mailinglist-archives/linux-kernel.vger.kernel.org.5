Return-Path: <linux-kernel+bounces-80290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1485E862CF5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A53BB20F14
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4DF1B81F;
	Sun, 25 Feb 2024 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZarA5qr1"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0243211
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708894693; cv=none; b=GlLLiLDt9dWIWnV/AW6H+N499Ov8X7HxRYSpk1litUkjPgS4Gy36rQOvDIlpIaDB1QfqOhkF/rZ2JiO6vVqEKDMsPCuCZL6yv0vFD7AweeAcVxECsIhPT63KnVAVJ5WcwT7/EMZVaZb43gvY0Zayb+Yv9R1VTyyqcaacqHqB1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708894693; c=relaxed/simple;
	bh=G+uzBfc0oWDDkEEUN4eppnhyRsmAuktqvDC/SDyC9Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTDkKHQxWb0BR7N/9ggCrBJRC/Of0OFwm772DVCWoPWlE1HsUH3v6VXaoB5Vi+VvtRkl0S3rx/vIKOs1FKyvP+0FFl2RCFyz3pCiV9imSA2BtTKR52gxghq6ceBaWGzOUth/FfOQWGlqts3FUXhHUys+N7abW+JWK5dNz6RwGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZarA5qr1; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bd72353d9fso1637346b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 12:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708894690; x=1709499490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qysAaItgkYAq3SwTLN3VU8RMWCs5RzMALqFImfrNUHc=;
        b=ZarA5qr1BcJEZ66LeYGbNSR4LavrNBD/R/gArih58MqLw9v1LAL6MLB2Z40fAj+CbR
         5pCtvDAJfQ3jphlpCeS0oGM1EHBPCDYd97SaWKG8YPVemzkPuVhSpLoy19e3xHfzxHMw
         7IYkdeiiwOLgZlsn0m6d7paAemF2PFyQ9r3khJ4UdjoQMBS4mx4SKHgOlk8VPpr3/iad
         /rBk/qivgxHPbKqsYR4FsoK0nv0n24AQChEWJj1YAUNkQHGlen8L9400kb88R9bv8qtT
         r+LWXeTETvCp+CPKgU2po7i3RnjySI6RnBAhEL32V7dQ9S8UyJsumb1vjCXs0I+goGap
         TqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708894690; x=1709499490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qysAaItgkYAq3SwTLN3VU8RMWCs5RzMALqFImfrNUHc=;
        b=r79m0KvUpZEA0WQsMQjhGbdA/t6xnDA85ajbrLfQH9GYeld4kAkc0tkltWdqXbuEz9
         k0Lqx6K4n3zLabzVV0169CSf198lLzJwgkS6d3oXhOX12bbrOKicIkIS4AVdxtzuGxUf
         /DuciHMKx8kNe5bTlyChgS4BVTy6/QjizWykVCtPdKrZyfB9lq9iT6Z13y7xRlzajujO
         k+NyLlNLehgnRh1GBkyAxnvyzm7k5I1TuDSjlq0PCpHv5o+wthy1kpiiqw25mQOyrf/G
         RZuLyxkd0MW3tSujHwn/ZDJ8VxBR8BxD6OmDygJ3Ah65UAPdmy+gQ9fJj2nT8x4CljSP
         z4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwJqbq1+c/HB35D57PbN6IwXn2eYsCLWBZkwsDxRTsRZmt0xijSExMUiVzHh3TdRHvzrAePBhGBEKJnepAGRGlc/bWKEeFyVx+xs3M
X-Gm-Message-State: AOJu0YxdBaAqS+11Ki5nhl99iEDnVjMglNiArtuTkfgYWJWVlanZNHSP
	wAG4UYYdYd52y0fcub3EBa533L76oroCSigwxLKFSVr2Lb5dfdeGtF8XFKKYp6w/6F1lvfypsm9
	bA6/7kPWky5XTNOV8VoUpE1Eos6UAtoqSp/wmwA==
X-Google-Smtp-Source: AGHT+IGLGLisc5bGf0HFG5iW6DFVysNuOika0kCxYs9Y52QBjZwPvU+tzTIDfoHJBRVgLI2wQUZxeL5lNMXPdzykdcM=
X-Received: by 2002:a05:6808:394a:b0:3c1:862d:7e2e with SMTP id
 en10-20020a056808394a00b003c1862d7e2emr6525742oib.50.1708894690053; Sun, 25
 Feb 2024 12:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225-fd-dpu-debug-timeout-v3-0-252f2b21cdcc@linaro.org>
 <20240225-fd-dpu-debug-timeout-v3-1-252f2b21cdcc@linaro.org> <4e6b41f4-27a6-4c65-dc03-67437a9716ed@quicinc.com>
In-Reply-To: <4e6b41f4-27a6-4c65-dc03-67437a9716ed@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 25 Feb 2024 22:57:58 +0200
Message-ID: <CAA8EJppNfdDsrMQA3cUR18b2so2qaw1fcFNMz0fW9rMSzFrysg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/msm/dpu: make "vblank timeout" more useful
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 21:44, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 2/25/2024 6:12 AM, Dmitry Baryshkov wrote:
> > We have several reports of vblank timeout messages. However after some
> > debugging it was found that there might be different causes to that.
> > To allow us to identify the DPU block that gets stuck, include the
> > actual CTL_FLUSH value into the timeout message.
> >
>
> the flush register shall also be part of the coredump in patch 3. so why
> is this needed?

I'd prefer to keep it. The devcoredump captures all registers, while
CTL_FLUSH points to the actual bit without the need to analyze the
coredump. At the very least, it allows us to analyze whether the issue
is the same or not (compare SSPP_DMA2 on c630 vs LM_1 on sdm660)
without looking into the dump.

>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > index 2aa72b578764..6058706f03e4 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > @@ -480,7 +480,7 @@ static int dpu_encoder_phys_vid_wait_for_commit_done(
> >               (hw_ctl->ops.get_flush_register(hw_ctl) == 0),
> >               msecs_to_jiffies(50));
> >       if (ret <= 0) {
> > -             DPU_ERROR("vblank timeout\n");
> > +             DPU_ERROR("vblank timeout: %x\n", hw_ctl->ops.get_flush_register(hw_ctl));
> >               return -ETIMEDOUT;
> >       }
> >
> >



-- 
With best wishes
Dmitry

