Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B7B786524
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbjHXCNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbjHXCMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:12:39 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D82F8E77
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:12:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id C132D60AA07D4;
        Thu, 24 Aug 2023 10:12:33 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?seccomp:=20Remove=20unnecessary=20=E2=80=98NULL?= =?UTF-8?q?=E2=80=99=20values=20from=20prepared?=
Date:   Sat, 26 Aug 2023 02:43:48 +0800
Message-Id: <20230825184348.6870-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RCVD_IN_SBL_CSS,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prepared is assigned first, so it does not need to initialize the 
assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index d3e584065c7f..af672e03449a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1838,7 +1838,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 				    const char __user *filter)
 {
 	const unsigned long seccomp_mode = SECCOMP_MODE_FILTER;
-	struct seccomp_filter *prepared = NULL;
+	struct seccomp_filter *prepared;
 	long ret = -EINVAL;
 	int listener = -1;
 	struct file *listener_f = NULL;
-- 
2.18.2

