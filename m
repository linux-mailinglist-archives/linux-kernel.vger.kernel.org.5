Return-Path: <linux-kernel+bounces-73989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E892685CE87
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFED41C23237
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288782BAE7;
	Wed, 21 Feb 2024 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="frPaumst"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98B2F36
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484601; cv=none; b=TbJmPPWWNI5H4Wza3yJQ9EZL+ZjxJmIPYobAnpIWCphihYcXHxwH+cZDtiRsWOJ5QKJLJmeKciM9c6tUw31UwKl9jqzqgHj5qd2cjjJHrUaMdJ10ZFRBgGwnQZmQKbiv4ZDeXu8zmCZoM/KW+IfhUMhB+RIR2DsK+1I4HrBnBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484601; c=relaxed/simple;
	bh=oobwvJOSlJZ6jqTkxaLxre6wjaVBnYmAyPVTnY+MfJM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=sXhwbqwmSuXX0XAWmqWZsUp3z+Uql/Bjywa93A0Mokn6DvkeBHJTMO2LTbRvEjFcjFWbb8xYen0zx7RJBLAqfeU/fPNYfyMoahMi78py069+xPj3VISf1gDRu6WFBmo/TaOu/Ra7djxJGX3j/EKej9vb1SbUL1fffr+SXSCvFoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=frPaumst; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708484589; bh=LKI66u4dgr+7iwYTp927KXhXTPqMfb6/+YRPw56ONE4=;
	h=From:To:Cc:Subject:Date;
	b=frPaumstbBFv47/rdxEFDJLe4zIYNI5yWDb8mM4pf6ydyw4Hqn6mbKxrwA+Yp1sw3
	 XjCb0F7jFT6Q0WrH+++6upH+oL0KTODunCAFQmjFbiuUAa7CPec3Dh9D1GVHstXMIn
	 r9hO3+WXwz5Qptm8RIT1laiXH3xBFQ4t1JFlir1U=
Received: from cyy-pc.lan ([240e:379:2240:ef00:159c:db93:bdcd:c9c6])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id C5A0C88; Wed, 21 Feb 2024 11:03:05 +0800
X-QQ-mid: xmsmtpt1708484585txbs3v0gn
Message-ID: <tencent_E19FA1A095768063102E654C6FC858A32F06@qq.com>
X-QQ-XMAILINFO: OUnVc07lD2ZBmrI0ZhjTbaZSf3JrAeZvIVT6kjHJ26bXBjMScunXxm1aDNZZKQ
	 /X/0IbcXbZ2RgT8zWVbJ9Or//pv5wVpAsfgTCHTb0t4ud6fWvmCH6mL82nuOjSk6/qeQ8LRZQBO8
	 8fbHDB1JF1SUl/Ova/4VF68qRq7N+tdwe/kceR1I+X8S7JtQFRoUCu+QRGSX5auPoW7zMccfPGgF
	 csuJjMy61fN3y9sSZkZ8alcyAr4/kU7vU0Ul/yJoiTNU4Jyi+JUCNpZaULAdpgqo1FXBUfzWCMfh
	 994NDiDExo5GjgDnf7OSDXQXmf9yHwGpScNSfEQ7YdofkkcOiedu6zxodZbriXjvZdzbB+gsfzf3
	 P3p8ynZDcDqNdWUCYR1mDsjOgZNUk/QaC2IHmdBXyRzsaitWiJH7D/w0ZTxvZEj+CplhxOvcdRDb
	 zk9berts7PfJWpbYb6pY9aTJiB7/mUWzzvllshAernW9m6UZ22EchXrOwN64b3lXmdLNVgAsVyzk
	 vC+V6Iue9wFWAwW8dGMXv9aCHg4tyEWfYa4roEfIZKBoY8SHv/y4mDsP/C9VaWpyqw9YJtjcvBIk
	 +a0x210bc7oc84PeoLUeAK4DncF/i7t6QBFnf8KszULRdSQLiQ4qRV/LsQnEZ5fBKac5xynLBVYB
	 RzFpnfmftmwafv5dmkBR9NpOscvCC2nroj9kc8fRAF5x6ZjKpAZcoXOnmDoIittaDitwQpY8Kwo8
	 yWKgmNmzcoBRDZ9BnrpOdQ6/Kht50BLNP2Kk70f8tTUcLI5PzDBhNRauTdXVuRg6569JpxiB3aQP
	 NENXpQQWq36kZr7hO3GZwYJ9RNHILSgSQzO9s+jYaOdYiOxrzwq6uIyVW5YCLESDnR5YommNMggM
	 a+9nT/Ic6sDUBVr9aOT0Gk/4TnEHlzooLRHraW8pN9S2iLiTGZX+CL4pn7bys4+k3L/MLV4mAPri
	 5AkTJsC6bl4Md5U3zGvUlz3r0E8QBFu4BKxrJq31Ru8ka9sSneuKyeqDeMdNxrIqJUDrB80MfNnu
	 AJdMvN59mRU4LF9QPn
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Guo Ren <guoren@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2] riscv: mm: fix NOCACHE_THEAD does not set bit[61] correctly
Date: Wed, 21 Feb 2024 11:02:31 +0800
X-OQ-MSGID: <20240221030231.3413066-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commit dbfbda3bd6bf ("riscv: mm: update T-Head memory type
definitions") from patch [1] missed a `<` for bit shifting, result in
bit(61) does not set in _PAGE_NOCACHE_THEAD and leaves bit(0) set instead.
This patch get this fixed.

Changes since v1:
* reword commit message and add reviewed-by

Link: https://lore.kernel.org/linux-riscv/20230912072510.2510-1-jszhang@kernel.org/ [1]
Fixes: dbfbda3bd6bf ("riscv: mm: update T-Head memory type definitions")
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/pgtable-64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index b42017d76924..b99bd66107a6 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -136,7 +136,7 @@ enum napot_cont_order {
  * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
  */
 #define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
-#define _PAGE_NOCACHE_THEAD	((1UL < 61) | (1UL << 60))
+#define _PAGE_NOCACHE_THEAD	((1UL << 61) | (1UL << 60))
 #define _PAGE_IO_THEAD		((1UL << 63) | (1UL << 60))
 #define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
 
-- 
2.43.0


