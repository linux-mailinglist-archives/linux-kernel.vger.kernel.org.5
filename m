Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B675AC43
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjGTKph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:45:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4869510F1;
        Thu, 20 Jul 2023 03:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD718619F2;
        Thu, 20 Jul 2023 10:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27830C433C8;
        Thu, 20 Jul 2023 10:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689849934;
        bh=FUjvj+1KggTKf3IJ7E9yOc6WsvJXizVjHxqnoZ8GHtU=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=XLq7frlQ+DX2iZ0GWH2j/yLPkJfirUGRg9xQhj3tKq1QsU/nlLSHzwm/UqB7d7B7z
         TxB7TBmCSiVXnFdNYDZt0pkx1bZ6AGG3Vw+Wc7dS6NB4NRDAnIoETNJIuLGhUVgfrZ
         wB6SRhcCtFmcTwB8f/12BWW/nUvhzszmm6rdwsb9rBIAB+wilg9EBhbUgylZlYfNEj
         8p9U+7X2S2P84OWpFc2uapIzQN8nc7mgdx4W8DdPywF6Bai7nLVF8Pf8DfceZkS7+v
         GDA6UehCrOAO9YjdLA3x+G8wjwu2EETigVHtT2VY6QqhkMJ7KyePq9Sopd/Pwxb5qR
         pveC4rS5+osbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 08CE8EB64DA;
        Thu, 20 Jul 2023 10:45:34 +0000 (UTC)
From:   =?utf-8?q?T=C3=B3th_J=C3=A1nos?= via B4 Relay 
        <devnull+gomba007.gmail.com@kernel.org>
Date:   Thu, 20 Jul 2023 12:45:22 +0200
Subject: [PATCH RESEND] security: smack: smackfs: fix typo (lables->labels)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230720-smackfs-lables-fix-v1-1-7994a1f7e45a@gmail.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689849933; l=959;
 i=gomba007@gmail.com; s=20230706; h=from:subject:message-id;
 bh=S9HyRNyzLwD2W29A0DsX2ZZZiM4IO3L3DpcXXpfmTVs=;
 b=XYaR86b7SPYm2uXmkLcj3CqPenNe9TpKXk3lIAAOYRLSyyGrVDIADV94Uh2cqBkvExkRCO4nL
 bBni3x5S3snD52/vgxYtNhQYlTPd9BnVsZJk2MR1sMKOrTOGalzsdM2
X-Developer-Key: i=gomba007@gmail.com; a=ed25519;
 pk=iY9MjPCbud82ULS2PQJIq3QwjKyP/Sg730I6T2M8Y5U=
X-Endpoint-Received: by B4 Relay for gomba007@gmail.com/20230706 with auth_id=60
X-Original-From: =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
Reply-To: <gomba007@gmail.com>
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tóth János <gomba007@gmail.com>

Fix a spelling error in smakcfs.

Signed-off-by: Tóth János <gomba007@gmail.com>
---
 security/smack/smackfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 5590eaad241b..2b79c30d4bb6 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -114,7 +114,7 @@ struct smack_known *smack_syslog_label;
  * SMACK_PTRACE_DEFAULT    regular smack ptrace rules (/proc based)
  * SMACK_PTRACE_EXACT      labels must match, but can be overriden with
  *			   CAP_SYS_PTRACE
- * SMACK_PTRACE_DRACONIAN  lables must match, CAP_SYS_PTRACE has no effect
+ * SMACK_PTRACE_DRACONIAN  labels must match, CAP_SYS_PTRACE has no effect
  */
 int smack_ptrace_rule = SMACK_PTRACE_DEFAULT;
 

---
base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
change-id: 20230706-smackfs-lables-fix-ac965c4c479f

Best regards,
-- 
Tóth János <gomba007@gmail.com>

