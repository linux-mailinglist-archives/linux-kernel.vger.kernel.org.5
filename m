Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4087EBD5F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjKOHLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:11:21 -0500
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22094F1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:11:15 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee165546f0ec33-d7501;
        Wed, 15 Nov 2023 15:11:12 +0800 (CST)
X-RM-TRANSID: 2ee165546f0ec33-d7501
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from ubuntu.localdomain (unknown[10.54.5.255])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee765546f0ee0b-6d655;
        Wed, 15 Nov 2023 15:11:11 +0800 (CST)
X-RM-TRANSID: 2ee765546f0ee0b-6d655
From:   zhujun2 <zhujun2@cmss.chinamobile.com>
To:     acme@kernel.org
Cc:     irogers@google.com, ast@kernel.org, namhyung@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        zhujun2@cmss.chinamobile.com
Subject: [PATCH] toos:leds: Fix printf format string in uledmon.c
Date:   Tue, 14 Nov 2023 23:11:09 -0800
Message-Id: <20231115071109.11511-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the argument type is 'int',printf '%d'
in format string.Problem found during code reading.

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---
 tools/leds/uledmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/leds/uledmon.c b/tools/leds/uledmon.c
index c15a39c1f271..62befe06eab5 100644
--- a/tools/leds/uledmon.c
+++ b/tools/leds/uledmon.c
@@ -55,7 +55,7 @@ int main(int argc, char const *argv[])
 			return 1;
 		}
 		clock_gettime(CLOCK_MONOTONIC, &ts);
-		printf("[%ld.%09ld] %u\n", ts.tv_sec, ts.tv_nsec, brightness);
+		printf("[%ld.%09ld] %d\n", ts.tv_sec, ts.tv_nsec, brightness);
 	}
 
 	close(fd);
-- 
2.17.1



