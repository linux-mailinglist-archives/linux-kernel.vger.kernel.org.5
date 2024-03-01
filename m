Return-Path: <linux-kernel+bounces-88464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7886E1F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17738285EF6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAAA6D1C7;
	Fri,  1 Mar 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTZv/v1f"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5E15A8;
	Fri,  1 Mar 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299700; cv=none; b=eEBACfnhFDeJd3P/UtP1YyzlB/U9c4TZ5ctTG7hD870RXI55C5C2MVWqgRN6DIfUGcIfUV9TmcU1fXmwdLFCjbXTSoMc185OvwTp6yPHJPg3FM45c9TjxgTmB9IZD/v+DyKVAfYISm3gQdVyQSbsTD0hWTYGepPBklNuEpz7L8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299700; c=relaxed/simple;
	bh=Ne7dH1YsRKndqImN7qVo3FJxjqh3u3bK01mCPanSgos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qusMSA1T/k5D7iXbu+/lHNWk32Z+BdHEObQo3/wuShnwJ95NdKVY+79OJYe6MdmhJxUIeommB7y73VtZEwLTTrilNPV+CrPRTkJdyxsXZkITM5pbxx2jR6qrI5tTwBXgfNfCnSl8kDxzFr3LJlD8BsjVvkaD5h7JroKKVDeIqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTZv/v1f; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d228a132acso25195531fa.0;
        Fri, 01 Mar 2024 05:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709299696; x=1709904496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5l7YTgHQJ4uu8ywnkoccEqji+CWQ03nsYaLhWI1QXxI=;
        b=WTZv/v1fdZF0p1uXzmMoWQPhWYoPWZYwZzILIbpZQWpzU+8+P3QeoQ3Mn0tsTSgfQc
         b8CWzBh6H3+zG/ACQvRKF5VBv6ukdsApv7kZW4stHFKCMO6NibB9wgk6DRs2ZzmMszof
         fKSjDO5vxE/xCvacLgJu88PJLOcCvdWGv9qQlDV10UrgHEt8MP0HncFnGXDmEBGLPMCw
         aGH/09yYBYPha/ui4vDlJ4991GY6Lp+ZVaqex0K1/M+0+rLvzIQtuRdmAjjIu5/5lXLK
         BN+TZy2yFOezvWkRVjh9kjsFF4ybT0/Up2lgArc7Uz20pEUZmyEt/CmQLBMQ1g8Aj9XT
         qdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709299696; x=1709904496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5l7YTgHQJ4uu8ywnkoccEqji+CWQ03nsYaLhWI1QXxI=;
        b=De2c9lVT2jCcja/NmdU2lV7A6uxU7sPNMn2PDw2FrNRWN/otL5WroqPbQ2UGU4ssqY
         /9TvXmxZjvaE/VGUCxzUXspb+J7eN1W7q7cw29o2Wa5oEBtWYVerQO/QcZ8XEmdxrcKW
         7Unff3UOvfYP03vkIeTcucsrilw6dY5xYleaBcPdWWtZzc2q3cNdrMP/kSFWGnGpwN+w
         eqVg3qG/VejAlpEsRYfYfjDSAi9tYHIt+dn4Ruk5aqVqKqpBFCJ92XZLeM3f4A242Oci
         uM5kR5HZGs7MjSjDUbdFBdW8rMrt5vJPHanoQ0NgJbwWlhhGyH2TWYQJuB84PiRpK/xz
         7iwg==
X-Forwarded-Encrypted: i=1; AJvYcCV/jg3wL2asCgy10OoH/DjKltdU0TD7SsiBSozvpxL7bo1r1WfKWTujCazJgCQsa2mVw9v+ss7Tq2rmaBTomfzZh92UZiFbL8eBVJZ5Cef4Ugupv9S/Q0p22jPPcAKaYmTkB6KQ
X-Gm-Message-State: AOJu0YxM+Pl9JXVyArmn1eLZqo6zkHuv9tss2Am8K2GJPzUhM7RAfdFP
	EwJqN7j33Z1w2Erxk7xg6LFEgID0gBZ4hBrnfjwA4ltccwExcpRD
X-Google-Smtp-Source: AGHT+IHAEBq2eERb1YzHcNf/A5asZKhYcTLxJdEqg8fO6iB0nq2rpd2QfL9efFx0rYhM6arWjvOKVA==
X-Received: by 2002:a2e:a368:0:b0:2d2:a3ae:b339 with SMTP id i8-20020a2ea368000000b002d2a3aeb339mr1177503ljn.48.1709299695979;
        Fri, 01 Mar 2024 05:28:15 -0800 (PST)
Received: from localhost.localdomain (80-108-76-242.cable.dynamic.surfer.at. [80.108.76.242])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bc8c8000000b004104bc8d841sm8317526wml.13.2024.03.01.05.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:28:15 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
To: tomeu@tomeuvizoso.net,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Christian Gmeiner <cgmeiner@igalia.com>,
	stable@vger.kernel.org,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/etnaviv: Restore some id values
Date: Fri,  1 Mar 2024 14:28:11 +0100
Message-ID: <20240301132812.15463-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Gmeiner <cgmeiner@igalia.com>

The hwdb selection logic as a feature that allows it to mark some fields
as 'don't care'. If we match with such a field we memcpy(..)
the current etnaviv_chip_identity into ident.

This step can overwrite some id values read from the GPU with the
'don't care' value.

Fix this issue by restoring the affected values after the memcpy(..).

As this is crucial for user space to know when this feature works as
expected increment the minor version too.

Fixes: 4078a1186dd3 ("drm/etnaviv: update hwdb selection logic")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---

V1 -> V2: Fixed patch subject line and removed not needed if clauses.

 drivers/gpu/drm/etnaviv/etnaviv_drv.c  | 2 +-
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6228ce603248..9a2965741dab 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -494,7 +494,7 @@ static const struct drm_driver etnaviv_drm_driver = {
 	.desc               = "etnaviv DRM",
 	.date               = "20151214",
 	.major              = 1,
-	.minor              = 3,
+	.minor              = 4,
 };
 
 /*
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index 67201242438b..8665f2658d51 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -265,6 +265,9 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
 {
 	struct etnaviv_chip_identity *ident = &gpu->identity;
+	const u32 product_id = ident->product_id;
+	const u32 customer_id = ident->customer_id;
+	const u32 eco_id = ident->eco_id;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
@@ -278,6 +281,12 @@ bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
 			 etnaviv_chip_identities[i].eco_id == ~0U)) {
 			memcpy(ident, &etnaviv_chip_identities[i],
 			       sizeof(*ident));
+
+			/* Restore some id values as ~0U aka 'don't care' might been used. */
+			ident->product_id = product_id;
+			ident->customer_id = customer_id;
+			ident->eco_id = eco_id;
+
 			return true;
 		}
 	}
-- 
2.44.0


