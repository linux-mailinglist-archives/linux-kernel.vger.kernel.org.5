Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61C7C74A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379717AbjJLRXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379632AbjJLRWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:22:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AA0D8;
        Thu, 12 Oct 2023 10:22:07 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79fe6da0095so49136839f.0;
        Thu, 12 Oct 2023 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131326; x=1697736126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRPzb8y122l4DlknEH64VDv/BNUclyHuDde/M0YXqy0=;
        b=YUYi3Ukl1rSIKKn1hi+75E6oqktHnG2aff1DZjcyjO5XE2AkfDsGvELFFLuYUTsphC
         MzObbChaS3c+ur73VHRROyslKCt2w9oFaA2KOKPY8X/JNnc8hiN24Zj8mq5uTi6s8RLh
         72BNXRgKagP75qQ1vr2FFL+JVDMoU49kVeFEU5sw91Evw5kiSrKMAti5cEfZpm53D6F+
         1dCVS8aC1hn81F0o5sibv1EGw72/PFyxvMkvAxEGXU8x8CyMC7+u3dLwTYg8ir1qt4Ol
         7y1sy1vStHBVsBUJsaStBBC3LPtEGo8p1Tz42WDxOBgTv/7T9AKzTs2eHjAelOWlCmcg
         0XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131326; x=1697736126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRPzb8y122l4DlknEH64VDv/BNUclyHuDde/M0YXqy0=;
        b=c3QxfY3spWsLbms3xQdsQ/FwQXNY5hRsj14c3lzrArP/VfLgVSvK+NkmlgUWs8ceBj
         iPa2rji4kApvKVTtysdEusPrFkCt+pdbNXmYINrGzhhgpObGFnT7YLjI6GCzipa7hYCo
         2bPUCEo+oxcJADLTIakNaZtBQPuawXt6AdTns4i1VYZBhM8mt2Hs7mg+jX98g0K18Yh6
         JHSuIHfdzJv0Q8FXyoLIGJEe1UIKvEQLuqUg0wLXHhTPNJzqcfArgbYCY8mHidH1kmWR
         9qUNQc149lU9C4bBRwfbYWvk7w9USejJlF0GennKKH2gfOyq3ePSrVVmyWHjDiGoohzU
         +jew==
X-Gm-Message-State: AOJu0YzYtnRZ9LVH576d54PO3Pm7sI0ncta5TJZxhHch1MCfqHweYLOE
        U6m59N1y5vWQb6IJEQH3f86bk2elk4OHzw==
X-Google-Smtp-Source: AGHT+IESMG1jZvzLORyP41l48qsAOCrxW1FElQ4HnzmDNC9Z9KDyDidDnwDbZ0Zi6wnzwaZiEi8j5w==
X-Received: by 2002:a5e:a61a:0:b0:799:178c:7be5 with SMTP id q26-20020a5ea61a000000b00799178c7be5mr29947658ioi.17.1697131326449;
        Thu, 12 Oct 2023 10:22:06 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id r25-20020a028819000000b0043cef0711c1sm3992211jai.158.2023.10.12.10.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:22:06 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 18/25] dyndbg-doc: add classmap info to howto
Date:   Thu, 12 Oct 2023 11:21:29 -0600
Message-ID: <20231012172137.3286566-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012172137.3286566-1-jim.cromie@gmail.com>
References: <20231012172137.3286566-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some basic info on classmap usage and api

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5- adjustments per Randy Dunlap, me
---
 .../admin-guide/dynamic-debug-howto.rst       | 59 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0b3d39c610d9..d8813dcc394a 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -225,7 +225,6 @@ the ``p`` flag has meaning, other flags are ignored.
 Note the regexp ``^[-+=][fslmpt_]+$`` matches a flags specification.
 To clear all flags at once, use ``=_`` or ``-fslmpt``.
 
-
 Debug messages during Boot Process
 ==================================
 
@@ -375,3 +374,61 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
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
+By doing so, modules tell dyndbg that they are have prdbgs with those
+class_ids, and they authorize dyndbg to accept "class FOO" for module
+defining that classname.
+
+There are 2 types of classmaps:
+
+ DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, like DRM.debug
+ DD_CLASS_TYPE_LEVEL_NUM: classes are relative, ordered (V3 > V2)
+
+DYNDBG_CLASSMAP_PARAM - refers to a DEFINEd classmap, exposing the set
+of defined classes to manipulation as a group.  This interface
+enforces the relatedness of classes of DD_CLASS_TYPE_LEVEL_NUM typed
+classmaps; all classes are independent in the >control parser itself.
+
+DYNDBG_CLASSMAP_USE - drm drivers invoke this to ref the the CLASSMAP
+that drm DEFINEs.  This shares the classmap definition, and authorizes
+dyndbg to apply changes to the using modules class'd pr_debugs.  It
+also tells dyndbg how to initialize the user's prdbgs at modprobe.
+
+Modules or module-groups (drm & drivers) can define multiple
+classmaps, as long as they share the limited 0..62 per-module-group
+_class_id range, without overlap.
+
+``#define DEBUG`` will enable all pr_debugs in scope, including any
+class'd ones.  This won't be reflected in the PARAM readback value,
+but the pr_debug callsites can be toggled into agreement with the
+param.
-- 
2.41.0

