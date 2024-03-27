Return-Path: <linux-kernel+bounces-120747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA6488DC79
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A411C23ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F58271741;
	Wed, 27 Mar 2024 11:25:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF266EB6D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538701; cv=none; b=PtFFH9nIGYMdfEHYzV+FMV144olNmciTHXMZcmRXPd1lUL8l/DkfMi83A6otcPuP4YMBIOUiZeMwTr//btMSyO93WKqYK29fxYRKo1n9zI6xDIYnP1zlYzINKQv0dlh2xZbPC8ZgBZEk03VFy7Ltvy5qxYbYJvUUKuSy4ScV1JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538701; c=relaxed/simple;
	bh=T+moCp9amPEcwG51Nwb9zHrIinA3U9QwdTdPkdNNDmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LiJ4c7KYIZqv6Pfq2gpUZh13qF7WAAvn6w9kMjs6JSYWWRi5zhN2p/NilSk2XbvRTnbRv165EMx1ZkrYVqH4CGFB6MvkKr4V3MOG36BXtjiA9+7NNXuQLoTHW9S4W008Co3TzxW/9bRr5PNkG4bslkO24hIBz8iUL6I3ch5Y+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFE0C2F4;
	Wed, 27 Mar 2024 04:25:31 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.14.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 672333F694;
	Wed, 27 Mar 2024 04:24:56 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Steven Price <steven.price@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: remove redundant 'extern'
Date: Wed, 27 Mar 2024 11:24:39 +0000
Message-Id: <20240327112439.200455-1-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It isn't necessary to mark function definitions extern and goes against
the kernel coding style. Remove the redundant extern keyword.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 87e307804b99..75b22b89db1a 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -107,7 +107,7 @@ void __init early_fixmap_init(void);
 #define __late_set_fixmap __set_fixmap
 #define __late_clear_fixmap(idx) __set_fixmap((idx), 0, FIXMAP_PAGE_CLEAR)
 
-extern void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
+void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
 
 #include <asm-generic/fixmap.h>
 
-- 
2.34.1


