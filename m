Return-Path: <linux-kernel+bounces-162933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D628B625E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A5F1F24A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EB0148853;
	Mon, 29 Apr 2024 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp/5SnF7"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AA4145B15;
	Mon, 29 Apr 2024 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419160; cv=none; b=k2Q4HTCHCFlz6y/7cLV+7HnX+Jh4Zy2jmFivzTh0rYXNruRA+MCjixhK8/8FDUwbUSaIW4I2Dc+KdBcM8sXLk6KbPMJmF1VOwoqPfIiJ5vjySjNWthfMU4o0znbDl4dYSaHmIJ6RpV1Djy8iWSNYyIYHjJY+OvGRScOhq+gp0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419160; c=relaxed/simple;
	bh=0OetwS3VJCN5pUQCPfGzxhYb5ZicuWDFYppJAp8i11M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhxAZYypmTw8UN2YyvU8LBnkIO7jbDY8JNqPRUFXtw+Jf6jA8mSfP8txNxlz6dzljN1f4zJXoHM7TaurMQVCu+CZg4L2EsuIwT7DrBoykJNmwAXMNFWEUS7484s/ICUzLclXr9pnwK7axFR+AvUrm7EEwhscqFnfEiInCIF0+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp/5SnF7; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d6bc8d4535so207319439f.2;
        Mon, 29 Apr 2024 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419158; x=1715023958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIz+6Oy1eqH41GGZgxlPQbWfghUp3j8MpQZmEvPSsQ0=;
        b=Mp/5SnF7JtkE4K19la9x9CiognQjcFb4ZDXmHaKc3Fx8xIuUfLIU/osFJwPtdkVD3z
         +jCvDdTgxU41pKRoFzvtKTM/H3pFFTmQqJVUZzRneV7Hk1PfyJpYOIMUlAkW7hDM7MrI
         D+wrZWKz3lI7VwlaoDACO47NZ9gc/VUYjhS8SLfBAuT3j6YgplRKzrl2AAU8qOvUvRFK
         U9UuYHjh1gEXPy9/CqhGwFxK0H/RL2myESI7cqIMgQ/8umGvV1f1ec7uoIqMxjeSpGEl
         3LtcdZfJzUqfOQD8TRyCr2tn0YocebQZseXEbnkNOeWQkHe0hqLmuQU7U9wsgs2b+2Q5
         jBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419158; x=1715023958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIz+6Oy1eqH41GGZgxlPQbWfghUp3j8MpQZmEvPSsQ0=;
        b=JSHC9aqt4lOsxav6DlJdCtqvw+e0Rudy6tjztcZE/hlIXyurB3Dxz2kDpDXUrYaaXu
         LlDIlyskWISIqGxQTa2nbMaYpX5adjI9LWyrI5tBMp98GQVjJDNH46zeagQcYmNXe5Py
         HXgf3iwUnwpHu8Ub6Ge8zq9VeNKRq5zKSYviqzZKQx1O48EHv8e3vmoqTSNAFBCmb3mN
         KzwexAZxwohjdHtXWDopFl5kmJH4sE1AoacC46Fdhnt1PwcSQug803E6MgVwFBCmTvsj
         TdzTObk/vgFv6T22LAzasMMI7vC3k1ABRY9/8XDA+ZeoNHJK1kn1A8d442n5bvR5STYu
         16gw==
X-Forwarded-Encrypted: i=1; AJvYcCXnRybeLdDL0Dkbp+zoaLtM0VU9EbALvqX6CHL2R/Z4y6kQkAkyeK1UkJzxg09SusClgJ2oESn8PG0MQej3g2LOsmVK5pUuPmwt0CGcKCDajpNkZjRZcL0yWMRT+B8L6gSMT/E85lb5
X-Gm-Message-State: AOJu0YwsM8bRkT7f1y44nAZZdUGFzTZ6nYNt4M33C3TfpAoLcM2iqYzI
	3EkjRU2lQBOqwf+/Vjsji+kfc1vNf+gDjlDMHP0f+oV6Jq2J8RSX
