Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D3379BF66
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241574AbjIKVRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbjIKS7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:59:42 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2BD1B8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:59:37 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1cc7407e507so6097853fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694458776; x=1695063576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FyAfsddzgMfH7Rve3tTC+ObTn5S/B+6cd6RfEH0mPVQ=;
        b=qg5EIL9lNKuP0fC/XHvZFFsuW4nQFl1cBMrUh0VXQsBDPZuzO6UVXC5Hfnb9OCk0tL
         4XAKdQGu8/H1w+FYemhLIwRkFEfKwX23+6LGydRnQ/Shb4D11Kk1BRctJuriygQvlvpn
         xI3IRVMcGqNViunkHVr/nwYVdKl/JAbTla0y1HoUn9VLAzf59imgMWDDOd3czUZ8FxZc
         0mXaRL+Uj58IxpxZQeQK5p8UoioSFpbCG5e2L34bEusyk5x7ZY5RMOEbyRI8lqKGV9wz
         wsxnw/+nm3+sf0wn3qaUrbmsRhmVGdu74OQ6UxznnUQMNygFZX9epR0QnDAv6fkDTW60
         wL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694458776; x=1695063576;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FyAfsddzgMfH7Rve3tTC+ObTn5S/B+6cd6RfEH0mPVQ=;
        b=I7ogf7FGrMhj9yWTi+931L+qD4+jxypPHg+FZpMvdBFlPjE4N2d6rwTfDNN/sm3wEs
         haPI9fpFW5Ijdec0bGoN79xM1DELPIr4NccatYa9XnJqltsC/r/qWbDi8hpzBHUHYcg/
         RlNqWG+qj5nepje6jHRpbH4PEnNa5TpaP4b4rny3vFx6uitTMzp68H+50DHRn+ax82Qp
         KuWHJmqfplJBU3k1N0vpopG0IDhQuVf9zb86vZ4XvL5diuRtlfydQUgGgsqLSfNsFFsH
         vxpcdtpyBxc9BfF40mIZz5YuIDwxQJ0ISnC2yXKmd6mydc7mKi/IYDfYjk8nWI6cPQu2
         NOkA==
X-Gm-Message-State: AOJu0YyuVNSP02KgJCOPpPLSsn1Hs/9XKSCWCc8SPG03P0IliJ0ImP8s
        cP3iUjOquZsaFi6jsQBJO8N8TpVgBkxRxGSJUQ==
X-Google-Smtp-Source: AGHT+IG59wr8uLni3C2V55r07TIhyuDid4iDz2o8Yv9hT/IRZPvGxl55SBxndfL1I8UCe+ixrBA6mOeCDnFrXvY09g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:9e86:b0:1d5:95fc:2a65 with
 SMTP id pu6-20020a0568709e8600b001d595fc2a65mr148856oab.0.1694458775855; Mon,
 11 Sep 2023 11:59:35 -0700 (PDT)
Date:   Mon, 11 Sep 2023 18:59:31 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJJj/2QC/x3MPQqAMAxA4atIZgO2/tariEOpUbNUSUUqxbtbH
 L83vASBhCnAWCQQujnw4TNUWYDbrd8IeckGXem6MkphuMS780Erbsc4dBjJI62MDlWjjV5b2xs iyINTco//fJrf9wMst+a9bAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694458775; l=1828;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=DBdVSubynrF3pAFkkMi1f9BTT60ciWDcbq2SU5EuRBg=; b=CYAmwiK7CDP7Z4adgOTjVKLEq7h3INeqRHS6jvpRLX93AfrV+Q2Ca6uptviT7Eq/HPolQcYba
 0Nfvn1OstRHDSyzQLfFZDyLtDKOqlDinW0kE1WVe67cXgmYQQVy+vkC
X-Mailer: b4 0.12.3
Message-ID: <20230911-strncpy-arch-x86-xen-efi-c-v1-1-96ab2bba2feb@google.com>
Subject: [PATCH] xen/efi: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
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

`efi_loader_signature` has space for 4 bytes. We are copying "Xen" (3 bytes)
plus a NUL-byte which makes 4 total bytes. With that being said, there is
currently not a bug with the current `strncpy()` implementation in terms of
buffer overreads but we should favor a more robust string interface
either way.

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer while being functionally the
same in this case.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 arch/x86/xen/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index 863d0d6b3edc..7250d0e0e1a9 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -138,7 +138,7 @@ void __init xen_efi_init(struct boot_params *boot_params)
 	if (efi_systab_xen == NULL)
 		return;
 
-	strncpy((char *)&boot_params->efi_info.efi_loader_signature, "Xen",
+	strscpy((char *)&boot_params->efi_info.efi_loader_signature, "Xen",
 			sizeof(boot_params->efi_info.efi_loader_signature));
 	boot_params->efi_info.efi_systab = (__u32)__pa(efi_systab_xen);
 	boot_params->efi_info.efi_systab_hi = (__u32)(__pa(efi_systab_xen) >> 32);

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230911-strncpy-arch-x86-xen-efi-c-14292f5a79ee

Best regards,
--
Justin Stitt <justinstitt@google.com>

