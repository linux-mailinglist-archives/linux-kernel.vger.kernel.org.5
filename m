Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3924770F25
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjHEJ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 05:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHEJ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 05:57:25 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FDF1B9
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 02:57:21 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so4640536e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20221208.gappssmtp.com; s=20221208; t=1691229440; x=1691834240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WCaScbYEgtnjR1GCfvq7Z8PNNCiGxQnN+NbG1fq6FPE=;
        b=I77rfBvKy87ih9s65g5GRJGXFBYxUgGm2YbA5OMVa8D77epIecTEufL8z9LN1pFlho
         YHFHvWmMvGPRUhGCrHPOnrOSb80cFFcCJ81Xc1e3T7FDErZoQP0YUJ3ey4dRjtkfLrN6
         559JJInm0vT9+dwtUGpIUUPctmWAUpr7hDDiZJZzCP2EgK+xWMNqFjilNCAw5Zgwm+K7
         IGa2jHJp3N4XlxGB3lmIpT5+yNg15tyMgUPfmncKMnwRC0lACC1TfHY/YOvDRQleLjcE
         DvIZOh9ry+7OwYIT/kemwSvu/gYr8RWV1zHKl+N48XEnSViNp59h2Hf306Jcm2oSIvx4
         kCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691229440; x=1691834240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCaScbYEgtnjR1GCfvq7Z8PNNCiGxQnN+NbG1fq6FPE=;
        b=LPadxo/nFVZbOVmIEQYtPL07dR0plfnGjV4SYkJbvKirOvLkWlL+wOpvsS97zaEDfy
         hkIWKKzBjzFlVIeyIn6bfuNBexO/+iYj/PNvP3fzrI1sjxnFe9rtO2z9+Gui84JkCTTB
         hAu7AKGi96osQWga7ymsdjGKSCu3D7mH3Lt1sJxVtigxEm8RFnWyeqCsnjqdkzT1APwD
         Smbs1pxcPHi/tokDO4Yujn71nCzHvH8LI1HVOB5xf+gthBuTkT8gWmksVTYsmh/n7GZ6
         u4k3FH6P2buAj5j2IZU9pNqojmJ5E7zUbPnfR8D/BpAx2M4ju56fGOYkGW8NYJwT9ojA
         Ncdw==
X-Gm-Message-State: AOJu0YyzIoHXdJI6xfZ9fQOh9SOpOr2jfCg1+Py1pkmSUonlr2KGkqAp
        tjACxe57IGTBFd390vY5LeEsjA==
X-Google-Smtp-Source: AGHT+IErPU4Ozl17Gl5tDc1p7f7iQOXYlrFzyiYjM0U248Pg6C4cbxf0ns77tv8rKXE5beamGWCeOA==
X-Received: by 2002:ac2:465d:0:b0:4fd:8976:5fc9 with SMTP id s29-20020ac2465d000000b004fd89765fc9mr2712016lfo.23.1691229439480;
        Sat, 05 Aug 2023 02:57:19 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d640d000000b003176053506fsm4752078wru.99.2023.08.05.02.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 02:57:19 -0700 (PDT)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v2] kconfig: avoid an infinite loop in oldconfig/syncconfig
Date:   Sat,  5 Aug 2023 11:57:09 +0200
Message-Id: <20230805095709.6717-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exit on error when asking for value that has an invalid default value
and stdin has reached EOF. This happens in particular for hex/int
configs without an explicit default value.

Previously, this case would loop:
* oldconfig prompts for the value but stdin has reached EOF
* It gets the global default value : an empty string
* This is not a valid hex/int value so it prompts again, hence the infinite loop.

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
v1->v2:
 * Improve coding style
 * Put more info in the commit message 

 scripts/kconfig/conf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 7cf63261d951c..8f32cbbce4805 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -377,8 +377,16 @@ static int conf_string(struct menu *menu)
 			line[strlen(line)-1] = 0;
 			def = line;
 		}
-		if (def && sym_set_string_value(sym, def))
+		if (def && sym_set_string_value(sym, def)) {
 			return 0;
+		} else {
+			if (feof(stdin) && !sym_string_valid(sym, sym_get_string_value(sym))) {
+				fprintf(stderr,
+					"Symbol %s has invalid default value and stdin reached EOF\n",
+					sym->name);
+				exit(1);
+			}
+		}
 	}
 }
 
-- 
2.30.2

