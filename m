Return-Path: <linux-kernel+bounces-138158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F18D89ED76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC2F1F21FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ADB13D535;
	Wed, 10 Apr 2024 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBh5En1w"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA313D523
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737328; cv=none; b=ixljCxiCRpUEUvoFvmduVJGJckD/s1kHpdrayT3EDGCxwNDhvhQzqYq4EZed/wNTCEVCfTBxtt2WzLJGHp55Tgr9u85R+8D0KGIZ58vsz1QgAdxPtlCf7eWueCRd8vCkyk0AXHjwCgDY3PcTrJ/+Wo9CAZ2LcF1qsx5EzGF7tjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737328; c=relaxed/simple;
	bh=oVhrHRXJ+JIB3beVQuHOwZ8d/Dj9iVDvBh7V56NZIKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZX20VbYx0q26LAQhKTB3pC+jBGyzr1UtfYECGLm3+SOwW0V2GxzTjVhb4xqk+VbxkkdzPaZfq+Kt7SrOX08vRIx2p3Np42zlPAfANhmx0iXeKH0cxON7+smJRLwqZA4eZ0T2j39ktL+Q82GcgIJNtH2YFv6Vzt8utGVDNrw97sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SBh5En1w; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso4630214a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712737325; x=1713342125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W08OGW7A4d8BhMW37wsOsXgyIhwpe4nsHm/mzDoOZ2s=;
        b=SBh5En1w7eOI/ZP2pIgI7bfkw5Tno861i/t5DbzBjmlG16zoec21iN/Jawv+W0DDiM
         R7Umo+PhIKuDggslLahV4N+FjCf132XE9f8e98dAKOILhIoRSvudSkK9FX/5GLl9P+rs
         L7VnUAjxjyEbhIOwpLIXoAxumhz6K0J7s/wI/hKz0vzP3rRe3WtG7XHnV89LYQREcU1b
         UwY1ZS6hMfu1g4fC87u2Do6hCl0I3Y7ijWLolGxl5Y9jdssSzgf2WdtpPaEpZgqaEp8g
         vbXx5qZXdCT1JpuCYK18ScPalZxgBW/xf5hGhoUAvCoSU+TnhqNICDlVX4yDVjjm4U9t
         uapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712737325; x=1713342125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W08OGW7A4d8BhMW37wsOsXgyIhwpe4nsHm/mzDoOZ2s=;
        b=oNwrasS/AjeE47WQDMi0i1T9DMH26ViPI48I01WXx9PoWDy0b41RCh5ELMaU7OkDV1
         gPr+EFOx1A4nXlwXZ1g5wrKrbnWlaeY0lPGyXbgpGR4Md5Le1doTO+dUOAfOfzRmSSbB
         +eZoWzAr4yYEk05VxG5PpHhY/wUgFwY+mnsREYyfeVUIlHat0+VEm4yL6j4gcbWE1R1M
         tvPmf0u7RKx73glkAAOYG2lvOqEcttoIq3GaGrW+3O5OYiVPrimE1w9En6xWkptZWep5
         onJiKPEDYB8V4hZUdPUayTgTN3IZXSfo6JyWw++jsWyizsWFLNL4q8bkxuBtNq4B8uME
         omag==
X-Forwarded-Encrypted: i=1; AJvYcCUDH7Xq/65YiVr3r9tcR+zh+4J1PjSoqGzI3tlsCfu4HHsQFPip7Vdfsavb9ttlRqv1g80dyMZ/Jwz8x1vg96Puox9Y+uPdwV7WMeh0
X-Gm-Message-State: AOJu0YyghZ/3zu8sqeP+fewjYqdsIl4QJ/ny+mgbPaIkN6DTG7eG62GA
	iuDxuj/1yDNhycyYq5XHRACSpTLO01Au2yuREZLt4dpoq1nijvzpgURVzSjFhja37rf1jMcDJKr
	t
X-Google-Smtp-Source: AGHT+IHO73OLzGBnIHP93WS1ck0o5UXo3asRI3ASj0p6/gpvUaKa0lWpEeuhDhRuJT5EmaJztPtzzg==
X-Received: by 2002:a17:906:dac1:b0:a51:c332:45b5 with SMTP id xi1-20020a170906dac100b00a51c33245b5mr1733543ejb.7.1712737324817;
        Wed, 10 Apr 2024 01:22:04 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id y15-20020a170906448f00b00a51d250a1a4sm3902836ejo.80.2024.04.10.01.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 01:22:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RESEND] drm: use capital "OR" for multiple licenses in SPDX
Date: Wed, 10 Apr 2024 10:22:00 +0200
Message-Id: <20240410082200.44966-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Documentation/process/license-rules.rst expects the SPDX identifier
syntax for multiple licenses to use capital "OR".  Correct it to keep
consistent format and avoid copy-paste issues.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Resend...

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/drm_client.c        | 2 +-
 drivers/gpu/drm/drm_format_helper.c | 2 +-
 include/drm/drm_client.h            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index 77fe217aeaf3..d8e3427ae205 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright 2018 Noralf Trønnes
  */
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index b1be458ed4dd..2348135fb6c0 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright (C) 2016 Noralf Trønnes
  *
diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
index bc0e66f9c425..1b907709115e 100644
--- a/include/drm/drm_client.h
+++ b/include/drm/drm_client.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 
 #ifndef _DRM_CLIENT_H_
 #define _DRM_CLIENT_H_
-- 
2.34.1


