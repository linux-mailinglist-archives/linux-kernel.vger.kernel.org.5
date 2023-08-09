Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93359776658
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjHIRW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjHIRWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:22:23 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7301FF7;
        Wed,  9 Aug 2023 10:22:23 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a5ad6087a1so11124b6e.2;
        Wed, 09 Aug 2023 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691601742; x=1692206542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+Vc8KF36dvoTsxw7COLho0+o4ramvtbWDluJ7MN6HU=;
        b=J0tuWk2R6rxihVOM/hdSNrEOmZo2mREj82lxIZvxHqJqqkiKqQNt+B3/PPypKPakE3
         Uc8S7JM2JfiH818Gft/k/QNDL/1z2hEKv9b5zXeuOifkWiubM8DAlM+FGmY4kZTzaKNe
         ebZBoyW1SYyrmVyeoxTkDV+vP889FCCx9eNzFtF9NaXTYmmsLnkqbsBTQqfSqsBTDWuF
         fba+l+tZssOxt3fa5acSbwwDbsuQbi+GZRdsSz4W8HFLZIhA4MHCsGOM6CNFgyJ7UoOz
         FZ6nLoH92OCD3fvoWPa8jvI8zNcLdRQB2UPkw6jXmx6I87ah0xMbxa9dV1b9dZDEipXA
         WbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691601742; x=1692206542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+Vc8KF36dvoTsxw7COLho0+o4ramvtbWDluJ7MN6HU=;
        b=lET/Occv49XNihAO8xJlY2NrpUlIQnLJ2Rzv36dBYYVo2Nu7264M/0SiJw2NAl8hZj
         gFWtAQfoUC5//ixZk4H+V3IFjPaOIRC2NI/q6dk64hMcDyKfPYvmX3gt+bSgAY2LByvL
         y5d0gtxx+lK9JNk41Er/iwVJtkmVmJOkj9sdN0TuuOKdf2a7Rjh6F56rsCkcRS29oHg0
         C2AVJaiUvWfffDJGDf/MteJrHllyqbWBXPVFl3bsNZ6M9Ot6bAQvJc3FgCFzRhsLqNdx
         3WP7dM+GDMq6BxczbUOlFdAazGlQqy90U9N45tadz68ZqPwam2znK1CuCycsrmoadMZ/
         8dWA==
X-Gm-Message-State: AOJu0YxkB4cg7OWu1EmCia2s0KcfkSrxHgM4x6M/93x/ZwQM4ItP+Vkl
        nSn3VmsMQ/eA3PSRj2yhp/A=
X-Google-Smtp-Source: AGHT+IE2KViwY+jM5mLKKZRwDXlK+iDfaAVU2o9gO2jHBaCH/jHJUN0NRgAOaNytgwSimKjzUufwvw==
X-Received: by 2002:a05:6808:f16:b0:3a3:fa64:bb8d with SMTP id m22-20020a0568080f1600b003a3fa64bb8dmr4271375oiw.10.1691601742310;
        Wed, 09 Aug 2023 10:22:22 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id a1-20020a17090abe0100b00268040bbc6asm1739080pjs.4.2023.08.09.10.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:22:22 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v9 4/7] sign-file: add support to sign modules in bulk
Date:   Wed,  9 Aug 2023 22:52:07 +0530
Message-ID: <20230809172211.343677-5-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809172211.343677-1-yesshedi@gmail.com>
References: <20230809172211.343677-1-yesshedi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the existing system, we need to invoke sign-file binary for every
module we want to sign. This patch adds support to give modules list
in bulk and it will sign them all one by one.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 64d5e00f08e2..0a275256ca16 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -224,6 +224,7 @@ struct cmd_opts {
 	bool replace_orig;
 	bool raw_sig;
 	bool sign_only;
+	bool bulk_sign;
 #ifndef USE_PKCS7
 	unsigned int use_keyid;
 #endif
@@ -252,10 +253,10 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 
 	do {
 #ifndef USE_PKCS7
-		opt = getopt_long_only(argc, argv, "hpds:i:a:x:t:r:",
+		opt = getopt_long_only(argc, argv, "hpdbs:i:a:x:t:r:",
 				cmd_options, &opt_index);
 #else
-		opt = getopt_long_only(argc, argv, "hpdks:i:a:x:t:r:",
+		opt = getopt_long_only(argc, argv, "hpdkbs:i:a:x:t:r:",
 				cmd_options, &opt_index);
 #endif
 		switch (opt) {
@@ -303,6 +304,10 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 			opts->replace_orig = true;
 			break;
 
+		case 'b':
+			opts->bulk_sign = true;
+			break;
+
 		case -1:
 			break;
 
@@ -460,26 +465,34 @@ static int sign_single_file(struct cmd_opts *opts)
 
 int main(int argc, char **argv)
 {
+	int i;
 	struct cmd_opts opts = {};
 
 	parse_args(argc, argv, &opts);
 	argc -= optind;
 	argv += optind;
 
-	if (!argv[0] || argc != 1)
-		format();
-
-	if (opts.dest_name && strcmp(argv[0], opts.dest_name)) {
-		opts.replace_orig = false;
-	} else {
-		ERR(asprintf(&opts.dest_name, "%s.~signed~", opts.module_name) < 0,
-				"asprintf");
-		opts.replace_orig = true;
-	}
-
 	OpenSSL_add_all_algorithms();
 	ERR_load_crypto_strings();
 	ERR_clear_error();
 
-	return sign_single_file(&opts);
+	for (i = 0; i < argc; ++i) {
+		opts.module_name = argv[i];
+
+		if (!opts.bulk_sign && opts.dest_name && strcmp(argv[i], opts.dest_name)) {
+			opts.replace_orig = false;
+		} else {
+			ERR(asprintf(&opts.dest_name, "%s.~signed~", opts.module_name) < 0,
+				     "asprintf");
+			if (!opts.replace_orig)
+				opts.replace_orig = true;
+		}
+
+		if (sign_single_file(&opts)) {
+			fprintf(stderr, "Failed to sign: %s module\n", opts.module_name);
+			return -1;
+		}
+	}
+
+	return 0;
 }
-- 
2.41.0

