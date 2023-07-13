Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3A27528DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjGMQh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjGMQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:37:20 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A1F30CB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:36:58 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3460e9f2376so3852985ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266217; x=1691858217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QseyuhLBDEROpWLKKgP32sjOtlfO2lCBfXeYS3rrNc=;
        b=AqtDTw4GHHFW58nhuU8rV2uPefm3xUgvTCwrRueppFdIOv2ej9WKU6woKNd1nwNbg7
         nITmmC8RuqvTre7dtVVfWFY60SigGwgiMyZFKcduWjiZjtj+CCtIf8FY1ytxaunJt7gQ
         dRzBSxdERnLrwldTIKAl+tRcPcnQbLuQpjQ6CT8to+2vJkDVSUXOASOroqq7S8mtPBtW
         7VyHw7z9dLTbE/8qUIP/lSMiwsr6FI77844DDo+apo+iJ4KJRarD9llXGvK4yiFcRbJF
         2UDX9OXdj6eyNCYVhO3cQD5D3/NLhY1njJBNuovqvvb3zadI/BWZ/SsdHza9e8qzrk/Q
         +/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266217; x=1691858217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QseyuhLBDEROpWLKKgP32sjOtlfO2lCBfXeYS3rrNc=;
        b=UpvMhIQUSbO/s6Zh+Qeuo/TDkwhgRBOsyydg5p86e333CDuFPkdO9hL4rbB5bOnpQY
         WLWx21QjVDI5ClUECoL3ACl6HvYWv0l+OCPREyvLuB/MKfov/gpwz8TCjdr0Y81S70CG
         6znGhwfVVnhX5l8S9DXVk39Rg7q9GndJxf/jKhpY1tRs7Xsy9xOQEzFxI1/0CTujzB9i
         x6hHi0ENwUlOsty1TwtM/eYJWNDEmKETdCPQBr6ROzLN48/niKJaRlRRfhuTYkc6HFPJ
         ejMuQAMiX6tctJfV+u1rCztSpET8D1GoRJWxS1ZPDrM5osgRBYv/xdf6BhVoJjCKO4l9
         3U9Q==
X-Gm-Message-State: ABy/qLY/owcSTpyKdnsxsEmtiEk7V5gWwW/S2P4iE19I0BBnscF4R9FB
        4cOv1UOcJ9nvmrY70133Bxg=
X-Google-Smtp-Source: APBJJlEjK86Ydtl/W4SvGe/f8j0/HOMCNbHXbx6Pjfwc1I9bI+5mnOhRqxl8RKH6GcBZKDfG0I9WDg==
X-Received: by 2002:a92:502:0:b0:347:223f:92f4 with SMTP id q2-20020a920502000000b00347223f92f4mr2116341ile.24.1689266216897;
        Thu, 13 Jul 2023 09:36:56 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id s7-20020a92d907000000b00345950d7e94sm2147571iln.20.2023.07.13.09.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:36:56 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        seanpaul@chromium.org, robdclark@gmail.com,
        gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 11/21] dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
Date:   Thu, 13 Jul 2023 10:36:16 -0600
Message-ID: <20230713163626.31338-12-jim.cromie@gmail.com>
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

old_bits arg is currently a pointer to the input bits, but this could
allow inadvertent changes to the input by the fn.  Disallow this.
And constify new_bits while here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f392f692b452..abdb54e3ddfa 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -592,7 +592,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -601,12 +602,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
+		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
@@ -618,9 +619,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
@@ -677,7 +678,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 				continue;
 			}
 			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, *dcp->bits, NULL);
 			*dcp->bits = curr_bits;
 			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id]);
@@ -687,7 +688,7 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
 
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits, NULL);
+			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, old_bits, NULL);
 			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
 			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
 				  map->class_names[cls_id], old_bits, curr_bits);
@@ -741,7 +742,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, modnm);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, modnm);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -754,7 +755,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, modnm);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, modnm);
 		*dcp->lvl = inrep;
 		break;
 	default:
-- 
2.41.0

