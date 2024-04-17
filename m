Return-Path: <linux-kernel+bounces-148497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE68A8385
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5AA1C21C56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BFD13CFA6;
	Wed, 17 Apr 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6j0+TLi"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD953D72
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358477; cv=none; b=c0KFlY19Xu+IfRk8XhyLeYhyjdeOi1X982oCsjt5s0BlhOyKmUGszkflLI1Wcyn0MP9/Xsbau1Fwe1Ez39tjUq7BkMBUkcwuYTErBjiKbf/0l6PyLGNW5utVPLdJ7wAtUFj3WrlnmaNQB+UR7qQcmwxemsf3vpmPSDOXT7kOWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358477; c=relaxed/simple;
	bh=M4J5PT3D+IetpcyDOgQ1xBf4qcsG2HDZzyXZjFHyBDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qgNxuqVrtYKTe6Viq8OLZ3T//Ao3jMkutnSw1G5dHfTl/tXf8wTzZjgVWXygjf2zI3Opk+RqoXziF2ZMU+vsCau5uzs7b8I/0yreUR/5maCzS07Wb6aSeOS49JcQPnWHNGWmUtB+24Nu48hbrm5MyZEfcOV6mzFiwIBevGAdDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6j0+TLi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e857e571f3so711855ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713358475; x=1713963275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WZyamrpNS4aLSSfT4icz6YwO81XFhsIQIb+WYvqqziI=;
        b=H6j0+TLi8Z8e/E+guobbKl0z2+gb2DAZm7VyiU0a0xhmyxtBiB2FZD5ahFiYMy7GGe
         OLfR1JMWsy0YXatXKLkJSlhwFqIV/7vfD7/dCqIHQwSJPoCIicoVh2usqP7dZlHKXS3P
         MnazMn6U2Vmjhru94pr0aUlKahPRl53v5OXQxiT26PXZc0A+Ma0dsvV/0eIRCLMvhhHQ
         VDr5/oWQF0eKqVuvUfmLJjDw18r3qLDyZS47KYRv2DQBt2jhhZ7eKJmF+rM2uD1bBOTw
         2cY3SWWpXT+OefK4U4uYpoVwbgL9VEACYf/bOmPfP9oxBhJ+KRUeGEfOBABXMkhFjDVb
         uvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713358475; x=1713963275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZyamrpNS4aLSSfT4icz6YwO81XFhsIQIb+WYvqqziI=;
        b=toKCvTrr+3uOHkMusy8Q7oazGqi2vibjbSIsL6xK1mwK/vlUVVfZLvVONZZ+aEXJN2
         feNJGrDsKbQwBztGWkzEte9YJ0TtkUgddXKKeYsnjnRWbs2QKOy7vZxnRytxCCFGFbEF
         3pPaDnPuh10gjOYYJ8gJVA5rSkyU1IACQT4pIyT/ONvCFlrZ05AuPv4YIrup1XkolAHa
         e9E+02zidwC9QiBnhMqiaGobvKagTagVUa9xfZlmkLRgokQbqhHwAmIOfrzkN4nq3B7t
         zPmiCunGhH/bieUDh1Hp//+h097PINjnVkkwwDKwWlZXNfiuT/mgQRzqL1+0J3Rk7cbe
         FFTw==
X-Forwarded-Encrypted: i=1; AJvYcCVZDSsibGzQdt7ozxEOH8bm5XEobXAvSFzK3XFHuBSUxnq2NWTQ8vWYyPJjVfsmwm/MDEuWHrjle9eMDKrmURBgIreKyM+p5zQ37k6b
X-Gm-Message-State: AOJu0YwLGmIBRrid9qehg4ltzwzMtxCNggtFZk2b6IzkhN8c/olPcsZU
	W0NDXqFqULF2QUtXCWz610HR5U8DS5HB4OV+bvRHCVc8m8RkW/My
