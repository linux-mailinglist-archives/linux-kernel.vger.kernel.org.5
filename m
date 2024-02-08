Return-Path: <linux-kernel+bounces-57338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E80784D71F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738F71C232A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185BD33CFC;
	Thu,  8 Feb 2024 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z6B+gbAC"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF52D79D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351776; cv=none; b=bclDNAc8y2lKwzejDPQd92WrOsZvRb8v3XRnszDd7Sbdg5HD7obUyqT1Du0w9e7NS4FVvuh4ZqwJCuUm+nt9kWzdrinJqhgkEAujGyh+1GUGWJi0iCYv4OonSHfU3xYiYeOQ32ZI6G9NhoRSHK4SBvSP0Z4y3iJlnaxaI/NSA7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351776; c=relaxed/simple;
	bh=4CKurykIUNpeJxcrH6U0OPpd6xWiFvuooSO5RXl+kNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tO9HKcLDVevENe0vz7krSGJwfQt/bbSj+D+GY9Djx79IiTqTz/dFnw84VKXqqy6sBfwpTo1aAYNXDY4xK9Ir7ihurv3YQHdXsU0g+oKN7/sJcBUdrFg0O9TZS30H5mPU0j/wQJ18pFwb9kNS5UFUxK1/1KSKL3FZQg5mpFWp1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z6B+gbAC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6daf694b439so1065018b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 16:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707351773; x=1707956573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/BsuHj3VQmzHd8+a3KYmlbDxHGdjbJNxGMh2W3gCsc=;
        b=z6B+gbACzWbMkCCx98IiYGzbe7JUojJ0NrXXmNgnsf4GlZVBDuUCjdJ9JgnvtkZeJU
         UYrcGK1Ir6pqDazgcsr9y8t76Q5qg4M6s7IUVIN9GXsqX+YOCoDV5bRQfrTmJYSGszN5
         7ij4kws3A/m3zf9r7uJotfr1NQO4Lba9aZYGD287ytreZUxv4eR6vw3nJH/4X9OBTsPy
         6BACZimNY59/G57JbkqtHsMGKu31WUQ4TGVWUFlKgQ2/1RFeRHIakxTuWMrUQc2hH4ql
         Ra9Zsoy//RksMCseK2YisjyGZ8BkdLvKjUJo0MN2ftJ7Ref53xDl6ndJZw+fwH1JsuLp
         WQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707351773; x=1707956573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/BsuHj3VQmzHd8+a3KYmlbDxHGdjbJNxGMh2W3gCsc=;
        b=WB3qhtyh+zh56yMBVQq9CD3XLp3NnXzi2ZyGcBIBl7s1bceLP7BstJy839oC3pkYpg
         nLUx1DtJrGtw2PIPbhmfiiH0OvI69rDFUrdvj4WjeTW2YzRTahpDf9EU/9RVnPURuO7d
         o0r+jEvIiiWerYIzEmt5J+hoJ5eqxVbVjUjRlDX4Ul9251xaRlPxLwPMGr6P6rYKMb+Q
         zpZD6RD7PstccuIzslHz1P7r3yPrkLeJAOfFlQS75CMnBL/9MnPoSOA7Gat9RpuUtaht
         VH+B3U6XI5Q6SL5kLsptNeaWg0tvrQKazx83nuv684/SCh/F+4RjBRh0FZvXRa4XlQkO
         VbXg==
X-Gm-Message-State: AOJu0Yylm6UEzqVLSVnog3AbLOXd1scx0zx2hGm+CzT6CkglL1PKVuCZ
	5Qj5PFyNcsYS6dxtocsZeoDGMjUfGG4JHZTcRDYqnm0cvV+X1lBRtEZdDI1GKDR3TATyLLItlIC
	Y
X-Google-Smtp-Source: AGHT+IHjqWrLpfwbm0T4Bc0N2ELBoSHjyLRSzkKZmIrGApvXqZ1uqtt/50hFUPWyzTw/MOC8D31dXQ==
X-Received: by 2002:aa7:8a0c:0:b0:6e0:4697:a8f1 with SMTP id m12-20020aa78a0c000000b006e04697a8f1mr3982693pfa.11.1707351773167;
        Wed, 07 Feb 2024 16:22:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgeeQjVGOFwNnlQizMaGB4axWA/3XIyzqQdXM3NBydQpn4ekb464+TCZQUN6MBBYkUE04FWNm0Qycj24e8alDsQxW9x7KYyO6iVRRIIyIhdCT1P5x2dhb9Rm0EQc2l/T6Dz4vSSnd4+Vp8uQPqDdu+M6qxd3Qj6Vh3EDSiB98VWLQbve1ExrsnA2YGXLvzQ0KI4DPnrIM5ZnL0cg==
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id g13-20020aa79dcd000000b006e03a640007sm2272630pfq.71.2024.02.07.16.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 16:22:52 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 07 Feb 2024 16:22:50 -0800
Subject: [PATCH v6 1/2] lib: checksum: Fix type casting in checksum kunits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-fix_sparse_errors_checksum_tests-v6-1-4caa9629705b@rivosinc.com>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
In-Reply-To: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707351771; l=2449;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=4CKurykIUNpeJxcrH6U0OPpd6xWiFvuooSO5RXl+kNI=;
 b=wJBv63kpB1zaus48cuP8nSNDobmAaAxStQrZN/5cqKGvH+MMDVxnRhBlVpEJi9oNnLFDrEiHC
 QIBC0ahdHE4DAjzdMJpP9uPDcKXMrgLis9QFfa+6jlR4Aj3XD/qRA8U
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


