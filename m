Return-Path: <linux-kernel+bounces-51818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA4A848FA9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02111C213DB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BDD24215;
	Sun,  4 Feb 2024 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfYqXvSw"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7D249FC
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707067454; cv=none; b=u4CXmmSsvGPPI76Z2bf2eAc85JCBaC+9cQWF//rGCngCMpwx/jnJkZgTum6OzBK6MeUkKeCLxZr7sBL/cd1nWDJZWiIRcZQJsyyoGwdA/SuGVuZWjTQcL2vD1y698P4gRJld4ZViRWSTvt5TqKjJzMlA7wWS4VyMvBYz8WJwWOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707067454; c=relaxed/simple;
	bh=ge61ygw4PmZXaFKzfXuyvYCrts6fN3YIespn9P5gMzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwpQpKziacsm75qc5+vshzhFEwZRTUDudwp5ysbe/pvuXj51ua+whipHSzuqtwNAAqY5Q4Fl1qhz2GiOgmtdrL5a5+fmr7lmrgrf9xvUZk9ENmXmAuP/OPpq33uf9kR8thSmK1Kc70O2onuGoyNjtz4qA99MkpGXWPjQNlpGW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FfYqXvSw; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso3131122276.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 09:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707067450; x=1707672250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T1P19T303L/B43bwnD9+Y7IOxEcnJdUhgKJO0qIHJpc=;
        b=FfYqXvSw/1arNlPxIyfFAnejcpwmBuL3gLjQXL9d/eDpzXdnDQbEKNW2U4DjAMUEvF
         OcGYEHzkaiiMWF23P6kmtyLZvwYXprq9JqCjO6cYeyUerQ/dUG5APQV5cJ9Kk6kKbulA
         vWBLUNEzvXRpx6BFkw1cL51o3nBLF0iS81uyWeD5yhzD3qBjfOeYi28IPL84dt73RvYD
         nvI9ZdDvJR43dXoCKSrt0B1T1D8sYAk5npVl5OL4FP7SJbK5kq6FSgmO9FO7juyUsXVk
         1XDWG4X4TdkfOlKIthGKP7CdimfyIk/j59bs1vQwG7MJL174Afr8SQX12pQDUBuyajcy
         3fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707067450; x=1707672250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1P19T303L/B43bwnD9+Y7IOxEcnJdUhgKJO0qIHJpc=;
        b=Z5OVLFRGvbsJ9E7QIK8DSWfUTyYwLceOzTwzvmVymSlMkV2UmkndEN5J4HMEZRfi6t
         Sc0I7TUQqvWY/TcNccxoPS6bmPDmr7WMAJiQHKNQpUyLnDBVxlgosDAtWFOZ8yeVy/yn
         cIkjuHA1NUY1TjVE2qJABuCypy7wZjCRleHMYuZmWDAK47mLjmNvOIYFhxxyReQWCECe
         g8IKRaFmsrPm5wwB9S58A7uKqjFMKjt8apJEz6pHN0tPE/WwH28c1qKGTcsZoyRGFFxm
         jDXyVGpPHuLneDJ9BaO2PbQXBOCSjkJ6EPcuJ/iiQ73+jE/XbyEIxXOOc9e7j5lNonOg
         8oHA==
X-Gm-Message-State: AOJu0Yw7cHAi/KCwmRj5wVInC1Web7NUsZ3JyEhMwG7kGvo0xw7dfPVM
	cMyOGPWr/qTI36CG6T3Hhz+ct6ag7Sx04uiJ8NUkTNbTqgQfzTsNR7Da4WjXYXk+yPq4HrNIXme
	MlGvpTcEF8mldDbLVera7o7X70fjRFXOc2+gzlQ==
X-Google-Smtp-Source: AGHT+IHZYVkC99LHGk0ItLne/MvFpBr+BVnK1MV9EqBBA9F3ArKp+lRF7UX8mtilpk16mlV1PhE7o33VzQh5K0Ob39s=
X-Received: by 2002:a25:ac5e:0:b0:dc6:4b37:e95 with SMTP id
 r30-20020a25ac5e000000b00dc64b370e95mr7149348ybd.26.1707067450280; Sun, 04
 Feb 2024 09:24:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204-drm-msm-dsi-remove-open-coded-get-bpp-v1-1-c16212de7e86@somainline.org>
In-Reply-To: <20240204-drm-msm-dsi-remove-open-coded-get-bpp-v1-1-c16212de7e86@somainline.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 4 Feb 2024 18:23:59 +0100
Message-ID: <CAA8EJprcdzEzYKzscyB0J5VrWfF77xJs1SZaoCpP-GQZ2AFmpw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: Replace dsi_get_bpp() with mipi_dsi header function
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 18:04, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> drm_mipi_dsi.h already provides a conversion function from MIPI_DSI_FMT_
> to bpp, named mipi_dsi_pixel_format_to_bpp().
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

