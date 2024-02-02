Return-Path: <linux-kernel+bounces-50375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D535847830
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07E51F2F657
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AE7131B00;
	Fri,  2 Feb 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRpTCBti"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737BD130AF5;
	Fri,  2 Feb 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899228; cv=none; b=DciBY0B+0qg1CnxOnIFdYXsqDeMJBsdGIZQ9nShuOtlu8I/CITc1cycYvxTPzTumxSrVP4PqbvBHgV7ELeHlvpEMMSOm8/YxgfPmITwwwjOjdmXQHFeByKPhBAIMV3HSZphVu+ZumOQX9Ln6nU3WzNlwKgOAllNJtfPJeh3IylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899228; c=relaxed/simple;
	bh=tChvbH3WJ4jv5ceSmRADst+lV4Lko4l57ZYmO3gq8Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYnHxLtivDALsA5ElLl8mswZcuhfnEzV9KILy3G8gKYKkQ2Dzj60XK9sgOo6lid8Amp6le0xi58diimqlJAilou041L1fnni//uRoe/5SLlpiRxqPqDOVyuJmeuCUHdLoS+sC/UFDgg/ZBj9hOBF/Z8DGjYmuA8f1QZNBgOU3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRpTCBti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE21C43390;
	Fri,  2 Feb 2024 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899228;
	bh=tChvbH3WJ4jv5ceSmRADst+lV4Lko4l57ZYmO3gq8Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRpTCBtiwLMteP4DzYIfIZEj/jwitpjGIIVEb7LhvaEVuA08hLhEXHvZciYTJOqcK
	 R4WkE7dee3j20f3+Ds7gR27GURJPpxI4PGNGeNrBTouYHyR/Nu9/++x0L5cjbWc/gt
	 T4IDopnzPV1beByFGAEhiMjoIgnbldOamA3qTmdyvNckE4bTVTbCB2+jmOyEudJJAD
	 wHirqArOmzL0HI3flS5AWB+XgAdP1B+KQBG5VDkpMMBFckNam3bMZK5zeN/9CGf5lX
	 QFUDd0+bEfVC4LOQoFaPiKg9fTvj8EPlOhtAxQ1E5jCbcE7UFT08m8csQH775k7B8V
	 qaSn9AAILd3lw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com
Subject: [PATCH AUTOSEL 6.6 07/21] x86/cpu: Add model number for Intel Clearwater Forest processor
Date: Fri,  2 Feb 2024 13:39:54 -0500
Message-ID: <20240202184015.540966-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
Content-Transfer-Encoding: 8bit

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 090e3bec01763e415bccae445f5bfe3d0c61b629 ]

Server product based on the Atom Darkmont core.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240117191844.56180-1-tony.luck@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 197316121f04..b65e9c46b922 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -162,6 +162,8 @@
 #define INTEL_FAM6_ATOM_CRESTMONT_X	0xAF /* Sierra Forest */
 #define INTEL_FAM6_ATOM_CRESTMONT	0xB6 /* Grand Ridge */
 
+#define INTEL_FAM6_ATOM_DARKMONT_X	0xDD /* Clearwater Forest */
+
 /* Xeon Phi */
 
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
-- 
2.43.0


