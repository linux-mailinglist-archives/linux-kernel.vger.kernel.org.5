Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FA47643A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjG0CC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjG0CCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:02:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD8CCE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8b2886364so2893565ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690423336; x=1691028136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JvH6fCyOwmUpJlih9kGPQ82FswQKyJELuqHpVpnDY4=;
        b=i7gBSpnqZQMeQLBB3IgdhZMBG7JEgU+m3wyIXdUHG3iCYDl66WvgCrSqmUpC5Njy3W
         dY+PJkHGbPQDbcb24H/c4beeMOYfCENgG3YPBbnTEeW4ru+hluahmqoSBW/28IsDhh4p
         4e5sbagKQJDa0OmqfHfRqb2hm8iVcZAfUi6zvIsB+nIpI5wSwBzb9KZ+OP+izfp1SAaO
         otpMwFXFToqJa96GG006XR0IvD+ZrQv2lY7mFv4AVHUdMeVcaicJ6A5/HvNi3Qt4uUHl
         TCwg1x3lWUb/uJUxKqhy2EyFqe6wpkiOEbFmvCJpeDCiq4aTPYD8omlkGE4DRKAqv9Td
         DOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690423336; x=1691028136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JvH6fCyOwmUpJlih9kGPQ82FswQKyJELuqHpVpnDY4=;
        b=OYiZnSWcNYEVhz4yexGIX5nJBg/YM3tKqG7OHU//GpBpoQxnwuPIBvhx9ohJQTQAFg
         IzcCmYVf+Q0sZdqlPwnBuOYOk2QWw2aqRokUhXJvb3deCabLQo8/QjYQP+dAO/9FnfaW
         ZZ0ns0CR2k3u4KPlcl713gz5gnKlaeXBC+Upu4i7T4IN/fFf98eVnWDWxnpirTDr6oR+
         CHksjheej++gAVJuFwOeOmAB7tUN4AGAZZSt8xzLerhLXPQ9pbggCwWmgbkJ8vQPMlst
         rm7vzJKZezMq8WuUsiQWDVk/q9NO2/4AH9ZaO9xsr7MIf/0FLiYdQF76pYB/DGmKi0jU
         Fjdg==
X-Gm-Message-State: ABy/qLahFDuXG3WL5WOxNVkWgm/FGLqy/wyJDlbiIdQhvFxYD7zyoaoB
        a9xZBSdxetKdh7P2qS4LSsO0cvHbmi9BSg==
X-Google-Smtp-Source: APBJJlEYYacde0cKtvxPkhHMjKZE1q1RLQsFu6oYo+pe8taW61QdhtOFkkGW0JdkvxBqLUMdKWhGOg==
X-Received: by 2002:a17:902:7616:b0:1b9:f7dc:b4f6 with SMTP id k22-20020a170902761600b001b9f7dcb4f6mr2750054pll.44.1690423335906;
        Wed, 26 Jul 2023 19:02:15 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090282c600b001a1b66af22fsm234921plz.62.2023.07.26.19.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 19:02:15 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/6] bitmap: fix opencoded bitmap_allocate_region()
Date:   Wed, 26 Jul 2023 19:02:02 -0700
Message-Id: <20230727020207.36314-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727020207.36314-1-yury.norov@gmail.com>
References: <20230727020207.36314-1-yury.norov@gmail.com>
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

bitmap_find_region() opencodes bitmap_allocate_region(). Fix it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index ddb31015e38a..0bed9d943d96 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1314,12 +1314,10 @@ int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
 {
 	unsigned int pos, end;		/* scans bitmap by regions of size order */
 
-	for (pos = 0 ; (end = pos + (1U << order)) <= bits; pos = end) {
-		if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
-			continue;
-		__reg_op(bitmap, pos, order, REG_OP_ALLOC);
-		return pos;
-	}
+	for (pos = 0 ; (end = pos + (1U << order)) <= bits; pos = end)
+		if (!bitmap_allocate_region(bitmap, pos, order))
+			return pos;
+
 	return -ENOMEM;
 }
 EXPORT_SYMBOL(bitmap_find_free_region);
-- 
2.39.2

