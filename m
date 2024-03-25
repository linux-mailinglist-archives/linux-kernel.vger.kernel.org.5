Return-Path: <linux-kernel+bounces-116623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D521889EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1751C35CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01740145B3E;
	Mon, 25 Mar 2024 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZEz/Wx3"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED143C2533
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711337740; cv=none; b=dCOdS6dtLK4xyvYVQSBFcHMUww6o1/INTCfuNXzSUWDU/KkoCdqFBsPsgweT54L5IkcdvWsZB/4YYnffIq/Df2rPxk5fZTWaw+vktfutrxQFFhl028axdRo/E+E7XynFKVkHlzIUfwdcAn6f8WWeIUz7qTRlJ1OC/8Uq743l/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711337740; c=relaxed/simple;
	bh=jouLekNDdjgpJm7iHqbiTapCmrWek4QuIWw1G5e8bP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mASYP/OxSqAgxJCeTgXbWYUhDltr9/QuiBzS8PXxpDi4lgSGpZ0eVkIcC/WZNP9iKTT7KieERGe+2KK7eNO+Qkvy32KoqkW75gLAfL5bJi2xRFRrF+QfpnUDTGtD49TvCzLdI4hsdayt/zzaFFc97p8iYjPMUDSvI11e+EKYWBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZEz/Wx3; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso2928187a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 20:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711337738; x=1711942538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JsOqF23nizDyVla4cEqGdF84V6TG9vf5xCFejd3HW00=;
        b=HZEz/Wx3xf/v3MrjBe2jHSbUpvg1Va+WXq1g90+Fni35VJxqcYxx8XjqIRUAygUExf
         Q+Prwu2au1uhUpl4EBiEY4F/EVFEAuIsfz3k+5PtDmJ84fJz0EtX30rYqFfrwNfP7KMF
         xeuSeDVjkGcEO6eBYk8TUZQp84HUCxK7OxY9u0fGaMXgEmgIdDcjBW2NTBiE7CJSoIIm
         W/ZmfyAL6M0KkjiakVtDofpnggfnTuNbG6aeMZRi9VFf6rIWAnrKeMqERxWl0OcJT/5L
         pWuIkaUUcREyE6F6tff9aAFPtkBkC8Gaw5PmIQbmLCJ+o3V/xB0aFjTxVux5QDXsYxOQ
         KRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711337738; x=1711942538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsOqF23nizDyVla4cEqGdF84V6TG9vf5xCFejd3HW00=;
        b=YFCARSh7gM5dDxh4uUQTiTIHVuynEAMfy1gThDkM1zbygcfdpXMdpTuWIc5cX2JPuG
         dbwxrkek7nhrwH4kmY7J7Y4nB+LXSP2suVplcJN2yGPk19WeZmJDt1BZXWQDhT6OfvPw
         B7b/X770IvAsorebFXFuvMAsEQNyqciti1oCUKp19aDp5JlZvrvbn7jCPOT4EFVYMOYY
         sn0Pu4LBXB7+jb9L6k0dGOGGFttDCLLewsub6LQFr8DBPmPiVo7bf2B8G6yY1CE5fOfY
         OCkZ6fhqwsIubN1U04Svwt3aVyjgqXgoOmOY2Zwv0D0fKzvjQw92dcvUQzSKsJv3CO4H
         d3BA==
X-Forwarded-Encrypted: i=1; AJvYcCXkr/LzjodWZctfawmI5+dQfBQgLAuVf3V/ArTLLU4sCs+QRAC3l0vXXDdLvKPPIxE2LXP0LbBzWEVR16MaJNrtxhdq4lcEVMJbjp6y
X-Gm-Message-State: AOJu0Yzrw8JvXRxOgyCWM6ryINGWDDXFsf6Vue0uMRcjNkZgH4pjYUzc
	8FvoH0j1m/4am966s1E50CBgrCSdXqr/mhO+waUTaACfOnOEyw3P
X-Google-Smtp-Source: AGHT+IHKAKPuNbizbOLeilWfOH0Wq1WODiKdBvp4HX4Sqm8mUd+l6HnF45FHhvBSOfzobqhcOf1opA==
X-Received: by 2002:a17:902:9a48:b0:1dc:79e3:c8ed with SMTP id x8-20020a1709029a4800b001dc79e3c8edmr5420981plv.31.1711337738516;
        Sun, 24 Mar 2024 20:35:38 -0700 (PDT)
Received: from JammyHuang-PC.aspeed.com ([118.99.208.177])
        by smtp.gmail.com with ESMTPSA id j11-20020a170902da8b00b001e0c5be4e2esm366837plx.48.2024.03.24.20.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 20:35:38 -0700 (PDT)
From: Jammy Huang <orbit.huang@gmail.com>
X-Google-Original-From: Jammy Huang <jammy_huang@aspeedtech.com>
To: tzimmermann@suse.de,
	jfalempe@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@redhat.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jammy Huang <jammy_huang@aspeedtech.com>
Subject: [PATCH] drm/ast: Fix soft lockup
Date: Mon, 25 Mar 2024 11:35:15 +0800
Message-Id: <20240325033515.814-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid infinite-loop in ast_dp_set_on_off().

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/gpu/drm/ast/ast_dp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index ebb6d8ebd44e..1e9259416980 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -180,6 +180,7 @@ void ast_dp_set_on_off(struct drm_device *dev, bool on)
 {
 	struct ast_device *ast = to_ast_device(dev);
 	u8 video_on_off = on;
+	u32 i = 0;
 
 	// Video On/Off
 	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xE3, (u8) ~AST_DP_VIDEO_ENABLE, on);
@@ -192,6 +193,8 @@ void ast_dp_set_on_off(struct drm_device *dev, bool on)
 						ASTDP_MIRROR_VIDEO_ENABLE) != video_on_off) {
 			// wait 1 ms
 			mdelay(1);
+			if (++i > 200)
+				break;
 		}
 	}
 }

base-commit: b0546776ad3f332e215cebc0b063ba4351971cca
-- 
2.25.1


