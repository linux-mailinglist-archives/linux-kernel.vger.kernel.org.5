Return-Path: <linux-kernel+bounces-30421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0738F831E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B5D5B25AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8A72D609;
	Thu, 18 Jan 2024 17:32:35 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991D2D044
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599154; cv=none; b=iqt8hem/8kHBAJAWLep2kJMQsI4viTHD9KUpp2WNZg0k0Df9MyOfMwGf2QkxzCm+dsM4qjJ3jATmeKzFftCvp3S1VKBdFrNVqWr90nFh4a6zlZAQRAtgDfjaK33ae1CEmcy9CXuZuj+9ugqxvLnnotz8HldF+CHp6AC7o8PafOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599154; c=relaxed/simple;
	bh=cvbCPN1PNGNQlz20JF8uuYdvdoi6CQOEbNjgwbPBiao=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=gDkCR5CcfouRXp0oIdYvVunwUEV8JCZkTaftYMyy5CtxV5tsMmKPoAdoCjCTg57vB6w36evSlMgFOm3ByqqODZNMGZE7lnslOGr4YvMbbZFxv5uYFPcxmJ80vGipojabWPr973vbz8pnbSFy7YVYJ4Tk8OnSv9GQT5eQvjAqkdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26fa294e56so1310306366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705599151; x=1706203951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEYSqpyfrDZSkYFm3rTNQP9D1iITVTBODLatPLfXrH8=;
        b=CZl/JFZHA3kQBUurcomjW3LNHrE6lI5Hd45F+XWmgd1fCJPf8xPojXIZYXDlE+r5Qa
         R6zW/ub6OXoi1EN8PcvU8Dz8xcSmLf+LUbMk4hmp+XG2GbJndMNZuz4inI5vOxltpm1a
         b4pFQucKi0RhqOgKX3xtNG3PTeNLeZt7TNTb+RWYYzwVkRdAc+I9ncc0kLFc8uMEp/oS
         /WltxAYsniOODJ7k+4tRRoQenG4dvV6rnWWIG0wY6m5nG/ZR4QrmaDOCuoOPowe5m4wX
         viPjwgdohxdVHUAj3H3ZrMgsSEaseMMdAPIKVJ8V7sebljyrVJKyrFWaRNKfABtwS7hC
         L2Sw==
X-Gm-Message-State: AOJu0YxfLMAQnXwBXoZuk/CTtIXXpQKi7QKAgbYQmBD44GWNE0utcdcF
	RjnsdYq+EgsaW/3l/RJwjqNVT4XXAVpR8mYIoOW28R5KuwDlWi+p
X-Google-Smtp-Source: AGHT+IFVlv/sEBMQaO4zvJ67JciCRUwvIj1m4p3WtigxEO1T2ZR1U0rqm52yhu5AeVSJrsws0gTnMw==
X-Received: by 2002:a17:906:195b:b0:a2c:fd6c:4753 with SMTP id b27-20020a170906195b00b00a2cfd6c4753mr715643eje.53.1705599151126;
        Thu, 18 Jan 2024 09:32:31 -0800 (PST)
Received: from localhost (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id rv25-20020a17090710d900b00a26c8c70069sm9329801ejb.48.2024.01.18.09.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 09:32:30 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: mingo@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/bugs: Create a way to disable GDS mitigation
Date: Thu, 18 Jan 2024 09:32:11 -0800
Message-Id: <20240118173213.2008115-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118173213.2008115-1-leitao@debian.org>
References: <20240118173213.2008115-1-leitao@debian.org>
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
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
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
2.34.1


