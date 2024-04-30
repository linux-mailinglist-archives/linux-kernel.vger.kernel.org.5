Return-Path: <linux-kernel+bounces-164300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C168B7C08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F12D0B2109C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9677B172BC6;
	Tue, 30 Apr 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnf/VPuu"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962E7711C;
	Tue, 30 Apr 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491989; cv=none; b=QvG2Od9bEKkphvsdGBFs/9w8W2fv0qrNr3XQQGI3xpKhZiZDUYW473IBEVHaHAiGeeWGO+w4x8fKwpQc1cYt1P44vT+139VK74lVM99GZVzsI2zbAc3jq6V/AWNF/t973CiQqqWalKydMBR2MjuT9zEer2RDSjZTLHXw55AArkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491989; c=relaxed/simple;
	bh=hQFFSwP3hcm0A3iyRIUb04UGBwoyBj5GHP5o8eDjlG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBUedgnFim7zxHbyDM0QsVEo2T2qoEJyVLN9oFe6ZYaHQzRoCwJPse0tnpDRa82C/+B/O9s2SG7hJQAr8s/HQHU8ieB9ShyCKZICd72TazCald8rfJp7UdsVxa+2hEUgTlYs/Ee5kLV/c61qS7q38HLeUp1Ia5BkFsVww96+XIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnf/VPuu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2dd7e56009cso76310021fa.3;
        Tue, 30 Apr 2024 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714491986; x=1715096786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJX2EMrHqD9/mkSUuJ8crahPJMdU3eA1kLV4eXYGmPQ=;
        b=Dnf/VPuubdJ7ZghUK/l4EZ20721esxRDj3SXOXileOJpGrAUYyMZqql+V9Sw8zpA+b
         fH2vAKBhdoZqRV9VQ213nd38AaQLrE/C2mYbPr55ZryzzRP3+GLeLIAmblDLm0sJEPtX
         kpgS8sboDXJ4I/v2y1I6ot+FmGsY+29gzd1WW68CeUdpNPm7F5ajiz6CBYfyuQuo0XLl
         qXTq1m6/e7pCgt3CdnD4uIw4EIkOhBgXYXPQX6nGg3KT8j+hbVLk4cKweWOv+45PUg0i
         jq9KFXUxa2mDoh/UXExsWzE5Me2Daw3dbVbiMV+ACm8H9hzyRH+xlOvLl6u/VXZpD8Vn
         1ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714491986; x=1715096786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJX2EMrHqD9/mkSUuJ8crahPJMdU3eA1kLV4eXYGmPQ=;
        b=ds09YnIy4Ikb4X312Dd5SmuSpR9848K52dOQX0Fy0OKZxFbosDmLeqELoonLIMyRx4
         nUr5MQLZMIXGYpLl3df7sZfNT5NGerrM9FZlSSNzzgmGvdXxXsV3fvhjBVfk9VrqLYYO
         aAaF6cR5dwMHl1CYdW9GetURcn1Ayet0X210IQWIBD+AZ3xG6p8PmG7yUjwwmRt9P3MZ
         +p3ZJfWt9ZcK+y6d3gjY+82F29OcCpSzrN5r1ejTIjbQJpMvofHDZfjkqK+HlNNJz4vD
         TRA/5JeFOnZGngm5d50Y5OmFOMvbV3hYleVzbs3hOyBVPnmsMxIPbe/EW3s3Cc4A0nWs
         xHdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGvbSQo3dYbBl2e1Swja2TPOOpcljqr/dPMG/W0sc4sV0apGHACuVdZ8aRe4Vsadev6oqCntPSKH1u68ttfnGF4XoYaOsgZ1c6DNTOYMkIZdMqwXeNO8d0JymOS4aaLWcvdq7Acx/TCQ==
X-Gm-Message-State: AOJu0YxDtKnzF+MA1h+RnVXF4sC68p3g1KacAMsMmwOAVWEwyCQmMbyw
	prbkgSaDw+vxorpwQ1FezAgbZeWexAJq2lSZw0qWv7chw7UD40nSx3P2M9po
X-Google-Smtp-Source: AGHT+IEeSoYSO/yZLvp6GGrZKNxDVAfi0rW5zd8s10+Cf4QCUUglTtvC/WUZDPIMgYmF6E06Hx/5Xg==
X-Received: by 2002:a2e:a547:0:b0:2de:8b8e:cc16 with SMTP id e7-20020a2ea547000000b002de8b8ecc16mr73357ljn.40.1714491986014;
        Tue, 30 Apr 2024 08:46:26 -0700 (PDT)
Received: from hp-envy-17.promwad.com ([78.62.135.63])
        by smtp.gmail.com with ESMTPSA id ay24-20020a05600c1e1800b0041bf29ab003sm11918440wmb.30.2024.04.30.08.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:46:25 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: 
Cc: Siarhei Volkau <lis8215@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] MIPS: Take in account load hazards for HI/LO restoring
Date: Tue, 30 Apr 2024 18:45:58 +0300
Message-ID: <20240430154601.1337028-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MIPS CPUs usually have 1 to 4 cycles load hazards, thus doing load
and right after move to HI/LO will usually stall the pipeline for
significant amount of time. Let's take it into account and separate
loads and mthi/lo in instruction sequence.

The patch uses t6 and t7 registers as temporaries in addition to t8.

The patch tries to deal with SmartMIPS, but I know little about and
haven't tested it.

Changes in v2:
- clear separation of actions for SmartMIPS and pre-MIPSR6.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 arch/mips/include/asm/stackframe.h | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index a8705aef47e1..a13431379073 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -308,17 +308,12 @@
 		jal	octeon_mult_restore
 #endif
 #ifdef CONFIG_CPU_HAS_SMARTMIPS
-		LONG_L	$24, PT_ACX(sp)
-		mtlhx	$24
-		LONG_L	$24, PT_HI(sp)
-		mtlhx	$24
+		LONG_L	$14, PT_ACX(sp)
 		LONG_L	$24, PT_LO(sp)
-		mtlhx	$24
+		LONG_L	$15, PT_HI(sp)
 #elif !defined(CONFIG_CPU_MIPSR6)
 		LONG_L	$24, PT_LO(sp)
-		mtlo	$24
-		LONG_L	$24, PT_HI(sp)
-		mthi	$24
+		LONG_L	$15, PT_HI(sp)
 #endif
 #ifdef CONFIG_32BIT
 		cfi_ld	$8, PT_R8, \docfi
@@ -327,6 +322,14 @@
 		cfi_ld	$10, PT_R10, \docfi
 		cfi_ld	$11, PT_R11, \docfi
 		cfi_ld	$12, PT_R12, \docfi
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+		mtlhx	$14
+		mtlhx	$15
+		mtlhx	$24
+#elif !defined(CONFIG_CPU_MIPSR6)
+		mtlo	$24
+		mthi	$15
+#endif
 		cfi_ld	$13, PT_R13, \docfi
 		cfi_ld	$14, PT_R14, \docfi
 		cfi_ld	$15, PT_R15, \docfi
-- 
2.44.0


