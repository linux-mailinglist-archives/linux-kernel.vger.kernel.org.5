Return-Path: <linux-kernel+bounces-162952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAC08B62AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4A31C21D13
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9732D140E29;
	Mon, 29 Apr 2024 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS/8CaIu"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ADE13D62C;
	Mon, 29 Apr 2024 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419583; cv=none; b=c+UbisIuw5vSzBEJuXNAYaUrc8JInXZgNAe1DIleVXiXFx/SS0XmEJdfas5230ig/V6mQyrPrP8Z90J2zrNzMJo5eUo2r6xFfNxIdIgK1HPYPtJWPbWbMy5/rMERBoYFZvY49UCBqznTZa/tbnH7co3USwtjc50GTO1zRzu8vP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419583; c=relaxed/simple;
	bh=+ZMtWk5lsJs9+6y5BoJzBbSCaGLSzqkdNg5i4sHJHsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGX1l3yL8VdpfPGZxaFyBtOcPrJU5EHtO9TplP2zsiXt8gqn9XbqWx/HDI0V2mKO9gDhKwtbClB8kcU2AxCtJZS2AUsA0Hlr0WpNRWEcGk6Hm1d3i794fG9kxsRna2vCwM/OJQfGNuPYrxYPaG5I7cMcaXb05+A438p0bIIR198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DS/8CaIu; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d9c2096c29so216936139f.0;
        Mon, 29 Apr 2024 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419581; x=1715024381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulaYyaVft/YyoU0+fiQtajkDbj/WJZ88JMn79Ec/vX0=;
        b=DS/8CaIuecXi3X/oVizeRXtAa9T+etjg+1grox7p/QVpoeEu0sASOfAcB6zV4N17CN
         PS3u1MLXPF3LWU8Yq1z+u1v6faa44rXkz2QTu5roFNn8KrHgOqKTmZhMIuI4xz8gmBUs
         lulEIUQlkBr4cNfMshLH8dAzu75tikEPaasTJ+bTMIgz9wAv54UmFzkPljERFjEQPF5h
         8PhkTt3JuuysRlBualBtoCv63l26jNiJbpVIhyv4jViRiPS1KjvNCiFNPaMVxBwMseXZ
         EeCYyXSZ4t8iAmXZWaTfOSt8UstVirZcFzIsQJdWruJoGR16+ecbDdUI2QvOa6WhQop/
         Pn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419581; x=1715024381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulaYyaVft/YyoU0+fiQtajkDbj/WJZ88JMn79Ec/vX0=;
        b=oPFt9WpK2Ncv7l1qE/2qXffV+doeUnfR4qpj6aOrKx4MirxR9x6uf7t106LT9Fcmjy
         YBbtuxA4/HmuY86hv3hUCSucuICogTkgrpY3mCl3lK4qSdXLyj40xr/QHJKfL0ldL7NG
         dR9YosCe6o2jT3djKEexlCNepZl8kFBlL61X+mZAA3iuRMcU7U//6RqozIijc3V70F/e
         RIJEOlNfXVIEpvc0hjVhNXadYavprb0imTqxYTxZA+w4SnL5Mkf6MasmsJu9mmjWTILz
         R1dAQNVHeYROCuas30lPZKUiBbCBCA7SQzPvm36kQ6j8g1zmmRLXjVyov1Ps7reTx9hL
         H/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb36BXtYMl5DGWAhev3pcPW9Y20yKT2+HTMpvCy/BKD3Sy0nyrEWu+CEXrbD+YDofCuWaNjK5Ecprn36Wiceq4s3n2oGV21M34HFINcuxhm6o4sWoBzcM0YKHfSwh6Or4gnkl8Vl2w
X-Gm-Message-State: AOJu0YzG5Rl0OCepsf17RDLvyOU2BCZme/FZGl1tRWeG1zOZHzVkuKBc
	VT/TtF3QedzrS5x+QbG7Tujcyh0dRSyyYo8/IsHsTmh2xpkK43Vm
X-Google-Smtp-Source: AGHT+IHyNsWP7Nzkt9gGnd6X8Rl4lpNvOOIYqiWNC2SKAWyiinyhoOsXf738AKl1GY5d/CNNu9onOw==
X-Received: by 2002:a05:6602:25c2:b0:7da:18b8:a4fb with SMTP id d2-20020a05660225c200b007da18b8a4fbmr13508509iop.9.1714419581091;
        Mon, 29 Apr 2024 12:39:41 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:40 -0700 (PDT)
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
Subject: [PATCH v8 31/35] drm-dyndbg: adapt to use DYNDBG_CLASSMAP_PARAM
Date: Mon, 29 Apr 2024 13:39:17 -0600
Message-ID: <20240429193921.66648-12-jim.cromie@gmail.com>
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

use new export
---
 drivers/gpu/drm/drm_print.c | 8 ++------
 include/drm/drm_print.h     | 6 ++++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 4a5f2317229b..efdf82f8cbbb 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -69,12 +69,8 @@ DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
 		    "DRM_UT_DP",
 		    "DRM_UT_DRMRES");
 
-static struct ddebug_class_param drm_debug_bitmap = {
-	.bits = &__drm_debug,
-	.flags = "p",
-	.map = &drm_debug_classes,
-};
-module_param_cb(debug, &param_ops_dyndbg_classes, &drm_debug_bitmap, 0600);
+DRM_CLASSMAP_PARAM_REF(debug, __drm_debug, drm_debug_classes, p);
+
 #endif
 
 void __drm_puts_coredump(struct drm_printer *p, const char *str)
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 905fc25bf65a..95c667934bbb 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -141,11 +141,13 @@ enum drm_debug_category {
 };
 
 #ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
-#define DRM_CLASSMAP_DEFINE(...) DYNDBG_CLASSMAP_DEFINE(__VA_ARGS__)
-#define DRM_CLASSMAP_USE(name)   DYNDBG_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_DEFINE(...)    DYNDBG_CLASSMAP_DEFINE(__VA_ARGS__)
+#define DRM_CLASSMAP_USE(name)      DYNDBG_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_PARAM_REF(...) DYNDBG_CLASSMAP_PARAM_REF(__VA_ARGS__)
 #else
 #define DRM_CLASSMAP_DEFINE(...)
 #define DRM_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_PARAM_REF(...)
 #endif
 
 static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
-- 
2.44.0


