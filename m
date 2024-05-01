Return-Path: <linux-kernel+bounces-164942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580218B854B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EF8284379
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2774D481C6;
	Wed,  1 May 2024 05:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HRayLi8T"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275B45C10
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541059; cv=none; b=o2QsvyxwEiO96/QDIbEuHOLyoZpY7E2otC4Z7WTZwLsT24hAdWlrOMVrN9/jK7CN3/sddb7NHCJuxNRTc2YBoIyGlo1C6HAAUuJpzsIAsKaIa0vYvuVsQxcgGgS3FlHoBMctIVpfjUJGP06mhjoiBTJ1y9nQDgUGS3zlBlnZAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541059; c=relaxed/simple;
	bh=8VgZBGOqasxtDu8NoWssIzgWua0nNl/c606VADtxgo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZPYQBJRONNj/LfMcar/gKOeSFaeDZvVPigUfLiz6RdirajBWPxHzVyjySOQpdVJF9a/noUTOMlqCYZRMCVY5/ykAm5jo3HtpaLwOmDYeAL7aNySN5hVLNuq41fgbVUDpmPQmhnZRsRKSEYpdls0F/WnH8etp72BGpqYFkj+5pCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HRayLi8T; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714541051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hv/zMJfrUtuR9SIXrjoG0hpn5IoOJRa072jft5yenws=;
	b=HRayLi8TZdep+HY2YBszNDQ9ymBbo+6MbPxdFt5JssNdZaEMQE1BQefVADpwku6mbKHiCS
	BgtlKdhJTz7BIQ/CXijEGow6CwEGgx+vp7V4b4ub95T+sbx+u3zhVjcYLgYpnAUVoF+R8v
	UDdihFrVlH190A6rSYEXvMt0NB1uiIs=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v2] drm/panel: ili9341: Remove a superfluous else after return
Date: Wed,  1 May 2024 13:24:02 +0800
Message-Id: <20240501052402.806006-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because the else clause after the return clause is not useful, remove it
to get a better look.

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
index 3574681891e8..433572c4caf9 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -722,7 +722,8 @@ static int ili9341_probe(struct spi_device *spi)
 
 	if (!strcmp(id->name, "sf-tc240t-9370-t"))
 		return ili9341_dpi_probe(spi, dc, reset);
-	else if (!strcmp(id->name, "yx240qv29"))
+
+	if (!strcmp(id->name, "yx240qv29"))
 		return ili9341_dbi_probe(spi, dc, reset);
 
 	return -1;
-- 
2.34.1


