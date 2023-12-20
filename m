Return-Path: <linux-kernel+bounces-6454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA7A81991D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3F31C25227
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050AB15AF8;
	Wed, 20 Dec 2023 07:08:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out198-173.us.a.mail.aliyun.com (out198-173.us.a.mail.aliyun.com [47.90.198.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499713ACF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=cyg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjterm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07452829|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0367338-0.0107246-0.952542;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.VoiN-3D_1703056120;
Received: from localhost(mailfrom:fuyao@sjterm.com fp:SMTPD_---.VoiN-3D_1703056120)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 15:08:41 +0800
Date: Wed, 20 Dec 2023 15:08:40 +0800
From: fuyao <fuyao1697@cyg.com>
To: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	maijianzhang <maijianzhang@allwinnertech.com>
Subject: [PATCH RESEND] iio: adc: sun4i-gpadc-iio: adaptation interrupt number
Message-ID: <YwdhTlk+7h+FMrwm@scg>
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
Acked-by:  Jernej Skrabec <jernej.skrabec@gmail.com>
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


-- 
Technology is exciting

From mboxrd@z Thu Jan  1 00:00:00 1970
Return-Path: <linux-arm-kernel-bounces+linux-arm-kernel=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BEFC04AA5
	for <linux-arm-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 11:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=43HWo/ZUnCasly+ZDH2iZ6YziJoEl7DGgRHVq1AWHGA=; b=N4HqsZY4E2SL6r
	coTCsOX2hRzQ7B0a1T00J2VkAPl7AipXosk76WMzyfIWnLKRkW8uqqBXKpQ2sHn25CKHP+ZW5UpiD
	6l25/vh+YIPuTKjxd22dXb3QWpmIObDbHRRIOZSAWMBva+k42rsgsfgRyYKOI/+fBRoqDqFZHrjV1
	LbiROW7b0SqMq6vAWAjGQvRON+qQDsqqpadEY+j508ViyVZdDIB2TY1zdy6uTAc4QqMRmzUH2NP7W
	eSzjr4Kd1dtJMmykNtjjlIm/7IPwpXbHb72IdX1lzo27891mjNCP6V6fToGXw+s5RFS1qHaRuZ+XB
	8g9p7pCDPqH/9eUb74/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRBPm-00D1Ka-Ur; Thu, 25 Aug 2022 11:52:51 +0000
Received: from out20-123.mail.aliyun.com ([115.124.20.123])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRBPk-00D1FB-2p
	for linux-arm-kernel@lists.infradead.org; Thu, 25 Aug 2022 11:52:49 +0000
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3045855|-1;BR=01201311R131S89rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.025949-0.00105542-0.972996;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.P.m81RD_1661428046;
Received: from localhost(mailfrom:fuyao@sjterm.com fp:SMTPD_---.P.m81RD_1661428046)
          by smtp.aliyun-inc.com;
          Thu, 25 Aug 2022 19:47:26 +0800
Date: Thu, 25 Aug 2022 19:47:26 +0800
From: fuyao <fuyao1697@cyg.com>
To: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	maijianzhang <maijianzhang@allwinnertech.com>
Subject: [PATCH] iio: adc: sun4i-gpadc-iio: adaptation interrupt number
Message-ID: <YwdhTlk+7h+FMrwm@scg>
Mail-Followup-To: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	maijianzhang <maijianzhang@allwinnertech.com>
MIME-Version: 1.0
Content-Disposition: inline
Organization: work_work_work
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_045248_320501_10DAB7D1 
X-CRM114-Status: UNSURE (   9.15  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=archiver.kernel.org@lists.infradead.org

__platform_get_irq_byname determinies whether the interrupt
number is 0 and returns EINVAL.

Signed-off-by: fuyao <fuyao1697@cyg.com>
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


-- 
Technology is exciting

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
CYG Technology.

