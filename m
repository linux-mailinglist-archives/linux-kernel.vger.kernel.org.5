Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1B47784B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjHKA6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjHKA6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:58:42 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58432706
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:58:41 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76cd8dab98fso111470385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691715520; x=1692320320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZksORGx0XEJoHoQJWtGvDBXPP9r6WCKakCBbKb77Tc=;
        b=MrN6rxEQXE2snBruLDXyyvw8qGzZqN6BoNHU88edT9Qx00HrAyPBx/sMxzn1IWebx6
         61AJtpZK8DH+ng5Fn6Nkt0pRjG3Zdw7E+K00C74G7YHHFGmWCI3Ru8EHZ0GuZl2mKWgV
         VRuvsC9Fjk1S7p/mN2FOQwElnHQTnO4w1I5y2KG2y/GSR9T7b7anaSSQ5m0ET5/3JbId
         4NWrJNoqXAW/LpC4ldDmBVT1NdRetZI2SV80MBjH/m99iUw/viryqLEXMZ+Xf5Ohd+J0
         5KEE3S6pZnoCH+9MrcqAzcJzBjDmvAbSbMtYJ5HgwTW7QuP1m3qQ0GOS1Zui/ez0+9Xj
         cUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691715520; x=1692320320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZksORGx0XEJoHoQJWtGvDBXPP9r6WCKakCBbKb77Tc=;
        b=I2K75vyzaZdLnrqFnXa9nLdcbkZb2Ho0NycjU5Ze7QYxYsHCfiIDXp02mxLPeMj2br
         R4kNKXitHgUsICe60BGWlrLACFhcxcts9t5ndJVeTXJT89wsOfot3wGSaMEtvo9NyJFT
         5WcCkmIkB9ruTDOM3Hl/1AaMyTUKKaYMqW2TVZt/FpI0rkfkcR6SfrUthTfEHOVv2Dmy
         jTf45ETSyRVq2EY3pvzkywxyxy/rUQ1QEo+QtpdWwKVHg+sqNOR0pzya3UiHhr1oFa9v
         1xxv33qwIq6boIJm39ClOXD2geL4ou0zwwtbxQE2KZO9M8DhzVxHyUTw/JjyZY2+wMNm
         0Y0g==
X-Gm-Message-State: AOJu0YzmgtGFK6KOt5gFS+03UlbDvIfO26uY2gi1RdjSHd7xd30NOo40
        DSixLjfJQ8PMdGCjHdKgBFh9xcSdxgs=
X-Google-Smtp-Source: AGHT+IEnjQHBWj4gRTIX62NLSGcMW60ftJ5I/+Q4ZFyXqRKiKyWFd2CN8ydttO6felMLxES2wf0uYA==
X-Received: by 2002:a37:b643:0:b0:767:dee0:455d with SMTP id g64-20020a37b643000000b00767dee0455dmr435761qkf.20.1691715520570;
        Thu, 10 Aug 2023 17:58:40 -0700 (PDT)
Received: from localhost (2603-7080-3d03-3cb9-317d-7087-0f3e-bab3.res6.spectrum.com. [2603:7080:3d03:3cb9:317d:7087:f3e:bab3])
        by smtp.gmail.com with ESMTPSA id r2-20020a0cb282000000b00637abbfaac9sm872379qve.98.2023.08.10.17.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 17:58:40 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 3/6] bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
Date:   Thu, 10 Aug 2023 17:57:29 -0700
Message-Id: <20230811005732.107718-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811005732.107718-1-yury.norov@gmail.com>
References: <20230811005732.107718-1-yury.norov@gmail.com>
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

_reg_op(REG_OP_RELEASE) duplicates bitmap_clear(). Fix it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index c9afe704fe4b..0ffafc41cd56 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1335,7 +1335,7 @@ EXPORT_SYMBOL(bitmap_find_free_region);
  */
 void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
 {
-	__reg_op(bitmap, pos, order, REG_OP_RELEASE);
+	bitmap_clear(bitmap, pos, pos + BIT(order));
 }
 EXPORT_SYMBOL(bitmap_release_region);
 
-- 
2.39.2

