Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768D97DDA33
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376916AbjKAA0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376885AbjKAA0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:26:21 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9420F5;
        Tue, 31 Oct 2023 17:26:19 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3576e74ae9dso20648375ab.3;
        Tue, 31 Oct 2023 17:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698798378; x=1699403178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6NIZdlLmgRQPJbwwmBZ102ypc9HsrQnlZpRMUUA7Yk=;
        b=jazU0iSJjZvhPHQDI4Zc1L48r/PTFhmfvS5uT8LXKQ1KEiMq0iq+GVUTtosvkAXd6M
         M8XyWbjQanec3c9OSQQJIDHBF1K1vxMrwag5fpYDICFj0HPoFjBmG0TV+ymWde8W7dL6
         j410IuqLyeU4wK7sjiA7aTXtTyVetZ1wiBcN2Sn+QnKKDXFxnHESqqY+oNxR2+oe040G
         RBIHzPATlf3/hQSTGeLWZYEdhEkgWb/f1PG419lZSERIXbz6HTOqaNFgSRerOMClAWgb
         2qiry7jUZCrKCjMP/cgMWm9K4dJLYbx6eOu4mxI5jg7uBzPz6gLlwZsjHxQZXnFxsN70
         tkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698798378; x=1699403178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6NIZdlLmgRQPJbwwmBZ102ypc9HsrQnlZpRMUUA7Yk=;
        b=FDP+8wN+fiIUKjSS8qXdjDh2UXBkwrTsVzUJ3G3wjqGblr50Ht3/EtT16O8USFP0wx
         gnNglHCumJevOOPpQww/AfY8NeWPGWal4/OAcfzU2pY57BxgBgvwOzyYIUE62BWcuyN3
         br4xvidXb1cDqCQVCW9JWBNmlF8S127q3DYIyDI8XuDkiuwXIOlV0MUx1UMHC1wiB4Pr
         ZEb+sav5c8FgLzzrPG+WBhCfp6937U+IUbZZr1qd1Ja+wrvATTh5j1057aCUinPIMAuA
         c+TcRQ2dW7/Pdt9Dm8yjRi0OBxJ15knMBbRDba/zCnV4h9vIBWcdZnF6gbKCuRfZ6Rgw
         9O/A==
X-Gm-Message-State: AOJu0YwceZgmBbIDj5qa6AJmweGa8gg16TSWedjBkVCzwMKaUj6PcM8w
        dsFXs9lUZ5TjhXpLFLZgGvmuIF18k6IA+w==
X-Google-Smtp-Source: AGHT+IGoYs+RgPsRUt10ACJbEGIFt/ux9/rDvmc+V7NYnthHWFiv9jfveqfaXDItWzipmMTT9jJMUg==
X-Received: by 2002:a92:cd8a:0:b0:358:121:8fd9 with SMTP id r10-20020a92cd8a000000b0035801218fd9mr18467744ilb.28.1698798378688;
        Tue, 31 Oct 2023 17:26:18 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t1-20020a92c901000000b00357cc8df1d5sm141701ilp.68.2023.10.31.17.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:26:18 -0700 (PDT)
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
Subject: [PATCH v7d 01/23] test-dyndbg: fixup CLASSMAP usage error
Date:   Tue, 31 Oct 2023 18:25:47 -0600
Message-ID: <20231101002609.3533731-2-jim.cromie@gmail.com>
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

