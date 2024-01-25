Return-Path: <linux-kernel+bounces-37953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01EB83B8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45F21C236A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEB212E72;
	Thu, 25 Jan 2024 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QzrOpA1d"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044512B9F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706157471; cv=none; b=ARrWjwKGkmN9mECk4lkOaTczyIxg8p6PhH1z9DFqSSUgFi9dmVg4qy0UO1w3IhUCmecKM9Gjxdl7ukwKzezOmeR1ri++fYbevUfVq9tZCyChexHCRENPlL4Ry5cO8DaQq8T4RVf7y0IUcqYKBGOHKxe03vUauPyBY4iflt5YNnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706157471; c=relaxed/simple;
	bh=Vu2zJU6rs7aIVFF/VzEdsxoph9/5pkBmQUthu2jacwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kAbIfR/qr73FLlcpGbk1GFiPiof7QazTHH7k1wZT9EhNZRjvlfLCYKW0ud0YVYJam9wxY5Jp4ToGMFgp/t5RQR8/yBCMRMpEEFvP/g2q5XjJLRMy1PqManU5fzal8S6OEhXk1VxNXbDAn5T6bskJOPIJ16EcYvT3vCn/yM/EPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QzrOpA1d; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bdb42da0e0so3186937b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706157469; x=1706762269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owm8njJqNk7VGFfQ1/2qrIodEhvlbTpdS+uPvTUB7yg=;
        b=QzrOpA1d0gbkfyYR8v2TI5ZmqOlVjE+onXqiTN7fbQgxe75oKA660Ke8wKOXRXZlQn
         Z7fCGjax3XH21OHudizz/Vyy7UX/NDfC0DoH6aJ57OZWTmvS6toFTcitP3ExoAiPQf15
         f081UONjcHVEuDZuaTflcl3axYsHBaUQut4HfgjG4GFy7W8V+FoSXoiEvuEIVpjgahyu
         X0fXV41N12ICkPpJsdCe7xb8HxCy0StDwBhxOcn4ogfZsuf6uUQv/F5TPuCbgHkRClG+
         d6NvD5r5H002QM31k5ssC47SPQAw32tk5PvnKbEXh9W9u+TNejwijoWUTdlc9BngxOR7
         imEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706157469; x=1706762269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owm8njJqNk7VGFfQ1/2qrIodEhvlbTpdS+uPvTUB7yg=;
        b=K0hAwwilQVBPKwHUf0A7OX2sMtisw2xFf3C3+Zo22FIH0n9dqMUS55567s3SStLMsK
         odq1IXu0nU9XqI33IWDUSaVHjsuibaoV6sNAHAih8oG/hXyd4keRqoZS1mv3YBslDFF3
         gGGB5MH9g+CewC0YrXr4eRkhYLoAx3eOiYz4XvG5wEBL14xE4pYPf5bWa3VNE6ikFbZr
         KR8yWN7qzVGUoHx55sx3D+bDJevYG0qUVxLoDbn6BOT0IQqWwqnejAHiMS/dDmNXQeIb
         DHiXavbqXeF29d5eB/Qz3Byqp2IRYtqb5XDJ6A0LR1AYl4PDlawUDNtUfUkdtYFQm9NC
         uowg==
X-Gm-Message-State: AOJu0Yz/IxQaPtnY5Cj3dd303DJWw97eS3u5BegxHQgjHBag1iq9/stO
	BAJymTgMYxyxFwkjhhZ3oAbzk2zWEkYLrR+5Fv0eMuR6C3nkMdJkG7mOsbba98Q=
X-Google-Smtp-Source: AGHT+IEwY4cA2M0qOmW7rK0WBHlbjAXatDRaEnxX4zaKlWlyM+DLjfIxGXEVQSYcOFFEikcEwC1MXg==
X-Received: by 2002:a05:6808:6197:b0:3bd:5306:da9d with SMTP id dn23-20020a056808619700b003bd5306da9dmr317257oib.65.1706157468969;
        Wed, 24 Jan 2024 20:37:48 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n2-20020a056a000d4200b006ddce8e110bsm355185pfv.128.2024.01.24.20.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 20:37:48 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jan 2024 20:37:24 -0800
Subject: [PATCH v4 1/2] lib: checksum: Fix type casting in checksum kunits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-fix_sparse_errors_checksum_tests-v4-1-bc2b8d23a35c@rivosinc.com>
References: <20240124-fix_sparse_errors_checksum_tests-v4-0-bc2b8d23a35c@rivosinc.com>
In-Reply-To: <20240124-fix_sparse_errors_checksum_tests-v4-0-bc2b8d23a35c@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706157467; l=2402;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=Vu2zJU6rs7aIVFF/VzEdsxoph9/5pkBmQUthu2jacwA=;
 b=Dehz5fd/Wt7zU3rlmnDtMdfMxmhEbMdNBvUPzxN5R2t1UGYoc8ZK7fKjBypS3cJs/PIAwpXuX
 nUaKgq1POzWAgpfjSiLBTgqIYIYxCZToTfmbCwbtMDRhmDnehCvYdid
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
2.34.1


