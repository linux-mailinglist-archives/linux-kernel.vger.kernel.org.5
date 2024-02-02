Return-Path: <linux-kernel+bounces-49526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70D2846B76
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F5B1C264E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF7E5FDA3;
	Fri,  2 Feb 2024 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Obbk0Wwj"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E125FDBE
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864609; cv=none; b=MiiwRiWj233L3BV6gWE75M/Vv7xjL797GuPtWW4viHnCQ/ou25MLT0h0NDw0RcsrOASNgcZf8qtqtOSLXQUeI4ZKzoXqUupTKzOk3xNNb/Fhm2tcQKsI4ViPxkrMMX1Ler5oGQc4n+FGA4ruWPOPw8xpiLWN4NptIoZSGfWzt6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864609; c=relaxed/simple;
	bh=CDNDfApB9J/0Mo/v5bcYk9hHAjVgb50qdPNZKhoMavs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dVkLLcQARD1A/Qy1NVIlISZBBnhLaiDKto/yBRF9fuGpottZL5XcywIuZ5uHDSVVW+TjE7ySVofHCq1pQlfwGvadJvFv7HodocUyzm+FgocrXNcBaT/WgqYVYVl+LTBwYKP6k+ZKlPo8xp47P+lwr/DQ/m25XX4bBs7Kub0YE/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Obbk0Wwj; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 41292Quf322558
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 2 Feb 2024 01:02:30 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 41292Quf322558
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706864550;
	bh=tgJVLIOaqTWEKblzYegcEPlggy9ZwJZR9Relq2fS08A=;
	h=From:To:Cc:Subject:Date:From;
	b=Obbk0Wwj92zGl1WuVKYJihGs+dBMEkJwIBrBtDEpFNvIRwHbZZazIfhuD0ktbxmFv
	 kzZsz2/jqpRlkZ9/eOtRegQxyYMPSdWEDDbtNk8yLsDK4TGTF2ZnomwhqL+JonEIkH
	 92Nj4y8SsIdcG29xDd0mjoqPhg5MPC8MA76VELP6rpZyabYnX15YsD/clwMIQ8hIGG
	 ubMyXRRCHyIoFFVG+xfEz9RQ+DX3ZzDzetEpTg51kDW3P0BPb081Pa3GfYNzFC+Jc/
	 Lb3KYlHL7oCrnP2GlqFtM43EFMoA5WMh/sIbi3+vV5QT5fQIy9zFxQydpOevL0Xa5l
	 xKiGBWAH/jmCA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        sfr@canb.auug.org.au
Subject: [PATCH v1 1/1] x86/fred: Fix a build warning with allmodconfig
Date: Fri,  2 Feb 2024 01:02:24 -0800
Message-ID: <20240202090225.322544-1-xin@zytor.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change array_index_mask_nospec() to __always_inline because "inline" is
broken as https://www.kernel.org/doc/local/inline.html.

Fixes: 6786137bf8fd ("x86/fred: FRED entry/exit and dispatch code")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/lkml/20240201111453.0ee3beff@canb.auug.org.au/
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/include/asm/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 0216f63a366b..fe1e7e3cc844 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -33,7 +33,7 @@
  * Returns:
  *     0 - (index < size)
  */
-static inline unsigned long array_index_mask_nospec(unsigned long index,
+static __always_inline unsigned long array_index_mask_nospec(unsigned long index,
 		unsigned long size)
 {
 	unsigned long mask;

base-commit: 208d8c79fd0f155bce1b23d8d78926653f7603b7
-- 
2.43.0


