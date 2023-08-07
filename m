Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1310877207C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjHGLPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjHGLPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:15:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4369B210B;
        Mon,  7 Aug 2023 04:14:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68706d67ed9so2973724b3a.2;
        Mon, 07 Aug 2023 04:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691406807; x=1692011607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+Vc8KF36dvoTsxw7COLho0+o4ramvtbWDluJ7MN6HU=;
        b=l51fYZkxHl9K4Y59a0c3A7vbtiezSQTvBodFreFQDQytaS8OMg9T7+rtzVwhGCjwDS
         hE1S4pXEJ1F8WN8J70p0U23SdwVTUDMCcSTiKOuQRTz6bE5q8L4LNRfQ3RcyY6zlwn92
         2Fn3gKbSmmFdVycAOhZeCHhiJUE1Y0cWhqQP0gqmavvl5/6GxZNOEAdmfe9M034oqsQF
         1oB+ngtHFYDGpqm7aUeApdVHHhxSISm1qqtdV4ugQ6N/s1LBS2j+cFOJtJX552OC+EdT
         d88Wc5eO76VOE2fR9SbnS/uSvjVt1YUCQTPJGVn5erGMAu6cdf/bR0N3q/WkKnil5JqL
         h3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406807; x=1692011607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+Vc8KF36dvoTsxw7COLho0+o4ramvtbWDluJ7MN6HU=;
        b=QO0yT03n9YB05K3Y+SdBkGDo6f8/RAQI1AcEP8Y68tTOvqvw0SUGCCc2DmdVJlWycI
         HaH6ujM2SvjIekPqln3S5e1I4juXMYgbCWSJjQclxyueMholpiyyTAVBsmxc0a69TURA
         LAMpQ4WvLBwssYLq9LNU2ysed9QOKpqf6B96b0yW5fXILyvHvQRTeL7u5uivZDPLTCrY
         O2fC6gqVuhWLYbatQXK3QalKcczuu3+9T7pAT/NrK4ReLfzHntuo2EcIP0ScAD+mYrrF
         OUxYaQ32VObEzHYRc9e35EesMIqhfe4XvkugoAICkiVj/L9ncQBvivQqzA61bhP4Ds04
         KHTQ==
X-Gm-Message-State: AOJu0Yyhazo/5LV/Rgt8loodwdH7DFYxPeg0aKP+ZhsuA5xEZe2LNrB1
        zZLLiNUyok2LaAPwZdnXkSQ=
X-Google-Smtp-Source: AGHT+IF6SbqSkfp04TcijVoF3wideRn7HDJUeWbvyxegcyJnmXCe3x3MtMnGygLXfch2DM6DKzHF2w==
X-Received: by 2002:a05:6a20:734f:b0:13d:ea25:9642 with SMTP id v15-20020a056a20734f00b0013dea259642mr9987547pzc.6.1691406806914;
        Mon, 07 Aug 2023 04:13:26 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id 4-20020aa79144000000b00660d80087a8sm5939173pfi.187.2023.08.07.04.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:13:26 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v8 4/8] sign-file: add support to sign modules in bulk
Date:   Mon,  7 Aug 2023 16:43:12 +0530
Message-ID: <20230807111316.315836-5-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807111316.315836-1-yesshedi@gmail.com>
References: <20230807111316.315836-1-yesshedi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

