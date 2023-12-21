Return-Path: <linux-kernel+bounces-8438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2647681B727
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591581C21C09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF0745CD;
	Thu, 21 Dec 2023 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EX3wa7dc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2A273182
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbd029beef4so1581818276.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703164662; x=1703769462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yz4iMeRIk9TAyj97jIuOOIhseoq5SQwyyx45BqaJo/Y=;
        b=EX3wa7dc25U7zaeafRq0/w64n1wWZaYxTXWB3oicED1TJf0KhLFWr4SoL254ZqCJWr
         4CvB/FohLr5mmJEIlDNB26wMdGTMm/xQDrDD9FQptRhqmQE+sokuBz4o41tiHKYSlLSV
         MmQWpqwpn3tU+2EXntUfbYuomlcWOROvU9HvcX7pKdLyT8ntFev4gPmTCKrs9c30Qpkt
         R/1370NdjCP4NIoYk/P6re4EjQ/hNKv5sCVTLDSBZF0xTk7b0sg0IvJEBIFWMP8kkOqq
         DHQagI0has6JvuFs8CgmGSkQ+kc9PUiF5bzSofAEr31dHI01kEmXoz8rWS/B3loPXu4u
         0c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703164662; x=1703769462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yz4iMeRIk9TAyj97jIuOOIhseoq5SQwyyx45BqaJo/Y=;
        b=fweAGZ0Kg56MkEE2vfd6bficznrJbpVowo6ZvhykvKTdGUjIIQUvJv+BiQJidQf+7C
         4yqQEu7T/SJ27zhhlO1Zh/LubDM857b5vymU29LOW0NbjzP4ZvV9sQSlMRA7GQnBRmZC
         haLYAFJfXvhsuNjYh6DVtWFAuciDKJQ7ldiklBneem2gR67uRrBURxlWPLa9AwyBF4oy
         /mJSPvT4ZkF4AG8AuWqxgFPabqcGIMdHF6fDuSWxF1+5WVOIpWOti9/hIODQanbCmqTo
         Pc0PpUIwK6uUd3oxC10/oIDdVhHBiL0fEiRKLhiG/gzQvhOorgpmT0lLmHtYnZcKkbSB
         X4yQ==
X-Gm-Message-State: AOJu0Yxz2Eg0afTMdIIz2nmVnPYKSJKpKFDkuh6qFQqN/IiPgprbeDHj
	ReMlhITNIlbqEHOaiNyct24OLB1VkfYElG9FTIgvcadWI5IsFw==
X-Google-Smtp-Source: AGHT+IE6C22+LNsiW2F843YHTth236QybUB1q3GOCwkhb/XTsX0HV0yBBuaiZlIIsroN5Kv3yXPy3tcoUpEyfVuKgWw=
X-Received: by 2002:a25:b312:0:b0:dbd:9a2f:be3d with SMTP id
 l18-20020a25b312000000b00dbd9a2fbe3dmr322201ybj.3.1703164662693; Thu, 21 Dec
 2023 05:17:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221124339.420119-1-raphael.gallais-pou@foss.st.com> <20231221124339.420119-5-raphael.gallais-pou@foss.st.com>
In-Reply-To: <20231221124339.420119-5-raphael.gallais-pou@foss.st.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Dec 2023 15:17:31 +0200
Message-ID: <CAA8EJpq-NWUEe8QbUwDHu0BBSViWKh92PujD7PA84xgvSUsvhg@mail.gmail.com>
Subject: Re: [PATCH RESEND v1 4/8] drm/stm: ltdc: implement bus clock
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Yannick Fertre <yannick.fertre@foss.st.com>, Philippe Cornu <philippe.cornu@foss.st.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 14:45, Raphael Gallais-Pou
<raphael.gallais-pou@foss.st.com> wrote:
>
> From: Yannick Fertre <yannick.fertre@foss.st.com>
>
> The latest hardware version of the LTDC presents the addition of a bus
> clock, which contains the global configuration registers and the interrupt
> register.
>
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> ---
>  drivers/gpu/drm/stm/ltdc.c | 8 ++++++++
>  drivers/gpu/drm/stm/ltdc.h | 1 +
>  2 files changed, 9 insertions(+)

I might be missing something, but I don't see this clock being set
(compare this patch to the patch 5/8)

>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 5576fdae4962..67064f47a4cb 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -1896,6 +1896,8 @@ void ltdc_suspend(struct drm_device *ddev)
>
>         DRM_DEBUG_DRIVER("\n");
>         clk_disable_unprepare(ldev->pixel_clk);
> +       if (ldev->bus_clk)
> +               clk_disable_unprepare(ldev->bus_clk);
>  }
>
>  int ltdc_resume(struct drm_device *ddev)
> @@ -1910,6 +1912,12 @@ int ltdc_resume(struct drm_device *ddev)
>                 DRM_ERROR("failed to enable pixel clock (%d)\n", ret);
>                 return ret;
>         }
> +       if (ldev->bus_clk) {
> +               if (clk_prepare_enable(ldev->bus_clk)) {
> +                       DRM_ERROR("Unable to prepare bus clock\n");
> +                       return -ENODEV;
> +               }
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
> index 9d488043ffdb..155d8e4a7c6b 100644
> --- a/drivers/gpu/drm/stm/ltdc.h
> +++ b/drivers/gpu/drm/stm/ltdc.h
> @@ -44,6 +44,7 @@ struct ltdc_device {
>         void __iomem *regs;
>         struct regmap *regmap;
>         struct clk *pixel_clk;  /* lcd pixel clock */
> +       struct clk *bus_clk;    /* bus clock */
>         struct mutex err_lock;  /* protecting error_status */
>         struct ltdc_caps caps;
>         u32 irq_status;
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

