Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F047C7D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjJMGBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJMGBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:01:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E69B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:01:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c8a1541233so13825835ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697176896; x=1697781696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UZXQ64zI4dZ66y0C+/+YXtcZqO4ReFctnoAjwEvrK3I=;
        b=hpJqxhwcrfHqhTYE6zpdzono4sdN2qQ1U1zE0lZwP2GzIvDfGqO3JOvhmKjM++nAeH
         MWsWk5DKsTcf51yVvC8eS9LJXDXy8a7ZoAE3vs/siRs786qqhUG6NACtHeiiVNYG/WaM
         NfluJw33a4aNWeZC6zptjN1PTfrJMkR9vhcmX0ltHSjtR6rSV4lw3iP2Sb/UMi1JF8OR
         RpxM266dyKhCjM7yZ9oxAfEfk8n4oYA0Kl4G3FlaXdYfqC/CwDNMJ3bqIPcwtQk48pRI
         cuRhqSj7/H/wYy9tqv13Nr9IfHEhzMbqldmxZjGRr+DOLbtVT3rdmUZdLK2DoWnmRDRB
         VHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697176896; x=1697781696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZXQ64zI4dZ66y0C+/+YXtcZqO4ReFctnoAjwEvrK3I=;
        b=vXCZv0HXASgkGP2ib0G1RzVkVFml7q+RY9Kl4pO/uoD3N62OIxnly3skmryqIbrZ1P
         Un/9urhp1HCpgTa2kC1QsOhDhqw8zd4WOhzU5/05aCGiX22ISFr+avuI9JmoxuOJPQ1L
         dZ4znrQMo7oM3AckWIz19Ug+r/0AM5HkOtT4m4dNZxSKZWC//YzqbVWOInkyJ7JIfR5c
         7dq19inrGxRGvTY/5aKIZVqphYABQszCvJl9y9fpLncbWJaBjyABcgqcM9hlBj6knlJY
         8sW1vAX4w10UpWb96MLQUTGc4RaMKBg3Hcw5pE1zrP93O1tP3UCwBmAeAb+i5j3S1yzT
         QQaQ==
X-Gm-Message-State: AOJu0Yzb2VxSiNrTX7NEgGxk3tA287Qw7vZkUXCiunBxChxuQvi1301D
        mi4E4e5S1JpkIgIPzeYIX5uceSFDHzSVSQ==
X-Google-Smtp-Source: AGHT+IHS6YGo5NwZbO65+2K46BEg+PTDhOqHDaZAZ8yhhMqsRxssyTPek2pN7/qMpUu7+I6Nl6f93g==
X-Received: by 2002:a17:902:8c85:b0:1c8:7489:56e2 with SMTP id t5-20020a1709028c8500b001c8748956e2mr19887877plo.35.1697176895931;
        Thu, 12 Oct 2023 23:01:35 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id kg14-20020a170903060e00b001bbb7af4963sm2997772plb.68.2023.10.12.23.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 23:01:35 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: gdm724x: Match alignment with open parenthesis
Date:   Thu, 12 Oct 2023 23:01:21 -0700
Message-ID: <20231013060123.13400-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix CHECK: Alignment should match open parenthesis
Issue found by checkpatch.pl

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/gdm724x/gdm_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 32b2e817ff04..4e5cac76db58 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -271,8 +271,8 @@ int register_lte_tty_driver(void)
 	int ret;
 
 	for (i = 0; i < TTY_MAX_COUNT; i++) {
-		tty_driver = tty_alloc_driver(GDM_TTY_MINOR,
-				TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+		tty_driver = tty_alloc_driver(GDM_TTY_MINOR, TTY_DRIVER_REAL_RAW |
+					      TTY_DRIVER_DYNAMIC_DEV);
 		if (IS_ERR(tty_driver))
 			return PTR_ERR(tty_driver);
 
-- 
2.42.0

