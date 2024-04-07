Return-Path: <linux-kernel+bounces-134198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F016089AEE4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEF31C22203
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC5B6FC7;
	Sun,  7 Apr 2024 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oivHzcLN"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14961C0DFA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712472006; cv=none; b=J7lR+tV+OVpOWFOuxeqHYCe5wnWKu49XROarMNgxESicwLdn4z/wycf52gJeVvmI+J72VCv0/vll5gZwPk78QEv6jslwTQkpl1Z3OiACbtKgHPWAp0ws3OHRd8GPXalJego4UpIHiYJp6CoMqWLHJbaKF66DRjHygn8E3T4ppbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712472006; c=relaxed/simple;
	bh=hnq/Ta6g5Sz+SLDAZsS7mYM2j5g7bqceiPJ4BmIGZeI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QA4lfDq+E0+CYw17dnuuioc7Zzdi/g4CKokWXL017HvIinJ30jFTgZSt1dlW2lB/g1RvixQKHc8TK5Sd+sfGcJcfmnZuy8vqTRV9HlJN5xtCWf4Ll66USqfC5iJZSUSgbMrooVzKdSxHy8hFTN62L2OZjeAerK/Be5TRvS1zeSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oivHzcLN; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712471996; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=V4x/Lj77Qq2ZCIBC+j8JnalEbYJ25z8MZAvncLNZwfU=;
	b=oivHzcLN58h9E4CUFWfsCvt/d6yip7CJ4W6A7Nz0OolH3EEZZugoK9VqU7ePuxid0cbn57/ELpmQYqdJ1Omynoyp6r6D1yNItpOr9o6aoIwnjcyFz97hYlhZyYmaUiIR+Xu5M4fuiVnCAiRBl4VA2hgmtDX0MCFTY4I//kL8+Js=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4.Zysc_1712471994;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W4.Zysc_1712471994)
          by smtp.aliyun-inc.com;
          Sun, 07 Apr 2024 14:39:55 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: arnd@arndb.de,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 1/3] powerpc: boot: Fix a typo in partial_decompress() comment
Date: Sun,  7 Apr 2024 14:39:50 +0800
Message-Id: <20240407063952.36270-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function partial_decompress().

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/powerpc/boot/decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/decompress.c b/arch/powerpc/boot/decompress.c
index 977eb15a6d17..6835cb53f034 100644
--- a/arch/powerpc/boot/decompress.c
+++ b/arch/powerpc/boot/decompress.c
@@ -101,7 +101,7 @@ static void print_err(char *s)
  * @input_size:  length of the input buffer
  * @outbuf:      output buffer
  * @output_size: length of the output buffer
- * @skip         number of output bytes to ignore
+ * @_skip:       number of output bytes to ignore
  *
  * This function takes compressed data from inbuf, decompresses and write it to
  * outbuf. Once output_size bytes are written to the output buffer, or the
-- 
2.20.1.7.g153144c


