Return-Path: <linux-kernel+bounces-148440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1128A8297
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A404B25764
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A2A13CFBA;
	Wed, 17 Apr 2024 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdQI+8Lv"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C07137766
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355022; cv=none; b=HAu4YN4y9DtiMWCnT/gc/GZmLE4WMLfqOeIxcBLJGFcREB41/Us12QZJrsPWTDHT9dwpNhDzyyDnX8/AoSnMQpMxpOd0AzeAqXuYt44766XHkRyX3ZE4L7HJIkDsPfKRTC3tvtB+d90Yb2Our5YRC161YtQUfSr2Pt/9gI0vpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355022; c=relaxed/simple;
	bh=rFWYHRR/8wQe0/h8nXEAewAVnKCnbdH3Rt5dV8yzjTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NX3GLW+nnfx4OHm7Iu/CempjLe9Pz7pT+7qoDockB5hCe44S5EJdrUgjNADKMyPuuYYERQWwfLfWsDoLf0Pekhd4lKS3i8qc0PlTiJg/SxJ4EnwVRLaR6KwcsOy+NIwGdbrti2bdpvyR02GK+nXz68OgGkvntijQE6cY9/KaOkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TdQI+8Lv; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ddda842c399so5714854276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713355020; x=1713959820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7V6DnLCsUFkJaBmXGBgPYovHMmnV4qT3enJ4vhqHZQM=;
        b=TdQI+8LvzmqPZn1yvqFHpPhC2u92d9udMKJM9NfzRHMAzuTe2zp06QyzB3p4zMhrN6
         Su1io/EHPQCMCAWqeicjs65L7HFh/Tx42tFPibBJNmNoFoXThVgClvw6y3CUTBa1dl9b
         PPa/kZKkacwtrVsXSh2t0CroQqeX/L0Dp0+9C4CGpk7NapZOXCS1LVOfx48mm3Xv3ylB
         ZXv3IFKnlbyMXJOUXH9h7xzoNAbxGlrQusFjbE5kn0Ht4qvkJkhoXQ8EYrMl+Ir9mAsx
         DCdAcZS447NmJ9J933ex3tLTVRPpWTNEnTVDD7k9oQj56+FkkayAiuf9JEkMAZtqAl4s
         5CFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713355020; x=1713959820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7V6DnLCsUFkJaBmXGBgPYovHMmnV4qT3enJ4vhqHZQM=;
        b=nqzQdKVZly36vYunsHbq9muwRWCKWtVRCpyLCu/ZWmntvw9tulAe/9zoNjtKQgdD12
         u4nRQLpFfV+QWB6ynMJdbIykm/+DxCmcNqQT8kM5W3h2YCZ9jg+DEGaTEiTTA4FE/2VW
         6FaHaC3VWn3kkDiEROGkUiyDeqsWFxZMwiVYm4jSDPjOe+TDvQqQp75kctEyP5QjefyQ
         msSOHFIQWzIe7bzyvy5WVLOdR2D/PafOZKu7ZPYl/LxwNADcVJL1mztur85q0pvvlkRO
         Jsz1tOVR8q7+kUIZhRX0oMCLzQ+zzCMC6r/2gVF6zZLZ2KBhU/otQ9QSw9Rv0PSd1dfD
         K68A==
X-Forwarded-Encrypted: i=1; AJvYcCVWTzJ0M6rrSh/QcnV8+daK0GjMxfTdA8qSz+jk2XDIT+lheN8LWKkgM/u+EL05BWWI7xjRR6L8yy8/CkIVzX+oJI8Kz/PG6LDpGXLT
X-Gm-Message-State: AOJu0YzW3ofZig4BKp11RtfWhFoac1KwSO75qEHwHvdaVW5EyXy0B9fc
	c+m9S466d+zuFU8sIS69lKHJcEbdoV8TdrA18FRB43oi2qqYGXhnN0rwTAbiASXe5TfsOeSxzjt
	vgEAsOrsBMrm6GZdT0ca9YG7T/uyYnA7s6X+d1g==
X-Google-Smtp-Source: AGHT+IHuJ+P0+tIP8Ja/s31hcE/lLfe8rzFJZRFTNiK24q6dN5Ov40yhIbmq423DTWh9Cjd7EAZUIsIKaKherzh7G/4=
X-Received: by 2002:a25:4ec2:0:b0:dcc:1449:71ea with SMTP id
 c185-20020a254ec2000000b00dcc144971eamr15228037ybb.50.1713355019639; Wed, 17
 Apr 2024 04:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
 <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-1-78ae3ee9a697@somainline.org>
In-Reply-To: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-1-78ae3ee9a697@somainline.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Apr 2024 14:56:48 +0300
Message-ID: <CAA8EJpqJfkRd3hN-QoHaxhP2dUaEOyaqnGzA5MiGk96oTLRO2g@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/msm/dsi: Print dual-DSI-adjusted pclk instead of
 original mode pclk
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
> When dual-DSI (bonded DSI) was added in commit ed9976a09b48
> ("drm/msm/dsi: adjust dsi timing for dual dsi mode") some DBG() prints
> were not updated, leading to print the original mode->clock rather
> than the adjusted (typically the mode clock divided by two, though more
> recently also adjusted for DSC compression) msm_host->pixel_clk_rate
> which is passed to clk_set_rate() just below.  Fix that by printing the
> actual pixel_clk_rate that is being set.
>
> Fixes: ed9976a09b48 ("drm/msm/dsi: adjust dsi timing for dual dsi mode")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

