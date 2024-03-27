Return-Path: <linux-kernel+bounces-120886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66B688E030
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D141C2915D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88C9144D06;
	Wed, 27 Mar 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUB87MNe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82951448F2;
	Wed, 27 Mar 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541492; cv=none; b=QhXem+Miw4bfzc9/uUO5zzP0w6UsitZdN+w6PKNpQ5EtNIjfNN395EoJZUh6+gooZ6H0XQ87Z38rwKirLhwmFC2mkb8+Bf5KWmJ+Wsuk2uS1U49tXMfFd3BuOzVNg39DbT7CZUngjVveMupHj2/0Z6OELAHQNIERrOGgfWcaXCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541492; c=relaxed/simple;
	bh=8HKvH2ZmRNAoMNTGQiDhZZWKlMb08XtUGwUod/1FeTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZ52nORKPTY2XV/mvFRA+XmBTArkC+zD+WmHQ8D4fESUVSdmDoqhDj/vBjmSboLOTo834f6rOWn0eR2/nhwLWziLfYZc+NOSTwapC+IZtiADNjoO4En4L2sKqnOnG+PMxx4MSX2uWhfUrIfu+IaZ7UQvET9i6O8h+7Fm4KvBNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUB87MNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE430C433F1;
	Wed, 27 Mar 2024 12:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541491;
	bh=8HKvH2ZmRNAoMNTGQiDhZZWKlMb08XtUGwUod/1FeTU=;
	h=From:To:Cc:Subject:Date:From;
	b=DUB87MNexWr/B6y1mYCgbMqhl7Bb+34h9WrjNqGS8lsMhR6MSeU4o7SvoB0NVBYPP
	 Ep+2izkyzLk7+p7m+cXtFNSOIyLW6QOno2qVz5S3oBp0xqCwmB3mvhw9o0D9o0IwS1
	 7kzHhyWQbRvGSIQ3u3+YiaO2RLHTCRjPutHIngo/TeZrn93wmzyoRUE7u92D/3Ih6K
	 gD/1eoLsVrGK/m4Vqi/h2s1McaaP64o4POo9hpz5koEOjaao1qYndAGIhDrUvdCkMD
	 ntZ4rbFHnkJr67YfqWV+GYp4Kn4OIkuA1t5xPxfPK6H5VYXYqoS2CePGShYNUMTWFF
	 5BYyPJ4OMXkyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wangyuli@uniontech.com
Cc: WANG Xuerui <git@xen0n.name>,
	Wentao Guan <guanwentao@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	linux-crypto@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "LoongArch/crypto: Clean up useless assignment operations" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:11:29 -0400
Message-ID: <20240327121129.2828782-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
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





