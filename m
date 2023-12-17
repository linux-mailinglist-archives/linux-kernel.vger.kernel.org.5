Return-Path: <linux-kernel+bounces-2490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B335B815DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE43B22A43
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D7320F1;
	Sun, 17 Dec 2023 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGp+NfaC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A020E6;
	Sun, 17 Dec 2023 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d47bb467a9so318623b3a.1;
        Sat, 16 Dec 2023 23:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702797200; x=1703402000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feSWUInibmppFuGNXnF0v3E6pdqKZ3fBbhHfQ61np4c=;
        b=dGp+NfaCZFRFtbtjtoIYcTHPqnW66HPvgXqU9bLFPxfxM98f4dPXBBGP1pKZYpshZk
         l/eE3XlMjGo3i8bOQBd8AmN1xY3B/VrtQ9Fw2NrMZ2+H2hOzaREKkEpoarFLF6Y9NB3K
         ir00N8ZwnSlz6+1mss4hUFYaNfppLP9Et/lRt7xCpLFdJxzNiX3SnnaLDuADexN7GoE5
         o8nZcAc6vXfyxCZYk2OUX//9ixMVnTaURIVEvL7McfPVTIfDEPVGSz5WCDXuEb26rNud
         ibd1Q9NPnZ7ZGWWs71GvdiAwkcWTzFMyD8MWbg6Gp89fwYhxVBClbkRSt9eH5yuCVljj
         J80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702797200; x=1703402000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=feSWUInibmppFuGNXnF0v3E6pdqKZ3fBbhHfQ61np4c=;
        b=eumC9GnRxtN/IGeNihJ8Us6kL3puQy/TmuyACMznwRvua8Fmc8EFGVS3qkzL67MSpC
         TDESJrR0P0Q2gz43t+QjmuzQujPtf4J+1jZPs5h5OHsFjqu69iKJh95I7goiPACoWgLv
         5684JXZqBcTVYcioa/B5tiNpN5W/2j+GfMGikpLfXyBavfD6BUuOlc8RNBP731rPxN3H
         OV1ifHi5yBTA17VhQQ9buoxLD4DEE5ClpKVdEVt6Czhb6tC+KCz56uwCV36NSxzfhJ+f
         n2b27ec7Y5yGVq5Dqgk5aCWuGN0C/9UvlNoYAt09t8A6q+EJ9apZg5lpx1r1rVrtNas2
         GCYg==
X-Gm-Message-State: AOJu0YyAo0V1hKZ8IH8a52ApRm31WFIFAsw+BREkJCZz3gSsakvLiFfj
	GpBRYk1Rrle0iOPMOvLRo7w=
X-Google-Smtp-Source: AGHT+IGqSESWQXTN78W86orpyfFDqNV9phDRlGiR1X9RzBIbvxCFThDNzhlc7ScbiAJmJsiX039f1w==
X-Received: by 2002:a05:6a20:8e14:b0:190:23b2:cf1a with SMTP id y20-20020a056a208e1400b0019023b2cf1amr17972903pzj.22.1702797199658;
        Sat, 16 Dec 2023 23:13:19 -0800 (PST)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000cd100b0068ffb8da107sm15740231pfv.212.2023.12.16.23.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 23:13:19 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marco Elver <elver@google.com>,
	Brian Cain <bcain@quicinc.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 1/5] m68k/bitops: force inlining of all bitops functions
Date: Sun, 17 Dec 2023 16:12:46 +0900
Message-Id: <20231217071250.892867-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231217071250.892867-1-mailhol.vincent@wanadoo.fr>
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
 <20231217071250.892867-1-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inline keyword actually does not guarantee that the compiler will
inline a functions. Whenever the goal is to actually inline a
function, __always_inline should always be preferred instead.

On an allyesconfig, with GCC 13.2.1, it saves roughly 5 KB.

  $ size --format=GNU vmlinux.before vmlinux.after
        text       data        bss      total filename
    60449738   70975612    2288988  133714338 vmlinux.before
    60446534   70972412    2289596  133708542 vmlinux.after

Reference: commit 8dd5032d9c54 ("x86/asm/bitops: Force inlining of
test_and_set_bit and friends")
Link: https://git.kernel.org/torvalds/c/8dd5032d9c54

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/m68k/include/asm/bitops.h | 87 +++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 14c64a6f1217..ae0457d582b8 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -28,7 +28,7 @@
  *	So we use the best form possible on a given platform.
  */
 
-static inline void bset_reg_set_bit(int nr, volatile unsigned long *vaddr)
+static __always_inline void bset_reg_set_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 
@@ -38,7 +38,7 @@ static inline void bset_reg_set_bit(int nr, volatile unsigned long *vaddr)
 		: "memory");
 }
 
-static inline void bset_mem_set_bit(int nr, volatile unsigned long *vaddr)
+static __always_inline void bset_mem_set_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 
@@ -47,7 +47,7 @@ static inline void bset_mem_set_bit(int nr, volatile unsigned long *vaddr)
 		: "di" (nr & 7));
 }
 
