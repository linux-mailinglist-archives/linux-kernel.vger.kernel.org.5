Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8683776BABB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjHARFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjHAREl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:04:41 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7C83ABF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:04:05 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7908ff76516so574339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909425; x=1691514225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dahxVnboO2eOF9q6iQLzZIEkr8U3iWdKsMgzp+Qnxik=;
        b=j/1kM7zqexhktI+SipB+6qY7U25IhR67NAPZkpIwJJc0C24J9OmsYguurxge1Kf6K9
         j6KD5jvPaVDiemtSm8i4M/DzclxIT3a6lm1OSas0jXPDtbx8nOXCC923GboAnILJMS/2
         tyVGYwnY8APqDN5D0MJ/coK5I1jT5qjvF/Qrk7VbraXPxbilkGmrUj5ywMoNEZRg133R
         vp5l8czoQ8IXdK8s6RpsJGgFZGa8yJ8Z6Xy4NJtECY/TfkolNLXC7XdXhmY7YCYwpVs6
         8Mjq2WqaPAdfU3huuKt07+T2ROMTyfcxOL6f7F2ldTIZw9NNCkGMdje4w5s6Z4sk5qiO
         +AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909425; x=1691514225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dahxVnboO2eOF9q6iQLzZIEkr8U3iWdKsMgzp+Qnxik=;
        b=f3mXUttOEquqNl36xCBgkUq7n9exhgQMk9HRa3ImyBdC9aYPBdEisIuucoUGT83s+O
         Ny0XvemQ0+jb/ll9O3blguVjW+dprhCSe0KTJlyCg9HNH5OiTd5D2llrDHfibvDRsXq2
         3nuDu5ImtmCGoZ0E0Rnsm1llrl3vvbGnbntIiQbdygH3XlDMPc+Njb5ue/x/a23+Wt5u
         Htbvh1tO6bhw2lcEOS+VuQ3P9D74NC/pasp2fGjU7PZScCPS8oitIXh+sTVA/28tJqDu
         jEApjpqC/nwUoq9ixFzuQCiTa5Xdnp8KvXXk5poxq5k/R4XwOK3bImhCrFqiH6P74fhw
         UH+Q==
X-Gm-Message-State: ABy/qLaR3rDiBd75gGkCgWhDaVt8acM1ShEPZOT7TpgG9PrD4oiJDqmC
        KduRJDX8CBdlK7L4fOp/Q50=
X-Google-Smtp-Source: APBJJlFHl4HyyTg5dsaTx1pWuDvPjyQMnLNPIQ9pr69CIT5YBYmj30+ZXlGognp6XZdE3puaMguVHA==
X-Received: by 2002:a05:6602:122a:b0:790:8e61:7152 with SMTP id z10-20020a056602122a00b007908e617152mr10226060iot.4.1690909424590;
        Tue, 01 Aug 2023 10:03:44 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o20-20020a02c6b4000000b0042b144abf71sm3768577jan.179.2023.08.01.10.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:03:43 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     linux@rasmusvillemoes.dk, joe@perches.com, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 21/22] dyndbg-doc: add classmap info to howto
Date:   Tue,  1 Aug 2023 11:02:54 -0600
Message-ID: <20230801170255.163237-23-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801170255.163237-1-jim.cromie@gmail.com>
References: <20230801170255.163237-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some basic info on classmap usage and api

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 64 ++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 8dc668cc1216..b8d2a7235cbb 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -224,7 +224,6 @@ the ``p`` flag has meaning, other flags are ignored.
 Note the regexp ``^[-+=][flmpt_]+$`` matches a flags specification.
 To clear all flags at once, use ``=_`` or ``-flmpt``.
 
-
 Debug messages during Boot Process
 ==================================
 
@@ -374,3 +373,66 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
 For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
 its ``prefix_str`` argument, if it is constant string; or ``hexdump``
 in case ``prefix_str`` is built dynamically.
+
+Dynamic Debug classmaps
+=======================
+
+Dyndbg generally selects *prdbg* callsites using structural info:
+module, file, function, line.  Using classmaps, user modules can
+organize/select pr_debug()s as they like.
+
+- classes coordinates/spans multiple modules
+- complements the mod,file,func attrs
+- keeps pr_debug's 0-off-cost JUMP_LABEL goodness
+- isolates each from other class'd and un-class'd pr_debugs()
+  (one doesn't intermix 2 clients' bank accounts)
+
+  # IOW this doesn't change DRM.debug settings
+  #> echo -p > /proc/dynamic_debug/control
+
+  # change the classes by naming them explicitly (no wildcard here)
+  #> echo class DRM_UT_CORE +p > /proc/dynamic_debug/control
+
+To support DRM.debug (/sys/module/drm/parameters/debug), dyndbg
+provides DYNDBG_CLASSMAP_PARAM*.  It maps the categories/classes:
+DRM_UT_CORE.. to bits 0..N, allowing to set all classes at once.
+
+Dynamic Debug Classmap API
+==========================
+
+DYNDBG_CLASSMAP_DEFINE - modules create CLASSMAPs, naming the classes
+and type, and mapping the class-names to consecutive _class_ids.  By
+doing so, they tell dyndbg that they are using those class_ids, and
+authorize dyndbg to manipulate the callsites by their class-names.
+
+Its expected that client modules will follow the DRM.debug model:
+1. define their debug-classes using an enum type, where the enum
+symbol and its integer value define both the classnames and class-ids.
+2. use or macro-wrap __pr_debug_cls(ENUM_VAL, "hello world\n")
+
+There are 2 types of classmaps:
+
+ DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, like DRM.debug
+ DD_CLASS_TYPE_LEVEL_NUM: classes are relative, ordered (V3 > V2)
+
+Both these classmap-types use the class-names/ENUM_VALs to validate
+commands into >control.
+
+DYNDBG_CLASSMAP_PARAM - refers to a DEFINEd classmap, exposing the set
+of defined classes to manipulation as a group.  This interface
+enforces the relatedness of classes of DD_CLASS_TYPE_LEVEL_NUM typed
+classmaps; all classes are independent in the >control parser itself.
+
+DYNDBG_CLASSMAP_USE - drm drivers use the CLASSMAP that drm DEFINEs.
+This shares the classmap definition, authorizes coordinated changes
+amongst the CLASSMAP DEFINEr and multiple USErs, and tells dyndbg
+how to initialize the user's prdbgs at modprobe.
+
+Modules or module-groups (drm & drivers) can define multiple
+classmaps, as long as they share the limited 0..62 per-module-group
+_class_id range, without overlap.
+
+``#define DEBUG`` will enable all pr_debugs in scope, including any
+class'd ones (__pr_debug_cls(id,fmt..)).  This won't be reflected in
+the PARAM readback value, but the pr_debug callsites can be toggled
+into agreement with the param.
-- 
2.41.0

