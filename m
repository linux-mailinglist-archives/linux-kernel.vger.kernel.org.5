Return-Path: <linux-kernel+bounces-165084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A758B878D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8754B1F216A4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5A5524DD;
	Wed,  1 May 2024 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dOB8pKST"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39CE51C40;
	Wed,  1 May 2024 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555204; cv=none; b=oeBWt2gcfib0VKxiLVD/z5fPOz3gb0I00jsHmdTmu1J+UuZ7h3CMdaZ4WKkscXSEzrNXRbjCyS7EjmPJXJn0ZbNXhH/SnAHVWG7JRUDOTwrv4jJcf8Pq+ZX7TdgBbb2tpoIzYVX4U5NSRFce1Fw1/UIMYw88mtB+UKQajQfCvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555204; c=relaxed/simple;
	bh=toE93QySheBfyF02XRIVOBlqg4D+U5lZNaG+/pvnFcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CwTjQji6ARcn/wPV4PVrSBbZHuucLt8FdtvoA2K2+cX+WVcZ80HVy/qSktUEW9L19syvet3tdNRvpovfp7RVOS0uYuqBrrepnuMSXwBcCyHsLlNP7fy6eTElOIPejh+FdfD643F/iXf7XffTAlz53yF31zgutCEw6EXKW4pxMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dOB8pKST; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 267zszaB9n00P267zs1vYS; Wed, 01 May 2024 11:19:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714555193;
	bh=Xesjsh9zXqKwK5RBVsmOk430OrjLqZlImsK09mLqsu4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=dOB8pKSTbrotF/JpCqwczO3LP3h6y8xgMnF2uKE0pzcECqPQj5IwdndJXt/w5LZ1H
	 XSQNK9ikSOPtQ4DQl5U4r81sDMmRa9VfjG+sebU9v9mEOUWe6DDxNxcwqWmkQZn3L0
	 b2PNUhH+dSRTFCk1UmuDGDqt2mKnAeax91WFyWY401n0eq1LCrE4pS2fx/iXp3F497
	 7g4LVM7Zqi2MvOnAnl5tXDAR7zJgWSbZewXPTdwlCGS4T7ObI1Zga+JqQAOILG1aPB
	 fIwmgRaU6cVyF1vBviirJAXbUN2WN+JNlD0wqtBlk1o2PVUQrkZsPTI78zDWD29vsr
	 9Vo85XBVMskGw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 May 2024 11:19:53 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: temperature: max30208: Remove an unused field in struct max30208_data
Date: Wed,  1 May 2024 11:19:41 +0200
Message-ID: <73f9f540ecdc7c10e833e6fc782324ae7d34ba9c.1714555144.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct max30208_data", the 'indio_dev' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

It was added in the initial commit 9ee95ae4cffd ("iio: temperature: Add
driver support for Maxim MAX30208") but was never used.
---
 drivers/iio/temperature/max30208.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/temperature/max30208.c b/drivers/iio/temperature/max30208.c
index 48be03852cd8..720469f9dc36 100644
--- a/drivers/iio/temperature/max30208.c
+++ b/drivers/iio/temperature/max30208.c
@@ -34,7 +34,6 @@
 
 struct max30208_data {
 	struct i2c_client *client;
-	struct iio_dev *indio_dev;
 	struct mutex lock; /* Lock to prevent concurrent reads of temperature readings */
 };
 
-- 
2.44.0


