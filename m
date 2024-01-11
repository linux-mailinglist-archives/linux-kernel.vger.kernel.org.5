Return-Path: <linux-kernel+bounces-23060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B44A82A6F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 05:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4671C230B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F8D1FB0;
	Thu, 11 Jan 2024 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aGt9xoNa"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E417D4;
	Thu, 11 Jan 2024 04:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PNGr7mm7W6jEYqSL7CGorGDhPjZNBHJ1TG0EblhInQw=; b=aGt9xoNaOOH0v5qI+JviYeT10y
	mZxrFvCCOI7G3s9QmnInPJKIwyrd9HCCZZRg/XHdrOraIxouADtmztks0oLCQGuQ81GQHYAmGZMqd
	bUhgXLImFlI/WOM+bR1VpoKljQj6gjYN0jHJk8SXF8swbIVAJrZMNL1a3s5hveCDBOwgQivhO2q2O
	d4qcrzVHqEMhk3zylS4U3miBPrU7rfm/QG1APWUXGlQq/27+sRATOGeBJNjVGaKg3zVJjR9Mm7G9d
	xC5xyCErXi+/3adaTf8kkEgKcmkLSXnCwULT6/7dlYos5AgSNe84VbILm7goulfPhvHtPc5RBwwnW
	n0JN38EA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNmkZ-00FoQb-0u;
	Thu, 11 Jan 2024 04:33:03 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org
Subject: [PATCH] media: i2c: ar0521: fix spellos
Date: Wed, 10 Jan 2024 20:33:01 -0800
Message-ID: <20240111043302.15641-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix spelling mistakes as reported by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Krzysztof Hałasa <khalasa@piap.pl>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-media@vger.kernel.org
---
 drivers/media/i2c/ar0521.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/drivers/media/i2c/ar0521.c b/drivers/media/i2c/ar0521.c
--- a/drivers/media/i2c/ar0521.c
+++ b/drivers/media/i2c/ar0521.c
@@ -314,7 +314,7 @@ static void ar0521_calc_pll(struct ar052
 	 * In the clock tree:
 	 * MIPI_CLK = PIXEL_CLOCK * bpp / 2 / 2
 	 *
-	 * Generic pixel_rate to bus clock frequencey equation:
+	 * Generic pixel_rate to bus clock frequency equation:
 	 * MIPI_CLK = V4L2_CID_PIXEL_RATE * bpp / lanes / 2
 	 *
 	 * From which we derive the PIXEL_CLOCK to use in the clock tree:
@@ -327,7 +327,7 @@ static void ar0521_calc_pll(struct ar052
 	 *
 	 * TODO: in case we have less data lanes we have to reduce the desired
 	 * VCO not to exceed the limits specified by the datasheet and
-	 * consequentially reduce the obtained pixel clock.
+	 * consequently reduce the obtained pixel clock.
 	 */
 	pixel_clock = AR0521_PIXEL_CLOCK_RATE * 2 / sensor->lane_count;
 	bpp = ar0521_code_to_bpp(sensor);
@@ -806,7 +806,7 @@ static const struct initial_reg {
 	REGS(be(0x3F00),
 	     be(0x0017),  /* 3F00: BM_T0 */
 	     be(0x02DD),  /* 3F02: BM_T1 */
-	     /* 3F04: if Ana_gain less than 2, use noise_floor0, multipl */
+	     /* 3F04: if Ana_gain less than 2, use noise_floor0, multiply */
 	     be(0x0020),
 	     /* 3F06: if Ana_gain between 4 and 7, use noise_floor2 and */
 	     be(0x0040),

