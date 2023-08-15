Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0E277D497
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbjHOUsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239709AbjHOUrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:47:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B8210D;
        Tue, 15 Aug 2023 13:47:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc7b25c699so36101325ad.1;
        Tue, 15 Aug 2023 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692132434; x=1692737234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1DJrBiG3w++AEcOTBn4KMkS3FoKlqolWUyFd9yHBFqE=;
        b=IrJbCdqgtsMAN0bN1cSxGImYPfQbQ5o6H2nhlOrwDCJpyHc6HWhAWvNxVT4jI7yjHH
         CFm8vsmTaGBMH4ILza5FaKG4ipTHMWXHRYicVWWzWVrPCVG7nTWWjWjt8cQfEI+2y/WW
         6Z1OnoqmUQuq0q0lynWgsPZpfd+9TbXueyYQZddzspywiH1IpvUFoTVDcyfCerb4W7Md
         6QDWrN9QVq2GhPWx8+eonezaqr0EGvSL76jwzdVJNMZj9C3JCUrll7LIg1nXruUUoFEE
         LA+EOVeAlBDy1OYl/yU7ixpNLts1VtTrutpqPPA25QCgh7Ivby8ZnQ1pbOTDd81jhUYM
         SiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132434; x=1692737234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DJrBiG3w++AEcOTBn4KMkS3FoKlqolWUyFd9yHBFqE=;
        b=GkFOLR14/UzolXbkSjoydG+J98QtfaoLujy4iFb0UiT985OFQ5QflAiDFS/quDuVeu
         BJoQXTuBx3aw0NfEuIR7pWNZtChTBWcm+e6F1teHli/HUUXiLi/cJ8w+eCXugGz2w3Nr
         wwl0Jz3q2yFGYCDr9WP3DUc0KRv4Z0F7Tpvb4/ay6PFf0jt0K/ZTv70PLNs3MlEt4I1n
         gVnDstplQTn5L/Ba+Tyzo97AeT6aa12j7TaKK6xty4auojeeymzn8OAvwx7z1g8NFGLW
         z21KWVm31Vp2vIK3JztDUdpIftuPSBmah7KKygGTw7Fw14f3jzbZ6WUZvE7tR5Q7TOku
         MqUQ==
X-Gm-Message-State: AOJu0YyuiLaao2/6aTOf0E8Iq4Ft7nMCbvZ5V7Wtoa4h1ugvAMkR61LL
        aBxtFrfx0o1+XrTXfH5ZsWMnxWJG0R4=
X-Google-Smtp-Source: AGHT+IGvPAV/XJKZB4RcMANHMh2yKTjRnwDljaVwtaiWZrSa2crx86jlqK8DPYeipCcp291zqiy3Pw==
X-Received: by 2002:a17:902:9a48:b0:1bb:673f:36ae with SMTP id x8-20020a1709029a4800b001bb673f36aemr5201plv.15.1692132433865;
        Tue, 15 Aug 2023 13:47:13 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:db85:3caf:1429:e455])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902b58b00b001bc676df6a9sm11521575pls.132.2023.08.15.13.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:47:13 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     paul@paul-moore.com, eparis@redhat.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: [PATCH v1] kernel: auditsc: Removes use of assignment in if condition and moves open brace following function definitions to the next line.
Date:   Wed, 16 Aug 2023 02:16:44 +0530
Message-Id: <20230815204644.52358-1-atulpant.linux@gmail.com>
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

The patch fixes following checkpatch.pl issue:
ERROR: open brace '{' following function definitions go on the next line
ERROR: do not use assignment in if condition

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 kernel/auditsc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index a674039ea9ef..d88ebc911277 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -880,7 +880,8 @@ static void audit_filter_syscall(struct task_struct *tsk,
  */
 static int audit_filter_inode_name(struct task_struct *tsk,
 				   struct audit_names *n,
-				   struct audit_context *ctx) {
+				   struct audit_context *ctx)
+{
 	int h = audit_hash_ino((u32)n->ino);
 	struct list_head *list = &audit_inode_hash[h];
 
@@ -1064,7 +1065,8 @@ int audit_alloc(struct task_struct *tsk)
 		return 0;
 	}
 
-	if (!(context = audit_alloc_context(state))) {
+	context = audit_alloc_context(state);
+	if (!context) {
 		kfree(key);
 		audit_log_lost("out of memory in audit_alloc");
 		return -ENOMEM;
-- 
2.25.1

