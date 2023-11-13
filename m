Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9285B7E9F92
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjKMPGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjKMPGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:06:22 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9281729
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:06:12 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4CEE8240103
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 16:06:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1699887971; bh=4NebyzUyVtbmcvuHG+8RjZVCYeuNv+9wPzrDKVbjtKw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=mTunSV70FDdYw/piyL63FrxU1EQod/a74D/bqgD//gv6hwvkid0pnIUpkkRNgPhJ9
         ignk4/d4G4ca1wJexrAmcs/vZMSYOTe/R+t7g61wWaeZUL7PYHj6Xcukf8j04pencJ
         rHU3nIG/6Ul75N7ayigL08zApHuB/zYaXdfLTusyhcBu/aE357elGa6cvStsLZb2qn
         v1xdRfsX8MPlXaUj4bPV0Q5BMKO/Z6dvXHhPZpfDsNN9SjCmpDdOPvD3htVSlbUHmo
         G+XCCYD5s7IIs3WAfW321UMRRDU22t6UHh0peiekJQOmU0eYurlWMAdmv+vHnXDCGh
         UUQB/7ACuAb5g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4STXnG0PHPz9rxh;
        Mon, 13 Nov 2023 16:06:09 +0100 (CET)
From:   Charalampos Mitrodimas <charmitro@posteo.net>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH 8/8] staging: sm750fb: Rename sii164ClearInterrupt to sii164_clear_interrupt
Date:   Mon, 13 Nov 2023 15:05:13 +0000
Message-Id: <20231113150512.1210869-9-charmitro@posteo.net>
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
index 1def02be4cce..6fef1ab484c1 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -24,7 +24,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
 		.is_connected = sii164_is_connected,
 		.check_interrupt = sii164_check_interrupt,
-		.clear_interrupt = sii164ClearInterrupt,
+		.clear_interrupt = sii164_clear_interrupt,
 #endif
 	},
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index b156a727bebf..d6bfd7c4eaba 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -390,10 +390,10 @@ unsigned char sii164_check_interrupt(void)
 }
 
 /*
- *  sii164ClearInterrupt
+ *  sii164_clear_interrupt
  *      Clear the hot plug interrupt.
  */
-void sii164ClearInterrupt(void)
+void sii164_clear_interrupt(void)
 {
 	unsigned char detectReg;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 33351f6d7f11..005473ca20cd 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -37,7 +37,7 @@ void sii164_set_power(unsigned char powerUp);
 void sii164_enable_hot_plug_detection(unsigned char enableHotPlug);
 unsigned char sii164_is_connected(void);
 unsigned char sii164_check_interrupt(void);
-void sii164ClearInterrupt(void);
+void sii164_clear_interrupt(void);
 #endif
 /*
  * below register definition is used for
-- 
2.39.2