-static inline void bfset_mem_set_bit(int nr, volatile unsigned long *vaddr)
+static __always_inline void bfset_mem_set_bit(int nr, volatile unsigned long *vaddr)
 {
 	__asm__ __volatile__ ("bfset %1{%0:#1}"
 		:
@@ -71,7 +71,7 @@ arch___set_bit(unsigned long nr, volatile unsigned long *addr)
 	set_bit(nr, addr);
 }
 
-static inline void bclr_reg_clear_bit(int nr, volatile unsigned long *vaddr)
+static __always_inline void bclr_reg_clear_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 
@@ -81,7 +81,7 @@ static inline void bclr_reg_clear_bit(int nr, volatile unsigned long *vaddr)
 		: "memory");
 }
 
-static inline void bclr_mem_clear_bit(int nr, volatile unsigned long *vaddr)
+static __always_inline void bclr_mem_clear_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 
@@ -90,7 +90,7 @@ static inline void bclr_mem_clear_bit(int nr, volatile unsigned long *vaddr)
 		: "di" (nr & 7));
 }
 
-static inline void bfclr_mem_clear_bit(int nr, volatile unsigned long *vaddr)
+static __always_inline void bfclr_mem_clear_bit(int nr, volatile unsigned long *vaddr)
 {
 	__asm__ __volatile__ ("bfclr %1{%0:#1}"
 		:
@@ -114,7 +114,7 @@ arch___clear_bit(unsigned long nr, volatile unsigned long *addr)
 	clear_bit(nr, addr);
 }
 
-static inline void bchg_reg_change_bit(int nr, volatile unsigned long *vaddr)
+static __always_inline void bchg_reg_change_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 
@@ -124,7 +124,7 @@ static inline void bchg_reg_change_bit(int nr, volatile unsigned long *vaddr)
 		: "memory");
 }
 
-static inline void bchg_mem_change_bit(int nr, volatile unsigned long *vaddr)
+static __always_inline void bchg_mem_change_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 
@@ -133,7 +133,7 @@ static inline void bchg_mem_change_bit(int nr, volatile unsigned long *vaddr)
 		: "di" (nr & 7));
 }
 
