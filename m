Return-Path: <linux-kernel+bounces-103975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46B887C753
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84F72835DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8193B63AC;
	Fri, 15 Mar 2024 01:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U6Bi/ROI"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB74C91;
	Fri, 15 Mar 2024 01:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710467651; cv=none; b=ALkU/MjLbtRA68IEcnRjlacIFqojE3EcuItLH818gT5f4p9JH7rRy6Asv+d5tCRx1536/90AzKxfxV+8pTAY6qBjgCNPHTrVR0FlwCyp5wcsZrvTTqsIRsKrFnLkP9xeObjGuIw9jnUKOxgsKVkUQt23kBgKV+olIY1f3bw7uZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710467651; c=relaxed/simple;
	bh=ruOgGDUL1x1bYYko096jvBmMwxvl0FULlZFFHrqtuuY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uEk0FDESBI+36avHHUAhNb0xtOHpsCArSGy0PPxFgMwAYe4byhzo5zm87EWHWCaHxc+IXgiKKVNT6k5X/fS3f9HyFcD1XWblC5qhGl6VbHvLZIHOEy691zClB33mLfCmDCZA0qZhCxbnpm2Y+sV4gsQtLkYgLDbxkfuTZ9/10H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U6Bi/ROI; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710467641; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=px9N44gO4i927LMckVeMvo+Wb1vg+vgE8QfX2H4P0og=;
	b=U6Bi/ROICx1kenEr4vIPjsBsSGnb+7jd6z6ayNZxCtX0+xPB7CuQ85zkD9bhfcVQZkR38gZULJtKRbu9iJFQjZ3RGjvC/KGas2urcd5TMtFb5fWiNtB7TjUfD9a6ZugOwpvUCNbP3f2dYaomMvVzzyUfNmnmPPMM6JotP/S46y8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W2UCwML_1710467629;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W2UCwML_1710467629)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 09:54:00 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: keescook@chromium.org
Cc: elver@google.com,
	andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ubsan: Remove unused function
Date: Fri, 15 Mar 2024 09:53:47 +0800
Message-Id: <20240315015347.2259-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function are defined in the test_ubsan.c file, but not called
elsewhere, so delete the unused function.

lib/test_ubsan.c:137:28: warning: unused variable 'skip_ubsan_array'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8541
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 lib/test_ubsan.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index 276c12140ee2..be335a93224f 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -133,11 +133,6 @@ static const test_ubsan_fp test_ubsan_array[] = {
 	test_ubsan_misaligned_access,
 };
 
-/* Excluded because they Oops the module. */
-static const test_ubsan_fp skip_ubsan_array[] = {
-	test_ubsan_divrem_overflow,
-};
-
 static int __init test_ubsan_init(void)
 {
 	unsigned int i;
-- 
2.20.1.7.g153144c


