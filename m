Return-Path: <linux-kernel+bounces-153775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315168AD2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635901C213D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797C11553A8;
	Mon, 22 Apr 2024 16:59:10 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C72155389
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805150; cv=none; b=fPzGfiHk+0ZF94jFYQwi4WJg0+DkeiJr8MWXEQuE6xHfNK/vzEXz0vQBwjz1Zc4De+1ohV0mJoXj3e1oe3X+DHujjsj79tCJb9NI7VSozlYUvVDEqawmF91ZL1HQrpZmp5GPhbe6LsywsnUe9oGhQD2Ve+aQxGz4Gnvabbt8p9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805150; c=relaxed/simple;
	bh=SQuiBF/MrCyQ/BCQmn4asn0BFCr/NqEGblHpuUCLd80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Min2EVqiqRLObfgebsEz2XbZI8vPy/sO7DwNn5W71R+turgCMIuadNQL70LNvI78kjqF/eaf+mJu0pNx3xFQAGY4XJopimwvbdrNyD4tBxA853jhYeaBMARAptF3IkhSfVYTwX0OiiMVNG5E35IXOOMFDLoTgtu+gX0+7pBS+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so5598808a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805147; x=1714409947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+/0PnhwCbrGnHePvFrIclH7z5aZoAPI8sjK8xPZqDc=;
        b=glwgv7JSmpT4kn6eqvyrsE07YiBxjLC84q0Ukfb35O/147RnZKHtFJPdA5FgnOUcoV
         oOBS8H0E9Lkl8YtHWHEBGNxxhM/+7N2QCXNQtROtV8PTkCVo/6ZRQHofPDU7ldak3yhy
         IJz1kdrbqISV+wDVudKuhY3s0xsr1hpJQ/v6UCq7Zcev6RWCqTgVfUCRHktUurh2WLLz
         8g1tbRt5ldrUpWnmeISrguNCYiYxWUOLWEnEttOTlVejCBSkzywKyLmwVY6aPFZ6N8br
         3HrTmxfhfN5f0Y2DaM1Jxm7EVWEiKt68LnlWue5ZrNg5i2do+bvRJqUCfUww8zYULb0k
         juxw==
X-Gm-Message-State: AOJu0Yzgnn4Mjiz/svq8QHGnAmGDdrtP0uejGiIKAla/bGncNl5IbLgX
	JFbmHfh+ISQkLT/1Kz1nXtGx00WvIiAzg8TeqkM1fKq3C70zPhbI
X-Google-Smtp-Source: AGHT+IFDR+iZyBNOD2psDx0EqBEJi0oKt5u+d8vPXAQZHcr9/rmG3FRadkiDVPKR1YRrX3eF6/LTfw==
X-Received: by 2002:a50:d6dd:0:b0:56b:a077:2eee with SMTP id l29-20020a50d6dd000000b0056ba0772eeemr5554859edj.4.1713805146356;
        Mon, 22 Apr 2024 09:59:06 -0700 (PDT)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id e6-20020a056402148600b005702c757af2sm5733234edv.30.2024.04.22.09.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:59:06 -0700 (PDT)
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
Subject: [PATCH v3 10/10] x86/bugs: Add a separate config for SSB
Date: Mon, 22 Apr 2024 09:58:24 -0700
Message-ID: <20240422165830.2142904-11-leitao@debian.org>
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

Create an entry for the SSB CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig           | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c | 10 ++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4f69a7f5f675..8a5fcb1468f0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2744,6 +2744,16 @@ config MITIGATION_SRBDS
 	  using MDS techniques.
 	  See also
 	  <file:Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst>
+
+config MITIGATION_SSB
+	bool "Mitigate Speculative Store Bypass (SSB) hardware bug"
+	default y
+	help
+	  Enable mitigation for Speculative Store Bypass (SSB). SSB is a
+	  hardware security vulnerability and its exploitation takes advantage
+	  of speculative execution in a similar way to the Meltdown and Spectre
+	  security vulnerabilities.
+
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5628a77281fe..2e8b24e36d01 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2026,10 +2026,12 @@ static const struct {
 
 static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 {
-	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_AUTO;
+	enum ssb_mitigation_cmd cmd;
 	char arg[20];
 	int ret, i;
 
+	cmd = IS_ENABLED(CONFIG_MITIGATION_SSB) ?
+		SPEC_STORE_BYPASS_CMD_AUTO : SPEC_STORE_BYPASS_CMD_NONE;
 	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable") ||
 	    cpu_mitigations_off()) {
 		return SPEC_STORE_BYPASS_CMD_NONE;
@@ -2037,7 +2039,7 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
 					  arg, sizeof(arg));
 		if (ret < 0)
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			return cmd;
 
 		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
 			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
@@ -2048,8 +2050,8 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		}
 
 		if (i >= ARRAY_SIZE(ssb_mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			pr_err("unknown option (%s). Switching to default mode\n", arg);
+			return cmd;
 		}
 	}
 
-- 
2.43.0


