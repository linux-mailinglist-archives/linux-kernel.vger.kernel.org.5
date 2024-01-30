Return-Path: <linux-kernel+bounces-45171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB18842C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F00B22D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF0C7AE5A;
	Tue, 30 Jan 2024 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RUrUVSLZ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD076997A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641846; cv=none; b=FC9z61keMTSBoR2Q7yTZlQJS9f7Zd5PkdfmT2ygYwasHzCv58HnShzvErHaDpND0oJjRla23L6yNi5MRXwww9FPVuwFOsHhZw0kVSes35d/Yr/iMkSMs/WHKc8zgRxrQrqG/f3SLufWwIebeuxLSwmAuE4IrNT2nQuCkiF3JjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641846; c=relaxed/simple;
	bh=4CKurykIUNpeJxcrH6U0OPpd6xWiFvuooSO5RXl+kNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+7Xr4QRToXcEaWOe85zNXWQ/DOZ7VdOhkyrdIBdleNAEtGTsHpy+5ymq0eoPwrrxwhSejYIMDKawIYbfixW4B+aFqnAMFx7hXWV1PdHlD94oCX0h/DfHmAtb2qr9btXxxwcTg/lb2Kk3i0P96nCjFusYmYL/blYDobOLerGB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RUrUVSLZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d8cea8bb3bso13653745ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706641844; x=1707246644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/BsuHj3VQmzHd8+a3KYmlbDxHGdjbJNxGMh2W3gCsc=;
        b=RUrUVSLZrxi29N0BkyQS9YKvUt5Lqu525raBdn7aLilRRlXIPTk+mCgiX+O6dI8x9A
         R3lw75r2PHzukiqpA2m/eSr4L3zcbppjUYMiWJXJ8606wR9XzZAXk7vIihJphSHBbLOO
         oUhSxUGY2Y3cptoEwwiN1RFHqc2BN5ZbngGkS2L1v00bWUVsNuG22RgLTzimTqUBv7zc
         DhPR0Jq7cFmmUvHDIin1DQMeArbhoHo43Qne0iERiT/3q/bHnayd8HNdtTaqD2t27JYz
         8WEK6Z0rRbS2c9xg2p+s0wb1nJ/lCJVbBj35BjJZ9Jw6Oj6hGaYfErGVV5Uwn6QxMWZy
         3fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641844; x=1707246644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/BsuHj3VQmzHd8+a3KYmlbDxHGdjbJNxGMh2W3gCsc=;
        b=Z0UmUPHlkd+P2cS7C/pysZhseNqO3DEG3FEk7s4GkDeLCuQ1ZhgcW6wABugpgFFszg
         a0R34ccdkQvxea5Rs2WB5nI+X1NRVRApzbLGct9BpaLzDvdvb1ai9aLA1pH/CF1Jcw7U
         UdRXD+hDZ/lCoBtDVjudiHXHSIAK6vb4BkUlAnDXhRq6ll/r/6dK+5nVLUkSx9VbCYWZ
         tWPfRKhrcNsaySS5VFFbFWurFNRRqMKJJ/7LriZu6efGmdq2oNIQjaGVjqcSiwqJ2+Qb
         wvZEcWzt1MVUni3pG7mav+HRC34dAv8sT8r+CAXsrcLJlalMUDU89bpdXGRAx2O6AHIt
         vuVw==
X-Gm-Message-State: AOJu0Ywt583k83SjnW0vVdXWU+udX/90smdiRA29sC5mqpvSEsRsnDVW
	p8TAdPVE1GB5lIQHFWVgkQXWIApxxuCRiPcjCC156/J93w1zGcbI8CQxnEr1P3o=
X-Google-Smtp-Source: AGHT+IGYIYaf27SkkDQMBKq5PCpBQ1EXRgp/Ndp48IM5ImEknaDxFpXU9VFAvP6yqalVYuKyBI7TLg==
X-Received: by 2002:a17:903:2985:b0:1d8:e2af:f7a3 with SMTP id lm5-20020a170903298500b001d8e2aff7a3mr516804plb.60.1706641844013;
        Tue, 30 Jan 2024 11:10:44 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902ebd000b001d91d515dffsm605340plg.156.2024.01.30.11.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:10:43 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 30 Jan 2024 11:10:03 -0800
