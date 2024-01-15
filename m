Return-Path: <linux-kernel+bounces-25575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9332282D2E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 401F0B20B78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A886215B1;
	Mon, 15 Jan 2024 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ysadX/VG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890761374;
	Mon, 15 Jan 2024 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=D498tm+X6eWH0ctrJ+yamEEYIoJnR90IzdsjGrMUKE8=; b=ysadX/VGgWgF3M/iBZpywxqN8I
	2uAgx8YuLm139/LNslclVL+uIUHCjn65iOhGfxzDhLsuiwcLHmxGLW5Z924LrXBSkHApCRxZiU5eU
	herpioouI8OhMrWX/pQuUCeyFQBaoGFPVIWZ7q6Kt4KsyX3H3q4MUNaHJDOwfaKRjPYNptWQeWMz2
	gD/2ZUPZkcgYsQB5SkLRLjPPwTpO4ZfdwX1KGZxXH6opVBYtyAlgp2z3Rw6TPXUNS2Bjw79+gx6Wm
	IXdFyAPD/4LBi5EtGMVhD2fV1LoI2idiRHpDxg7TdVQ8H6riFNN9tw+TbANKGjXDz3GU+DbOmvlK1
	JfJDi51Q==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPBLq-007Zjo-0z;
	Mon, 15 Jan 2024 01:01:18 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Hongbo Zhang <hongbo.zhang@stericsson.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal: db8500: remove kernel-doc notation from data
Date: Sun, 14 Jan 2024 17:01:17 -0800
Message-ID: <20240115010117.8383-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't mark data with a "/**" comment. kernel-doc does not support
documenting data definitions. This change prevents a kernel-doc
warning.

db8500_thermal.c:27: warning: cannot understand function prototype: 'const unsigned long db8500_thermal_points[] = '

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Hongbo Zhang <hongbo.zhang@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/thermal/db8500_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -20,7 +20,7 @@
 #define PRCMU_DEFAULT_MEASURE_TIME	0xFFF
 #define PRCMU_DEFAULT_LOW_TEMP		0
 
-/**
+/*
  * db8500_thermal_points - the interpolation points that trigger
  * interrupts
  */

