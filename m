Return-Path: <linux-kernel+bounces-7869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2226881AE81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B450C1F24598
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B67CAD59;
	Thu, 21 Dec 2023 05:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d54lMIzE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE3AD51;
	Thu, 21 Dec 2023 05:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963C0C433C7;
	Thu, 21 Dec 2023 05:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703137592;
	bh=h1bfl0BThbn+znFHsBBkIqcPm3nn5itg9uL9y4qM708=;
	h=From:To:Cc:Subject:Date:From;
	b=d54lMIzEhERrTY69qDJs/DKSwJh07RqS1cgcu933M6H1O6yylDHQfOjWFi77elOuU
	 6ftMFpU1F7x7spBakm25NkX/9HLcB9lFWj0FfnZA9dZzlT7005VbrGZ3Up2vyDM+1R
	 tqtDigi9vkY9XxRyjF2DYDGlAqFQFrJxpPTjuMmVNGEXpd7/m9kNxPguN4LgWZueyW
	 b7A8Mxwhqp4U7EWM9foGegFKNMG0l5tSRqBbOgoyoZWRG7hcF3MLPkPyQpEQRn2UJF
	 KAwiR70M3zCCJN9hdUj9XyhS1O8wrFVndN8mQrvwaP4KUId+u8XbI71D11XT0b7OrI
	 6FKhhNjz8gb/g==
From: guoren@kernel.org
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	zhangqing@loongson.cn,
	huqi@loongson.cn
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH] loongarch: mm: Remove unused TASK_SIZE_MIN
Date: Thu, 21 Dec 2023 00:46:24 -0500
Message-Id: <20231221054624.2208019-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

Remove TASK_SIZE_MIN because it's not used anymore.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/loongarch/include/asm/processor.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
index c3bc44b5f5b3..99c80396f63a 100644
--- a/arch/loongarch/include/asm/processor.h
+++ b/arch/loongarch/include/asm/processor.h
@@ -20,7 +20,6 @@
 #ifdef CONFIG_32BIT
 
 #define TASK_SIZE	0x80000000UL
-#define TASK_SIZE_MIN	TASK_SIZE
 #define STACK_TOP_MAX	TASK_SIZE
 
 #define TASK_IS_32BIT_ADDR 1
@@ -33,7 +32,6 @@
 #define TASK_SIZE64     (0x1UL << ((cpu_vabits > VA_BITS) ? VA_BITS : cpu_vabits))
 
 #define TASK_SIZE	(test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
-#define TASK_SIZE_MIN	TASK_SIZE32
 #define STACK_TOP_MAX	TASK_SIZE64
 
 #define TASK_SIZE_OF(tsk)						\
-- 
2.40.1


