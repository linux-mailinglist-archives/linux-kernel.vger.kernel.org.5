Return-Path: <linux-kernel+bounces-54325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B84A784ADAA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F2B285C46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775CA77F2E;
	Tue,  6 Feb 2024 04:42:56 +0000 (UTC)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9579DC6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194576; cv=none; b=AAixQWQhsk4ySzxfYWcnRoNqBE5+4c8SbKM3YW/9mCVPEQxsrDyUySpo4M8Ppyo3iHOjCCE5NVCqLqF5Eb7dz1gboq3q+6ynTiLsVrnwFI4rcPcibDCJlQsLdxOuPB1FmW2UdorK0r26WQpbgVFNwf0Qj2jokwLdCS8jeGPBixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194576; c=relaxed/simple;
	bh=nc0jLkuc57sYljrMKMUObIFnwLlI3hm99D6/F9t3tXQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Lu3CW3RtB4bZLD+MgFa93Y1zVXxPhg9L6Eyy6SO+X/XEnMVpEgRbgTwn1mTiyDIe11gOL7iS4Au3nt0l/YYhd/kdv9tQXiKLjebUu6azy1kuka8rcVbmlTYQo4zNewzJIVMZiXlJ/RVpjQl7vAfeIqGyqsM+N4gq5axjxn/P4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: bizesmtp91t1707194541t9xd589g
X-QQ-Originating-IP: pMzahIqg6H5dlPo+vAhyxexMUr3RLOXUZCog16Pyj2M=
Received: from ubuntu1.. ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 06 Feb 2024 12:42:19 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: 0vfWcIgh24yhEjsGKgTjDSuqmFqO91+wU93WDdBJmkdGhNU+EQTKp6T9wFfHE
	olJfbkXSl/UD1IDL1lpyYWuZoBKR2L2POs7sSK6FcxK1VX9S/a9GHCXPvGihUkjQxrXQfpL
	qqUVUzZFca0MGPliNtXrVYcMSvNVHq1WbP7lxKqLNyR21PSIi+AvS/32OST/Zj+5jt7DNng
	nkRODrT+5JhpFwTTafFJEzFmj8NBCOWbaZbY/46bYa6LWKMFSg+SHcf6JqYY42pj7QRkH05
	2tjOmG/3g55LOROKes7bYsuSxZL5+VMzrCv+1pZ8JOSc4NB7xBzPbWZPV/Kv7JkxRBo6hon
	lcEUggmWI7xYFQel30=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11924492051614252062
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
Subject: [PATCH] riscv: vector: Fix a typo of preempt_v
Date: Tue,  6 Feb 2024 12:42:17 +0800
Message-Id: <20240206044217.1283849-1-songshuaishuai@tinylab.org>
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

Here corrects the miss-spelling "prempt_v".

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/include/asm/simd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/simd.h b/arch/riscv/include/asm/simd.h
index 54efbf523d49..04baee713eff 100644
--- a/arch/riscv/include/asm/simd.h
+++ b/arch/riscv/include/asm/simd.h
@@ -36,7 +36,7 @@ static __must_check inline bool may_use_simd(void)
 	/*
 	 * Nesting is acheived in preempt_v by spreading the control for
 	 * preemptible and non-preemptible kernel-mode Vector into two fields.
-	 * Always try to match with prempt_v if kernel V-context exists. Then,
+	 * Always try to match with preempt_v if kernel V-context exists. Then,
 	 * fallback to check non preempt_v if nesting happens, or if the config
 	 * is not set.
 	 */
-- 
2.39.2


