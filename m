Return-Path: <linux-kernel+bounces-51534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D63E848C49
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AB4282711
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AD614A8F;
	Sun,  4 Feb 2024 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVj0/VcT"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79901642A;
	Sun,  4 Feb 2024 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707036739; cv=none; b=BA092neXdcFbc6ZBCxQRRtad0PCL0WsdtRINQBA/pL2Cn1A4Rw/fpLd1/IXVXRa6qe+gqklb2toM6FbR+9HurkDj201QFQJ1ja/sD7SZpsrDEL3moT1cEaDCCqelGdHcpe78xhHcqKXuiV0s5SBLEsTDeYrTA2R9ZPPmrZsDs0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707036739; c=relaxed/simple;
	bh=LXtVdhUKnAh8eTFYbVyTry3ntQtaF2+aGyIy67uHW8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtdSJ2sGK8OEsYfzHvLFC3KCHAqJsvtG2NAB5tAJZ4YjI7LXiirSqIVCp9aqP44mLi+2egvpTifJT1WO8H31+gJkWQin/gkYc/V0cPMBUjlEOVXImbeWv6GdceUyxag+rm6TIvyDVxRxjbuMdaYQM+L+glFFacOgfRfB0E6qUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVj0/VcT; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so2284759a91.1;
        Sun, 04 Feb 2024 00:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707036737; x=1707641537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4z0nvVWnIAYTJA2M72IaGWpdL1cvbNZSmvJznW48f8=;
        b=BVj0/VcT9NlCvZwHNf3JiB2hqL28wGDN4WcdhlGfahrMldVnLXhXbf6lK+DgCKMonO
         b3UaesGCFaboCW0NRMbzif6wm1HdCUE84NTp5CByIJkbowKgVGpIEfWwB8ZDCZ0fPPB4
         hp/GzJmHKyXKmx3EdbBa72TNvkUpSIyEHaaXZZIbPGUHSoUgssszquw5Ki5H68Wg7VkK
         HWRbhTNLzmLqOtvhphhiuQILvJf/rRtVUIlf8gc7ljeZavamyLUI/g/IUbsd7OEyY4+E
         sIxz6uLwRkwtS4Q6k+o+Br5O/JK5OzJTCVsixiPHDu4hlcQxaXbtk9l1+PDxhPpEPo3D
         FuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707036737; x=1707641537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4z0nvVWnIAYTJA2M72IaGWpdL1cvbNZSmvJznW48f8=;
        b=cV0roKLWNZIficz7mVpv9U/yhhptlUAeb1VralfFTCAB6qbXnIIpnReMJgIQVeKYwQ
         yW71UOnJSHG9uAQHqX6T+DjgOENzM8KVZYAHVmMHwLJp6w7bDHbdUEKwSoSBQNh2e6/K
         +newJqENDYjkFXt6LsGD17HHcXQm8eFnSImjz+2kWPk6JR+g3QnRKdGZnpcanC8koo3Q
         agFIBgfcQKNAx47quSigTTNIOHaX1f/8xIbqpNEcevseg8NgUciQWzlgqRi3bWqS1SXt
         mqj74U3A5/Deo5OSq7PZajlUAjH4qj9aYc5q4mgAN/0W9yp9Dtnc0Q/qW4u9o5Nj5CAf
         mc0g==
X-Gm-Message-State: AOJu0YyhnmAWxEivuzCzVnnSTMhqAhCRKc9Dhb9dukIyD/V7uWzApLlf
	ZK1MjnNfkhXPuy7ruFFvJPZTmJSqJRYCungAg1dQsbmDCVXpO8Ik
X-Google-Smtp-Source: AGHT+IEcYiw8dThyDCH2LzMECBuzlS6CvMGFjjK3PsTXXNtFA4KTa7waR4fjoN14ngsgKukNtaGsWg==
X-Received: by 2002:a17:90b:3846:b0:296:2383:fb80 with SMTP id nl6-20020a17090b384600b002962383fb80mr7152730pjb.26.1707036736861;
        Sun, 04 Feb 2024 00:52:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUjBlxxA1lFb+5HgSJ3g90MGzz9eA948Va1u/N809Q9E5kqkDLPRvj0mQI4uNIpZ4nGuZJNNBCUxsz+HJvP4L8jPM096pfXyCamjBmmupfo4xygz3oogZ8yR+ESO+qnGhx37JRnZ2upccyBrV53ekfJBS60K5J8sa2L1EJWI6AxA6NH5Nqu6CjWdtlWR/FGYXUwnx+q4KWRtmc2b+G6t3i6n6n53FQIex+mtrBGnlMWkAJuIFBnvsRy+ufYqK5wkPnlnrbLwArD
Received: from localhost ([112.7.96.15])
        by smtp.gmail.com with ESMTPSA id jx15-20020a17090b46cf00b00296540086a5sm2898818pjb.23.2024.02.04.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 00:52:16 -0800 (PST)
From: John Sanpe <sanpeqf@gmail.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	rdunlap@infradead.org,
	torvalds@linux-foundation.org,
	unixbhaskar@gmail.com
Cc: mm-commits@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH] lib/bch.c: increase bitrev single conversion length
Date: Sun,  4 Feb 2024 16:51:55 +0800
Message-ID: <20240204085155.6745-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimized the performance of the three functions (load_ecc8 store_ecc8
and bch_encode) using a larger calculation length.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 lib/bch.c | 87 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 38 deletions(-)

diff --git a/lib/bch.c b/lib/bch.c
index 5f71fd76eca8..e9a9517e7b1b 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -73,6 +73,7 @@
 #include <linux/bitops.h>
 #include <linux/bitrev.h>
 #include <asm/byteorder.h>
