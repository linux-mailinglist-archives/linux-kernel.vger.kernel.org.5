Return-Path: <linux-kernel+bounces-153774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91068AD2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40912880B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22117153BE0;
	Mon, 22 Apr 2024 16:59:08 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E556E155314
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805147; cv=none; b=E+qSZLXOwx90tM3j/9g43np6p/mae2psccxOT5wmb0uwP/KdwHhM3Dl8YeeSQBloI1cC01Hndv7Xftbha0yaB6sA+dqw8C5niLx50kIC2laDeUPJS9cOMj6GyXiMfwCX7dYA4MA7rW1am6AZ+4EAG//pn6ZrCDO+fOJEintF8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805147; c=relaxed/simple;
	bh=CEW6djjENnK8i4xnr2gyr3zOyZhyU7VSWHKtmWEbZvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGGGqLNKlp8Gi1QjWB90vwRYdW9Zckt9HNfE2y9ZOEnjDj1GrkeeYme8fPEhxxPnH1wut35UscHNVDOoQMBNLPoi4J+zG70dhcEXy2+H3jMsUosS6pcXiI4zF7K9uJVINUD9rFOYKgbNSkxH0LqXqSCv1ak7P2m8A4k8e05qSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a72f3a20dso7210535e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805144; x=1714409944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQodkT2pk00x6+Ui5xe7sWS/8qfrbWhleMy31J9gQDg=;
        b=bAkkqK5mUF1qCld1RU8/9CETxjZF7VoVO2YsyLW1DDXpe7/D2WX543K1NtyJwbsKeo
         XRMgpNxYde5jqAMabS4jNjS4kL45XBEEkAj+ukD2+UBRsSNyUG7h4M3xbuc4YljUw6Hi
         UjP97MsAMhmh9qNGkEkT7CaQGVlIvcxrtiKjnw2QVSyOID7s+12D2kKAJV7uOBKv/2+3
         bPwyIPk0+yxM3y73D2gZ7Hr8KpSNMRq7XGkrCNsMLMm7CPtgegYouvZUr+ily/jOIsha
         6MZouBV5SPiFthV1DnoOxPwkvoHYW0tNZEGoXzK5GTdP1cj90e5gYfXZ0gzZ/eLp4F4N
         LqLA==
X-Gm-Message-State: AOJu0YwjRajjNud3NyIw/yuzUqaSMVA8XGv4zCq9zRhSqS3QF8BjqENz
	FASsO1YkD6fYyTY2ZCnD1XlBWp9WXZwTSXjAlq7U0dTsZZLikzhU
X-Google-Smtp-Source: AGHT+IE5o1g3gt6lfgT2cTCMXsZ1InOMguPjiH1OnB0u2IB1/pdg9UaGREvMM+AgZxQJuCYO0TSZNA==
X-Received: by 2002:a05:6000:22d:b0:348:4519:15b8 with SMTP id l13-20020a056000022d00b00348451915b8mr6885572wrz.40.1713805144348;
        Mon, 22 Apr 2024 09:59:04 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id qq22-20020a17090720d600b00a554f6fbb25sm5923437ejb.138.2024.04.22.09.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:59:03 -0700 (PDT)
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
Subject: [PATCH v3 09/10] x86/bugs: Add a separate config for Spectre V2
Date: Mon, 22 Apr 2024 09:58:23 -0700
Message-ID: <20240422165830.2142904-10-leitao@debian.org>
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

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for the Spectre V2 CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig           | 12 ++++++++++++
 arch/x86/kernel/cpu/bugs.c |  9 +++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fdf1c894fcb8..4f69a7f5f675 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2719,6 +2719,18 @@ config MITIGATION_SPECTRE_V1
 	  memory access bounds check.
 	  See also <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 
+config MITIGATION_SPECTRE_V2
+	bool "Mitigate SPECTRE V2 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V2 (Branch Target Injection). Spectre
+	  V2 is a class of side channel attacks that takes advantage of
+	  indirect branch predictors inside the processor. In Spectre variant 2
+	  attacks, the attacker can steer speculative indirect branches in the
+	  victim to gadget code by poisoning the branch target buffer of a CPU
+	  used for predicting indirect branch addresses.
+	  See also <file:Documentation/admin-guide/hw-vuln/spectre.rst>
+
 config MITIGATION_SRBDS
 	bool "Mitigate Special Register Buffer Data Sampling (SRBDS) hardware bug"
 	depends on CPU_SUP_INTEL
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 49b60c0e2eb4..5628a77281fe 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1457,17 +1457,18 @@ static void __init spec_v2_print_cond(const char *reason, bool secure)
 
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
-	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
+	enum spectre_v2_mitigation_cmd cmd;
 	char arg[20];
 	int ret, i;
 
+	cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
 	    cpu_mitigations_off())
 		return SPECTRE_V2_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_CMD_AUTO;
+		return cmd;
 
 	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
 		if (!match_option(arg, ret, mitigation_options[i].option))
@@ -1477,8 +1478,8 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	}
 
 	if (i >= ARRAY_SIZE(mitigation_options)) {
-		pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-		return SPECTRE_V2_CMD_AUTO;
+		pr_err("unknown option (%s). Switching to default mode\n", arg);
+		return cmd;
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
-- 
2.43.0


