Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993707A570E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 03:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjISBly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 21:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjISBlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 21:41:52 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5FE3910D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 18:41:46 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id D3F6460292BAF;
        Tue, 19 Sep 2023 09:41:43 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     linux-kernel@vger.kernel.org
Cc:     Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?profile:=20Remove=20unnecessary=20=E2=80=980?= =?UTF-8?q?=E2=80=99=20values=20from=20err?=
Date:   Tue, 19 Sep 2023 09:41:26 +0800
Message-Id: <20230919014126.8168-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

err is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/profile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index 8a77769bc4b4..87acc7a9d7e2 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -465,7 +465,7 @@ int __ref create_proc_profile(void)
 	enum cpuhp_state online_state;
 #endif
 
-	int err = 0;
+	int err;
 
 	if (!prof_on)
 		return 0;
-- 
2.18.2

