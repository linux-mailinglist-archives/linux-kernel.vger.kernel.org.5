Return-Path: <linux-kernel+bounces-36225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC27839DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A75287C74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360641FB9;
	Wed, 24 Jan 2024 00:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sYiMiits"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CDB17CF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706056729; cv=none; b=Z0ytEhmOJTRWt1RHg5+RshIE7j0v9RJZY9Ldl7N7MUP6bILsGdoFGED/COjv9luFIZFco6AVVF0cXXhuqsbjEkIYMj8GqNKVCSi4w5RzT8zeMGRZzcm9Jy/TOlIEc41M7dwaaA80UBI/H2LrBXPNQEojFNi1TAbqcTn9ZArcEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706056729; c=relaxed/simple;
	bh=vtaithEKdlnR6rNf+kxSTk35iDBBx0caxMmfVcvyUEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=doEDQk2OLvqYAEHqV29XT0nXc/5KlSE4aLNTN7zfRyMjyHb5L4ypRSIcWgwMwtElMLHML7Ta4nlAgTR48vXr4s+Xr+W9PRQjjPmyl5mObSeZhcPSZroqOWrtl5lPFJGnAoplJbguMKski/Npap13PpdcyJt57eIXolY4TsWM/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sYiMiits; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d6fbaaec91so40845645ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706056727; x=1706661527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ynZXq3hbnTIt8pJLL68IBYX2Qlu6g0sPaImPdjw3z4=;
        b=sYiMiitsUtzIv++fA++6jxc0ZNzKheFJFHPX+ALprbb3u6BtQDF/47pacsqZq2Mmdc
         C/IBPHNljK/jDyvxBcs2LExfvFTjHgqBbq/S6kUKVee569obhFQpE/hHvsc28cE11HRO
         l1mXLuQEQY8/956EBl0o+u6VTeHcHoVMm7Sd01q2meMh8KaQxZZcMdNSLM4akzZvOMVx
         uqYyy6VyRyXx00Sp8SL/kePe0iwk3dMhFIbsTBVfTLYbR9dDiIfMLsPdJq4Bpko9n4oQ
         8p00XeajtDisz5fqM+gyJGyxOLZ0w7eOu17yM36ZGmyD9X6JoaHJkBsQxyN+80THbPsA
         EmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706056727; x=1706661527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ynZXq3hbnTIt8pJLL68IBYX2Qlu6g0sPaImPdjw3z4=;
        b=kyU7zRxryJEn+aIbPaEYXPrrvpHqYOvb5U30wHOrPkCyMoFUjmXQ835TG+8Oyd4XTM
         ui1wGfkMg+g419/mINwIw+QALq8TZgnrjYlNbQh3cTIGHwv5NsY/l+bR6EpTjnXVEhYo
         jGrqIaxSVHVQ1XXFb0pV56bR2keEA5U44WjeHH5LT24HBsOXIzC+4QRs+pJRMo5afixJ
         dAksqskw1c4Udo9FJPdjM5eu1OtZwYBpX7GMB2poDGBZaz8MetHRk/xWPLCtAPp2uWr8
         ppspobowMb2FZhR8Nvmbm4d3EzokYazspfdzwR27RIW1EEMHDhrkMrak3Bw9TiRSw/hm
         +Kyg==
X-Gm-Message-State: AOJu0YyK51/lAWmPgXlx0Jn6XGdjBggUEIZLXaB4oPrx85vCQm7rPrjt
	J+bWIfj9+lbUPDeb/Lx6ItoiDDf/9rFKfDz/r1EN/MYFc7Rk7Eq6BTP+U+UrGnQ=
X-Google-Smtp-Source: AGHT+IG4FTPgOY+7pijx/l7wOMI0Hg9IEAGR48MqVsQWkpHYrYrJ8PdlSwIgh9F5E8WbMC7gnIVjVQ==
X-Received: by 2002:a17:902:e88e:b0:1d5:e5b9:19c5 with SMTP id w14-20020a170902e88e00b001d5e5b919c5mr68404plg.1.1706056727140;
        Tue, 23 Jan 2024 16:38:47 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id bi3-20020a170902bf0300b001d6fe15b563sm9384275plb.157.2024.01.23.16.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 16:38:46 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 23 Jan 2024 16:38:42 -0800
Subject: [PATCH v3 1/2] lib: checksum: Fix type casting in checksum kunits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-fix_sparse_errors_checksum_tests-v3-1-efecc7f94297@rivosinc.com>
References: <20240123-fix_sparse_errors_checksum_tests-v3-0-efecc7f94297@rivosinc.com>
In-Reply-To: <20240123-fix_sparse_errors_checksum_tests-v3-0-efecc7f94297@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706056725; l=2402;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=vtaithEKdlnR6rNf+kxSTk35iDBBx0caxMmfVcvyUEU=;
 b=+OFFsVkeKTXHR3g8R7WKXY27hVLPEKztOS48oaTY2+wDxMVOXkIwd4K4iwwLNMg0jrZgcEX2m
 IbTAQUjhl51BWvW2vEXF9pgczeUyGI6tXDU/cqbigjWHwYCi80qeXuM
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The checksum functions use the types __wsum and __sum16. These need to
be explicitly casted to.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
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


