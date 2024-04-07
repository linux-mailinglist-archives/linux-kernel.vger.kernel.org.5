Return-Path: <linux-kernel+bounces-134192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC03389AEDA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032391C21B44
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A960D63BF;
	Sun,  7 Apr 2024 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKOeQz/a"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979CFEDB
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712471467; cv=none; b=I/Qs98Zf5KCNNHoirEaBZB7yXOt7GvAUcILC4mJszh+GgwSzLfN+3LWcV1H9l1TKa8mlxpR3Gh31LZIH/adBE+U2P0kAPCbdyDLRY33z31IuxsILAARJ4s3Q9cdEYXetLPybGNef0q0huDm7dinrfhI/PQx/q9BNhOpf6Od7eQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712471467; c=relaxed/simple;
	bh=0gQjTieB0HIR/W+dcRw3UJQNw6uWyq8YNCtyIsF2wJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KY2ASzQ9cvfWpqw2QGMi6wOEILeTDEy/BgPgyGpNU6coBbbAqafIUArhyN4ko2mWv5MayhR5RtqwnvfrdC5GDxBnJsixA1AU/C3nYmWYDxXsLZQXqKtnp5yT/i6kCDa6wRD8dUqWhj/KDHMsq4IojHhfRVOVthfSwbLLHpO1H5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKOeQz/a; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-6ed01c63657so1557337b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 23:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712471465; x=1713076265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0TxNP5ukGCjKIEdOUAnb8TNyxv/o51V0OIxtAK8qx0=;
        b=CKOeQz/aHd4sVSs9zGYkeKE10EqCb92LLaiGYej3jExMNGY3IsiRw8XJfKDt00PWOq
         xNLA2Wrp51V88sBYm2vr2OD6DsOSkYR45n02c+bAIio8h8iscexoUK1q7fbg+/U6LB9U
         5jNUbN01xyRIWSR9LINXBqWU6BJ9ePSYNyJQ0/MG9H1rtmY51gNenIsyr+uuF61yUak8
         XGyeZERx9+GqVa9TqjKUdT8qkC371rCzcYLBlDOlqXZKDCTJEdklJGcac8luZpBKCDc7
         rGrAg7BgGH4ulsegOUKWqyBcdFN0cYuFdA0uJanI+4don+K0Pyl6fkXwe/RkzMTrJ0oM
         +akA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712471465; x=1713076265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0TxNP5ukGCjKIEdOUAnb8TNyxv/o51V0OIxtAK8qx0=;
        b=T3h3BoFmMtPtdsUWXlJXRq7ElS6QoeKyFx8qsDUKaI9xIhxWbu4QBcrM0B8xxEb2v0
         kKIE4sXTpmIsarZ/1zGNOF2ftRCwKHyPcHsxyNEvXZGC3zXvXcEKLrJ8n8u8c1InWzjj
         M2htMgRalQxpKWPYZa7Kl2iao4h0Em1f9Wl6iq8CodTOELvcJJqQ6dlX4zU+1MO5zwml
         89LM9G+Aq9nqmHu62D8dJoDgk6CZ/ihfiUTr2Z21CFutwQLCMMFwSgqLM/qRPknArOKM
         pGhzA+VCHupzSdPReHnE+/urZlyqmKE9CbVr0tMxOZ2geAcZVqF9cJZoknLmVE0Og9Jg
         6NrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8Et40F3vPrpdtNCUBckQSIRfs+Y4oUC0CvpwcOHqYaSPpE+7/M20pVXmDRA9VdhYC4B8rU8BeDsB/sg7Twtz9Mc2n0gc4htzl2dPl
X-Gm-Message-State: AOJu0YyENHlDufpQAar4KTV4cEchIvbfsOMV7LnnKGYPN8ODEIVP3yvV
	JCuMOlKU3q76H2ftCuu4qqmD8MKliNj1ykg4oep995uEVl7o4NXa
X-Google-Smtp-Source: AGHT+IG2nUt92rcNDvoOt4O/AyiK70xXaZdfxjmL45kPB9Fr4ysLqYiBC8WGR8PWdZ/XkBm9LCJB4A==
X-Received: by 2002:a05:6a00:98f:b0:6e9:38d0:5019 with SMTP id u15-20020a056a00098f00b006e938d05019mr7497422pfg.0.1712471464780;
        Sat, 06 Apr 2024 23:31:04 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id gr6-20020a056a004d0600b006ead007a49dsm4120547pfb.49.2024.04.06.23.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 23:31:04 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: [PATCH V2] drm/arm/malidp: fix a possible null pointer dereference
Date: Sun,  7 Apr 2024 14:30:53 +0800
Message-Id: <20240407063053.5481-1-qq810974084@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In malidp_mw_connector_reset, new memory is allocated with kzalloc, but 
no check is performed. In order to prevent null pointer dereferencing, 
ensure that mw_state is checked before calling 
__drm_atomic_helper_connector_reset.

Fixes: 8cbc5caf36ef ("drm: mali-dp: Add writeback connector")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
V2:
* In patch V2, we additionally set connector->state to NULL. In this way
we can ensure that there is no state pointing to freed memory.
  Thanks to Liviu Dudau for helpful suggestion.
---
 drivers/gpu/drm/arm/malidp_mw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index 626709bec6f5..2577f0cef8fc 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -72,7 +72,10 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
 		__drm_atomic_helper_connector_destroy_state(connector->state);
 
 	kfree(connector->state);
-	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
+	connector->state = NULL;
+
+	if (mw_state)
+		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
 }
 
 static enum drm_connector_status
-- 
2.34.1


