Return-Path: <linux-kernel+bounces-121190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D0088E34C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13A42A3FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51AB18132D;
	Wed, 27 Mar 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxM0JQ5x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F618130E;
	Wed, 27 Mar 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542310; cv=none; b=RT8Vc7K6InTUAAPfTcVN8dfPMJ/KiZf+CF7hGbI5RgccvoypRY/xHQ+4yJboGwcs0XlP+msAMK0ZEREvxlwKn00LXz8QdYtcTdMWbSBbbeeziqqVJWU5xfA1YEV4eOqoazKMJhtxYR6eplE46clgSHQ1H7pj0ZWhj0hLP/xE9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542310; c=relaxed/simple;
	bh=tQOdbfRc0uu9USqlT0ZH22KXVG2u9wYpVV+XI4OZdkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/ngrnw7wNaukmGPlk1enARSaWb9uwUEHZ9/pAR3eDPTMbsOtCQE5+UaD0blOIyk2eOONF2sIYJmxobJ52uvMu+i8SBWNCvC+zFeR21tgyVZgqFigqsiAV0UD+0eqlYKOLu6UHghQJ7Vrx/kCke7dYUh8XJzgTIE/9Cj93db8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxM0JQ5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AFBC43390;
	Wed, 27 Mar 2024 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542309;
	bh=tQOdbfRc0uu9USqlT0ZH22KXVG2u9wYpVV+XI4OZdkY=;
	h=From:To:Cc:Subject:Date:From;
	b=QxM0JQ5x48rsAOWhahTtzTy0vnnzWLCo640LJfpFw8aGudttKkJuGuZkviR2lvYot
	 Rt/ZPjZ3zXAQ1Q4b58Uf7ZoyJuaaRCUf8gED2K9OcTEj5fvrQRN+mbNxcRb4bk52V8
	 FNHPKekQoWt4ID9JFUlCVuMULNesm5zCtTfiLU+vwexq7q1E9ScwvyWV/HnJKvvp/y
	 Hudu0iQ6po2l+KYQ/4oxkfDEMT5WUvPxrTozBGwDjhvmWEeCtmU88ttRTVMZaRmCeJ
	 HhJYM0kP3zCOYi9zEBo5iVa1vcbRlhtguz9hSFxfLWYY8Dp08lmTkAc0Gpu2uoh5ZA
	 HhvG98iLIsjWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wangyuli@uniontech.com
Cc: WANG Xuerui <git@xen0n.name>,
	Wentao Guan <guanwentao@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	linux-crypto@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "LoongArch/crypto: Clean up useless assignment operations" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:25:07 -0400
Message-ID: <20240327122508.2839963-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fea1c949f6ca5059e12de00d0483645debc5b206 Mon Sep 17 00:00:00 2001
From: Yuli Wang <wangyuli@uniontech.com>
Date: Tue, 19 Mar 2024 15:50:34 +0800
Subject: [PATCH] LoongArch/crypto: Clean up useless assignment operations

The LoongArch CRC32 hw acceleration is based on arch/mips/crypto/
crc32-mips.c. While the MIPS code supports both MIPS32 and MIPS64,
but LoongArch32 lacks the CRC instruction. As a result, the line
"len -= sizeof(u32)" is unnecessary.

Removing it can make context code style more unified and improve
code readability.

Cc: stable@vger.kernel.org
Reviewed-by: WANG Xuerui <git@xen0n.name>
Suggested-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/crypto/crc32-loongarch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/crypto/crc32-loongarch.c b/arch/loongarch/crypto/crc32-loongarch.c
index a49e507af38c0..3eebea3a7b478 100644
--- a/arch/loongarch/crypto/crc32-loongarch.c
+++ b/arch/loongarch/crypto/crc32-loongarch.c
@@ -44,7 +44,6 @@ static u32 crc32_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
 
 		CRC32(crc, value, w);
 		p += sizeof(u32);
-		len -= sizeof(u32);
 	}
 
 	if (len & sizeof(u16)) {
@@ -80,7 +79,6 @@ static u32 crc32c_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
 
 		CRC32C(crc, value, w);
 		p += sizeof(u32);
-		len -= sizeof(u32);
 	}
 
 	if (len & sizeof(u16)) {
-- 
2.43.0





