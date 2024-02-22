Return-Path: <linux-kernel+bounces-75811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F7585EF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0CB1C21B92
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B01756A;
	Thu, 22 Feb 2024 02:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oZUda3Hf"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677EE14298
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708570607; cv=none; b=KMZi9oVtkLbhlgW1EBGFTXaBPOWX0Dy9DyG8iFI15xgfZIaSaX0orJXu0UvbFLTiKUfNo/ma7EalH0tSGDH9kXwh5pudJNR9kfFp1IPM68c1IlS7VPxFxDLPOgbaHSk2GVcj1ZoemUw6p6E9NB0tybxHjyeb2ReEHDQCaj3Xlnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708570607; c=relaxed/simple;
	bh=qIxvOuUQdTE/c11+6K8jm43GYNvTh+hoxAg5skAHgOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bddYnJ/wkGu8+GCQxI8V5MQi1svwf55ocbM/Aku63klqoUkFkIqDygcj4629SNeKpDm0DjJcaoSdtjxZv4IbJBbsMCQXtJAYAQploL8SoZmjr5dzwA2In/8Ma3atiAEKTczuLU3FSfatNIf+DsagXXv4952e0VepvV0K8abl6Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oZUda3Hf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d73066880eso69877065ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708570604; x=1709175404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pn7jhUvFrsr4hsFrRSTNI7io+CHMGvymnbNX2sEJ1l8=;
        b=oZUda3HfY7kZqtGS9rZ5hwOVKx1P27mCyqOYhDGmU10nqW9XrBfl9IRZcPWry46Up7
         Jf3RTgh1ddwgbwU4y71zbLXsVfjmjvPy0PrvWqpDE2tfRWHUn4HVVHpRrl/ZG2SecQkY
         UChrD6FhquwOn60WC6xBh5P2/XDlcD194tS0/VnfxL5trQmjPcZUBLytGoojPNc1ofTQ
         2vfUiq0t3WEB1gVSGXEfBAb3kOp0y8Wc6L97z2Y4ccv0rbeu1z0DZoWVceDdfifZlgs7
         DIquZuG5G0xcjMSTcQ85hpwFfLt2VAKWEsBF1o9sA7CfU4Xc2zPhW6WmtWN+ZGQ/pkTB
         Qpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708570604; x=1709175404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pn7jhUvFrsr4hsFrRSTNI7io+CHMGvymnbNX2sEJ1l8=;
        b=TV254WTn7D+2oXU3TftIOg0+q0wA4Wwu/zuOGGciUTfHoL7w1tZwGCeqMx0KRmyMm0
         6VyUAkRNn5dg28ptH4hZwrxIytGguHDbsb+AQo6CQs5/1e5VaQsL2i6Kx2X/GFzShnI0
         7vkb1v2yXpDD3VyoHBQ8l6dXAHkHwUX1Ff+pYEJq3lgTOuEf9jHaH1jAHeoUHQaCsJwk
         j48C5RbBW9SWTzX11/nCMVu3gg11uKeddPUeZ77RK1SILqV1vMLOiez2QETgiIXrIgQV
         TsgnNToQUVfM/5OI8TO0aAKszf9CFzC54fQl1WGUe6PXdlBNc9z7NFTkmXy7+FU4oSHI
         DAzw==
X-Gm-Message-State: AOJu0YxPXEeg4NBUQdhRuN0+aEijgEo0sNKFIakt4ecnaytlrAU0pC7D
	Tzyp0NuEsnGMLa+/Z1P84nutrR7TE4XCzrRJMjVVqbf49PcDKqRQLkT5mF1lmW0=
X-Google-Smtp-Source: AGHT+IFzmP5+X8d1fkZN1wWrcZDpeIEDy1oEHwLActOXk11ati0G+i9g0tZRSD5ycpa27t+SddVtgw==
X-Received: by 2002:a17:902:f609:b0:1dc:3ab7:cc68 with SMTP id n9-20020a170902f60900b001dc3ab7cc68mr3473876plg.21.1708570604680;
        Wed, 21 Feb 2024 18:56:44 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902f28c00b001dba98889a3sm8797521plc.71.2024.02.21.18.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 18:56:44 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 21 Feb 2024 18:55:49 -0800
Subject: [PATCH v9 1/2] lib: checksum: Fix type casting in checksum kunits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-fix_sparse_errors_checksum_tests-v9-1-bff4d73ab9d1@rivosinc.com>
References: <20240221-fix_sparse_errors_checksum_tests-v9-0-bff4d73ab9d1@rivosinc.com>
In-Reply-To: <20240221-fix_sparse_errors_checksum_tests-v9-0-bff4d73ab9d1@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 Parisc List <linux-parisc@vger.kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708570602; l=2493;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=qIxvOuUQdTE/c11+6K8jm43GYNvTh+hoxAg5skAHgOQ=;
 b=qyGWK/Z1PlzRHyNHABo1Hlefxyi9yuqzzUQU2A6vNOseCkhQF7BjH+d3oAi8E4w4A0GqbAB/N
 hPysmTZwHfCBSH3nyJ1/cIAjCawdsElpAFDxqTTz0EO+YPyjLuNRmL/
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The checksum functions use the types __wsum and __sum16. These need to
be explicitly casted to, because will cause sparse errors otherwise.

Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401200106.PMTn6g56-lkp@intel.com/
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
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
2.34.1


