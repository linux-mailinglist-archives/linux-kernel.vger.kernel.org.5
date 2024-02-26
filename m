Return-Path: <linux-kernel+bounces-81267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776C0867324
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7B21F248DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FCE210E4;
	Mon, 26 Feb 2024 11:33:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E06208B8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947206; cv=none; b=u5AqFVKN2uiE4jDCZOB9HfUbzpMtnSmqZftNWs6e1D8ENzpWcSOD6/bWZAZLu9pwGxlqZj9LJRR279MrHDYCIkb/wBDl6SThhe1OGpTYH/u8RVeMN/W/dSzL6xMkegZeLGhAKZfC5pkFvz5ecyonoLWS/uGwFDWDqqJaQFRT1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947206; c=relaxed/simple;
	bh=itmjCQvkDKYCOqdryrMcD03YE3rCvHggOaRIyi037GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VEB9VdxgpamXFREdqVTvr8ifDohbSvgrlZFB3aiWC2gQD6WeENEOBeSGYq82L4JCfP21u7+d3qIIlzej5FdwpGX0BWxQpunuv1u2054K05flJX4JfZYGeCWxc9dsUsbgxpmz94PbEqwjWG7hKE1RA+u57Vrf+Cpb9uptEPtHwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2B27DA7;
	Mon, 26 Feb 2024 03:34:02 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D30E63F6C4;
	Mon, 26 Feb 2024 03:33:20 -0800 (PST)
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
	Mark Rutland <mark.rutland@arm.com>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <tabba@google.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/8] arm64/sysreg: Add a comment that the sysreg file should be sorted
Date: Mon, 26 Feb 2024 11:30:30 +0000
Message-Id: <20240226113044.228403-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226113044.228403-1-james.clark@arm.com>
References: <20240226113044.228403-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few entries particularly at the end of the file that aren't
in order. To avoid confusion, add a comment that might help new entries
to be added in the right place.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/tools/sysreg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index fa3fe0856880..a84c19c111fa 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -48,6 +48,8 @@
 # feature that introduces them (eg, FEAT_LS64_ACCDATA introduces enumeration
 # item ACCDATA) though it may be more taseful to do something else.
 
+# Please try to keep entries in this file sorted by sysreg encoding.
+
 Sysreg	OSDTRRX_EL1	2	0	0	0	2
 Res0	63:32
 Field	31:0	DTRRX
-- 
2.34.1


