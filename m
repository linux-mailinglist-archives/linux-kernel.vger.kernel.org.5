Return-Path: <linux-kernel+bounces-52940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A58849EA3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B607287421
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B7D3A1C3;
	Mon,  5 Feb 2024 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8QwCwui"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442073589C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147723; cv=none; b=UEirsOra+xqzZGdQBRm06uROnuDecLlxIDwHrXW6eo4Sbxxz2bqA2Snvhhyqv8pPDqugYmu1x0tmIkktzFO27nDjxyN6e6OXxsUq0CfV4ZkvyeUGdnjygV8v+RBe4O0nJI0iJdrMBuyX1R8VSR8+Wkq6qs5/HnHD5VuPI2QiHCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147723; c=relaxed/simple;
	bh=53b2H8uF29g5f+ZgMeGd29yJbLCDFBzBlvwx1MeFTPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0D+l+2qZ6s/nXGxCr90Li7pVvW5Xei1T68n7y7huE35rCdLERjU9R0AssUtkHocjSDANndBD7Z1sg5cy7ADF1gNlvPVYIKboSAUHDRyb2KuOnY5E3g4gL9E7hK2qXLfVBdM8zEbXVlkQv4u6qaDMjhZWPNoacibL5loI4jVn1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8QwCwui; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d98fc5ebceso7120705ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707147720; x=1707752520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBc4fLjatrXpASlD/WVnTmp4iXcVx1KBzPpDYNmB8KU=;
        b=i8QwCwui1Lum9A1xpb34U0E6XudnBJhBnDABM1gzAPD0l9gU77GSKhAB6YAEu+QGIo
         AzmD0xNg0YWxjzZUHhplJlUXM1OnkLZUZWK7wutxM2q0BFInnV8r8oXFqaXOBGmDvKDs
         51iM/3ULGbCORejutK05yrdY3+WAtO60iLd7ZmHoeHjfTyAoFRmiZu93uZkLkCzc1gpr
         CVpFwZpKG8ff3+o/Py48TWGGxKzXxCYUFxRkSYU6n4NOZ6aT66SgrLKox0ab0uKU0D3r
         JE0AZQiPjpVOtqu1WYH68gN/uUBRngsD5QvfT8CKjWbXqaxRC+d6aIP0fyKbMZKZw3Tz
         mNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707147720; x=1707752520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBc4fLjatrXpASlD/WVnTmp4iXcVx1KBzPpDYNmB8KU=;
        b=scFEqP/MddUUkh2mNXCbtPcrpghzxpqSSsCdsOYhutXVV/tdRY3UQTNIUrbdCQ4eFh
         nlhxOiVfDT/loMgJaAxxvcGEJXtJ1RYaBJQYMKu7zsUqv5jge9Dsxr3aUgSk63jCTf9+
         G6rtQkQvLC+BEq/+ij5+1fGF8mgLpfyOC4c3gfAi7x/hR5ia7FVGQlbV6oWjY+87yUUW
         qIw1K8wSBEn/uYcnj8p7/DuVqKXFhXHF510+7L5fM/OdITsG5sbg1yaxwL4v7IT8s5DG
         DNBK+PtxC4oIgKzpm0YOlcMXxa57m3i9KH3+CLFoMsNyxMrXoY9RexPGxLmwUsxY6ShX
         l7Qw==
X-Gm-Message-State: AOJu0Yz5Ac0UYCMLhVeApCZlEX7h6mjt54jEuO4VdnkaUOcOHmax7m/4
	I65p4Uw+O1iQzpYnD7h4NXQEumEdCHQTwzTuip75t3o+Gf0UOV2N
