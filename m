Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58FD7643A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjG0CC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjG0CCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:02:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAB79E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb7b8390e8so2778555ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690423340; x=1691028140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3H7tTdXzCccSotcbK0HBN3jtn5fCkiAGI0Ov9NcQqc=;
        b=FE8vhxxde3URV15sRKyzYC3RSBIPZnfZAbCJuIjENhkipGgFCLWNIy6Se5Tj3jTdi9
         DM8XdHJlQbuweQv2ulSRoW2p/ik4/RFySbZC/GnbJz7FUmmKIvcrOkzdZwbrsOgE4Txi
         oSGxZnE8QNNlndoUZbMS/DQ2u3tsDRyHq5kymA+i5haL+/EQSUZI47q5FCdw/yo5XwAb
         fu4ShUvwjwwP05boV6WrfHQUVPbHEKwy0CYR65ujtghPXNRtpbCZnwvcfzt44UzXDOwI
         groPZF3G+mey2uA7xZ7WPlMLTKWTLZHhUV0XfFmIW2cGwCj1IT/mbIrZjEucrYUYi3cb
         7QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690423340; x=1691028140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3H7tTdXzCccSotcbK0HBN3jtn5fCkiAGI0Ov9NcQqc=;
        b=PL5Znzf4hOiDmgtYwC72y9W67NcGQAu6GBxlGKiWQqlU2CKzt/lz3vNaxXAl1mSx4a
         XZ1za+9XwJDqJa+vf+dqiwMqvM9XrEiMhwNswWIXB+mpPYOfF3tK73vdMqS7/ToOh/FN
         QdVRltKagrDntIX55Z1sB6F2zPQjNLAbf86ak6pFijzTaxsgqwgYu5e9iUcjptHK/U5O
         9dlZEFFeg7uvKLa6f86nxOkjOy7EOvk2owecg5JOt0OcGmBMgXNIHpFQYMuLsQ+JuS9U
         hd847UcYeXFwXxijfYp4sFFcs6yap4OXHAvRZ6v1AABixVYGGYLDAD+Xzio6YqyXO75d
         3LHg==
X-Gm-Message-State: ABy/qLb8nTxZlzqBZZnLkmE2V4XEuCRYf/+oF/xdnJSMzjd9CDjj0Tka
        lJuTINpV77N3FNE2VReskvM0L3edKSZuFw==
X-Google-Smtp-Source: APBJJlF0NQyhEBYt5tlROyKdSLsCGnG72vbaMpfDMlFOiPOM5ns+egetlDvW9I2BwS2QLt19wa2XdQ==
X-Received: by 2002:a17:902:d4c9:b0:1ae:626b:475f with SMTP id o9-20020a170902d4c900b001ae626b475fmr3616183plg.12.1690423339606;
        Wed, 26 Jul 2023 19:02:19 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b001b8422f1000sm215289plh.201.2023.07.26.19.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 19:02:19 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/6] bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
Date:   Wed, 26 Jul 2023 19:02:03 -0700
Message-Id: <20230727020207.36314-3-yury.norov@gmail.com>
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

_reg_op(REG_OP_ALLOC) duplicates bitmap_set(). Drop it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 0bed9d943d96..346b848170e4 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1352,9 +1352,12 @@ EXPORT_SYMBOL(bitmap_release_region);
  */
 int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 {
+	unsigned int nbits = pos + BIT(order);
+
 	if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
 		return -EBUSY;
-	return __reg_op(bitmap, pos, order, REG_OP_ALLOC);
+	bitmap_set(bitmap, pos, nbits);
+	return 0;
 }
 EXPORT_SYMBOL(bitmap_allocate_region);
 
-- 
2.39.2

