Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF807528E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjGMQin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjGMQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:37:25 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5EF272A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:37:07 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-346541baf2aso5038345ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266227; x=1691858227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Hpk91v6S/H4Fewdz/m/7w0Z69KCGXKFXbB7sQFxvns=;
        b=PRuNxpUOgQyHdG8xAb7oyEAQApKzt/OLHL3fYGNizID2VWduiR5u3S3+Wnvy4l+AtN
         frn84bflDdi6dnSNf+aOa81Xl1ZzrzKKLQZIV1IE/2ZGqdkPME6E8eTKz6Dk+6pwdrLe
         01S+bWkFSUjvwEBe7X9t2+oAHaa6XsLAamZi6ucAHAxiUrMkqhxpKEY2085K92Hw2VTI
         sJPPegg/RHBzbDtSCol+ucOtla+ncNYyX53N/jENknto+mTA61ROrAMVZj7yCSs5NP33
         MjbsoMaEmNVeuxk8RALTwFhCbAW4Wv5pOaetIVNa34thAybaO16J7MI7jqNFRBYAPCFs
         yxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266227; x=1691858227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Hpk91v6S/H4Fewdz/m/7w0Z69KCGXKFXbB7sQFxvns=;
        b=cFAYHMCYyCIpSGnEww11lBwuSCSF6mdqUW8EVUnQ0jNemV/HkBmH/5v4ytF2/noCik
         56s3PEdIKeX96Maj3F0ft4bI3EQOj1dIE3gqYfcTc4qKF4qbSWD3BnDWj/VnmBg8Do2O
         7SoWAY1A/J3hQzO64XWp4iCxGo6gRbnCAHGnW1BlixG0bqlQVsZWorFCwUlLVtGjHx5u
         9Je24VvYdQklt7cIpyDqvQLFGN+tasM1OJbrZ2GNFTLxY2b1gRF6kRCZ03Lnw40v9tWq
         DBlyd2B2o5Nv6qyS2SlL38IDDYTZNSdU7Axp/t5Xt6Iz2WDhVSbmnaI/PPKRPnw/kQN+
         IrQg==
X-Gm-Message-State: ABy/qLaQXNYGq4W6oqK7x5NGZjNm3gJRjK0Lmd2HckqcL+YqIx18Z+/Z
        TnOOhozI+q/cWzscJ3nbdsE=
X-Google-Smtp-Source: APBJJlE5tiBFK09iMBObOy+YziX4QDegRnmRX3iwsn/S6s5XwYylCDlCasCpS2rPgLy5p+1Cj9b4Gw==
X-Received: by 2002:a92:cccd:0:b0:346:3fc5:93e0 with SMTP id u13-20020a92cccd000000b003463fc593e0mr142862ilq.2.1689266227135;
        Thu, 13 Jul 2023 09:37:07 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id s7-20020a92d907000000b00345950d7e94sm2147571iln.20.2023.07.13.09.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:37:06 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        seanpaul@chromium.org, robdclark@gmail.com,
        gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 21/21] dyndbg-doc: add classmap info to howto
Date:   Thu, 13 Jul 2023 10:36:26 -0600
Message-ID: <20230713163626.31338-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713163626.31338-1-jim.cromie@gmail.com>
References: <20230713163626.31338-1-jim.cromie@gmail.com>
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
index 8dc668cc1216..878750ce8c1d 100644
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
+- isolates from other class'd and un-class'd pr_debugs() 
+  (one doesnt mix 2 clients bank accounts)
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
+ DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, ala DRM.debug
+ DD_CLASS_TYPE_LEVEL_NUM: classes are relative (Verbose3 > Verbose2)
+
+Both these classmap-types use the class-names/ENUM_VALs to validate
+commands into >control.
+
+DYNDBG_CLASSMAP_PARAM - refs a DEFINEd classmap, exposing the set of
+defined classes to manipulation as a group.  This interface enforces
+the relatedness of classes of DD_CLASS_TYPE_LEVEL_NUM typed classmaps;
+all classes are independent in the >control parser itself.
+
+DYNDBG_CLASSMAP_USE - drm drivers use the CLASSMAP that drm DEFINEs.
+This shares the classmap defn, and authorizes coordinated changes
+amongst the CLASSMAP DEFINEr and multiple USErs.
+
+Modules or module-groups (drm & drivers) can define multiple
+classmaps, as long as they share the limited 0..62 per-module-group
+_class_id range, without overlap.
+
+``#define DEBUG`` will enable all pr_debugs in scope, including any
+class'd ones (__pr_debug_cls(id,fmt..)).  This won't be reflected in
+the PARAM readback value, but the pr_debug callsites can be toggled
+into agreement with the param.
+
-- 
2.41.0

