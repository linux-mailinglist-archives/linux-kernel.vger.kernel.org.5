Return-Path: <linux-kernel+bounces-7217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C76381A359
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A4D284D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0924645E;
	Wed, 20 Dec 2023 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RoYL/K3r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA74174F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d08be5fdbso10635415e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703087862; x=1703692662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxiI83AWHviDA1K2goPpANE3T3h3Nt6zkBhZOZxUOr0=;
        b=RoYL/K3rrFgCrlnZqqBBy1WQKpn8tuoOwu/RMvWGGtEL4YHm4vdP89F6O/X+8lvnp+
         kD/0IA7Wdx4CDGlQmKC0sIv261QA3AdEADsfkqCvFscesjtW3VxEeh/kZ9m0AHY1GzpJ
         s9No/LZfVBootxsNxi95SrEliVIGqaER+hK6y97eC7xDh7reraaEjnna3e0eXCzkEPfz
         Wzk5DbJ66vVDu9bYBan5EZ6F690HQ6+JlkzuKlPrvSvOBJYKa5iIGktBvFGnVFgT32eP
         gyqIibPfjuemvvJGzb0MiySImjHs8hUxPRdeRQ1H9Ohdyj24KxDpgVJTPoTyfIv0gV1t
         b8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703087862; x=1703692662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxiI83AWHviDA1K2goPpANE3T3h3Nt6zkBhZOZxUOr0=;
        b=C6/ww1brTjw2wH8F75HdspzzUxxiQtWn+3i1JMceZLjWyQlgIUR0i7ZVn3Yp7pmQTV
         LFuuLurreYcRPMney24EbiodJzQ1JgCZfRg3dbHdx14mGF6oyZyiyApvn9HyK7PW3fvR
         jA/ZqX72u9Y3633pJG+vkJtuexeGuIRy40GvGXAb5ywNCVCJ4w73y7/8qlURxy2vd6Uq
         Hq5tVWfZu0G8H7eNa13D++fYT4vO9A4dPwwh/tO6ISPZ/TDG96M1MBeSXGAAXe9wEMFI
         DfzJfPdQNuWDXkAeT+Z/dHPJVNF2XI4ZHM6r3yJTlDgCllUJduWTg4KJVb+Gd5rub+ZN
         QowQ==
X-Gm-Message-State: AOJu0YzG16QWRMoixMXrGjAYruXrpAQLNLE+Oc3HS8dkAfYYOxRJkHCu
	9RJPzf/0/ZRnI9LglvcOaMK/VA==
X-Google-Smtp-Source: AGHT+IFJbjR0PbYZ8f2Ct75zHWOpr+wt21lqG0IGhwGx4TEjDmQ++1Z336t5tRomVVKE9Pyr/5CpGA==
X-Received: by 2002:a05:600c:214c:b0:40d:35c9:7b86 with SMTP id v12-20020a05600c214c00b0040d35c97b86mr1498909wml.4.1703087861906;
        Wed, 20 Dec 2023 07:57:41 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:3eae:b70:f27f:7aa1])
        by smtp.gmail.com with ESMTPSA id h18-20020adffd52000000b003366af9d611sm7279693wrs.22.2023.12.20.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:57:41 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Robbin Ehn <rehn@rivosinc.com>,
	Gianluca Guida <gianluca@rivosinc.com>
Subject: [PATCH v2 2/6] riscv: hwprobe: export Ztso ISA extension
Date: Wed, 20 Dec 2023 16:57:18 +0100
Message-ID: <20231220155723.684081-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220155723.684081-1-cleger@rivosinc.com>
References: <20231220155723.684081-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Export the Ztso extension to userspace.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 4 ++++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_riscv.c         | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 41463b932268..10bd7b170118 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -161,6 +161,10 @@ The following keys are defined:
        defined in the RISC-V ISA manual starting from commit 056b6ff467c7
        ("Zfa is ratified").
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZTSO`: The Ztso extension is supported as
+       defined in the RISC-V ISA manual starting from commit 5618fb5a216b
+       ("Ztso is now ratified.")
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 91fbe1a7f2e2..01ac3dc196e5 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -56,6 +56,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZVFH		(1 << 30)
 #define		RISCV_HWPROBE_EXT_ZVFHMIN	(1 << 31)
 #define		RISCV_HWPROBE_EXT_ZFA		(1ULL << 32)
+#define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index f0bd7b480b7f..6564fa9e7a7f 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -174,6 +174,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZKSH);
 		EXT_KEY(ZKT);
 		EXT_KEY(ZIHINTNTL);
+		EXT_KEY(ZTSO);
 
 		if (has_vector()) {
 			EXT_KEY(ZVBB);
-- 
2.43.0


