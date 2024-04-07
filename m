Return-Path: <linux-kernel+bounces-134200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB31F89AEE6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222C81C22115
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BC91119A;
	Sun,  7 Apr 2024 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YAmcefSq"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C51F7489
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712472009; cv=none; b=hGD39Yycpxp/WMLGvdZHgt40EG2cbo9lXiltbUhMpbVHpd1t2SR+5EtWhBB0FJ2mi8ep5hmR1GTdXO79g88An1XT3/KInYE6Ee7vOuhIxXuNWwFAmyN/hILo7FkdpX/k8290ayb9LCVwS08YB/cZfdvkkGgs4yE1RfGMPKmqy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712472009; c=relaxed/simple;
	bh=ftxyYxHgge01K5FGwCdWcUIt5Zgt2SY7iyEXC9DhRr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BhQs53T4YeBwWCewkmmtGJTXYVRNwqqONGq5HfzkFKcoSweZ11/A/ozG3jv9LkXMkVR+HGu1TU7Hw9/QHl1v1vPWyfVlDUK/HW4uWOuf8TECcjl/H0Vui6Etm98QH7V0pdl5RwE6LEaYgi9gYSHpcGLIp7j3+tjQgexxbiK4b0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YAmcefSq; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712471999; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EjfZY0CTUIhZ4N4U3YPY3Hn4r3z4P0OXYogLhFLWsC0=;
	b=YAmcefSqZvWLFj+kkZSvqF2GvzZBI+Lw/WOIQptgaMKnWMcaX1fmjhB4Hit1FitFVTJPickzAoBAaQ2sdIf292/d65ndUv08Ugr8GsXYE53DD4ho36h6kNgPizev0J0g0t30XeA5d6ieKJGW82xJBJsko+9gMSDch64c48WlAdc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4.Zyu2_1712471998;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W4.Zyu2_1712471998)
          by smtp.aliyun-inc.com;
          Sun, 07 Apr 2024 14:39:58 +0800
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
Subject: [PATCH -next 3/3] powerpc/rtas: Add kernel-doc comments to smp_startup_cpu()
Date: Sun,  7 Apr 2024 14:39:52 +0800
Message-Id: <20240407063952.36270-3-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240407063952.36270-1-yang.lee@linux.alibaba.com>
References: <20240407063952.36270-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function smp_startup_cpu().

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/powerpc/platforms/cell/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index 30394c6f8894..bdb7adde798d 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -55,6 +55,8 @@ static cpumask_t of_spin_map;
 /**
  * smp_startup_cpu() - start the given cpu
  *
+ * @lcpu: Logical CPU ID of the CPU to be started.
+ *
  * At boot time, there is nothing to do for primary threads which were
  * started from Open Firmware.  For anything else, call RTAS with the
  * appropriate start location.
-- 
2.20.1.7.g153144c


