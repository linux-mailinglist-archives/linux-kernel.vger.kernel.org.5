Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E677DE394
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjKAPYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjKAPY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:24:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67291DA;
        Wed,  1 Nov 2023 08:24:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9d267605ceeso588203166b.2;
        Wed, 01 Nov 2023 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698852266; x=1699457066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MR56JFaTSz3HojkL2pFJM5gDNujw4Oiu7ruy5pujofg=;
        b=i122G23ULf4J/voTJG3Fb7wWMoG8LE/ssCLyfVwFBh45SPe3+/YbrERS62gA04m4wY
         EBiyQhDZYHsJQUZ4TpatQjv6PB/bVcfDaWkB5gArBIZl2gjCOYoUMhoDtC7sWWSrHUmr
         ffYbjQHzSOsiND8TGp3Mq2Xsety5U/N+EmIObqMpkKFgGEFiruaxatpSB/QkyGhB7Me2
         fqb/GmE6qwYUYLqDvvKHoH1sTbJNnmxl0SQYXp3hjQdAYkBihZDz7QT5XnXGiGkO1Wvv
         oDdZlaKLYwMJ3HbRPzmJAbQdXHvQ7Hfzs1wKsIubeWYXAjdYnoyq40z7PBauB8K/uA3f
         gK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698852266; x=1699457066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MR56JFaTSz3HojkL2pFJM5gDNujw4Oiu7ruy5pujofg=;
        b=kpbT5GAaP4d+Es0jvPf6PIgF1wiiwtP0+9vRRRub8xrfI/NH/hNFtz3oSppNuK2uyJ
         TPqkeYUlHjLzxLVOJ0tyxMePIzepHPWhCse0fJ9+CWflqTbEV+lznjGVFvxxdd3Cd+fr
         b9TLrz7QHXBhrRYKQXTrt5DWkfRCVN1uumFTucsOqF6iDIdDuHsJsxK/h5bvZqgWksNq
         3Xf5obnPpP+LOEuaa1fkKezRUHDwOX/XsdHrn6KhXnJZFIOdV2yKTeysIAK+FpIi3Ztr
         nWWgTlpzYmk9bul9mYvIllxN7y6SOfa4nbDGxIPVRdwXEKxiHBOAotPQoUFGW8QOf/z2
         t/LQ==
X-Gm-Message-State: AOJu0YyDAtAVhMXgxqQDXpjQhkt6GhbulbN/IKyAAwgpg5nLrFJxP1VW
        a7E0JORjtLWiC6UwIeaLvQ==
X-Google-Smtp-Source: AGHT+IG06McQz3xQ9bs3PqKtzLwtYLm29nY/TyIOplo37JTu3OFaOpw5cUcGk9s6YXB+xPAlRY6zUQ==
X-Received: by 2002:a17:906:4fc8:b0:9a6:4f54:1da6 with SMTP id i8-20020a1709064fc800b009a64f541da6mr2108484ejw.57.1698852265584;
        Wed, 01 Nov 2023 08:24:25 -0700 (PDT)
Received: from localhost.localdomain ([105.163.156.68])
        by smtp.gmail.com with ESMTPSA id lu13-20020a170906facd00b009ad8796a6aesm50855ejb.56.2023.11.01.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:24:25 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: sm750fb: Remove unused return value in display_control_adjust_sm750le()
Date:   Wed,  1 Nov 2023 18:21:34 +0300
Message-ID: <20231101152137.10664-2-anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modifies the return type of display_control_adjust_sm750le()
to void from unsigned long as the return value is being ignored in
all subsequent function calls.

This improves code readability and maintainability.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---

Changes in v3:
- Rebase patch to apply against latest branch

 drivers/staging/sm750fb/ddk750_mode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index e1f20379431c..4278f9a826ab 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -13,7 +13,7 @@
  * HW only supports 7 predefined pixel clocks, and clock select is
  * in bit 29:27 of Display Control register.
  */
-static unsigned long
+static void
 display_control_adjust_sm750le(struct mode_parameter *mode_param,
 			       unsigned long disp_control)
 {
@@ -70,8 +70,6 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
 	disp_control |= DISPLAY_CTRL_CLOCK_PHASE;
 
 	poke32(CRT_DISPLAY_CTRL, disp_control);
-
-	return disp_control;
 }
 
 /* only timing related registers will be  programed */
-- 
2.42.0.345.gaab89be2eb

