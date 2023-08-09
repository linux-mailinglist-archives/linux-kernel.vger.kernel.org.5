Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DC0776656
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjHIRWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjHIRWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:22:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9331FEF;
        Wed,  9 Aug 2023 10:22:17 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26934bc3059so860542a91.1;
        Wed, 09 Aug 2023 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691601737; x=1692206537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sshxUFVbctBDVN/rzug39I/npfxRGzCIXVTdlhheim4=;
        b=Gm0jN3xybomHGt+nNqzWRqb/8iUt44Dh293c9zYb1NrtkeZMzYcZjLHSWCbYYMarkX
         OOHwWh6OE3IMZpgNO+arqQXrSA0mEkfs+q7yv81y06dlxJn4Y+lOzLpG/vy/SWxeJaO7
         Wc3kGCxYXlI/AJqiTpTPsBq/sce+2EpY5k9qj3KgXjX06x1iRzD8flSDFw0mxFdATxr1
         xOBx/7LpkVcXKq7cY+ZavwpXak8v84rX+F+8IlV9DYv2WmkseyV2Woi8pa12FNdBrYPV
         dg/dU5ZUaq3T699T37ImF33/JJKs4QczgwSWcYXUvpYE00v5h2Tu+4A5EYmtL2/g7R8r
         pxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691601737; x=1692206537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sshxUFVbctBDVN/rzug39I/npfxRGzCIXVTdlhheim4=;
        b=YgvAnjYKWCj58Z4pR168iuLvjhO21P/RMyT9Tu8p8vB1AMe2bHem+8IPG2Zl+DQjc9
         nAQuDw69U6uuOXZ/tpfMYDy5Wupjq28rDaT2+jUCJNuqlmZ84RLw6xWp2pzBM2JHWU11
         QBngYQtSYLWJ744HtMAPihbQC7vvYvIFirapJQK4Afs6onUftiyfRDOWLW6BWTl8dTzi
         1IdxerrsYZeH9WaaNP50k7rixX1GTvyWOgdRfqql/vzwX5gYAgrLgKepJfOOyKX+i0/a
         3TbfE9LFZyqPx/i7OO0Cf4JnUs4yZFbTqLXgYlo6V22XhOeFZqfStmUmeolrequzGpSV
         02hA==
X-Gm-Message-State: AOJu0Yypf8EnEFvfr+JSId+Lfkg1MpbgohOm4dg/n89s16ZyhoVi0dKG
        bVRiCKgNiCagLiu8j5EdgYcOE541N72bug==
X-Google-Smtp-Source: AGHT+IEFhOY2Y/SMcJU36puXtVrDmqBJOX0qkwOE68PlFodBd60+ge9fKE3PKiSs4QB5NUrqM+Ts/A==
X-Received: by 2002:a17:90a:bb16:b0:269:3757:54bb with SMTP id u22-20020a17090abb1600b00269375754bbmr100795pjr.11.1691601737381;
        Wed, 09 Aug 2023 10:22:17 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id a1-20020a17090abe0100b00268040bbc6asm1739080pjs.4.2023.08.09.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:22:17 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v9 1/7] sign-file: use getopt_long_only for parsing input args
Date:   Wed,  9 Aug 2023 22:52:04 +0530
Message-ID: <20230809172211.343677-2-yesshedi@gmail.com>
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

