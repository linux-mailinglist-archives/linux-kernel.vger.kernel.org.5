Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B55D79D544
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbjILPsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjILPsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:48:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EFD10EB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:48:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so2566986f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1694533720; x=1695138520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qir5/GADT6C25YxBC4a/ulJ8wEdWqJzoZGXrPaN77dA=;
        b=XJAkfePDn+MX+A31Y49f0pL933m81jNQXt2Lbq0qmwK5AhKfTG1i2RgdDoQDgciLL9
         +iQh4Dc0TwNfFmq5Q2xrTqe4IWaB+xTUgY/lzlhOnZlaom0U1E7Vn/xBNvNXKbWVQY2I
         1/24XnCj1xt25VtZFeq9Q9JpZJXTTjGJVmlVxPhEu1XD77qGplzSAwavz6ZblekH7AGg
         RjjXPUe99iaspZdN3vk6rKPo3aMe+euCe+kYSm6iTWy8JuRX3MjSZsLlsfQgAK80tcfa
         cIKrO8ZAEvQ+kKhDU/fcqSC8/PBxMJQfb3Bj+8buijvLO1Xya8JPSfI3s53mzE8Hknfk
         3jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694533720; x=1695138520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qir5/GADT6C25YxBC4a/ulJ8wEdWqJzoZGXrPaN77dA=;
        b=EX8KAOulwpTKVXGCiQErNaM9EKyolmSYWj6NH/tL0tmJNi/AgYv5vWDKWDG5R+DMnq
         Yc2+ISPL1UafTGOcuhvLKi9CfcfbQajMY7psoaeA/7HlXVemRDncaTiOyB1Cj5aDx4wz
         OEnV2bHxd70x6G/zBQRFnRLJOtS6lBAz+/YU7F0weilakZdYUqMlP3kjNu+XQOSdXhDc
         0OSKN+7GtANmVs6/FI5b0hdutmxKhHU9ZEdrF81rU1g/vsWgZkRTa9wZ+xfgUzBwwgyK
         OcETHAzQDkVz8zOieo3o+dslDI/+J3JRytLvC32VsL0cCya1/06P8uhzZdY3xbnaQN0+
         U9gg==
X-Gm-Message-State: AOJu0YwAZJwNcwJaz8NmVGhLg89ZrWyJnqPny1lr/Cx+Vub/zSS4cC3t
        uFZ6DQ8Arx6tQVBrcR0mNFWgXQ==
X-Google-Smtp-Source: AGHT+IEVTKA0CaBtBFNx8PXTtui/wqeMjFQcOulAVIdtRSIn30x+cSy9hnqedOue5NJNNf5+OioREw==
X-Received: by 2002:a5d:4f0c:0:b0:317:e68d:f862 with SMTP id c12-20020a5d4f0c000000b00317e68df862mr9826813wru.37.1694533719832;
        Tue, 12 Sep 2023 08:48:39 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.numericable.fr ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id o21-20020adfa115000000b0031f9bdb79dasm7717445wro.61.2023.09.12.08.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:48:39 -0700 (PDT)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v3] kconfig: avoid an infinite loop in oldconfig/syncconfig
Date:   Tue, 12 Sep 2023 17:48:11 +0200
Message-Id: <20230912154811.1338390-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
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
index 33d19e419908b..68f0c649a805e 100644
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

