Return-Path: <linux-kernel+bounces-130730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ABF897C50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A8B2885ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041F2156C4D;
	Wed,  3 Apr 2024 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Qin+KnVl"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA37158865
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187722; cv=none; b=nq+eOT+g/0Ixm3LFUIgRIvDNE6ZY+IwzbDvjhc+27BnHvBcOhkrWWhWTJ+aaqgE0prRv5fnDPEkpS4h4vZogzvr1MEUBHV2ayGV/AtHZxqev84hMAx5Vb6YiWiiAhIeyQLc2PDlkqlTLNDp7duuFXRQm+XeStN6eUSGju/zVbpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187722; c=relaxed/simple;
	bh=CNl3hprkQqVLkBFECp9sssqM0vv7IwZGZ7tM7RPw44k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaiBIK5gkt/Ut6TGW+IBhtCJ8UHyDSf7DYpFdxvPUpzABeMERlBOica1k2Eco+MG4WedHn/384PXaxkDXHRXMIxBsWUsFy6E1pcBbO4DLvwL+0L5iqDykiledCN2deBFy53xckAuy3fwb8cuDpEKAiOJUJ7YEUGrbiZXjhrHhmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Qin+KnVl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e28856ed7aso2974535ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 16:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187719; x=1712792519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1ajd+NFF25bzcoUpj6TOVq3gYUXEAPUF2iej3ctG8E=;
        b=Qin+KnVlIIcZhNoYZvq20/1nCED1I2HIiBhT8a85Fn7F9l+JuoHRoqpHIU0PL3sBbl
         JV1++fC+Z6wgfSgUDq7gdo7WsTv0s5BMDvz+SWDpikGQIAhrgLdtWzOwBS2ddgoNnwtm
         mSpP6jBdKPE5nBJA1e9ZxIOnFJhVPY2AlCrqx/QRlC+sP3grwmeZWXdEL9pqq00bbH4R
         IpceTNxix6ng7ED1u1RDxHGuGAZcSHUwvpF93aOPNnlEBh5m0Kopv+HfQNpZ7OVwbBqu
         GLaNQ54ZwBKAHqkm/CBcYAWsvC+F6e4ltb8sFoTWAi+JY0KTz24QUN8ZF4LZXoloZ9Uh
         LBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187719; x=1712792519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1ajd+NFF25bzcoUpj6TOVq3gYUXEAPUF2iej3ctG8E=;
        b=KKXt4gxO+4gsbKWu8MJQG4qBianZjlIhimMWNBdKrqMH+p29SvoIs3a9O5tcbyNOZA
         edmS1dMdxNHtyrEsHVjQOVvZBq+kYcx+yWgCEpANTJVcb+XfQhwEhfk++I9nqeFawmPg
         POZnZrbv+Ct/Abp1KtF0uqzzR17TGO6M/MjGKUJsJUsf1kn/XGmnpEgJwdXYNJWhnxZO
         N02E519aKhONFyjpbZyyyI8Rtul6fgW/lv73blqPchFcbjLKifEufFxx3YBK1bHOEVTS
         HT30of1YmyPPXQrS9OScr46Tej91GIr+uNGp4SSYnD0aXagit37glsmsdYx1rmKAXvTK
         tIgg==
X-Forwarded-Encrypted: i=1; AJvYcCV0hqOycAQ3C96kVtnYcyUxCzEuWQJHVWoPvwtpk+ciQUNs4piHv+NIyRGin7QAZPNwg08yDVS2TZSV85mXJP38gPFmmUPfICBp7oPC
X-Gm-Message-State: AOJu0YwVVXXv9QRmwUmQCLYQABF3hWQLJHkgH/wb4a80FgYCHOIXQSBz
	kjkD2g9Ebp+J7Veq6SRm2erk+GQxqw1o/Qv12h6Oh4zcHZe2DG0Fn+NnvzxtRXA=
X-Google-Smtp-Source: AGHT+IGh4iyC/GhUryA4pkxFBs7yNJ36fG0Y8vGsIbyj+jFCsDK2F7CISUUTPnXh7UOmjs+99OfNvA==
X-Received: by 2002:a17:902:f105:b0:1e2:718c:61e with SMTP id e5-20020a170902f10500b001e2718c061emr712135plb.27.1712187719240;
        Wed, 03 Apr 2024 16:41:59 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:41:58 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	conor@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v3 11/29] riscv mm: manufacture shadow stack pte
Date: Wed,  3 Apr 2024 16:34:59 -0700
Message-ID: <20240403234054.2020347-12-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403234054.2020347-1-debug@rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4d5983bc6766..6362407f1e83 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -408,6 +408,12 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	/* shadow stack on risc-v is XWR = 010. Clear everything and only set _PAGE_WRITE */
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -693,6 +699,12 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	/* shadow stack on risc-v is XWR = 010. Clear everything and only set _PAGE_WRITE */
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));
-- 
2.43.2


