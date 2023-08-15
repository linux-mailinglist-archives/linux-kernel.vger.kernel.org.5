Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDCD77D266
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbjHOStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbjHOStS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:49:18 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B582128;
        Tue, 15 Aug 2023 11:48:46 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76c9334baedso349823385a.2;
        Tue, 15 Aug 2023 11:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692125269; x=1692730069;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUkzcxBX95ON8ima77ZDNX4N/ymonVr14GMExOANhWY=;
        b=iHGlzigdgqt6qKcO8L2bAwYQ4Cy5pru4TkmMhTcq3R17uOZ04fmH3bl20knmRW+KGg
         1Yuo5ng8p3f+cu5Sq/w7aBPdxN9KL3llETkyZhnT7YqbjMcDO2Lj0w3/negM7M3LnDi1
         EhW+ZKcIcvEFE01IZgtGaMBtmHNfge+YMq9mRt7zk+Q2YO/dqZwXJva2VDjfYYpizBxA
         imSKhkGUO5kWf2qYFp62uytwSy8GaqDbcMnYXOemiy5FEOW+6+dPziKOTuQ0RLWAlKfl
         KfPxVi8zsL/uLJdYtN3fdSYwnW2urInybyyx5D61/5owmraXlrR2z6rC+l4WcCbGMdcO
         kzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692125269; x=1692730069;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUkzcxBX95ON8ima77ZDNX4N/ymonVr14GMExOANhWY=;
        b=b3/GVgq3GUkY/PDlZhfNh/3I+SXmickGa5+XgqTmRTvj8Sh93+yiYqq7qhHYS9UDl2
         eg6Wx2mdxZ9350Ob8U0Qw19Wsxu09SXuozQzXzTYUl9yLLtnM8KTn0Vj+0Ej3ifJvvzE
         /gCMYhpXA+o9fFgPf08/MCPRUetUCbLI+7CywA3iwqAxqvLpUeYzrVhd9WZc+OYkB3YM
         fRDN2jJ1n+Wga+ox7Al/8LkHcaauI+Wy7TzTvseJjMpiAiI4S3oSTi73WT3jLxFIUhPz
         QPwARFLx72VESABeyaKLQCUAGN0UOWc9yr7OoUZlx/o5laomJbhczhK5keWu/c+D0lKP
         Cpyw==
X-Gm-Message-State: AOJu0Yx0SavbnMk0SXdYuznEDQWN8mzt+D9qc8IgvrVJzQd2110bqIm+
        N1R5fh0D/r25RY5mb+9NWnY=
X-Google-Smtp-Source: AGHT+IEzV3XMrb+VmuEwpjkCjCeeSMB6T6VsfFi+bAY0WBPO1p+q8OcjVcQZw6AWErfBf8iettWlDA==
X-Received: by 2002:a05:620a:2807:b0:76d:3272:ab42 with SMTP id f7-20020a05620a280700b0076d3272ab42mr15387824qkp.9.1692125269007;
        Tue, 15 Aug 2023 11:47:49 -0700 (PDT)
Received: from abdel (bras-base-ktnron0692w-grc-13-174-95-13-129.dsl.bell.ca. [174.95.13.129])
        by smtp.gmail.com with ESMTPSA id m19-20020ae9e013000000b0076745f352adsm3898261qkk.59.2023.08.15.11.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:47:48 -0700 (PDT)
Date:   Tue, 15 Aug 2023 14:47:41 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: [PATCH v2] staging: sm750fb: fix sii164InitChip function name
Message-ID: <ZNvITXcfVwpJAh6y@abdel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Changes in v2:
  -Fix alignment mismatch with open parenthesis

 drivers/staging/sm750fb/ddk750_dvi.c    |  2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 22 +++++++++++-----------
 drivers/staging/sm750fb/ddk750_sii164.h | 20 ++++++++++----------
 3 files changed, 22 insertions(+), 22 deletions(-)

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
index 3da1796cd7aa..2532b60245ac 100644
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
@@ -118,16 +118,16 @@ unsigned short sii164GetDeviceID(void)
  *      0   - Success
  *     -1   - Fail.
  */
-long sii164InitChip(unsigned char edge_select,
-		    unsigned char bus_select,
-		    unsigned char dual_edge_clk_select,
-		    unsigned char hsync_enable,
-		    unsigned char vsync_enable,
-		    unsigned char deskew_enable,
-		    unsigned char deskew_setting,
-		    unsigned char continuous_sync_enable,
-		    unsigned char pll_filter_enable,
-		    unsigned char pll_filter_value)
+long sii164_init_chip(unsigned char edge_select,
+		      unsigned char bus_select,
+		      unsigned char dual_edge_clk_select,
+		      unsigned char hsync_enable,
+		      unsigned char vsync_enable,
+		      unsigned char deskew_enable,
+		      unsigned char deskew_setting,
+		      unsigned char continuous_sync_enable,
+		      unsigned char pll_filter_enable,
+		      unsigned char pll_filter_value)
 {
 	unsigned char config;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index ca330f6a43e2..71a7c1cb42c4 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -16,16 +16,16 @@ enum sii164_hot_plug_mode {
 };
 
 /* Silicon Image SiI164 chip prototype */
-long sii164InitChip(unsigned char edgeSelect,
-		    unsigned char busSelect,
-		    unsigned char dualEdgeClkSelect,
-		    unsigned char hsyncEnable,
-		    unsigned char vsyncEnable,
-		    unsigned char deskewEnable,
-		    unsigned char deskewSetting,
-		    unsigned char continuousSyncEnable,
-		    unsigned char pllFilterEnable,
-		    unsigned char pllFilterValue);
+long sii164_init_chip(unsigned char edgeSelect,
+		      unsigned char busSelect,
+		      unsigned char dualEdgeClkSelect,
+		      unsigned char hsyncEnable,
+		      unsigned char vsyncEnable,
+		      unsigned char deskewEnable,
+		      unsigned char deskewSetting,
+		      unsigned char continuousSyncEnable,
+		      unsigned char pllFilterEnable,
+		      unsigned char pllFilterValue);
 
 unsigned short sii164_get_vendor_id(void);
 unsigned short sii164GetDeviceID(void);
-- 
2.34.1

