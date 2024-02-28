Return-Path: <linux-kernel+bounces-84494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4754086A76D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA11A28B06C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD922032C;
	Wed, 28 Feb 2024 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rRZG9/jg"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362E1CFB9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709092768; cv=none; b=cIWoUuF+WLKXUZWnAqzPRUBBucqhK+4Ngd4aRJ+gHiQ3MWRoYJNS4zX1caWmjkD4TRVndukqSwiUq8bLSlGHqyag2UDW1zQDRdRRgGx97d37DhnTYXnvMRkp5944+8NteumTjQhGlEe0RzrnisUk8cacJD2DQh4yx3EAH99E2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709092768; c=relaxed/simple;
	bh=IMrHPu3rw7CR5m4n1G33TOrc7SfYW1B+5Tg1bVNKqZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgL+Coen9ZdF6mdv16boZf0hSi7aDeEHFIQsp+dENV2ffTOyTkHdJSA9w/0JfIoDe6eBfZetWiqjHq93b8qolryyeCqWyao2DuCyyDJFcZiX9ZqSu2p+k9Qv1l2a2iHQPSvJJAW8Y/YT+EBqWGLsGscf8kSIYn4hfGwMRlMxaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rRZG9/jg; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso5010382276.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709092765; x=1709697565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YFwyn+BWw8rCmi1hzkJUbLKC4zkTCP6n1LK6z6QA5OI=;
        b=rRZG9/jgxerWJCar/x8Fh1uhTKPguAhG5zQJ2dGKmM/R1p1Ny4rMYWqMYdf3SGHai1
         RbpMrbSLcGcFp5jXPp/WpnIvTeKKhdVPxPQ6u2AVTQVdhhSiH7sc7M0dGOs9JkkeXCK2
         2SvPBC1vCm2N9Aq8W9LpteR19IXynNnjv7aRdtSPIl5HTRkKMaIThyEecdZIv8Urr73C
         D+1f4KUIA6YfUcC28udvwhuiwIL9pYSarRfKnteLAk4YLIwK9BTeRb+tbIq+6hstd43t
         DTbs/hD6vEqUqF4zMZAN6V8lAa+4BM6l9MGWNQRhPjJ4nzVWiHqx7e/RET+cSlFdDuCL
         /SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709092765; x=1709697565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFwyn+BWw8rCmi1hzkJUbLKC4zkTCP6n1LK6z6QA5OI=;
        b=q6Hie9ct1OH0w/3DkQfm32Wi+y25WffZkdHSDszkgtzWlstQ6IKSTBPH+m6MEruKjk
         QCz+B70ygCJ7XArzD+xhBLcnN8TWGWzIIcHSnhuqmTKM5aPJKU8yHL3ND4IDdxpCe0hM
         Z+jTZ5EN+U0inrtJKkm638dxzxVu3W4Ci1475KWmUpBl3/2O96LbKtsBEjODQdK9xCQ1
         ODJxVA+OO2Gm7GNqBFgGEegufFFkNQlag8Q+arxcA9hV5nGvBXM0KVhmmwuUe6yFw+kl
         Ns+s5a0TkSIwP0A23SgEkyu/wcBoC+NNaQULm48RwcEV5zq8c2PD1rquv7hwXifamgh9
         2B9w==
X-Forwarded-Encrypted: i=1; AJvYcCVqIe9U/Oyd30KxQnM2TJC++efP0Iuswyf3Fn/cAq/SAtuDYfBczg4ym3NdxClYVu+0a78WGNrID/kljluvAIZ/F6+WtYDp67TWCvCl
X-Gm-Message-State: AOJu0YyFqDaML0zps4q4qmqvM9jJtDQd1LbtoRV1pe6ANrligBsafIdS
	HHVERwN2DOTYHsRIJwYLY5vXT0naqgrfBcFngkHuJWK/G9pCcxAIgdjvLf+3TG57zmevpsNe+jY
	YZxtBCPzyiKsxZFBhMdDw5vDGHUHV9cqUKgHfDQ==
X-Google-Smtp-Source: AGHT+IFcs2FLZnsPY384lCGwM2yZ4jK42q79aAno/WcBXJrGDRzRP9dkz37Md1Jr+WKWJn4QzBI+5Nm6obS/pu7NW9o=
X-Received: by 2002:a25:ae8d:0:b0:dcc:d455:2ab9 with SMTP id
 b13-20020a25ae8d000000b00dccd4552ab9mr1551431ybj.27.1709092765548; Tue, 27
 Feb 2024 19:59:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228011133.1238439-1-hsinyi@chromium.org> <20240228011133.1238439-3-hsinyi@chromium.org>
In-Reply-To: <20240228011133.1238439-3-hsinyi@chromium.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 28 Feb 2024 05:59:14 +0200
Message-ID: <CAA8EJpoHQD2apb=0WB8G4aisgnQsZG1=dxRV-NQNLNcm-KTdNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/panel: panel-edp: Match edp_panels with panel name
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 03:11, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> It's found that some panels have variants that they share the same panel id
> although their EDID and names are different. When matching generic edp
> panels, we should first match with both panel id and panel name by checking
> if edid contains the name string. If not found, match with panel id only.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v1->v2:
> match with panel name instead of crc hash.
> Note that we can't directly use drm_edid_get_monitor_name(), because some
> panel store the name after EDID_DETAIL_MONITOR_STRING instead of
> EDID_DETAIL_MONITOR_NAME.
> ---
>  drivers/gpu/drm/drm_edid.c        | 69 +++++++------------------------
>  drivers/gpu/drm/panel/panel-edp.c | 44 +++++++++++++++++---
>  include/drm/drm_edid.h            |  2 +-
>  3 files changed, 54 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 15b97c8ed993..c4126475ff0a 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -2764,7 +2764,19 @@ const struct drm_edid *drm_edid_read(struct drm_connector *connector)
>  }
>  EXPORT_SYMBOL(drm_edid_read);
>
> -static u32 edid_extract_panel_id(const struct edid *edid)
> +/**
> + * edid_extract_panel_id - Extract a panel's ID from EDID
> + * @edid: EDID used to extract the panel's ID.
> + *
> + * Extract panel ID from EDID.
> + *
> + * Return: A 32-bit ID that should be different for each make/model of panel.
> + *         See the functions drm_edid_encode_panel_id() and
> + *         drm_edid_decode_panel_id() for some details on the structure of this
> + *         ID.
> + */
> +
> +u32 edid_extract_panel_id(const struct edid *edid)

drm_edid_extract_panel_id(), please

>  {
>         /*
>          * We represent the ID as a 32-bit number so it can easily be compared

[skipeed the rest, LGTM]

-- 
With best wishes
Dmitry

