Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347647DDA35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376961AbjKAA0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376923AbjKAA02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:26:28 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3184FF4;
        Tue, 31 Oct 2023 17:26:26 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3575287211bso20913745ab.1;
        Tue, 31 Oct 2023 17:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698798385; x=1699403185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+YoaYP9Btr77N0brD8AfqI/lJY3W3ao1Z4fzgsncX4=;
        b=cREyh+CNLxztOnFkiDihVEvX/KDhhnrfADPSCmloWxpqk8VlM9oJ9mGAeqTJRsYrbR
         VD5t6jrKS8icwbeETNL8EIb52DNRUmnc3LZCeRZFjNsnnvqSidy5Azz/DLuSfNCMizkf
         XZMtk/4es//GDDsVVAo7GRjCahK9V6Fldn11uYZOd+2PrQOBx4UmYYrIKS3XWXDTxVQ+
         jVB9RIDfpZMGt08jjcjdtxE/c5nfJ82x6eU/AO0lWs74l6RIe8rIERlDxQ0sqcbFLAtu
         8ypWa7QEIcu7pNt/W1pO92Qk/XDgYbH5tNpTIzao+VScZ836cRYACmvZGcEpfifK35VN
         0+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698798385; x=1699403185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+YoaYP9Btr77N0brD8AfqI/lJY3W3ao1Z4fzgsncX4=;
        b=pW14u2oi3LOT6JrHcqitZKAzQohJnJBKEXMqlYseBNZE49VQOIYoimqziMYcIoA57l
         F5MR/hbEKIkxwSUhe/8PvHHW68mq73ETjACM5SQnG9lN4xTeMUEDPTSITSOsH4izT57b
         EAR7/tpGN/jT3QEuOYO9Jes6WJYu7lC98iIjHGbjklJWECER+JTmJ5hFXn0inInO5L0c
         151qmPS6ae/i+kDuFGCSic+8RUabpmS0q4xPJ3BFU/xwE89Zn57zG2VOEHPnGOJi41C0
         V5Bv49VjTtHoQqbpV1cGSlQdRxsyzMEtiQSNS904Ernl6YMHf/y5dXecEZ9v93UCH6L0
         mrbg==
X-Gm-Message-State: AOJu0YxBtmOz4PuiBmV/6KLmhfh8PMvf4ATaogNUEHK7U7GfSczFdU0H
        dcZKJ1PfHlMbqk0AlnIS28DHuf83o5+o8A==
X-Google-Smtp-Source: AGHT+IHFCe2bEfwNiGqjn9xcNuK0WJbUzvMAzVY5SQXMQ86DRyZUDjpBsVnnRJtNMNOhfxSk8+K5PQ==
X-Received: by 2002:a05:6e02:1b05:b0:357:47a3:adb8 with SMTP id i5-20020a056e021b0500b0035747a3adb8mr18275462ilv.29.1698798385252;
        Tue, 31 Oct 2023 17:26:25 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t1-20020a92c901000000b00357cc8df1d5sm141701ilp.68.2023.10.31.17.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:26:24 -0700 (PDT)
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
Subject: [PATCH v7d 06/23] dyndbg: split param_set_dyndbg_classes to module/wrapper fns
Date:   Tue, 31 Oct 2023 18:25:52 -0600
Message-ID: <20231101002609.3533731-7-jim.cromie@gmail.com>
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

rename param_set_dyndbg_classes: add _module_ name & arg, old name is
wrapper to new.  New arg allows caller to specify that only one module
is affected by a prdbgs update.

Outer fn preserves kernel_param interface, passing NULL to inner fn.
This selectivity will be used later to narrow the scope of changes
made.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ba41fdeaaf98..b67c9b137447 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -708,18 +708,9 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
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
@@ -756,8 +747,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
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
@@ -770,7 +761,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, NULL);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, modnm);
 		*dcp->lvl = inrep;
 		break;
 	default:
@@ -779,6 +770,22 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
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
2.41.0

