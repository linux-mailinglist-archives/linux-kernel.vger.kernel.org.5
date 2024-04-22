Return-Path: <linux-kernel+bounces-153765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 271B58AD2DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9D4EB24C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB14153BC9;
	Mon, 22 Apr 2024 16:58:52 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61DE1DDE9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805132; cv=none; b=kyeX1VBhODGwzpDKgxfB/egDBXFHFASKry8ICXUoyfI+pY1Hgup89LSSPh/u7gOUqNzb8dnAGd0MTPGRwC6zJTIe3kC+RyqfmjtXY4K+601ME+Uvh9BcUp+oTqnkFFM1oOPCb/MwpJop20rr/UjlQB2bJyooiVhbCJLLdyN9WNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805132; c=relaxed/simple;
	bh=hXqLihYRFZkuzCw9JYuUqBxMEsnT35op8rRRCnu4HY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+beJwmeOpGaUuNcZ8K085/e70MgYlrjOeXJaugj7lfRNqdPRSuHHGjKEMGBJMfU7wt4B6MzxlPlokp2D9zoXg/mMK9vR/yx79UBbm4lYPH2ndbL9y1+sZr1KcayzBLrQ7EsDvSWH2NZ65rtgWavDPKJY0OLArSjz/45ELgMTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57217644ba1so642909a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805129; x=1714409929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+M8nxac4P+fMy2xk1zKUUJNHliTVzYUlBw8aFfQ+TY=;
        b=eKTRxz+H96fHjmsd43VfTI+W5chWPh/fSdvOBY9/m8aUWmNe1UvnB3x10EdgbSB6pf
         VpAirNwaTuMTqeWjg9hROqNJiGlYRB8wolEYr6o78hvGC52gj5SGXy/+pZ9vWhrk0Y4e
         IrY8sd7JKocMhL0ejlTxxvnx2LeU/K6yiquizOELXfL3XANo0pwX8GJfVI9jwQ2bN01J
         hE1vccLlvBCXIbItXyrFaCncDA48Z/LOkocsRcsBqyCvsZauC5i3leDrwqcnrTkyuTDd
         aCRpZg0F3a6iJ+cNyfL6tX4kQwPzLNgh5GGgnuKxktdxfra0LesfSjoMu1rypu9yBaLa
         bC0Q==
X-Gm-Message-State: AOJu0YwnsM9RxN2O0/Jojb8wnl/YpRcn0Gi8FwaDEb9NBq4/kU79D5tT
	ofzJ2Hd6xqA8vV4SX++/sgSgQ5KpH5nFJiXBLyIRobR43q3W9fUs
X-Google-Smtp-Source: AGHT+IGsDn4LlxXuTi1FLgWH4nNl0MdFXjS78u76R6NZBmDmau6je1+nmAwS0uOyDzZabkFiGD15jg==
X-Received: by 2002:a17:906:db03:b0:a55:b062:3bfd with SMTP id xj3-20020a170906db0300b00a55b0623bfdmr3871403ejb.35.1713805128914;
        Mon, 22 Apr 2024 09:58:48 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id hd38-20020a17090796a600b00a556f41c68asm5840640ejc.182.2024.04.22.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:58:48 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: jpoimboe@kernel.org,
	mingo@redhat.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/10] x86/bugs: Add a separate config for GDS
Date: Mon, 22 Apr 2024 09:58:15 -0700
Message-ID: <20240422165830.2142904-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422165830.2142904-1-leitao@debian.org>
References: <20240422165830.2142904-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there is no way to disable GDS mitigation at build time.
Disabling the current config option (GDS_MITIGATION_FORCE) does not
disable the mitigation, but set it to GDS_MITIGATION_FULL, which does
not disable it.

Create a new kernel config that allows GDS to be completely disabled,
similarly to the "gather_data_sampling=off" or "mitigations=off" kernel
command-line. Move the GDS_MITIGATION_FORCE under this new mitigation.

Now, there are three options for GDS mitigation:

* CONFIG_MITIGATION_GDS=n -> Mitigation disabled (New)
* CONFIG_MITIGATION_GDS=y -> Mitigation enabled (GDS_MITIGATION_FULL)
* CONFIG_GDS_MITIGATION_FORCE=y -> Forceful mitigation (disable AVX)

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig           | 16 +++++++++++-----
 arch/x86/kernel/cpu/bugs.c |  7 ++++---
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a902680b6537..d99b758c8d35 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2607,15 +2607,21 @@ config MITIGATION_SLS
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
index 9a9685c9244b..f2bdfb359f6b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -731,10 +731,11 @@ enum gds_mitigations {
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
2.43.0


