Return-Path: <linux-kernel+bounces-47709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086984518D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053071F2BD22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105111586FA;
	Thu,  1 Feb 2024 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eQ8GtO1n"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BFC634FF
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769648; cv=none; b=gXeVMRyQnqkoIeu4f81o1HUCAlGTIyCaMWAc5gWU2BFNGcCaVqzY7k2S03SY5MNkl6teAhVZVzg5LeKA56G/Ebk9jYnnJ4Hz0tWdHvKMXnPkRrQnS0kc9U2rdrRiXlLYwIxe3CQFXNgrECAN32Z+UhvuH/qBWUM3tih+7cv5swk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769648; c=relaxed/simple;
	bh=+3+H4L8FL4dzjFZ4FqWhB/vlMrVeJ1UYdAoYv089bgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cq7g1qaiGbng1BvnCI2IRo1wtff//+1lJO+cw8K58Nnl0VL9nQYVvkLK5awc/zkIP22JV4Xf4MrHjlRdxYg4Gt+aa7SQspyiM+tEoaJRhauzjWDK5Z77y9SgMiCRaWtZJ3yPlw5XmGWuFw3941elIJQEENdIjHEmL/2LMjVF+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eQ8GtO1n; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ddce722576so415360b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706769646; x=1707374446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIXyaPpVLFUfFDNyJy3KWQ2yUOHOdYcvoDWbSmBuabE=;
        b=eQ8GtO1nN/BIvXhesKkdlllyPvPviDd34/+lwZJaqWdDblOw5LsFaWlv58z9wrJ++X
         XR+DkmihMCCiffE3IDzqHbxkpsnOyqEGimQnPiZW9hJq3YgalN3elHB+ODfBiERCHp5g
         M4WFg5f81dWVPVPIGBx9nOV6RIR8B7SeG4Ssz1Y6XiqDuD69BFzVxyadgAoVgZWbUjsL
         Wroezf6bm8Cxm7fmZMg41RS+6P3x1vsvRUJxudiMQt81TIMymLDufz2hXlxa9TDmujdT
         n43jerDw5Su9yyqnrbAFVf1+dyZl03RbIWgdXbsYi8BkY5UBhLthwNnFCdnB7MgDM7Hn
         jUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706769646; x=1707374446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIXyaPpVLFUfFDNyJy3KWQ2yUOHOdYcvoDWbSmBuabE=;
        b=LMTqQhOxNFb1NCIXF0jDBtVRztc304azbspTaewP9xJWpTTkPnfhJ2k6j0f6HJloIO
         LpdrLkFPjmV+7PFeHj+8Tz65TpeNrWhLcdlI5zuxgONjLwNum+YWvvEKktkBvfxf97Qw
         Ab+18Z1Fd5HsGjFHswfnq+IIt8U/HPhvNvIMXHUG0Vk/RBmxygu97StIvb1ZstsySUDH
         8F15/2hFXwTmjBvTrbLvlnPcp3cESD3m/UDZEjyB1ww5wfluxvElluIhv3/rUChnn/yd
         q6IrW3F/G4gBonUzXnUdLlEysjg8oVbRbFnYPiQYxtmGYRjdnlCI4matMH5HUq0UgvXa
         VJFA==
X-Gm-Message-State: AOJu0YxkyCHZ2TNkXoHAB/SQNKWjnHW6w6W5Qn/J7bNWLH1/p7hcC8D+
	8fFmSBgmRpnrhdd4wFhC2QGiWaj8hDqwqwCOw9NnUmObDh6Fd97bdI1HaDqdf2A=
X-Google-Smtp-Source: AGHT+IH0Ilf+FhRJHFE95RV4Rfrl8XpJK4Lt8W5UOLth2X1zaJdGQWNQfaO0qCMIHLCPfQ1gwt1ufA==
X-Received: by 2002:a05:6a00:2e8d:b0:6dd:e398:2a84 with SMTP id fd13-20020a056a002e8d00b006dde3982a84mr5625436pfb.7.1706769645899;
        Wed, 31 Jan 2024 22:40:45 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id y9-20020aa79e09000000b006ddc7af02c1sm10925764pfq.9.2024.01.31.22.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:40:45 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 31 Jan 2024 22:40:22 -0800
Subject: [PATCH 1/2] riscv: lib: Introduce has_fast_misaligned_access
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-disable_misaligned_probe_config-v1-1-98d155e9cda8@rivosinc.com>
References: <20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com>
In-Reply-To: <20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706769643; l=1864;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=+3+H4L8FL4dzjFZ4FqWhB/vlMrVeJ1UYdAoYv089bgM=;
 b=bRvK7aKUqvows9fD9AnnFe3X/BPdMMpRQM2UWcIw7htlQ7Bn9ObEUpctD0UR2OtlMn1rEBT20
 SD8K04u+x6tCVTERMuXek6EDidfS6/EYlv21nNMSndqs1QmpjODeU5J
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Create has_fast_misaligned_access to avoid needing to explicitly check
the fast_misaligned_access_speed_key static key.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 6 ++++++
 arch/riscv/lib/csum.c               | 5 +----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 5a626ed2c47a..dfdcca229174 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -28,7 +28,9 @@ struct riscv_isainfo {
 
 DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 DECLARE_PER_CPU(long, misaligned_access_speed);
+#endif
 
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
@@ -137,4 +139,8 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 
 DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
 
+static __always_inline bool has_fast_misaligned_accesses(void)
+{
+	return static_branch_likely(&fast_misaligned_access_speed_key);
+}
 #endif
diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index af3df5274ccb..399fa09bf4cb 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -318,10 +318,7 @@ unsigned int do_csum(const unsigned char *buff, int len)
 	 * branches. The largest chunk of overlap was delegated into the
 	 * do_csum_common function.
 	 */
-	if (static_branch_likely(&fast_misaligned_access_speed_key))
-		return do_csum_no_alignment(buff, len);
-
-	if (((unsigned long)buff & OFFSET_MASK) == 0)
+	if (has_fast_misaligned_accesses() || (((unsigned long)buff & OFFSET_MASK) == 0b101))
 		return do_csum_no_alignment(buff, len);
 
 	return do_csum_with_alignment(buff, len);

-- 
2.43.0


