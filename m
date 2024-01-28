Return-Path: <linux-kernel+bounces-41535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 200E883F3F5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB72A283D7A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0464AD2F7;
	Sun, 28 Jan 2024 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rgazrkj6"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C358F6E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706418371; cv=none; b=S6U8U9Y3Nv46/vs2qZ9rABTDpigGp4H6X5mOcaSkvYCMw/5jeffNkNpYx77/9r1LAUhdvv7z/k9yCQS98nmDaQEyZKr/i2PUueMQKM09vDQulvjExV7UrG35NoZU3hsQi9FkLhuj0z/gJqZF5tuhF21Bzion7O6Dld3XGGxu8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706418371; c=relaxed/simple;
	bh=qP1S1rXP0UMtjHp5qx9OgsIHVeo/JJwGD+kMiT1E4bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvTh+tmoyfWnAjp80a1gK8rfw+cSFCIsdHEM47YUhtHgf9XVzSAk1fbFJKU/FaQFP49hgaY9S9BAiCOR8fF558KuU8+S3+zRPzzSQHVrT833itiDumrHHefPuFLqXl0O0tYxXV55qgNLR0EgavW1dcFmcLhFLlXj183Qn71avas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rgazrkj6; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd5c4cffefso2162478b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 21:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706418368; x=1707023168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19sNIGW0pghbkIABBLpZ8u04puBnH22vL76jF4wAKJM=;
        b=Rgazrkj6j04Hl5jIA2RNOaZRpPUlXrsO9yjGn682flVLQnc7lcjNQpYJB237DFfKY9
         ImVmQxWpJh5zxTfZ4rm/VzY03twK1cyFYwVQoYLHzEtvJ7B615HeTuu7cBDkJgZGkpts
         2eId0sSAiKEA3Xx58FIfUGUs0yliTIVHJn4nc+pvHdWJDnNZ/Rkto2XyxMsIboxzFLQp
         nqQh12vs/icWZubTKl+gj1ZtjzSjRvAPThOQkOL3iuzrsb3Yn9BxWJ8RiLwf1p+5kx2F
         Mw8Gb1oszTubPBRH+eb6EAFh78v3z7YTxeh7m3kTLJGdjEddFmBDemcNXzBhF/cJfC++
         8VGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706418368; x=1707023168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=19sNIGW0pghbkIABBLpZ8u04puBnH22vL76jF4wAKJM=;
        b=I0T35BB2sApoC+89+joHmF8HjQJTdOPdXJ2XRsfiLDo3trRETdXyIQ1ucSkU4UKW8s
         YTBhG2HItlFd/Q0WV8LWT5E5TPy8+bb08N2YQZF76jQCu5EorpVNSTtUFkn9syF9pjZW
         lI8klBaWPt1FQMLk76e6Pimbb2pQCkh+kCMG6T0xnIDmy11S+Rni8Ud28AJPr1vmgnAx
         0SPvh52F2nb2hWwzMsx6ko5gYaam3eF1ItbDcB6qUUAHB0SmYI+ZyYEltgN+nBmXL1GI
         +4cTi4WLLnInFfGs2Firwv3b2h4AXdcdbMB7cg5qzA9beNMXywMn+akNXbV69PUOxf83
         q1Eg==
X-Gm-Message-State: AOJu0YwoCbwHYsH6MhITt7wxkym3idfFgUeuhKAKPXwKRQ5Ls2CyTF3m
	qNJQVIUYpIPgDxxsdydQIzOOHgRI/wyL15Jy/VNZY71XzfPwzXv9
X-Google-Smtp-Source: AGHT+IGBTtbhRceHwTa0x3eZf1sJmCivqoJmPoyAxwOiobLNypPD+byqKoFmrztSRgvKweXB+qAZ3Q==
X-Received: by 2002:a05:6808:1815:b0:3be:2175:98e9 with SMTP id bh21-20020a056808181500b003be217598e9mr2912252oib.18.1706418368391;
        Sat, 27 Jan 2024 21:06:08 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddd182bf1csm3550372pfb.46.2024.01.27.21.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 21:06:07 -0800 (PST)
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
Subject: [PATCH v4 1/5] m68k/bitops: force inlining of all bit-find functions
Date: Sun, 28 Jan 2024 14:00:07 +0900
Message-ID: <20240128050449.1332798-2-mailhol.vincent@wanadoo.fr>
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

Inline all the bit-find function which have a custom m68k assembly
implementation, namely: __ffs(), ffs(), ffz(), __fls(), fls().

On linux v6.7 allyesconfig with GCC 13.2.1, it does not impact the
final size, meaning that, overall, those function were already inlined
on modern GCCs:

  $ size --format=GNU vmlinux.before vmlinux.after
    text       data        bss      total filename
    60457956   70953665    2288644  133700265 vmlinux.before
    60457964   70953697    2288644  133700305 vmlinux.after

Reference: commit 8dd5032d9c54 ("x86/asm/bitops: Force inlining of test_and_set_bit and friends")
Link: https://git.kernel.org/torvalds/c/8dd5032d9c54

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/m68k/include/asm/bitops.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 14c64a6f1217..a8b23f897f24 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -465,7 +465,7 @@ static inline int find_next_bit(const unsigned long *vaddr, int size,
  * ffz = Find First Zero in word. Undefined if no zero exists,
  * so code should check against ~0UL first..
  */
-static inline unsigned long ffz(unsigned long word)
+static __always_inline unsigned long ffz(unsigned long word)
 {
 	int res;
 
@@ -488,7 +488,7 @@ static inline unsigned long ffz(unsigned long word)
  */
 #if (defined(__mcfisaaplus__) || defined(__mcfisac__)) && \
 	!defined(CONFIG_M68000)
-static inline unsigned long __ffs(unsigned long x)
+static __always_inline unsigned long __ffs(unsigned long x)
 {
 	__asm__ __volatile__ ("bitrev %0; ff1 %0"
 		: "=d" (x)
@@ -496,7 +496,7 @@ static inline unsigned long __ffs(unsigned long x)
 	return x;
 }
 
-static inline int ffs(int x)
+static __always_inline int ffs(int x)
 {
 	if (!x)
 		return 0;
@@ -518,7 +518,7 @@ static inline int ffs(int x)
  *	the libc and compiler builtin ffs routines, therefore
  *	differs in spirit from the above ffz (man ffs).
  */
-static inline int ffs(int x)
+static __always_inline int ffs(int x)
 {
 	int cnt;
 
@@ -528,7 +528,7 @@ static inline int ffs(int x)
 	return 32 - cnt;
 }
 
-static inline unsigned long __ffs(unsigned long x)
+static __always_inline unsigned long __ffs(unsigned long x)
 {
 	return ffs(x) - 1;
 }
@@ -536,7 +536,7 @@ static inline unsigned long __ffs(unsigned long x)
 /*
  *	fls: find last bit set.
  */
-static inline int fls(unsigned int x)
+static __always_inline int fls(unsigned int x)
 {
 	int cnt;
 
@@ -546,7 +546,7 @@ static inline int fls(unsigned int x)
 	return 32 - cnt;
 }
 
-static inline unsigned long __fls(unsigned long x)
+static __always_inline unsigned long __fls(unsigned long x)
 {
 	return fls(x) - 1;
 }
-- 
2.43.0


