Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B767FC9D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbjK1WqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjK1WqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:46:18 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0287019A6;
        Tue, 28 Nov 2023 14:46:25 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67a14f504f8so21906676d6.0;
        Tue, 28 Nov 2023 14:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701211584; x=1701816384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhpsd/CJqEzY2wViCgUIbvNNXzGivZKIEmu3PQkzhVE=;
        b=XsO10W1qy+mn6Jn2XJIxwFQda9GAd1l86NcOKW0FIS4X30PWcnafgnYBcgWvDd8vmV
         cEHV4GVANUDTvwghgrKVKMbsa3l0Bsb6sr711dGbC3yZsdTxnzGDVIBZbAxd71zsFU0X
         kVlkiAVgQ8+2Jni9zkyJp5udj0ibaduBnV3vIRWGiAJlYYaai8Ej1nk6BUd9b/TrPzz2
         q2XwUHj3SxV/WMRI/z+wpJvULjICgspCVH270Qv8nqsk5pIOtmtwSSwA+da3n+qJXEjY
         q8f3JArkkGXtN7ZW7Nm5Y88C77gCGfH4ZD92+hXBrFwJcegLmh0TFv2N0WoEvJbdwpHa
         HIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701211584; x=1701816384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhpsd/CJqEzY2wViCgUIbvNNXzGivZKIEmu3PQkzhVE=;
        b=G0sgdxHFCX8gkh2DuOsQv1cGeUr01l/hVnzhpYQAmRubCnnr6kic8u84N8PX9x97cS
         aBVP2CNo1/9E0ppdQrl3OKPioB3R90Rx74EI7hhjAoJ62HtBg6SoXQ5rHqmPEUFm6Gfg
         N14YcYWjRQYCWNUVpypCXwZjhmDvHB0yRifg6G0EbAQXlTTrCh03YGoH6J82+ZqvjbMh
         wTbNbY21TMp6JKzf26yA1jgB1GjcbbN2oOrDIa9G9FhHypbsCbgnlLHSV0vosYw8FH4f
         MPQY5EL0zZfNKuKQLuaAbX/8Nkz3XVd+WjvsEMgJfSsPX5+23CwBX4U3Kubc+CH82m9e
         HB3Q==
X-Gm-Message-State: AOJu0Yyea1pU+EMtvopn3YiC/puTfF5lCYX9TJg23VeBYiO4NBMAxBPh
        ealeoMRQmFVZtKVFqGT0Ha8=
X-Google-Smtp-Source: AGHT+IE6pRwhOTqRhINFN2eazXP7q4ErDCKPBsRwJZFUkJDiwFErGp8qdvqAseNy6DBU+RYnFDa6hQ==
X-Received: by 2002:a05:6214:806:b0:67a:590a:18f6 with SMTP id df6-20020a056214080600b0067a590a18f6mr3626618qvb.51.1701211584122;
        Tue, 28 Nov 2023 14:46:24 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id em15-20020ad44f8f000000b0067a543e6379sm1336565qvb.75.2023.11.28.14.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:46:23 -0800 (PST)
From:   angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To:     skhan@linuxfoundation.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        angquan yu <angquan21@gmail.com>
Subject: [PATCH] Fix Format String Warnings in lam.c
Date:   Tue, 28 Nov 2023 16:46:07 -0600
Message-Id: <20231128224607.71334-1-angquan21@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: angquan yu <angquan21@gmail.com>

This commit addresses compiler warnings in lam.c related to the usage
of non-literal format strings without format arguments in the
'run_test' function.

Warnings fixed:
- Resolved warnings indicating that 'ksft_test_result_skip' and
'ksft_test_result' were called with 't->msg' as a format string without
accompanying format arguments.

Changes made:
- Modified the calls to 'ksft_test_result_skip' and 'ksft_test_result'
to explicitly include a format specifier ("%s") for 't->msg'.
- This ensures that the string is safely treated as a format argument,
adhering to safer coding practices and resolving the compiler warnings.

Signed-off-by: angquan yu <angquan21@gmail.com>
---
 tools/testing/selftests/x86/lam.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 8f9b06d9c..215b8150b 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -817,7 +817,7 @@ static void run_test(struct testcases *test, int count)
 
 		/* return 3 is not support LA57, the case should be skipped */
 		if (ret == 3) {
-			ksft_test_result_skip(t->msg);
+			ksft_test_result_skip("%s", t->msg);
 			continue;
 		}
 
@@ -826,7 +826,7 @@ static void run_test(struct testcases *test, int count)
 		else
 			ret = !(t->expected);
 
-		ksft_test_result(ret, t->msg);
+		ksft_test_result(ret, "%s", t->msg);
 	}
 }
 
-- 
2.39.2

