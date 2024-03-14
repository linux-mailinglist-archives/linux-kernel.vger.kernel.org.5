Return-Path: <linux-kernel+bounces-102885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D8A87B802
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51BD1C22761
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199334A11;
	Thu, 14 Mar 2024 06:38:43 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BEB443D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710398322; cv=none; b=C1721Cbi8YBeXLRjrbNr9CktJMQpKg+zkIqcmO6lk4659uI10woqj8GJtrvRep63nHxQLrFGNkqDfaUnBi9ky+p6jBdfKpSsYEaXxCBYuzJU1d4uBkXCcj/83uj3L+x76vJLXRbmtsXJUJI4BdIiS2cF3vLAeWfCIsO8Wm2HN9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710398322; c=relaxed/simple;
	bh=ncxPhRMMpfqp9OzQjoy4dcGCuf78mFoSFqMSDKndVh0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VRoHxDkbnK7um6yBztwLmZy1VuhrHxyn5jzPy8CN06tUpBgq0QTHZ/Pmp/UsDxqX5x0ZAoovYv3rHTITuDfFcjq5J1dK/ZHRlO+1kC/hH+XmsrUO4zFkMm6ARflGQbCBlNRMHBN1dPPSX2rJ1j3G9WWO+B+nGQMA0+HOXBcfj+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TwHkz0PqWz1FMPL;
	Thu, 14 Mar 2024 14:38:19 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EA7E1400DB;
	Thu, 14 Mar 2024 14:38:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Mar
 2024 14:38:35 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<suzuki.poulose@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] arm64: Remove unnecessary irqflags alternative.h include
Date: Thu, 14 Mar 2024 14:38:19 +0800
Message-ID: <20240314063819.2636445-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)

Since commit 20af807d806d ("arm64: Avoid cpus_have_const_cap() for
ARM64_HAS_GIC_PRIO_MASKING"), the alternative.h include is not used,
so remove it.

Fixes: 20af807d806d ("arm64: Avoid cpus_have_const_cap() for ARM64_HAS_GIC_PRIO_MASKING")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/irqflags.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 0a7186a93882..d4d7451c2c12 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -5,7 +5,6 @@
 #ifndef __ASM_IRQFLAGS_H
 #define __ASM_IRQFLAGS_H
 
-#include <asm/alternative.h>
 #include <asm/barrier.h>
 #include <asm/ptrace.h>
 #include <asm/sysreg.h>
-- 
2.34.1


