Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB377994D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbjHKVTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjHKVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:19:29 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BFD2130
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:19:28 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-187959a901eso2809270fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691788767; x=1692393567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQpId7/xrpQlCKdhMKKnoX3RMnX16k+BrWUnYQTLzJw=;
        b=uUhkhnABtd0vfm57xK91U6UrehuBrImq4ARCgRvPK1VtDSGUxYTRLzLYMyreywR/Kr
         pCh/hQNvbfipv3mKDUJiaDsvo3bwZHFN5pu4ewh1VNo2Z/YrRCpdGvV5/JbfP0XjLK+B
         hTVgKZVq/gLBU3Sv0VHPO3+NtyQwNyy0GsvpvmIn7HzktHQJ4p/loFJ6jZ1a7MeasZLO
         z+0b9LD/Vtn6c2AfA6PhS9bB+qCxbkjRGZAe9BqNRDmWmfjmbhOXDqaG1N7a9Sg73kQ8
         PjsMTbRI3O7gBIRoVBbMfcwoYhB5aMR3pkUBYiAd7Ty4FOnlgscisSZ8zdUoBaUC+HXL
         SQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691788768; x=1692393568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQpId7/xrpQlCKdhMKKnoX3RMnX16k+BrWUnYQTLzJw=;
        b=AFvlBTyzN1z8gJ0kdlE0KzZzlSApEXpYKntRZTIww1/eG5U+6tgw9wQWAGkuu0wS2o
         RtZGFm7iYainr/n6gWJ0glo1kVgZ4tUP6GrJ8m4i14iJ6kuwxlp5GDL9D8R5ZEMrS7jM
         lFWgU0HroBkAL8Y55lG0948W5kdg/fMwQDcv7DwHGxNDYjTXAu8/dfx2H5SSGEhfXlrT
         YWRJfFT2U8ARrqtj7bmldUO3THKS880iKZMtAfRvxMnT/IBbamlXIAIuUjaBo+grfBw4
         BqdKD8tHkxL0daEtJiVkPO3PpvXDOOCT4M+jq22uE/mdm4KGsuBxPRhDGAGn6MxeVgx9
         MQpw==
X-Gm-Message-State: AOJu0YyYcPwwOF1NLZy+cB5yMtrm4FetYPdS8enmaOCLFcn+UluW+AmU
        LNIaSvM9NtcbcMzqW2UhP8EMm9MfQlmKqTlDXQ==
X-Google-Smtp-Source: AGHT+IGk1uf0kGWR1cjzqQP7AfmkJkzJDJmfyuKmDjGLWg1w0/gQx1YVAdwd/TAqEYcQ0G5w7a5EsM3oLCtnyG9dyA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:9567:b0:1c0:eac2:979c with
 SMTP id v39-20020a056870956700b001c0eac2979cmr65726oal.3.1691788767834; Fri,
 11 Aug 2023 14:19:27 -0700 (PDT)
Date:   Fri, 11 Aug 2023 21:19:20 +0000
In-Reply-To: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com>
Mime-Version: 1.0
References: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691788764; l=2495;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=OU2B7x8FNL1q157scUIMm8YAPWH0YRRYFkNwfqAAlYc=; b=t8i/MBrRZYTBCyZG+n62sm6BtF8rrxy6c3AXOklnMgD6g/y9j3NSShRjs0U3zb6DojFQXi7R6
 t71tXOebyWwC4lP3GudY7BB2KoS2VPhOxRDI6pEsirAJWNJJ7/C+0lD
X-Mailer: b4 0.12.3
Message-ID: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-2-301052a5663e@google.com>
Subject: [PATCH RFC 2/3] powerpc/ps3: refactor strncpy usage attempt 2
From:   Justin Stitt <justinstitt@google.com>
To:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
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

This approach tries to use `make_field` inside of `make_first_field`.
This comes with some weird implementation as to get the same result we
need to first subtract `index` from the `make_field` result whilst being
careful with order of operations. We then have to add index back.

The behavior should be the same but would love some comments on this.

Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note: I swapped the position of the two methods so as to not have to
forward declare `make_field`. This results in a weird diff here.
---
 arch/powerpc/platforms/ps3/repository.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index 1abe33fbe529..6b731a5d4adc 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -63,36 +63,33 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
 }
 
 /**
- * make_first_field - Make the first field of a repository node name.
- * @text: Text portion of the field.
+ * make_field - Make subsequent fields of a repository node name.
+ * @text: Text portion of the field.  Use "" for 'don't care'.
  * @index: Numeric index portion of the field.  Use zero for 'don't care'.
  *
- * This routine sets the vendor id to zero (non-vendor specific).
  * Returns field value.
  */
 
-static u64 make_first_field(const char *text, u64 index)
+static u64 make_field(const char *text, u64 index)
 {
 	u64 n = 0;
 
 	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
-	return PS3_VENDOR_ID_NONE + (n >> 32) + index;
+	return n + index;
 }
 
 /**
- * make_field - Make subsequent fields of a repository node name.
- * @text: Text portion of the field.  Use "" for 'don't care'.
+ * make_first_field - Make the first field of a repository node name.
+ * @text: Text portion of the field.
  * @index: Numeric index portion of the field.  Use zero for 'don't care'.
  *
+ * This routine sets the vendor id to zero (non-vendor specific).
  * Returns field value.
  */
 
-static u64 make_field(const char *text, u64 index)
+static u64 make_first_field(const char *text, u64 index)
 {
-	u64 n = 0;
-
-	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
-	return n + index;
+	return PS3_VENDOR_ID_NONE + ((make_field(text, index) - index) >> 32) + index;
 }
 
 /**

-- 
2.41.0.640.ga95def55d0-goog