+#include <asm/unaligned.h>
 #include <linux/bch.h>
 
 #if defined(CONFIG_BCH_CONST_PARAMS)
@@ -115,14 +116,6 @@ struct gf_poly_deg1 {
 	unsigned int   c[2];
 };
 
-static u8 swap_bits(struct bch_control *bch, u8 in)
-{
-	if (!bch->swap_bits)
-		return in;
-
-	return bitrev8(in);
-}
-
 /*
  * same as bch_encode(), but process input data one byte at a time
  */
@@ -135,7 +128,10 @@ static void bch_encode_unaligned(struct bch_control *bch,
 	const int l = BCH_ECC_WORDS(bch)-1;
 
 	while (len--) {
-		u8 tmp = swap_bits(bch, *data++);
+		u8 tmp = *data++;
+
+		if (bch->swap_bits)
+			tmp = bitrev8(tmp);
 
 		p = bch->mod8_tab + (l+1)*(((ecc[0] >> 24)^(tmp)) & 0xff);
 
@@ -152,20 +148,27 @@ static void bch_encode_unaligned(struct bch_control *bch,
 static void load_ecc8(struct bch_control *bch, uint32_t *dst,
 		      const uint8_t *src)
 {
-	uint8_t pad[4] = {0, 0, 0, 0};
 	unsigned int i, nwords = BCH_ECC_WORDS(bch)-1;
+	uint32_t value, bytes = 0;
+
+	for (i = 0; i < nwords; i++, src += 4) {
+		if (!bch->swap_bits)
+			value = get_unaligned_be32(src);
+		else {
+			value = get_unaligned_le32(src);
+			value = bitrev32(value);
+		}
+		dst[i] = value;
+	}
 
-	for (i = 0; i < nwords; i++, src += 4)
-		dst[i] = ((u32)swap_bits(bch, src[0]) << 24) |
-			((u32)swap_bits(bch, src[1]) << 16) |
-			((u32)swap_bits(bch, src[2]) << 8) |
-			swap_bits(bch, src[3]);
-
-	memcpy(pad, src, BCH_ECC_BYTES(bch)-4*nwords);
-	dst[nwords] = ((u32)swap_bits(bch, pad[0]) << 24) |
-		((u32)swap_bits(bch, pad[1]) << 16) |
-		((u32)swap_bits(bch, pad[2]) << 8) |
-		swap_bits(bch, pad[3]);
+	memcpy(&bytes, src, BCH_ECC_BYTES(bch)-4*nwords);
+	if (!bch->swap_bits)
+		value = be32_to_cpup((__be32 *)&bytes);
+	else {
+		value = le32_to_cpup((__le32 *)&bytes);
+		value = bitrev32(value);
+	}
+	dst[nwords] = value;
 }
 
 /*
@@ -174,20 +177,27 @@ static void load_ecc8(struct bch_control *bch, uint32_t *dst,
 static void store_ecc8(struct bch_control *bch, uint8_t *dst,
 		       const uint32_t *src)
 {
-	uint8_t pad[4];
 	unsigned int i, nwords = BCH_ECC_WORDS(bch)-1;
+	uint32_t value, bytes;
+
+	for (i = 0; i < nwords; i++, dst += 4) {
+		value = src[i];
+		if (!bch->swap_bits)
+			put_unaligned_be32(value, dst);
+		else {
+			value = bitrev32(value);
+			put_unaligned_le32(value, dst);
+		}
+	}
 
-	for (i = 0; i < nwords; i++) {
-		*dst++ = swap_bits(bch, src[i] >> 24);
-		*dst++ = swap_bits(bch, src[i] >> 16);
-		*dst++ = swap_bits(bch, src[i] >> 8);
-		*dst++ = swap_bits(bch, src[i]);
+	value = src[nwords];
+	if (!bch->swap_bits)
+		*(__be32 *)&bytes = cpu_to_be32(value);
+	else {
+		value = bitrev32(value);
+		*(__le32 *)&bytes = cpu_to_le32(value);
 	}
-	pad[0] = swap_bits(bch, src[nwords] >> 24);
-	pad[1] = swap_bits(bch, src[nwords] >> 16);
-	pad[2] = swap_bits(bch, src[nwords] >> 8);
-	pad[3] = swap_bits(bch, src[nwords]);
-	memcpy(dst, pad, BCH_ECC_BYTES(bch)-4*nwords);
+	memcpy(dst, &bytes, BCH_ECC_BYTES(bch)-4*nwords);
 }
 
 /**
@@ -257,12 +267,13 @@ void bch_encode(struct bch_control *bch, const uint8_t *data,
 	 */
 	while (mlen--) {
 		/* input data is read in big-endian format */
-		w = cpu_to_be32(*pdata++);
-		if (bch->swap_bits)
-			w = (u32)swap_bits(bch, w) |
-			    ((u32)swap_bits(bch, w >> 8) << 8) |
-			    ((u32)swap_bits(bch, w >> 16) << 16) |
-			    ((u32)swap_bits(bch, w >> 24) << 24);
+		if (!bch->swap_bits)
+			w = be32_to_cpup((__be32 *)pdata++);
+		else {
+			w = le32_to_cpup((__le32 *)pdata++);
+			w = bitrev32(w);
+		}
+
 		w ^= r[0];
 		p0 = tab0 + (l+1)*((w >>  0) & 0xff);
 		p1 = tab1 + (l+1)*((w >>  8) & 0xff);
-- 
2.43.0


