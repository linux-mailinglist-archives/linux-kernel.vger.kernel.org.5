Return-Path: <linux-kernel+bounces-14181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B28218D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AADFB2150B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C24B6ADE;
	Tue,  2 Jan 2024 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRpDWh8T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497946AAB;
	Tue,  2 Jan 2024 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d87df95ddso14350475e9.0;
        Tue, 02 Jan 2024 01:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704187217; x=1704792017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RiTUNZ10k6wQcCp803CcT029DnaSpcGHPPSc1r2WfXA=;
        b=YRpDWh8TO+EGwvwor/shnHwjGmovh9vqxQiqr8qVwJHluyZn62jC81eSc85+3kxpNt
         Y0W264auWsrTBc3E9zP94YPS4j4p1m5VYqfRH2N3nabG8I8KJNt8LWHrWlISbcqPXoGx
         AlMwq7LSIlF7MfcDhpf5+CRnYdstUGUtKjZ1TBGJxO3iAqkOuMSktNnb3992XsrsTe9M
         d+ygAxqOVnoel8cYeL66f+2D3BluYLZ688MPr6xQ5+7rzs1FlDwPsAeDkiK0A5uchrCH
         kNok9yMk3jL1SNpZRYmWP8qFJu/sy8RwgXasPaP5h4sbzSQvNldj6WjsIZeZ9fY1MQgk
         cv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704187217; x=1704792017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiTUNZ10k6wQcCp803CcT029DnaSpcGHPPSc1r2WfXA=;
        b=vg+6QTUrgTqVsaLcH+ZgRZS6E8RT2RSXBVP9is+UX3SgEPAZXlMUct/ZJufPPywUTY
         D89yFlH3vZrsPRuhBRkv9od0eqXQCQ/8ieEcQKOyIjt8Sdz7S11iAl5nmZ2ym9MJyyfF
         Jo9ZEn7/90r/PHgwtcgnz1zJ9Q6sz2TiLauoQ9jj04RnpI17EBZBt0jjfjSIXhywVEJK
         /BXvMtG6nUs/tEbHi24PhVXRTIB43kC85EcSFW6w8F1Bwkqg6679n63pFaf2kHOaAh5R
         d7EyVuF68wR4Pt8vsTH5GOF3rwe4l/xg1SDnTPCt2IfJq02B2YfLBBxZEVJIE28w+uzw
         INtg==
X-Gm-Message-State: AOJu0YzbK7UyijDnXKrgEQY4LFRuDC+JEiZ9jfsVsJjwCuhesBtiFucO
	gOn2W40ORLnD/iK4+8izIXM=
X-Google-Smtp-Source: AGHT+IGsByEPoucSmW84vcGQlZDBldsoqIytSqU80ojmxB3JqT27shPf0a4zX0slvmtrE8yDClVpeQ==
X-Received: by 2002:a05:600c:1910:b0:40c:24b1:8d07 with SMTP id j16-20020a05600c191000b0040c24b18d07mr4674540wmq.192.1704187217232;
        Tue, 02 Jan 2024 01:20:17 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c001100b0040d44dcf233sm38266096wmc.12.2024.01.02.01.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 01:20:16 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/xe: Fix spelling mistake "gueue" -> "queue"
Date: Tue,  2 Jan 2024 09:20:14 +0000
Message-Id: <20240102092014.3347566-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a drm_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/xe/xe_wait_user_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
index b0a7896f7fcb..b3ccdcf40557 100644
--- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
+++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
@@ -147,7 +147,7 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
 
 		if (q) {
 			if (q->ops->reset_status(q)) {
-				drm_info(&xe->drm, "exec gueue reset detected\n");
+				drm_info(&xe->drm, "exec queue reset detected\n");
 				err = -EIO;
 				break;
 			}
-- 
2.39.2


