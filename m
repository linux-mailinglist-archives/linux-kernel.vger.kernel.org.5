Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8373E77665B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjHIRW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjHIRWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:22:22 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3F9210D;
        Wed,  9 Aug 2023 10:22:21 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-56546b45f30so76924a12.3;
        Wed, 09 Aug 2023 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691601740; x=1692206540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kc/8xA5HfVOnw4JeGBWUmNDme5l9D/HCBm9IBlclfHU=;
        b=ivFd19zaljOwkITr9dn0LOpN9NS6roc7rmCZqyLTvAuU4fLeGULHhhXzMNIw9RgoeG
         JtCNJfzFKLlWaaYDV9lu0nO7Z+BSVq7NgyJ9Rnp+xif5gpX4yWWu488o+ijttlJX+I+2
         7bpDbArqlSqA2j372QJhI+oPrQLU+Fw7dtm+BIdisSk1i6zbDK6EfKaYsOwivpq8UP3e
         LR5tLrXBieqzRPI6G81rVIk4Zn05Nlr4qXQR7oiFk3bZ3QKvJV/qCRqDDArXcaxv6Vtv
         HTfFeF+/2e5WO1DH7SzIdqKarLe6MeM3j1k1yM0PI6qJgu7pQ+XIXH03mGf5FTnosr48
         d+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691601740; x=1692206540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kc/8xA5HfVOnw4JeGBWUmNDme5l9D/HCBm9IBlclfHU=;
        b=AXQUIQRREGS6TJJxuKN9JP41kFXA8ovqBWRwQXJP7Py9qP30P8R56nKyZO/dLGXk2v
         2bIDJlGEqMH1YjWs8udEjIAc58DPZzqXLPQsn1YmeqG5LbKQVOx7V+TaIa42sBf/Q8J7
         S3TBXkE1Kb8MlG+MCkduU0xBjLCTpPisgJtPbUWzFuqNdnApIH51h2HiHPwGphotSxzS
         j7vigv7zIvp1XdTItynSELWZG6Mlm7A1hi+2tUObXex036/jTT0FQ7BQ5voQ//GkNQ51
         XWSI2cVRdBtRLfce3nyG8XMN9an8zqCgNdaNabkM+T8EWQ2Jhj0ks7z/15Ls0KsjUZ5y
         Z1yQ==
X-Gm-Message-State: AOJu0Yz+HaHOvyWgT6yVdBlZGbIpeg8MPc5w/4AanK6yHJd9RlogF9uu
        NlYvi12EvSThlXDf5wyxEDo=
X-Google-Smtp-Source: AGHT+IEH7lN6afl9zoESzAVbs4XVWCUBemSVs2noo5RMZxzVtOaavy/rJ/TB06c0hLILHfGFLruFrA==
X-Received: by 2002:a17:90a:d48:b0:268:14d7:bc34 with SMTP id 8-20020a17090a0d4800b0026814d7bc34mr2795092pju.20.1691601740685;
        Wed, 09 Aug 2023 10:22:20 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id a1-20020a17090abe0100b00268040bbc6asm1739080pjs.4.2023.08.09.10.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:22:20 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v9 3/7] sign-file: move file signing logic to its own function
Date:   Wed,  9 Aug 2023 22:52:06 +0530
Message-ID: <20230809172211.343677-4-yesshedi@gmail.com>
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

Keep the main function bare minimal and do less in main function.
This patch is pre-work for bulk module signing support.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 115 +++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 61 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index b0f340ea629b..64d5e00f08e2 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -313,10 +313,10 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 	} while (opt != -1);
 }
 
