Return-Path: <linux-kernel+bounces-12371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1152C81F3C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0696283EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ECB63D2;
	Thu, 28 Dec 2023 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IRj4wDWM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55B03D8C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-204520717b3so3179291fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703727748; x=1704332548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJe+2iWG7zhbu2gjOAPKG3r+a1/tBb6PXcWtzUfSG2Y=;
        b=IRj4wDWMchpe5e/SlDtZMjWCwEWx6bf7LCeVjTNfmaCvVOOK0CNgHJ0+I5Ttx1qYfw
         IJa6H5PuBZ4y+0P/lRAdb90JZKw9KnYAaRErnR6Rpj6xq8Vfc0JmK3I2GJqRe/jIbVqF
         gYUTK63PSAJhI13bAxb5gwp4Ti3d+gAPlaz6TSULeYg2LCA//Tq05BpUDWNOT8hDnfdp
         aRL4i+pJ9NP4gaNohjf+05d3bwlDk32npHj/GxiO/xCnWEBj0TASIGagmkTURtqd3kPn
         aNbZlCDfe/OMtBhOfA/Uy6bBjk0ciqWNRa37xEwqdsNnGUd0JH40B45m7mG3vNC4LPaQ
         eXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727748; x=1704332548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJe+2iWG7zhbu2gjOAPKG3r+a1/tBb6PXcWtzUfSG2Y=;
        b=lcRBODFFc1JQhl5bYj8rexMR1dCJ68VyuOgTZmTQUoTI/HyBbvsFO2xreNjAPiMsNz
         QYsVaNIRpCKyMt/oPDcCFaC7qWcM5hHh/OWPZFx2dsA1q56YT93V1nH3mU4HWTWY3b5p
         njSHFaKRCzP3J9COtfK/dJIPK15TrsT3FjLG1aXJyeoxV17MnqNz41CtHlbduMiIzSU2
         lrLH2ij+1OpRL27g1ujxBZDZi0hKQpDMna2KPSd3GJAWWqxVvJwnm9gl/k19hFUBfIt8
         X6aJLzx0bKGF3HgWMxuWRdVc95BtPhezoZ1M+DCGJ2BQ8CDJ/gK6cVDGtctxWrQGNc1q
         0aSw==
X-Gm-Message-State: AOJu0Yy5SAc67tl3/+D/5gsL9ntS7fNUD/ic0nK5+TObsS43FFIxFevR
	wP/XLzTEk2qGR+Zdd9kXwA9p4+m4DGbZoZUo1Qn4iGaakhk=
X-Google-Smtp-Source: AGHT+IHYZaSMdp2QaO80SoY2qT34DsaM+IszcA+ix/EbDuC7szn+dKwMtM8zlpfibfh9dbJ1h4v/ng==
X-Received: by 2002:a05:6870:355:b0:203:e0bc:5e11 with SMTP id n21-20020a056870035500b00203e0bc5e11mr10237951oaf.70.1703727746413;
        Wed, 27 Dec 2023 17:42:26 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:42:26 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	linux-arch@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 03/14] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Wed, 27 Dec 2023 17:41:53 -0800
Message-ID: <20231228014220.3562640-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231228014220.3562640-1-samuel.holland@sifive.com>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/arm/lib/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 650404be6768..0ca5aae1bcc3 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -40,8 +40,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-  NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
-  CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
+  CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
 
-- 
2.42.0


