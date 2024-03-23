Return-Path: <linux-kernel+bounces-112408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D947887969
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095882823D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745BF2940B;
	Sat, 23 Mar 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5ucRF8H"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CAB3E470;
	Sat, 23 Mar 2024 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711211518; cv=none; b=NdiIZoTRBsHH5BiTfmGw0NCoA37lBtZVYJ0AINPe4Ulw+VmVsz3gfaIJgio2PPEp1qKEI5Ocoirdj2Ctw5/o/EjikqOdyfOrWLCI1jUyYkad722AL4Pex+KCGSvYEhR6ZB4vSK1544w4ixn1XXh9gB1Df44sVinnpegrMQ1SMqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711211518; c=relaxed/simple;
	bh=hYR21Vffkaz1yzdbwEsh41c3XSN5q8lBLdIhHpY99Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KakV96U6JB1pqKyoaGq6YyGl1Dt34Af0h1rFjTVJesbGLTDAa9f/LB9rdEj2AwE0lQo8NyfB/1NtNlC42XepVK9L65VKza5VcmJgUkPtvY1mAy22XBbbIr0bhCbeNU/XJxzJVviQyDq0NzAEPMSLMQiLx3wBtTs41DjbjskvRFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5ucRF8H; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-368480eb81bso13734645ab.0;
        Sat, 23 Mar 2024 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711211516; x=1711816316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+gNAzOlZksAWrrk/Sn0MY4Ibq+h1gY4sUBMqWqGyMMg=;
        b=A5ucRF8HbpjyIkTPwA2YN9ldHLORC4hoS+iSAFQ1pg2bsqejFOV1egxWYii87BOChF
         DhEwWmuw9Dxs6rB+rBrdZ4slxxNdCQ91vPd3SNUlIUFvXdKNgpKQefFrNvjY4Z+5LD+G
         yKu6u47T4Y79k0Ln3oreWqsWWxAOiNW8WxrKlZ1kLKUb1gutjt1vzmSkbPdCMrIcfiyN
         /ws0/mRV/A/ZoWhm7FjqdymCCRDkN9I/La38BanswyRyxGSa7WI1rB0hJEijcAe6qvWJ
         4JNiAtE3AjpeONmF+NPTv8NvkFri/gmvDWJx+TVCo+x2S/4JK96lbFu89nXSDjAnAaUR
         3e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711211516; x=1711816316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gNAzOlZksAWrrk/Sn0MY4Ibq+h1gY4sUBMqWqGyMMg=;
        b=dwRheZDqhraCrEjJcZGyOTc9UDfsQ128DXLxINL6vZiS8fcb11gt25lay9UG03rnVM
         OKH9H8BFEpJkYt69nZNoXBrDxOaBKJUVjYbGn6TU/MF5zwv2jBtSK5MpE5a2/levaGM7
         qbZhhIwcnOpWYAzWreSJOn4bo/9y9m2p6wytdWTIg+6hYUNV2DtcwSHPUlcfc3q7aEcg
         IyIZT1jnTGAKylHy0QQYvHwwkS6WazaL2WefkG8s5ENz4kqKl7U54SaR0reOzc219C1L
         nygekpgd62yfADP4SdzoYTaNGN50JqptEAfVFAdU6TNz55cj9y3dsP0fIVDhZt19JV2+
         /owg==
X-Forwarded-Encrypted: i=1; AJvYcCXaslDdahoLDJIzD8c5/oWlh5TBM/ZzKG1ZUkSg+TrGdgww/GvkLGAIG0VR2izMCMhgmWEoRxWSjBFPpabX5qgmZAXsOCrKFHGmCOr7Fxdxv59meYZCo0QTyOLpRpm3bkFqlKJzgeez
X-Gm-Message-State: AOJu0Yxmv5EbVfksG4L7gBasG6SS1hGp7oBrVWoCbFZUZP6+CNKrc5JP
	YQ5eXxaNBzUOJzY3gX+BOws+T0F4xZFdEdjPZua9ipUywu1eNqZL
X-Google-Smtp-Source: AGHT+IHkLe8WthnCTg9DUJIoNT1vufkGawGIt/PJEEGR7qpZOXaS/myb/s/E7Y1IUAeXIdmR9S0dOw==
X-Received: by 2002:a92:ca8d:0:b0:368:85c6:6bd1 with SMTP id t13-20020a92ca8d000000b0036885c66bd1mr832046ilo.10.1711211516495;
        Sat, 23 Mar 2024 09:31:56 -0700 (PDT)
Received: from amogh-desk-mint.Dlink ([119.82.122.244])
        by smtp.gmail.com with ESMTPSA id v62-20020a632f41000000b005cf450e91d2sm2970106pgv.52.2024.03.23.09.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 09:31:56 -0700 (PDT)
From: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>
To: airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org
Cc: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Fix duplicate C declaration warnings
Date: Sat, 23 Mar 2024 22:01:47 +0530
Message-ID: <20240323163148.23497-1-amogh.linux.kernel.dev@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix duplicate C declaration warnings at
Documentation/gpu/drm-kms.rst that was found by
compiling htmldocs

/home/amogh/Linux_Kernel_Workspace/linux-next/Documentation/gpu/drm-
kms:360: ./drivers/gpu/drm/drm_fourcc.c:344: WARNING: Duplicate C
declaration, also defined at gpu/drm-kms:39.
Declaration is '.. c:function:: const struct drm_format_info *
drm_format_info (u32 format)'.
/home/amogh/Linux_Kernel_Workspace/linux-next/Documentation/gpu/drm-
kms:461: ./drivers/gpu/drm/drm_modeset_lock.c:392: WARNING: Duplicate C
declaration, also defined at gpu/drm-kms:49.
Declaration is '.. c:function:: int drm_modeset_lock (struct
drm_modeset_lock *lock, struct drm_modeset_acquire_ctx *ctx)'.

Signed-off-by: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>
---

changes in v2
- add warnings found after compilation
- fix grammar in commit description

---
 Documentation/gpu/drm-kms.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
index 13d3627d8bc0..a4145f391e43 100644
--- a/Documentation/gpu/drm-kms.rst
+++ b/Documentation/gpu/drm-kms.rst
@@ -357,9 +357,6 @@ Format Functions Reference
 .. kernel-doc:: include/drm/drm_fourcc.h
    :internal:
 
-.. kernel-doc:: drivers/gpu/drm/drm_fourcc.c
-   :export:
-
 .. _kms_dumb_buffer_objects:
 
 Dumb Buffer Objects
@@ -458,9 +455,6 @@ KMS Locking
 .. kernel-doc:: include/drm/drm_modeset_lock.h
    :internal:
 
-.. kernel-doc:: drivers/gpu/drm/drm_modeset_lock.c
-   :export:
-
 KMS Properties
 ==============
 
-- 
2.44.0


