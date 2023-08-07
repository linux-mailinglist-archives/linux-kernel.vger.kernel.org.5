Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021EF772096
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjHGLQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjHGLQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:16:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750E92D42;
        Mon,  7 Aug 2023 04:14:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686efb9ee3cso4205288b3a.3;
        Mon, 07 Aug 2023 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691406802; x=1692011602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sshxUFVbctBDVN/rzug39I/npfxRGzCIXVTdlhheim4=;
        b=QK/zubLdZZoZP6gIBKll8Bu1c0ZW4s26X+pmcAjKk7aKp87JjNJHvan60ekq0fxM/3
         8rBlrw8ymXTrQV3kypJvf68/gadP19Hrit8zQkGUAAjmFthnxjuOyJFGKBpAVWMlKZ9w
         4S2G0kR+nQZ3r8S02PZxb/XTI9Y6cJCI4Z+CQQbxCDMsv50iWJJFox/e+rmNIdkF13mR
         gmUy1RW183vTiNh22GiC7aYlK0GqGlAi9qGfbWH3Bw8oJtyLo7c63ZaR6fY4poBgcMgO
         jwUucRyITbL8BdyJERcdrPWZLe6xGBl2p7azg9I1nXElJjZIHNA6AE95YqPg5Yfz5nyY
         NzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406802; x=1692011602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sshxUFVbctBDVN/rzug39I/npfxRGzCIXVTdlhheim4=;
        b=ioUy6GG8JidZg6CFTWeXyWZRZYAronksLn9G/nmA5Asp2YshDLHde/LxJQVOau4S0g
         kfyJy/KZHS7f6/72XfWiBmlSpt5LduU1wdFy//ff96XwQWIs7WtLRC4E2dRzoQuJU1Xg
         tIFJpYD5Z8S359VlApwLom4mN92+S4dkUnGLP35SxiRUMxouVMmfKt1TbH4Yfe8QDv/r
         1NtM/HTn4OMQz9Gl2TBbH1IJnAfpQ7ynTH11KFlSMhkTjhE2wP8CWkZtSD1Zf44eM6+R
         fuOCqg7pBz8FUI5B5RuNzelzs0e1UU9/DkatY/IzLpsqqCIq/45fG2zeycrJwSv1ufnU
         n+Fg==
X-Gm-Message-State: AOJu0YwjJ3YtO2sr5jOB/i6hOAC/+aR9zyZN5w7i8Bws5HYuJsVanrNw
        n6YUmW/Mhkawv71pc5CkM3I=
X-Google-Smtp-Source: AGHT+IEsERBFZP3UIISrmaZikUwTc5ArhwjO+MU9vrxHAAF3rZinitGAg6jh86hMdNOyUtjcAA9m/w==
X-Received: by 2002:a05:6a00:1488:b0:687:6184:def4 with SMTP id v8-20020a056a00148800b006876184def4mr11462825pfu.21.1691406802248;
        Mon, 07 Aug 2023 04:13:22 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id 4-20020aa79144000000b00660d80087a8sm5939173pfi.187.2023.08.07.04.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:13:21 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v8 1/8] sign-file: use getopt_long_only for parsing input args
Date:   Mon,  7 Aug 2023 16:43:09 +0530
Message-ID: <20230807111316.315836-2-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807111316.315836-1-yesshedi@gmail.com>
References: <20230807111316.315836-1-yesshedi@gmail.com>
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

- getopt_long_only gives an option to use long names for options, so
  using it here to make the app usage easier.

- Use more easy to remember command line argument names

- Introduce cmd_opts structure to ease the handling of command line args

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 97 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 19 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 598ef5465f82..94228865b6cc 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -213,15 +213,77 @@ static X509 *read_x509(const char *x509_name)
 	return x509;
 }
 
+struct cmd_opts {
+	char *raw_sig_name;
+	bool save_sig;
+	bool replace_orig;
+	bool raw_sig;
+	bool sign_only;
+#ifndef USE_PKCS7
+	unsigned int use_keyid;
+#endif
+};
+
+static void parse_args(int argc, char **argv, struct cmd_opts *opts)
+{
+	struct option cmd_options[] = {
+		{"rawsig",	required_argument,  0,	's'},
+		{"savesig",	no_argument,	    0,	'p'},
+		{"signonly",	no_argument,	    0,	'd'},
+#ifndef USE_PKCS7
+		{"usekeyid",	no_argument,	    0,	'k'},
+#endif
+		{0, 0, 0, 0}
+	};
+
+	int opt;
+	int opt_index = 0;
+
+	do {
+#ifndef USE_PKCS7
+		opt = getopt_long_only(argc, argv, "pds:",
+				cmd_options, &opt_index);
+#else
+		opt = getopt_long_only(argc, argv, "pdks:",
+				cmd_options, &opt_index);
+#endif
+		switch (opt) {
+		case 's':
+			opts->raw_sig = true;
+			opts->raw_sig_name = optarg;
+			break;
+
+		case 'p':
+			opts->save_sig = true;
+			break;
+
+		case 'd':
+			opts->sign_only = true;
+			opts->save_sig = true;
+			break;
+
+#ifndef USE_PKCS7
+		case 'k':
+			opts->use_keyid = CMS_USE_KEYID;
+			break;
+#endif
+
+		case -1:
+			break;
+
+		default:
+			format();
+			break;
+		}
+	} while (opt != -1);
+}
+
 int main(int argc, char **argv)
 {
 	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
 	char *hash_algo = NULL;
-	char *private_key_name = NULL, *raw_sig_name = NULL;
+	char *private_key_name = NULL;
 	char *x509_name, *module_name, *dest_name;
-	bool save_sig = false, replace_orig;
-	bool sign_only = false;
-	bool raw_sig = false;
 	unsigned char buf[4096];
 	unsigned long module_size, sig_size;
 	unsigned int use_signed_attrs;
@@ -229,13 +291,14 @@ int main(int argc, char **argv)
 	EVP_PKEY *private_key;
 #ifndef USE_PKCS7
 	CMS_ContentInfo *cms = NULL;
-	unsigned int use_keyid = 0;
 #else
 	PKCS7 *pkcs7 = NULL;
 #endif
 	X509 *x509;
 	BIO *bd, *bm;
-	int opt, n;
+	int n;
+	struct cmd_opts opts = {};
+
 	OpenSSL_add_all_algorithms();
 	ERR_load_crypto_strings();
 	ERR_clear_error();
@@ -247,23 +310,19 @@ int main(int argc, char **argv)
 #else
 	use_signed_attrs = PKCS7_NOATTR;
 #endif
+	parse_args(argc, argv, &opts);
+	argc -= optind;
+	argv += optind;
 
-	do {
-		opt = getopt(argc, argv, "sdpk");
-		switch (opt) {
-		case 's': raw_sig = true; break;
-		case 'p': save_sig = true; break;
-		case 'd': sign_only = true; save_sig = true; break;
+	const char *raw_sig_name = opts.raw_sig_name;
+	const bool save_sig = opts.save_sig;
+	const bool raw_sig = opts.raw_sig;
+	const bool sign_only = opts.sign_only;
+	bool replace_orig = opts.replace_orig;
 #ifndef USE_PKCS7
-		case 'k': use_keyid = CMS_USE_KEYID; break;
+	const unsigned int use_keyid = opts.use_keyid;
 #endif
-		case -1: break;
-		default: format();
-		}
-	} while (opt != -1);
 
-	argc -= optind;
-	argv += optind;
 	if (argc < 4 || argc > 5)
 		format();
 
-- 
2.41.0

