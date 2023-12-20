Return-Path: <linux-kernel+bounces-6562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D67819A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F643283216
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ECA1A59E;
	Wed, 20 Dec 2023 08:24:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out28-84.mail.aliyun.com (out28-84.mail.aliyun.com [115.124.28.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF0F199AB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=cyg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjterm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.261246|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.028598-0.00112938-0.970273;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.Voiv2io_1703056997;
Received: from localhost(mailfrom:fuyao@sjterm.com fp:SMTPD_---.Voiv2io_1703056997)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 15:23:18 +0800
Date: Wed, 20 Dec 2023 15:23:17 +0800
From: fuyao <fuyao1697@cyg.com>
To: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	maijianzhang <maijianzhang@allwinnertech.com>
Subject: [PATCH RESEND] iio: adc: sun4i-gpadc-iio: adaptation interrupt number
Message-ID: <YwdhTlk+9h+9Mrwm@scg>
Mail-Followup-To: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	maijianzhang <maijianzhang@allwinnertech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxmR5SPPY18O7LaG@google.com>
Received: from out20-218.mail.aliyun.com (out20-218.mail.aliyun.com
 [115.124.20.218]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384
 (256/256 bits)) (No client certificate requested) by
 smtp.subspace.kernel.org (Postfix) with ESMTPS id 103EC2F28 for
 <linux-sunxi@lists.linux.dev>; Thu, 25 Aug 2022 12:18:23 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3045855|-1;BR=01201311R131S89rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.025949-0.00105542-0.972996;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.P.m81RD_1661428046;
Received: from localhost(mailfrom:fuyao@sjterm.com
 fp:SMTPD_---.P.m81RD_1661428046) by smtp.aliyun-inc.com; Thu, 25 Aug 2022
 19:47:26 +0800
Precedence: bulk
Organization: work_work_work
Organization: work_work_work

__platform_get_irq_byname determinies whether the interrupt
number is 0 and returns EINVAL.

Signed-off-by: fuyao <fuyao1697@cyg.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 include/linux/mfd/sun4i-gpadc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index ea0ccf33a459..021f820f9d52 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -81,8 +81,8 @@
 #define SUN4I_GPADC_TEMP_DATA				0x20
 #define SUN4I_GPADC_DATA				0x24
 
-#define SUN4I_GPADC_IRQ_FIFO_DATA			0
-#define SUN4I_GPADC_IRQ_TEMP_DATA			1
+#define SUN4I_GPADC_IRQ_FIFO_DATA			1
+#define SUN4I_GPADC_IRQ_TEMP_DATA			2
 
 /* 10s delay before suspending the IP */
 #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
-- 
2.32.0


