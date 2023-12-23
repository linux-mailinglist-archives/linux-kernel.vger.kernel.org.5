Return-Path: <linux-kernel+bounces-10547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F26281D605
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20791C2083D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC075168A8;
	Sat, 23 Dec 2023 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RlOSQJr2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8515EB7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a235500d0e1so297959466b.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 10:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1703356406; x=1703961206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ruRMkuxTLRfeG6Csq4ElIsO4M1/KCLiyHuWeJfvDVGs=;
        b=RlOSQJr2ZMihrcg9RY3c6AH5PDFPWX0kJ7xErKeG8xQGqnMHqS61ZfFr3tiTbCZv+4
         lEo0ztlRTBHNPoszNlOzHm82XKL/p6EoOjFpnqEzKlKIgkSnQtchd+dMsJKG+sg7bE53
         9/VwfiDIrEH1Q0cvCVNd5NQA/gbPXK1RDBopo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703356406; x=1703961206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruRMkuxTLRfeG6Csq4ElIsO4M1/KCLiyHuWeJfvDVGs=;
        b=GgsTthNYzQVwdJkPwPwm9MNDuqxEjQr27QWJJjGj6xaKW8psyBI3+a3j+CGQgE0P9L
         8RkJ+SSBXGlWoJJDpqu39Fb6qWhhBZoOMNMCQsL+nj2StFsugx7Sh1I3rUPhRvEeTzh+
         D6xhT9WXHiS1+IbTbw/Bxn3jEsOy/0SxzNhwA/NNI7cdlgZyDwa2LfLfxDsX2uYME1Ap
         zwSu5zgMYMqZerL3SXvfNFNsRUvhnosItJc6nBOVunIwI7rzUB33nOtjEHRzdFj7ZTug
         Mdt+xmmTcJg+P7OvZT1rNCw815PSn8CdNpGeQOHGtYRquKG6+07OJve1/fDby+6S1K8M
         TngQ==
X-Gm-Message-State: AOJu0YyjAUmS5drNF3ol/uJfrwelF27MhxcwZd+Wt+3Uudv/kfhOTeY1
	y6u8Vdz+QAZ312/pfu6+4jM8gXDGarbr1ZaHz9zQPRzVcZZ5Lw==
X-Google-Smtp-Source: AGHT+IFObCoZObJ9xG7YLuA6LJhDM4BoJEQE/rko43dkA/DzcHeY/t9X5gJmWy9epmDUOKgTOv4XsA==
X-Received: by 2002:a17:906:10b:b0:a26:b173:ff92 with SMTP id 11-20020a170906010b00b00a26b173ff92mr1409440eje.65.1703356406378;
        Sat, 23 Dec 2023 10:33:26 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-79-50-102-81.retail.telecomitalia.it. [79.50.102.81])
        by smtp.gmail.com with ESMTPSA id kb6-20020a170907924600b00a26b024070asm2290910ejb.50.2023.12.23.10.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 10:33:24 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/debugfs: drop unneeded DEBUG_FS guard
Date: Sat, 23 Dec 2023 19:32:48 +0100
Message-ID: <20231223183301.78332-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Makefile enables/disables the file compilation depending on
CONFIG_DEBUG_FS.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>

---

Changes in v2:
- Add 'Reviewed-by' tag of Jani Nikula

 drivers/gpu/drm/drm_debugfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index f291fb4b359f..f80d9cf3e71a 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -45,8 +45,6 @@
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
 
-#if defined(CONFIG_DEBUG_FS)
-
 /***************************************************
  * Initialization, etc.
  **************************************************/
@@ -588,5 +586,3 @@ void drm_debugfs_crtc_remove(struct drm_crtc *crtc)
 	debugfs_remove_recursive(crtc->debugfs_entry);
 	crtc->debugfs_entry = NULL;
 }
-
-#endif /* CONFIG_DEBUG_FS */
-- 
2.43.0


