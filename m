Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F187C74A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441949AbjJLRXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379712AbjJLRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:22:36 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACAA1BB;
        Thu, 12 Oct 2023 10:22:04 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79f95cd15dfso50395839f.0;
        Thu, 12 Oct 2023 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131324; x=1697736124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKUPZJG7I4VMa4iERW/Xn8lzZwDxy57eOqc/z/Cxr40=;
        b=PSnBnqcAi/PQqVvHJbmy93mU3X+E8Z/5pGP3B0LlfbbswjY1QGgeM8j7cVgmkz9QwY
         Whw7UjRJzvFk6+3FuyPHYtZzwcD3J2N34szKF7EcqVswdwpUl94VzjLAv3kpSmONhUPU
         19lqc68ezvMrayQ8Xp8mas7JF+09kbTKs9IT8/LFAWWJ5iBcD3TB0QvahXDfItIRdhIq
         S5ZWDGddXDaVMGUUXU03V0NVXK8z1Wf6ILcSA7BclwmCaRjdq/qOoO+9beRsTUC2CKio
         ZsCWu1Kefl/snfL3h/T//SgSgUNFoF+Xo63ojR3ylFB3yYcw2ztElFJVMRKZnHaU9bjD
         dmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131324; x=1697736124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKUPZJG7I4VMa4iERW/Xn8lzZwDxy57eOqc/z/Cxr40=;
        b=sW+ZRqhPZmK9DeIU/U89477alsHLDjMVDSIjYoCEdyJ7SjSSjvHDyRe78wZDXiR63t
         7SLkFJ65BTIRAvACOjC77Z0o12ZNPL2OAR8TRvLxaFb9d6WfizatO0LF4opjLcRWaJwJ
         J6BpEovM5QBJO8v5fGbimrrUoYxG0c2VEqsyJ5Kw+q9WFf8x9ClS2/lfccZkL4likmlB
         tW3ekusLmNn/NnxifkBVOjPHYSVodeP8IvRshhg3JJiDibjkv9QKpfrHSXXbP8XLh0aS
         PJ1aQiDfFN3f3kXM/IzyVsNiYwOgJ3P7mDh8e1IbuL0/zTOCXVtnb5EclWWKbbv/Ofay
         jOcw==
X-Gm-Message-State: AOJu0YzgX4LSRvRRLWBaOLY+kUiZL6/VeaoLqENPiUTGS9DzEPsF6vDL
        vTPFSqpAcn2k19eMywBNoMyXhLhKoxGr+g==
X-Google-Smtp-Source: AGHT+IHYDPIhtoCH7YcgdpOkaA1wQ5EPaVbHO4XuAb+xnx3rvomq194dWEMTluIEOI+clHZfAWoO2A==
X-Received: by 2002:a6b:919:0:b0:792:8230:c175 with SMTP id t25-20020a6b0919000000b007928230c175mr25871912ioi.6.1697131323872;
        Thu, 12 Oct 2023 10:22:03 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id r25-20020a028819000000b0043cef0711c1sm3992211jai.158.2023.10.12.10.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:22:03 -0700 (PDT)
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
Subject: [PATCH v7 16/25] dyndbg: refactor ddebug_classparam_clamp_input
Date:   Thu, 12 Oct 2023 11:21:27 -0600
Message-ID: <20231012172137.3286566-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012172137.3286566-1-jim.cromie@gmail.com>
References: <20231012172137.3286566-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract input validation code, from param_set_dyndbg_module_classes()
(the sys-node >handler) to new: ddebug_classparam_clamp_input(kp),
call it from former.  It takes kernel-param arg, so it can complain
about "foo: bad input".

Reuse ddparam_clamp_input(kp) in ddebug_sync_classbits(),
to validate inputs from parent's params, just like our own.
To support that reuse, alter ddebug_sync_classbits() and caller to
pass kp instead of kp->arg.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 70 ++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c11feca70d6f..17eefb35ac96 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -656,6 +656,30 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 
 #define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
 
