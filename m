Return-Path: <linux-kernel+bounces-4186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3452A8178F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040961C25418
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFD572071;
	Mon, 18 Dec 2023 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1iYIqPT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD75E5D758;
	Mon, 18 Dec 2023 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e2bd8c396so2410919e87.0;
        Mon, 18 Dec 2023 09:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921259; x=1703526059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4czKecRr4zUiqvQxmuxZf3Bt0qVxMHQuUS2sRj3gQ9o=;
        b=C1iYIqPTprmgc3srMBvzf+1LlOOCtfy1qNb8XLA+RoGDnAyPrPcuhfHw28bHgB8xSY
         +2bTZqTkpGqCqLCq7yE9wzO7E3AWKkd8283uohkM5KKUm61Qvd60StIepgfhYO4Wad4y
         UkoaavQ8sE+LBDNK7uCckL6/X7G2tlVDedEeDdGud5q+fL8siPEbv45MiZNBmyeki7+S
         1TRPwf7EFpm/i/No26Kpc6GVPT8uk+bA0yMVr4s3Dx+MwHDMhh0cWMYAu8+Twae43BiI
         ko8e4iqisY+v5Ke/vPR07UiQbKQGKWWUeX/YLVA15QUcYJarhR8AIlLdprBpx6MEG0pD
         x9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921259; x=1703526059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4czKecRr4zUiqvQxmuxZf3Bt0qVxMHQuUS2sRj3gQ9o=;
        b=cKKXg2oa7Dw/rK/69pxSAx5IivYBwRmSBrh0e5LE7UeAaO+q+UJ7rQH41Gftc17doQ
         NFnVZ6RvnUVOpaEN4KopQFbnwIphfEI0bwp4kP1RfFJ3Mq79ROCoLWvk2GqqNpJ4yF4e
         HceQfcFGU43SyCU0dhOIZkSaXkzfZQ0AOQmj+9m5x7OZjCbC0X7Bqfaz/PdxiVvVaLq+
         ZVYd9Is+CxLi8F26tjvuTwgq2N+hxE6IhqcMJhVboXKQ5FFkZ0OOToRbRl3hQxN0pLDS
         HxbfJ8AG7YrQpzz4w+/s5j166UdMG6nMtHsLGHAyakZ4rqr/c6hl5EqH8NbsRnjIhUPg
         RI+Q==
X-Gm-Message-State: AOJu0YyUqi9wl1wzpkZN+oouHBocuw+DkvOWTvguxNSu3MXNNYemxI7N
	wgLKifON83DSup2BRkz+/fX4Dt3u5OSfSg==
X-Google-Smtp-Source: AGHT+IF4lP7MpuXlO75JEsjQJQGiM5DfUKgEoAQdcHqU26QULwmPYfDFq1YYAWU3s8IVdwpnwkLHig==
X-Received: by 2002:ac2:5f7c:0:b0:50e:2275:59bb with SMTP id c28-20020ac25f7c000000b0050e227559bbmr2351376lfc.44.1702921258994;
        Mon, 18 Dec 2023 09:40:58 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id dx6-20020a0565122c0600b0050e3cd7444asm226006lfb.15.2023.12.18.09.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:40:58 -0800 (PST)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v2 02/20] media: i2c: ov4689: Sort register definitions by address
Date: Mon, 18 Dec 2023 20:40:23 +0300
Message-ID: <20231218174042.794012-3-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218174042.794012-1-mike.rudenko@gmail.com>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Put register defininitions in the order of increasing register
address.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index ff5213862974..1ae6d9b9c9b3 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -19,15 +19,15 @@
 #include <media/v4l2-subdev.h>
 #include <media/v4l2-fwnode.h>
 
-#define CHIP_ID				0x004688
-#define OV4689_REG_CHIP_ID		0x300a
-
 #define OV4689_XVCLK_FREQ		24000000
 
 #define OV4689_REG_CTRL_MODE		0x0100
 #define OV4689_MODE_SW_STANDBY		0x0
 #define OV4689_MODE_STREAMING		BIT(0)
 
+#define OV4689_REG_CHIP_ID		0x300a
+#define CHIP_ID				0x004688
+
 #define OV4689_REG_EXPOSURE		0x3500
 #define OV4689_EXPOSURE_MIN		4
 #define OV4689_EXPOSURE_STEP		1
@@ -41,12 +41,12 @@
 #define OV4689_GAIN_STEP		1
 #define OV4689_GAIN_DEFAULT		0x80
 
+#define OV4689_REG_VTS			0x380e
+
 #define OV4689_REG_TEST_PATTERN		0x5040
 #define OV4689_TEST_PATTERN_ENABLE	0x80
 #define OV4689_TEST_PATTERN_DISABLE	0x0
 
-#define OV4689_REG_VTS			0x380e
-
 #define REG_NULL			0xFFFF
 
 #define OV4689_REG_VALUE_08BIT		1
-- 
2.43.0


