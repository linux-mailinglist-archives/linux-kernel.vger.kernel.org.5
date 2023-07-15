Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6DF75488E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGOMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 08:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGOMwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 08:52:38 -0400
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3651A35B5;
        Sat, 15 Jul 2023 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689425535;
        bh=ZavfJ3sl0BIdu9qU/Btv2uDCTKqWbE0OwBWuVN/30zo=;
        h=From:To:Cc:Subject:Date;
        b=awfmRGi3i8FeUigI0LF58aw+jVInz9kTg0VuR33SS9wO7ITU0YL5xrPdONHabxZov
         YM82j7lGY2hAw+ZpPKqnLE7wo4uZl4JFddwU/IE6Vo5B+ySysJj8bGH/p0xFN4AIsQ
         g3eZi44FyOEidLiETarQADuoLzuInv9nLFM0P1TI=
Received: from KernelDevBox.byted.org ([180.184.51.70])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id D0C9C832; Sat, 15 Jul 2023 20:52:12 +0800
X-QQ-mid: xmsmtpt1689425532twcg2r5io
Message-ID: <tencent_1BEE491CDD88D78E6D0583D57B7C2844A00A@qq.com>
X-QQ-XMAILINFO: Ma+X2EIxQOjIddsJ+eA7SFWNxqgXSMWAlpeG6fAU+MAbNXvA/4b5DZB2jEI5kn
         d40GLTjckFV1CuOEEaQkVoXCb8Ctc592z4KUuzsXPGLCmxp8+9mtiC6Wo16k/WPkE3TlBulSe4cY
         ogewe3JAokJ+cYA2xionFW9FC/BCVb4at2XtkzZiVCq1YGMqVFLYgAsyYj61bP4MNK3RYl2Q/I9k
         SNdAWnbnu29jhIrMAZFFzH6TfbPtlR4x4hl+mGKHO/IWklwT3r5vBfLnUSwaqt3LTeePfVSYtf/l
         RASlacq02rMq/wHQRNyJ8E8rwanJFoNi+wWyuiIJ5/AC9WhZUFmiVO+nXh8yr9blFk8ABQ+qvrx4
         Ntgx0drVHZLxpRnT0yI3tLYaNEgJskGOzTJY9Bc3x0YEJgnisnS0kb3kMDYkM6oIEzJ+kmcjdg/P
         aoQHmHDxexw0pEzb2qbCpmH9N5ghgNo8C1wLwMXZx16f/V4/qMA3Y+YaTagqLR9qBz6xh5NTSa1B
         U4sVCsfch7TDglrNpKpN4UHK+MmOmQ+coZkfPjj9dgECgIrMlqYlGfx+JW3VTKSHWcUvBBs13V/7
         ZwsjqIr6YE00hFDaeVL2LG8hHkShh74kWasFpuQJi+lspWPWp683Ssln2vv8YEnHfzJGp5mWlNvR
         Y/vTEd0srAP1hkr7noISXHrkePSBaVvFoiX5UxhNMOIUiHOg7mnnx0RSk8Tmiwbk0GtYe4qQeYx5
         9Csztw3YXEZlb+chKJvjUfOCIR7EPIc8lLbLOvmcNYXCYbKHCtFQo8IRJvsnL3lKzzBpulh4TXQw
         QYLqIsFyJ/JPLhu4S4cvB6i7z4X01oXgkGXHyua9cOtPbpn+sHXsYYJXIj07N90WqLpsIL2G0cJj
         gQSQJ9AXL7fYJFY1eMNZiEI8l3GmBLW86VhJF7htgwBY8fK+goQUk9yvlewz/aJOd7do6z7N1Bo/
         aul8qBXFyKgfmAPa5uzgjznOW1cpuTnHDzUyh5smEIIelKd29kbaAr2Kzf/b1kGdjQZSKOmK8W3W
         ZStM6Edd/GKFxkdJqqOxksAyMhp7vE7xJdHFW6R0W899T5comYKqm+yru4npc=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     pkshih@realtek.com, Markus.Elfring@web.de, kuba@kernel.org
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH v3] wifi: rtw89: debug: fix error code in
Date:   Sat, 15 Jul 2023 20:51:45 +0800
X-OQ-MSGID: <20230715125145.1771474-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a failure during kstrtobool_from_user()
rtw89_debug_priv_btc_manual_set should return negative error code
instead of returning the count driectly.

Fix this bug with the following changes:
- Return an error code instead of a count after a failed call 
of the function "kstrtobool_from_user".
- Omit the label "out" with this source code correction.

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
Changes in v2:
- Corrected the format of this patch
- Used variable ret instead of goto out
Changes in v3:
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

