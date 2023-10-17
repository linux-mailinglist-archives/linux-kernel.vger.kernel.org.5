Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30447CBD27
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjJQINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJQIN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:13:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F02E8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:13:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1225AC433C8;
        Tue, 17 Oct 2023 08:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697530406;
        bh=46LFzxJ8kVX8In6gN8/8l3XSFq9NXQixEzzsEgPJrZI=;
        h=From:To:Cc:Subject:Date:From;
        b=PbwrsftLLcm9eKRbpFoh1Xo1EVbsmerWJ7QUrWDhUzstBQtj4BXm8dscZkc9KbtS7
         p+6wmy534ZJEdBP4PsSK5Qf1zm4rYF8eDbM358IwHNGD1yRTyA0CKMjUKYjlfKEhpF
         ZUhBub3R+RYdT3YKlIBHeC5vHThTHtdKj9wtLN/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] staging: rtl8192u: remove entry from Makefile
Date:   Tue, 17 Oct 2023 10:13:10 +0200
Message-ID: <2023101709-amuck-upward-46f1@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  31
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=46LFzxJ8kVX8In6gN8/8l3XSFq9NXQixEzzsEgPJrZI=; b=owGbwMvMwCRo6H6F97bub03G02pJDKl6TqJebl+2HHpdV39+YSRnb33SqT8u+sdnx/Avt0nIy tvwXKOnI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACaSxsYwz0hY4Pa6qMf71d7U aJRvet/EFX5/NsOCGbfEZp23bXOaNaX9JefSreYzNeXUAQ==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 697455ce4110 ("staging: rtl8192u: Remove broken driver"), the
driver was removed, along with the Kconfig entry, but the Makefile line
in drivers/staging/Makefile was not updated, so things like 'make clean'
fail to work properly as they will decend into all subdirectories to try
to clean things up.

Resolve this by removing the entry in the main staging Makefile.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Fixes: 697455ce4110 ("staging: rtl8192u: Remove broken driver")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index ffa70dda481d..0f6379436443 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -4,7 +4,6 @@
 obj-y				+= media/
 obj-$(CONFIG_PRISM2_USB)	+= wlan-ng/
 obj-$(CONFIG_FB_OLPC_DCON)	+= olpc_dcon/
-obj-$(CONFIG_RTL8192U)		+= rtl8192u/
 obj-$(CONFIG_RTL8192E)		+= rtl8192e/
 obj-$(CONFIG_RTL8723BS)		+= rtl8723bs/
 obj-$(CONFIG_R8712U)		+= rtl8712/
-- 
2.42.0

