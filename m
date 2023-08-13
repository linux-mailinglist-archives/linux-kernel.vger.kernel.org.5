Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AA377A6E5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjHMOZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHMOZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:25:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C8510FC;
        Sun, 13 Aug 2023 07:25:38 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso2066450a12.1;
        Sun, 13 Aug 2023 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691936738; x=1692541538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YV2EKTSmF4ZF8Dc6kXfO6H86j6vsqSlyX5k6d36xNA8=;
        b=V2+H/lgmyfoGT60GcYPH/BEH4PJSPhRWustW9sRtT+dyVYgRSMum42e3V/5LHdj4Xn
         4aMY+rm/coQ5rHQ4mzQ43aR5gvj5N52NobDx0z5oy4jTXodp5dgCIOMRW9nQC4d646J9
         FTpZFs+CTb2zkn/AM1mcltQhmgDLorAhXGrcaJjVk3HBPqbqvB4AqMZy8WaYoRxsGLF8
         NqwhSl2u+2/Bd9EajwJUJIlO0k8b+t5uHiOBfG6UtBU1Ecfdi7f/kRGFHP0fpKTGghPo
         hcZ95bDvGrBQqPLavHkr7Z14+GG4TaQifhtJbe9oQDeQun1fGATUZy8SP3pS9E+3yZMd
         gt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691936738; x=1692541538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YV2EKTSmF4ZF8Dc6kXfO6H86j6vsqSlyX5k6d36xNA8=;
        b=J0WeG9T7uRxKGINF8zpQQlnM4nJGKSEq/PJ6LWer53boxKX61BTx3undJ1y+3eXj0H
         9qvxv+HnMyO4+VAcOXdBQUxhhuDfPWK79zciHHtlnoZPOx+De2AT4LmYGpFzqYIO5na1
         nM434xhy+ke3sS0nMa6czm0jahYk3xq+ln+uABPTeswqBP+6gxJnPI4a3SLh3S8UE1sx
         NfsqtBbvuWIrZBS4V/i9hgLrq4DbefPzSSNwGdJkIrBpTMvUv04OYwjrtv8gbfVkwI3w
         Mgfd81dqtTGqugvrUdks8xYFVAw5ImCEgP4A5sHn4E4b6izUUI5TBysyIhfWIz0uDqWm
         Iskw==
X-Gm-Message-State: AOJu0Yyd23ov1xXo9aLcQnYE5IxKRJqruuZxTUte5KVzpDWgly68pBXk
        MDFcQNoM+2BT4v3cfgoA0kKq1dKn3iU=
X-Google-Smtp-Source: AGHT+IG0f/0942t0FEoLb+nx/Kb0bjN4H3y6V6fqm5/MzgET3ad3DxqzvTqJRPv86vv+xPCyooHDWA==
X-Received: by 2002:a17:90a:6941:b0:269:3771:7342 with SMTP id j1-20020a17090a694100b0026937717342mr4393892pjm.18.1691936737648;
        Sun, 13 Aug 2023 07:25:37 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1022:f538:d00a:1992:423:e24e])
        by smtp.gmail.com with ESMTPSA id n22-20020a170902969600b001b5247cac3dsm7440361plp.110.2023.08.13.07.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:25:37 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v2] Documentation: spi: Added a valid hyperlink
Date:   Sun, 13 Aug 2023 19:55:32 +0530
Message-Id: <20230813142532.150744-1-coolrrsh@gmail.com>
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

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

The hyperlink to datasheet in website are subject to change.
Created stable hyperlinks to view datasheets.

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

---
v1->v2 
changed the commit message

---
 Documentation/spi/spi-sc18is602.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/spi/spi-sc18is602.rst b/Documentation/spi/spi-sc18is602.rst
index 4ab9ca346..0dd7e3b95 100644
--- a/Documentation/spi/spi-sc18is602.rst
+++ b/Documentation/spi/spi-sc18is602.rst
@@ -6,7 +6,7 @@ Supported chips:
 
   * NXP SI18IS602/602B/603
 
-    Datasheet: https://www.nxp.com/documents/data_sheet/SC18IS602_602B_603.pdf
+    Datasheet: https://nbviewer.org/github/spidocs/spi-sc18is602/blob/main/spi-sc18is602.pdf
 
 Author:
         Guenter Roeck <linux@roeck-us.net>
-- 
2.25.1

