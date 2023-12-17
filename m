Return-Path: <linux-kernel+bounces-2492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E1F815DDB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D76281319
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BB76AAD;
	Sun, 17 Dec 2023 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aroyU7BJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6695D63AA;
	Sun, 17 Dec 2023 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b844357f7cso1696781b6e.1;
        Sat, 16 Dec 2023 23:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702797210; x=1703402010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZV393vzARRuX2pwqmw5hE6OeimRr0obKDvqio21m2gk=;
        b=aroyU7BJ9ZlRKHGgR74IRmjfYNtOpZUSPvCmssf5fHitT+f9GRoOtub54UyCsuS/bh
         zR/kVGnGFK+29Pm7Jk9oJlBNvn3R2rCe4Y+gYt+w/c0U/tNHtDi7kkblkVATZN8kZPDb
         rGivcnP3RWvjOl66y3A4N5EBuVqNQQ9EJixBTm+WKh7BiJEdn++fVF7x18DR3Zsf3dD8
         EMmGdBBE1ibhlFbcjdSPujg0cLEWGlkPEpsXlL/gZKZI3UoZ9NW4uA5T0M7jMPkchsQb
         OwaW6m4SCFODGAuuHfnSZjxIeoE8EZTu584Y4/Pg/mqwjlBlvwsh/StOXyRcPf76xQaJ
         n4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702797210; x=1703402010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZV393vzARRuX2pwqmw5hE6OeimRr0obKDvqio21m2gk=;
        b=EeoBEIA9XdeZqJkn5K5nwyB0m64T9iYHnWpfE2jKZRBNViC4laeJdD/vzP4m77/EjT
         ImEimEqRCkAZ4GYxwZvOOUrb4gmDp+E0n63uVLce93lmyXEngrKT3n9G2oVEuPl3qT2n
         uuC1vaOuik8jOl3LqJDkx70IwxtM+gXfVqLv4pnNsTJaoMxpgoMjBf2LnzWNHji9r5Za
         UEND++N28AYZ4l+v4QzuxEG126ewRKxKjgIebTn4N8v6n6sNWRAWhTLxuyhmBRpReJUY
         xMVWmCB8zwpoXdvK44q3mBsGQsjqQHPbgCa4IdnuZdWCeCxW/rHV1Hduos/FxzYuQ5Mc
         LxNA==
X-Gm-Message-State: AOJu0YzIqnZq2SVZY93zEXG0uhPVJ1UWLL0XawxhxWfljmG9ZZ0se4QF
	BgHz5ZHAf92VBTTkA7U8Cmg=
X-Google-Smtp-Source: AGHT+IF8q2ujwJLtWhsj+hSoyYr3CajraUBLSb5x/4VREsRp3/VoULFMci56eN2ewnOAYG0hVRU8NQ==
X-Received: by 2002:a05:6808:2125:b0:3b8:b063:6b96 with SMTP id r37-20020a056808212500b003b8b0636b96mr19083767oiw.69.1702797210271;
        Sat, 16 Dec 2023 23:13:30 -0800 (PST)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000cd100b0068ffb8da107sm15740231pfv.212.2023.12.16.23.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 23:13:29 -0800 (PST)
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
Subject: [PATCH v3 3/5] hexagon/bitops: force inlining of all bitops functions
Date: Sun, 17 Dec 2023 16:12:48 +0900
Message-Id: <20231217071250.892867-4-mailhol.vincent@wanadoo.fr>
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

Reference: commit 8dd5032d9c54 ("x86/asm/bitops: Force inlining of
test_and_set_bit and friends")
Link: https://git.kernel.org/torvalds/c/8dd5032d9c54

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/hexagon/include/asm/bitops.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index 160d8f37fa1a..950d4acc2edc 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -28,7 +28,7 @@
  * @nr:  bit number to clear
  * @addr:  pointer to memory
  */
-static inline int test_and_clear_bit(int nr, volatile void *addr)
+static __always_inline int test_and_clear_bit(int nr, volatile void *addr)
 {
 	int oldval;
 
@@ -52,7 +52,7 @@ static inline int test_and_clear_bit(int nr, volatile void *addr)
  * @nr:  bit number to set
  * @addr:  pointer to memory
  */
-static inline int test_and_set_bit(int nr, volatile void *addr)
+static __always_inline int test_and_set_bit(int nr, volatile void *addr)
 {
 	int oldval;
 
@@ -78,7 +78,7 @@ static inline int test_and_set_bit(int nr, volatile void *addr)
  * @nr:  bit number to set
  * @addr:  pointer to memory
  */
-static inline int test_and_change_bit(int nr, volatile void *addr)
+static __always_inline int test_and_change_bit(int nr, volatile void *addr)
 {
 	int oldval;
 
@@ -103,17 +103,17 @@ static inline int test_and_change_bit(int nr, volatile void *addr)
  * Rewrite later to save a cycle or two.
  */
 
-static inline void clear_bit(int nr, volatile void *addr)
+static __always_inline void clear_bit(int nr, volatile void *addr)
 {
 	test_and_clear_bit(nr, addr);
 }
 
-static inline void set_bit(int nr, volatile void *addr)
+static __always_inline void set_bit(int nr, volatile void *addr)
 {
 	test_and_set_bit(nr, addr);
 }
 
-static inline void change_bit(int nr, volatile void *addr)
+static __always_inline void change_bit(int nr, volatile void *addr)
 {
 	test_and_change_bit(nr, addr);
 }
@@ -200,7 +200,7 @@ arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
  *
  * Undefined if no zero exists, so code should check against ~0UL first.
  */
-static inline long ffz(int x)
+static __always_inline long ffz(int x)
 {
 	int r;
 
@@ -217,7 +217,7 @@ static inline long ffz(int x)
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline int fls(unsigned int x)
+static __always_inline int fls(unsigned int x)
 {
 	int r;
 
@@ -238,7 +238,7 @@ static inline int fls(unsigned int x)
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-static inline int ffs(int x)
+static __always_inline int ffs(int x)
 {
 	int r;
 
@@ -260,7 +260,7 @@ static inline int ffs(int x)
  * bits_per_long assumed to be 32
  * numbering starts at 0 I think (instead of 1 like ffs)
  */
-static inline unsigned long __ffs(unsigned long word)
+static __always_inline unsigned long __ffs(unsigned long word)
 {
 	int num;
 
@@ -278,7 +278,7 @@ static inline unsigned long __ffs(unsigned long word)
  * Undefined if no set bit exists, so code should check against 0 first.
  * bits_per_long assumed to be 32
  */
-static inline unsigned long __fls(unsigned long word)
+static __always_inline unsigned long __fls(unsigned long word)
 {
 	int num;
 
-- 
2.25.1


