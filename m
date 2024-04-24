Return-Path: <linux-kernel+bounces-156502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518238B036B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E1D1C235AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6594E158211;
	Wed, 24 Apr 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+ODFgzO"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572B157E82
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713944626; cv=none; b=XrEH8erB2XRb1NjIuAU00uk+d2VLOSrnRCrM6TbpbvZe1X1enu8dc34LH7QjZtE+sU1Wj0KWOcaiQBY56S58bSFB3GedQJkvuhBE+/41VmIahd/ObiiObqqwTwgeP88IBE8BNhUbyq45XUWu8D6b4W0lNXW828KD6YnaMQ22oZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713944626; c=relaxed/simple;
	bh=FNO19UPt+SxE3J7JJoknkl4PlWyZdoOdUB8D1Ke0EsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUO/erqck9x9JEcOCVrG8xrBM3RUiguyqy0bHgGCDoR97u/GCgtf82yhXa9Qac89AgutELcKr4DavxFrvWUuyICZycVAqI7S+r5mzTrTtrGBvpcwjaWdLY4d9UBBdRRZ/xDDsx0vktbIr4gWgYosu69dHCHtCqH+5BZ3SsSxm18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b+ODFgzO; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de54b28c3b7so2020930276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713944624; x=1714549424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wtsihhksumpqYptVS7nFL045QDvdMYuFE08WIUvrDLM=;
        b=b+ODFgzOorQR6+ONaw+uRY2cGqjpMe+BrQVRpklsY0Ziiwgaw5YKNIrR1UayJ2yDzr
         T8VUPvuz6JUFOaBvR/7oEhV0kCFdKjQiQ35TlgKFvPBl9pZebu4lKAS3gRvZfYq3Mugd
         6u6gLSf9Oz7OdcR9Bq3JIGmsNeF0E3T1jhufqQdjdqn86wptPE4TsN2eGHgwUZDiUXfI
         KrNmGCPJTd2uURLVVHtZo5PB0Hig0AbVluaEHeXxyJffPdi2OWR/tgG7CfMg2vQpWa4v
         tkizpe5UuN0aji72B7QW/aylEou8itzywo9warvc/DZu+qUec6UuPXyD9ZXfwiwBM/Ai
         Nfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713944624; x=1714549424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtsihhksumpqYptVS7nFL045QDvdMYuFE08WIUvrDLM=;
        b=SSQrgQ0pfVzwUJXs/fSvywJo0cftQ/pXeP6QZYt1blPE/rJXFWMxwMPoJdbMBLBVB8
         j/+0W/mSQkr5AohcdOeqBUNjGxW0Ho6B+ZKcVbJ5SPj5j74L/40IliQngO+7KeSkKvio
         3hDE4b93YtG1Nof6HVwHsYx5StH/zBU2sJz8XIYKMjYjfzZ8KPM5mWZ1nLRRm4DdJcXx
         8kU2fG2u0rRfrzfyeuz6kbbOag7wZU3XiitjcSFSwj8DPSHDGK5CDAIukjpA+8J0TtTA
         QlprWSrFOQBS1xVP3xL3CTZHpPIA/p6An1U9B5+7glnq+6pgN8NMi31sdQ0L5+nEEdD4
         de4w==
X-Forwarded-Encrypted: i=1; AJvYcCWfG3qdjVu8UGBmunMUw+74AyWp7a/Att7c6z7gkOOWGkRw1GfSg2+rknB3qSg6S5RcRbZgH4LjY0cYmLZ7J21glSbnZ1dAVCRFdURX
X-Gm-Message-State: AOJu0Yz6iwDqoYgCEqGD+uOuhGKEzUO2MnXX6YAKqct/kSs1kPglBZgh
	Tc655Yj+QurVZtb2Mio6y1wqggKhz6BoxKqVuMPetriYlmxI+RTK6zrA4kUmIN2Pi8WAJRDtBOV
	wc1bbK6rFXHNQX9Gp5fG0EksQeOnC/Vr7glUq9tJA3GCaqv9s
X-Google-Smtp-Source: AGHT+IF6ZYrfiV6J/Ex+BTtfPhn4h1lI97ii3I32JXsH/ubecZf0tKeapodA/iVSzk2OAU67Z3K0OGIEKkbnClchApA=
X-Received: by 2002:a05:6902:110e:b0:dca:c369:fac2 with SMTP id
 o14-20020a056902110e00b00dcac369fac2mr2179571ybu.3.1713944624156; Wed, 24 Apr
 2024 00:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420-panel-sw43408-fix-v1-0-b282ff725242@linaro.org>
 <20240420-panel-sw43408-fix-v1-1-b282ff725242@linaro.org> <d377e5c4-7716-4f4e-8fe4-472e3230eebe@linaro.org>
In-Reply-To: <d377e5c4-7716-4f4e-8fe4-472e3230eebe@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Apr 2024 10:43:32 +0300
Message-ID: <CAA8EJpr-uTiLNbYxq2e7X7-QWaa83Rh3NhZa2ALMxTPPb2Nx0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel/lg-sw43408: depends on CONFIG_DRM_DISPLAY_DP_HELPER
To: neil.armstrong@linaro.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 09:54, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 20/04/2024 04:41, Dmitry Baryshkov wrote:
> > This panel driver uses DSC PPS functions and as such depends on the
> > DRM_DISPLAY_DP_HELPER. Add missing dependency
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202404200800.kYsRYyli-lkp@intel.com/
>
> No Fixes ?

I'll add Fixes for v2. I'm waiting for the discussion on Kconfig to settle.

>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/panel/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> > index ab67789e59a2..5e6692207beb 100644
> > --- a/drivers/gpu/drm/panel/Kconfig
> > +++ b/drivers/gpu/drm/panel/Kconfig
> > @@ -340,6 +340,7 @@ config DRM_PANEL_LG_SW43408
> >       depends on OF
> >       depends on DRM_MIPI_DSI
> >       depends on BACKLIGHT_CLASS_DEVICE
> > +     depends on DRM_DISPLAY_DP_HELPER
> >       help
> >         Say Y here if you want to enable support for LG sw43408 panel.
> >         The panel has a 1080x2160@60Hz resolution and uses 24 bit RGB per
> >
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>



-- 
With best wishes
Dmitry

