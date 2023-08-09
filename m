Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACEB77665A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjHIRWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjHIRWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:22:20 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC91ADA;
        Wed,  9 Aug 2023 10:22:19 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1bb7297c505so16724fac.1;
        Wed, 09 Aug 2023 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691601739; x=1692206539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq9xqM+h7oBuIV562NdPhowrLOOfWiFKQyz9j1DoQbE=;
        b=aUj2Gobe5kqvBtqWChMciBQMMEoNr+G1iQCVDZS3A3YOreCXkqc9e4wo1n6MCCXAuj
         hxShXPvUCno9Lne0jm9KkIul+YfvyM5HfH9SVp74J1SQaVQkaWicYfKQZ8wkgl9ghzZB
         yWJJVEM5+j+mg22IT6Ko3YJq1xSvn3XuZKzXawTRdXH56SRTz0y3Js6I1eHp42h64IlJ
         TgweuIxE1kPF4/O+tyE9OIUEzPPaxtV1X7u0TzLL8/zoHGVgUV9FrS5OjduBhHyh13zT
         qGRJ+nRhcQGeldGqoiYROaRrQxBX78R1x1PkxAOCIKBWvn/MKuiHrAiaotIOrXJehlcg
         QUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691601739; x=1692206539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hq9xqM+h7oBuIV562NdPhowrLOOfWiFKQyz9j1DoQbE=;
        b=kDk3dy+SMNpZsel5ED7GftY1teW47uBWamCdYf5AMFCVwLUU0Ejvj0PiFo3tQ2GT0v
         wEwrci9JNMKufdLdE8dSfjcFGp7ePViHtyDkIZYJpM393vUddJ6VMjbACY4Y/j0vdJai
         3PybjwXugIdj8XEp+7VJu/UdpkpVPR75M4V8HRmOd0+Z/3t7UWYL6dorjT3qePX+YwfR
         NqojBMOuXBTUQ279u8M878nftulMRNwsk+BuNcD75FQLyaIg78ylBEQbCTYs4Qy2eBWi
         DNolmMBOzO4NfhUNB6PIWkkc45AiRy8oLg15wbRg3Q+V7o8ejfm7WPGTdnpj1s861Ha+
         O0Ag==
X-Gm-Message-State: AOJu0YxO/F4gLXpG5zmimI9wSSXQQlMOpiY6IZr0KOkGU18fLBDO/4Fv
        BklcezbFHjwPvhpsejd7nDg=
X-Google-Smtp-Source: AGHT+IHPdWho9K41zWMrOdMQFSSWihQXJUronm52XKlW5lmVrfo1XesvLrkP8A82kTgTgdbEZ1lz3g==
X-Received: by 2002:a05:6808:f16:b0:3a7:215c:e34 with SMTP id m22-20020a0568080f1600b003a7215c0e34mr4224010oiw.15.1691601739062;
        Wed, 09 Aug 2023 10:22:19 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id a1-20020a17090abe0100b00268040bbc6asm1739080pjs.4.2023.08.09.10.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:22:18 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v9 2/7] sign-file: inntroduce few new flags to make argument processing easy.
Date:   Wed,  9 Aug 2023 22:52:05 +0530
Message-ID: <20230809172211.343677-3-yesshedi@gmail.com>
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

- Add some more options like help, x509, hashalgo to command line args
- This makes it easy to handle and use command line args wherever needed

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/Makefile.modinst |  4 ++-
 scripts/sign-file.c      | 63 ++++++++++++++++++++++++++++------------
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index ab0c5bd1a60f..e94ac9afe17a 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -72,7 +72,9 @@ else
 sig-key := $(CONFIG_MODULE_SIG_KEY)
 endif
 quiet_cmd_sign = SIGN    $@
