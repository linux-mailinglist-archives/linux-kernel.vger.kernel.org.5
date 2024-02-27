Return-Path: <linux-kernel+bounces-82856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DE4868AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B77283283
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CD356B85;
	Tue, 27 Feb 2024 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X6HPfAmU"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED0E56461;
	Tue, 27 Feb 2024 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022024; cv=none; b=HBfx8OFQLQei0UiJv/g8Zj7FVg2R76mLtaj83F5kTkY2QFY4+GmSWbaYHDcf1ZOCDIEBQ8jbiZ0YV1eeZQ0VQw6WiVTD+egtLZ3UK5r0QQir9jCfhWLymUiA4Y3iwxvsjlFRyuzMoVriLkHF4tCSAGMT6tfAG18nG/LabXATD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022024; c=relaxed/simple;
	bh=k9RhSxrlPLj8IlwJPdxEqZaaSrHaCWfR513zF4tGFVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f3KWSEgMfBMmd7L4b6bZxrXyTTokranbxaLunLSHZABM+hEmivNv2htSr8SH9JUdDiC86KE+tgaxUKhZI20jTgCJ8rfTdMqAB+WuIyo7h7oFDn7LaEwyBM/In+nIeDYhPN9t6SZKTLn4DWBK0iiFAyaQivVoRTGcM/MfD5Y5K6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X6HPfAmU; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709022018; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7yZTkXJpiVrirUXO3U9wzx2D7H03LIl+2lfBhplApEw=;
	b=X6HPfAmULC7OEJEtdxIuNaNhsXbRlxpLBofmdNtTQqSm4a0ETelwO6YrChZbPHnjFier2d8Va/y2KwuFvOzctOxvYWZG0qXm4uppHzyT2OBsQxuGwKR7NZ5o1QPa5yHrCjLF+nRdvWZkNDckMiGhi+iVoXU6o5f2mZr/USrUm44=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1M90AE_1709021999;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W1M90AE_1709021999)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 16:20:17 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] bdev: make blockdev_mnt static
Date: Tue, 27 Feb 2024 16:19:58 +0800
Message-Id: <20240227081958.89092-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blockdev_mnt are not used outside the file bdev.c, so the modification
is defined as static.

block/bdev.c:377:17: warning: symbol 'blockdev_mnt' was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8341
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 block/bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index e7adaaf1c219..ca1c12c1189e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -374,7 +374,7 @@ static struct file_system_type bd_type = {
 };
 
 struct super_block *blockdev_superblock __ro_after_init;
-struct vfsmount *blockdev_mnt __ro_after_init;
+static struct vfsmount *blockdev_mnt __ro_after_init;
 EXPORT_SYMBOL_GPL(blockdev_superblock);
 
 void __init bdev_cache_init(void)
-- 
2.20.1.7.g153144c


