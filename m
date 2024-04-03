Return-Path: <linux-kernel+bounces-129508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA27F896BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7941C20AB3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884C3136E3E;
	Wed,  3 Apr 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCFu8d3W"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507F13667E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139017; cv=none; b=oA01IlbzEQQIYezPCQwkH0ujH/2Eca4oBkd80pllubik/9l1dwI0sAHv6Aw70BUrUu5gjtERlR6uH0dRdsSYxkU2sYSbuncE4WvTSK1lIWlqdVJ4+F9s2Ti+VayiNbxxTb9XWpz+k7vj+Pq75rXvgHW5IuCYP6lSbsz2UWi7afM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139017; c=relaxed/simple;
	bh=xE6QTbHFKdSfTxh3//5Pv1bJxOb959BsmtpGeNd3Olo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSIDpwkeu2J4loS+/zzjmU6VTcwOHB0u/LUHxogTbiodkiFEhslPGZFkg7Fqoc2BUa38sW02mJVMeOuVcRSWfDwZ2ghwAmNCLHkVPECZ61UBKNq+7CcZTLAqdArxXw3yyVuthKSyWHcRiSZX8jpbkqlSAPhROqJi8wvWzAt8Txc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BCFu8d3W; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so5205863276.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712139015; x=1712743815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rx+/ODJmMo86rpamIh1rOudX2tVZC9qd0xdyuh7u+G8=;
        b=BCFu8d3Wq0lTtUxJIp9yHcY1pClcdDtEI8J1B+waNcPk/dciwXxqn1s/V3Yncoa25a
         jLDhsDns+pCUSkP+dtSq6qb8oR4k6P52p+whclFfwINl0T27DpsiPeEaq/OISmJGX5rr
         EnAhC0M6SUedf9zqi1wctLhd8ME3ZNe0navo4aouzAO33F21GZzBb0mwGtQ1XgwlJvhG
         aYYzIS2h+zT1deqp2fzNKBLpIo0X3QZRc/zCGmzxb+9BW12irGjg56bAyXGMjLVAZeYf
         5F+1wKMuZMGzH+huC5KkPFesSki1Z/n+ZG/vkkF1IAUDKRSpH5kecaxvbLzB0VqCd50+
         AlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712139015; x=1712743815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rx+/ODJmMo86rpamIh1rOudX2tVZC9qd0xdyuh7u+G8=;
        b=wmkll8U8CZ8bOPW9lqtTk2TmOb3gHUC27dTaGiMEWXfvFd/cFfE/9M9EEfevRmCTa9
         N3CC/jATCoOJUxGkWpzPt9tmtBwsymkiG+xzIji1K8Jw1k8+1lYnOLGTTks89QJEX8hh
         7mJ/34UAxvYFkUNtkz8ZsTGmXh7RDzc/3bqP+zM6JUjPubgQE2Vaz1YmO8mORCd155a3
         0+L5ZTw2d6Qqzd2s5u5kE9jFPSO8MIKInpap6Nhk7n4n2DsbNVdVpMzQUbz1oSHS3DYq
         qnR/1jMNdnDfa64IEBomx4cAqRlB2XGy8KhtkJpwfYFhHnowpRewwOMhkJKLeZdVTMND
         jepA==
X-Forwarded-Encrypted: i=1; AJvYcCUKSyIxxZaLTPWJhj5REgIlZWtNojFf2EGghTR+nRSm97uVWmutZ4PMGBtGD+M6vTQOKZwkO34l72hEUdv8Ta1/w566+fR99T0yt3El
X-Gm-Message-State: AOJu0YwpW1eNh2L8uaIHJD0W01VUN3kZaktPxCe1rdavacWOFwbZSvKL
	T65XgInkOb6wwAJ85LSKJdOPTTApkTmG7J4Kp24XMWGVVQnpBtjjuRRJ/vVECN0bpnru1pSFNn3
	3vLa9KrG8wYLq9sIjoGQfAWe48Q92T0KoRPdl3A==
X-Google-Smtp-Source: AGHT+IGjh7gnnBb9kNyO5PIPLl2Il5vz8QX1R3iBfDYBjyvguAc/FohIsajpw5mGOtCvkRWDwc/PlH4RwAJFT54eBCo=
X-Received: by 2002:a25:ba42:0:b0:dcb:be59:25e1 with SMTP id
 z2-20020a25ba42000000b00dcbbe5925e1mr12992717ybj.30.1712139015113; Wed, 03
 Apr 2024 03:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
 <20240403-msm-drm-dsc-dsi-video-upstream-v1-2-db5036443545@linaro.org>
In-Reply-To: <20240403-msm-drm-dsc-dsi-video-upstream-v1-2-db5036443545@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Apr 2024 13:10:03 +0300
Message-ID: <CAA8EJpo-tZSOD+B+4znyBmFPVOjc6yocsVwYMXPN5d3WQfbr=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] drm/msm/dsi: set video mode widebus enable bit
 when widebus is enabled
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 12:11, Jun Nie <jun.nie@linaro.org> wrote:
>
> From: Jonathan Marek <jonathan@marek.ca>
>
> The value returned by msm_dsi_wide_bus_enabled() doesn't match what the
> driver is doing in video mode. Fix that by actually enabling widebus for
> video mode.
>
> Fixes: efcbd6f9cdeb ("drm/msm/dsi: Enable widebus for DSI")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>

You have ignored all the review comments that were provided for v1.
None of the tags were picked up either.

Have you posted this for internal review like I have explicitly asked you?

> ---
>  drivers/gpu/drm/msm/dsi/dsi.xml.h  | 1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.xml.h b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> index 2a7d980e12c3..f0b3cdc020a1 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.xml.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> @@ -231,6 +231,7 @@ static inline uint32_t DSI_VID_CFG0_TRAFFIC_MODE(enum dsi_traffic_mode val)
>  #define DSI_VID_CFG0_HSA_POWER_STOP                            0x00010000
>  #define DSI_VID_CFG0_HBP_POWER_STOP                            0x00100000
>  #define DSI_VID_CFG0_HFP_POWER_STOP                            0x01000000
> +#define DSI_VID_CFG0_DATABUS_WIDEN                             0x02000000
>  #define DSI_VID_CFG0_PULSE_MODE_HSA_HE                         0x10000000

From the top of the file:

/* Autogenerated file, DO NOT EDIT manually!

>
>  #define REG_DSI_VID_CFG1                                       0x0000001c
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 9d86a6aca6f2..2a0422cad6de 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -754,6 +754,8 @@ static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,
>                 data |= DSI_VID_CFG0_TRAFFIC_MODE(dsi_get_traffic_mode(flags));
>                 data |= DSI_VID_CFG0_DST_FORMAT(dsi_get_vid_fmt(mipi_fmt));
>                 data |= DSI_VID_CFG0_VIRT_CHANNEL(msm_host->channel);
> +               if (msm_dsi_host_is_wide_bus_enabled(&msm_host->base))
> +                       data |= DSI_VID_CFG0_DATABUS_WIDEN;
>                 dsi_write(msm_host, REG_DSI_VID_CFG0, data);
>
>                 /* Do not swap RGB colors */
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

