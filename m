Return-Path: <linux-kernel+bounces-71613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C89985A7CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD901C22BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137A3A8F4;
	Mon, 19 Feb 2024 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0huWCQg3"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D42E832
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357761; cv=none; b=ZU4al4526NuS4rzTruggGxfi706jvVjQ7pVMenarcAiyiaXbHGHujvo0F7Tgt8MyBcGhkViQV1uW5ZWBbtYwmTX9lS6ykvik83jn9zKyUuJi9MvC+sgm9RiMASfuUxrBGsbHD3g8CwrDTECEFBtM0GNsvtE6z5+pkmo89XvIsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357761; c=relaxed/simple;
	bh=ZwHY7vGldHgliLrYajuSNrjl8dkhc+l00GhDGeXacpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OJCrXpm5uwIoRuhJ4IL9W0sa22JBC4H74d7m4QnzmQ0AaAsHmsy/Mfh5t03yuVXse+fi5a/eyC3ojiLdMw7eRqiD/kCePe8XJwQmtNScyJ3+WnEtHIH54m8g3uBHD0D65nHcqk2dChWPoQ4dMW5crCXa9gkjZT7wKhnMFHurAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0huWCQg3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e33db9118cso278016b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708357758; x=1708962558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CDVX+aQQf3UCj4psWuuhlbCqwqS7vSYaBRqyqThSZrc=;
        b=0huWCQg3kTR6VujbrNMdjgFsmkAEGUl/PuM7kflv6vVa8kbAW9zOEvqi+MYryOs5ra
         YnvkS33R2oSVF0ri5Dbr0Vf5bbeudQc1IUhQW778oDHWoDiksaH7aPx9ynCkuA+aILGi
         4hnSN4zPilP0R+RNcYcBXsovAhWEGJi2hsnrEJYqBDiy4ZvlaUjWrwEHkVK8enFfObYc
         YZo8K4SoNQHuKeRt/9SYATh4/vv1bgUUr/BFmYuMp7jt9NenHpieu0ZcD+SSKGhzRevQ
         4x1qIgVPRvtqY+cvB0ISVMz7ibM1OZu4wwXlRsnIOYb5NmxxO7986+bGr+WZPK4mg28g
         rYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708357758; x=1708962558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDVX+aQQf3UCj4psWuuhlbCqwqS7vSYaBRqyqThSZrc=;
        b=dSsHNvLvF63xbiRcxvHR0up+7vB76tU99fozi+ZkhUfUHbRyf+g55wX+sd0yV21viE
         b5JFPgZfA8u/sIsi4kTuuKFXami5y4p5joS9VVjjUt8Hd0+cJCY2Wp1swDH7Qj8zR7aK
         eIxZOJzSIS/fEeom+BJFb9ZL+1wlqWG6KJIoE4ne7FJCEN0qCSwWYOYFsQGnlxOTWuTH
         kOwMTCYzXhCQ9zgov5vjeBc4om+s/gRnyuFwbvTML6/8vGc+g6dOxXE7+vDfzCueth5p
         /xdEyqvWZTPSXgjXOSltr3vrhwN213IVAGtLIDCENgNvcF7nW9zFQo0d8mJq26gkowhi
         8rTA==
X-Forwarded-Encrypted: i=1; AJvYcCUEgtMmnujSgVMLJjnRBmi0WDMFe+9FBz/Xvr1j8lgX5ZvneT8h5CBNnEUEfldcW08eLVtHF7hvsV/71l8f8iRtCE6PfUn/PuEyxekM
X-Gm-Message-State: AOJu0YzI/twTyeHYIfvUJBC9kYTUvTi2zoVUJnZdbPySYldJxxY2hrP5
	4TuDRrRHyouTFM6Rv9YB2Iz/VsL62ztPUg6MNp+u5GD7ALMnrY1XjD7w3XbkYiw=
X-Google-Smtp-Source: AGHT+IEcyZCHhd6HIFFkqbFH2GwEOuyTsp9nTeseU6jdpsxfQQbNhEYUiWvejav6rxmgpRl71P7gWA==
X-Received: by 2002:a05:6a21:789d:b0:1a0:a6bb:d0d0 with SMTP id bf29-20020a056a21789d00b001a0a6bbd0d0mr3708851pzc.1.1708357758289;
        Mon, 19 Feb 2024 07:49:18 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:8501:8c81:d5c:f8d2])
        by smtp.gmail.com with ESMTPSA id lo10-20020a056a003d0a00b006e0f4a183c8sm4990773pfb.104.2024.02.19.07.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 07:49:17 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Robbin Ehn <rehn@rivosinc.com>
Subject: [PATCH] riscv: hwprobe: export Zihintpause ISA extension
Date: Mon, 19 Feb 2024 16:49:04 +0100
Message-ID: <20240219154905.528301-1-cleger@rivosinc.com>
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

---
 Documentation/arch/riscv/hwprobe.rst  | 4 ++++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index b2bcc9eed9aa..0012c8433613 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -188,6 +188,10 @@ The following keys are defined:
        manual starting from commit 95cf1f9 ("Add changes requested by Ved
        during signoff")
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTPAUSE`: The Zihintpause extension is
+       supported as defined in the RISC-V ISA manual starting from commit commit
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


