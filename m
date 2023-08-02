Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883EB76C175
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjHBAWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjHBAWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:22:07 -0400
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A471211E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 17:22:04 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6bb23d4b3b7so11508446a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 17:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690935724; x=1691540524;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KilSXJK2MVD2AnPm9S8tYLf7mVOFKVkH/54xfLNRqRA=;
        b=OH8wphWtMmg60OnMDGFBbF7ujCNGPfgd2hbBYp4SVBYlFKrjyQu3OyqQGskdp6nUx0
         zrZQow/qzsJWNWHEmuV3V2qPKIKMA9s5C7cY/R7IaT/DqJ6oRdyQY2b82z5poBpUR27F
         du+pXzKwbNL4p7SmBwzwQkAIr0EraF+KpipRtx/9CfQdlWuxFUre1Z5oDrSL9dfERZ8Z
         Ew5uf/pjeNaDEYFWcjMiEED9VgKAfpBYhKT2+HnffFuA0R6qzLEBFB96EoqyguDp8xX8
         3hd9790NAi7zG25zuNBEJP/3LXIyAhUPtDDFV6dHiirHEEXFpZqC04f5xPep+Ptk6QbE
         7/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690935724; x=1691540524;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KilSXJK2MVD2AnPm9S8tYLf7mVOFKVkH/54xfLNRqRA=;
        b=JGWYc5LyC0k4B7N6P2bHjqFIldRtqIdficz02yoSFuJRr3ZAgBS2dStv1NIYG2PzMs
         ENlBDCUIXW6BFQWdvrZlhyh9Q1lScMT53Jm0XeRnN4nf7n4q7AVdx2MPYWkQzC2t+l66
         /IlEWXhwANL1cK374M3yaONN+sxfmZgY2m/qJ1Ur3Il8Kcgoemb8ZBnkNFLy6xKnh+8B
         I6HBIrESrEHSYRXHqPVEi97ZbxGHUb1cYCNUYYYS8MnB3H8KO83pp/5JgN7CmD2S08QM
         wUcrxybX5QnNMRWfH4f27xkVtuB2RU7tvtrfQtOk53P+jeNRNvfAdT4O7mDb1MLxh1Kk
         E2Ng==
X-Gm-Message-State: ABy/qLZqFGELrwXFUwGhA4wvbgYdw8fx0DC/8KWgdU/iN9Vu71Y9CKSO
        c0Vr//4FjC+X3hIniI42/fu9GT/p5ei00xOX5A==
X-Google-Smtp-Source: APBJJlE6hQQSIqZLj/BmT+qswU4s+FzGwFzE/FiZyI/8dUSztNts5afzNmPqF9G3rBrPkMhq6NyTiD2qAN7/Qj9lhg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a9d:7f0f:0:b0:6b9:6ef7:72f3 with SMTP
 id j15-20020a9d7f0f000000b006b96ef772f3mr15098160otq.0.1690935723801; Tue, 01
 Aug 2023 17:22:03 -0700 (PDT)
Date:   Wed, 02 Aug 2023 00:21:58 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKWhyWQC/32NQQ6CMBBFr0Jm7Zi2ECSuvIdhAcMAE5GSqWk0p
 He3cgCX7yX//R0Cq3CAa7GDcpQgfs3gTgXQ3K0TowyZwRlXmsZY7JRmVAkU8cG68oK26kzVENV VfYG825RHeR/Ne5t5lvDy+jkuov3Zf7Vo0aLry9ENZHqq7W3yflr4TP4JbUrpCzEeraazAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690935722; l=1734;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=D6hZsVI6Tg/cS4gcm5zBne5/wTMEFngDX9MakiPlN9c=; b=BFamEJKVk9qr4ymm+TIZ9Pu636D4xvSUp89XThBbJXvRx+VpNnfLVUV6Vf6elstDWbOXogA6B
 CRRIKYBa1mlBCWmpuuUH5qNbPrKKy1Gn0mQyZbapFhj08hVrY2pqzkp
X-Mailer: b4 0.12.3
Message-ID: <20230802-arch-riscv-kernel-v2-1-24266e85bc96@google.com>
Subject: [PATCH v2] RISC-V: cpu: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

Favor not copying strings onto stack and instead use strings directly.
This avoids hard-coding sizes and buffer lengths all together.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- Use strings directly instead of copying onto stack with `strscpy` (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230801-arch-riscv-kernel-v1-1-2b3f2dc0bc61@google.com
---
 arch/riscv/kernel/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index a2fc952318e9..872fa7a47d68 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -271,21 +271,21 @@ static void print_isa(struct seq_file *f, const char *isa)
 
 static void print_mmu(struct seq_file *f)
 {
-	char sv_type[16];
+	const char *sv_type;
 
 #ifdef CONFIG_MMU
 #if defined(CONFIG_32BIT)
-	strncpy(sv_type, "sv32", 5);
+	sv_type = "sv32";
 #elif defined(CONFIG_64BIT)
 	if (pgtable_l5_enabled)
-		strncpy(sv_type, "sv57", 5);
+		sv_type = "sv57";
 	else if (pgtable_l4_enabled)
-		strncpy(sv_type, "sv48", 5);
+		sv_type = "sv48";
 	else
-		strncpy(sv_type, "sv39", 5);
+		sv_type = "sv39";
 #endif
 #else
-	strncpy(sv_type, "none", 5);
+	sv_type = "none";
 #endif /* CONFIG_MMU */
 	seq_printf(f, "mmu\t\t: %s\n", sv_type);
 }

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230801-arch-riscv-kernel-14a048cc6467

Best regards,
--
Justin Stitt <justinstitt@google.com>

