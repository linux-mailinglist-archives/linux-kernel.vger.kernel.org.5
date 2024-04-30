Return-Path: <linux-kernel+bounces-163748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5758B6F36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB7B1C22B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F57D129E7F;
	Tue, 30 Apr 2024 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJ2LtBs9"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355A1292D2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471799; cv=none; b=ognex6GU3srD8C9DDBZ7tPykdnEbRFiSXKD5CQbGFamZCsWwhghz2X1r897ps5BSG3qEB29+2hZtKkqkpwZON/IfZWdEGZNw4if4kZ/RrLxbUMQdarW2AoCV7OOlyo4SkVQLt/2Vg1yNKWVh2gYhVdxSCEx7564YslDglJGzENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471799; c=relaxed/simple;
	bh=mNpTAbsh1hHbVBOwdxXS11hKaRI+rocDAKPjlm5GISQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC3Z2d3YgI4ykMKUCKDShDd92LZaCzU9k3DZgwfzKaIYEgLOxmwxCPMH15Pb978KN3pqnqzYesLBvYA4Xiq+6Oy6CIcWEopW2KPoynFVdPv8BR9gPXExSoXYbwWxSwjL5O01H6UA8BBvNdNcXPtFfFRHHNfaET/VdyIcq+2Rc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vJ2LtBs9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5171a529224so6968921e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714471794; x=1715076594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mbwpFJFih7RIT1NY26n8+loi/ZJwnp9wrw9uANwmIA=;
        b=vJ2LtBs9Ac7rh9MclTw0anqr8q27u8wRxQND8CMMPDI+d8uo0XsnkdR3412fz8INVS
         rIP8vKXEOx26IaPOmCA7/OgUnVs9I5F4Yh68bK9eF3tkJWeUq8kYaSgJIriLmCyvBQwp
         THwSYtUaQvnlcvFLDFo0k2UozcGGGkDAAiy3KgEpV7PNKrt2pQ4aQ7JDt+YYRE3+2rAR
         cGWzCP+sJNQiPJqSFvdfVzbOlyHJabAA9O2M3eF3PHI0qnz3sMIUF2u6NlqtLWRWtRFX
         vEnkTcmVMsXav/rECjxY/OifYoawISSRol6knOOjoe714MnESGF+XOjSnt1/nHI52UT3
         /RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714471794; x=1715076594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mbwpFJFih7RIT1NY26n8+loi/ZJwnp9wrw9uANwmIA=;
        b=cmykIhXCo3hPhb/NIqzCF21owaZuTrAOlWyXtLxYrCfiVojIYFE1XuDUIuTQoXq9WN
         pXUAu6ONKGnY02aN6ReeFlsPG3dsS41txet5G+sM0tDmF3/F2uJhRV0tbEIp5OaoyU8c
         7Iv8DoIrEfOVOFwmMUovUIrV2elSC5g3mg1Zj9E0eW9em/ezEnwD+Kk5Yt6sZgYJpkZy
         QhZKWUwvpEjCIzo7r502ASBETWr7e0JJ51Lo+2mXDxdphY6EsyV10Pkn98Q30VZ45fDY
         j23dOUrD35eumWpO8aCYouUuJqZ2Qfm2tzHyTAga5t/VWhPet5DHiSm3bQ7izqpwPdPX
         znag==
X-Forwarded-Encrypted: i=1; AJvYcCWmS/westdXC9esPqejGD+11Fje5cpFsO9AHSsa81VSPw+LYJOtilvVgaevUD8TpH9OCx72VxctnCTGEIyfZhCeRvW3fBE2CqtyLBBx
X-Gm-Message-State: AOJu0YyAk7Uri5ga68Bfs0XY+7h2/eoW0fXcEUKEu+f6rJ75edwhvgbl
	SEWKHJmLmrt+DX4HHRz0QFJcw1H1NbgxxVudqtdHX0csyQrmrYMwKA4K+9AmRCY=
X-Google-Smtp-Source: AGHT+IHLFfBk+3bT5MCPiG0Sy+oXtj7PLWqAxH1nSKl7+nAmTFj46bAxdYE1eFckW76M0RQSsj0nqA==
X-Received: by 2002:ac2:5607:0:b0:51a:f596:9d53 with SMTP id v7-20020ac25607000000b0051af5969d53mr1449277lfd.42.1714471794305;
        Tue, 30 Apr 2024 03:09:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id b30-20020a056512025e00b0051bc39ef08esm2453377lfo.10.2024.04.30.03.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 03:09:53 -0700 (PDT)
Date: Tue, 30 Apr 2024 13:09:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] drm/ci: skip driver specific tests
Message-ID: <esplx2t6yfrarxflxo5kq2lstx7uiy2atzcxtwf7kugsctnkat@ameojtgtpopj>
References: <20240430091121.508099-1-vignesh.raman@collabora.com>
 <20240430091121.508099-5-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430091121.508099-5-vignesh.raman@collabora.com>

On Tue, Apr 30, 2024 at 02:41:20PM +0530, Vignesh Raman wrote:
> Skip driver specific tests and skip kms tests for
> panfrost driver since it is not a kms driver.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt   | 14 +++++++++++++-
>  drivers/gpu/drm/ci/xfails/i915-amly-skips.txt   | 14 +++++++++++++-
>  drivers/gpu/drm/ci/xfails/i915-apl-skips.txt    | 14 +++++++++++++-
>  drivers/gpu/drm/ci/xfails/i915-cml-skips.txt    | 12 ++++++++++++
>  drivers/gpu/drm/ci/xfails/i915-glk-skips.txt    | 14 +++++++++++++-
>  drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt    | 14 +++++++++++++-
>  drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt    | 14 +++++++++++++-
>  drivers/gpu/drm/ci/xfails/i915-whl-skips.txt    | 14 +++++++++++++-
>  .../gpu/drm/ci/xfails/mediatek-mt8173-skips.txt | 12 ++++++++++++
>  .../gpu/drm/ci/xfails/mediatek-mt8183-skips.txt | 14 ++++++++++++++
>  drivers/gpu/drm/ci/xfails/meson-g12b-skips.txt  | 14 ++++++++++++++
>  drivers/gpu/drm/ci/xfails/msm-apq8016-skips.txt | 14 ++++++++++++++
>  drivers/gpu/drm/ci/xfails/msm-apq8096-skips.txt | 14 +++++++++++++-


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # msm skips


>  .../msm-sc7180-trogdor-kingoftown-skips.txt     | 15 +++++++++++++++
>  .../msm-sc7180-trogdor-lazor-limozeen-skips.txt | 15 +++++++++++++++
>  drivers/gpu/drm/ci/xfails/msm-sdm845-skips.txt  | 15 +++++++++++++++
>  .../gpu/drm/ci/xfails/rockchip-rk3288-skips.txt | 17 ++++++++++++++++-
>  .../gpu/drm/ci/xfails/rockchip-rk3399-skips.txt | 15 +++++++++++++++
>  .../gpu/drm/ci/xfails/virtio_gpu-none-skips.txt | 15 ++++++++++++++-
>  19 files changed, 260 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-skips.txt
> 
-- 
With best wishes
Dmitry

