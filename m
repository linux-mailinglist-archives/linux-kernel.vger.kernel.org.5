Return-Path: <linux-kernel+bounces-129455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B73C7896B0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87CD1C25E29
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD621350CA;
	Wed,  3 Apr 2024 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyS0iJV4"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F8134CE0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137753; cv=none; b=VzeYrpRLOn1rUIKCuzO4nV0q/huAms/PgikO4jVmccuF5FC09LRJHzcaeXJCQvvwTTYa7iU/ufEyVOGIqL7jnoqcepkrfMgsMek1kR3069sxQ9ZhYzanu5wP8gep/F5fKiVYRpXcbDwsJJWUAcMzrgixxjgDbdDyvEYB/KMRUDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137753; c=relaxed/simple;
	bh=I/lHK07ldnCHYwMXK+O+modiLmcQLlhWwsMZypnyawE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0GNRORoGJXNwA7FIh6eH+1/0gNvcXwbrsHrBPuctDX0QJXQqPz8GcbEYmULlndN/UwuRCfYmz3lc7IxvAnaqYUF16zrggfFYd0jeQ4evC1C/i1IYd2zVfW2k4twRHc/AY511AHFEOp6BtqFxaBsB19pb0yDnP8vbXd3trXB5Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gyS0iJV4; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ddda842c399so4894485276.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 02:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712137751; x=1712742551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3tvxwcGEaXlq9t2qggBvOm4jDfIobjVvvQgoLk34JPw=;
        b=gyS0iJV4JbOjl0nH6c1arzmrIy2B2zK5JHKy20mJ4XpVh6oFLhihKxk4fybz8dH7ZG
         3PhWDUbdNqQV8jAUXiruBp6dmZcruQhQDVdd7DgriRSI8C6LIRvjL/o3a2bPNQmZXkA0
         v5yD01WuIkOxY0cQQVSxz6ue1fvgcknQF63fbdZrT9kW9jShKeW3RgnBR/o/id315Sdc
         Q84gc858fOJNfUeLczirbYsfq1U5259rAGPRISCfbCmMWxSpHojVq7xHdyF8bMOFiTaK
         glElAzOh59YwnqmQX1RCSeFbeEGsyQmGS5JkyY+myrn1t9BlcAZ+zKvJfXei/pRC6dOl
         sNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712137751; x=1712742551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tvxwcGEaXlq9t2qggBvOm4jDfIobjVvvQgoLk34JPw=;
        b=jSY6jymQvT8iu1TgjolFvisRxkdxWHubReltD2bioyyWAb42bJBmxLRCoYu0lsJaZJ
         UA4HYiS5TcJ704y3FadXJR5pUN1kqh/D4XdtIsFWIP2y8KI7b+mp1t+1B2aDMKvxd/5O
         +e66oteKdOawbYcrIDuBASmQJRTNc3adurqkZX1RwC3E8lfhLZ8QkKr46NFy+FrV7rLd
         TEUvxEynRNgYfvMDnun16NGzpC3VV70wxk957EQ0MAa3TXZeJc2R+kPh1Tw+obwMRL3i
         IIYng55uJS9ndEZQYFBrzssgCDTqnzRJgWoLyHgTlO7UZaRCn2oSvcOv8cLqbdwhVNiN
         PuXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0VuJmaS84XO9kkoF/q7p8qk8bxt442IJ9eSZsw+gxUNv+IvO1gDn/qmW4QJoSxW8SsHoyPO6Mu+EMYlzNlKImlC3Y8a9FYEEgXbMg
X-Gm-Message-State: AOJu0YzbGsRM3qdmiMj1L0sCM+giHaUcRKP953x1Ln7+y9UzZMiVYhKN
	Z/RuFILP7YZ1gmMth+6J98RgwDZa/qdyYrGF18Oy6YrgEjeJ1SpxjZkafRnHGmhEkv8noEUCkAN
	OpLfqODm1pg2FMAm0dt8Wr+TC4u6neMdhlrJE3g==
X-Google-Smtp-Source: AGHT+IEpF2mJ7B2oXcCBJscSms9I5JdRsHzjwR2AXCUqHh+AiX5In12EGhsUtCqq2Re95OL5aJpNfwvGQHMpDLx4yAQ=
X-Received: by 2002:a25:b989:0:b0:dbd:8f9:a71 with SMTP id r9-20020a25b989000000b00dbd08f90a71mr12861423ybg.28.1712137750746;
 Wed, 03 Apr 2024 02:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
In-Reply-To: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Apr 2024 12:49:00 +0300
Message-ID: <CAA8EJprd78g0jM4u2uY-vZnqQibbWevjxqzXFaPohkvmyWHkHw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add DSC support to DSI video panel
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
> This is follow up update to Jonathan's patch set.
>
> Changes vs V2:
> - Rebase to latest mainline.
> - Drop the INTF_CFG2_DATA_HCTL_EN change as it is handled in
>     latest mainline code.
> - Drop the bonded DSI patch as I do not have device to test it.
> - Address comments from version 2.

Which comments? "Adress comments" is the worst case of changelog.

Also, what do you consider as version 2? Jonathan Marek has only sent v1.

>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
> Jonathan Marek (5):
>       drm/msm/dpu: fix video mode DSC for DSI
>       drm/msm/dsi: set video mode widebus enable bit when widebus is enabled
>       drm/msm/dsi: set VIDEO_COMPRESSION_MODE_CTRL_WC (fix video mode DSC)
>       drm/msm/dsi: add a comment to explain pkt_per_line encoding
>       drm/msm/dsi: support DSC configurations with slice_per_pkt > 1
>
> Jun Nie (1):
>       drm/display: Add slice_per_pkt for dsc
>
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  9 +++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |  8 +++++
>  drivers/gpu/drm/msm/dsi/dsi.xml.h                  |  1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c                 | 42 +++++++++++-----------
>  include/drm/display/drm_dsc.h                      |  4 +++
>  5 files changed, 44 insertions(+), 20 deletions(-)
> ---
> base-commit: b1e6ec0a0fd0252af046e542f91234cd6c30b2cb
> change-id: 20240403-msm-drm-dsc-dsi-video-upstream-1156d110a53d
>
> Best regards,
> --
> Jun Nie <jun.nie@linaro.org>
>


--
With best wishes
Dmitry