Subject: [PATCH v5 1/2] lib: checksum: Fix type casting in checksum kunits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-fix_sparse_errors_checksum_tests-v5-1-4d8a0a337e5e@rivosinc.com>
References: <20240130-fix_sparse_errors_checksum_tests-v5-0-4d8a0a337e5e@rivosinc.com>
In-Reply-To: <20240130-fix_sparse_errors_checksum_tests-v5-0-4d8a0a337e5e@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706641842; l=2449;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=4CKurykIUNpeJxcrH6U0OPpd6xWiFvuooSO5RXl+kNI=;
 b=ntcjB985UMqaIuXRZL/4gxJlmmqHVS2v+EXM00xdfj5+udEoKNMBpvbauhVdIbkewXW4KAH3R
 5vuR6BOPq+SDVNzK2iuYzdq3rs7iWwM1CNUNclHaGjmcDfQYU5Ldo1e
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The checksum functions use the types __wsum and __sum16. These need to
be explicitly casted to.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401200106.PMTn6g56-lkp@intel.com/
---
 lib/checksum_kunit.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index 225bb7701460..776ad3d6d5a1 100644
--- a/lib/checksum_kunit.c
+++ b/lib/checksum_kunit.c
@@ -215,7 +215,7 @@ static const u32 init_sums_no_overflow[] = {
 	0xffff0000, 0xfffffffb,
 };
 
-static const __sum16 expected_csum_ipv6_magic[] = {
+static const u16 expected_csum_ipv6_magic[] = {
 	0x18d4, 0x3085, 0x2e4b, 0xd9f4, 0xbdc8, 0x78f,	0x1034, 0x8422, 0x6fc0,
 	0xd2f6, 0xbeb5, 0x9d3,	0x7e2a, 0x312e, 0x778e, 0xc1bb, 0x7cf2, 0x9d1e,
 	0xca21, 0xf3ff, 0x7569, 0xb02e, 0xca86, 0x7e76, 0x4539, 0x45e3, 0xf28d,
@@ -241,7 +241,7 @@ static const __sum16 expected_csum_ipv6_magic[] = {
 	0x3845, 0x1014
 };
 
-static const __sum16 expected_fast_csum[] = {
+static const u16 expected_fast_csum[] = {
 	0xda83, 0x45da, 0x4f46, 0x4e4f, 0x34e,	0xe902, 0xa5e9, 0x87a5, 0x7187,
 	0x5671, 0xf556, 0x6df5, 0x816d, 0x8f81, 0xbb8f, 0xfbba, 0x5afb, 0xbe5a,
 	0xedbe, 0xabee, 0x6aac, 0xe6b,	0xea0d, 0x67ea, 0x7e68, 0x8a7e, 0x6f8a,
@@ -582,7 +582,7 @@ static void test_ip_fast_csum(struct kunit *test)
 	for (int len = IPv4_MIN_WORDS; len < IPv4_MAX_WORDS; len++) {
 		for (int index = 0; index < NUM_IP_FAST_CSUM_TESTS; index++) {
 			csum_result = ip_fast_csum(random_buf + index, len);
-			expected =
+			expected = (__force __sum16)
 				expected_fast_csum[(len - IPv4_MIN_WORDS) *
 						   NUM_IP_FAST_CSUM_TESTS +
 						   index];
@@ -614,8 +614,9 @@ static void test_csum_ipv6_magic(struct kunit *test)
 		len = *(unsigned int *)(random_buf + i + len_offset);
 		proto = *(random_buf + i + proto_offset);
 		csum = *(unsigned int *)(random_buf + i + csum_offset);
-		CHECK_EQ(expected_csum_ipv6_magic[i],
-			 csum_ipv6_magic(saddr, daddr, len, proto, csum));
+		CHECK_EQ((__force __sum16)expected_csum_ipv6_magic[i],
+			 csum_ipv6_magic(saddr, daddr, len, proto,
+					 (__force __wsum)csum));
 	}
 #endif /* !CONFIG_NET */
 }

-- 
2.43.0


