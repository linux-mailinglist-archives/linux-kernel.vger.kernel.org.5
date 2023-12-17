Return-Path: <linux-kernel+bounces-2491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E63815DDA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDDB1F223B4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399665257;
	Sun, 17 Dec 2023 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6WnJIqa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB4D3D65;
	Sun, 17 Dec 2023 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59148c1ad35so1622928eaf.2;
        Sat, 16 Dec 2023 23:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702797205; x=1703402005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Lcla7+xNiv5DjqNFwhIbwZ/t+uq3BdL5z3Q7Ys3rqQ=;
        b=R6WnJIqa8CQ0I1PD+Xk6ekB6jyAG+U8SEaA5BA9LtSGvz15HjlxMlLiNIEnkiQRJyO
         HbOl1TR2DvBma01pGOuD30J1vtt99XXTZv9dGujaPwg/RADqCF+HfDJPe8BNYoBbg61J
         pQ1TmBWLxPSR+5Ye8NUAmYpp2HHKS0d9dZLyZFncfCdSwGMFTsq9tkR24Mt/KmShHF4u
         eX4gWvhpZ6th7zTxYizyOXtygsSgZFz6tmqyoeK93U9t4CqIbY3YffOQSSTxdrs3A2a1
         WH8Acl6hHrOHATjhPNkojxmjCotFyb/Xje8nBzBySmbHAyfD6JRdKGc05k/+1U06Sg0M
         scRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702797205; x=1703402005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Lcla7+xNiv5DjqNFwhIbwZ/t+uq3BdL5z3Q7Ys3rqQ=;
        b=rz0+zsjegyUzm05MnBUpGhI3cJAAHA8ctquq3jmAB+qZY9j3wYAMzpWqJdxyuc7n0u
         C1wgJ2DYKbdvwGDq092Rei5Hn0siAPYWb5/QR2BU3rqu+/m7kokFvctEQW/zRn7oV31v
         QOBwJ+9MMFdj9+kDSQkl8JWqIE6Tcr+DNZ6RycWcDt+Sz3MBcYoYws276jWdVlKmCYhm
         XQhltWBcPYWe76/Tqfai4pZ+TA8sRGN1OBgO6QpEld1gMoOmib0+Zw4GAHSV6pDwMEW+
         wWp1QN4OdturivLAMPS9yCD2rke/9E1r805LBQ3IPpLAI/39KAVggWa635LG2zoRo+Gb
         svZg==
X-Gm-Message-State: AOJu0Yw6Tc8lGyNrzA8D50rhb4M0n5Av201xcX83nSi4Q6V1Wc7IdStG
	igCqIy44LVY2IjOUa65QdgU=
X-Google-Smtp-Source: AGHT+IEPBGJ4ARPNrxvSgt2qn9lQ4hHfgW1RzzZiJmfZnfo2kj1iNdiBdBHyw68Pbe4qdlzSXmnUVw==
X-Received: by 2002:a05:6808:3c95:b0:3b9:e779:8a04 with SMTP id gs21-20020a0568083c9500b003b9e7798a04mr23826650oib.17.1702797204976;
        Sat, 16 Dec 2023 23:13:24 -0800 (PST)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000cd100b0068ffb8da107sm15740231pfv.212.2023.12.16.23.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 23:13:24 -0800 (PST)
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
Subject: [PATCH v3 2/5] m68k/bitops: use __builtin_{clz,ctzl,ffs} to evaluate constant expressions
Date: Sun, 17 Dec 2023 16:12:47 +0900
Message-Id: <20231217071250.892867-3-mailhol.vincent@wanadoo.fr>
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

The compiler is not able to do constant folding on "asm volatile" code.

Evaluate whether or not the function argument is a constant expression
and if this is the case, return an equivalent builtin expression.

On an allyesconfig, with GCC 13.2.1, it saves roughly 8 KB.

  $ size --format=GNU vmlinux.before vmlinux.after
        text       data        bss      total filename
    60446534   70972412    2289596  133708542 vmlinux.before
    60429746   70978876    2291676  133700298 vmlinux.after

Reference: commit fdb6649ab7c1 ("x86/asm/bitops: Use __builtin_ctzl()
to evaluate constant expressions")
Link: https://git.kernel.org/torvalds/c/fdb6649ab7c1

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/m68k/include/asm/bitops.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index ae0457d582b8..3f89b9dccc33 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -470,6 +470,9 @@ static __always_inline unsigned long ffz(unsigned long word)
 {
 	int res;
 
+	if (__builtin_constant_p(word))
+		return __builtin_ctzl(~word);
+
 	__asm__ __volatile__ ("bfffo %1{#0,#0},%0"
 			      : "=d" (res) : "d" (~word & -~word));
 	return res ^ 31;
@@ -491,6 +494,9 @@ static __always_inline unsigned long ffz(unsigned long word)
 	!defined(CONFIG_M68000)
 static __always_inline unsigned long __ffs(unsigned long x)
 {
+	if (__builtin_constant_p(x))
+		return __builtin_ctzl(x);
+
 	__asm__ __volatile__ ("bitrev %0; ff1 %0"
 		: "=d" (x)
 		: "0" (x));
@@ -523,6 +529,9 @@ static __always_inline int ffs(int x)
 {
 	int cnt;
 
+	if (__builtin_constant_p(x))
+		return __builtin_ffs(x);
+
 	__asm__ ("bfffo %1{#0:#0},%0"
 		: "=d" (cnt)
 		: "dm" (x & -x));
@@ -541,6 +550,9 @@ static __always_inline int fls(unsigned int x)
 {
 	int cnt;
 
+	if (__builtin_constant_p(x))
+		return x ? BITS_PER_TYPE(x) - __builtin_clz(x) : 0;
+
 	__asm__ ("bfffo %1{#0,#0},%0"
 		: "=d" (cnt)
 		: "dm" (x));
-- 
2.25.1