-static inline void bfchg_mem_change_bit(int nr, volatile unsigned long *vaddr)
+static __always_inline void bfchg_mem_change_bit(int nr, volatile unsigned long *vaddr)
 {
 	__asm__ __volatile__ ("bfchg %1{%0:#1}"
 		:
@@ -160,8 +160,8 @@ arch___change_bit(unsigned long nr, volatile unsigned long *addr)
 #define arch_test_bit generic_test_bit
 #define arch_test_bit_acquire generic_test_bit_acquire
 
-static inline int bset_reg_test_and_set_bit(int nr,
-					    volatile unsigned long *vaddr)
+static __always_inline int
+bset_reg_test_and_set_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	char retval;
@@ -173,8 +173,8 @@ static inline int bset_reg_test_and_set_bit(int nr,
 	return retval;
 }
 
-static inline int bset_mem_test_and_set_bit(int nr,
-					    volatile unsigned long *vaddr)
+static __always_inline int
+bset_mem_test_and_set_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	char retval;
@@ -185,8 +185,8 @@ static inline int bset_mem_test_and_set_bit(int nr,
 	return retval;
 }
 
-static inline int bfset_mem_test_and_set_bit(int nr,
-					     volatile unsigned long *vaddr)
+static __always_inline int
+bfset_mem_test_and_set_bit(int nr, volatile unsigned long *vaddr)
 {
 	char retval;
 
@@ -213,8 +213,8 @@ arch___test_and_set_bit(unsigned long nr, volatile unsigned long *addr)
 	return test_and_set_bit(nr, addr);
 }
 
-static inline int bclr_reg_test_and_clear_bit(int nr,
-					      volatile unsigned long *vaddr)
+static __always_inline int
+bclr_reg_test_and_clear_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	char retval;
@@ -226,8 +226,8 @@ static inline int bclr_reg_test_and_clear_bit(int nr,
 	return retval;
 }
 
-static inline int bclr_mem_test_and_clear_bit(int nr,
-					      volatile unsigned long *vaddr)
+static __always_inline int
+bclr_mem_test_and_clear_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	char retval;
@@ -238,8 +238,8 @@ static inline int bclr_mem_test_and_clear_bit(int nr,
 	return retval;
 }
 
-static inline int bfclr_mem_test_and_clear_bit(int nr,
-					       volatile unsigned long *vaddr)
+static __always_inline int
+bfclr_mem_test_and_clear_bit(int nr, volatile unsigned long *vaddr)
 {
 	char retval;
 
@@ -266,8 +266,8 @@ arch___test_and_clear_bit(unsigned long nr, volatile unsigned long *addr)
 	return test_and_clear_bit(nr, addr);
 }
 
-static inline int bchg_reg_test_and_change_bit(int nr,
-					       volatile unsigned long *vaddr)
+static __always_inline int
+bchg_reg_test_and_change_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	char retval;
@@ -279,8 +279,8 @@ static inline int bchg_reg_test_and_change_bit(int nr,
 	return retval;
 }
 
-static inline int bchg_mem_test_and_change_bit(int nr,
-					       volatile unsigned long *vaddr)
+static __always_inline int
+bchg_mem_test_and_change_bit(int nr, volatile unsigned long *vaddr)
 {
 	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	char retval;
@@ -291,8 +291,8 @@ static inline int bchg_mem_test_and_change_bit(int nr,
 	return retval;
 }
 
-static inline int bfchg_mem_test_and_change_bit(int nr,
-						volatile unsigned long *vaddr)
+static __always_inline int
+bfchg_mem_test_and_change_bit(int nr, volatile unsigned long *vaddr)
 {
 	char retval;
 
@@ -319,8 +319,8 @@ arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
 	return test_and_change_bit(nr, addr);
 }
 
-static inline bool xor_unlock_is_negative_byte(unsigned long mask,
-		volatile unsigned long *p)
+static __always_inline bool
+xor_unlock_is_negative_byte(unsigned long mask, volatile unsigned long *p)
 {
 #ifdef CONFIG_COLDFIRE
 	__asm__ __volatile__ ("eorl %1, %0"
@@ -350,8 +350,8 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
 #include <asm-generic/bitops/ffz.h>
 #else
 
-static inline int find_first_zero_bit(const unsigned long *vaddr,
-				      unsigned size)
+static __always_inline int
+find_first_zero_bit(const unsigned long *vaddr, unsigned size)
 {
 	const unsigned long *p = vaddr;
 	int res = 32;
@@ -376,8 +376,8 @@ static inline int find_first_zero_bit(const unsigned long *vaddr,
 }
 #define find_first_zero_bit find_first_zero_bit
 
-static inline int find_next_zero_bit(const unsigned long *vaddr, int size,
-				     int offset)
+static __always_inline int
+find_next_zero_bit(const unsigned long *vaddr, int size, int offset)
 {
 	const unsigned long *p = vaddr + (offset >> 5);
 	int bit = offset & 31UL, res;
@@ -406,7 +406,8 @@ static inline int find_next_zero_bit(const unsigned long *vaddr, int size,
 }
 #define find_next_zero_bit find_next_zero_bit
 
-static inline int find_first_bit(const unsigned long *vaddr, unsigned size)
+static __always_inline int
+find_first_bit(const unsigned long *vaddr, unsigned size)
 {
 	const unsigned long *p = vaddr;
 	int res = 32;
@@ -431,8 +432,8 @@ static inline int find_first_bit(const unsigned long *vaddr, unsigned size)
 }
 #define find_first_bit find_first_bit
 
-static inline int find_next_bit(const unsigned long *vaddr, int size,
-				int offset)
+static __always_inline int
+find_next_bit(const unsigned long *vaddr, int size, int offset)
 {
 	const unsigned long *p = vaddr + (offset >> 5);
 	int bit = offset & 31UL, res;
@@ -465,7 +466,7 @@ static inline int find_next_bit(const unsigned long *vaddr, int size,
  * ffz = Find First Zero in word. Undefined if no zero exists,
  * so code should check against ~0UL first..
  */
-static inline unsigned long ffz(unsigned long word)
+static __always_inline unsigned long ffz(unsigned long word)
 {
 	int res;
 
@@ -488,7 +489,7 @@ static inline unsigned long ffz(unsigned long word)
  */
 #if (defined(__mcfisaaplus__) || defined(__mcfisac__)) && \
 	!defined(CONFIG_M68000)
-static inline unsigned long __ffs(unsigned long x)
+static __always_inline unsigned long __ffs(unsigned long x)
 {
 	__asm__ __volatile__ ("bitrev %0; ff1 %0"
 		: "=d" (x)
@@ -496,7 +497,7 @@ static inline unsigned long __ffs(unsigned long x)
 	return x;
 }
 
-static inline int ffs(int x)
+static __always_inline int ffs(int x)
 {
 	if (!x)
 		return 0;
@@ -518,7 +519,7 @@ static inline int ffs(int x)
  *	the libc and compiler builtin ffs routines, therefore
  *	differs in spirit from the above ffz (man ffs).
  */
-static inline int ffs(int x)
+static __always_inline int ffs(int x)
 {
 	int cnt;
 
@@ -528,7 +529,7 @@ static inline int ffs(int x)
 	return 32 - cnt;
 }
 
-static inline unsigned long __ffs(unsigned long x)
+static __always_inline unsigned long __ffs(unsigned long x)
 {
 	return ffs(x) - 1;
 }
@@ -536,7 +537,7 @@ static inline unsigned long __ffs(unsigned long x)
 /*
  *	fls: find last bit set.
  */
-static inline int fls(unsigned int x)
+static __always_inline int fls(unsigned int x)
 {
 	int cnt;
 
@@ -546,7 +547,7 @@ static inline int fls(unsigned int x)
 	return 32 - cnt;
 }
 
-static inline unsigned long __fls(unsigned long x)
+static __always_inline unsigned long __fls(unsigned long x)
 {
 	return fls(x) - 1;
 }
-- 
2.25.1


