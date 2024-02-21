Return-Path: <linux-kernel+bounces-74498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B839885D52A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AE11C209C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563293D982;
	Wed, 21 Feb 2024 10:04:54 +0000 (UTC)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC23D965
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509893; cv=none; b=VET+CPSUWInqOCEPNrPUUoQGmPP5Esxz1bJJ+fj+zT45fYXQLveXNB64eA054h+/URlxn5dDl1ecg+9VYBvX5hKUOgSVNDX8FhpaENO+r/ke/4gkllqvmepFXrIHANA+HrwVvDZZpamLsCB6F6mQYGFSK3KQNovfGVeP/cykQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509893; c=relaxed/simple;
	bh=RMLx0DOlR6d8tmi9pMcIaBeoejWyA37IhHX8Be6XsDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=umJoQeJNzGFHOfSgP7Ww/61Fy44NtzWh5YEWfZQZuuSZf/SPlXSXNbPyggv13ThCGIhIAeDc2kx03RTJ68lE4RT1KdAfqYu554wt9+vwWjjzjMsplstG+xvYMw1+97/yqMi/zQ+keqaOj0a0YpMkEC44rHGrukMNqINRJ+yGqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: bizesmtp79t1708509791tffdlfxc
X-QQ-Originating-IP: hZ5w7OPc1Pp86+CkyB3tl09awzp4C34FMga0zrF7TLo=
Received: from ubuntu1.. ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 Feb 2024 18:03:09 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: C46Rb8GPIEdPMTROtMOZN6nemes7t5ZwikAXs3JSN5ZREdpnZoH+yMSsiy3X3
	2zkr3jRvn/gzVABgxzc3QJkIk2UKXHjs9d/ZCOMC4IgwFRvy294Bt3lvNmR2us87eGtjrMk
	qKKWrSgIcXajT/Yp4RVc8Um9sEdBp7Sey+bwv7O394Q0bP0UJlE6TgC5OcFD3V/3DzRCMJ3
	jr3NvicWNxtebFmxdyrqnzq4hQB9KnLHju69ppHjDO7C1erx0qdWC4B6hO9+gtaQCrGS+aY
	L9tKwiT4xqDqRC7aruaYwsWTP31kfo6UvMtJH+PwbkfPFk1r8MdN4L8t/dxLnJYlvJaaaMi
	/9eDaaE88b3I+cyZPpXbMpZ8Lg90g==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3370517727250236861
From: Song Shuai <songshuaishuai@tinylab.org>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	andy.chiu@sifive.com,
	ebiggers@google.com,
	vincent.chen@sifive.com,
	songshuaishuai@tinylab.org,
	greentime.hu@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Andy Chiu <andybnac@gmail.com>
Subject: [PATCH V2] riscv: vector: Fix a typo of preempt_v
Date: Wed, 21 Feb 2024 18:02:52 +0800
Message-Id: <20240221100252.3990445-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-2

The term "preempt_v" represents the RISCV_PREEMPT_V field of riscv_v_flags
and is used in lots of comments.

Here corrects the miss-spelling "prempt_v". And s/acheived/achieved/.

Reviewed-by: Andy Chiu <andybnac@gmail.com>
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
Changes since V1:
https://lore.kernel.org/linux-riscv/20240206044217.1283849-1-songshuaishuai@tinylab.org/
- s/acheived/achieved/ 
- Add Reviewed-by from Andy
---
 arch/riscv/include/asm/simd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/simd.h b/arch/riscv/include/asm/simd.h
index 54efbf523d49..adb50f3ec205 100644
--- a/arch/riscv/include/asm/simd.h
+++ b/arch/riscv/include/asm/simd.h
@@ -34,9 +34,9 @@ static __must_check inline bool may_use_simd(void)
 		return false;
 
 	/*
-	 * Nesting is acheived in preempt_v by spreading the control for
+	 * Nesting is achieved in preempt_v by spreading the control for
 	 * preemptible and non-preemptible kernel-mode Vector into two fields.
-	 * Always try to match with prempt_v if kernel V-context exists. Then,
+	 * Always try to match with preempt_v if kernel V-context exists. Then,
 	 * fallback to check non preempt_v if nesting happens, or if the config
 	 * is not set.
 	 */
-- 
2.39.2


