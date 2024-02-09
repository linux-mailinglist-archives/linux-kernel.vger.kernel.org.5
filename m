Return-Path: <linux-kernel+bounces-59334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F68784F58C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF14B26471
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB25381B0;
	Fri,  9 Feb 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLf3eBWv"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9893C466
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483769; cv=none; b=p3GcXXP0/xYW/4B3t55uMuwuzIphK+kWRMl+uUXqijVVd0DDnCpzdLd23o954wz8s0j4bcn51yWimit5umzZDFtVwECrmFS9Szzcf8bFIzHQnVmh+zWbFsdf2FVJpvx6GN0DcH9jseAWyKJdIjaufgZ0TvKpD8dAD/6Lp/5uuR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483769; c=relaxed/simple;
	bh=12Q2gl1DveHT/3s9+knSL+sGOcxvkbiCnBtuOCrdZzw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nqwe3GYZNJLtMubtWCYLwTHRFaOmLnZylXxuTadHeCfUVkQ4lEBUNYY/IP25VPUL6BmTyi0HeHxlvpxXI5TIcnPIymQG7L8OhFXfrOq7s1iZTqWmWf6hhz1u5NOdExATwJyxEP9IHhyDU6wc5mNJnJV0j5+7uDth9H13s+m/Mfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JLf3eBWv; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55cca88b6a5so1264740a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707483766; x=1708088566; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=30ltjS2465HeE6RDkcYZ7gz3HAH/FfBk4VubamB9xlg=;
        b=JLf3eBWvL06pnpnbXI2CF1RXZrdQAf/PtERyfIKQgE68yAjwD42M1+ZQNAM8PvAwG7
         wL8rQXCY5BxrOV3gkn/ISaxAw/SUc7XfaORXh3FrdyM7P1c70vOWTKrNerFqY3P3UcAy
         dNeF2yWpvftR9a0OPUsVIak2YjtW61YNd90lMWnBB7GU9TJo9rQvH8e9bFGNfhAelS/r
         H8QIJLFpmZ3miDdTvsCp36FYqbdhe7FUQfNbMRw8M61atlmjumkl1Z/9jfDjOR7BxJfj
         JWHMru0KVeB8K3szTc8xaMQ46iZuUd+xAzXKJehQdLFAeC/diOeRm/oijdorCDPdAuL9
         PZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707483766; x=1708088566;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30ltjS2465HeE6RDkcYZ7gz3HAH/FfBk4VubamB9xlg=;
        b=KKBBV4pLA7eMF9KXtI739tT7LtwZJkpE3IKh3phdqn1Np75O6MUaNd3OWBT+kFHAtB
         QP9X1RoGG+h308+vK5UkVfgUw90yJXC5mtkbZ9AeWKUCwnx9Dny6RuDDoIBv3Xo6QNv/
         DrY4pq3R6GnanlvVcVV7J+2SPgb7TDBfIPmOuwo+kGaOJQLnwfduh9TIzixhqIgCNFJs
         FwMyd8t+5sdFga0lyc72PUk5UjyyY0BXI2ljUsdwZPsBfQvA5k1pLkeXyUVHKr7ePKqq
         bpmn++TaDO6sdDOvQiD46Qqppaz/r2RsErRUEQ4zgh8ZXgG/a18RmaNzX99M0DlEz+lU
         MGNA==
X-Gm-Message-State: AOJu0YyEr0qObQQbqwSY3o/YuOoNgNH3yiFoZ7CgOKbHkhrCyNnSTW2a
	VtIgGCxjcoCKM9+dJxcJMjWygSGGTu3I2jDfkZEyJ7HFUx0+T7XnE50n7ptrMFI=
X-Google-Smtp-Source: AGHT+IGk3Uy6387987t9ObpRRvhmYrzvpBWmjEfnryXbGtmf7Y8JaQxsRglpq2IGmZTRgLgs84PSXQ==
X-Received: by 2002:a05:6402:12d3:b0:560:8010:b678 with SMTP id k19-20020a05640212d300b005608010b678mr1245938edx.30.1707483765418;
        Fri, 09 Feb 2024 05:02:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJazRu4iYiKzzQwF/gSh1UE3tl7gDgkJUAgPuN+fxfAMMbbBSuIoh8EztuiqybU5H3TAvB3rAuRntIXddfciGZ+rUYMgNDlht9JOhm2NA+3CFgl2l9oxy4aIY8wvySUkAZeB9P9FAb/HBbbnjQHmztNz3OxAMLak+cio07d1ZC0PQZO0p5LMzPTkdxzIC2ziwdv2ps4BuZTsCm45Ww8aaSimOUhpz3Yhjb73sQrezTbTmLmsAJjWKNUK7vMxAx4jBdiodphI7gxv7h0At4mxCCQFDu3SLht/9EraI+2b3syXQgPXRVCeM1G5bJFCuPcox3Hzw7YhI8e9wu2pIILG6FT2wzXkY27tOtIgiREW/Mgu8TQck8rQg/vZ/gjsBR1CMyS0/VHMMfxc4wrT221jhtRJrR+4EgafsOOI4wMwOhpqov18mn1YUtZmU14hCdb+EjYzT858gki30kdpNXnjAuoQ7bffAM7bdxxv23usQGjZjRntEaufxyQmHtkjCLFWi5khB6Lb+TdKRGy9Y2iNpNBzaUsBqPBpEDpNkuPGcbfHwAiUxYTET57A63nO6NKWJcMxQYtMXZt/zX4Xa0Iqs8DAssfIuTgiSVhLmB9O/5+8A6fL8jqM11vm7DPfpqWru2IuB3XA==
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e16-20020a50d4d0000000b005605716e755sm806635edj.52.2024.02.09.05.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 05:02:45 -0800 (PST)
Date: Fri, 9 Feb 2024 16:02:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Anthony Koo <Anthony.Koo@amd.com>,
	Josip Pavic <Josip.Pavic@amd.com>, Leon Huang <Leon.Huang1@amd.com>,
	Mounika Adhuri <moadhuri@amd.com>,
	Lewis Huang <lewis.huang@amd.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix && vs || typos
Message-ID: <7482be2a-aca1-41dd-bb6e-d547571b9507@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These ANDs should be ORs or it will lead to a NULL dereference.

Fixes: fb5a3d037082 ("drm/amd/display: Add NULL test for 'timing generator' in 'dcn21_set_pipe()'")
Fixes: 886571d217d7 ("drm/amd/display: Fix 'panel_cntl' could be null in 'dcn21_set_backlight_level()'")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 5c7f380a84f9..7252f5f781f0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -211,7 +211,7 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
 	uint32_t otg_inst;
 
-	if (!abm && !tg && !panel_cntl)
+	if (!abm || !tg || !panel_cntl)
 		return;
 
 	otg_inst = tg->inst;
@@ -245,7 +245,7 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 	uint32_t otg_inst;
 
-	if (!abm && !tg && !panel_cntl)
+	if (!abm || !tg || !panel_cntl)
 		return false;
 
 	otg_inst = tg->inst;
-- 
2.43.0


