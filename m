Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16CE7E9F90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjKMPG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjKMPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:06:14 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE44171C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:06:10 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 40B9024002B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 16:06:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1699887969; bh=+0firMEs8jGDnwurQSwdedi7SuSTkZP4QKZILe7SstQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=cZTlFL/0STVCQhNkdzXzcVbpju767yxMPdu7HsF4yEc4ysIMfmUitmsJFX/tdF9Vh
         4+h5nfS6C5se+tccwzgDiWeTlLJ8yX5TDQOADpFdFaW40RzODxSKc6MwJl287PF66e
         nOcVcQg9o44pkgkGIt5qcxLfYTDn1/6vi8c6R8+EkUkSUpg6iN8+HYrEUm3JmU+/6K
         RPyU4RZ62rgqg3OpGwYA3q/yk4kQqAS6v1sGH4eQchsuEZmXLrBE+YXBs4wk7XZM6h
         flBgGZcTU2SJ5ElmOZHkIJuHOsgAiPfpP2+KOFTKFISl9p/TcioQ7WS+PEr68qqdMI
         0arY8pS97rkVQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4STXnC3t5Fz9rxS;
        Mon, 13 Nov 2023 16:06:07 +0100 (CET)
From:   Charalampos Mitrodimas <charmitro@posteo.net>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH 6/8] staging: sm750fb: Rename sii164IsConnected to sii164_is_connected
Date:   Mon, 13 Nov 2023 15:05:11 +0000
Message-Id: <20231113150512.1210869-7-charmitro@posteo.net>
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
index 1ce44c50617a..ac1aab77da28 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -22,7 +22,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.get_chip_string = sii164_get_chip_string,
 		.set_power = sii164_set_power,
 		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
-		.is_connected = sii164IsConnected,
+		.is_connected = sii164_is_connected,
 		.check_interrupt = sii164CheckInterrupt,
 		.clear_interrupt = sii164ClearInterrupt,
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 430acc4c2a80..24f40db0dfcf 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -350,14 +350,14 @@ void sii164_enable_hot_plug_detection(unsigned char enableHotPlug)
 }
 
 /*
- *  sii164IsConnected
+ *  sii164_is_connected
  *      Check if the DVI Monitor is connected.
  *
  *  Output:
  *      0   - Not Connected
  *      1   - Connected
  */
-unsigned char sii164IsConnected(void)
+unsigned char sii164_is_connected(void)
 {
 	unsigned char hotPlugValue;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index ea3859a5a430..f8689bb3e1d5 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -35,7 +35,7 @@ void sii164_reset_chip(void);
 char *sii164_get_chip_string(void);
 void sii164_set_power(unsigned char powerUp);
 void sii164_enable_hot_plug_detection(unsigned char enableHotPlug);
-unsigned char sii164IsConnected(void);
+unsigned char sii164_is_connected(void);
 unsigned char sii164CheckInterrupt(void);
 void sii164ClearInterrupt(void);
 #endif
-- 
2.39.2