-      cmd_sign = scripts/sign-file $(CONFIG_MODULE_SIG_HASH) "$(sig-key)" certs/signing_key.x509 $@ \
+      cmd_sign = scripts/sign-file -a "$(CONFIG_MODULE_SIG_HASH)" \
+				   -i "$(sig-key)" \
+				   -x certs/signing_key.x509 $@ \
                  $(if $(KBUILD_EXTMOD),|| true)
 else
 quiet_cmd_sign :=
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 94228865b6cc..b0f340ea629b 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -215,6 +215,11 @@ static X509 *read_x509(const char *x509_name)
 
 struct cmd_opts {
 	char *raw_sig_name;
+	char *hash_algo;
+	char *dest_name;
+	char *private_key_name;
+	char *x509_name;
+	char *module_name;
 	bool save_sig;
 	bool replace_orig;
 	bool raw_sig;
@@ -233,6 +238,12 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 #ifndef USE_PKCS7
 		{"usekeyid",	no_argument,	    0,	'k'},
 #endif
+		{"help",	no_argument,	    0,	'h'},
+		{"privkey",	required_argument,  0,	'i'},
+		{"hashalgo",	required_argument,  0,	'a'},
+		{"x509",	required_argument,  0,	'x'},
+		{"dest",	required_argument,  0,	'd'},
+		{"replaceorig",	required_argument,  0,	'r'},
 		{0, 0, 0, 0}
 	};
 
@@ -241,10 +252,10 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 
 	do {
 #ifndef USE_PKCS7
-		opt = getopt_long_only(argc, argv, "pds:",
+		opt = getopt_long_only(argc, argv, "hpds:i:a:x:t:r:",
 				cmd_options, &opt_index);
 #else
-		opt = getopt_long_only(argc, argv, "pdks:",
+		opt = getopt_long_only(argc, argv, "hpdks:i:a:x:t:r:",
 				cmd_options, &opt_index);
 #endif
 		switch (opt) {
@@ -268,6 +279,30 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 			break;
 #endif
 
+		case 'h':
+			format();
+			break;
+
+		case 'i':
+			opts->private_key_name = optarg;
+			break;
+
+		case 'a':
+			opts->hash_algo = optarg;
+			break;
+
+		case 'x':
+			opts->x509_name = optarg;
+			break;
+
+		case 't':
+			opts->dest_name = optarg;
+			break;
+
+		case 'r':
+			opts->replace_orig = true;
+			break;
+
 		case -1:
 			break;
 
@@ -281,9 +316,6 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 int main(int argc, char **argv)
 {
 	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
-	char *hash_algo = NULL;
-	char *private_key_name = NULL;
-	char *x509_name, *module_name, *dest_name;
 	unsigned char buf[4096];
 	unsigned long module_size, sig_size;
 	unsigned int use_signed_attrs;
@@ -315,32 +347,27 @@ int main(int argc, char **argv)
 	argv += optind;
 
 	const char *raw_sig_name = opts.raw_sig_name;
+	const char *hash_algo = opts.hash_algo;
+	const char *private_key_name = opts.private_key_name;
+	const char *x509_name = opts.x509_name;
+	const char *module_name = opts.module_name;
 	const bool save_sig = opts.save_sig;
 	const bool raw_sig = opts.raw_sig;
 	const bool sign_only = opts.sign_only;
 	bool replace_orig = opts.replace_orig;
+	char *dest_name = opts.dest_name;
 #ifndef USE_PKCS7
 	const unsigned int use_keyid = opts.use_keyid;
 #endif
 
-	if (argc < 4 || argc > 5)
+	if (!argv[0] || argc != 1)
 		format();
 
-	if (raw_sig) {
-		raw_sig_name = argv[0];
-		hash_algo = argv[1];
-	} else {
-		hash_algo = argv[0];
-		private_key_name = argv[1];
-	}
-	x509_name = argv[2];
-	module_name = argv[3];
-	if (argc == 5 && strcmp(argv[3], argv[4]) != 0) {
-		dest_name = argv[4];
+	if (dest_name && strcmp(argv[0], dest_name)) {
 		replace_orig = false;
 	} else {
 		ERR(asprintf(&dest_name, "%s.~signed~", module_name) < 0,
-		    "asprintf");
+				"asprintf");
 		replace_orig = true;
 	}
 
-- 
2.41.0

