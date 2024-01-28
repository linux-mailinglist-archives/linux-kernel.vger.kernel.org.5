Return-Path: <linux-kernel+bounces-41536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AF883F3F6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFFB1F21837
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951B3DF67;
	Sun, 28 Jan 2024 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3SpdN5X"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E010D527
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706418374; cv=none; b=Hg0+yB07XDcohxxdGbASLYDFBNsyQXImdqAYPjx9lIvHFO73EOoXtTO1WiYjDDowAvcDMbz9QABFQOn00zyN7ZFU2AYXq0LSJS3+gHzHY76Z0ftEd8NtybuwlGkcPHrzycM8nihFkIYYcJYIxulRT1hjNbgCbY0QyrLumB13wVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706418374; c=relaxed/simple;
	bh=ExuY3mPusE/FWbLSFzM/M9SA0b5v24qHPt/95eQI/Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asnBv/nWq0niiAz7ja7ToC8bpHi5ZtaQjG63025AWwTqQ0HUEo3/wpyaAgmt5kI1V4Byzgb9N8zauO08t8QOs3uPkUKEDcg8i2dztetm45bTJ68cxwEDExY9yDo1wLVMDXSEuEfcjKPYAUxbgSAdg+jo49wkVvGjkfKhDqVboao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3SpdN5X; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bd5c4cffefso2162519b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 21:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706418372; x=1707023172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Afm8icB/y+Dcgg++6LXAA0U3DRuhdcifD/F9kyq+8Bw=;
        b=A3SpdN5XK3K1mTaGdxFBRPKefIXvQFS5O8e2a6a+brw8qALDde5KG1JK/2plQ9EdHb
         hUIEP/8h9PYPf+cNM9to8lIOLM9nyBMNkxfZQc78UGzIbIiDycJDq2E1lvFlIY8GWLPR
         YGBq8jST8hNo5jphplFViUVJueaBfAkIhLEfO2Q6wYbBJFqDl+ONKlY9m1atA0TAF/om
         ODLPXue4UFk20DnZKcZzh/iOCOP5SQkC8GKoRRQCIoyYiIaD2CCetWG6wPEsVhEivAwu
         pm0qJjVSqaoufugs7ngmF8bTEohKdMM20AK82O/eH3tlpbRSbD95ujgsAKAdh5xNpU5b
         YXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706418372; x=1707023172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Afm8icB/y+Dcgg++6LXAA0U3DRuhdcifD/F9kyq+8Bw=;
        b=WDt4y/DrTyjf/SnadLGfjzJxmVcSWOUvumlmt1idlzMnFg9zLezfM6VwLk0hM7frFQ
         w0ayRj9uxnimBKinvFI8jYkKXT0oV6D1rB8bPgb2cIY8Nz/KT5WZei3gcKm0WH6x5q/u
         H8ZDVhUcTP4gj858yk26XyDdM5ACNmyJ4mcrWJkm11sm+EyXOeThirXZYzqKIaQSmcYk
         uJkne0kzlz7+nQfqZ+9KnyRRqWV61fYpwTvE8ny1aMToCPc1lS3lNWvbcxLYJXG6F8cH
         o7aJWq14WQctaWSZ943FuhKZwIt5leEXDxXtKj5II23fdtBG3C0CPmi+WHmni1DLHQZT
         pFJg==
X-Gm-Message-State: AOJu0YwVh0br0zON9urQRZoCbAOBKn4+5wGedU41dc519vZZ08j5w0uG
	09hOGYa30Ml2jrtW/4fPBRBAmCSO7Z49OiQmWqpP+N6GkjUXJLEg
X-Google-Smtp-Source: AGHT+IFX51ILylxaSYnl18EoW6kL48m7lSuyH/v3viP4NEjjW8STalhGnaCEAi2BeLIKKaIi3ElmTQ==
X-Received: by 2002:a05:6808:1189:b0:3bd:a71f:9bf0 with SMTP id j9-20020a056808118900b003bda71f9bf0mr3657759oil.39.1706418372492;
        Sat, 27 Jan 2024 21:06:12 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddd182bf1csm3550372pfb.46.2024.01.27.21.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 21:06:11 -0800 (PST)
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
Subject: [PATCH v4 2/5] m68k/bitops: use __builtin_{clz,ctzl,ffs} to evaluate constant expressions
Date: Sun, 28 Jan 2024 14:00:08 +0900
Message-ID: <20240128050449.1332798-3-mailhol.vincent@wanadoo.fr>
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

The compiler is not able to do constant folding on "asm volatile" code.

Evaluate whether or not the function argument is a constant expression
and if this is the case, return an equivalent builtin expression.

On linux 6.7 with an allyesconfig and GCC 13.2.1, it saves roughly 11 KB.

  $ size --format=GNU vmlinux.before vmlinux.after
    text       data        bss      total filename
    60457964   70953697    2288644  133700305 vmlinux.before
    60441196   70957057    2290724  133688977 vmlinux.after

Reference: commit fdb6649ab7c1 ("x86/asm/bitops: Use __builtin_ctzl() to evaluate constant expressions")
Link: https://git.kernel.org/torvalds/c/fdb6649ab7c1

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/m68k/include/asm/bitops.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index a8b23f897f24..02ec8a193b96 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -469,6 +469,9 @@ static __always_inline unsigned long ffz(unsigned long word)
 {
 	int res;
 
+	if (__builtin_constant_p(word))
+		return __builtin_ctzl(~word);
+
 	__asm__ __volatile__ ("bfffo %1{#0,#0},%0"
 			      : "=d" (res) : "d" (~word & -~word));
 	return res ^ 31;
@@ -490,6 +493,9 @@ static __always_inline unsigned long ffz(unsigned long word)
 	!defined(CONFIG_M68000)
 static __always_inline unsigned long __ffs(unsigned long x)
 {
+	if (__builtin_constant_p(x))
+		return __builtin_ctzl(x);
+
 	__asm__ __volatile__ ("bitrev %0; ff1 %0"
 		: "=d" (x)
 		: "0" (x));
@@ -522,6 +528,9 @@ static __always_inline int ffs(int x)
 {
 	int cnt;
 
+	if (__builtin_constant_p(x))
+		return __builtin_ffs(x);
+
 	__asm__ ("bfffo %1{#0:#0},%0"
 		: "=d" (cnt)
 		: "dm" (x & -x));
@@ -540,6 +549,9 @@ static __always_inline int fls(unsigned int x)
 {
 	int cnt;
 
+	if (__builtin_constant_p(x))
+		return x ? BITS_PER_TYPE(x) - __builtin_clz(x) : 0;
+
 	__asm__ ("bfffo %1{#0,#0},%0"
 		: "=d" (cnt)
 		: "dm" (x));
-- 
2.43.0


