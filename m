Return-Path: <linux-kernel+bounces-162941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFF58B6281
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8BB1C21C47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09E813BC07;
	Mon, 29 Apr 2024 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnhpHzDg"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA8313B2A2;
	Mon, 29 Apr 2024 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419570; cv=none; b=Zo8GWqlhiAOfEOVcjfVsCCgV9STaKWoUrQv+lPd6CFh6tjMnwM+4JP0Dvkh8wZaK+038mIxn0LWrS+pVJX8iaIhARsR2uj0PIKkEBk0AfG6Bg3WiAS+MdBGuNQGhFspXgBRYQtfuKqhDpi2BD3oapzwoIBEN6RJ0Pg6ScEyn/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419570; c=relaxed/simple;
	bh=0OetwS3VJCN5pUQCPfGzxhYb5ZicuWDFYppJAp8i11M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Msw0Y2KR8rLf5FMBjalOTACCQi9whcarnC5GiUvz4gCk7fFeI7APavg7X9y1eJX3fOEpBZIDVZVZwP4FieyKgTw6RCRdR0c2moiwX/sysdE2qvbkpu9G4MUdnJWc2usEEyFcmA8DOv6NbMgdkQj8Ze/UCIx1QdMfc7grdjP7vtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnhpHzDg; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7dbc33bdf08so207963339f.1;
        Mon, 29 Apr 2024 12:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419567; x=1715024367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JIz+6Oy1eqH41GGZgxlPQbWfghUp3j8MpQZmEvPSsQ0=;
        b=bnhpHzDgRg7wt4oBvu3Jjww2Hi0e10OgUdBFf1HSZRxZvYJAX7ViAwxSX5D0UXEhuQ
         +yCAekCU391LpPDpnNhMgtVlbVIEvQ1x0pWPKG+p4ETmWrvSQxd+m0sGqVeTthLIETTb
         i7wdLBndN7MrXRFXqUXFxNxwz15qexv+AGvGMBWEQULS6lTnKunXotgrKXw6fFg4BSCx
         ToIiJQKouYxAqlDwJVpQ3QDSY+7iFXVtJ9g4yPgL0Hn3e9ijYpp4D9esqaXCzvyuXorF
         USqvfr9s49xEJ1Hjgu9LTpf8sbMNr5GvkdgLnuiRkmCDn0RqNkoSHccgolv96U135JeZ
         d2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419567; x=1715024367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIz+6Oy1eqH41GGZgxlPQbWfghUp3j8MpQZmEvPSsQ0=;
        b=iX2p7eDo1NaCp32Zs5y5DhgUj8616Eoh5reeTRdcyh7pdG6LhwyvuW55V1WXLA+6LE
         cFYBu8E4kuxWlp0/0SbpTxsYY0UpX/aQOos30S0NSbe2v2fdyA9rbAgBF4XlCITSikND
         11kTsMjT7g47REi5HhZLfpXSOYthwuduwJk4eIJGZwGXM6ScBTMF08mn1f3IuFUNvcQ5
         888RlSB2xxn4p50SPB89BSIollsnR7XBmP7JBxR1Y0hxSFAe2n5Upq5sN6Z4K+NvhZyx
         ns7N7AfzKXkkPKKOiSOKrxvj/7Ix/sZDATEBiXoBGctX8sTv5YLiK3/oNX3ASTXi9GqL
         G3dA==
X-Forwarded-Encrypted: i=1; AJvYcCXueTZfVtpOvVtMpTxU1FS0PUrxz2g5541+3H5khL+/dyS2pMvcM+rZtH/LXLfnN++2K0b/u1BC1ARssYqQw7KvBeJmFMcwTpZomVSSrDQcTbHEznDdIWvLYxUoRnkVk+nTLGClw08q
X-Gm-Message-State: AOJu0Yz1A6sWa+lBTVVJKB+2X/IbQVT7Ng+qc6EN3+t6mw2fpPYb6GpT
	ZOaSTYIKNSzaxoF6da0iYyjSXCxtcrB/fXbecXwg+pOfRsIisOKsHUTsKh6x
X-Google-Smtp-Source: AGHT+IFThzWVB3vIE8LFgGpixsEhbHUun9+9i1vLB9kJbGTkJx0mvT+Q90khSTqWjq6hpXuEXvfcOQ==
X-Received: by 2002:a05:6602:1cca:b0:7de:8d0d:8836 with SMTP id hg10-20020a0566021cca00b007de8d0d8836mr9390488iob.7.1714419567644;
        Mon, 29 Apr 2024 12:39:27 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:27 -0700 (PDT)
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
Date: Mon, 29 Apr 2024 13:39:06 -0600
Message-ID: <20240429193921.66648-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
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