X-Google-Smtp-Source: AGHT+IFa60vwbhiLC3KHxBDj3pj07TOapnYwrlrH7l61oHAatkapvrje4wYvZjjJjzdKrsZTGMK7Qw==
X-Received: by 2002:a17:903:40c4:b0:1d9:9fa2:a0b4 with SMTP id t4-20020a17090340c400b001d99fa2a0b4mr4512229pld.66.1707147720292;
        Mon, 05 Feb 2024 07:42:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUQN9wfp6UC88AploE6+ZJapT/z6lIHI5mkXVzCwf/z3/vRM5yQOMaPI+85GRn0VJhpP408gle1gklCtbulFsie/wKxp2KOGHQ1iyBNB2hQqQxoC9iIQvUU/8k4b7423QIJLOjUaAV8F0DqjNXwdbB6rHrkn8F3h31kqKOzxUQH/cL1QxM1W1Dns6Hejt2M2lH4H9XKG4FaQx/1w3nTLS+zahxeT3y9UDvkFpGdcjhWqPn0KzLXe9mwBLKBNFAYxgQrndF03JGNszEaMzYTUj9Q3F6xYvljz+k6b+zOLUvD9Uc+1DBdB5GvGB33gHw0S/RjfxfGHztZgH1IqLu4eISs/Zlr9AY8s4UYDKcW19cO/iguLqstZGcgt+lTAzXi8Wpm5cwnuDcQqs+64iaWuFSI7TH8ytj/WMQSxuoY3E1X7sgzX/xgQIehfsPH3HJOIxX5XPTI/bJM5vlORlbipOV9s7Z3J0ajrL6NA0fkgWV9uJDqwH7wRPQgWO8KKH/vZsha9rXMTnrGqwQPJuGBbY19ngfz54bpOI3UtgcwMi5vOn41A5cJh1qrI08GLlVD7tPetCmITHcbtficmcnJp00=
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id s9-20020a170903320900b001d8a5c08277sm4438plh.260.2024.02.05.07.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:41:59 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: fthain@linux-m68k.org
Cc: mailhol.vincent@wanadoo.fr,
	David.Laight@aculab.com,
	akpm@linux-foundation.org,
	bcain@quicinc.com,
	dianders@chromium.org,
	elver@google.com,
	geert+renesas@glider.be,
	geert@linux-m68k.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	ndesaulniers@google.com,
	paulmck@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	willy@infradead.org,
	yury.norov@gmail.com,
	zhaoyang.huang@unisoc.com
Subject: [PATCH] m68k/bitops: always use compiler's builtin for bit finding functions
Date: Tue,  6 Feb 2024 00:40:37 +0900
Message-ID: <20240205154143.1004442-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAMZ6RqLkCPuy+mQxp0HuVBgfSiFgFOwimYm1Ro7ESANyF-fRyg@mail.gmail.com>
References: <CAMZ6RqLkCPuy+mQxp0HuVBgfSiFgFOwimYm1Ro7ESANyF-fRyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC and clang provides a set of builtin functions which can be used as
a replacement for ffs(), __ffs(), fls() and __fls().

Using the builtin comes as a trade-off.

Pros:

  - Simpler code, easier to maintain
  - Guarantee the constant folding

Cons:

  - clang does not provide optimized code. Ref:
    https://godbolt.org/z/Yb8nMKnYf

Despite of the cons, use the builtin unconditionally and remove any
existing assembly implementation.

This done, remove the find_first_zero_bit(), find_next_zero_bit(),
find_first_bit() and find_next_bit() assembly implementations.
Instead, rely on the generic functions from linux/find.h which will
themselves rely on the builtin we just set up.

Not-signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
As written earlier, I do not want to sign-off a patch which can
degrade the performances of m68k clang users. But because it is
already written, there it is.

If someone wants to pick up this, go ahead. Just make sure to remove
any reference to myself. I hereby grant permission for anyone to reuse
that patch, with or without modifications, under the unique condition
that my name gets removed.
---
 arch/m68k/include/asm/bitops.h | 215 +--------------------------------
 1 file changed, 5 insertions(+), 210 deletions(-)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 14c64a6f1217..44aac8ced9fc 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -340,218 +340,13 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
 #endif
 }
 
