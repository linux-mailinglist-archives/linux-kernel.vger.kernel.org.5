Return-Path: <linux-kernel+bounces-165312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653B28B8B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919381C2158A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67812EBE2;
	Wed,  1 May 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijDP3YbT"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451CE12EBC5
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714569661; cv=none; b=TvgSc8kPBBh9tCcPx//uVPSNGEoHr8vLskHvLciUOrJq9cteogbZnwEXwRz8452h/ZfEwti5Ht68ESIOILz4Vy1oFjC9fgDgfHc6XfgIEKZ08wPQ8N0dS3uv1v1I+fUPSmg5Qy3AFNT7PACmy0XlBL0MXekQ8HU8BrIsl3/MbZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714569661; c=relaxed/simple;
	bh=NZE08G/LqeGcG2yMEUuX0qI+6M+X7Wcar8H+m+SETtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htRGW+pURsU8sM4KgGYfWxddfmQt2p1WD9gMQpdj3RUZ7+OIXLVNoB5W7rDxaPKypS4IfIoe/COXiHHrfuv6ZE5Qtra1crVNG2sL+GDAgOzqJ+YQolpRDfXo/e3rxVXJLGErmQQlLq5SUipbnM/5u6KLDNP3+CG93FElPCMOXvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijDP3YbT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5f803c625c2so398494a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714569659; x=1715174459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvhrzVU9em3tEzFIzAQNhBQoieSaMynlhOsy4UcuIKg=;
        b=ijDP3YbTEy/20LPUtSArmaI08gAjefYa8i6rUokVJClTECnkIGE+/gxo4Epc0YVvjH
         oEOhqSqKWylAWflRDTXUZvl90ii6IGJtu6m2AlFkxfwt8nczTRvjB0rIs4Jx4uQ8yE3y
         w9cKBmKVDkzbmO2LRw8+dX+BaYGd0ec+MSpW/gUn9HiyDLFKlcePWw0r3zSaTUI/uWHs
         7J3Bgn5/ZQYbRSllZ4ATlxf09B/WdPo14nup6JBSgi6rQPZTqYD+xJqlyqFcXTDS8S7Y
         GIuohGSrTQKfOfrCS0yP4KYRex/LRBFjAxZnscytZWNm/scUDKUX37kXJ7eyVcFq8Tol
         SKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714569659; x=1715174459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvhrzVU9em3tEzFIzAQNhBQoieSaMynlhOsy4UcuIKg=;
        b=BfcK8/LTXTuNAtbQ0mfCtVRRBKy7NPyVcsvs0TwP1XWjIjhi59aoHTPIm40h4/C5Qs
         TFrACd4/egtiUqbHzbGMtAsqv9b3uMKflf3fc2u9K+tK9YgnJ3R8Uto9cVcUiN+whG3u
         hxKC6rdbuzITIkWSkHILwqew7ORykZ4x46gMdDXJVR2Eouxm+jOAjPFpxIodXnpdV2kL
         YgL0zaq4uIYcvhr/3W7msSObF+MIRis5oUKl1e7smY2G3daIJtdrPhd6VDExJka80mLX
         uRHGpRe/ALKmfvF3PQ8Nht4QJQHisbi38Id+dMu21jHVcLS/gOkFdK0q9mVN4rChwNn7
         IFdA==
X-Forwarded-Encrypted: i=1; AJvYcCWXczqF8UlH1E7AjMddW6tI7qj9XeRUT/+YuxPaoof4a9nG0JO17zkohXPbXAxblafDr4643mutLkKC8n8fSV9ox9r/HjwaiomeBA7v
X-Gm-Message-State: AOJu0YxejFbDsrv8YrdNVVSnkqXfiOSEZ1/QkKUYCZokPCl0o3wdjhBX
	0QFaZbWf0RRLJPDiZoKZuK8C5WVi0AMs3G+CuW4I0QpTkcK13Qyb
X-Google-Smtp-Source: AGHT+IFgR/QBXyH8gmv6yU87naxcsbqSSYoY56wH1UDIiThJv+osqdnV0rHZjxzAOHoCtOUsIfhbiQ==
X-Received: by 2002:a17:902:e5d0:b0:1e9:a06a:c3c3 with SMTP id u16-20020a170902e5d000b001e9a06ac3c3mr2647320plf.5.1714569659387;
        Wed, 01 May 2024 06:20:59 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b001e0648dfd68sm3277164pli.296.2024.05.01.06.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 06:20:58 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	n26122115@gs.ncku.edu.tw,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 2/2] bitops: Optimize fns() for improved performance
Date: Wed,  1 May 2024 21:20:47 +0800
Message-Id: <20240501132047.14536-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501132047.14536-1-visitorckw@gmail.com>
References: <20240501132047.14536-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current fns() repeatedly uses __ffs() to find the index of the
least significant bit and then clears the corresponding bit using
__clear_bit(). The method for clearing the least significant bit can be
optimized by using word &= word - 1 instead.

Typically, the execution time of one __ffs() plus one __clear_bit() is
longer than that of a bitwise AND operation and a subtraction. To
improve performance, the loop for clearing the least significant bit
has been replaced with word &= word - 1, followed by a single __ffs()
operation to obtain the answer. This change reduces the number of
__ffs() iterations from n to just one, enhancing overall performance.

This modification significantly accelerates the fns() function in the
test_bitops benchmark, improving its speed by approximately 439 times.
Additionally, it enhances the performance of find_nth_bit() in the
find_bit benchmark by approximately 26%.

Before:
test_bitops: fns:          5876762553 ns, 64000000 iterations
find_nth_bit:                  4254313 ns,  16525 iterations

After:
test_bitops: fns:            13388431 ns, 64000000 iterations
find_nth_bit:                  3362863 ns,  16501 iterations

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/bitops.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..57ecef354f47 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -254,16 +254,10 @@ static inline unsigned long __ffs64(u64 word)
  */
 static inline unsigned long fns(unsigned long word, unsigned int n)
 {
-	unsigned int bit;
+	while (word && n--)
+		word &= word - 1;
 
-	while (word) {
-		bit = __ffs(word);
-		if (n-- == 0)
-			return bit;
-		__clear_bit(bit, &word);
-	}
-
-	return BITS_PER_LONG;
+	return word ? __ffs(word) : BITS_PER_LONG;
 }
 
 /**
-- 
2.34.1


