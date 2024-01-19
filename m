Return-Path: <linux-kernel+bounces-31510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D5832F53
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375911F22F64
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6861A5644C;
	Fri, 19 Jan 2024 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tOEmZPzS"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17A1E520
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705691670; cv=none; b=WIRWFJiUPx0itsA8NOvZ2SrvE6n7P3GEkC3hbXmhm7hv7nhitMPhZ9orKWg975VKMnlyOaDTFvPiPoesOrTZqW6nW3UzQcAvTsmVOpEJR8EfBGPnENOmDJ/KFLaJgh670JbC6mjf9ao0VO+HgGdeT0rGCuki5ZMv0tMTdta9XuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705691670; c=relaxed/simple;
	bh=XfA3mXR/kpCiBxjtCgQDEdmO3fLSqh0nuac3M9FDsz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ww8onEyJF5oywWgUXGgxiRVpmM4b2O8jvlhcY7V9hdceM+2px4fs3rF4LGRKgqhKRBl5/8oeQM3GgjjGEwo4oiH6ymtJK9S/h/LjIC5XjKQMkc0QswXIN9+/MA9K1Ce1L3eIJdZQa/61Pc727DVit7OC4ltSurvRfKDFjTTgK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tOEmZPzS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6dbb003be79so1440135b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705691668; x=1706296468; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RX04359vUujevZcu+leKo6r+RMZzMdp7p5uteZ17bR4=;
        b=tOEmZPzSpDu+EFf6C1wkU68LIQ2jN0HT5nOZYUgOrv8tOHAaA7Qqg6xmnPsIK7UE5G
         o+zCCoTSo9JQtbJapxA6hTDRaJGw5r4YiM4ZPm/VSBPHOfUd5yykvRxNULqfE9E9rwt8
         2LbEiPz+dNPsFwmF8ZxLuEWZp9ILJxzPzO9+6KryASHnFPkGznyoRmm9Dyp6QEAY/Udr
         HyOAc4DyHC0odkDfdDvcs7yONzQN0BC4mKNZw+7h2KBlnZiBKf7cPP9If+BQQng2QpdW
         YhSdhsB6TvvQD60Jr7NONDhKNlPB7ShirJeTI997cQPkp6UXtK7UmLrP1x/iyszjTXdV
         QwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705691668; x=1706296468;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RX04359vUujevZcu+leKo6r+RMZzMdp7p5uteZ17bR4=;
        b=CXcpJ9pJQXR1/N9Ayu0mGVdxB0YmUEo/Kd9hScsgrrYmfgibu8RwqzdpLE9W7qFLk3
         aq4K2Rq54wQczNgHkj43pyY0pM1cRlC6iBQDl6yHNo7Wgh11cGD2PvWxbECpUrjvQnUb
         qQjTM4Eo2MquOyU9diIyqX0+ZrrQ0Q4QF5JWH5+ArUMG2JukVXj7uLorOv3xQGOoFaUM
         VWSDWHYJE96A9prOOChhfhQ1eA/FtA/zJIL3V4Lh0VBaxdfrio8xchMMbWnNU5X6+dlc
         kv3CVJ6kmVvMNh+ZzhyWruaG051VY5aDM3Mf0K4m+9DaiMb5Wd+1uz3HO5pGLlN66hwv
         RFyw==
X-Gm-Message-State: AOJu0YyS6YwO16V50+Ds9VuxnvSIdZ7RuhX5thU6/Ocho/Dio4boKXHg
	fjbZpAGd0tR0bczGd3GVaidL5ExiEp4Xb2LQ600KPDC6qQAmIdnY4QIYdmMGY5w=
X-Google-Smtp-Source: AGHT+IEWM40rm6IsX+oi/UzTpGzdpZBL1w7ubahGd+ddWzKf36kvdDhPMxZhJvHWoMuDls9DkIZhjg==
X-Received: by 2002:a05:6a20:9e91:b0:199:9c28:b091 with SMTP id mq17-20020a056a209e9100b001999c28b091mr343143pzb.48.1705691667865;
        Fri, 19 Jan 2024 11:14:27 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c20-20020aa781d4000000b006d9a6a9992dsm5464361pfn.123.2024.01.19.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 11:14:27 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 19 Jan 2024 11:14:24 -0800
Subject: [PATCH] lib: checksum: Fix type casting in checksum kunits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240119-fix_sparse_errors_checksum_tests-v1-1-2d3df86d8d78@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAA/KqmUC/x2N0QqCQBQFf0Xucwvutpj1KxGLrqe8RCr3WATiv
 7f0OA8zswlhCsql2sTwUeo8FfCHSvLYTQ84HQpLqEOsvT+7u34Tl86IBLPZmPKI/OT7lVZwpQt
 N3zb9MQ6nNkrJLIbi/BfX277/AE/6c31yAAAA
To: linux-kernel@vger.kernel.org
Cc: Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705691667; l=2611;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=XfA3mXR/kpCiBxjtCgQDEdmO3fLSqh0nuac3M9FDsz0=;
 b=2i3QyMUWbRI5BTNf/3Ct9GGtaQ0lCJuGHu4qJG3hV8wCO7mFew+a2WJBxxJsqfGd0aGAakEHJ
 LlvBhpUnhLwBJYKw+2ATAA62VIPhVVM6aLt3G59rj8/7CtzlwYJ6oxI
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The checksum functions use the types __wsum and __sum16. These need to
be explicitly casted to.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401200106.PMTn6g56-lkp@intel.com/
---
The checksum functions use the types __wsum and __sum16. These need to
be explicitly casted to.
---
 lib/checksum_kunit.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index af3e5ca4e170..09e2b262a3f2 100644
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
@@ -613,8 +613,9 @@ static void test_csum_ipv6_magic(struct kunit *test)
 		len = *(unsigned int *)(random_buf + i + len_offset);
 		proto = *(random_buf + i + proto_offset);
 		csum = *(unsigned int *)(random_buf + i + csum_offset);
-		CHECK_EQ(expected_csum_ipv6_magic[i],
-			 csum_ipv6_magic(saddr, daddr, len, proto, csum));
+		CHECK_EQ((__force __sum16)expected_csum_ipv6_magic[i],
+			 csum_ipv6_magic(saddr, daddr, len, proto,
+					 (__force __wsum)csum));
 	}
 }
 

---
base-commit: 4525462dd0db9e86bb67c10dedbbaa4f8d62697d
change-id: 20240119-fix_sparse_errors_checksum_tests-26b86b34d784
-- 
- Charlie


