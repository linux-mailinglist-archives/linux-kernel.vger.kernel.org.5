Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06387548D0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 15:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGONnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 09:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGONnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 09:43:10 -0400
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982E82723;
        Sat, 15 Jul 2023 06:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689428580;
        bh=dNz+OjNDlEUgComoIKSnoAm4Bz3z0vkm3h5nOzFr4OQ=;
        h=From:To:Cc:Subject:Date;
        b=mKONzNztJXodzzw/CkXykbombfvQ2uVvMtGyajakZF9CVHSC2+Sov3a/DS0a+55M8
         skF7IP0HHNJIxnTAAEDoqsPeMpXCzqmVc1S606dRSXE9g3xdBnZcDoqVgFg6euVIev
         JBaeir6vnqiC7s5N7O9GvN3ekFJGdgCNQB1SPoUU=
Received: from KernelDevBox.byted.org ([180.184.51.70])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id ABA2A299; Sat, 15 Jul 2023 21:42:58 +0800
X-QQ-mid: xmsmtpt1689428578tn155qoz3
Message-ID: <tencent_1C09B99BD7DA9CAD18B00C8F0F050F540607@qq.com>
X-QQ-XMAILINFO: MiQgh5atCJQAwR+fZ+cyonpPeTO5jOVHv2Mq4MaV0HbaGp0Cth8XI5PitKG+k7
         OKN4BzQjChRIYr9z5MY60HCE428A6f+aay46117OjE42AUjC0PTvpnOQH+4IhZp/54EzBCQH6eEc
         GXtkm17vh2VcrdHQzhT9ihWJ7ytbcBes418+BVSpoMtmMXANWnS1lI4hbPjLteGa6dEbta8COmpP
         rzpw5I+EgUjRM0VMLNt/kIWN6PhzwU2PI+Fs5hqRI5dJkyAPp6ctmnLxVnuFNuZ1rukhfTfA+q2R
         p8leTdTn6oqE5FYqZL1xl47jXLKvWXS0Cb+Wi+CLcOdods88sRrJvVu2ex2aM6BBP9QvL5kMUjB7
         CB6YmsO14I8r8Wk4RBKAPG2+bqFSnjHzpsQ2EoifQw7vYwVwei8A3IcklUvjhCCylCnzly23gDI0
         w6OjCMYwsmH9kzuyZJ7v1rBP0sYLesG/SuRwGxhCQVhdLdIEOL+zt4XZSLBOHzSQNU5+TXfNRs/a
         kcxnZeNNKPEKdgBxQ+kxtZDzvqFVPdXFCdWmqXx1GuaGAGQUyPXdzbTbnxMlFEC+VDwui1ZzmDVj
         AZMMVDCVcV75s6IdyZ+hT76BWbacTrxTuLfIgJXCUtenhHthlHh1E2Z9tTXuYLVNUSW3qjjRL+WV
         AaY4QymS0P7xc5gdvL+d8x0moDGXElG3a1FJF77RUC6yx0PpncFtThwHURZjyfeqml1v2kkMgnis
         2NKNR+dDiExFefspAjet7pKCc8sKU3mWg+o8O3/6KF9YZKbewHBVk+3FpHxtq4a+0UEm83W9gUEs
         NEjc5D9MqQH8F9FSrq3T+PTQjqhrMmbOV8vKhYNYuW0oclHJ0ioUaMnF9fx955q8k0HY4WXaNz+f
         gNMvsqiT6ehDc4zl38CjffwMQ27e28TSYuY5/KhccSBN+9dQwpIHuv809ZEo7BNHleoncXTyVNid
         rv66H81AV5s890/SA9u/v4vnvnjHDAtFeUMdDRuqnDyCW/MnHg6gPasRgHpD8UhTBJ2UkVns8Nzf
         J8IT3AD/mcD7D4it2Ydth8lof1oDkWhBmSFocIl6cil/cB1yee
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     pkshih@realtek.com, Markus.Elfring@web.de, kuba@kernel.org
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH v4] wifi: rtw89: debug: Fix error handling in rtw89_debug_priv_btc_manual_set()
Date:   Sat, 15 Jul 2023 21:42:57 +0800
X-OQ-MSGID: <20230715134257.1847511-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a failure during kstrtobool_from_user()
rtw89_debug_priv_btc_manual_set should return a negative error code
instead of returning the count directly.

Fix this bug by returning an error code instead of a count after 
a failed call of the function "kstrtobool_from_user". Moreover
I omitted the label "out" with this source code correction.

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
Changes in v2:
- Corrected the format of this patch
- Used variable ret instead of goto out
Changes in v3:
- Improved change description
Changes in v4:
- Improved change description

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

