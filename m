Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6D1754721
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 08:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGOGvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 02:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOGvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:51:33 -0400
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FE23599;
        Fri, 14 Jul 2023 23:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689403880;
        bh=NERu/KtVTq3aiG51hr0iINkM+uTg2JQTX/C5jpABD4s=;
        h=From:To:Cc:Subject:Date;
        b=MKeuIyY4KWXwpz9KEL+skFtpEZLTM6Ex9evYkT7Xxk2i8ulUwqgvaRUFpjUgy773Q
         ab70YvDnoqEIwRkU/c6jrRfA0jOijlDKpSD+kSdR0e14+VHmy1+5Vfaf0DESzwxatr
         ZxO//BLXPyJ4nveiQODt8xXdzKDseAiMt0OScAbg=
Received: from KernelDevBox.byted.org ([180.184.51.134])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id B3B81259; Sat, 15 Jul 2023 14:44:59 +0800
X-QQ-mid: xmsmtpt1689403499tmzqxrafn
Message-ID: <tencent_7C09B91B925AF62D7CB0280F028563540807@qq.com>
X-QQ-XMAILINFO: N9hOYgqt7GNxrr4Li6otSOTa8O04DwYr+WikfpSer4UK0QDbrd6ZleBYBOIRAl
         OgML/EAumXg724d67ZIB0HXO0zLdcyZRrKgQXbFyg10o9sU0NQcyNQp2vhb0FDLlMDfPWjblJJoD
         tAQs4D542v3lU33EHZmQp9pfw+2c4hD9UW/YwqqyB5InmOpUN6ZXvWZLWqRpvzYKbO5C9LcvPgps
         ushAi64oygxBYZbz4EfOPNCguy9OI74ktLLBPU1Oy6BlaqGSIsmo4yGljM2oQN6Q+gK/DCmJzTcB
         Z+6OUUtb6pG3L4lMHTICOGi6oJ+lletXFlbx4BA6tp61nIDB/lPU8QHCrllJjHYoKd7Uo4N80b/6
         uygKLYbypUp4/MQ2lPVwfH4iivvhJQaUnjXRh9SLDoArBzmqOhSE+vjl514DfeMYAPLHgxhzRXsI
         3Yla0+Vv/rjvANov1tRxmyVtyw0bx8xmz9QA9oulDj2XYBMmpu3vzCKcco6QVpE+WJD+FToPHLVD
         W59KNrxstEqEwqmhPjaVO7/SlWARNnNlVjMXhmO5x/W5sS/a9PiDWytCRRGzQANFNkdwja/Hs+4/
         jl9/py0UqhpyI2/iWeXhdaPwrHbL2v/oDZ7/2WG1K2LYp4tmK5rz9w3Zah1ElJEieNIxMYxcCFY3
         ApDSgq+JwL73EFoWOd6vj0o450pMoB3x5mcv0ST/roEJE45wAOU69tFT4gPeP6sLX6lylkJ3qm82
         8+qdynZzB3W1N0npufLKDGDcMdhnnTSnUN00WibpFFFtK0nge3H0LYpUEGuo/Sd0F4P0ucUmMJ3E
         teSN+AhrN/uVkmXbZ77VGFE/50N0hmfARRwVYP4U9AFs+MprtOe0Uk7fQ0BiWMEQUu6GFtdwif5v
         eWs1+n2sGF0Ulu3VTj6PsJvmFoSIFxZap1flLZH9owe5hcnRXbGH8yLnBZLyoxynjmX09NrWJTpo
         A3aXeS/pwjKFKuqNLs2xqwist1Z5kXQzTtOC7UdmhnkyEASweHDu7lPzMpUoNq
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     pkshih@realtek.com, Markus.Elfring@web.de, kuba@kernel.org
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH v2] wifi: rtw89: debug: fix error code in rtw89_debug_priv_btc_manual_set
Date:   Sat, 15 Jul 2023 14:44:57 +0800
X-OQ-MSGID: <20230715064457.971310-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a failure during kstrtobool_from_user()
rtw89_debug_priv_btc_manual_set should return negative error code
instead of returning the count driectly.

Fix this bug by returning the correct error code.

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
Changes in v2:
- Corrected the format of this patch
- Used variable ret instead of goto out

 drivers/net/wireless/realtek/rtw89/debug.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index a4bbac916e22..ce5a9ac08145 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3193,12 +3193,14 @@ static ssize_t rtw89_debug_priv_btc_manual_set(struct file *filp,
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	bool btc_manual;
+	int ret;
 
-	if (kstrtobool_from_user(user_buf, count, &btc_manual))
-		goto out;
+	ret = kstrtobool_from_user(user_buf, count, &btc_manual);
+	if (ret)
+		return ret;
 
 	btc->ctrl.manual = btc_manual;
-out:
+
 	return count;
 }
 
-- 
2.30.2

