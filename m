Return-Path: <linux-kernel+bounces-166546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E147E8B9C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F82A1C21432
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E795913C80D;
	Thu,  2 May 2024 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrNpNSSo"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C0513C805;
	Thu,  2 May 2024 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659247; cv=none; b=IHuZdlOgMOagcewdbDI/3GPX5mR3Ir+5MuDXZ8GfGxVJjwWf7HFr4iCq04qC45X75JuJjquLAycl0qyyaYtIuQBYEwpRPwpVfDBdWYvoHtUFYDjASxXBVn6y7fTRqVcJIbYiicIXj1rY0tHvkWjuTqOuOdZPoyJOMMD5yW1XMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659247; c=relaxed/simple;
	bh=lbWfnrf/xgAKQua0DHb+A0y6pv4+Q2Pc2fzVcmh6W7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VJXsBzg68kmmhTz9LCtHFauzRx0L5PnDhSAGEeuv/JfNRAODv+iyAIzTiFpg6MexXX6xzIyxf3z4BU6N941pLdI8OdEf+q1ijSfCc/kyHsIdRjmRSNMyBBJH6NCLa7meqPBSczot73+p35Ka67PItakqzxrseAXRw9ugYBNzetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrNpNSSo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed627829e6so9331259b3a.1;
        Thu, 02 May 2024 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714659245; x=1715264045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZK9MhMJmPLU0U1h9aoilxp/KfAO26agqEnlepbavk/M=;
        b=MrNpNSSoe3uH2rB2n+4PEq6UusckOCS4TvKQ7yVH9qwpkDLgou8I+/q9wAud9biwMN
         PaIBoeZDMoFhICn1+cNhgZ8q80RtWvpHHsgdkMvXweOshbZK0FcrmR4lU0znOXID52uI
         fHING7FGsWkcPz5iP/WjnI5Z9dCLvjD3wA4oCHRElhiIqrHiYhEeawopYW8l5LflzRUm
         FtwNI+jzK3y47YonxXc9T/5G/S1cn8glx4vTWpVOt+C2XprHIMfJbTSgzlE1RvGgUSLH
         9vZ2UE+0PPfi3zOwtlEXg1ko0GEhReYHlf+4kCp7rLRxiG/dVYy7x7AI+d87twB3mCv7
         DStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714659245; x=1715264045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZK9MhMJmPLU0U1h9aoilxp/KfAO26agqEnlepbavk/M=;
        b=XcYZ/LtplxZZfSiPWcpqCLrN8fCGxeEdoSK6jFEEYZvPT7WcoUqDhml+Bneg3lG9em
         FYgRMCnu3WfE+Qd6GwnqRNvop+1ccMUSoBBYmLGxKNq9Lo/VKaw1UNfMRxv96w/Sn06z
         RTovYsHX66QIbpZ3ZYGOM70Yyg92zbOgiWwBdDsMMmzHoFTKga3LRczOesWtrfYWVlG9
         b4zysz56JAeIcpkjskz+duQEuAE+z3uZ7clfb2bnguf6yyeMjMzosg1Szh9uDPHrIFpC
         0YgxAcQQmSJHJDbNjzIw9Jo31KzPvVH39+NffFxX4OUwdWpakh0rE9iPU8ks7qyblVyu
         Avfw==
X-Forwarded-Encrypted: i=1; AJvYcCXsrMI1lr91PS7Zj7OrJxpPyMGQ0AQdXPnezoE1/fnloFodFLZRsuDXnfIb2Rtur6Cg2AVjEak89CbPsFHBxTwK5FZdKyRAtptQVpffGlkVlL8YvP0NRD0k3WHvysvC7u8C57t0Gl5A5k+NSD3x
X-Gm-Message-State: AOJu0Yze34sPEnEheuHurOhIAaIitdQ4I4fsyadhXxNTe1XoFAJBhuoU
	8wjFDzp3XOfxqsLTdzLHBO0Ox6dMx74Kyd+Uqq5bYzKZClQLm2Dj
X-Google-Smtp-Source: AGHT+IFAb7vnMGomKlHPacm8NDZMeY7sNS0eDNsEmYEE8UkqWCVqra81g6aGMfTNUU8Gqy+DdLKfYg==
X-Received: by 2002:a05:6a20:4320:b0:1a9:5eb1:7f35 with SMTP id h32-20020a056a20432000b001a95eb17f35mr7072909pzk.46.1714659244972;
        Thu, 02 May 2024 07:14:04 -0700 (PDT)
