Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7590D79B268
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344596AbjIKVOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbjIKJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:51:11 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D7CCE6;
        Mon, 11 Sep 2023 02:51:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A672E0007;
        Mon, 11 Sep 2023 09:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694425862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wMBDha9fdZATE/tS3IS+GhXBQ2biCPCamqQI4+g2x5g=;
        b=U6NLyNh/FEH8/fvpeQUtHKs2dyTGmlZ2vxroPbFcIvQZQoyvpDfTEjyboTTSdA5E5tfyo/
        GpjrWeqhWoDJsZs0FiDH/kSTom27AsLTlepmo6BAMbnCBh6ZjhnJIsQ33pFyDTwnnQcaC9
        W/n5guAa/4ylt+9J1um+VCGVv1r0cTIdsEjJICyeyevyJq0YCMdNKPEp9QHcbheHEgz9xN
        17AK0kjtATkweDTaQn+H/0x87YvtfQOeXnRIiKCG+5XptPBFsSncOQ26R3fs/igCRZpz3M
        96uAMiZYPjdod8+g3fojYhnH0Rt+qafY0ENgIzig/K2Swt97NVYsmNFtBHVVCA==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: sh: silence warning
Date:   Mon, 11 Sep 2023 11:50:51 +0200
Message-ID: <20230911095052.1292869-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Silence:
drivers/rtc/rtc-sh.c:517:58: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 3 [-Wformat-truncation=]

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index cd146b574143..04a6d24e2817 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -469,7 +469,7 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 {
 	struct sh_rtc *rtc;
 	struct resource *res;
-	char clk_name[6];
+	char clk_name[14];
 	int clk_id, ret;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
-- 
2.41.0

