Return-Path: <linux-kernel+bounces-129442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350C3896AE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF36F1F215CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD48134759;
	Wed,  3 Apr 2024 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLQNtr7e"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE66EB73
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137297; cv=none; b=satCOC/ZTDRpuLKmzVKn0BI+dEZmMxlOGbrpy7zT8p4dfFBZma5DRDBxT12/9bZk8/t1bVSHPeyQoRqn9HY70Kpsyq1xniphsbgth9azRj78oZjuFoAd3leBegOnNDlbE2rjmzPaPTgE9Ls+2Hoai9mj+9kaULHhMUOXt/APxs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137297; c=relaxed/simple;
	bh=2n0SI0PCJNLsmym3XpRftN0ZKee56xcXmb8IjevYUO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bs78pYTvAbdXEKyLzbIx+zPMl+7nh+OyXKHumJTDCsKsPfsNYQcmYhx2NBvZHVrS2Czs9Ozv6mz1+JdZl4+zfnAXtR1P7ZqTgrgtPGjaZc3AGYLCwB8tpR6+qkuybvok3dGVYKpiqADPettrE8l6j/jwzJLtOyT8WE9jD8n9r4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bLQNtr7e; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so5883646276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 02:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712137294; x=1712742094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyO+QBQa0l1KyC9aVtB+Tynj7pN+XlIzE4CNhhsDWik=;
        b=bLQNtr7eq/ajw87TAJ5A+2zfCvJtvMBFmttaab7jPLeq6CIKGypXhZ2hcMCgebFe/3
         wKK1Yee2FGDGxZ+KJred1ZuZX92P14uVZwlVQVXb4VRkslH3ygOPgJKCZQjFyxiNLGuu
         +7kK1IPRvhkkrx9qVGE+9aVh7L0gixdDmeoaTk17gG8dFzntzDkvcF3d2TqVSLo1U3q2
         z6LaF8GhYQfNk2htHTp/yQ2XfGZfHP/yGn011v0dZgk87x47X+BdvPoW/cXeXt1zy02Y
         xEKPP2em70BaWYPM8P0wmMh4r/EQeHNL7DaPNUEM0e4s/WU8gAXwceQTgs3EAFaiWpU9
         sXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712137294; x=1712742094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZyO+QBQa0l1KyC9aVtB+Tynj7pN+XlIzE4CNhhsDWik=;
        b=EfGXdyLOVMpU3ygMk/U+ofrSloSZEUatYKBgKyyag3kJbU9MQmPcc7lqsmKQNtstDd
         sUcVVChzm4yVI+hMgvP+doWJuuq3uANq49aNTH7Qz2SU7RZ0PY7nwtXRhZ4of77/hKb5
         KqvQejoc9YYhLDGCR8BvA5X+aMMz+3ugnbjk7kyFzJxRHjqs/NCyQQBbMcetbICNWp+8
         wUUGUYY+cnKpFbi2r/xx/WYEwuCmF8L64snWwxFx0+fVePxB0/PaYWRnX1t6aoGYF10s
         b/VGilVAqndCwDPbu2sSThV/GLIbs0fK0Y12zN18M3JvQnAYf3WHmW7wIAkRz2iHyggv
         w34g==
X-Forwarded-Encrypted: i=1; AJvYcCXhbT6S4PN351feqVTxmPPUlncUknVfu0tarKDq3sc4tV6bWE8Y82S+rKelwdBx5ZiffqTpnKk2Dpi/LYdkvJJtQZH//5t7z5dH+p/I
X-Gm-Message-State: AOJu0YzduY6j1qx8f+PpNP5vdK2EaA9VZ97JWjGIIFoUr4sfwoDtbfz3
	GkCs8wRy/4cX2Tof7iI8mWxuNiBIbyoKoOghFkQ/ZOHvdab3KvjyqGY5ZnM1nZqUTE9nJ50tTwt
	n44xVTaHe6pY0Bd6vneKtkR3bw1JTVrFvFj2glw==
X-Google-Smtp-Source: AGHT+IHo7Vge0DzQtT3KcHX8RHK0g2XNH+Jxl5Eel4VaYYgoWl8Iyz2W7DVZ0oNcZ76UL25OVO7Ocj0cWKDlGl95sZI=
X-Received: by 2002:a25:d606:0:b0:dcb:e82c:f7d with SMTP id
 n6-20020a25d606000000b00dcbe82c0f7dmr653359ybg.41.1712137294567; Wed, 03 Apr
 2024 02:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
 <20240403-msm-drm-dsc-dsi-video-upstream-v1-5-db5036443545@linaro.org>
In-Reply-To: <20240403-msm-drm-dsc-dsi-video-upstream-v1-5-db5036443545@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Apr 2024 12:41:23 +0300
Message-ID: <CAA8EJprCf5V7jcR2XCkpkTtRr5f1beHKksL8PJJB_10EDLXEMQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/display: Add slice_per_pkt for dsc
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 12:11, Jun Nie <jun.nie@linaro.org> wrote:
>
> Add variable for slice number of a DSC compression bit stream packet.
> Its value shall be specified in panel driver, or default value can be set
> in display controller driver if panel driver does not set it.

This is not a part of the standard. Please justify it.

>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  include/drm/display/drm_dsc.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/drm/display/drm_dsc.h b/include/drm/display/drm_dsc.h
> index bc90273d06a6..4fac0a2746ae 100644
> --- a/include/drm/display/drm_dsc.h
> +++ b/include/drm/display/drm_dsc.h
> @@ -82,6 +82,10 @@ struct drm_dsc_config {
>          * @bits_per_component: Bits per component to code (8/10/12)
>          */
>         u8 bits_per_component;
> +       /**
> +        * @slice_per_pkt: slice number per DSC bit stream packet
> +        */
> +       u8 slice_per_pkt;
>         /**
>          * @convert_rgb:
>          * Flag to indicate if RGB - YCoCg conversion is needed
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