Received: from localhost.localdomain (125-229-101-177.hinet-ip.hinet.net. [125.229.101.177])
        by smtp.gmail.com with ESMTPSA id h17-20020a056a00219100b006ed06c4074bsm1252591pfi.85.2024.05.02.07.14.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 07:14:04 -0700 (PDT)
From: "Hsin-Yu.Chen" <harry021633@gmail.com>
To: keescook@chromium.org
Cc: andy@kernel.org,
	akpm@linux-foundation.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Hsin-Yu.Chen" <harry021633@gmail.com>
Subject: [PATCH 2/2] string: improve strlen performance
Date: Thu,  2 May 2024 22:13:59 +0800
Message-Id: <20240502141359.89567-1-harry021633@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Port `strlen` in gcc, which enhance performance over 10 times

Please refer to these following articles
1. [Determine if a word has a byte less than n]
   (https://graphics.stanford.edu/~seander/bithacks.html#HasLessInWord)
2. [Determine if a word has a zero byte]
   (https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord)

Signed-off-by: Hsin-Yu.Chen <harry021633@gmail.com>
---
 lib/string.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 6891d15ce991..31e8642422af 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -398,11 +398,80 @@ EXPORT_SYMBOL(strnchr);
 #ifndef __HAVE_ARCH_STRLEN
 size_t strlen(const char *s)
 {
-	const char *sc;
+	const char *char_ptr;
+	const unsigned long *longword_ptr;
+	unsigned long longword, himagic, lomagic;
 
-	for (sc = s; *sc != '\0'; ++sc)
-		/* nothing */;
-	return sc - s;
+	/* Handle the first few characters by reading one character at a time.
+	 * Do this until CHAR_PTR is aligned on a longword boundary.
+	 */
+	for (char_ptr = s; ((unsigned long) char_ptr
+		& (sizeof(longword) - 1)) != 0;
+		++char_ptr)
+		if (*char_ptr == '\0')
+			return char_ptr - s;
+
+	/* All these elucidatory comments refer to 4-byte longwords,
+	 * but the theory applies equally well to 8-byte longwords.
+	 */
+	longword_ptr = (unsigned long *) char_ptr;
+
+	/* Bits 31, 24, 16, and 8 of this number are zero.
+	 * Call these bits the "holes."
+	 * Note that there is a hole just to the left of
+	 * each byte, with an extra at the end:
+	 * bits:  01111110 11111110 11111110 11111111
+	 * bytes: AAAAAAAA BBBBBBBB CCCCCCCC DDDDDDDD
+	 * The 1-bits make sure that carries propagate to the next 0-bit.
+	 * The 0-bits provide holes for carries to fall into.
+	 */
+	himagic = 0x80808080L;
+	lomagic = 0x01010101L;
+
+	if (sizeof(longword) > 4) {
+		/* 64-bit version of the magic. */
+		/* Do the shift in two steps to avoid a warning if long has 32 bits.
+		 */
+		himagic = ((himagic << 16) << 16) | himagic;
+		lomagic = ((lomagic << 16) << 16) | lomagic;
+	}
+
+	if (sizeof(longword) > 8)
+		abort();
+
+	/* Instead of the traditional loop which tests each character,
+	 * we will test a longword at a time.  The tricky part is testing
+	 * if *any of the four* bytes in the longword in question are zero.
+	 */
+	for (;;) {
+		longword = *longword_ptr++;
+		if (((longword - lomagic) & ~longword & himagic) != 0) {
+
+			/* Which of the bytes was the zero?
+			 * If none of them were, it was a misfire; continue the search.
+			 */
+			const char *cp = (const char *) (longword_ptr - 1);
+
+			if (cp[0] == 0)
+				return cp - s;
+			else if (cp[1] == 0)
+				return cp - s + 1;
+			else if (cp[2] == 0)
+				return cp - s + 2;
+			else if (cp[3] == 0)
+				return cp - s + 3;
+			if (sizeof(longword) > 4) {
+				if (cp[4] == 0)
+					return cp - s + 4;
+				else if (cp[5] == 0)
+					return cp - s + 5;
+				else if (cp[6] == 0)
+					return cp - s + 6;
+				else if (cp[7] == 0)
+					return cp - s + 7;
+			}
+		}
+	}
 }
 EXPORT_SYMBOL(strlen);
 #endif
-- 
2.38.1


