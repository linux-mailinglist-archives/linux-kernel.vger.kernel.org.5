Return-Path: <linux-kernel+bounces-25555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE882D294
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0B51F213AD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 23:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B902C686;
	Sun, 14 Jan 2024 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uCt225ef"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C52C680;
	Sun, 14 Jan 2024 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=eMAehrgdOex157gcLIzKgIOwhrQ8V1YSfEKTBwqKato=; b=uCt225eflj2P3CxFEEs4l2+Q8d
	5gmB86zPZ3b4r7l+unS32A0UUt4w1ixOSWvtlY82S/YKkL4WOrPeilKM6bvWMpu95wOTT23HuGfLR
	t8qy0Mc21OavxXXVlEnbj3jltGGScd1Z5mSWcVAtrj0y50vPUUbz4Znlk39Q022W9uF8FuVmZaYMO
	Jqy3oaWB+Btvw+MT5fvrTLSWJneO1w1Ldg3di+5xOH1BzPfe7vuNm9yCOLfA10Fbmk1tbIqfPbevc
	v0D30wyizRHZ5wUIZvY79CK1SQYzy95YulqMdefKj41bZWRViSOcxte8rZE9JhV1fmscZ7KEH/+pq
	ETtBUWSw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rP9fN-007UEI-03;
	Sun, 14 Jan 2024 23:13:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: ac100: remove misuses of kernel-doc
Date: Sun, 14 Jan 2024 15:13:20 -0800
Message-ID: <20240114231320.31437-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent kernel-doc warnings by changing "/**" to common comment
format "/*" in non-kernel-doc comments:

drivers/rtc/rtc-ac100.c:103: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Clock controls for 3 clock output pins
drivers/rtc/rtc-ac100.c:382: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * RTC related bits

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org
---
 drivers/rtc/rtc-ac100.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -99,7 +99,7 @@ struct ac100_rtc_dev {
 	struct clk_hw_onecell_data *clk_data;
 };
 
-/**
+/*
  * Clock controls for 3 clock output pins
  */
 
@@ -378,7 +378,7 @@ static void ac100_rtc_unregister_clks(st
 	clk_unregister_fixed_rate(chip->rtc_32k_clk->clk);
 }
 
-/**
+/*
  * RTC related bits
  */
 static int ac100_rtc_get_time(struct device *dev, struct rtc_time *rtc_tm)

