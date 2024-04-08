Return-Path: <linux-kernel+bounces-134802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E2689B72A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322EC1F21852
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADB179C0;
	Mon,  8 Apr 2024 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xoNo3d1g"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C224567F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712554278; cv=none; b=ncZoeC4JPBwGL90GuYASHLgPwKhDOlpMWyI2DD4UIir9R+zrlpH390OCKNzy3/USRLiRnbTa+uz1h6UmTsmovILrnCsXPFrpXpMUhNIKon7gh+5qLLE57S08J0X7irfFa6ZIOlwjwExNDAm8yJSfrgbVMGBvRbYZWIbffeI/tNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712554278; c=relaxed/simple;
	bh=wo7Pwd/jwAqwu7CIC4HixpqxO5O5RWVGNE9t/rxNCDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBU4P0XHLbH6tNNDUF7Auq+6i8tr43susou/eUHqZOO/XZ4Ck6ay4Mobnl35Ups+oGoTsJ7sYTLSQI3d4aphg9PbTPvlcg4/gP+dW8dzbmv7roUtdWUsw65U6WDmEaksePS4Io5Whtn0y2uIeyrOwYpj0uK/bG8leRtpC4H6OJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xoNo3d1g; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712554274; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=k23jdKfibshf2paiE8mb65YrFHJxxTS5h12Q4rCwBqE=;
	b=xoNo3d1gveM9Bk5ovWSsKjb/6ewm8ls1jh4N8iHL/yUpWfeReH2680JiWUiOx4pWFZaXjSijUth9PvOUvNoORZQcsoaSQJTG9GGsmYdrgt/BCzmEBfb2bZxyXelBvrkK4QF0FZZn7QxCRWxN85UnpAb9lO/iQ1ZJbNkc2vvaPmA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W439DQO_1712554273;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W439DQO_1712554273)
          by smtp.aliyun-inc.com;
          Mon, 08 Apr 2024 13:31:13 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: rdunlap@infradead.org,
	arnd@arndb.de,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 3/3 v2] powerpc/rtas: Add kernel-doc comments to smp_startup_cpu()
Date: Mon,  8 Apr 2024 13:31:09 +0800
Message-Id: <20240408053109.96360-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240408053109.96360-1-yang.lee@linux.alibaba.com>
References: <20240408053109.96360-1-yang.lee@linux.alibaba.com>
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
 arch/powerpc/platforms/cell/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index 30394c6f8894..fee638fd8970 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -54,6 +54,7 @@ static cpumask_t of_spin_map;
 
 /**
  * smp_startup_cpu() - start the given cpu
+ * @lcpu: Logical CPU ID of the CPU to be started.
  *
  * At boot time, there is nothing to do for primary threads which were
  * started from Open Firmware.  For anything else, call RTAS with the
-- 
2.20.1.7.g153144c


