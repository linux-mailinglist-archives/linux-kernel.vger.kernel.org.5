Return-Path: <linux-kernel+bounces-58484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFF884E708
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193FE1C2501C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FF31272AA;
	Thu,  8 Feb 2024 17:46:13 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4667782D61
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414373; cv=none; b=HZbZKj/FAK6mDSdgJxX0QcTKhb36bU+bbQivptypq4ttq2lY30whOfd20iRky65o00l/y5RN8PMNLmd+oLUziSAX4yvohphl0xHl9BgWyN3i2+JL9sAWGHgsngWzUaYu6fIBq9iZBy746YvdJK9OJ80QPjhiX+lO9onREvD4SZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414373; c=relaxed/simple;
	bh=q2dr7c/QVHh7zHm5CcoMvsNU3SwZfRo9G63HVxFAciY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAZJQ5qLAvjsdT6bf8owT5jzUs+jIU7OCeGcefEdu3P0eZrapplldPtb2Rnotuk86j5tAzGD7CdV99dQVP2HpGJ8+95XmLcOa49NOU02+n6bH6jQETk/48V/TtDIhBMKoSseshXTc7eKPxNBw/sd6QH6OuKu53FuyHpHQJZBpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a389a3b9601so6188866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 09:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414369; x=1708019169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ih/jBTnio5/IZQFOp461sTdF+T+V2d6Zsp9b1u0NxxA=;
        b=aZ+bEJJ3nc1naSYGJcIRvxnny9pnYfPf1qUaZJzk3BHDr94lV4EsCSUPHr29XDZnEU
         XmxK6aqrfNZXg3E9J86310GpIhIjCf1fmytFvzw6/UoaZV24KtSJlVyNW/ky1ZWYc6q5
         HcZXi7TOz9uGzbYm1a6C54hOoOUgCnN/FikebztQhYfITwvuv84q8mMuJuYTz1/Oujx/
         L1r+MM6Wtbg1qYz/5haw7Mi3XSDs3obsNCefx3YUznsB1JMs8GS35Zg3bFvNO1DCdHtT
         OEXkADLdbeu4pMdNQLNCkn82sEaoO2+fzPzoIRyMewg0C2CrA1B0CHeA358GaDIngSWt
         O1Bg==
X-Gm-Message-State: AOJu0YwNnOjlHnV9kmQTWIvQ/ll2pUEtOSl2FuvFr/p0PJRf6hwAsD3B
	D+Qxwin+NqOspzpXOgNboDtMwdfp8BMdhVax1tWkRrPgtlMAXdGw
X-Google-Smtp-Source: AGHT+IEKtNoKw4R184/7V5YL9rQl71ykoPGcBgHJApsExsGFxa67cXAV4Maf9i6avJVHypObaqZjeA==
X-Received: by 2002:a17:906:80ca:b0:a36:fc15:c6b2 with SMTP id a10-20020a17090680ca00b00a36fc15c6b2mr32370ejx.35.1707414369418;
        Thu, 08 Feb 2024 09:46:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGQH8vx/d3kKVONIuJf8EGl3CmpVDMrfLZsOC9xxQc/X9ietRvOGVnfbaSwPLtfg2ltfyRqyZcBsYqZeRsQmQROgQZ07KNMI6lbs5z3QSQpeMhYfaSEiE2vqJFVTXM2e3CPPUyqqSZlGy2stdgrDkxYSjN4oVdKrX3YsAcI1r3tSfYUAEWimZyTaZ0QLE06sq+RlIwrBQWfV37sQjfj5UHgT4j+1YPW5phHG5uE9r5WRe+4BLyXeQ5tO5se7kn/iUpGMR14LegMhO2Z3t0HdRwPal02xQW0C8rOw==
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id en14-20020a056402528e00b0055fe55441cbsm1045813edb.40.2024.02.08.09.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:46:08 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: mingo@redhat.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] x86/bugs: Create a way to disable GDS mitigation
Date: Thu,  8 Feb 2024 09:45:53 -0800
Message-Id: <20240208174555.44200-2-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208174555.44200-1-leitao@debian.org>
References: <20240208174555.44200-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there is no way to disable GDS mitigation at build time.
The current config option (GDS_MITIGATION_FORCE) just enables a more
drastic mitigation.

Create a new kernel config that allows GDS to be completely disabled,
similarly to the "gather_data_sampling=off" or "mitigations=off" kernel
command-line. Move the GDS_MITIGATION_FORCE under this new mitigation.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 16 +++++++++++-----
 arch/x86/kernel/cpu/bugs.c |  7 ++++---
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0a9fea390ef3..d5e3f1a8cacd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2587,15 +2587,21 @@ config MITIGATION_SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
+config MITIGATION_GDS
+	bool "Mitigate Gather Data Sampling"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Gather Data Sampling (GDS). GDS is a hardware
+	  vulnerability which allows unprivileged speculative access to data
+	  which was previously stored in vector registers. The attacker uses gather
+	  instructions to infer the stale vector register data.
+
 config MITIGATION_GDS_FORCE
 	bool "Force GDS Mitigation"
-	depends on CPU_SUP_INTEL
+	depends on MITIGATION_GDS
 	default n
 	help
-	  Gather Data Sampling (GDS) is a hardware vulnerability which allows
-	  unprivileged speculative access to data which was previously stored in
-	  vector registers.
-
 	  This option is equivalent to setting gather_data_sampling=force on the
 	  command line. The microcode mitigation is used if present, otherwise
 	  AVX is disabled as a mitigation. On affected systems that are missing
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f2775417bda2..0172bb0f61fe 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -671,10 +671,11 @@ enum gds_mitigations {
 	GDS_MITIGATION_HYPERVISOR,
 };
 
-#if IS_ENABLED(CONFIG_MITIGATION_GDS_FORCE)
-static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FORCE;
+#if IS_ENABLED(CONFIG_MITIGATION_GDS)
+static enum gds_mitigations gds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_GDS_FORCE) ? GDS_MITIGATION_FORCE : GDS_MITIGATION_FULL;
 #else
-static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FULL;
+static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_OFF;
 #endif
 
 static const char * const gds_strings[] = {
-- 
2.39.3


