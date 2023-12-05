Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EA5806223
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346496AbjLEWuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346271AbjLEWuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:50:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F54B5;
        Tue,  5 Dec 2023 14:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=k5UHSRsYexw7YmIWFMZ0g5GX98velugEhzwlyJPyNlg=; b=l9rnlWkX3cI7xQFCITWtTqZHAM
        LLN4oI0AATxWrL7asoJGj9grOX9Yw5ig4KtJEThvJl3ulaK/GXar9m+pJpAJm+D4+EnGM+t08/zH+
        FqgZezLmUzy4UV2ID69QDGYCdbEsfdAhOph4eCt+xJ1yqx2KMqR5+dDWncUgDUk9wLksHQSjaVYpE
        E6HiLXATL5ZbPcBcHiDZ/xuSApc6rD35I/4BZpRA7032U6baxIdgMZoppNH5SCJs04z1l5M3RbGHr
        jsrQYcdbIWz820qumwkjfvGolZxXV/csMQfFWvy/t+3Y9hGZIf5J+NQfY8PCzCDvr44GyYmao3Q/K
        S04cRKmA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAeFa-008YJL-0B;
        Tue, 05 Dec 2023 22:50:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: watchdog: fix kernel-doc warnings
Date:   Tue,  5 Dec 2023 14:50:45 -0800
Message-ID: <20231205225045.32121-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings found when using "W=1".

acpi_watchdog.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
acpi_watchdog.c:85: warning: missing initial short description on line:
 * Returns true if this system should prefer ACPI based watchdog instead of

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/acpi_watchdog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -81,7 +81,7 @@ static const struct acpi_table_wdat *acp
 	return wdat;
 }
 
-/**
+/*
  * Returns true if this system should prefer ACPI based watchdog instead of
  * the native one (which are typically the same hardware).
  */
