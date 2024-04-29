Return-Path: <linux-kernel+bounces-162921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7061B8B6246
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27103284D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ABB13D251;
	Mon, 29 Apr 2024 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHlfZgf2"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588013B29D;
	Mon, 29 Apr 2024 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419144; cv=none; b=Zy8PfcMlMtuJB2rrMeTk2LDGsQO07pSuKkCSWdr+c4PlIkn5VIfvqAcZS1EvBszU8YbskXPrXIy5nut4Uyw7ffxnTwxEjYKRe+RyG6mjO+GTfUJ1TjmkR1OCLU2wLVFKMqySnM55xSHIxf9Df3JKZEnDZ6vdXjZA3kMXSmsth2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419144; c=relaxed/simple;
	bh=gcHhIOivrLNnx2FvE1ZQVovMowH8r0spdndZ02OXVJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ev1Y0T5OXQ58tWdZ9paQexbRgLGCse5PiaOiPly8KBgdLB9PR8lxD2OAL9VvI4mfTcxtkFfF07iK8NVlyTJwAs8L0lr1tg2F76HsYgJ8275ywIvpYH2N30NAYPnOlnQ1KrZU74Ku0gDNJyVIzp9JyuGqjy5vE4Mfz6aj2MtPApc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHlfZgf2; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7ded01aa1d2so54835039f.3;
        Mon, 29 Apr 2024 12:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419142; x=1715023942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri83bb6oyLyojLzmXoS5Sm7yzWutd/S2ODfs8cE/PMw=;
        b=hHlfZgf2JEkbrxKJsWYQwUrcHSEld7Wt7d4qlmHNDOojaO/0rz78R8YgluFlW3Ojuf
         QYP6ftxTMnZUrd9ybCm6UhzdasLEPktGB27/CxmzDv2Mvman/n5/RKt1u12oGdTbc5Uz
         BYS/byMtTJZwULaLYMv8HXWLnjBFOlicLeBUPOSWa1ryD6XpLASGLJe9LL/qPOS1HrS5
         3jy7GqMhxIZyuZZXi3ON33zxuAk6V7FoPdaalrEjuIZHL6S5UFq9avRGyIG+mWxGOmks
         DivxrvjQLJXirduMnScRPOl4FeyN+WnEwGyoOzL000cnTjakzr6owGYqPTj4tsFj5Le0
         yUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419142; x=1715023942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri83bb6oyLyojLzmXoS5Sm7yzWutd/S2ODfs8cE/PMw=;
        b=Ub05Ufm2xgqCl34qYNjpp3pV5LvAABaSjboVa+23xLrf9XZimKOfxooR634yl2ftDN
         wtyvjgWUWg4Og4lyX5f7t/C1F3NEon4VyJLWqS9AJKo3D9tIQ3TvLloDS0tzCDZTIvds
         ggdpjpEAUuXO3YUHsGBWjW1Nel60R7lXkAQxJi2hO4UOWAklhmZqulojdXBSdLipd5Ys
         eXr5XvS/+kQ0VkpwQGvHoSAUov0lEWYNLuAg8AcD8daT/fAKYK4dyvVQXOMhztLEBLzw
         y/hbt5qe5j2IaW+64PPAiSbV7XJzEbbWySsqxo5oRPKqTBeM/nEE0wXgNNLufcI6wDsF
         47Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXZgz2LC+EIT2cCnQDxxH9Ia65H6WfpKHUgWpbNzqpuWSiD4UDKYKwqIWv14G/NLVh9KkusOscGUbl56BUVdbCpm3OK8H+O+/CmzxOCEQVGe/LLU2G9YnnW18+mMHR/Y0xBU87+eMAH
X-Gm-Message-State: AOJu0YxsPeX49Yl5AAxoZI5bkaztcMq4a149+E871JMLAXcoC45tf7Rg
	qf9mP44+i77XQFf6vuBABNBa/tSE0m3ZV6wjAtBq/1xmubcQQdkV
X-Google-Smtp-Source: AGHT+IH7L9iz/DEu5n/0SdbAq8tqvCL5guAdpohYvgpP3KLiQ+nIg6zPIVZaEFBq7zLzebD/k1+gdw==
X-Received: by 2002:a6b:7414:0:b0:7de:ba89:afb4 with SMTP id s20-20020a6b7414000000b007deba89afb4mr8711060iog.1.1714419141923;
        Mon, 29 Apr 2024 12:32:21 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:21 -0700 (PDT)
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
Subject: [PATCH v8 08/35] dyndbg: split param_set_dyndbg_classes to _module & wrapper fns
Date: Mon, 29 Apr 2024 13:31:18 -0600
Message-ID: <20240429193145.66543-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193145.66543-1-jim.cromie@gmail.com>
References: <20240429193145.66543-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split api-fn: param_set_dyndbg_classes(), adding modname param and
passing NULL in from api-fn.

The new arg allows caller to specify that only one module is affected
by a prdbgs update.  This selectivity will be used later to narrow the
scope of changes made.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a1fd2e9dbafb..4a48f830507f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -711,18 +711,9 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 	return 0;
 }
 
-/**
- * param_set_dyndbg_classes - class FOO >control
- * @instr: string echo>d to sysfs, input depends on map_type
- * @kp:    kp->arg has state: bits/lvl, map, map_type
- *
- * Enable/disable prdbgs by their class, as given in the arguments to
- * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
- * levels by bitpos.
- *
- * Returns: 0 or <0 if error.
- */
-int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+static int param_set_dyndbg_module_classes(const char *instr,
+					   const struct kernel_param *kp,
+					   const char *modnm)
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
@@ -759,8 +750,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, NULL);
+		v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", KP_NAME(kp));
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, modnm);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -773,7 +764,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, NULL);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, modnm);
 		*dcp->lvl = inrep;
 		break;
 	default:
@@ -782,6 +773,22 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
 	return 0;
 }
+
+/**
+ * param_set_dyndbg_classes - class FOO >control
+ * @instr: string echo>d to sysfs, input depends on map_type
+ * @kp:    kp->arg has state: bits/lvl, map, map_type
+ *
+ * Enable/disable prdbgs by their class, as given in the arguments to
+ * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
+ * levels by bitpos.
+ *
+ * Returns: 0 or <0 if error.
+ */
+int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+{
+	return param_set_dyndbg_module_classes(instr, kp, NULL);
+}
 EXPORT_SYMBOL(param_set_dyndbg_classes);
 
 /**
-- 
2.44.0


