Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5867D0A82
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376464AbjJTI1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376440AbjJTI1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:27:47 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 93682C0;
        Fri, 20 Oct 2023 01:27:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 7861260327055;
        Fri, 20 Oct 2023 16:27:35 +0800 (CST)
X-MD-Sfrom: zhoujie@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   ZhouJie <zhoujie@nfschina.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        ZhouJie <zhoujie@nfschina.com>
Subject: [PATCH] =?UTF-8?q?module:=20main:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20err?=
Date:   Fri, 20 Oct 2023 16:27:27 +0800
Message-Id: <20231020082727.10659-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant assignment .The variable 'err' was assigned a value
before its usage, making the initial assignment unnecessary. This commit
removes the redundant assignment, improving code clarity and efficiency.

Signed-off-by: ZhouJie <zhoujie@nfschina.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fedfdb8db52..a3c036eb7bcdb 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2830,7 +2830,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 {
 	struct module *mod;
 	bool module_allocated = false;
-	long err = 0;
+	long err;
 	char *after_dashes;
 
 	/*
-- 
2.18.2

