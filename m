Return-Path: <linux-kernel+bounces-167066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC958BA3FF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059C42816ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155094D5BF;
	Thu,  2 May 2024 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FovkIkSu"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62046B80
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692737; cv=none; b=O7crce+CHYmPJoOT2Z+z4h/lVYR+LeDqzBk6WzDEPr3A+W+DVJdoaULGKEwFTEcFoUC1WWGh+yNd/K0/oilZM6PR4qHMfuosV9MiVEHmE3WgAWq6lVm2EdScXh4fN0BsI7fUsD+cgyYyst8jP7v3HMF/apXUH4St0XV3GUmAY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692737; c=relaxed/simple;
	bh=JjG9zTh3YcEGevq2mGu1lapQZDi6ixXR4kkaGkiUikM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TlPE4er0/5wEXKcn1+SlldVeWWW4alcfFhx5IcKv18tFFMLUcN9aYshR6hGQUSN8L8goTanGXw6ZP3SyY7v5FQ/05M6Qc6IOEHzonLRTvi5TdfnM6fKMAET4dYY7BrZ60bUC+2/jKvBR6t1S2ABJM2itdOSpxY+jV1Esy3kvQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FovkIkSu; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61bee45d035so38695817b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714692735; x=1715297535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwV1HZVleW01thm7cKmWmN1euQJwSchKow0lguZfgFs=;
        b=FovkIkSuwpRyRsoZTvFnqnVfc2SiM8x8HEbO/pnTc5uEHyyiAdeMFzSFrLt/e3XgtI
         38L4AAT09UtcF9PvA24dzbopMKwSr4UDi7vACrxmU/IJJpdDp0BDmkOWpzEBJspY9I69
         5ZvoqCkIN/yfPK953BJwShB1LdLZJvTf8rFBPv1YFVQerkPuY4naIyO5Wh8nI8SnF7dy
         UuzufOS0/uUPefcA8J584XzfuQxkUBZy7kVWxCHYdxRPNz56ZyAFV+TOvyFsTkjm/z7H
         ehtFSWM0no8MkMQkC8Q7oEHvTlj2gZpI0a2hg3QGfmNhBasUt0pmCCoCjcf701P/UfyL
         OotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692735; x=1715297535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwV1HZVleW01thm7cKmWmN1euQJwSchKow0lguZfgFs=;
        b=iTxf9fHuRK2iBKcnCZdsco1t6+2iC/9gxkynqGDk+i9Rb/NR6zSOKh7s+u1ocDrAjz
         tCYcJaBJjx/228MaI70SkDSkVZ9TzQ8bsTGz9xrAg3kpJi1+epMlXsaMGoSiEVrgteAz
         h+SzfQPEnKspawXD2G35TPHWcSAJRYOEZe0GOdpmXom810eUILTgI40gderHyXULwQvY
         VNqfYWNINzntRMw7xxum+3NYv6FZWyrxafReKHE/CxzbctdghCMdHcCjKu2HW2PzMXmk
         PTnm+Faud2/9Kg21vUkO1k3vJLNxhk7+UhusB8JYcHpfNTIZZb5tZ91o5LL4WKSVFd3f
         u/7g==
X-Gm-Message-State: AOJu0Yw3Izi/iKpnjdoAxxyc0oYFd3LWHiW1O1rPtyH8mpGTIVUvIGXd
	yhGqYTSZ4wYmaVOZzCD082H3ug5eYnRcQ1Ai3S5fF8zuguWLSZJV/OeK0g==
X-Google-Smtp-Source: AGHT+IEfIyTCFtIJsgR5/4dFaKx64FgUX3BiK43cMG6jgpNDd+rdbywqtcN3n4X3qgws0YGbJKmeDg==
X-Received: by 2002:a81:4882:0:b0:61b:1f0d:838b with SMTP id v124-20020a814882000000b0061b1f0d838bmr1103567ywa.14.1714692734769;
        Thu, 02 May 2024 16:32:14 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id s20-20020a819f14000000b006152af6131dsm420052ywn.119.2024.05.02.16.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 16:32:14 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 3/4] bitops: squeeze even more out of fns()
Date: Thu,  2 May 2024 16:32:03 -0700
Message-Id: <20240502233204.2255158-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240502233204.2255158-1-yury.norov@gmail.com>
References: <20240502233204.2255158-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function clears N-1 first set bits to find the N'th one with:

	while (word && n--)
		word &= word - 1;

In the worst case, it would take 63 iterations.

Instead of linear walk through the set bits, we can do a binary search
by using hweight(). This would work even better on platforms supporting
hardware-assisted hweight() - pretty much every modern arch.

On my Ryzen 9 5900X, the test_fns() benchmark runs binary fns() twice
faster, comparing to linear one.

The fns8() returns 64 to make sure that in case of no bit found, the
return value will be greater than the bit capacity of arguments of all
fnsXX() functions up to fns64().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitops.h | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 57ecef354f47..1c4773db56e0 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -247,17 +247,49 @@ static inline unsigned long __ffs64(u64 word)
 	return __ffs((unsigned long)word);
 }
 
+static inline unsigned long fns8(u8 word, unsigned int n)
+{
+	while (word && n--)
+		word &= word - 1;
+
+	return word ? __ffs(word) : 64;
+}
+
+static inline unsigned long fns16(u16 word, unsigned int n)
+{
+	unsigned int w = hweight8((u8)word);
+
+	return n < w ? fns8((u8)word, n) : 8 + fns8((u8)(word >> 8), n - w);
+}
+
+static inline unsigned long fns32(u32 word, unsigned int n)
+{
+	unsigned int w = hweight16((u16)word);
+
+	return n < w ? fns16((u16)word, n) : 16 + fns16((u16)(word >> 16), n - w);
+}
+
+static inline unsigned long fns64(u64 word, unsigned int n)
+{
+	unsigned int w = hweight32((u32)word);
+
+	return n < w ? fns32((u32)word, n) : 32 + fns32((u32)(word >> 32), n - w);
+}
+
 /**
  * fns - find N'th set bit in a word
  * @word: The word to search
- * @n: Bit to find
+ * @n: Bit to find, counting from 0
+ *
+ * Returns N'th set bit. If no such bit found, returns >= BITS_PER_LONG
  */
 static inline unsigned long fns(unsigned long word, unsigned int n)
 {
-	while (word && n--)
-		word &= word - 1;
-
-	return word ? __ffs(word) : BITS_PER_LONG;
+#if BITS_PER_LONG == 64
+	return fns64(word, n);
+#else
+	return fns32(word, n);
+#endif
 }
 
 /**
-- 
2.40.1


