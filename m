Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3A7B7469
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjJCXCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjJCXCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:02:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16D0B0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:02:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-278eaffd81dso1090297a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696374133; x=1696978933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nEaRtaRax1n0h+1IKPeikRHaTx6MRk96Qy5GH4j8LaQ=;
        b=EzlLmj2oJp/hxPa+CD6Hcew2zFqskosP4shxeocDaYZXCqwIuFbiYSXercrtckIsvV
         vSRWruFCqWjKUCeE8ehlGgBJ6ve1hAKqkeYZGvHgWJ9F1LRlGE7C3F1ncrUIhuMN7tse
         +Plo2WsUXhmUCAelOcwJ5QskH9epT4mZ+vqca3cPMmHcHILiAS0kgaJCPAFZtWa+Vrrm
         cKDpqwGdrTRkQSKp1mFuaPNB9ogc77u4vufKLPkEnEDny7sxkk6YPpdKbhguVy0rf23G
         50cLHRvIOXhCH1nVI/1HAuUi+xOG1JPhn+IabDnq/gomHqj43SUtDXTkuGfPLFPzJpR6
         urMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696374133; x=1696978933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEaRtaRax1n0h+1IKPeikRHaTx6MRk96Qy5GH4j8LaQ=;
        b=EsN8hEDXaAQcI5G0oVih9/O01W44BE0UUeJiWH1oasHXXQXqASeREtdE7gjR0qfO7e
         BHNbo2ZYSkO1UUNOPjovcSK23FYfzxGk4vlY3hjW5KmiUN+U0TrhY9Gi3Zx+G+L0Zm+J
         0pVlqKVL98HuTZuAAKB9kyGAikqTDHxWCBcIbdfgPjoAFNhr+Q6tWvsnIf3o4ETgyS2L
         FsJjYLQGGWeQWDgEKgygi81XCtCCauhNLDn6xWLYrUuLg1BSt46UMiT7jQLEdyM5YizM
         e76nIOAc/C8fcgIKPxAkkAQTBzzEDZYS/t7KFx/Oq6r3SCMHyiRkM6Z3wTo7IeI3b+fM
         Y4zg==
X-Gm-Message-State: AOJu0Yzc8bqIWO6nJYcsxbhKCGnCNqZbNOWsyYObsWgJLwMOzKpwtt+E
        PJ69TeJWr/Rf+YAP7ppepj7BMTxA60Y=
X-Google-Smtp-Source: AGHT+IHSyviMq44U3UuFEk2M4ds+PrQx58KEBZHBDUujKrCVVa2ZnMDeTAUbtE9+odUQcUIRWSBM3A==
X-Received: by 2002:a17:90a:4292:b0:279:be6:bf73 with SMTP id p18-20020a17090a429200b002790be6bf73mr732397pjg.11.1696374133149;
        Tue, 03 Oct 2023 16:02:13 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:1d9:902f:6531:9779])
        by smtp.gmail.com with ESMTPSA id ji13-20020a170903324d00b001c727d3ea6bsm2167940plb.74.2023.10.03.16.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:02:12 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: use proper address entry count for direct nodes
Date:   Tue,  3 Oct 2023 16:01:55 -0700
Message-ID: <20231003230155.355807-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
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

From: Daeho Jeong <daehojeong@google.com>

For direct nodes, we have to use DEF_ADDRS_PER_BLOCK.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 78ffdb6..56a7d31 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2894,7 +2894,7 @@ static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sbi,
 	fsck->chk.valid_blk_cnt--;
 	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
 
-	for (i = 0; i < ADDRS_PER_BLOCK(&node->i); i++) {
+	for (i = 0; i < DEF_ADDRS_PER_BLOCK; i++) {
 		addr = le32_to_cpu(node->dn.addr[i]);
 		if (!addr)
 			continue;
-- 
2.42.0.582.g8ccd20d70d-goog

