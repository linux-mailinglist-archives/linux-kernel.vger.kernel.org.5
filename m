Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7016D77C6C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 06:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjHOEjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 00:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjHOEiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 00:38:51 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13678F4;
        Mon, 14 Aug 2023 21:38:46 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-63d48c3d242so35481626d6.2;
        Mon, 14 Aug 2023 21:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692074325; x=1692679125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vUSlJ1K+YltX3fu0fwuh0HX4VMb0WiCiIqUudwqAsHI=;
        b=Av+4LsG4ZZU6TgMGKe/aUJfcGcY4JNFgEIKy7F0/L2u2R6253lSrAQk0upWXGiv0AL
         Lwfp89+pzCbRyOG6ejURrWN3s5LHgEms85TFwIoq/eNDcna3X5sVOa+ydo/5MC/d5hud
         6Z60XaMHzBPMjJ6mOUE02vqXuN9Dh8hAeFnlNfiP8IUT/z1b+50GCZ/JYV6kKAF0Mrl9
         EnXqnUm9ZrcU9fWAv2iSeD0KnAktVdz8ApIHBO2V7ZV6MccfEp8UJBp3JLarLeusXuQ7
         LzZiVmMfLoGTrIGG94mJVj4LYOHkolLqGk2BPA+WhDyhsR5MQZjBHU7fLAWWRxyj6hTg
         rH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692074325; x=1692679125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUSlJ1K+YltX3fu0fwuh0HX4VMb0WiCiIqUudwqAsHI=;
        b=PCdPKr9gSYaVrFr+utY9icVB+GQEzTlu7znCHMhnPZlhtEL0kiXGYPi0DHH8WE026w
         4KLOFysOT1aLKk6ilY1YXIHpofuNnBSk0w6dKrIKVjxN9GKhBnAlluORZAVkvGVEji9e
         /k9MhbQUSQvsdLZmpSkTiUzNeh2Ua6h6tq0HYZi/6Gxuqj18qJ1d5JxtRrLvtoZbg+4k
         nAgNDO4T0wygQFG7hz3KLxoeGAu8FWF9WXkN0mqkvM37Soh+O2W5zUVe4ffDxfLjX/Iy
         /nkHRK0wnOLsz+IhsrIrnqMIrgozgfrm62HgO/AoM2NR7iYbTot3HUruNyI1CgUI2WVu
         ZcXQ==
X-Gm-Message-State: AOJu0Yy6Mz3qu5b4B74hfnJdh8xdRXBO6wM9DZHbYjzQRgt+ob8QL5MP
        2ud7xJyAIF6HQCry/tyuoHuks2axKsu11A==
X-Google-Smtp-Source: AGHT+IHlRKYII7XNiHTvKhRFpl+U39brmO0LJzBgiLbx8fE8kLkSj0Lwrb5EjbPw5hmZsFns09Ducw==
X-Received: by 2002:a0c:df8a:0:b0:647:2f8f:8c29 with SMTP id w10-20020a0cdf8a000000b006472f8f8c29mr2054378qvl.48.1692074325225;
        Mon, 14 Aug 2023 21:38:45 -0700 (PDT)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id a7-20020a0cb347000000b00630c0ed6339sm3880822qvf.64.2023.08.14.21.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 21:38:44 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-fbdev@vger.kernel.org, Abdel Alkuor <alkuor@gmail.com>
Subject: [PATCH] staging: sm750fb: fix sii164InitChip function name
Date:   Tue, 15 Aug 2023 00:37:59 -0400
Message-Id: <20230815043759.404423-1-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux Kernel coding style. Found by checkpatch.

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index e0c7ff3352bf..8b81e8642f9e 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -14,7 +14,7 @@
 static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 #ifdef DVI_CTRL_SII164
 	{
-		.init = sii164InitChip,
+		.init = sii164_init_chip,
 		.get_vendor_id = sii164_get_vendor_id,
 		.get_device_id = sii164GetDeviceID,
 #ifdef SII164_FULL_FUNCTIONS
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 3da1796cd7aa..d162e1a16584 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -72,7 +72,7 @@ unsigned short sii164GetDeviceID(void)
  */
 
 /*
- *  sii164InitChip
+ *  sii164_init_chip
  *      This function initialize and detect the DVI controller chip.
  *
  *  Input:
@@ -118,7 +118,7 @@ unsigned short sii164GetDeviceID(void)
  *      0   - Success
  *     -1   - Fail.
  */
-long sii164InitChip(unsigned char edge_select,
+long sii164_init_chip(unsigned char edge_select,
 		    unsigned char bus_select,
 		    unsigned char dual_edge_clk_select,
 		    unsigned char hsync_enable,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index ca330f6a43e2..13420bcc282c 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -16,7 +16,7 @@ enum sii164_hot_plug_mode {
 };
 
 /* Silicon Image SiI164 chip prototype */
-long sii164InitChip(unsigned char edgeSelect,
+long sii164_init_chip(unsigned char edgeSelect,
 		    unsigned char busSelect,
 		    unsigned char dualEdgeClkSelect,
 		    unsigned char hsyncEnable,
-- 
2.34.1

