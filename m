Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98755802280
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjLCKZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjLCKZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:25:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A6A10E4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:25:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF795C433CA;
        Sun,  3 Dec 2023 10:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701599135;
        bh=5SBYjvSXCCi361BUF6jW6e0HVe2sXM0i9kXYxAiDfG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0F0Nnyp3WZmkSirOGw6DV/AN4cIC1JcR0C8H9SZRzwHSlALHuz+2Bnoepfd8ypx+
         VW/Q0aG5avI60eQyeSm469rI3VsIP7VpiQwldFz3FKqr7zRQZCtutd6za0np9Babm4
         SRV2eCNl2eh9VVmniqMoUJfFeFLMl3dPnoFpVmJu3Af3uC9TiUme7eVkZKcFJtmcsC
         dnnXI6gceb5k620eQCgygAiExRPYv3zLiAtKtEPot1LVpdF1fYL7xZIL/YxoENVrY/
         kljsBARO72ssfdQ4CReLXWLOp2KRUghuhO+OL6bBVp/WxPyOXo9uPaH49L0iFW0Pl+
         y0O1ffyelLi2Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] kconfig: make menu_warn() static function
Date:   Sun,  3 Dec 2023 19:25:24 +0900
Message-Id: <20231203102528.1913822-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203102528.1913822-1-masahiroy@kernel.org>
References: <20231203102528.1913822-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is only used locally within menu.c.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lkc.h  | 1 -
 scripts/kconfig/menu.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 471a59acecec..3908741edf8f 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -80,7 +80,6 @@ char *str_get(struct gstr *gs);
 
 /* menu.c */
 void _menu_init(void);
-void menu_warn(struct menu *menu, const char *fmt, ...);
 struct menu *menu_add_menu(void);
 void menu_end_menu(void);
 void menu_add_entry(struct symbol *sym);
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 61c442d84aef..f07c0d8691af 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -19,7 +19,7 @@ static struct menu **last_entry_ptr;
 struct file *file_list;
 struct file *current_file;
 
-void menu_warn(struct menu *menu, const char *fmt, ...)
+static void menu_warn(struct menu *menu, const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
-- 
2.40.1