+static void ddebug_class_param_clamp_input(unsigned long *inrep, const struct kernel_param *kp)
+{
+	const struct ddebug_class_param *dcp = kp->arg;
+	const struct ddebug_class_map *map = dcp->map;
+
+	switch (map->map_type) {
+	case DD_CLASS_TYPE_DISJOINT_BITS:
+		/* expect bits. mask and warn if too many */
+		if (*inrep & ~CLASSMAP_BITMASK(map->length)) {
+			pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, masking\n",
+				KP_NAME(kp), *inrep, CLASSMAP_BITMASK(map->length));
+			*inrep &= CLASSMAP_BITMASK(map->length);
+		}
+		break;
+	case DD_CLASS_TYPE_LEVEL_NUM:
+		/* input is bitpos, of highest verbosity to be enabled */
+		if (*inrep > map->length) {
+			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
+				KP_NAME(kp), *inrep, map->length);
+			*inrep = map->length;
+		}
+		break;
+	}
+}
 static int param_set_dyndbg_module_classes(const char *instr,
 					   const struct kernel_param *kp,
 					   const char *modnm)
@@ -674,26 +698,15 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		pr_err("expecting numeric input, not: %s > %s\n", instr, KP_NAME(kp));
 		return -EINVAL;
 	}
+	ddebug_class_param_clamp_input(&inrep, kp);
 
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
-		/* expect bits. mask and warn if too many */
-		if (inrep & ~CLASSMAP_BITMASK(map->length)) {
-			pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, masking\n",
-				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
-			inrep &= CLASSMAP_BITMASK(map->length);
-		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, modnm);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		/* input is bitpos, of highest verbosity to be enabled */
-		if (inrep > map->length) {
-			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
-				KP_NAME(kp), inrep, map->length);
-			inrep = map->length;
-		}
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
@@ -1160,16 +1173,27 @@ static const char * const ddebug_classmap_typenames[] = {
 		  ddebug_classmap_typenames[_cm->map_type]);		\
 	})
 
-static void ddebug_sync_classbits(const struct ddebug_class_param *dcp, const char *modname)
+static void ddebug_sync_classbits(const struct kernel_param *kp, const char *modname)
 {
-	/* clamp initial bitvec, mask off hi-bits */
-	if (*dcp->bits & ~CLASSMAP_BITMASK(dcp->map->length)) {
-		*dcp->bits &= CLASSMAP_BITMASK(dcp->map->length);
-		v2pr_info("preset classbits: %lx\n", *dcp->bits);
+	struct ddebug_class_param *dcp = kp->arg;
+	unsigned long new_bits;
+
+	ddebug_class_param_clamp_input(dcp->bits, kp);
+
+	switch (dcp->map->map_type) {
+	case DD_CLASS_TYPE_DISJOINT_BITS:
+		v2pr_info("  %s: classbits: 0x%lx\n", KP_NAME(kp), *dcp->bits);
+		ddebug_apply_class_bitmap(dcp, dcp->bits, 0UL, modname);
+		break;
+	case DD_CLASS_TYPE_LEVEL_NUM:
+		new_bits = CLASSMAP_BITMASK(*dcp->lvl);
+		v2pr_info("  %s: lvl:%ld bits:0x%lx\n", KP_NAME(kp), *dcp->lvl, new_bits);
+		ddebug_apply_class_bitmap(dcp, &new_bits, 0UL, modname);
+		break;
+	default:
+		pr_err("bad map type %d\n", dcp->map->map_type);
+		return;
 	}
-	/* force class'd prdbgs (in USEr module) to match (DEFINEr module) class-param */
-	ddebug_apply_class_bitmap(dcp, dcp->bits, ~0, modname);
-	ddebug_apply_class_bitmap(dcp, dcp->bits, 0, modname);
 }
 
 static void ddebug_match_apply_kparam(const struct kernel_param *kp,
@@ -1184,9 +1208,9 @@ static void ddebug_match_apply_kparam(const struct kernel_param *kp,
 	dcp = (struct ddebug_class_param *)kp->arg;
 
 	if (map == dcp->map) {
-		v2pr_info("found kp:%s =0x%lx", kp->name, *dcp->bits);
-		vpr_cm_info(map, "mapped to:");
-		ddebug_sync_classbits(dcp, modnm);
+		v2pr_info(" found kp:%s =0x%lx", kp->name, *dcp->bits);
+		vpr_cm_info(map, "  mapped to:");
+		ddebug_sync_classbits(kp, modnm);
 	}
 }
 
-- 
2.41.0

