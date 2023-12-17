Return-Path: <linux-kernel+bounces-2493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C259C815DDC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7989E283763
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39879D9;
	Sun, 17 Dec 2023 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k30N9yvj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FB76FD5;
	Sun, 17 Dec 2023 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ba00fe4e94so1705082b6e.1;
        Sat, 16 Dec 2023 23:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702797215; x=1703402015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vyhSqduyGw//DWggAhtjkJM+OOGpuFMjvvJjdOe8jo=;
        b=k30N9yvjoCL8Oux3twFbUdaV8+ZgXrVdikZwowb1Zfr4q/fYxUWwp+nLraGTSODz6t
         CQx5j9s541072br1zWdfPHmZQGn1ULbM8RdB7+ojxyxSzHhH4qgr5vYBKs9aVcqeR8sj
         KL4yXC9ZoHhkqDcFKL/ImiLYR8bQP6QHAF+Y3u/+IhSJquqSypaSegDjyuAv8vtUNC0I
         QYeeE8xGOk9md87TW9mQvxvfhcikXKhBsE9OHsmTxEojnK4CXND8zfTqS5VeGsJHlO60
         /i+qgiF+1GqB6tVZIxri45D9ManLLVhLYcDFrgqSC+gKyYuL+4sGki6P5Orv0RncCVMx
         kEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702797215; x=1703402015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vyhSqduyGw//DWggAhtjkJM+OOGpuFMjvvJjdOe8jo=;
        b=gr6Sc90dJmMoK/02sZ56qXPp8SnZMMLesO2RCWsyVGpFNA7nXoa4MHRR6mw5JHEbrr
         3cVN9PI3zmK2yKu2gQWpdnvSrNK2MYiIlHCZ5LhTzrSQV4C9BqqE7m5QhRSOD+Sqj11D
         SY/t1Dc6R9NCMYUO7NyGeKLYXXcv8IMv2iV2UnPgi8Ym/ReErHmpYy/+8T5XxT364AZq
         ZAoQAs+ACwmSVUI+I6R8S8t4X9SaHIIiocHLLfC32kwu23305n7UWHaiTgYQGVyZa1Ya
         9OcQhayRoylrWvrKGukAzq7jJdhTPLI9n4Hia00H0gepkV099RcjHvYnoBnvlEmOrjpW
         iJ8w==
X-Gm-Message-State: AOJu0YyaYYF5xBllLhVeVpfYqSpsx16kSULZv72lLGnKMjqA/RzcTwkY
	OmJwfWZXg+bKuiP8v1q7B2I=
X-Google-Smtp-Source: AGHT+IHGOx0BR5HAYftUoQp8Nb+5soW9pU5BJgFekD35zFbH7EwlDc0Na3Oxjb+GsxeC4LLdkZLVbQ==
X-Received: by 2002:a05:6808:3309:b0:3ba:231:cd44 with SMTP id ca9-20020a056808330900b003ba0231cd44mr19137878oib.43.1702797215473;
        Sat, 16 Dec 2023 23:13:35 -0800 (PST)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000cd100b0068ffb8da107sm15740231pfv.212.2023.12.16.23.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 23:13:35 -0800 (PST)
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
Subject: [PATCH v3 4/5] hexagon/bitops: use __builtin_{clz,ctzl,ffs} to evaluate constant expressions
Date: Sun, 17 Dec 2023 16:12:49 +0900
Message-Id: <20231217071250.892867-5-mailhol.vincent@wanadoo.fr>
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

Reference: commit fdb6649ab7c1 ("x86/asm/bitops: Use __builtin_ctzl()
to evaluate constant expressions")
Link: https://git.kernel.org/torvalds/c/fdb6649ab7c1

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/hexagon/include/asm/bitops.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index 950d4acc2edc..12c6ad1ea2ed 100644
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
2.25.1


