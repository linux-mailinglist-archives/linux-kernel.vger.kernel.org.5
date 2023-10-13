Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3917C9074
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjJMWsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJMWsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:48:33 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3E5BF;
        Fri, 13 Oct 2023 15:48:32 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-352a22e1471so10472745ab.0;
        Fri, 13 Oct 2023 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697237311; x=1697842111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6NIZdlLmgRQPJbwwmBZ102ypc9HsrQnlZpRMUUA7Yk=;
        b=j/Ug/xjCTF9ZLFiCzY6P99ZzjmjFcjYccV1rFaF3Tyeua6YlPMkMkekU1xNswBdeIb
         wDrWwy0LcTM5PrM6/fbX11xWUlmRNFfJSnVvMn0AiBBuYkyuVipQ20Pspjw2id5+Zen/
         IPVUzeHr80fRqJViwjy7LGmnXqoejgw1+dok/duEMRBxVVck5LTKiwIRjr7R1sM25Lob
         6/ZMkcyCQ9pYm9qRUX+BX6lW406O8/SjupGCovjpmsqBnfM5WYiCUvyAK3fHy92TKzdV
         4YC/aDWb36EsCulALfpYy1dWRhEytR8FaUJfO4e3LEg1W9efYgOO4dCny5Cf1rANn4Q6
         qh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237311; x=1697842111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6NIZdlLmgRQPJbwwmBZ102ypc9HsrQnlZpRMUUA7Yk=;
        b=Lv8s4XrblL3Ten916r4X/8Raqkv1Vy9x0HAxTcINa7ri3IC32gMkmIo3FnoQpcGh1T
         e+4ptyp/xE1HTRc+t1NdXlfGFI6x+Sjg5bLlpsZgL4OTEHkrcfmOnIdaJVCC3dyeJBVu
         lji8g6asyJgjvYmuJr2Fmv2FxurRVAgJ8Cwd0OxwhTrmlJm1ZpgsWc2NQyKh1OCldB7K
         7A3fK2XXVLnEHwU+3cnNMJ0nZc4Qu88A7R1G7XplesWG5FKroxQiM39zGKDeRe8oJ5QS
         W8Sy79KEtMpTmEwGQzfBHTc6udmLACMf5RG6RkcLtHMA4bmSH/pR/e+atF9VWTPXd2Fe
         zSYA==
X-Gm-Message-State: AOJu0YzHqwa7aVYNN1ntZ9wbaGzaielIgg1sLiqZ0nvcmrGcXKaMTITi
        +aPlTlZdb48IHXBIsDJMoLyc/NVuivT/PA==
X-Google-Smtp-Source: AGHT+IFA5f7XOQ/uqAKJYGMLvZKg+0KHzwGrvWYPW/qdlHycTjD98B73OaNojeXhn7vC/vD7isrjvQ==
X-Received: by 2002:a92:d14f:0:b0:357:6de0:4f46 with SMTP id t15-20020a92d14f000000b003576de04f46mr1371393ilg.6.1697237311232;
        Fri, 13 Oct 2023 15:48:31 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t10-20020a92dc0a000000b003512c3e8809sm1683071iln.71.2023.10.13.15.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:48:30 -0700 (PDT)
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
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7b 01/25] test-dyndbg: fixup CLASSMAP usage error
Date:   Fri, 13 Oct 2023 16:47:53 -0600
Message-ID: <20231013224818.3456409-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013224818.3456409-1-jim.cromie@gmail.com>
References: <20231013224818.3456409-1-jim.cromie@gmail.com>
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

more careful reading of test output reveals:

lib/test_dynamic_debug.c:103 [test_dynamic_debug]do_cats =pmf "doing categories\n"
lib/test_dynamic_debug.c:105 [test_dynamic_debug]do_cats =p "LOW msg\n" class:MID
lib/test_dynamic_debug.c:106 [test_dynamic_debug]do_cats =p "MID msg\n" class:HI
lib/test_dynamic_debug.c:107 [test_dynamic_debug]do_cats =_ "HI msg\n" class unknown, _id:13

That last line is wrong, the HI class is declared.

But the enum's 1st val (explicitly initialized) was wrong; it must be
_base, not _base+1 (a DECLARE_DYNDBG_CLASSMAP[1] param).  So the last
enumeration exceeded the range of mapped class-id's, which triggered
the "class unknown" report.  I intentionally coded in an error, but
forgot to verify its detection and remove it.

RFC:

This patch fixes a bad usage of DECLARE_DYNDBG_CLASSMAP(), showing
that it is too error-prone.  As noted in test-mod comments:

 * Using the CLASSMAP api:
 * - classmaps must have corresponding enum
 * - enum symbols must match/correlate with class-name strings in the map.
 * - base must equal enum's 1st value
 * - multiple maps must set their base to share the 0-62 class_id space !!
 *   (build-bug-on tips welcome)

Those shortcomings could largely be fixed with a __stringify_list
(which doesn't exist,) used in DECLARE_DYNDBG_CLASSMAP to stringify
__VA_ARGS__.  Then, API would accept DRM_UT_* values literally; all
the categories, in order, and not their stringifications, which
created all the usage complications above.

[1] name changes later to DYNDBG_CLASSMAP_DEFINE

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 8dd250ad022b..a01f0193a419 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -75,7 +75,7 @@ DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
 /* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 11, MID, HI };
+enum cat_disjoint_names { LOW = 10, MID, HI };
 DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
 			"LOW", "MID", "HI");
 DD_SYS_WRAP(disjoint_names, p);
-- 
2.41.0

