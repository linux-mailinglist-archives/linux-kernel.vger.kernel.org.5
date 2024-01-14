Return-Path: <linux-kernel+bounces-25405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F3582CFD3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 06:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D308282FF7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8FF1848;
	Sun, 14 Jan 2024 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4RvBwUxn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA57E;
	Sun, 14 Jan 2024 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PzOpUmwBdQyN8LMxGGlblOE7kAHx3tOgseXWQh8nflI=; b=4RvBwUxnW3k5pW8bqEpheN9t9w
	NBsMvoiuGiSbupk3Bg5ul2y1T3ZsbjO8jBUNbsZHabrJvpvuo7Q3sMbgNRjI04/PNExV2tqqbByBL
	hzV/iF6Q171c/UTdnfll5G4z3CbtY6hfQc1IHK4vdHuOWuDthjA9g82+TKSF3SQr9wOuZME7wC4WL
	JVb5m9WD3Tgakbv/Qfp51trE46Pj62svfRIL7ZT2Dx6MqBVQLultphBebv4JcRCxoiv4YvF+IL4Tx
	wVAq0ZR0AN5yGNVTBBZL0WxMaHNvrcXgAiMRnFtY0dZG+3WyElLwXzoHOUW+eeQtyuPtPKbXG0/af
	vpledeHQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rOt2G-006Cyw-1B;
	Sun, 14 Jan 2024 05:27:54 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	patches@armlinux.org.uk,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH] ARM: s5pv210: fix pm.c kernel-doc warning
Date: Sat, 13 Jan 2024 21:27:51 -0800
Message-ID: <20240114052751.17242-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct function name in the kernel-doc comment to prevent
a kernel-doc warning:

arch/arm/mach-s5pv210/pm.c:61: warning: expecting prototype for s3c_pm_do_restore(). Prototype was for s3c_pm_do_restore_core() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: patches@armlinux.org.uk
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-s5pv210/pm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -47,7 +47,7 @@ static void s3c_pm_do_save(struct sleep_
 }
 
 /**
- * s3c_pm_do_restore() - restore register values from the save list.
+ * s3c_pm_do_restore_core() - restore register values from the save list.
  * @ptr: Pointer to an array of registers.
  * @count: Size of the ptr array.
  *

