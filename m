Return-Path: <linux-kernel+bounces-121025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A78888E19A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E611F23165
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D73139D1B;
	Wed, 27 Mar 2024 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNQFHsLT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1DE15AAB3;
	Wed, 27 Mar 2024 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541876; cv=none; b=lYhCvldhPA1Uw2JsgujzwwucoFHbGdFSAcPnwqeTW6VAj5wR/YsMdO0iPOyhpVPpYBIm6+KQYeFjpmKrq8EJeABT0jYsFFVyxQ9MAwyxtPv0G13eDgy34bksT3hm/Lkk0OmojZSOrGI7157uDzksBYJthexbl5fLKc+6agPE2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541876; c=relaxed/simple;
	bh=8KdgN4gMYpFIeyybpCJjFfRxR85qaQxrQ/OatPBxMwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSuHGbBAARpa7c0fnlZX4+WTjCuKGkQgjOGsLPAPozMFsBJd6h+VtLPFjz5Bt2HbPIgrOhqyQnXR+641RvC9TexztBWRpbMA5CFuDq+lVKqsclXmxtl/FRoyU1mxVOZxxvVMh+c+pyzXxiXX0mYje9LmURL3dzNAUFXlLHsxEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNQFHsLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D56C433C7;
	Wed, 27 Mar 2024 12:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541875;
	bh=8KdgN4gMYpFIeyybpCJjFfRxR85qaQxrQ/OatPBxMwA=;
	h=From:To:Cc:Subject:Date:From;
	b=YNQFHsLTdNvPTWB31tU1dFxyzsq0FhO/HlDDVg4XPljDU7oWiCXzyjRWDGkP/s1Kt
	 ezrsWLMgpkYuKK/anHPpP5knLVSEtvBuGMP0xTekv6zbTPHrXoeN8uLOk25zGtfgvc
	 RuvF8cvZNa1UxgnxDLjXt5b47ZIObq+SgnQU0nNmTfWUpP2X9uXzmShB74igCL8ZKX
	 9MrerwISQJLNJ/bs+LOhs+JDnLxj4Ai4CnYryOjNTm/Htrww5D+kbpB6aGDvOcfbRT
	 5w2rqOj9Lh4Jk5/MotrlxpqiHWmMHlSyIPv6aI4+sLBSOPN2YNpslNq3t1ksYRS/Ya
	 Z1kNBZ7AvLzow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wangyuli@uniontech.com
Cc: WANG Xuerui <git@xen0n.name>,
	Wentao Guan <guanwentao@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	linux-crypto@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "LoongArch/crypto: Clean up useless assignment operations" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:17:53 -0400
Message-ID: <20240327121753.2833881-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
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





