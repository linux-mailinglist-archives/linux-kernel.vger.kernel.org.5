Return-Path: <linux-kernel+bounces-82473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B38E786850B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544FF1F22194
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1852A17F8;
	Tue, 27 Feb 2024 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ddxu9HRQ"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D7915CB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994246; cv=none; b=U++8+CXXDpxHBXtzjMn9jgszKD97NtrxwAKqZM8AmB59sM7kkqXao67ngHNzRgfLq5AfNf9eXcHAER6qfehA6WgUnMFTzF0+uwEjy5mjtaM2QhIlgBjt/7A2GD1tk2M+D5aP+GWhQB/zdPN1EPNegIiQrRHr95+/8srvOI49ljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994246; c=relaxed/simple;
	bh=A+TmjsnY+cysgEex+j7n1tyrma6IdjkmyS79+Ldw3EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urtzSVNTSy3YWvJqROAiWbbZjZ6OtOx+hxuHh/3xt6BJhWv/lMV8pKp7nNbX3WDRMZ30L29VHujNO8Rw08NVXQth8EEoioGFf5HivkXbO91rLjWTL6bh0zOxBC399Mpz/sX71sOW2n9NimReVGKIJ/pQk3e7Ol+/2jBtQSeNBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ddxu9HRQ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-607c5679842so37523647b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708994244; x=1709599044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0iKNjUWW7iRYO9A2SIeCUXKezp5MA/FCeIQBi7AX+V8=;
        b=Ddxu9HRQAh+gIk/CtD/ibj0yG6yB/pDuh0tPhohkop+ej1S77d7UF6PUDNv5WqcdsB
         s+yq9oyutTtDe7zNzM2wzx/ZB9EzKzVP42hCfVEOgQeE/oYibmVqILGsEGskp9pimCtK
         VIJzbfqDz9y5QxaW7QgueqTuRpPBneFUaEiTQOqoGglaFf9FvesE5y543s8jkwmoV1yT
         eDwrK1ImPvlrjacOlHGYzx3HQvxt8LBsWY8SFFMniGgavGJKkXdZDMpsy+ElS6hrUkX0
         Iq/DFqiYEbIoTxpxL4qLtIcjMDrUtuOqsLMSDtK5cgtOL8g2rGe5SZAd6Lb6Fuxob1dt
         S5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708994244; x=1709599044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iKNjUWW7iRYO9A2SIeCUXKezp5MA/FCeIQBi7AX+V8=;
        b=q715o0PqUmGETacr0yoBhNmfX043GYrqve6mIyk+ehpGwDuP/oNvgKUqkjjwDktiRR
         8/Gm1gUd8a7JA4mdV5aCSk6cayyCivzi7Wi2UNvuXU6aJ+0yXh23FCHrc8DJ+uZVblJs
         Ya8emBysUdjTV/KGKtXgWuv1WBH0fMEvel1e4o3pcwtU73QNCfALz0fu6NipkzXHClAl
         Rr7qNHq97LXla/G+v2crXmiX4cVgWn1C+YQtkn/9T8mqZv+QNFsj7fwvp1LHotzrJ7Ol
         9jr4CWiFSOo54Bn1mWwFumih/0+sYOt4w73KGXAGg/wxiGGK4jTo2pE9OVvP4ngLxBfb
         kPVg==
X-Forwarded-Encrypted: i=1; AJvYcCUvfqpc50gH2vpAcdADlhTuxdQ0RcHN1GBjjftpD7GlGnFNdblrKCvF2Yaox8X6rHQrO0r/IhFvFCkg5wVuVefojRt96yNzzYmfzz1d
X-Gm-Message-State: AOJu0YxYP+eUJUWFcIY9IOYxBQjA1sC/NzgAH+m/qLB8UTyfq9YK6cL7
	jmG3A121KIT1Zr4SuA7Bj8PaDG8Tseb6cTLVzLPjItYYbLFVuySvK+XB+Ob+USP6YZQ/vNSI8p7
	Ak/EQwJrVuzVnp4FYrDgFesribGSnkx4egDLpTQ==
X-Google-Smtp-Source: AGHT+IE4df8EejmK1GYtnYYIrilUdBgPMb7hN2YbBWwQO1DFK1I89UwkIg2NUUy1NEoZP4PPArIQGcOaiQ/Mu43T4Vk=
X-Received: by 2002:a5b:752:0:b0:dcd:b034:b500 with SMTP id
 s18-20020a5b0752000000b00dcdb034b500mr889012ybq.43.1708994243773; Mon, 26 Feb
 2024 16:37:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org>
In-Reply-To: <20240223223958.3887423-1-hsinyi@chromium.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 27 Feb 2024 02:37:12 +0200
Message-ID: <CAA8EJpre_HOY1xzOZPv5gPiJ-kEZEJiEm8oyYzXTiPj66vY8aw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Match panel hash for overridden mode
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Feb 2024 at 00:40, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> This series is a follow up for 1a5e81de180e ("Revert "drm/panel-edp: Add
> auo_b116xa3_mode""). It's found that 2 different AUO panels use the same
> product id. One of them requires an overridden mode, while the other should
> use the mode directly from edid.
>
> Since product id match is no longer sufficient, EDP_PANEL_ENTRY2 is extended
> to check the crc hash of the entire edid base block.

Do you have these EDIDs posted somewhere? Can we use something less
cryptic than hash for matching the panel, e.g. strings from Monitor
Descriptors?

>
> Hsin-Yi Wang (2):
>   drm_edid: Add a function to get EDID base block
>   drm/panel: panel-edp: Match with panel hash for overridden modes
>
>  drivers/gpu/drm/drm_edid.c        | 55 +++++++++++++++-------------
>  drivers/gpu/drm/panel/panel-edp.c | 60 ++++++++++++++++++++++++++-----
>  include/drm/drm_edid.h            |  3 +-
>  3 files changed, 84 insertions(+), 34 deletions(-)
>
> --
> 2.44.0.rc0.258.g7320e95886-goog
>


-- 
With best wishes
Dmitry

