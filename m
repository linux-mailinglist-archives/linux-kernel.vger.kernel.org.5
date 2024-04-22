Return-Path: <linux-kernel+bounces-153332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CE98ACCBE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36980283430
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509721474CB;
	Mon, 22 Apr 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3xV06F9"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DA502A4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713788871; cv=none; b=f/zSf8DoN8JlqeKAdm+o3dB/j50rqJbRcBVsSLHKdGKu1nCn4iRftRzkYx5Udb+gNfZjZpipRG/Uh4mNXnQEm/W/AKRppLlQ8C3iWGRUupFgakStYxKrELDrX/AmKGK6Ouig8bJ51M/Bddu3q+SO/Gg1WmOj25r3EtSNLC19V6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713788871; c=relaxed/simple;
	bh=mt6mlSo1jC3vI+zgiMWJaoTMX9PCEb3C+l11VmxRilE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/ZQEWFD2PoaPpzePvsuQeBzVeRzq1NotUBd0OnIWnBgMScUUua0BJjn0Jqct5b6w4Ebz0ZRq7jrmQoztsFtL0BcAMonmUyl3rhAKnXyPQm97QmGD+Y6TANe/i2Eoswdp+Y5wJYlJkMtk0Vg3Q2VK6G/IT+kT9Fkq1CNdCVl4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F3xV06F9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5196fe87775so4750562e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713788868; x=1714393668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=12I/hmJ2u76lJqmqa2dDrAg2aVkMUhxeNf6XkgcF6r4=;
        b=F3xV06F91ARGuxocUJ4n3RKHxfrQBK4cpfCeeto3V5es9nQM2qyyMbEBA2E87qcgEi
         CvN/B+j9ZifxTV5U2iM+6w4vvia2ExpHHksUuf6Y23ZI3YK8M1GOUW9HXe0WPqlCPxAo
         f9IiOLsPNkjC9OAbcDbVllsB+1DREYGAThhOuHbYlBr1/2jLqwao72jVkZQWduttNyzn
         PoHzyGT975z3cjrsxmETL36nuyXailY0p/kRY9fKPhaJZNk/hZjCVXnmaz+uQKuA9WFX
         yV2Ey00Ki8fBBkxbA2ZhqlCzs+KmmKf2pKwuBrhidm8v4q05O7Yp+Qd0XvLhPa6x8YZA
         IYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713788868; x=1714393668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12I/hmJ2u76lJqmqa2dDrAg2aVkMUhxeNf6XkgcF6r4=;
        b=hOvbVq1Nca/C4OcgEJA66r4zH0s8h2NRi6U3SfluzAIA4LSxmgCWgjobszQ7l/q3oP
         hfxz0nfClXCk9n1S9HNDvpDaBoPEgaxjT+K672Lk9AnGF9Q+M2wJF9u//PSzntGxpIJ/
         3mPGEYxm97ncJytl1qRPz1eIgTg8skOP/6SfKrlvRweU8b/uFPobnUEXeGdHkjRDyqVw
         ZU+UTHxK0GiJ785TOQPc8dyAJVoORQWBI+e75xMdHp5jsOb27Vo1t4UuVeUw4JDwsouX
         ZwQyKBmV7BMJ4PgBdXQVEtLcxtPFpPE4z97+vJtU3LTIa63X5vEx74pttGraXq+KxAQt
         s8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWKK8GxEcq/NYhha4V7YngZxYCK3x4f6kLiJ8mQJTn6U2oa4Jn+fgzbsJZaaF1JZCnz+tByxod5pT4NgDqZX3G8S9ZwG0adEUi3tRk0
X-Gm-Message-State: AOJu0YwJeJyy256Pxc9pW8xgE6xQMClMGynh2lcvaStBPwgZ51V1ulVw
	AQ14Qdw2SkzObA2AOpGLpO27ZoOYqCeDL9efLeTl4oDRcCYSGPQfb+9NQszK650=
X-Google-Smtp-Source: AGHT+IHVVaGOnbVBC2sXkZB/sTSuTYbDmcWOHVAaQJnXB4GCRg5Rj303uKct+4WAPf2X2LSbc+ER+A==
X-Received: by 2002:ac2:58ca:0:b0:51b:396e:2880 with SMTP id u10-20020ac258ca000000b0051b396e2880mr1328427lfo.63.1713788867880;
        Mon, 22 Apr 2024 05:27:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id l29-20020ac2555d000000b0051929ed7b08sm1727333lfk.140.2024.04.22.05.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:27:47 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:27:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 00/11] drm: Restore helper usability
Message-ID: <xf4bhhmf6jxnnkvc3g4gs7mdup3cxtnrjrkp2pipnvgx3odx7h@ewkr7jbcs36u>
References: <cover.1713780345.git.geert+renesas@glider.be>
 <87il09ty4u.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il09ty4u.fsf@intel.com>

