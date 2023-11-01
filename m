Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A082D7DDA49
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377037AbjKAA1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376970AbjKAA1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:27:06 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3553122;
        Tue, 31 Oct 2023 17:26:39 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3575c10421aso22062355ab.3;
        Tue, 31 Oct 2023 17:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698798398; x=1699403198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/Y22HDoQtQ5J6jKu+XMrHNDFCbaw7mLlFMAwMGHHHY=;
        b=ihqzBl+Tac5uxCRECWjEIEnHDQlFLB/N9AhSSXfPIZ38EA2/rNSv33Cs9i2Uj30NHV
         /LR+A2VpJrRubupQqFEiOfp8HvKJR8I1Uv3QgBM7oA1bADRVZZ394qrFgLd25L3o5Szu
         MCJSP99+DgnB9sWZCaimQQTFeF7N+RN0ZTGUKV7ozq7oGp7O1pOAmTvr1AqvrRdIobjm
         O6tGo0ejNaTzQRaZ5xm2ln37rDq/kLeu+B4706tZIi4XZm1E8S6jwBSaRcvxO/QXlQx6
         Khxk3ayVEhyAg46ElFOyxZjZ9cOlpFJecj1JGUpDgsxic9lbnFdtp9N21nXAKKP2UMJ4
         wMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698798398; x=1699403198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/Y22HDoQtQ5J6jKu+XMrHNDFCbaw7mLlFMAwMGHHHY=;
        b=m5urXWlxchz9oljUAOdNn6YK+o527ZjBoRTjkxl+hrUAe5pGXsUbo/h0YgleQEOpJU
         GM0wgGLZHtLASfZaAs8/IcEFybBPuc2VNK+/iFvd7Mg6c7m45x2PQdM75NBSShfTG9co
         1EpuKuKvIJ7pxK/w59TUjYx9QRjo+dcP7B/kaV0lnrp43WYQNL11ARkjqfVeRDJHE4lQ
         MSceu+P4jhTItPoe/ZiX5+YDyU12RViviPdM4nMrCQL8q7mQX7bBMucQckMShnW4mALT
         vd+8/ymvrmTXeEMru/OnUALK9BEHqYoAJyhAm2AXPaQWE/Y/LCNmYl4W69gx6WusS0KJ
         ni9w==
X-Gm-Message-State: AOJu0Yz8WsHoBpqf/l7F08M7Aii5TVNPZwU2EKccHXeBEVbGISUd4OyZ
        H9FVQYNz1bVokVUfMzBTJBk13IZPuqtjIA==
X-Google-Smtp-Source: AGHT+IGplcxVeKRrxfEzIe5t4tRpaoRwBH4GttUH+1bSvDZD6oSEvtngVm7LhpLRqTeegbroJkeBfg==
X-Received: by 2002:a05:6e02:11b0:b0:359:4048:38da with SMTP id 16-20020a056e0211b000b00359404838damr1276156ilj.1.1698798398709;
        Tue, 31 Oct 2023 17:26:38 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t1-20020a92c901000000b00357cc8df1d5sm141701ilp.68.2023.10.31.17.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:26:38 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        quic_saipraka@quicinc.com, will@kernel.org,
        catalin.marinas@arm.com, quic_psodagud@quicinc.com, maz@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v7d 15/23] dyndbg: refactor ddebug_classparam_clamp_input
Date:   Tue, 31 Oct 2023 18:26:01 -0600
Message-ID: <20231101002609.3533731-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101002609.3533731-1-jim.cromie@gmail.com>
References: <20231101002609.3533731-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 7d3261dede77..f878a6f09fc8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -653,6 +653,30 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 
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
@@ -671,26 +695,15 @@ static int param_set_dyndbg_module_classes(const char *instr,
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
@@ -1157,16 +1170,27 @@ static const char * const ddebug_classmap_typenames[] = {
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
@@ -1181,9 +1205,9 @@ static void ddebug_match_apply_kparam(const struct kernel_param *kp,
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

