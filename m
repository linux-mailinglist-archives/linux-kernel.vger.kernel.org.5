Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714C47E9F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjKMPGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjKMPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:06:11 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55D21727
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:06:07 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 785E4240105
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 16:06:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1699887966; bh=cKoUTgqnqm13vv5MG10qVvupT4f2fR5l912U63mc1Jw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=ME3jk71FlNDwdoz29NDXmzhntLvKVMRYDJ14Ni+MMSEoslo/nAtvgTOXUHugN9htP
         U8gkJJeHseXN5P31ERyUUELSVtvElTqRu8ZXir2gyxmTvi4YI+p65KGYlAC4PTcpSm
         I5J0kMF1RqXqThcOTegkw6rnxV1sRkGYIu7fzb0dz6+M+6h+8XEw1D7TwqhOZ0nMVp
         7NBgW6ngkwBHzoQ0N4FnYtAdzEO9p6OlaAqS5XTuCLHIcpSaUjqisJPhPwplsj8+eH
         3WsiOCb6AXnbcj6uJ8JIqFzOD+/vZJVXOZeqSvsopkUyo6zihtvoZMe1AYjEThbZ2W
         Hec2LpdIXxqjQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4STXn90hFNz9rxY;
        Mon, 13 Nov 2023 16:06:05 +0100 (CET)
From:   Charalampos Mitrodimas <charmitro@posteo.net>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH 4/8] staging: sm750fb: Rename sii164SetPower to sii164_set_power
Date:   Mon, 13 Nov 2023 15:05:09 +0000
Message-Id: <20231113150512.1210869-5-charmitro@posteo.net>
In-Reply-To: <20231113150512.1210869-1-charmitro@posteo.net>
References: <20231113150512.1210869-1-charmitro@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 8 ++++----
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index e568c210e2bd..c12df1f9fb00 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -20,7 +20,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 #ifdef SII164_FULL_FUNCTIONS
 		.reset_chip = sii164_reset_chip,
 		.get_chip_string = sii164_get_chip_string,
-		.set_power = sii164SetPower,
+		.set_power = sii164_set_power,
 		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
 		.is_connected = sii164IsConnected,
 		.check_interrupt = sii164CheckInterrupt,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index f0a255da1b36..d0b80b86a4d7 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -256,8 +256,8 @@ long sii164_init_chip(unsigned char edge_select,
 void sii164_reset_chip(void)
 {
 	/* Power down */
-	sii164SetPower(0);
-	sii164SetPower(1);
+	sii164_set_power(0);
+	sii164_set_power(1);
 }
 
 /*
@@ -273,13 +273,13 @@ char *sii164_get_chip_string(void)
 }
 
 /*
- *  sii164SetPower
+ *  sii164_set_power
  *      This function sets the power configuration of the DVI Controller Chip.
  *
  *  Input:
  *      powerUp - Flag to set the power down or up
  */
-void sii164SetPower(unsigned char powerUp)
+void sii164_set_power(unsigned char powerUp)
 {
 	unsigned char config;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 7c5cc81f38d4..c15cd6a5d53b 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -33,7 +33,7 @@ unsigned short sii164_get_device_id(void);
 #ifdef SII164_FULL_FUNCTIONS
 void sii164_reset_chip(void);
 char *sii164_get_chip_string(void);
-void sii164SetPower(unsigned char powerUp);
+void sii164_set_power(unsigned char powerUp);
 void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
 unsigned char sii164IsConnected(void);
 unsigned char sii164CheckInterrupt(void);
-- 
2.39.2

