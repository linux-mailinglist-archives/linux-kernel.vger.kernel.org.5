Return-Path: <linux-kernel+bounces-41537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3223A83F3F7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8271E1F21BC3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7EB1DFD9;
	Sun, 28 Jan 2024 05:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLuDGVyx"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2111D524
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 05:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706418379; cv=none; b=tFkCBcwCt/vA3YeObCegpIGOeM6Cqc7cBJ9j1mOpJcXdshzq4hhmKScdOjfeF2dgCrhsMVl50+Xn4QBNVYY19IvMi94kfSdAcqpB188XvePAfisCFsGYeEVdya8/XUrhlpnpt2vYoDskYFsdqdyl79w5ZpjwPs4nHlpA/rbZb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706418379; c=relaxed/simple;
	bh=EUVQyICOpBqVWh6g3IN6x5mNM2NGmg0g/sEBs5QBZ1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJHXbdEcRWGVgsATfihIXtR4IcHMytJkv3Xn1fIraktH5lI5AXjnYn6QzFRoCGkxr1YybMEIUi1QFsHwBXalfbQsAuLoOmPq+p+RjHVKjr6NaQENiYqnH3N8R8sCdy9vb9uyXIaVIrztJzzB86waG8sDxMNDgJyAxcumEnlG0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLuDGVyx; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5986d902ae6so1121787eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 21:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706418377; x=1707023177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLlJCmhI5JZIPAQYj2G74sUtNrIAZ9HIcrgV/zcgKnA=;
        b=jLuDGVyx+/IBfX94fH9WjaYxXHjJCisAspgSf50Qno8VdqkSFBAg7oIiP12o16JXg/
         j4TIGBapzuWkRHsrgGD7UplJHADGD1ZLFh/2F6Zo0dxV9DrxbdUOnww+wEqQHRaV4p+u
         RdJzEI34HM+dUGHCbs94WHyrxAZtgwlYCLbfjmX6XWV+YpTcppcXiXwEw2jAmetIgepL
         iPWEwK899Gti8sdylX8/KfHquqmImdMkOMQ8AjRQpct37zsHi5zXWBuNgGhBbH6brLGU
         xgIxKeHHop1G4Bp8GaGqFLRGi6/zf/NHdRelSGzmzEe746tF3qRIpKV/Ge3fO9I9FyOV
         /JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706418377; x=1707023177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GLlJCmhI5JZIPAQYj2G74sUtNrIAZ9HIcrgV/zcgKnA=;
        b=fir4/zoKYP4sOgAc7TeTMrOuMRUr/+LwsAgYzhsMMrqOevq6zhKn5soRC60I9YLY1v
         lcN8hCvI2tR5v1gWFA3z/y71XCAuvUWyoiiPGDwF0dEDcFtCLVYyL8sc3j/svQkvljXi
         O/z0U7DEDx/Bs2IAA1N4H6HcI2x1cFVhiiHi4/ePo6gHjf4nzzoxhGlEBMstTAO5C+1e
         JNfZdjGACa69/z7GF8UQObmPQ/X6WgAGxOF8SE7hlx7RRhw8ymcbDJrbIJZnTZKOrAN3
         /CL8vem2x72KkyajWyR/AUq7TiffzrO3bmJXJ+XQYOfKMROTsHD1jiqV3kWsB4qmeWfU
         9vAA==
X-Gm-Message-State: AOJu0YxlPzHH1t6GjVLfv7BFiyAbOfeW+9yBDG7L/jLEySnocsMl+mf7
	ezA8JOuG2gehLb2XSqLHJjj+l/Tv4HQSO68g1sKdq+z+xfQSL0CI
X-Google-Smtp-Source: AGHT+IHoQbPQZIJSI+buf7XdlQZCHJPSEHdvtWV2n+RU3qSWFQbxHhbebOSg/814TJZcUf51VrOmCA==
X-Received: by 2002:a05:6359:4114:b0:177:2e7:cd54 with SMTP id kh20-20020a056359411400b0017702e7cd54mr3368594rwc.32.1706418376523;
        Sat, 27 Jan 2024 21:06:16 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddd182bf1csm3550372pfb.46.2024.01.27.21.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 21:06:15 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
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
	linux-m68k@lists.linux-m68k.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 3/5] hexagon/bitops: force inlining of all bit-find functions
Date: Sun, 28 Jan 2024 14:00:09 +0900
Message-ID: <20240128050449.1332798-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr>
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
 <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr>
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

__always_inline is also needed for further optimizations which will
come up in a follow-up patch.

Inline all the bit-find function which have a custom hexagon assembly
implementation, namely: __ffs(), ffs(), ffz(), __fls(), fls().

On linux v6.7 defconfig with clang 17.0.6, it does not impact the
final size, meaning that, overall, those function were already inlined
on modern clangs:

  $ size --format=GNU vmlinux.before vmlinux.after vmlinux.final
        text       data        bss      total filename
     4827900    1798340     364057    6990297 vmlinux.before
     4827900    1798340     364057    6990297 vmlinux.after

Reference: commit 8dd5032d9c54 ("x86/asm/bitops: Force inlining of test_and_set_bit and friends")
Link: https://git.kernel.org/torvalds/c/8dd5032d9c54

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/hexagon/include/asm/bitops.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index 160d8f37fa1a..e856d6dbfe16 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
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
2.43.0


