Return-Path: <linux-kernel+bounces-162729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFCA8B5FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5501C221A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD4386626;
	Mon, 29 Apr 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uKKXxvSW"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627786260
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410753; cv=none; b=PFSmrng1yKohBTXso7IL3WyTs4k/nUK9ua5qYtfW5WXqai9yHD5gOMyck8l352OWxdIFbUw1zaPJNtWJTNRzkHSm5d/h/su93BYDX1cMtkXtrvtSPf9gbogPLB54KLNLsDERSfGCUBNdf7n0EM6+UOrmJW8dk33pSdu42M+8HMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410753; c=relaxed/simple;
	bh=9ovVlPioVFOyRF2NddI9GluTUtYYOtw2duDAk2S063s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GGXW4ltvImeuWaloSz6FfRjJAWjy/cEOpNxRK7zg4fH0HsznMXHUbMV8PKglvIwrG2/Sz9Eq9nNLtlIoH8jCLA9xqoUw8U5SIzX/dNWc/L8EAdL6kMPaMDm0qm8G+RI58sBDyaqMy8V7YnY9I8Omrk6qddknWL2fhLSoriQ01UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uKKXxvSW; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714410750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LtY9ZZoQVyAdY+PG/ixtS/JGvGfKRbCGnJ+QNkSOp0k=;
	b=uKKXxvSWMLPLENU+Sj7BGrKoT1aD43R0fmqhKMkBToIvMLYuGpyCb+qgln4oghKj5sJ0tz
	90yXSP+VNy4RdgcEE843QVGfbB82NUGVJVq82k1YoOEuNNN+DlaYId1Y38Wc/lu6/5d3Ux
	7XPTT9Wp/LDXpOVP5PMtlRO9hp8td6k=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/panel: ili9341: Remove a superfluous else after return
Date: Tue, 30 Apr 2024 01:12:18 +0800
Message-Id: <20240429171218.708910-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The else clause after the ruturn clause is not useful.

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