X-Google-Smtp-Source: AGHT+IE1jWtePWw6hNOXPmMG/1s0Yzh6iS8u5e32EiGdJcYoBYuvslfcHMKe4q9ahEbOBjkby+55rw==
X-Received: by 2002:a5e:c20b:0:b0:7de:c3ab:3496 with SMTP id v11-20020a5ec20b000000b007dec3ab3496mr6792315iop.4.1714419157705;
        Mon, 29 Apr 2024 12:32:37 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:37 -0700 (PDT)
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
Subject: [PATCH v8 20/35] dyndbg-doc: add classmap info to howto
Date: Mon, 29 Apr 2024 13:31:30 -0600
Message-ID: <20240429193145.66543-21-jim.cromie@gmail.com>
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

Describe the 3 API macros providing dynamic_debug's classmaps

DYNDBG_CLASSMAP_DEFINE - create, exports a module's classmap
DYNDBG_CLASSMAP_USE    - refer to exported map
DYNDBG_CLASSMAP_PARAM  - bind control param to the classmap
DYNDBG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug

cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5 adjustments per Randy Dunlap
v7 checkpatch fixes
v8 more
---
 .../admin-guide/dynamic-debug-howto.rst       | 63 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 6a8ce5a34382..742eb4230c6e 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -225,7 +225,6 @@ the ``p`` flag has meaning, other flags are ignored.
 Note the regexp ``^[-+=][fslmpt_]+$`` matches a flags specification.
 To clear all flags at once, use ``=_`` or ``-fslmpt``.
 
-
 Debug messages during Boot Process
 ==================================
 
@@ -375,3 +374,65 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
 For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
 its ``prefix_str`` argument, if it is constant string; or ``hexdump``
 in case ``prefix_str`` is built dynamically.
+
+Dynamic Debug classmaps
+=======================
+
+Dyndbg allows selection/grouping of *prdbg* callsites using structural
+info: module, file, function, line.  Classmaps allow authors to add
+their own domain-oriented groupings using class-names.  Classmaps are
+exported, so they referencable from other modules.
+
+  # enable classes individually
+  :#> ddcmd class DRM_UT_CORE +p
+  :#> ddcmd class DRM_UT_KMS +p
+  # or more selectively
+  :#> ddcmd class DRM_UT_CORE module drm +p
+
+The "class FOO" syntax protects class'd prdbgs from generic overwrite::
+
+  # IOW this doesn't wipe any DRM.debug settings
+  :#> ddcmd -p
+
+To support the DRM.debug parameter, DYNDBG_CLASSMAP_PARAM* updates all
+classes in a classmap, mapping param-bits 0..N onto the classes:
+DRM_UT_<*> for the DRM use-case.
+
+Dynamic Debug Classmap API
+==========================
+
+DYNDBG_CLASSMAP_DEFINE - modules use this to create classmaps, naming
+each of the classes (stringified enum-symbols: "DRM_UT_<*>"), and
+type, and mapping the class-names to consecutive _class_ids.
+
+By doing so, modules tell dyndbg that they have prdbgs with those
+class_ids, and they authorize dyndbg to accept "class FOO" for the
+module defining the classmap, and its contained classnames.
+
+DYNDBG_CLASSMAP_USE - drm drivers invoke this to ref the CLASSMAP that
+drm DEFINEs.  This shares the classmap definition, and authorizes
+dyndbg to apply changes to the user module's class'd pr_debugs.  It
+also tells dyndbg how to initialize the user's prdbgs at modprobe,
+based upon the current setting of the parent's controlling param.
+
+There are 2 types of classmaps:
+
+ DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, like DRM.debug
+ DD_CLASS_TYPE_LEVEL_NUM: classes are relative, ordered (V3 > V2)
+
+DYNDBG_CLASSMAP_PARAM - modelled after module_param_cb, it refers to a
+DEFINEd classmap, and associates it to the param's data-store.  This
+state is then applied to DEFINEr and USEr modules when they're modprobed.
+
+This interface also enforces the DD_CLASS_TYPE_LEVEL_NUM relation
+amongst the contained classnames; all classes are independent in the
+control parser itself.
+
+Modules or module-groups (drm & drivers) can define multiple
+classmaps, as long as they share the limited 0..62 per-module-group
+_class_id range, without overlap.
+
+``#define DEBUG`` will enable all pr_debugs in scope, including any
+class'd ones.  This won't be reflected in the PARAM readback value,
+but the class'd pr_debug callsites can be forced off by toggling the
+classmap-kparam all-on then all-off.
-- 
2.44.0


