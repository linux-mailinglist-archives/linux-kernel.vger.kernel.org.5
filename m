Return-Path: <linux-kernel+bounces-66000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E973E855511
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFA1286BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F0D141985;
	Wed, 14 Feb 2024 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nm7swkuF"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9536E13F003
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947009; cv=none; b=u3HSDb5TOffrLxmtyjr2DmckkbYygEO1Fv7d2A+euTurwpE7Y6/1vYuRMvFevgFxwN+37gxWd9+SNndGcSxCO4HJ1CQCxlfcRUTrW814/ycwXhfkJwVt+iaskTXyhILK/dMSEk13k0VckMGu8iiGzifnBZUPNJC+IiNfGYL3lnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947009; c=relaxed/simple;
	bh=NNXekux/WHD+IAyfhhTztt1QcH5aqOmbij+qdO9nKoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VHmMfUEuPXOf/01dPuOTJQ1ch5Q+X1Cw+CyYUdnMJHTilUig5kD8VLp+cADw32diVFFVjP0BIJlTXAfY0NL9IlourjcRKdrYIiVDv4OBN389GkjXDFH11SuoezYa1iLPumkP25u1UYIIpCWOdR7/EoRKlIfJ7PmSO+pn+0pjUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nm7swkuF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d8aadc624dso1791075ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707947007; x=1708551807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mi0RSxbVzPWILoZDCU58Qlo5ijNXbWrWoWQ1rQw2zOw=;
        b=nm7swkuF1UsKWdAx6Bba6gPCMoBEsN+Mrhh38dneKPpRtuErjIRf3YrvxgoBh0oTJ+
         s/IajnWcQxwLjCHxYD59gxkWvOicl4KtFSb7b7GQi7BmfTHiifVDP3dtzDhHAUVHXIvY
         Rqvi0xJrKJr8q9VxRkvAY0CpNdxdkK7tEyP2lkFYFy6xEJ58u6aK2i0AlXb9vXnbgwdZ
         7Ou4/VuDMrWikredjXzOeBQewhLBk5QKiUrVNQ3PxCzXqG4ce3C03Rm5mW92Hkly7VGK
         zrfXuBVWGqv1Knx8HAvjC30xhy2LXajTPGYXyPIoa32lRJPShgRxnDPdVZdA9G57xjSX
         7kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707947007; x=1708551807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi0RSxbVzPWILoZDCU58Qlo5ijNXbWrWoWQ1rQw2zOw=;
        b=WrZzmh7/FwJitkZF0RfymEm8drZnAq/UPvGivlgHcGs1vMJ2Jw/58s+oIvfxIFDVKR
         ye5TXLKzsp+p+jemyanDvM8Ti3Nj2UKQFrqzGKxUM2uk3t+E2XLpdbhTdRTSW1s03Tj1
         wOasoJRmnRfBmKbs7WXu1gbMcxiaus5q7E710QgJwDsKlQahPb4qBDJb+HXZVfZBA2Ie
         GgSF8JIocrFvpsZgnGTzmQHTsZntoh+cJja3K0PquC8EuE6ISFrk4gwyF5FON6Se3GX0
         2C+87PBOmUzbbyD8x+iB9ZF60R1L2oG+wC+LwntlJ1NMjbypHsq3nuhdT4FkM3hF4Ins
         y17w==
X-Gm-Message-State: AOJu0YyR4dN3NSv/Ty11mSkPn3MZeijAdUGr1/HUgrJ8qcRJb/GDzwfu
	l/1pwHXHPDtbnYCJFYIXIyuUJskUDerf15a2T3UpOkynm2W9FIxUmXrM06hxyPNBblRkr3ygMqc
	C
X-Google-Smtp-Source: AGHT+IHYbckt4mHrejPnMy+rO3aLQDD5Q6x8NHe1cJnup+h7mG0AHanX7BqtWCyfe2mVcOvA+MsFGQ==
X-Received: by 2002:a17:902:8216:b0:1d9:a527:608f with SMTP id x22-20020a170902821600b001d9a527608fmr3512091pln.64.1707947007120;
        Wed, 14 Feb 2024 13:43:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVo12LYd6ieKErNtgxTOLGkgHw0QC7rZe1zK0oXsMePJhakxO4ZyymTg5yu3EDLatU58Kh/0uXFaimx/rcO8kmW/Y3/V5UReHIDJqZ07QSHfSJ84oqWOU7KDDvXWaLvz15UdM/2rR2hTzGHC48qoRZYEmt5njsyGQngVFLm4iNT4oIjLzRjE5EHsNQF1TxuhieQZ0IMbZ3lHbbQ0JhLk2afaW0+BXBqGSdnFZBSdt3uNoQVYDsrAjyMw8HLizXqMnes0ebqHYKzf+vReIZpOxlDsJxoQay5t0/suGZY0UfhJvKn3Sa49xOSNvXE8QvNH94YXtYdciWDs6QdNCZTZfvuj+iokhoE7ag=
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902e01100b001db6739d337sm1085919plo.163.2024.02.14.13.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:43:26 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 14 Feb 2024 13:41:02 -0800
Subject: [PATCH v8 1/2] lib: checksum: Fix type casting in checksum kunits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-fix_sparse_errors_checksum_tests-v8-1-36b60e673593@rivosinc.com>
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
In-Reply-To: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 Parisc List <linux-parisc@vger.kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707947004; l=2493;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=NNXekux/WHD+IAyfhhTztt1QcH5aqOmbij+qdO9nKoo=;
 b=gR/M6E/C4g3VNUt1MpGkVNoeJgadk6hnf40hfs7jMtK5fzMzPe09JAiabGlB5dMVNYOw1HDpu
 eKlEAfgJsJ1Al2bzCRmRNHUD6+ETTUWYyhjiudF1OT1jRZiefDGsbn+
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
2.43.0


