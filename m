Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EDA7E9F91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjKMPGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjKMPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:06:14 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183A1706
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:06:11 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 34B75240106
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 16:06:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1699887970; bh=ImO2p/LseShj5lOmJnVvCx6tNn9JRqxDUMthFKX+oJ0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=DKuevgchkENfdAXzMxqCjLOr/YnTvdIswvP0H23mLG0BJnMSsAtNYHqHigkoTys/X
         Pu1ePffC3b0rc6mOgqwuGEij1qG1+6qjV2v3kBz1b/QL0YC8sgZo8M9PJio1Qzmol0
         ixCMewdhxb8b4d3lRVJ/ffQE1lA6lFaSqDHsTREnLRhV8XBph60V1bTrnzsOaG2beU
         edOXVWuAeazYpT2Hz1jqWSlYRpg5M8RZuy+WCWPgxT2SVOD8r9Iu+pZ1o3JwHxiEaE
         Jri/uOEimE6bGr7WlW0A3vgZPQCBGtHTXWDnmgLJoyoTC75uy4IcbQ4LYfgqsO6tIz
         luPbqsFtcpdww==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4STXnD6G9Mz9rxQ;
        Mon, 13 Nov 2023 16:06:08 +0100 (CET)
From:   Charalampos Mitrodimas <charmitro@posteo.net>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH 7/8] staging: sm750fb: Rename sii164CheckInterrupt to sii164_check_interrupt
Date:   Mon, 13 Nov 2023 15:05:12 +0000
Message-Id: <20231113150512.1210869-8-charmitro@posteo.net>
In-Reply-To: <20231113150512.1210869-1-charmitro@posteo.net>
References: <20231113150512.1210869-1-charmitro@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index ac1aab77da28..1def02be4cce 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -23,7 +23,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.set_power = sii164_set_power,
 		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
 		.is_connected = sii164_is_connected,
-		.check_interrupt = sii164CheckInterrupt,
+		.check_interrupt = sii164_check_interrupt,
 		.clear_interrupt = sii164ClearInterrupt,
 #endif
 	},
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 24f40db0dfcf..b156a727bebf 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -370,14 +370,14 @@ unsigned char sii164_is_connected(void)
 }
 
 /*
- *  sii164CheckInterrupt
+ *  sii164_check_interrupt
  *      Checks if interrupt has occurred.
  *
  *  Output:
  *      0   - No interrupt
  *      1   - Interrupt occurs
  */
-unsigned char sii164CheckInterrupt(void)
+unsigned char sii164_check_interrupt(void)
 {
 	unsigned char detectReg;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index f8689bb3e1d5..33351f6d7f11 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -36,7 +36,7 @@ char *sii164_get_chip_string(void);
 void sii164_set_power(unsigned char powerUp);
 void sii164_enable_hot_plug_detection(unsigned char enableHotPlug);
 unsigned char sii164_is_connected(void);
-unsigned char sii164CheckInterrupt(void);
+unsigned char sii164_check_interrupt(void);
 void sii164ClearInterrupt(void);
 #endif
 /*
-- 
2.39.2

