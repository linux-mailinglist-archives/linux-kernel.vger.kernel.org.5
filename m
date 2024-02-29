Return-Path: <linux-kernel+bounces-86526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD62286C68E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702171F21C79
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32A16351F;
	Thu, 29 Feb 2024 10:13:57 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93D634FA;
	Thu, 29 Feb 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201637; cv=none; b=DJ14bd8UNbzd11tqZwdkWs2p/wRzgZJ/BDXO0WHkFeh7h+a1enaoBTTJGiFinaCJ16tYGlnuIdBRjG1aSQJjAud/kPH2X3isLcQpDIdjIdV+l8GjS5qYZF8dMvcT0JOVHTK6SaDyljRkeMA2UBC9hPo4f3y88kdPR2j68o0kmtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201637; c=relaxed/simple;
	bh=8NZVv0lkuZlY6+A2M5F1zaJ3Ds4jXdulvQdDZTK2V0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rx3YjGJP9DMT4zaqWFL9tmQC6ICXCKyb3YAK1DXZG1+wcKjn7TxyHJjwZqlg98l0V/7y1cMSeY2wS853hlU1MPlBSfj6c9WjG5FVUIMjYS4aTFNc5Jdn4URF5N8iNT/JCvatFnCEaUcblPkizrXMOmNW4OalRDgg3MaE5F3eqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp80t1709201113t32ib1l5
X-QQ-Originating-IP: darFS/AnfPpgCRo7otCbYoD5Wd/NwnLY6XQ6Qd04Thk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Feb 2024 18:05:11 +0800 (CST)
X-QQ-SSF: 01400000000000C0B000000A0000000
X-QQ-FEAT: znfcQSa1hKYmF0jHFgph+YrvzbCpdq/0E1K0TlIRQBz/8ddzsf+8rJH47uuYR
	u+FqG3YXNgS533wDh5NenF2q0B/FXDJYvMpu2SHxLgyAC/4HCGtWvn7o+X1pFfgfTWUTA4U
	MGW+z3jkKG/vrk15Ihh6fTFkLak8qU4uni5GFb4dbZ9bjwAhBPVkGgWOQBWBiqlRmTeklZ2
	9PsiJG/sz6BJAsheURugGIFtrSBrK/H2Ri6rvcZpyHc9m9mPeYB9v0ea37khJ78w5lV2k/m
	KgRYlc8he3dfst2lSHmD+k0BmfQ8ckHP6kKyVYa1wZqY3TnePr+4fb2zS59uItG+MrhzdTC
	D9ObeIq4uqUQmpa4xu3w5HKvkDImTgLFpYrJ8DL1/JCsxNAhFmwE8YMjpAfxFBVR3RuVcyu
	OdNtYJnpuVw=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5336942437654610621
From: WangYuli <wangyuli@uniontech.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: linux-crypto@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	WangYuli <wangyuli@uniontech.com>,
	Guan Wentao <guanwentao@uniontech.com>
Subject: [PATCH v2] LoongArch/crypto: Clean up useless assignment operations
Date: Thu, 29 Feb 2024 18:04:49 +0800
Message-ID: <79D75E042AE5B03F+20240229100449.1001261-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

The LoongArch CRC32 hw acceleration is based on
arch/mips/crypto/crc32-mips.c. While the MIPS code supports both
MIPS32 and MIPS64, LA32 lacks the CRC instruction. As a result,
"line len -= sizeof(u32)" is unnecessary.

Removing it can make context code style more unified and improve
code readability.

Suggested-by: Guan Wentao <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/loongarch/crypto/crc32-loongarch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/crypto/crc32-loongarch.c b/arch/loongarch/crypto/crc32-loongarch.c
index a49e507af38c..3eebea3a7b47 100644
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


