Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B3779B304
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350080AbjIKVfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243828AbjIKRxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:53:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F405DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:52:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59593051dd8so48570667b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694454776; x=1695059576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FfX6RSRA/tErdP/6b3BPnVn+Cseh6Qa8GqkXP+/ygfU=;
        b=XeaiYAC9+CQfh11TsC0QXPCO3rfzkOtVEeyEzdjXndeYy4ATbmwq2pqCp5djujoZ+C
         TKF0ggE95q7zog6ODW7gOxgSBLOur9eKWQIqST1N0Cqfn4NFfGXMmjpkK5Tri7rp2ktw
         tIvZvTLAb5XSuzgO0dzyKNHqkq2i7RPm16tkELQ1rqLFoftr7t3YoOWso0shnWGfrXZu
         M6gEPYEUAIKp4vMu9xeGEoo76CWq4RVxns2qQThY1vcblQFDSVFi6HJi4xfnJHIR2xnh
         ypkQEivqfgt2Yh4gwvmac68t+vgCp8jWU5etdzHFS81li7twShz4VYH4QKB8Rnn0GD+S
         PZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694454776; x=1695059576;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfX6RSRA/tErdP/6b3BPnVn+Cseh6Qa8GqkXP+/ygfU=;
        b=miOErs/U6SyQFOmDX6QNIlYAteQenMredNo8cA9siOJLv81PRxvM0sJ9vJz3wJmQr4
         xIjr8Y3mYBAvMQJlh2ouxz16oHFjgavP2uJUr24P6e4FeCXB2lCJL8hVJ11PXNNGp3pX
         cqM7DXoS/XnujVkA+fkf3+3UebkMcK2ipEsUM6DECNmF+H83tRWR3CfXXGXN3hlXiNVL
         0bs0GoR23y590dPHcVyEnpJZBM+jGStVzM5E3DUyfeUKzKUwqvjL2VSYsHnTozgXVgD9
         y6YDwqLYnJsmHjsL+2tIXXdJF2qkf23+qTdvB8tVhIfhDzaQzBmiRR5zRIQtOvEf5Avi
         NikA==
X-Gm-Message-State: AOJu0YypuU32mHaoO5HXAzAOvoZ16QX3hfJ07B95szx+VfehCXQTIz98
        pjabBDukFn0s9xubsZnU+j0UmaGV7qc51J3IQw==
X-Google-Smtp-Source: AGHT+IEA/Fl4erMnmYdtrmI9xarwhf9E5DXlxyKwU8nOP9w68+WoAh6IzaJY9FBWx8oyGyINbpWCxI9Xum07nwJFww==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b706:0:b0:58c:74ec:3397 with SMTP
 id v6-20020a81b706000000b0058c74ec3397mr248983ywh.1.1694454776558; Mon, 11
 Sep 2023 10:52:56 -0700 (PDT)
Date:   Mon, 11 Sep 2023 17:52:44 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOtT/2QC/x3NQQqDMBBA0avIrDuQKJamVylFJBmbgTaGmUQs4
 t0buvyb9w9QEiaFe3eA0MbKa2phLx34OKcXIYfW0Jt+MM5a1CLJ5y/O4iPWD66Kb051xyC8kSh SiSRlzlNtNHq8jc5eTbDDMjpobBZaeP8vH8/z/AG03h9UggAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694454775; l=1822;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Wgwz6kVMUOE/MdaR7dFrpNbwIMGBA/OsTf12jDBzZgQ=; b=msb87huM5Q1fxVqPK+dd7EGT/+zyiEGIFJ8brAYfbNJVy1XYEB3ede05shCahtgbcub2GG4VL
 XXvEL7We+4lCTj6XZm5nuJguI+xwBOM+eD8TJpQ3x7NELmT7z7rybnE
X-Mailer: b4 0.12.3
Message-ID: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
Subject: [PATCH] um,ethertap: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

`gate_buf` should always be NUL-terminated and does not require
NUL-padding. It is used as a string arg inside an argv array given to
`run_helper()`. Due to this, let's use `strscpy` as it guarantees
NUL-terminated on the destination buffer preventing potential buffer
overreads [2].

This exact invocation was changed from `strcpy` to `strncpy` in commit
7879b1d94badb ("um,ethertap: use strncpy") back in 2015. Let's continue
hardening our `str*cpy` apis and use the newer and safer `strscpy`!

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 arch/um/os-Linux/drivers/ethertap_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
index 9483021d86dd..3363851a4ae8 100644
--- a/arch/um/os-Linux/drivers/ethertap_user.c
+++ b/arch/um/os-Linux/drivers/ethertap_user.c
@@ -105,7 +105,7 @@ static int etap_tramp(char *dev, char *gate, int control_me,
 	sprintf(data_fd_buf, "%d", data_remote);
 	sprintf(version_buf, "%d", UML_NET_VERSION);
 	if (gate != NULL) {
-		strncpy(gate_buf, gate, 15);
+		strscpy(gate_buf, gate, sizeof(gate_buf));
 		args = setup_args;
 	}
 	else args = nosetup_args;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-859160d13f59

Best regards,
--
Justin Stitt <justinstitt@google.com>

