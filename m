Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4739F77D499
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbjHOUsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239930AbjHOUsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:48:21 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E867212A;
        Tue, 15 Aug 2023 13:48:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565e54cb93aso455889a12.3;
        Tue, 15 Aug 2023 13:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692132484; x=1692737284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G4IX9/WkCVI7eBjbMqjNOw8oTFgTkITXU+deaPVMnaU=;
        b=EIxB4xe8sE1jozTdmjFDNVzRWkLCtNuxbVT/R2BWDRQ2z8sh+a11Wwcin4TBjdLtUX
         u0vv70K/4P7NmwK3agNPwBUc94Dh2fn5ypkLdxcvnf/UeVyhFczVLVjU6eRLQxWiZub1
         30XBrSOdBjUeDIe7e32ra5t1i0ZxW4x8JvfKDckLopbEbJF8UPvwM+0b4vKTcPC157Gj
         1wXTwndnDC0p3o/hxAf21ezZXoxRhacZXWSxRwJg+EnTSTVR7MrlNnTfvSHwpTvx0OMK
         S95+lLX4GA9Rd+/Np8GCTBfo0KCpzf3JxCIfG9SQT7i4f/3Wpshg+TWfB5MWFZBC42yu
         927Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132484; x=1692737284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4IX9/WkCVI7eBjbMqjNOw8oTFgTkITXU+deaPVMnaU=;
        b=Y5yYsT19Yes0GqmpnF+Y/auphedkAyUL2z80MyXzQhLMMFX4NXe8InnYMHqfxtuQn3
         jEIbs5bXoTougwt7k3hVhNY+Dr2PqRgD+e1ICdrbkjVovWKCSYrqpJiM0Y++HzUR57V4
         pfRezGolZaGcXc3dqD/RsxqmScrh3eevsvQG0P2G3Weqs+iQE83mxBnXXeHFO/59SC4d
         pzLme+JsnZgWam9yBLjmHaWkuOF5jA9vqMW1dhG9GTklpdF6zNhQaUuJ+SoUl/DchyPs
         oiUecSp8gzGg+lIfx80CFhBBHIj3FSleQ0jP+1LgQp3KBSjNTde567oaQ8DCrNJjlNc4
         BHPQ==
X-Gm-Message-State: AOJu0Yxxxw/XQQpC7KNZJycUpVCxgOLxTL7taoBVABKGAqvGr740FTcW
        2+X2IiUtn36x2tuRR5gIGOc=
X-Google-Smtp-Source: AGHT+IHmVhVNAXM6fVm7cY98poh/f8N7e7OcOzJjnOdeDyyPf6+we4bwJkx6zCbUbzCSyjzRWfwD4w==
X-Received: by 2002:a17:90a:e50a:b0:26b:56fa:87d3 with SMTP id t10-20020a17090ae50a00b0026b56fa87d3mr5692619pjy.31.1692132484557;
        Tue, 15 Aug 2023 13:48:04 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:db85:3caf:1429:e455])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b001bba3a4888bsm1835828plk.102.2023.08.15.13.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:48:04 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     paul@paul-moore.com, eparis@redhat.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: [PATCH v1] kernel: Moves trailing statements to next line
Date:   Wed, 16 Aug 2023 02:17:51 +0530
Message-Id: <20230815204751.52481-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes following checkpatch.pl issue:
ERROR: trailing statements should be on next line

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 kernel/audit.c       | 3 ++-
 kernel/auditfilter.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9bc0b0301198..a5393eda7f9d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -323,7 +323,8 @@ static inline int audit_rate_check(void)
 	unsigned long		now;
 	int			retval	   = 0;
 
-	if (!audit_rate_limit) return 1;
+	if (!audit_rate_limit)
+		return 1;
 
 	spin_lock_irqsave(&lock, flags);
 	if (++messages < audit_rate_limit) {
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 42d99896e7a6..a25757f09255 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -694,7 +694,8 @@ static struct audit_rule_data *audit_krule_to_data(struct audit_krule *krule)
 			data->values[i] = f->val;
 		}
 	}
-	for (i = 0; i < AUDIT_BITMASK_SIZE; i++) data->mask[i] = krule->mask[i];
+	for (i = 0; i < AUDIT_BITMASK_SIZE; i++)
+		data->mask[i] = krule->mask[i];
 
 	return data;
 }
-- 
2.25.1