-/*
- *	The true 68020 and more advanced processors support the "bfffo"
- *	instruction for finding bits. ColdFire and simple 68000 parts
- *	(including CPU32) do not support this. They simply use the generic
- *	functions.
- */
-#if defined(CONFIG_CPU_HAS_NO_BITFIELDS)
-#include <asm-generic/bitops/ffz.h>
-#else
-
-static inline int find_first_zero_bit(const unsigned long *vaddr,
-				      unsigned size)
-{
-	const unsigned long *p = vaddr;
-	int res = 32;
-	unsigned int words;
-	unsigned long num;
-
-	if (!size)
-		return 0;
-
-	words = (size + 31) >> 5;
-	while (!(num = ~*p++)) {
-		if (!--words)
-			goto out;
-	}
-
-	__asm__ __volatile__ ("bfffo %1{#0,#0},%0"
-			      : "=d" (res) : "d" (num & -num));
-	res ^= 31;
-out:
-	res += ((long)p - (long)vaddr - 4) * 8;
-	return res < size ? res : size;
-}
-#define find_first_zero_bit find_first_zero_bit
-
-static inline int find_next_zero_bit(const unsigned long *vaddr, int size,
-				     int offset)
-{
-	const unsigned long *p = vaddr + (offset >> 5);
-	int bit = offset & 31UL, res;
-
-	if (offset >= size)
-		return size;
-
-	if (bit) {
-		unsigned long num = ~*p++ & (~0UL << bit);
-		offset -= bit;
-
-		/* Look for zero in first longword */
-		__asm__ __volatile__ ("bfffo %1{#0,#0},%0"
-				      : "=d" (res) : "d" (num & -num));
-		if (res < 32) {
-			offset += res ^ 31;
-			return offset < size ? offset : size;
-		}
-		offset += 32;
-
-		if (offset >= size)
-			return size;
-	}
-	/* No zero yet, search remaining full bytes for a zero */
-	return offset + find_first_zero_bit(p, size - offset);
-}
-#define find_next_zero_bit find_next_zero_bit
-
-static inline int find_first_bit(const unsigned long *vaddr, unsigned size)
-{
-	const unsigned long *p = vaddr;
-	int res = 32;
-	unsigned int words;
-	unsigned long num;
-
-	if (!size)
-		return 0;
-
-	words = (size + 31) >> 5;
-	while (!(num = *p++)) {
-		if (!--words)
-			goto out;
-	}
-
-	__asm__ __volatile__ ("bfffo %1{#0,#0},%0"
-			      : "=d" (res) : "d" (num & -num));
-	res ^= 31;
-out:
-	res += ((long)p - (long)vaddr - 4) * 8;
-	return res < size ? res : size;
-}
-#define find_first_bit find_first_bit
-
-static inline int find_next_bit(const unsigned long *vaddr, int size,
-				int offset)
-{
-	const unsigned long *p = vaddr + (offset >> 5);
-	int bit = offset & 31UL, res;
-
-	if (offset >= size)
-		return size;
-
-	if (bit) {
-		unsigned long num = *p++ & (~0UL << bit);
-		offset -= bit;
-
-		/* Look for one in first longword */
-		__asm__ __volatile__ ("bfffo %1{#0,#0},%0"
-				      : "=d" (res) : "d" (num & -num));
-		if (res < 32) {
-			offset += res ^ 31;
-			return offset < size ? offset : size;
-		}
-		offset += 32;
-
-		if (offset >= size)
-			return size;
-	}
-	/* No one yet, search remaining full bytes for a one */
-	return offset + find_first_bit(p, size - offset);
-}
-#define find_next_bit find_next_bit
-
-/*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
- */
-static inline unsigned long ffz(unsigned long word)
-{
-	int res;
-
-	__asm__ __volatile__ ("bfffo %1{#0,#0},%0"
-			      : "=d" (res) : "d" (~word & -~word));
-	return res ^ 31;
-}
-
-#endif
-
 #ifdef __KERNEL__
 
-#if defined(CONFIG_CPU_HAS_NO_BITFIELDS)
-
-/*
- *	The newer ColdFire family members support a "bitrev" instruction
- *	and we can use that to implement a fast ffs. Older Coldfire parts,
- *	and normal 68000 parts don't have anything special, so we use the
- *	generic functions for those.
- */
-#if (defined(__mcfisaaplus__) || defined(__mcfisac__)) && \
-	!defined(CONFIG_M68000)
-static inline unsigned long __ffs(unsigned long x)
-{
-	__asm__ __volatile__ ("bitrev %0; ff1 %0"
-		: "=d" (x)
-		: "0" (x));
-	return x;
-}
-
-static inline int ffs(int x)
-{
-	if (!x)
-		return 0;
-	return __ffs(x) + 1;
-}
-
-#else
-#include <asm-generic/bitops/ffs.h>
-#include <asm-generic/bitops/__ffs.h>
-#endif
-
-#include <asm-generic/bitops/fls.h>
-#include <asm-generic/bitops/__fls.h>
-
-#else
-
-/*
- *	ffs: find first bit set. This is defined the same way as
- *	the libc and compiler builtin ffs routines, therefore
- *	differs in spirit from the above ffz (man ffs).
- */
-static inline int ffs(int x)
-{
-	int cnt;
-
-	__asm__ ("bfffo %1{#0:#0},%0"
-		: "=d" (cnt)
-		: "dm" (x & -x));
-	return 32 - cnt;
-}
-
-static inline unsigned long __ffs(unsigned long x)
-{
-	return ffs(x) - 1;
-}
-
-/*
- *	fls: find last bit set.
- */
-static inline int fls(unsigned int x)
-{
-	int cnt;
-
-	__asm__ ("bfffo %1{#0,#0},%0"
-		: "=d" (cnt)
-		: "dm" (x));
-	return 32 - cnt;
-}
-
-static inline unsigned long __fls(unsigned long x)
-{
-	return fls(x) - 1;
-}
-
-#endif
+#include <asm-generic/bitops/builtin-ffs.h>
+#include <asm-generic/bitops/builtin-__ffs.h>
+#include <asm-generic/bitops/builtin-fls.h>
+#include <asm-generic/bitops/builtin-__fls.h>
+#include <asm-generic/bitops/ffz.h>
 
 /* Simple test-and-set bit locks */
 #define test_and_set_bit_lock	test_and_set_bit
-- 
2.43.0


