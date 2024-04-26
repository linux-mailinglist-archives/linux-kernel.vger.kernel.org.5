Return-Path: <linux-kernel+bounces-159826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE948B34C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D751F22E19
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987DB1422AE;
	Fri, 26 Apr 2024 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xj+mVmGe"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EE813C9A7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125662; cv=none; b=O1i/x2iDom0LmLhnSbRpHJiwkcYZaugk3L+nMa2scYqI8yRAMUEU5wyHDO7mMiqQjrn1m/nrWmtn8qE7op4fzHULkMF7W6qcp7nG4p2VCpjenSHS6LTXGTuey4NbgbcWdMViXX4Hiy8uu96fXQ8b1qxUxYZshX8ieFm7UO2KWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125662; c=relaxed/simple;
	bh=WcviH6h+CaxLwazpo5nWKABXVxE7UwV2Nz+TkZraABg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Do28bneXmmBWYXnI6NmNPrVHHCFszXN+vL6Uh7DW8rcP+4scTwWOgIlgFjJFMe8PyN4vx828F7t0jWwyScsccb+U3hKARzCOqrOo861rsXgTawEPWBibQnckN3ulW6TLb3tlV2QHnMJOAGBVpAEInyOarDPGN/VyoNWgA4ICDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xj+mVmGe; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714125657; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=71Usgg6qKY4WD/KJLkSdMUhRfDvtMS6SMA1IGXcqwHM=;
	b=Xj+mVmGeD8M0DNWi6s73Aq9ZiVoyFljzW/kvNcuPOYCsyRcxOjbvrEt6PP83mMy9v4gH7TSiKD/s4MsuitvZYNzp90g6W/SjmLoM2eKVMzNysJmk6ZEB/+2G/aAlN4xR0EqAzlk4BIx3exmR/XUA216dKRCdPM9bananAtwcbXg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W5IoWWO_1714125655;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W5IoWWO_1714125655)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 18:00:56 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: myungjoo.ham@samsung.com,
	cw00.choi@samsung.com
Cc: linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] extcon: adc-jack: Document missing struct members
Date: Fri, 26 Apr 2024 18:00:54 +0800
Message-Id: <20240426100054.61506-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds kernel-doc comments for the previously undocumented
members `dev` and `wakeup_source` in the struct adc_jack_data in 
adc-jack device driver.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/extcon/extcon-adc-jack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
index cf5050a244b2..125016da7fde 100644
--- a/drivers/extcon/extcon-adc-jack.c
+++ b/drivers/extcon/extcon-adc-jack.c
@@ -26,6 +26,7 @@
 
 /**
  * struct adc_jack_data - internal data for adc_jack device driver
+ * @dev:		The device structure associated with the adc_jack.
  * @edev:		extcon device.
  * @cable_names:	list of supported cables.
  * @adc_conditions:	list of adc value conditions.
@@ -35,6 +36,7 @@
  *			handling at handling_delay jiffies.
  * @handler:		extcon event handler called by interrupt handler.
  * @chan:		iio channel being queried.
+ * @wakeup_source:	Indicates if the device can wake up the system.
  */
 struct adc_jack_data {
 	struct device *dev;
-- 
2.20.1.7.g153144c


