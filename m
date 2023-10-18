Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9161F7CE3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjJRRGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjJRRGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:06:31 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BEC12B;
        Wed, 18 Oct 2023 10:06:21 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79f9acc857cso255507039f.2;
        Wed, 18 Oct 2023 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697648780; x=1698253580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hQ8DAFT4FsmbzhSx1IDeWkXEPOHVXkBPwwDIEI4NyY=;
        b=FedXUgnzppx51UYVh6OyI69Fiv1kOEQA1/Dp0IetZf4cbfPd7lLHvDnAql2Re1nqBD
         a3L7Da5ac0r2HxRB2e1IjI+iPok55wQa7mjOIPgwPvfH8Bf2ni2vhpKspKGv/+Xf0KcG
         ckKbDH84J6tY0C6Ng/SUXQagnc7rcW/++qwERmGemiwmGPLktn75Gc8E2SfPMjETPO8Y
         DXy6tjZmDqP5Npo8nvFS3fykahG9qKRFUHjibN8C/cupUEA5UmX4by3u1BK2cV42WjfA
         0exAk7KBjw0KayGq1PEBX6hoBCKML2w9Lk3S14D1hHXWVNWbcYfa/pa1vk+IvJ1jEqMK
         Zwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648780; x=1698253580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hQ8DAFT4FsmbzhSx1IDeWkXEPOHVXkBPwwDIEI4NyY=;
        b=ARmiiSIxK0/usNM409lP0TypXh1bPFWoe7c4cMYJ+T/YfIJMWz0MIxrxsntDyKT7qi
         UhT20IKry8p0Mb+vQsZYCq97jivBIzn+GBCh9RMD76JBwUS4u2lRNdqk10YK1p0om7hz
         wZhCdWfjJJ4XH8dyS7WeWhUOr8Rl9vqhWU4qdMdWeu9mtF1/Ysbe46NAvxK4rFrFz0zz
         rSuvh2D1kA80k/vcgQ724ngNuWNPXJZidF+vpmWEeVVsj7647wmKdpI4KFugVXH87iHT
         vLX+g6X28tTxvG2UGLeafof8bFQS8e7jleEqw2n01Iqu3rCpAc3UXqEzxWskqpA5ouP4
         ak6A==
X-Gm-Message-State: AOJu0Yza2j0+aNEfZtJZcIOBFG+yeY+Kc5l3cMDP0DRhVXHL728OXxRP
        +0/CxhTmIv6rtMu2dqkIlfIMq3DyuBJ68g==
X-Google-Smtp-Source: AGHT+IGIAZvPMDR+fx6OVWKmXyK6iJj0xVodIpeExPc/78Fe8uEKXZgGaoSFAe/fSgw/hj7OJdSkBw==
X-Received: by 2002:a05:6602:2e94:b0:786:2125:a034 with SMTP id m20-20020a0566022e9400b007862125a034mr6919099iow.18.1697648780262;
        Wed, 18 Oct 2023 10:06:20 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n4-20020a5d8244000000b0079fa1a7cd36sm1228944ioo.30.2023.10.18.10.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:06:19 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7c 09/24] dyndbg: silence debugs with no-change updates
Date:   Wed, 18 Oct 2023 11:05:49 -0600
Message-ID: <20231018170604.569042-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018170604.569042-1-jim.cromie@gmail.com>
References: <20231018170604.569042-1-jim.cromie@gmail.com>
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

check for actual changes before announcing them, declutter logs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b0e11f6bfaa2..b07aab422604 100644
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

