Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8666A7F8091
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345799AbjKXSuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjKXSup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:50:45 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86DD2D76
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:50:51 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d645cfd238so1313524a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1700851851; x=1701456651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GN2VkgC7Ox1NKiEC9HCdwkrrRrCW+s3lIxVSHnTzVKU=;
        b=UcTYqK4Jjwn8vgjOlshR6k5n5qTBhMiWVqTgJQIzHwQydGYEs9Qj1+WymB8+QqN9zQ
         ljBe0NTP9cGykOHz5tHr9xD5L8v4GW+hWWlZgJvdGE9UyI023zhJnbAT5eRjg7Yw749w
         +IuHmefov1p8+uItZsC3MOPt5+wZFE2zlc8+FpiJmw6QT1JodieZcMRKU493wdDhPEmI
         X1X2CavVyz6pvqORllHFOIr/n7fBiNAyOElwCRXqQW0S7NZXRQ3TLPtWXW/vqH9wT/5u
         ZuYxVp8by2XVlaX4mibgiDQ3KaRXx6B5QygeLYCqOfHL8FphQ5U2cipwBNHOjD30EbjM
         bTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700851851; x=1701456651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GN2VkgC7Ox1NKiEC9HCdwkrrRrCW+s3lIxVSHnTzVKU=;
        b=h27Um28tqbuTsLN3zdDSiE5dJes3PmyZ9QaVylfVzdgdQR0teNVyX3E2stxPTh4RqH
         cWNHSWXTZ++JENDhAhsnldO6kqSqOLKHnFrilkGo5rp/y3QCBmRYogwU3uN0ag4El4mz
         81P2HJXcxo1fGfKFnXue3q+shjLcxJPrvD+dkeQkPNpG+18fjSCAC0kCWYWX1EAezwlj
         Nd65c6rqQioGlihbD0xghNWzvaAVTGzlpo3JYcrlL2wUApZZO0UrA/eIcvbe+j2sNaHX
         dWtWVeVrNOhBIfjv/HxMJBKKAZcU9CQMM4vOFkoIF591jnDjrfwFn/a/HNF0o2t2B2BR
         5HgA==
X-Gm-Message-State: AOJu0YxMXVsUZI3HntV413Pcvt811Etrb7tD0W4nSaL5mW62F7yxAk2C
        s/m8rzX60HwmWktfJrkbViqG5A==
X-Google-Smtp-Source: AGHT+IGSlMbH/Ck5ElefEgjBJPgaupOZ0YPj68+cSBsnSg8DNXRhAre6QsKPuSm5nqrDd40GTTUtRQ==
X-Received: by 2002:a9d:7553:0:b0:6d6:567a:c83d with SMTP id b19-20020a9d7553000000b006d6567ac83dmr4211966otl.9.1700851851133;
        Fri, 24 Nov 2023 10:50:51 -0800 (PST)
Received: from 6VQ5VV3.attlocal.net ([2600:1700:19e0:a90:c242:2a26:eb7d:4205])
        by smtp.googlemail.com with ESMTPSA id p2-20020a056830130200b006d7e99c4bfesm584696otq.57.2023.11.24.10.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:50:50 -0800 (PST)
From:   Stanley Chan <schan@cloudflare.com>
To:     linux-pm@vger.kernel.org
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Stanley Chan <schan@cloudflare.com>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] tools cpupower bench: Override CFLAGS assignments
Date:   Fri, 24 Nov 2023 12:50:41 -0600
Message-Id: <20231124185042.315148-1-schan@cloudflare.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow user to specify outside CFLAGS values as make argument

Corrects an issue where CFLAGS is passed as a make argument for
cpupower, but bench's makefile does not inherit and append to them.

see also:
commit dbc4ca339c8d ("tools cpupower: Override CFLAGS assignments")

Signed-off-by: Stanley Chan <schan@cloudflare.com>
---
 tools/power/cpupower/bench/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index d9d9923af85c..a4b902f9e1c4 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -15,7 +15,7 @@ LIBS = -L../ -L$(OUTPUT) -lm -lcpupower
 OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o
 endif
 
-CFLAGS += -D_GNU_SOURCE -I../lib -DDEFAULT_CONFIG_FILE=\"$(confdir)/cpufreq-bench.conf\"
+override CFLAGS += -D_GNU_SOURCE -I../lib -DDEFAULT_CONFIG_FILE=\"$(confdir)/cpufreq-bench.conf\"
 
 $(OUTPUT)%.o : %.c
 	$(ECHO) "  CC      " $@
-- 
2.34.1