X-Google-Smtp-Source: AGHT+IENNyKEzVAUv6cld2pyeDqqLUcqzjmM8BPF90COWjMJiU4qmgdcY1l9lx0ExfiISeYotT0o9g==
X-Received: by 2002:a17:902:a601:b0:1e7:b7a7:9f20 with SMTP id u1-20020a170902a60100b001e7b7a79f20mr6266474plq.59.1713358475358;
        Wed, 17 Apr 2024 05:54:35 -0700 (PDT)
Received: from lima-default.. (1-175-176-70.dynamic-ip.hinet.net. [1.175.176.70])
        by smtp.gmail.com with ESMTPSA id be10-20020a170902aa0a00b001e5df38994dsm8442552plb.248.2024.04.17.05.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 05:54:35 -0700 (PDT)
From: Chin-Chun Chen <chinchunchen2001@gmail.com>
To: yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Chin-Chun Chen <chinchunchen2001@gmail.com>
Subject: [PATCH] linux/bitops.h: Refactor function fns to reduce branch usage and eliminate external calls
Date: Wed, 17 Apr 2024 19:21:58 +0800
Message-Id: <20240417112157.19443-1-chinchunchen2001@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrote the function fns to use macro wrote in linux/include/asm-generic/bitops/const_hweight.h
Decrease the number of required branches and eliminate the need for external calls.
The number of branches is now constant, unaffected by input variations.

This commit improves code efficiency and clarity.

Signed-off-by: Chin-Chun Chen <chinchunchen2001@gmail.com>
---
 include/linux/bitops.h | 54 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 5842d7d03f19..18899f11aaa7 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -247,6 +247,13 @@ static inline unsigned long __ffs64(u64 word)
 	return __ffs((unsigned long)word);
 }
 
+
+#define __const_hweight2(w)                                                 \
+    ((unsigned int) (!!((word) & (1ULL << 0))) + (!!((word) & (1ULL << 1))))
+
+#define __const_hweight4(w)                                                 \
+    ((unsigned int) (!!((word) & (1ULL << 0))) + (!!((word) & (1ULL << 1))) + \
+                     (!!((word) & (1ULL << 2))) + (!!((word) & (1ULL << 3))))
 /**
  * fns - find N'th set bit in a word
  * @word: The word to search
@@ -255,13 +262,48 @@ static inline unsigned long __ffs64(u64 word)
 static inline unsigned long fns(unsigned long word, unsigned int n)
 {
 	unsigned int bit;
-
-	while (word) {
-		bit = __ffs(word);
-		if (n-- == 0)
-			return bit;
-		__clear_bit(bit, &word);
-       }
+	unsigned int sum = 0;
+#if BITS_PER_LONG == 64
+	bits = __const_hweight32(word & 0xffffffff);
+	if (bits <= n) {
+		n -= bits;
+		word >>= 32;
+		sum += 32;
+ 	}
+#endif
+	bits = __const_hweight16(word & 0xffff);
+       if (bits <= n) {
+               n -= bits;
+               word >>= 16;
+               sum += 16;
+       }
+	bits = __const_hweight8(word & 0xff);
+       if (bits <= n) {
+               n -= bits;
+               word >>= 8;
+               sum += 8;
+       }
+	bits = __const_hweight4(word & 0xf);
+       if (bits <= n) {
+               n -= bits;
+               word >>= 4;
+               sum += 4;
+       }
+       bits = (unsigned int) (word & 0x3);
+       if (bits <= n) {
+               n -= bits;
+               word >>= 2;
+               sum += 2;
+       }
+       bits = (unsigned int) (word & 0x1);
+       if (bits <= n) {
+               n -= bits;
+               word >>= 1;
+               sum += 1;
+       }
+	bits = (unsigned int) (word & 0x1);
+       if (bits <= n) {
+               n -= bits;
+               sum += 1;
+       }
+
+	if (!n)
+		return sum;
+
 
 	return BITS_PER_LONG;
 }
-- 
2.40.1