On Mon, Apr 22, 2024 at 02:50:09PM +0300, Jani Nikula wrote:
> On Mon, 22 Apr 2024, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > 	Hi all,
> >
> > As discussed on IRC with Maxime and Arnd, this series reverts the
> > conversion of select to depends for various DRM helpers in series
> > "[PATCH v3 00/13] drm/display: Convert helpers Kconfig symbols to
> > depends on"[1], and various fixes for it.  This conversion introduced a
> > big usability issue when configuring a kernel and enabling DRM drivers
> > that use DRM helper code: as drivers now depend on helpers, the user
> > needs to know which helpers to enable, before the driver he is
> > interested even becomes visible.  The user should not need to know that,
> > and drivers should select the helpers they need.
> >
> > Hence revert back to what we had before, where drivers selected the
> > helpers (and any of their dependencies, if they can be met) they need.
> > In general, when a symbol selects another symbol, it should just make
> > sure the dependencies of the target symbol are met, which may mean
> > adding dependencies to the source symbol.
> 
> I still disagree with this, because fundamentally the source symbol
> really should not have to care about the dependencies of the target
> symbol.

I'd agree with you, but if the driver depends on helpers it becomes
ridiculous. So, it seems, we need a different solution for the original
problem.

> That said, I'm not going to keep arguing against this. Whatever.
> 
> 
> BR,
> Jani.
> 
> 
> >
> > Thanks for applying!
> >
> > [1] https://lore.kernel.org/r/20240327-kms-kconfig-helpers-v3-0-eafee11b84b3@kernel.org/
> >
> > Geert Uytterhoeven (11):
> >   Revert "drm: fix DRM_DISPLAY_DP_HELPER dependencies, part 2"
> >   Revert "drm/display: Select DRM_KMS_HELPER for DP helpers"
> >   Revert "drm/bridge: dw-hdmi: Make DRM_DW_HDMI selectable"
> >   Revert "drm: fix DRM_DISPLAY_DP_HELPER dependencies"
> >   Revert "drm: Switch DRM_DISPLAY_HDMI_HELPER to depends on"
> >   Revert "drm: Switch DRM_DISPLAY_HDCP_HELPER to depends on"
> >   Revert "drm: Switch DRM_DISPLAY_DP_HELPER to depends on"
> >   Revert "drm: Switch DRM_DISPLAY_DP_AUX_BUS to depends on"
> >   Revert "drm: Switch DRM_DISPLAY_HELPER to depends on"
> >   Revert "drm: Make drivers depends on DRM_DW_HDMI"
> >   Revert "drm/display: Make all helpers visible and switch to depends
> >     on"
> >
> >  drivers/gpu/drm/Kconfig                 |  8 +++----
> >  drivers/gpu/drm/amd/amdgpu/Kconfig      | 12 ++++------
> >  drivers/gpu/drm/bridge/Kconfig          | 28 +++++++++++-----------
> >  drivers/gpu/drm/bridge/analogix/Kconfig | 18 +++++++-------
> >  drivers/gpu/drm/bridge/cadence/Kconfig  |  8 +++----
> >  drivers/gpu/drm/bridge/imx/Kconfig      |  4 ++--
> >  drivers/gpu/drm/bridge/synopsys/Kconfig |  6 ++---
> >  drivers/gpu/drm/display/Kconfig         | 32 ++++++++++---------------
> >  drivers/gpu/drm/exynos/Kconfig          |  4 ++--
> >  drivers/gpu/drm/i915/Kconfig            |  8 +++----
> >  drivers/gpu/drm/imx/ipuv3/Kconfig       |  5 ++--
> >  drivers/gpu/drm/ingenic/Kconfig         |  2 +-
> >  drivers/gpu/drm/mediatek/Kconfig        |  6 ++---
> >  drivers/gpu/drm/meson/Kconfig           |  2 +-
> >  drivers/gpu/drm/msm/Kconfig             |  8 +++----
> >  drivers/gpu/drm/nouveau/Kconfig         | 10 ++++----
> >  drivers/gpu/drm/panel/Kconfig           | 32 ++++++++++++-------------
> >  drivers/gpu/drm/radeon/Kconfig          |  8 +++----
> >  drivers/gpu/drm/renesas/rcar-du/Kconfig |  2 +-
> >  drivers/gpu/drm/rockchip/Kconfig        | 10 ++++----
> >  drivers/gpu/drm/sun4i/Kconfig           |  2 +-
> >  drivers/gpu/drm/tegra/Kconfig           |  8 +++----
> >  drivers/gpu/drm/vc4/Kconfig             | 10 ++++----
> >  drivers/gpu/drm/xe/Kconfig              | 13 ++++------
> >  drivers/gpu/drm/xlnx/Kconfig            |  8 +++----
> >  25 files changed, 116 insertions(+), 138 deletions(-)
> 
> -- 
> Jani Nikula, Intel

-- 
With best wishes
Dmitry

