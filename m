Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE077E9F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjKMPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjKMPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:06:13 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56E01706
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:06:09 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id AB0BA24002D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 16:06:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1699887967; bh=33EB0Ym3zH6H8syG98g+ey7lfXVmTvuJAym04bp4hJc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=rsssDzp8lO6l/0qUzmyFSB69YPeg1P6WEkC3pUYgAtkmqFdgXinaKcjPeFN/PV82o
         yB4Y2wCQwgIlG4OIDqME7KQhXHzLpDHbJRkV5TS5U+DUmVtlP+jSgdn2p8Osk1R18/
         3TXG9qivrWvB/6XjQuJuUM1LATGLsMCCqGqOytIA0DqGzkuhAMCvH8mi18peyZbjMl
         H2SjQ3olPrhyMwYrxRvxwYpIpNMZadTjxDSRO2R2rXrL43SusdxI8OywGJs8e+dT1i
         g6VU+sosQ/DhidvEfuZh/0baOXCVX5l32xxVSe9ddP+8ZfW9lnr3T3Bgc5rRcOqHO7
         EJAhpXzQVQJ/w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4STXnB2FFqz9rxM;
        Mon, 13 Nov 2023 16:06:06 +0100 (CET)
From:   Charalampos Mitrodimas <charmitro@posteo.net>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH 5/8] staging: sm750fb: Rename sii164EnableHotPlugDetection to sii164_enable_hot_plug_detection
Date:   Mon, 13 Nov 2023 15:05:10 +0000
Message-Id: <20231113150512.1210869-6-charmitro@posteo.net>
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
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index c12df1f9fb00..1ce44c50617a 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -21,7 +21,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.reset_chip = sii164_reset_chip,
 		.get_chip_string = sii164_get_chip_string,
 		.set_power = sii164_set_power,
-		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
+		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
 		.is_connected = sii164IsConnected,
 		.check_interrupt = sii164CheckInterrupt,
 		.clear_interrupt = sii164ClearInterrupt,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index d0b80b86a4d7..430acc4c2a80 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -329,12 +329,12 @@ void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
 }
 
 /*
- *  sii164EnableHotPlugDetection
+ *  sii164_enable_hot_plug_detection
  *      This function enables the Hot Plug detection.
  *
  *  enableHotPlug   - Enable (=1) / disable (=0) Hot Plug detection
  */
-void sii164EnableHotPlugDetection(unsigned char enableHotPlug)
+void sii164_enable_hot_plug_detection(unsigned char enableHotPlug)
 {
 	unsigned char detectReg;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index c15cd6a5d53b..ea3859a5a430 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -34,7 +34,7 @@ unsigned short sii164_get_device_id(void);
 void sii164_reset_chip(void);
 char *sii164_get_chip_string(void);
 void sii164_set_power(unsigned char powerUp);
-void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
+void sii164_enable_hot_plug_detection(unsigned char enableHotPlug);
 unsigned char sii164IsConnected(void);
 unsigned char sii164CheckInterrupt(void);
 void sii164ClearInterrupt(void);
-- 
2.39.2

