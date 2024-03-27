Return-Path: <linux-kernel+bounces-121098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7165788E251
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B291286F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A68D16F84A;
	Wed, 27 Mar 2024 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEpKH6cw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428316F833;
	Wed, 27 Mar 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542074; cv=none; b=fJFB8fPqlQUUPziJHRaoQAD5sKfzfC2A+aVze1ke7cz5k9zkK/ZN6mV2tJm1R9tZsTjc6rxn5/xSwUovszX/uZ5GjljOE7hwa4+xNW5jiACR1Wb+eL87/elsLwBjVfpDTV+db33o3vmxCPZ355il7LrV6XB8cUszNrD6a2vG2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542074; c=relaxed/simple;
	bh=Q1Emc4VWpFUeuSp7EW7BNI771Osv5t5ijKeHZI7rmks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sv4YBnqq0BCoMB/fGJcdTpLF3sA2qWFQUTpGnQyc0+fyY0T6lXRN6PRxkmAhQ4lq8cCf/wBY2yMXIf45Sc07Xu8NMmIrL4MwQ/LCSt0gtcXmGcTrzDe7Kdm0uo8xG5pFROYbEb8rEww6komWIUa7EXgg7xtpjVR5XkfP1uI2ceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEpKH6cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5168FC433B2;
	Wed, 27 Mar 2024 12:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542074;
	bh=Q1Emc4VWpFUeuSp7EW7BNI771Osv5t5ijKeHZI7rmks=;
	h=From:To:Cc:Subject:Date:From;
	b=XEpKH6cw18VRQ7Hd6HpNp3hkFb+P2AKrF+HrlOrCPkPOilxOWEpT5RcamoscspVWU
	 /HztjYTkdzf8wHsWKBH5EnZtHGEiuCmG/tRjiLak/ktKcULgMN96qeWbJlEzFuNbR7
	 UfgVcwnKfNIfHi13Jen2vQKNNy7gCaUOkueDPb9WhPpO6gtaza1D6Ul73VXE0qzGkL
	 LL7j/SfAPEqIS6WSVTrz2xq7WXpHJLh/7ogtgdwQDjGa/MUhZkypEPT1/trY8b79UO
	 VWkHjTGb+4rbzSvTGUcBlJhoLEQbXbUisCLudm+GVI4AMr+/bcZLc4TTZiVFIIqbn0
	 H35VRCLEgKQAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wangyuli@uniontech.com
Cc: WANG Xuerui <git@xen0n.name>,
	Wentao Guan <guanwentao@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	linux-crypto@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "LoongArch/crypto: Clean up useless assignment operations" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:21:12 -0400
Message-ID: <20240327122112.2836639-1-sashal@kernel.org>
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

The patch below does not apply to the 5.4-stable tree.
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





