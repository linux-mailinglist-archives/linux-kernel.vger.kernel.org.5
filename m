Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B4479DD56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbjIMBCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjIMBCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:02:22 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68291C3;
        Tue, 12 Sep 2023 18:02:18 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5776089b652so2303777a12.2;
        Tue, 12 Sep 2023 18:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694566937; x=1695171737; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iP1lkvVYjBN+KkdHkwdbL7/nnWbR17dZlHeb1s8O7n4=;
        b=KbHf2qK2SVn/MBDjbhi3YrnmKPWoyhpp9B5+y40kWtGcuYrBUAX2Q9+vL11mvIfmi1
         DZFsCNenaUi7FGjwl+YH1wXir5iwSt6e+bSlItB3yDeo0XkZe2Z20nsIcv6ltsKGZWTe
         MRZxAvP1f7drGWshG0QOMtlJP49BOm7xbUzDyd2BrBMQ18tFIWb7YkoYIxQMPrba+sY3
         aMQ1WlLVcwpnxrV3XyP8A3iUKMZ85nVZvUm60e5ddoIsQcesGI6WXgxAJITBTrWtQqk1
         RwZ6scRb2GRly2KcHuYX4MX09llnrcyesPUCwxviCCSv76JyQg5hW523vYLUHYd16YOe
         5V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694566937; x=1695171737;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iP1lkvVYjBN+KkdHkwdbL7/nnWbR17dZlHeb1s8O7n4=;
        b=C0BODmpKuaZGzL2HHhxw+nSjcqbyK6EYAOZkcCwlvUgJVkRzPECDEI/n9quZ+cccJv
         YKjjcZtM02I4gvfhIJAlSLEGfL86ztaYaaKVSxlGaFtBX0tYFL0KIVuxdpZl32Ug5dU6
         3kZeqRdnZAlEmEOsSRZA2QSUU1W6fOFyYdm4g5U1Zk+0t35D7gBBU6VBi9mLCtFjiYDK
         6t5L8Z0jChyDI1/2gbv77ERzWqKiun9ELfULYrH25zB+sIo1nLftCGcIsE0aS0KySAJU
         VjFLfYkNT6ZdMU68FdNvP9Ug6xzZlPRE1a54DDygZp/fd+ZIPf8Tq1ZHKPh5KOSqnbNB
         3Edg==
X-Gm-Message-State: AOJu0YzXxYCz0OnuKk4V/WI22/I/vyjC3YN+EJvkOuLBgdBZl479i4Py
        Ypzc1bGTRqU8a4bZADVyQl2I14c47w3FEQ==
X-Google-Smtp-Source: AGHT+IFN1PhjaXlp3JAOzpJIqkPhljBgbMWen3PGjjdkTkL3ORlcQHP+ND9StB5BT8IMPAYJA6wFWw==
X-Received: by 2002:a05:6a20:7d85:b0:13a:12c2:359e with SMTP id v5-20020a056a207d8500b0013a12c2359emr1424023pzj.2.1694566937349;
        Tue, 12 Sep 2023 18:02:17 -0700 (PDT)
Received: from midnight ([2001:8003:6434:b000:c30f:d88d:412c:6e9a])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902748400b001bbb8d5166bsm9102235pll.123.2023.09.12.18.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 18:02:16 -0700 (PDT)
Date:   Wed, 13 Sep 2023 11:02:13 +1000
From:   Angus Gardner <angusg778@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: Removed unnecessary parenthesis around
 conditions to comply with the checkpatch coding style.
Message-ID: <ZQEKFR1OPoXGI2lO@midnight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/staging/fbtft/fb_ra8875.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 398bdbf53c9a..658f915b8528 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -50,7 +50,7 @@ static int init_display(struct fbtft_par *par)
 
 	par->fbtftops.reset(par);
 
-	if ((par->info->var.xres == 320) && (par->info->var.yres == 240)) {
+	if (par->info->var.xres == 320 && par->info->var.yres == 240) {
 		/* PLL clock frequency */
 		write_reg(par, 0x88, 0x0A);
 		write_reg(par, 0x89, 0x02);
@@ -74,8 +74,7 @@ static int init_display(struct fbtft_par *par)
 		write_reg(par, 0x1D, 0x0E);
 		write_reg(par, 0x1E, 0x00);
 		write_reg(par, 0x1F, 0x02);
-	} else if ((par->info->var.xres == 480) &&
-		   (par->info->var.yres == 272)) {
+	} else if (par->info->var.xres == 480 && par->info->var.yres == 272) {
 		/* PLL clock frequency  */
 		write_reg(par, 0x88, 0x0A);
 		write_reg(par, 0x89, 0x02);
@@ -99,8 +98,7 @@ static int init_display(struct fbtft_par *par)
 		write_reg(par, 0x1D, 0x07);
 		write_reg(par, 0x1E, 0x00);
 		write_reg(par, 0x1F, 0x09);
-	} else if ((par->info->var.xres == 640) &&
-		   (par->info->var.yres == 480)) {
+	} else if (par->info->var.xres == 640 && par->info->var.yres == 480) {
 		/* PLL clock frequency */
 		write_reg(par, 0x88, 0x0B);
 		write_reg(par, 0x89, 0x02);
@@ -124,8 +122,7 @@ static int init_display(struct fbtft_par *par)
 		write_reg(par, 0x1D, 0x0E);
 		write_reg(par, 0x1E, 0x00);
 		write_reg(par, 0x1F, 0x01);
-	} else if ((par->info->var.xres == 800) &&
-		   (par->info->var.yres == 480)) {
+	} else if (par->info->var.xres == 800 && par->info->var.yres == 480) {
 		/* PLL clock frequency */
 		write_reg(par, 0x88, 0x0B);
 		write_reg(par, 0x89, 0x02);
-- 
2.40.1

