Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A12788AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343603AbjHYOHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343560AbjHYOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:07:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DCA2D5F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68bed8de5b9so792525b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972387; x=1693577187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZWXmOFW7XIR7sQz7nqwnwxxF6rABq6U04fiBPGQFaA=;
        b=ZG8zBfh7anm0g3M9FG4Dc9nNzbFg88JOXeg26DKYQWggkvyPZCWYDvY1qSfn5u9nEV
         3ooqLe9VOFoMvZ0r6xMspaUoYfEqr7u/ctxhNiLjxkBApW8Mlw6R4/PGT5vrg2vxZI4m
         9qYLV5IKAopuStbV7qTN+8mY4WWkXxWddRTMu+6ftuKOIfZaQPbdPvQ5hp+o+Y51aM7l
         23P0y52rUsrvdFjtW4uWNj8dmaNPOHzZruBzlzLs46cwlO7bkTp+lderlJ0CUFEY5uBx
         RuEM6Ehz4Z7PftEGVFq9+ugxj2dt9VDe7+hVaXfZxqEO1Sq2CIkzerPNpWbZzDujjAZe
         Ecog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972387; x=1693577187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZWXmOFW7XIR7sQz7nqwnwxxF6rABq6U04fiBPGQFaA=;
        b=CuGX8JenznsRhe0f6XP6wCViYuCSsqvZ+cgDgLJVk00m/AiZ+nT4OOebWPiogNxin6
         V6S4CoycEt5yyn+de66RLVEiHRg8NyfEHjMywQyM5++W4+ZR5zLRWwdPBgPkL3F3s+x2
         Mgx8caHx1K+YoxAqhecGQ/SOgh4Wc0XbrsGoFN2xkw682e61py24nxP6uNq9bdSH8bc+
         UhVacdSWmAJjgsfCoMvRtefe4/qEzDYbaYBg1E2MzOgze0+1xTdERcZOp0a8WskTR8TN
         wnvNH/PEUEk80YY9T92frEnQO3vTBi5VeaGf0AGEy0PYt/G3yHRiKbaGQ3y6uMXSTrh4
         SfMg==
X-Gm-Message-State: AOJu0YzvacVO1DetE074CIvZuXQgtXl/6HtA/+DYg2yuONIqPRziw7AQ
        aw64ZCo9m8sFlWnEgKQbdJMk2Q==
X-Google-Smtp-Source: AGHT+IEaOooGftcc4wT7bB4cMAu+91Apz/XETquR+YmaObwZipLUG68TraK7rQrUbNNmUHr6Nz83OQ==
X-Received: by 2002:a05:6a20:4324:b0:14a:ac45:d7d8 with SMTP id h36-20020a056a20432400b0014aac45d7d8mr9002025pzk.31.1692972387593;
        Fri, 25 Aug 2023 07:06:27 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:27 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 11/16] Staging: rtl8192e: Rename variable pTS in function prototype rtllib_FlushRxTsPendingPkts()
Date:   Fri, 25 Aug 2023 07:08:42 -0700
Message-ID: <20230825140847.501113-12-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825140847.501113-1-tdavies@darkphysics.net>
References: <20230825140847.501113-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pTS in function prototype rtllib_FlushRxTsPendingPkts()
to ts, to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending whole series as v4
v3:No Changes
v2:No Changes
 drivers/staging/rtl8192e/rtllib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0c812eb02ba6..9c2817e8a5d4 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2039,7 +2039,7 @@ bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn);
  * ieee handler to refer to it.
  */
 void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
-				 struct rx_ts_record *pTS);
+				 struct rx_ts_record *ts);
 int rtllib_parse_info_param(struct rtllib_device *ieee,
 			    struct rtllib_info_element *info_element,
 			    u16 length,
-- 
2.41.0

