Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B266D7B27B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjI1VsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjI1VsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:48:17 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190CF1A1;
        Thu, 28 Sep 2023 14:48:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so21295054e87.1;
        Thu, 28 Sep 2023 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695937692; x=1696542492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHFjIMlDbV5kSmnyZox+gz39Xi2GjyZylQuebCzLYHE=;
        b=DCU1e3zP+IcFciXYKaLxq660eJI5QYAysG/L38frUwg3uk6Kw4MDvZ6W58hZCZXqZg
         LVj9uwskdRZPaPO0fxeROUXN9vY9jlULMxS1o/0RAQEPtO7KvKi7kfT35DjNY3MKT1jQ
         gbEB6wmtc/pSukR3V4w7LK0RcK0XUFsrvxRI8+DU9IpxIHgIlfPRWf/psE+WTTLlH+pg
         v7doHc/8VGF/IH1g/mIQPY52T2L/JHCAm94OUtuR4ckipNGG3B2kdu+GFS+S46iz1opv
         k+x6tiQCe4XBwQ0TLQVZbmHOs7nTBwC/kCrmedjHUhQoSNEII+auCbx5Xd/VihzXXuF0
         vOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695937692; x=1696542492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHFjIMlDbV5kSmnyZox+gz39Xi2GjyZylQuebCzLYHE=;
        b=JSEQX5HFqm1SK9KJyp46vHNgmh1GxUxj7A6J/hpwo797Bkws/FtPoZLcFzZqB3SmFn
         uUZLu5tBBjfeKuEKs3mvU/4GAVgmAq9AqjoGKezt0EHTjO9u/1wVIMdTczFGvUYmY58S
         sXZvYbp572hBsbqNz5rFtrj+wngGhbahFuBJrrY5y3NbcXE0FqmCWKILNHxwHPzP3ayQ
         lSDGO8x+KGK3AN620vYUhtLVa8kYZXZi5RQvaQnhpAYS0y/iTps5rwsOCh7fER62UJzB
         w/Ec+VAT9VuT8+SYw1bFTrlj9WqKxsbZABwwlXvIZV7ZlBot/NPmr2odvIpjZstoi4CJ
         mR2w==
X-Gm-Message-State: AOJu0YxXBh/5tudx59x4jQ77XAPW+EcJDmc/z+KCtmJLJOuf9tJbpKrI
        z0TPKc02vH05phFUotf+MpaUYknqS3E1jQ==
X-Google-Smtp-Source: AGHT+IG+n6HpGdHLmIq/ZZ3U2mK8r7GpAKB/WgnmRMGFrG0wFGGhc5jQHmSGVPZDeV5lpSj7yE6GFA==
X-Received: by 2002:ac2:4e85:0:b0:4fe:2d93:2b50 with SMTP id o5-20020ac24e85000000b004fe2d932b50mr1942084lfr.31.1695937691961;
        Thu, 28 Sep 2023 14:48:11 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id v2-20020a056512096200b00503189d8b8csm3246714lft.198.2023.09.28.14.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:48:11 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     lenb@kernel.org, rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 1/2] drivers: acpi: Fix label indentation and leading comma formatting issues
Date:   Thu, 28 Sep 2023 23:48:07 +0200
Message-Id: <20230928214807.43409-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fixed the following formatting issues flagged by checkpatch
in utils.c:
 * Remove incorrect indentation before goto label
 * Remove whitespace ahead of comma in parameter list

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/acpi/utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 2ea14648a661..300646bf8ba7 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -399,7 +399,7 @@ acpi_evaluate_reference(acpi_handle handle,
 		acpi_handle_debug(list->handles[i], "Found in reference list\n");
 	}
 
-      end:
+end:
 	if (ACPI_FAILURE(status)) {
 		list->count = 0;
 		//kfree(list->handles);
@@ -523,7 +523,7 @@ acpi_handle_printk(const char *level, acpi_handle handle, const char *fmt, ...)
 	vaf.va = &args;
 
 	path = acpi_handle_path(handle);
-	printk("%sACPI: %s: %pV", level, path ? path : "<n/a>" , &vaf);
+	printk("%sACPI: %s: %pV", level, path ? path : "<n/a>", &vaf);
 
 	va_end(args);
 	kfree(path);
-- 
2.34.1

