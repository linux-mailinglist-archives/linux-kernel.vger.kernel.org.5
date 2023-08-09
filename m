Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1919377665E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjHIRWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjHIRWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:22:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5542123;
        Wed,  9 Aug 2023 10:22:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-267fc1d776eso8281a91.2;
        Wed, 09 Aug 2023 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691601744; x=1692206544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig5W7IVmZukpubm43ufz7bJD8pT18xKkNxAjQ1Pkr0Y=;
        b=QizvGZTBUXTBDgn8psZ99xw+SOkhsWL32LWp3Fu9kLUd1sEognyZa9cqDH9ED44Iyh
         IjkyWhEYosGuDsyYz3k9XnSXk9MOXTW+XiYXdaAa2UI7H1ByiMpWeNpv2D/rrDQEXCwE
         W5zOGC4U4x2G72i7sh2W1JXKu7T9mTmtX0TSSKYl2DtHm0iW4BuXW8Lprf8yHA1ijNDv
         g5zh3h0E8mO6Yx2nKR92SPDub8eieH7adRpRefv0TKf7z5sxRHlOm9GHMweSIg8LT+rS
         nl+Pmi4SROWjEPycOfUhcqVII2FJTvxYslGZRfN+pQzLFhrUKfYVJe35ERVyFu7w7TkB
         jejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691601744; x=1692206544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ig5W7IVmZukpubm43ufz7bJD8pT18xKkNxAjQ1Pkr0Y=;
        b=By0lx8lj//4w6boV5Pg/x1FIqm5jnqawpVSPDIGM2rtAfKEVmSmJVtkEALpqoxoaGc
         dpF0d7BUNq9G/1cvdFdqjAbKsnQyj1GnrpH0gQJeL6ZHf+AooSinxt+v1DbyhePVqb82
         mOjUPLegq0pKTBXqeHLm602RgxTBvsWCUocL8ETM3zg3wJXhcrDj6RrxR+ShjCva+6xT
         oexkwQma2Ekkn3QeW9IFav40p51lCPendIhSxJ/h4qmTgqclTI549m4MgZ0EA97ta8T1
         J01ArOTYHZ+0VRZW3Q34k9ta4Q9aFjA2ZIGtan5YLghQfJmLGKZahck/7SkZ9kla8YxA
         6OSg==
X-Gm-Message-State: AOJu0YyG4vVHDRLWWxlFFMgBl3DKvQTMx1FBbFCKyywihZEH2/A8UvOl
        nNYLVlx/0aDGxahelmBpw0U=
X-Google-Smtp-Source: AGHT+IHF2dM6O+3RGI/MhpbY8TsHJ9rMgshnsXOJNM6RF/bnsrz4PjFvxpkpEow4A/lJJULyvYL88A==
X-Received: by 2002:a17:90a:c7d2:b0:268:1e95:4e25 with SMTP id gf18-20020a17090ac7d200b002681e954e25mr2680890pjb.17.1691601743953;
        Wed, 09 Aug 2023 10:22:23 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id a1-20020a17090abe0100b00268040bbc6asm1739080pjs.4.2023.08.09.10.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:22:23 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v9 5/7] sign-file: improve help message
Date:   Wed,  9 Aug 2023 22:52:08 +0530
Message-ID: <20230809172211.343677-6-yesshedi@gmail.com>
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

Add a proper help message with examples on how to use this tool.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 48 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 0a275256ca16..d3abc5721a7e 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -74,12 +74,43 @@ struct module_signature {
 static char magic_number[] = "~Module signature appended~\n";
 
 static __attribute__((noreturn))
-void format(void)
+void print_usage(void)
 {
-	fprintf(stderr,
-		"Usage: scripts/sign-file [-dp] <hash algo> <key> <x509> <module> [<dest>]\n");
-	fprintf(stderr,
-		"       scripts/sign-file -s <raw sig> <hash algo> <x509> <module> [<dest>]\n");
+	fprintf(stderr, "Usage: scripts/sign-file [OPTIONS]... [MODULE]...\n");
+	fprintf(stderr, "Available options:\n");
+	fprintf(stderr, "-h, --help             Print this help message and exit\n");
+
+	fprintf(stderr, "\nOptional args:\n");
+	fprintf(stderr, "-s, --rawsig <sig>     Raw signature\n");
+	fprintf(stderr, "-p, --savesig          Save signature\n");
+	fprintf(stderr, "-d, --signonly         Sign only\n");
+#ifndef USE_PKCS7
+	fprintf(stderr, "-k, --usekeyid         Use key ID\n");
+#endif
+	fprintf(stderr, "-b, --bulksign         Sign modules in bulk\n");
+	fprintf(stderr, "-r, --replaceorig      Replace original\n");
+	fprintf(stderr, "-t, --dest <dest>      Destination path ");
+	fprintf(stderr, "(Exclusive with bulk option)\n");
+
+	fprintf(stderr, "\nMandatory args:\n");
+	fprintf(stderr, "-i, --privkey <key>    Private key\n");
+	fprintf(stderr, "-a, --hashalgo <alg>   Hash algorithm\n");
+	fprintf(stderr, "-x, --x509 <x509>      X509\n");
+
+	fprintf(stderr, "\nExamples:\n");
+
+	fprintf(stderr, "\n    Regular signing:\n");
+	fprintf(stderr, "     scripts/sign-file -a sha512 -i certs/signing_key.pem ");
+	fprintf(stderr, "-x certs/signing_key.x509 <module>\n");
+
+	fprintf(stderr, "\n    Signing with destination path:\n");
+	fprintf(stderr, "     scripts/sign-file -a sha512 -i certs/signing_key.pem ");
+	fprintf(stderr, "-x certs/signing_key.x509 <module> -t <path>\n");
+
+	fprintf(stderr, "\n    Signing modules in bulk:\n");
+	fprintf(stderr, "     scripts/sign-file -a sha512 -i certs/signing_key.pem ");
+	fprintf(stderr, "-x certs/signing_key.x509 -b <module1> <module2> ...\n");
+
 	exit(2);
 }
 
@@ -281,7 +312,7 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 #endif
 
 		case 'h':
-			format();
+			print_usage();
 			break;
 
 		case 'i':
@@ -312,7 +343,7 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 			break;
 
 		default:
-			format();
+			print_usage();
 			break;
 		}
 	} while (opt != -1);
@@ -472,6 +503,9 @@ int main(int argc, char **argv)
 	argc -= optind;
 	argv += optind;
 
+	if ((opts.bulk_sign && opts.dest_name) || (!opts.bulk_sign && argc != 1))
+		print_usage();
+
 	OpenSSL_add_all_algorithms();
 	ERR_load_crypto_strings();
 	ERR_clear_error();
-- 
2.41.0

