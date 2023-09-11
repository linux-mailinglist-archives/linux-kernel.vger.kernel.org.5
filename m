Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2079BFED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbjIKWX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243939AbjIKS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:27:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DB21A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:27:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58f9db8bc1dso48735607b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694456847; x=1695061647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p4gDHjdo7g0e0VEUdde9XhYVf3BvNK1Q4R1IFhdu2EU=;
        b=2ghIN16C+85JNtjLFbVOdwlr2kwwxPlmKzcutw6C3YmWUJCq5eLYMpzFZHlUEvgFMe
         lPNksjrlVZDLLnbYXPTioJY2LdAnoFUFJCcKIhABtWRyUcCtMma8NN510Sfc2Zjb6iXe
         iTN2ywHMEENOnLU1ME9Hb3XcfqVaDRxnxlw9ZnvD82PWl20TBdj9f3W5ccY8MlPsj33T
         4SOILPiPFYdXH84tyEpk7tf7QBU93TV6ySExY/DgQ8e+w8zZETyyKOQnQr7Q1QofJ+ym
         pz1I7g4qatqEDu+/lj/4W1FGjB3cVlzOwncrZbr0Ohu/W/9suWEDAEEG5s0RzurIwRMi
         qFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694456847; x=1695061647;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4gDHjdo7g0e0VEUdde9XhYVf3BvNK1Q4R1IFhdu2EU=;
        b=uWLRRllCLNiBsaOkNUMnRrILnlqGsRSo3p0kodtLur9fmk2TNxz5rhTUZVIB5/AHDd
         hKh/Yiym7tpNyAa6s54t2/35XIrHZadAUXErVI5llg7KLxO/wBznFE4MPTsFg6KWZwo/
         iMttYrrPyxDcuXfKX+nyueEpACIwAZizz+WBvbR+9Yi2Z3Gd5CYs2kkqt5TF0hUYyJoW
         eRjoC+g4GR6JhSdbz2frO+N1KaheZ9m54NeZnMq3MC4K6K2ewIc5kk5raNqUIBfLCZnz
         IMR5i7j5bDtqP9ncPhrVIfA5pr2bmQurkz5bloLTENCnaBWZLaBvi+ESb1s+upCKb+tw
         0Aog==
X-Gm-Message-State: AOJu0Yx+zPrc2W0CWnNsmW6uV1J80LEPO0cPW1dzEDWdqTe11T2Af+/l
        ee7hfVgTXwtBAiueBeNU0CQv2RciUWvOoQFiaw==
X-Google-Smtp-Source: AGHT+IFXwRs2WiPU1oQO41cJq/UB6Ht6s9+w8CBY9n7RHSCOA92/od6eE9lpWuVMuGg4p6bdi9Xfs61/jcv0peYObQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:cb05:0:b0:576:8cb6:62a9 with SMTP
 id q5-20020a81cb05000000b005768cb662a9mr261505ywi.6.1694456847000; Mon, 11
 Sep 2023 11:27:27 -0700 (PDT)
Date:   Mon, 11 Sep 2023 18:27:25 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAxc/2QC/x2NQQqDMBAAvyJ7diGxEJJ+pfRgNtu6l0Q2IhHx7
 wYPc5jLzAmVVbjCezhBeZcqJXex4wC0zPnPKKk7TGZ6mWAt1k0zrQfOSgs275AKFdxSeyAMPpo YnIvRJ+iVVfkn7Tl8vtd1A6LFs0JxAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694456846; l=1696;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=dB+yasP8Bzxdh37I4XyOTceZ5yt48YWVpNpjD6rXby4=; b=FlV+BHOQFu2YvXN7PEVhHveROJCatNBEXKLmz3ikk6gHqPooRAghFock1yvnxmr/1xo2rxa0R
 /y9OxN0uAveB0WeynZZwEf9tY2My2NYnliox/S8LAYpzG4xaPOFDuJe
X-Mailer: b4 0.12.3
Message-ID: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
Subject: [PATCH] x86/tdx: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated and we should prefer more robust string apis.

In this case, `message.str` is not expected to be NUL-terminated as it
is simply a buffer of characters residing in a union which allows for
named fields representing 8 bytes each. There is only one caller of
`tdx_panic()` and they use a 59-length string for `msg`:
|	const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";

Given all this information, let's use `strtomem_pad` as this matches the
functionality of `strncpy` in this instances whilst being a more robust
and easier to understand interface.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 arch/x86/coco/tdx/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b0..2e1be592c220 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -119,7 +119,7 @@ static void __noreturn tdx_panic(const char *msg)
 	} message;
 
 	/* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
-	strncpy(message.str, msg, 64);
+	strtomem_pad(message.str, msg, '\0');
 
 	args.r8  = message.r8;
 	args.r9  = message.r9;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230911-strncpy-arch-x86-coco-tdx-tdx-c-98b0b966bb8d

Best regards,
--
Justin Stitt <justinstitt@google.com>

