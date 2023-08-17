Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F3677FD17
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353943AbjHQRgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353708AbjHQRgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:36:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5360110C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:36:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdc19b782aso515835ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692293803; x=1692898603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lkje228NQWYrR/qCRwOjDNFj5AUJFOJz23skZpqsW4g=;
        b=bDyqFsJdJTAycj6jOtpqBOVcXY+KfUrt5c2IumDkVOn6oWGGSFUFAV/mUW4IPFYfy1
         L7rQA5xhfljnCZAwyNqR9vPRx7Z7dYDxak3Jd8fmK494wz21JeY7GK1AcDe4ecxiPU/g
         HWCJ/EfsEAPJFpkCkThm+6iuHNxSehAAXWY7z9CRLBMGVa+UTd9pwLNMc87ZtsjStvYO
         wOp90kTsU57YSDp/xVtbu0N6hxQjbHUxcS2DJWdQJjv5a6iAQL/FszADLQ+8+fI9yTty
         jFdlg91HE0ZYSfIU2Av2efcMdrTT0JpxLAe1gJxZp4POq7a4VOU88els17RIYsZIzgB+
         yzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692293803; x=1692898603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkje228NQWYrR/qCRwOjDNFj5AUJFOJz23skZpqsW4g=;
        b=PU8rIA2XMbc0ZVb2j/XZEZV5GL/GxylY10wmNJy3Wrp7YiY/jfSrNuQuc1G31xEW3x
         dap2y8wA7I4lgwSxKP25WjGpJlxDJF8MAwtWGdSiefonluiMIg7nTxBDIRAqWApdp75a
         msDBWZT8mcviwYai8pGLtdCwe+0zViRIlQl9NDWJJbJdEfB5Zg09WDewqVirnFE1x36V
         oByi2gMC5olQDNwtKZzN5+zr0hysFzwHPs33Btq9hjjmg2QFs4iactuR5SY0TXBOOdog
         t8hOCo8NFZo67zJpBzkiTLJoy0EEBfU8Etus66fIOtRXNAt6y26gJB9PiVGi+IA2R36c
         IYyA==
X-Gm-Message-State: AOJu0YwFiQjk0vix9zIqxIRy8JKjV77h0PgvIpcPCMQpU5BsrMbq6s2q
        jXhMJbhXlvKFhV0tEOB6ltjP40g80R4=
X-Google-Smtp-Source: AGHT+IEKB7h2NPiCo+RacmjVMEfygFsGLetxsL7KqBu1PrZRI7bUsQiZEW58MnXVt367y3dCyEa0gQ==
X-Received: by 2002:a17:902:c451:b0:1bb:e74b:39ff with SMTP id m17-20020a170902c45100b001bbe74b39ffmr119206plm.0.1692293802686;
        Thu, 17 Aug 2023 10:36:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:c155:d912:d62a:88e5])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b001b8a00d4f7asm47018plg.9.2023.08.17.10.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 10:36:42 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     stefani@seibold.net
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Subject: [PATCH v1] samples: kfifo: Fixes a typo
Date:   Thu, 17 Aug 2023 23:06:36 +0530
Message-Id: <20230817173636.78757-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Fixes a typo in a comment.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 samples/kfifo/dma-example.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/kfifo/dma-example.c b/samples/kfifo/dma-example.c
index 0cf27483cb36..112b0e427199 100644
--- a/samples/kfifo/dma-example.c
+++ b/samples/kfifo/dma-example.c
@@ -80,7 +80,7 @@ static int __init example_init(void)
 			break;
 	}
 
-	/* put here your code to setup and exectute the dma operation */
+	/* put here your code to setup and execute the dma operation */
 	/* ... */
 
 	/* example: zero bytes received */
@@ -109,7 +109,7 @@ static int __init example_init(void)
 			break;
 	}
 
-	/* put here your code to setup and exectute the dma operation */
+	/* put here your code to setup and execute the dma operation */
 	/* ... */
 
 	/* example: 5 bytes transmitted */
-- 
2.25.1

