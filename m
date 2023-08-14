Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495B877C347
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjHNWLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjHNWLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:11:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3071BB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:11:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d6349e1d4c2so4064088276.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692051092; x=1692655892;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CMcdRD24atYHQ4ASbvndMrLmRw1xxWMNBnFpR/mRjlk=;
        b=HuqgTRKoklAsdTv01+eJc2nEa8jvomwmVl1Dw8TZU5BWfw9XWQSaI6zrx1ldt1uleL
         DL1DM5ofxEVUFClCMFYhN4S7AHSKFQyDS5c89+UQACDbUfjhjebi8MKjMZT/dqSqLrmp
         r+tKKjojKe4LehRwglg/xrVMe1SR2w04+QM+UkJUsjmylvSbAfmKBsa6F429r2Ot7Cwt
         jjnJPYNk622Xm9zldrGQOd+OHgXNb946EGkZGni8hc4bmcS2ID/VhtdHCosV6NzhmTUp
         83BonW5fwbtL/KkXUrdhF1kOC3rHrU7Nz7fBesTse77Zvxiq6DOQ0zH2lolhnz1vNo2Y
         wonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692051092; x=1692655892;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMcdRD24atYHQ4ASbvndMrLmRw1xxWMNBnFpR/mRjlk=;
        b=HvHcRzVEyR8wQ2XnaQ9E0XBalrM2ewPQLQuAlpRsnn6xXIhuZ9y/w2FzRqb06+IStF
         XdZLj2vflBLKjdCwvcnkUGELYnLEXZakgvJ4Q44QKq4fpNh8YII0AhuJN6phK8YrxKZD
         ICqVtk16ZxPIwVtK79Fyjc97QXx0tOk+aMQQgWebvL+NubT3evtcyeik/cLoIo5bdl+Y
         tdmGPAPGl1+W3D8plwTq61S2b1xLH7ajLIwVEk4igdT4W+S98Mu3ZzD1QWE8Nk+Z0Ib8
         KpTHCMA1OuRu/RhONOWVuMlCc9W/rIXRgitEjnxvmiSFvXXN2IXa0H65U5GDSiUB6H6+
         CmMg==
X-Gm-Message-State: AOJu0YzWn13Tm+3SjPi5UYyXxLKFmxxVc16fEg3e5j/mT2U61TullDGQ
        eTNy8bfD1Tv8APN9pfNdw3I+boeabP0N3EzOQA==
X-Google-Smtp-Source: AGHT+IFge6sMjlzuWc91VOTqFOPoOtO9DhwycrLl6JYCuJSnpwiiizAteB6AGo2bWHyHSzmtkYNWoxff+qRYMspZeA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:b190:0:b0:d4d:564d:8fbf with SMTP
 id h16-20020a25b190000000b00d4d564d8fbfmr146274ybj.13.1692051092011; Mon, 14
 Aug 2023 15:11:32 -0700 (PDT)
Date:   Mon, 14 Aug 2023 22:11:28 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAI+m2mQC/x3NwQqDMAyA4VeRnBdoq6LbqwwPXZq5wNaOBIoiv
 vvKjt/l/w8wVmGDW3eAchWTkhv8pQN6xbwySmqG4ELvZj9gLZIwqVRWQyuEypktGuqnPOTNaLs RXmc/uhjGyRNBa32Vn7L9P/flPH/3xh9OdwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692051090; l=1743;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=wIdErpsOv+ezc2N3195w2EaGkvC3nzErvAaVNhdk/Rs=; b=QvPWejA1W6dyxCS1W8dn15uDJwEG3gwju4x31ItwOpaH9xtSR+GXhgUPir79VMcQJMlD7Z+Vy
 yJZvZwaPECSBBH9pvOyco404PO0xKNU2LexES3A6CKLz0bnRKG54Hp1
X-Mailer: b4 0.12.3
Message-ID: <20230814-void-drivers-soc-renesas-rmobile-sysc-v1-1-6648dfd854de@google.com>
Subject: [PATCH] soc: renesas: rmobile-sysc: fix -Wvoid-pointer-to-enum-cast warning
From:   Justin Stitt <justinstitt@google.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang 18 I see the following warning:
|      drivers/soc/renesas/rmobile-sysc.c:193:22: warning: cast to smaller integer
|               type 'enum pd_types' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|        193 |                 add_special_pd(np, (enum pd_types)id->data);

This is due to the fact that `id->data` is a void* and `enum pd_types`
has the size of an integer. This cast from pointer-width to int-width
causes truncation and possible data loss. Instead, cast to `uintptr_t`
which has the same width as void*.

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: It should be noted that there is likely no data loss occurring in
this case since the enum only has a few fields. The narrowing cast from
pointer to int will not lose any data.
---
 drivers/soc/renesas/rmobile-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/rmobile-sysc.c b/drivers/soc/renesas/rmobile-sysc.c
index 912daadaa10d..0b77f37787d5 100644
--- a/drivers/soc/renesas/rmobile-sysc.c
+++ b/drivers/soc/renesas/rmobile-sysc.c
@@ -190,7 +190,7 @@ static void __init get_special_pds(void)
 
 	/* PM domains containing other special devices */
 	for_each_matching_node_and_match(np, special_ids, &id)
-		add_special_pd(np, (enum pd_types)id->data);
+		add_special_pd(np, (uintptr_t)id->data);
 }
 
 static void __init put_special_pds(void)

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230814-void-drivers-soc-renesas-rmobile-sysc-98150a2571cc

Best regards,
--
Justin Stitt <justinstitt@google.com>

