Return-Path: <linux-kernel+bounces-41538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EFE83F3F8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E1E28510F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AD21F94C;
	Sun, 28 Jan 2024 05:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0wmCgX7"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B81EB27
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 05:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706418383; cv=none; b=UNfSTETIPKMDH3C9xomKSbNjHZtIFwL45sLv89VN7qxDes82RS/ss8ZSpEoHml1vA0kROcbgW7wu7BQLCsLEu/wy7nHgIBDfGNUGOTorPAdDelrCnqEnTuR4Stl4hbQP8K0OobIu28rtYs5tXdrb2XLzr4QeFEy+xqQtC6y1i2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706418383; c=relaxed/simple;
	bh=R1pbFLI03IlZKTp/TgcUS71vFBkjz46xTjfOd1hIJ0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XO7PV3s41/qIV6wzoHClEkHmVdhLUreOc4L42sx4cbJbt2aa7TK9FJEan0NIM+UaN/pqhnoe6UUzvK6E7bIkR0/7vhnl5uuvv4PwoTTCT0ukwgdhIjB0VlagtJcIfNY3gMD3lw/lkO4vFq8SvDAVDDcvuJcMkZXCjBcbTgKBymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0wmCgX7; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59927972125so992648eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 21:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706418381; x=1707023181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQBsNQfE0P3AMOj6B4RUDeOxeQtA43qqvQ0BuQwr7rw=;
        b=V0wmCgX7E5aOxkoYKhW0gCF7B0ohqszlzAy+69baGiBHa8s/hLMMSdb3WW4tEtXcG+
         mJTa5/7br8eWyEBDBl8zA+qVhBCGgujAjX7DnF1DanyQew/VjLtekiCPu7CBbsHQaKCY
         ROX4BvdcadezTVoL8RoaEst18MiUIDMEejp96ok5gJ1C0wiz08Hy4ysR1DJLeVLfuthv
         IyG3RKP7sMgPL0Ug15DBiyLdlq/ltC8TUuBpYO4XL7SjAh4IOz41URZl46VyaTjPZbdO
         PC1fxweQV2WDwHHVtxUD1JNqDflu39rphFDIP0C4gqAtpmLbgdccdkR7CaB1QS0kflBc
         H4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706418381; x=1707023181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FQBsNQfE0P3AMOj6B4RUDeOxeQtA43qqvQ0BuQwr7rw=;
        b=saeVgFsZZdqvLOzpZ1pQbrWBLvuDhmAxtqOYaWV4neUHkQqHeikGxnynBtDrTjBnwU
         YEcbVZBvXbVIrixCQJYgMVZ1ofmDOYaWorlOb+nicfxIRja3tidGUrUsfCqOKwuEpNyj
         dV3o92qbyPRijO6QGScJFPqAi4e1OvN9FeAn66iwzaLIy05/k0JCn6jZILOoEMwpsFwn
         TRfsOUYawy2DOJlVc1GIUQ+mkU4a9SphyzndDYg/RwzV286Nuxa5DX0UbD2/0O+rwsXx
         tgvGD+9tjktmW/bdpr+1htMdX5+/mSb5lwaLgMK1zR8FUPA5Ljq23lk40yaDH3GoVPJa
         mrxg==
X-Gm-Message-State: AOJu0Yydo9b4cCx61Lf2C0aH/YMGOG8vKTLPKER6wf6geSAU32w9RSr1
	yE4EU7CFl/ZaYyq6TqEhJ63Evud+zoH0OLBUqbsbN3jc9c3x/xyn
X-Google-Smtp-Source: AGHT+IEG7nBxPu1DZAQ3x4bvDDnlqVoOR9wWy15hrjJ//5bm1LQ2RgGqogRvkweP/oDf95b7NCqmJQ==
X-Received: by 2002:a05:6830:4106:b0:6db:b046:2189 with SMTP id w6-20020a056830410600b006dbb0462189mr3439811ott.24.1706418380989;
        Sat, 27 Jan 2024 21:06:20 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddd182bf1csm3550372pfb.46.2024.01.27.21.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 21:06:20 -0800 (PST)
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
Subject: [PATCH v4 4/5] hexagon/bitops: use __builtin_{clz,ctzl,ffs} to evaluate constant expressions
Date: Sun, 28 Jan 2024 14:00:10 +0900
Message-ID: <20240128050449.1332798-5-mailhol.vincent@wanadoo.fr>
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

On linux 6.7 with an allyesconfig and clang 17.0.6, it saves roughly
4 KB.

  $ size --format=GNU vmlinux.before vmlinux.after
        text       data        bss      total filename
     4827900    1798340     364057    6990297 vmlinux.before
     4827072    1795060     364057    6986189 vmlinux.after

Reference: commit fdb6649ab7c1 ("x86/asm/bitops: Use __builtin_ctzl() to evaluate constant expressions")
Link: https://git.kernel.org/torvalds/c/fdb6649ab7c1

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/hexagon/include/asm/bitops.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index e856d6dbfe16..c74a639c84f3 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -204,6 +204,9 @@ static __always_inline long ffz(int x)
 {
 	int r;
 
+	if (__builtin_constant_p(x))
+		return __builtin_ctzl(~x);
+
 	asm("%0 = ct1(%1);\n"
 		: "=&r" (r)
 		: "r" (x));
@@ -221,6 +224,9 @@ static __always_inline int fls(unsigned int x)
 {
 	int r;
 
+	if (__builtin_constant_p(x))
+		return x ? BITS_PER_TYPE(x) - __builtin_clz(x) : 0;
+
 	asm("{ %0 = cl0(%1);}\n"
 		"%0 = sub(#32,%0);\n"
 		: "=&r" (r)
@@ -242,6 +248,9 @@ static __always_inline int ffs(int x)
 {
 	int r;
 
+	if (__builtin_constant_p(x))
+		return __builtin_ffs(x);
+
 	asm("{ P0 = cmp.eq(%1,#0); %0 = ct0(%1);}\n"
 		"{ if (P0) %0 = #0; if (!P0) %0 = add(%0,#1);}\n"
 		: "=&r" (r)
@@ -264,6 +273,9 @@ static __always_inline unsigned long __ffs(unsigned long word)
 {
 	int num;
 
+	if (__builtin_constant_p(word))
+		return __builtin_ctzl(word);
+
 	asm("%0 = ct0(%1);\n"
 		: "=&r" (num)
 		: "r" (word));
@@ -282,6 +294,9 @@ static __always_inline unsigned long __fls(unsigned long word)
 {
 	int num;
 
+	if (__builtin_constant_p(word))
+		return BITS_PER_LONG - 1 - __builtin_clzl(word);
+
 	asm("%0 = cl0(%1);\n"
 		"%0 = sub(#31,%0);\n"
 		: "=&r" (num)
-- 
2.43.0


