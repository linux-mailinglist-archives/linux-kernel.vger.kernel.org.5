Return-Path: <linux-kernel+bounces-31297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F69A832C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429911C23706
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B45954668;
	Fri, 19 Jan 2024 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="N937FwuA"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9BB1373
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676622; cv=none; b=KpM8RmHceG0h1bSEw6xXrrtUHWjcvuD/mkQWELO1G1T0EqszGUnqmfbMcBM2T9wXB659o10C4yhQFbxZzcYZLm6ZNEZHB8ZvYFfCP/wDoWYk/6uJUqhOsn+PSNl698TGfHf3AAkDJsDW3ExJ+XOKictPoloJh33UVCcECJVYTS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676622; c=relaxed/simple;
	bh=WThewpXt/M7/HyWVe33yqIVrMcMdh8fZCrQsnJP/J0U=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=UHK6O4ApAz6aah07O0hdT/lI3PUK76T/P2mbMfz2PHBnJfeK0cuHAfdYFDkIi1Y4bbcU1vN9kdyhzN41v6hLVILNUA4Fy1l1Yi2KKQ6pAeNuPUqNUgc5ITUyieB7pW4FAXaRVq9nwuj7hPZ1IQqGHBAsMytk8ndV93oswJIuGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=N937FwuA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d99980b2e0so895698b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705676620; x=1706281420; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=0OkN04rYJbcV5yI+1DylExB1sHf2862fFRZ4+hBrCQg=;
        b=N937FwuAxKkX8EYhAlqq1ZBzryT6ydlbtB/20uNW4jbEKbcZjexmuJoTfHJZuvydw+
         nxWQNKF/zx9Z/Mn84r17jM1A0U9/G9+CfyhhauJCUMu5kxPijFaUo4FJ6cIDrXxaTCRX
         2VGiF2DliuahFMUVRTZzRZNizt20FD3T1xLqiabYjT/cykgsWjfXBfrfXj2k48GX78lR
         VtxcXP4V5ef90BjULFASiZcQMgzJeJdKJvm+GQlInTUI93FkUFlPCDHghwqAcVuNE5fW
         LL+3qi0cl0tuSqe2IBi5ZiaquC9bNdFUZHFvlOUf71hbQlczpYmabgmWi30noYVjYS6X
         oxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705676620; x=1706281420;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OkN04rYJbcV5yI+1DylExB1sHf2862fFRZ4+hBrCQg=;
        b=KM5omW8sx0AtsYqPFP1vnxB4MPHpvQjLtFM3lhgnNrQ3NxvH351M7HzuNnRZJ4pBc6
         ta823t5hxnY8T2isYDAjbpTG3SOG1bPoaG1ipx6foNkvt/u/HyRw3cFj6wwcFw2lMB11
         1QC8kQ53DZZjCpbEfpXCMkQARpWJ2XbwCdgLMuURo7F8PjVOJn7aV6BX32qBPj4BmB2v
         9QfRbJe0zRY18XCHbsjn2ATKa2WQmbPYsdx4NLq30q4kNyE0BQidcSADj8npprfJbD8m
         NvBbcW2I6dr6fWXz0qeCiApTn4kcU9T0nXjMpX+4mtfz2jmr6YduEguYynSo8ZdcsJ0E
         6U5g==
X-Gm-Message-State: AOJu0YyhHLbA6lMGJft9Ow5mRGXe6HA5fGYyygkMXaEnJY+x1ZvgWByl
	dLPG4rwnf6vGwvJvtypd+rJVdsGh9kl4kPaML4X9M6RbuQeRgAOb8MSmEEXmWqE=
X-Google-Smtp-Source: AGHT+IHU8Y7GKeyuuZYXeP9FKdXHUATlkC+PPQYbKGR1PAMKpM6ElwORYAvxQJgd6B6GEHijfENnAQ==
X-Received: by 2002:a05:6a20:2d0f:b0:19a:3a07:1f2d with SMTP id g15-20020a056a202d0f00b0019a3a071f2dmr3458624pzl.44.1705676620338;
        Fri, 19 Jan 2024 07:03:40 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d7-20020aa78147000000b006dbc6a5daa5sm750913pfn.154.2024.01.19.07.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 07:03:39 -0800 (PST)
Subject: [PATCH] lib: checksum: Fix build with CONFIG_NET=n
Date: Fri, 19 Jan 2024 06:56:01 -0800
Message-ID: <20240119145600.3093-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Palmer Dabbelt <palmer@rivosinc.com>, davem@davemloft.net,
  goldstein.w.n@gmail.com, dave.hansen@linux.intel.com, christophe.leroy@csgroup.eu, nathan@kernel.org,
  ndesaulniers@google.com, lrh2000@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>, masahiroy@kernel.org,
  linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To: charlie@rivosinc.com

From: Palmer Dabbelt <palmer@rivosinc.com>

The generic ipv6 checksums are only defined with CONFIG_NET=y, so gate
the test as well.

Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401192143.jLdjbIy3-lkp@intel.com/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
That Fixes tag is against a PR I just sent up to Linus [1], sorry for
missing this but it came in right when I was sending out the PR.

1: https://lore.kernel.org/linux-riscv/mhng-690cf774-fd28-4d25-be9f-69e19fb84d5c@palmer-ri-x1c9/T/#u
---
 lib/checksum_kunit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index af3e5ca4e170..225bb7701460 100644
--- a/lib/checksum_kunit.c
+++ b/lib/checksum_kunit.c
@@ -593,6 +593,7 @@ static void test_ip_fast_csum(struct kunit *test)
 
 static void test_csum_ipv6_magic(struct kunit *test)
 {
+#if defined(CONFIG_NET)
 	const struct in6_addr *saddr;
 	const struct in6_addr *daddr;
 	unsigned int len;
@@ -616,6 +617,7 @@ static void test_csum_ipv6_magic(struct kunit *test)
 		CHECK_EQ(expected_csum_ipv6_magic[i],
 			 csum_ipv6_magic(saddr, daddr, len, proto, csum));
 	}
+#endif /* !CONFIG_NET */
 }
 
 static struct kunit_case __refdata checksum_test_cases[] = {
-- 
2.43.0


