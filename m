Return-Path: <linux-kernel+bounces-162953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4D8B62B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8A81F211F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D141411D0;
	Mon, 29 Apr 2024 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODBA3keM"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551D613F00B;
	Mon, 29 Apr 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419584; cv=none; b=mssbUdXiZ+IN51seSQU1t9g3OLXn5XBQlUyI8ZdHyTNEv0h36/8l9rDLd6xFz6DtBRrGX/TK90xouEdVpyadn131yKljoSdmaXmd8grc3oknVi91bl8TaAek0sJ0DeKPph60oi3NVdHwD3lAZK/2UVrCQSQBuRU+NY+C3QXV3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419584; c=relaxed/simple;
	bh=rRAJuYHrOhx54zIIngzGCtZ5j0rhacITWG9/7iNvQw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WR2JIZ7DPw6cPk+9ATRtqxbZBsWIhhjjHlxMUJCE36zGax4FnKxv+42ClUVv4nz55tIN+1Q4RFafPKIneWMVKoOwDry+JXTxDd9z9p/hV0RywaNqUm1m/6cs3PWfPSSSo2NQN6lMJptXAFaaNFjQKE826IjHt4Lt3XBD7VLI4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODBA3keM; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7daa6bfe4c8so206158439f.1;
        Mon, 29 Apr 2024 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419582; x=1715024382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ie5rZ4dsMUbEYAulp2798W3AJ6+dgFCJhLzBPJXIbz8=;
        b=ODBA3keMufT9mlDPhTkCtccoLIwMhdLwFILxGDr706RGcngoYiW1C9cYbBvFlnyDY0
         Kcz+lfdMjuxwKLBC5H0AcmaZfhf1EDFm9aVp5eteeN7F2cPohYKdINQDp99D/5mm+O9i
         Z5IKRBm/vaf1RoFCNg87975YseBYjO6GR2zttS0j4jjpzOdGSpOOGoQWB5fNhJ4+4A9c
         1ecPNb2JPUffjeCVAb9a67rNEZ7SzwO2UUQYyEG2lv3igFD/7TuuY8TeWRLB042zZt49
         i0R75m04P1aF4PAzwEzef2xlzbNWPE12L06DiumhmBJmtALZLGe+W9gJfOJdVdS9n7x6
         aNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419582; x=1715024382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie5rZ4dsMUbEYAulp2798W3AJ6+dgFCJhLzBPJXIbz8=;
        b=hQ7leEf4kI37khsTsDb44etuh1splkmdmrNatRm6h36kY1BxZDeMOcq1klhlF98yRq
         07J4BnFo532qojuNW8RQCeaXhbwQfMV9ERUM82eTqgeVSObEdRlXpzrZKE6bhoxTcNgR
         YTfnYWQJonEFUVsggqjvMSqfa42ZHqWcZjhXwQ2WBtmtq1nX+A0pZ7wHDLuBU7+cebPY
         M6H/7f5BMEfcgrJ+x0LVR0kRyxtUWu08N7jx4HnptT+iyLnmyHJwm45Hc1jaq43u3s24
         HM6uDtIrcGTQ5R7DrUvf4yaVwsMaCpnlIIQi6hXw6nI/gTeXF4qfKhbcS45wMq3ZbFA4
         13rA==
X-Forwarded-Encrypted: i=1; AJvYcCWKYTOTDK8RGykftrompXz/WPyVVVbeLWjmrSPDyCcJg4wrbX9oYPT3oZHW64AkCKtpguLmF7akk7+wYCYhP4Dl7dHIlnvSplRXIxdunPfwqLBkLquTkaMfIo4EE/xtlDse4f2YU/dY
X-Gm-Message-State: AOJu0YzzGKlyuOybyaEJ0/4KJCcKubk+S1wz6bubDR44lY8Tto/XbAsU
	BQjsSjJEQMH1azdHJmspuGvFp6YU1Jg5yql7YSVLgkYp6yqy4iyX
X-Google-Smtp-Source: AGHT+IGrQCUh7NJG66NLfClNiBakmvFViipsgTmeiMMctP+y/nuBqnI1oha451gFi7fkgh3cY29+VA==
X-Received: by 2002:a05:6602:2759:b0:7d5:c987:3239 with SMTP id b25-20020a056602275900b007d5c9873239mr888946ioe.16.1714419582384;
        Mon, 29 Apr 2024 12:39:42 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:41 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 32/35] drm: use correct ccflags-y spelling
Date: Mon, 29 Apr 2024 13:39:18 -0600
Message-ID: <20240429193921.66648-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193921.66648-1-jim.cromie@gmail.com>
References: <20240429193921.66648-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Incorrectly spelled CFLAGS- failed to add -DDYNAMIC_DEBUG_MODULE,
which broke builds with:

CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_DYNAMIC_DEBUG=n

Also add subdir-ccflags so that all drivers pick up the addition.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 104b42df2e95..313516fc2ad5 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 drm-y := \
 	drm_aperture.o \
-- 
2.44.0


