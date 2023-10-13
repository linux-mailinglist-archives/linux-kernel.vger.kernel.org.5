Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD507C7CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 07:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjJMFPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 01:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMFPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 01:15:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B579B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 22:15:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-58e119bb28eso2256481a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 22:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697174116; x=1697778916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKjEcIigmoEinaPG1JriR5J2v44jnRnKiYDnkmhOFmI=;
        b=jNS0bi9S1eNC72CmlTDoXqTkdO7uWjm12T9cY5V6ZYp1KO4I+9cli8pY3BFYVXtnxW
         k8/TZd8vFNgkGFkbMBcC5YveMgp+pksuHnXM71w8/UhO5QTGyt1mLk1BHBuZFKfHQXxv
         NXLbA5zaSoRXierygKoLUPB+Y2khugn/KmukTAs8qUq0jD5InyOmWwWYJJuK379a5BHi
         +8cX+INRGvF5KvKwbZpgmZ6nVNcbr37DNKbYtP9E50CNIKZHP4CqC6T2184eQ9mTw5AN
         knoJkwXLSQo54bGtaM/J6NztTJIgGo1WJAOrj7vYEJ2/eUJZL7nwQXnEES2EuGK19xXO
         m7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697174116; x=1697778916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKjEcIigmoEinaPG1JriR5J2v44jnRnKiYDnkmhOFmI=;
        b=L8wInUXS2E/Tg0rVmPP8t4ywUQqsovbsju1NEg1ysyv2iNFwrPGIWPDHDZfA+aDkUo
         941Vg0wzjdk418KlfeC6cfamOVBI292ssRhUredcOOMpRdBUVJCDrZkZVznn4hVe5GU3
         67hmfZEN6n1skVDghCj7vtUCNkLnhHZ3NiWVzNCT0EpEI5m3Ig+xk7L4eXI5+nkv82l/
         7ovcekzG457y9jz+PS4TSPN8tKQd5Genx4aZdQlvBlqwYh/BOaPsCfzpFDgJxZWPTZLP
         eigKCkBIDHJ8KiQ3ZfrwKySGygXfgBr5uZSiJm0N6pC+/mcAqXyz30DrQNYP+lrtkgFf
         lVow==
X-Gm-Message-State: AOJu0Ywe4QUMcpFNxwHI0uMQOvqp5uZ6sm2T8WUq+PXRqCAsXdRtHCJt
        UHRh9JZz5Gy1fHdzKzCQrVSdF9Hr2QS7hw==
X-Google-Smtp-Source: AGHT+IFIHVjDl5w8kCEUBtP2Sx7CTrSrJc97kJKWwdh4nhqH433WOlxPmQnOji0VmPUs6XFnCFSY9w==
X-Received: by 2002:a17:90b:3758:b0:27d:306d:71cb with SMTP id ne24-20020a17090b375800b0027d306d71cbmr2752325pjb.10.1697174116459;
        Thu, 12 Oct 2023 22:15:16 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id gp14-20020a17090adf0e00b00276cb03a0e9sm2697459pjb.46.2023.10.12.22.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 22:15:15 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: gdm724x: Fix coding style checkpatch warnings
Date:   Thu, 12 Oct 2023 22:14:58 -0700
Message-ID: <20231013051502.9578-1-soumya.negi97@gmail.com>
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

Add blank line after declaration & match alignment with open parenthesis.
Issue found by checkpatch.pl

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/gdm724x/gdm_tty.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 32b2e817ff04..0c61eaff6122 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -160,6 +160,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
 
 	while (remain) {
 		size_t sending_len = min_t(size_t, MUX_TX_MAX_SIZE, remain);
+
 		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
 					(void *)(buf + sent_len),
 					sending_len,
@@ -271,8 +272,8 @@ int register_lte_tty_driver(void)
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

