Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BE27F0A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 02:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjKTBef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 20:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjKTBee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 20:34:34 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C439A128;
        Sun, 19 Nov 2023 17:34:29 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso4037773b3a.3;
        Sun, 19 Nov 2023 17:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700444069; x=1701048869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/mFMZVK/lhe/UOIVNdnOUMIpZBMESZjMufWJQUFv6zE=;
        b=nqmzkg2FCO3MgaIDAbDCtwwSEYvuQKvZrpqYk7Yn8whC1e+HxnPXZyuIYnd3xk12bs
         uJ5EnUfRXo2dZLmcmptCASGQaGT8SI48FzvATiEuGACaenP5SEEWX8FU5U7SZzRvVqRo
         7IW/nezeeMhqbz6tG0vEGlu05+cLNRPcRrr3AwYtZkpbeKC5taDSy0fKn/hsPXS+MuL3
         53FO6b4Lf/IgKKHOu/ZZLg/bkTUt6naL+tCYgiqrcaiRQQ8tSpH2La7GRn7qsxhn/GSh
         p60njlQ5hi5ZU1x8uEXWUCZhjAPf0Nl5Lh4PAbad9NyERZSLanFuohcZmPAdjjGhPRv0
         WSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700444069; x=1701048869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mFMZVK/lhe/UOIVNdnOUMIpZBMESZjMufWJQUFv6zE=;
        b=GTmHGgY7F/FJPoT2jAVC9tK61aiJF98rA1AMcPpY6RJgOpXVhiL5usfF+DZrLZxaM+
         MtLIP1A/FSFLGMv75NmQB+fX+ZLj5e7fVRJlzS2Xkfyv/UShVN8g9PfbH9Ogv64PII6u
         WqC/91NdIVMoW44cyd3EFej/v6FOfqrcc56fCr2ROgYd5xv30dsMlOdEIyBmgRXEEDCY
         pn5lS028YsLl3yxZRAozsFzaQ3qpxubUWos0JK+1cYDQkWPuwI2KbpQLqPQzQyxuUF0V
         gsXwlM2VyveJ1jcNUswsgwV0PPMUnCuT+V0kg/EVYNL3znrWE+RQycLBlnrD07Tzqqe8
         LH4Q==
X-Gm-Message-State: AOJu0YwUi36fsCuelOBrbztC/rnFhVF51nRiHGZ8H0lVM9wEwTXV9UYY
        R7n1Il70zY1vzNX6rvFg0Ko=
X-Google-Smtp-Source: AGHT+IH6wOaT7IvlhH1cBNzzv/52oOm+4m2RM3UOtVTx8c0nh8V0ATPjAEpdYDfbhRclNOLeH4LuFQ==
X-Received: by 2002:a05:6a20:e588:b0:187:9521:92a7 with SMTP id ng8-20020a056a20e58800b00187952192a7mr6715422pzb.18.1700444069166;
        Sun, 19 Nov 2023 17:34:29 -0800 (PST)
Received: from localhost.localdomain ([154.85.51.139])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78504000000b006cb884c0362sm1291865pfn.87.2023.11.19.17.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 17:34:28 -0800 (PST)
From:   Yusong Gao <a869920004@gmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, dwmw2@infradead.org,
        jarkko@kernel.org, zohar@linux.ibm.com,
        herbert@gondor.apana.org.au, lists@sapience.com,
        dimitri.ledkov@canonical.com
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [RESEND PATCH v2] sign-file: Fix incorrect return values check
Date:   Mon, 20 Nov 2023 01:33:59 +0000
Message-Id: <20231120013359.814059-1-a869920004@gmail.com>
X-Mailer: git-send-email 2.34.1
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

There are some wrong return values check in sign-file when call OpenSSL
API. For example the CMS_final() return 1 for success or 0 for failure.
The ERR() check cond is wrong because of the program only check the
return value is < 0 instead of <= 0.

Link:
https://www.openssl.org/docs/manmaster/man3/CMS_final.html
https://www.openssl.org/docs/manmaster/man3/i2d_CMS_bio_stream.html
https://www.openssl.org/docs/manmaster/man3/i2d_PKCS7_bio.html
https://www.openssl.org/docs/manmaster/man3/BIO_free.html

Signed-off-by: Yusong Gao <a869920004@gmail.com>
---
 scripts/sign-file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 598ef5465f82..dcebbcd6bebd 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -322,7 +322,7 @@ int main(int argc, char **argv)
 				     CMS_NOSMIMECAP | use_keyid |
 				     use_signed_attrs),
 		    "CMS_add1_signer");
-		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
+		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) <= 0,
 		    "CMS_final");
 
 #else
@@ -341,10 +341,10 @@ int main(int argc, char **argv)
 			b = BIO_new_file(sig_file_name, "wb");
 			ERR(!b, "%s", sig_file_name);
 #ifndef USE_PKCS7
-			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
+			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) <= 0,
 			    "%s", sig_file_name);
 #else
-			ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
+			ERR(i2d_PKCS7_bio(b, pkcs7) <= 0,
 			    "%s", sig_file_name);
 #endif
 			BIO_free(b);
@@ -374,9 +374,9 @@ int main(int argc, char **argv)
 
 	if (!raw_sig) {
 #ifndef USE_PKCS7
-		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
+		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) <= 0, "%s", dest_name);
 #else
-		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
+		ERR(i2d_PKCS7_bio(bd, pkcs7) <= 0, "%s", dest_name);
 #endif
 	} else {
 		BIO *b;
@@ -396,7 +396,7 @@ int main(int argc, char **argv)
 	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
 	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
 
-	ERR(BIO_free(bd) < 0, "%s", dest_name);
+	ERR(BIO_free(bd) <= 0, "%s", dest_name);
 
 	/* Finally, if we're signing in place, replace the original. */
 	if (replace_orig)
-- 
2.34.1

