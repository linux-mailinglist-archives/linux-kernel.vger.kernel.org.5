Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A067DCB9B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjJaLRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjJaLRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:17:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB94C2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:17:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9d10f94f70bso510038966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1698751032; x=1699355832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4v8a5RiHMYlglwAdgrZyHV3KIcl5PxmltDe1hiSZ5M=;
        b=WJx19JUvYylr/rePwIlsbglrHYMDlSA5sfnuSL6EmAowSbdSUT3Fd+/XXxlrZfhUsj
         J/cszZP4AYXS61DCreqXv3AqPWzkPNXFJLT+sT8faZ2ZJy53NwvmO5Hb9ETw4q5MXwNh
         IbHL3gIWtKxDvqu6hI2qBjZeMd8PGvS0H3eYZ9e/Ss9h/Cxl7Okfl20j9kLYjlb0CPuU
         PYCJ6a+fnJp6U4VJ5uEK4UrzeNLv89S6hbXx2zHl0lxgp7nk4XNwkyAiWvF1Bye+T5Ni
         AmBXXyCcp53cjjrigM3chteIjYRIOaYtwOWIVyMhYjj31j2aWLD0l4nuc0Yx5rcOAYNJ
         HinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698751032; x=1699355832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4v8a5RiHMYlglwAdgrZyHV3KIcl5PxmltDe1hiSZ5M=;
        b=jRVTaxWo2KtvbmwnJQYrqkhVfQpZmo/a/ovstab49ZxfXc4Itk8PW6YHKcD0B7M7hQ
         rbqm+/xZ1wASj+CWWfrSzNMh0G4NuLbBxLODJeKKoQB/nrtDlKxaj1ANxn81dLEtmIC8
         PTdqv9VzuGeb9p6khp/6OGESYaS4Lc3fHn97/LI/dA4WFysgKrD4zrrduhSmU3yve9ld
         R/m90Ybbc4Y1fXXTCBIho7GMBVV0mOtK1b5C73YI0l5WHGv3VMWRTsEVFQpZv7HQNPW/
         hCEskOn4FOnHUV/Xk/O6pRujOjHMwAcFMThx1V5oetWT6E6CJed2rGDGqtE9MIo/iwCV
         5mag==
X-Gm-Message-State: AOJu0Yxi+37Jf5S0GzuJ0b4t1/9XAk6lijn75emKSdUJrDSjhvHvQO1y
        nW8Q8itJQV8t0tz8bWRS/gXD2A==
X-Google-Smtp-Source: AGHT+IFfnZRFnEk/ev5++w7OPm0hDm/9kXdKQTzvdxqPuHdb+OE0ib4NmMgw1LQN/uhro1gW0RNYyA==
X-Received: by 2002:a17:907:2da9:b0:9b2:982e:339a with SMTP id gt41-20020a1709072da900b009b2982e339amr9426712ejc.22.1698751031721;
        Tue, 31 Oct 2023 04:17:11 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.numericable.fr ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id oy11-20020a170907104b00b0099cc36c4681sm795606ejb.157.2023.10.31.04.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 04:17:11 -0700 (PDT)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Yoann Congal <yoann.congal@smile.fr>,
        Brandon Maier <brandon.maier@collins.com>
Subject: [PATCH v4] kconfig: avoid an infinite loop in oldconfig/syncconfig
Date:   Tue, 31 Oct 2023 12:16:47 +0100
Message-Id: <20231031111647.111093-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exit on error when asking for value and reading stdin returns an error
(mainly if it has reached EOF or is closed).

This infinite loop happens in particular for hex/int configs without an
explicit default value.

Previously, this case would loop:
* oldconfig prompts for the value but stdin has reached EOF
* It gets the global default value : an empty string
* This is not a valid hex/int value so it prompts again, hence the
  infinite loop.

This case happens with a configuration like this (a hex config without a
valid default value):
  config TEST_KCONFIG
       hex "Test KConfig"
       # default 0x0

And using:
  make oldconfig < /dev/null

This was discovered when working on Yocto bug[0] on a downstream
kconfig user (U-boot)

[0]: https://bugzilla.yoctoproject.org/show_bug.cgi?id=14136

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
Tested-by: Brandon Maier <brandon.maier@collins.com>
---
v3->v4:
 * Added Brandon Maier's "Tested-by". Thanks!
v2->v3:
 * Simplify the patch by fusing comments of :
   * Masahiro Yamada : Exit as soon as reading stdin hits an error
   * Randy Dunlap : Display the name of the currently read symbol
v1->v2:
 * Improve coding style
 * Put more info in the commit message

 scripts/kconfig/conf.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 33d19e419908..68f0c649a805 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -74,13 +74,17 @@ static void strip(char *str)
 }
 
 /* Helper function to facilitate fgets() by Jean Sacren. */
-static void xfgets(char *str, int size, FILE *in)
+static int xfgets(char *str, int size, FILE *in)
 {
+	int ret = 0;
+
 	if (!fgets(str, size, in))
-		fprintf(stderr, "\nError in reading or end of file.\n");
+		ret = -1;
 
 	if (!tty_stdio)
 		printf("%s", str);
+
+	return ret;
 }
 
 static void set_randconfig_seed(void)
@@ -339,7 +343,10 @@ static int conf_askvalue(struct symbol *sym, const char *def)
 		/* fall through */
 	default:
 		fflush(stdout);
-		xfgets(line, sizeof(line), stdin);
+		if (xfgets(line, sizeof(line), stdin) != 0) {
+			fprintf(stderr, "Error while reading value of symbol \"%s\"\n", sym->name);
+			exit(1);
+		}
 		break;
 	}
 
@@ -521,7 +528,11 @@ static int conf_choice(struct menu *menu)
 			/* fall through */
 		case oldaskconfig:
 			fflush(stdout);
-			xfgets(line, sizeof(line), stdin);
+			if (xfgets(line, sizeof(line), stdin) != 0) {
+				fprintf(stderr, "Error while reading value of symbol \"%s\"\n",
+						sym->name);
+				exit(1);
+			}
 			strip(line);
 			if (line[0] == '?') {
 				print_help(menu);
-- 
2.30.2

