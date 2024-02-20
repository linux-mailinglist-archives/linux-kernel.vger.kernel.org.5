Return-Path: <linux-kernel+bounces-72782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7271A85B8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EAF1C2163C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C086217F;
	Tue, 20 Feb 2024 10:10:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E26215E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423803; cv=none; b=Ndw18ReNtGNvS5z2/chmmFeoP7QpijPMVQsiNxh3A/HiKHFolpJeTXQmXpgYnWyxEcouysJUx05Zop2e29RufomD9rSMq5ELTwTHgN9acjL/NLj6BQ3+4VRNaG8qf1vtbmBOfu2KCNnjiiaYZ5Vt+vMLT8cE00AXWVkVzb1hG70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423803; c=relaxed/simple;
	bh=/WMFdTur/ftMdu5Fg+u5AWRizeTGYRL+OGHqhgthSgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=edo97c1y5mrvyycw41WfUBTIhRvzto/cEYapXq8a3N+tqOs70arvROaIEs8d/I5aKYu5ekCAutCBCYYEUeWW1jbSpKt5smJX3oCRDRDpREmZsW/hK3E7ywFtD8N5tVzCGYMHt6g3G9orWDC09X6bZ8HJW9Zk9jLB8gma0gLflzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADCBDFEC;
	Tue, 20 Feb 2024 02:10:40 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8897A3F762;
	Tue, 20 Feb 2024 02:09:55 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	acme@kernel.org,
	oliver.upton@linux.dev,
	broonie@kernel.org
Cc: James Clark <james.clark@arm.com>,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/7] arm64: KVM: Fix renamed function in comment
Date: Tue, 20 Feb 2024 10:09:11 +0000
Message-Id: <20240220100924.2761706-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220100924.2761706-1-james.clark@arm.com>
References: <20240220100924.2761706-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

finalize_host_mappings() became fix_host_ownership() in
commit 0d16d12eb26e ("KVM: arm64: Fix-up hyp stage-1 refcounts for all
pages mapped at EL2") so update the comment.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index bc58d1b515af..11d77aa36173 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -131,7 +131,7 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 	 * can't be donated or shared with another entity.
 	 *
 	 * The ownership transition requires matching changes in the host
-	 * stage-2. This will be done later (see finalize_host_mappings()) once
+	 * stage-2. This will be done later (see fix_host_ownership()) once
 	 * the hyp_vmemmap is addressable.
 	 */
 	prot = pkvm_mkstate(PAGE_HYP_RO, PKVM_PAGE_SHARED_OWNED);
-- 
2.34.1


