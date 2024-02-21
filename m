Return-Path: <linux-kernel+bounces-74307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6110D85D299
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161BD1F252FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ED63C499;
	Wed, 21 Feb 2024 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UhuKLhBG"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E073C487
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504275; cv=none; b=sQdBwdu6VYbkKKFlWJkYnqlF98H8ys0wp2++0g087qOn38FdpCCCBpLfGquQlP2TnrBS2a22n360xI7Xr1zAi/Z1EaD+HjulkEtf1/OOH4X6CgXz3WXVcf9vofdj5b8UriKqor18XTTPx9Izyqnemw7U+2m0Xy3o6DPLjYolJi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504275; c=relaxed/simple;
	bh=vqbvLAUaPJ4WgRR+teh0/Ah4uMsjuy4TXqtUh9j5+sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N+ak/Toa3sDfcq12tziXjMWn6s8L+vfwkah5yuzN2n2GY9wUSAr4204KSiMt7W1O6ueBf05FgsBAfhIK1Fxin8Z0QVeQfdZumy8CCSeimO6LrA3OoAKyyCD7EViSdekQ8S6/h0gW4tZ2ke42Fhic7inK7UEzOToS9ic9MZ9ynoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UhuKLhBG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ad9ec3ec2so1002614f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708504272; x=1709109072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DfmgtPB5KtCEWqqxteO1F8ctpQ9OvQULDo2fgyZ5GM=;
        b=UhuKLhBGQ/Rjv05yaNvR/EWKJMdH1Nkxmlfib/Ra8xN1twy6AVAleTXbmpfS53Au9u
         YMP9aK7I+Bgd4APrC+wdSgkpDtyEJbbe7+C9byJO+BLLa07VnCTfWgcYhFOmpjtYIemC
         fJfeMB6JY5xhSO5IW47UTmBB5huqKeBA3aLhMZZp+JcJrLNfid0DJNvJBJmPVICo2xsK
         T2i7pKBFAm5fPIoEDYChqST6pih7iho+L1U+HHtmjT25vbGGMKNPikws+oQgpX2CbIO2
         foHLlvJrk+FpTLW8yTRZtZTZvdSxqAO8QDWRgXFF194IbydtBLqKFj9+HoUPKY8Z+4ZZ
         LsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708504272; x=1709109072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DfmgtPB5KtCEWqqxteO1F8ctpQ9OvQULDo2fgyZ5GM=;
        b=exGJDjGfUka4cHHVkk6Ac3lObQ8WtkKnE6maebbCMUtE4GPxBBsaKCelEsJrZMoGGj
         4hKi50EF8sgmoN0tcj+yULtStkbplk1LAV+ED7nf48YIZi+u4VPTacbV8akZ7ifSiFC4
         JnFlSIUOw2BPENFj8lTF4LiuUY1C74T2J/pxQBaJ2s3krQ58FZMU829mMTLDvKEhtOIt
         PcRkHzAUWaL1RY+wI6jhdKDx4RFmMjgiPfUbWEmd5vBB+s0e7R67Z7iKvJyb+l4iwqyr
         rDgctLpRLscqz7oo30+kuRSXor4l0CXjSCcG4vNHbp6aJD7QO1MkFOV/iZeCQEzs78ar
         ZJ0w==
X-Forwarded-Encrypted: i=1; AJvYcCVlG5mHBJJMJAj7g/OzQBH0dCdagvgIoqdS4sNwfNgBOpNIuWafxszIY1j6lmAuBSOmzwpX+5waZClxlAtvv9hE9uZ0PdORdsZMEafh
X-Gm-Message-State: AOJu0YwzJ/N8pT/Yq6RNXkhD1W9xCdnql+XMghqSabxj8cZuF0DYtTc7
	HVEZiA8chfk8X5J4Iyl9Tj1zkbUe622oNzAGTNRp53bsaowY+m3ZXFzYUbmqVgM=
X-Google-Smtp-Source: AGHT+IFpQ25mW9HjQjzpg+0Xj68AfJWrOkwGecdVCbJfBfuwd15xExxElqbvXDzVs+szTRDW8c+wFw==
X-Received: by 2002:a05:600c:1ca8:b0:412:52a2:bd4e with SMTP id k40-20020a05600c1ca800b0041252a2bd4emr9522943wms.3.1708504272039;
        Wed, 21 Feb 2024 00:31:12 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:e1be:e214:b8ab:dbb2])
        by smtp.gmail.com with ESMTPSA id q4-20020adfab04000000b0033cf637eea2sm16210705wrc.29.2024.02.21.00.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 00:31:11 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Robbin Ehn <rehn@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v2] riscv: hwprobe: export Zihintpause ISA extension
Date: Wed, 21 Feb 2024 09:31:06 +0100
Message-ID: <20240221083108.1235311-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Export the Zihintpause ISA extension through hwprobe which allows using
"pause" instructions. Some userspace applications (OpenJDK for
instance) uses this to handle some locking back-off.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
v2:
 - Fix typo "commit commit"
 - Add Atish Reviewed-by:
 - Link to v1: https://lore.kernel.org/lkml/20240219154905.528301-1-cleger@rivosinc.com/
---
 Documentation/arch/riscv/hwprobe.rst  | 4 ++++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index b2bcc9eed9aa..204cd4433af5 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -188,6 +188,10 @@ The following keys are defined:
        manual starting from commit 95cf1f9 ("Add changes requested by Ved
        during signoff")
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTPAUSE`: The Zihintpause extension is
+       supported as defined in the RISC-V ISA manual starting from commit
+       d8ab5c78c207 ("Zihintpause is ratified").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 9f2a8e3ff204..31c570cbd1c5 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -59,6 +59,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
 #define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
 #define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
+#define		RISCV_HWPROBE_EXT_ZIHINTPAUSE	(1ULL << 36)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index a7c56b41efd2..1008d25880e1 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -111,6 +111,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZTSO);
 		EXT_KEY(ZACAS);
 		EXT_KEY(ZICOND);
+		EXT_KEY(ZIHINTPAUSE);
 
 		if (has_vector()) {
 			EXT_KEY(ZVBB);
-- 
2.43.0


