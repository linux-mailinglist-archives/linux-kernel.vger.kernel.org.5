Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5A779C354
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbjILCwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbjILCwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:52:32 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C8846A5;
        Mon, 11 Sep 2023 16:10:18 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34f62d318a3so7907885ab.2;
        Mon, 11 Sep 2023 16:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694473732; x=1695078532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OT6IFguW/4DLumHawSixfP36EK45t059NQqpOGGT6yM=;
        b=Waa+yzyxK3QM/wgsl+0+9LT7g1lCAodN7oVr/09Fxc7j9ILshvzBchzazJ1r0R7MUb
         UyXJxpqlX3tHfpQVLnAOS/GMjhng2X+tDDDmOEJb/lU6OXpS3dpRMg5ybAYhnHTFc2UO
         +op9/wbsl1BKY/Cr0b2Hp7bIhRfF2iMo0mN5w+G257TjC1WTvw42cO4aAoX/vApwLpah
         4aw88hPH6RfhfKn6pvg6NZ+jj+bHyKlEz2SUfVQzK99HGGocippH3WA4cyGvqBXBDeAR
         W0dRiF7pVU4356JsrfnBwo97Q3E1nbsSfpFmwcOjhXsB1EpWJfXi7AhvLlf78vcbw8YS
         3PSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473732; x=1695078532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OT6IFguW/4DLumHawSixfP36EK45t059NQqpOGGT6yM=;
        b=RIIPlP5y41kk/pWEiNbkuEmMi4RukA/oE1EaU9fL+FmIIN9QLPOKsoLfAQFYmUTym+
         3Eoc0zX0YAkx4z4AfIC7+kiiW6/+DLQrl2xUZQShnCmZugWP5UfPTsZ798H7nRLj3Qrk
         QJ5kMmkO09EwCYScdLnw62mOCWrF615kVr64g9siIwHLYNXAa0/fKC7L8RY8kIorhxvq
         nP+PWrQe0dU/IUYcyFIgHbfGomtAx7MRTi/IFin3vPpIA3lmuMLPm8rbzH5ZwoVp/DXs
         Bofac35NsV5fTr5G0m87tF4U58l5YvuRviTnlDp1F2wJ7GY8su2X+gEPYFk35dVc8oRt
         ya1Q==
X-Gm-Message-State: AOJu0YziYBHFVhfdgHxeCGh5dsbofO6/8J0ZhcTO6e/B7+Cef0WrDi48
        /QSWpqdND6LVjKkmzku4JE0=
X-Google-Smtp-Source: AGHT+IGXcqZsyEpWo/sj2dkS8Od7PevZHZxGLE+VJj9Aw0UXdcHekh90w4d4NlXrlxpXOlQNiZOmkA==
X-Received: by 2002:a05:6e02:961:b0:34c:dd54:10c5 with SMTP id q1-20020a056e02096100b0034cdd5410c5mr11705350ilt.10.1694473731983;
        Mon, 11 Sep 2023 16:08:51 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:08:51 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 08/22] dyndbg: silence debugs with no-change updates
Date:   Mon, 11 Sep 2023 17:08:24 -0600
Message-ID: <20230911230838.14461-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911230838.14461-1-jim.cromie@gmail.com>
References: <20230911230838.14461-1-jim.cromie@gmail.com>
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

check for actual changes before announcing them, declutter logs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f64d55d191ad..05c777dedf27 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -591,7 +591,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	return nfound;
 }
 
-/* apply a new bitmap to the sys-knob's current bit-state */
+/* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 				     unsigned long *new_bits, unsigned long *old_bits,
 				     const char *query_modname)
@@ -602,8 +602,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -618,8 +619,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
-- 
2.41.0