-int main(int argc, char **argv)
+static int sign_single_file(struct cmd_opts *opts)
 {
 	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
-	unsigned char buf[4096];
+	unsigned char buf[4096] = {};
 	unsigned long module_size, sig_size;
 	unsigned int use_signed_attrs;
 	const EVP_MD *digest_algo;
@@ -329,11 +329,6 @@ int main(int argc, char **argv)
 	X509 *x509;
 	BIO *bd, *bm;
 	int n;
-	struct cmd_opts opts = {};
-
-	OpenSSL_add_all_algorithms();
-	ERR_load_crypto_strings();
-	ERR_clear_error();
 
 	key_pass = getenv("KBUILD_SIGN_PIN");
 
@@ -342,34 +337,6 @@ int main(int argc, char **argv)
 #else
 	use_signed_attrs = PKCS7_NOATTR;
 #endif
-	parse_args(argc, argv, &opts);
-	argc -= optind;
-	argv += optind;
-
-	const char *raw_sig_name = opts.raw_sig_name;
-	const char *hash_algo = opts.hash_algo;
-	const char *private_key_name = opts.private_key_name;
-	const char *x509_name = opts.x509_name;
-	const char *module_name = opts.module_name;
-	const bool save_sig = opts.save_sig;
-	const bool raw_sig = opts.raw_sig;
-	const bool sign_only = opts.sign_only;
-	bool replace_orig = opts.replace_orig;
-	char *dest_name = opts.dest_name;
-#ifndef USE_PKCS7
-	const unsigned int use_keyid = opts.use_keyid;
-#endif
-
-	if (!argv[0] || argc != 1)
-		format();
-
-	if (dest_name && strcmp(argv[0], dest_name)) {
-		replace_orig = false;
-	} else {
-		ERR(asprintf(&dest_name, "%s.~signed~", module_name) < 0,
-				"asprintf");
-		replace_orig = true;
-	}
 
 #ifdef USE_PKCS7
 	if (strcmp(hash_algo, "sha1") != 0) {
@@ -380,20 +347,20 @@ int main(int argc, char **argv)
 #endif
 
 	/* Open the module file */
-	bm = BIO_new_file(module_name, "rb");
-	ERR(!bm, "%s", module_name);
+	bm = BIO_new_file(opts->module_name, "rb");
+	ERR(!bm, "%s", opts->module_name);
 
-	if (!raw_sig) {
+	if (!opts->raw_sig) {
 		/* Read the private key and the X.509 cert the PKCS#7 message
 		 * will point to.
 		 */
-		private_key = read_private_key(private_key_name);
-		x509 = read_x509(x509_name);
+		private_key = read_private_key(opts->private_key_name);
+		x509 = read_x509(opts->x509_name);
 
 		/* Digest the module data. */
 		OpenSSL_add_all_digests();
 		display_openssl_errors(__LINE__);
-		digest_algo = EVP_get_digestbyname(hash_algo);
+		digest_algo = EVP_get_digestbyname(opts->hash_algo);
 		ERR(!digest_algo, "EVP_get_digestbyname");
 
 #ifndef USE_PKCS7
@@ -405,7 +372,7 @@ int main(int argc, char **argv)
 
 		ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
 				     CMS_NOCERTS | CMS_BINARY |
-				     CMS_NOSMIMECAP | use_keyid |
+				     CMS_NOSMIMECAP | opts->use_keyid |
 				     use_signed_attrs),
 		    "CMS_add1_signer");
 		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
@@ -418,11 +385,11 @@ int main(int argc, char **argv)
 		ERR(!pkcs7, "PKCS7_sign");
 #endif
 
-		if (save_sig) {
+		if (opts->save_sig) {
 			char *sig_file_name;
 			BIO *b;
 
-			ERR(asprintf(&sig_file_name, "%s.p7s", module_name) < 0,
+			ERR(asprintf(&sig_file_name, "%s.p7s", opts->module_name) < 0,
 			    "asprintf");
 			b = BIO_new_file(sig_file_name, "wb");
 			ERR(!b, "%s", sig_file_name);
@@ -436,7 +403,7 @@ int main(int argc, char **argv)
 			BIO_free(b);
 		}
 
-		if (sign_only) {
+		if (opts->sign_only) {
 			BIO_free(bm);
 			return 0;
 		}
@@ -445,24 +412,24 @@ int main(int argc, char **argv)
 	/* Open the destination file now so that we can shovel the module data
 	 * across as we read it.
 	 */
-	bd = BIO_new_file(dest_name, "wb");
-	ERR(!bd, "%s", dest_name);
+	bd = BIO_new_file(opts->dest_name, "wb");
+	ERR(!bd, "%s", opts->dest_name);
 
 	/* Append the marker and the PKCS#7 message to the destination file */
-	ERR(BIO_reset(bm) < 0, "%s", module_name);
+	ERR(BIO_reset(bm) < 0, "%s", opts->module_name);
 	while ((n = BIO_read(bm, buf, sizeof(buf))),
 	       n > 0) {
-		ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
+		ERR(BIO_write(bd, buf, n) < 0, "%s", opts->dest_name);
 	}
 	BIO_free(bm);
-	ERR(n < 0, "%s", module_name);
+	ERR(n < 0, "%s", opts->module_name);
 	module_size = BIO_number_written(bd);
 
-	if (!raw_sig) {
+	if (!opts->raw_sig) {
 #ifndef USE_PKCS7
-		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
+		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", opts->dest_name);
 #else
-		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
+		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", opts->dest_name);
 #endif
 	} else {
 		BIO *b;
@@ -470,23 +437,49 @@ int main(int argc, char **argv)
 		/* Read the raw signature file and write the data to the
 		 * destination file
 		 */
-		b = BIO_new_file(raw_sig_name, "rb");
-		ERR(!b, "%s", raw_sig_name);
+		b = BIO_new_file(opts->raw_sig_name, "rb");
+		ERR(!b, "%s", opts->raw_sig_name);
 		while ((n = BIO_read(b, buf, sizeof(buf))), n > 0)
-			ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
+			ERR(BIO_write(bd, buf, n) < 0, "%s", opts->dest_name);
 		BIO_free(b);
 	}
 
 	sig_size = BIO_number_written(bd) - module_size;
 	sig_info.sig_len = htonl(sig_size);
-	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
-	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
+	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", opts->dest_name);
+	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", opts->dest_name);
 
-	ERR(BIO_free(bd) < 0, "%s", dest_name);
+	ERR(BIO_free(bd) < 0, "%s", opts->dest_name);
 
 	/* Finally, if we're signing in place, replace the original. */
-	if (replace_orig)
-		ERR(rename(dest_name, module_name) < 0, "%s", dest_name);
+	if (opts->replace_orig)
+		ERR(rename(opts->dest_name, opts->module_name) < 0, "%s", opts->dest_name);
 
 	return 0;
 }
+
+int main(int argc, char **argv)
+{
+	struct cmd_opts opts = {};
+
+	parse_args(argc, argv, &opts);
+	argc -= optind;
+	argv += optind;
+
+	if (!argv[0] || argc != 1)
+		format();
+
+	if (opts.dest_name && strcmp(argv[0], opts.dest_name)) {
+		opts.replace_orig = false;
+	} else {
+		ERR(asprintf(&opts.dest_name, "%s.~signed~", opts.module_name) < 0,
+				"asprintf");
+		opts.replace_orig = true;
+	}
+
+	OpenSSL_add_all_algorithms();
+	ERR_load_crypto_strings();
+	ERR_clear_error();
+
+	return sign_single_file(&opts);
+}
-- 
2.41.0

