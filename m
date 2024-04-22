Return-Path: <linux-kernel+bounces-153770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ECE8AD2EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 928A2B2611F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7601D155317;
	Mon, 22 Apr 2024 16:59:02 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BB1552F8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805142; cv=none; b=dwX8vsASCOQ4nRbRXg+xT51XpRfTQpXcvUmI/WHWXVpUItmYJhbU0VWvvB3gusyNuIoemDwtarsHZA6tklVk5x/piS1MesxCYHvvItGc4kr9et59FqomvTIcMqonj8ah1br9qWL/emFo3ZdRl1sXu9Aok2MSXnCD5R8hpe3Lrt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805142; c=relaxed/simple;
	bh=YgvAz9KHnENdbdQSX+/hzGCPyOv+Dc9oxXqawLxd/M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAoFP4A9Q8Mer/JcS8Zj1o61mvFzTaGJzUmQe7quPtUOj2BsS0AQb2zbbYPBROpmbBDlLdQhmBoW1KeXXg8u0tBHMhnp+634Tx1ToQOdXAepQym93PqRoUTM6detHYB5X+Us5/S0vuOnPM9/PCK584Obi/txcjjb6OTRbIGaWmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso5870913a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805139; x=1714409939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K16+OPsEQjJ9rybaX0bQn7NDfdzmf1VzGQpkmeZBSqE=;
        b=Dq4zBNUr7ibGoEx/KORlxCsbIawRLDvi/eMFQS6rsDNR4TelIFeJmTx60QMrpGTF1R
         sG1qRXIrNQjc2ZQ8bVxNygsl5wuRahai55xJ3zlhG4N0K2rHMvnQKYzFLUDU0K4+xBo4
         U/3NAsWdrlqFQx6IcWf2Qg9U3lCOkuqkUeBfZTX34eVduHk6SthHBEjho74LeWyqyf2m
         GWr1fOPzP9m//3xVRtWQLKkJEH8L1/h5M8Rq7JphyZU/b9I/wKhUAy0APnYf9ZMeSLqQ
         EE3xusN3MlRbwTm58jFiwvJTFvKfmBzvAT+FDNBwmtTnPwibTy97rdByDIjyZyzjBGl+
         N7HQ==
X-Gm-Message-State: AOJu0YwHR+eODBbKEfH5BUoP93ZFMdABwEPChmAGLR71uTCZ6ETXouQW
	bJKn2AfuF2/ctxcSnk9A87Ou0DCiVYCmNi2KzmCMHgLoV9cXVoe/
X-Google-Smtp-Source: AGHT+IE0xJW8Rzq3oCU66PJ2lSgR3MaWR/hRHFKcjHzpZsazbT/2HB+jEN/vkyl4Fb4qe/SdgA4U8A==
X-Received: by 2002:a50:9e66:0:b0:56d:b687:5a45 with SMTP id z93-20020a509e66000000b0056db6875a45mr6908036ede.1.1713805138567;
        Mon, 22 Apr 2024 09:58:58 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id k4-20020a50cb84000000b005705bb48307sm5729767edi.42.2024.04.22.09.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:58:58 -0700 (PDT)
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
Subject: [PATCH v3 06/10] x86/bugs: Add a separate config for RETBLEED
Date: Mon, 22 Apr 2024 09:58:20 -0700
Message-ID: <20240422165830.2142904-7-leitao@debian.org>
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

Create an entry for the RETBLEED CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig           | 13 +++++++++++++
 arch/x86/kernel/cpu/bugs.c |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 192d20348b41..f5c941a0a837 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2695,6 +2695,19 @@ config MITIGATION_L1TF
 	  hardware vulnerability which allows unprivileged speculative access to data
 	  available in the Level 1 Data Cache.
 	  See <file:Documentation/admin-guide/hw-vuln/l1tf.rst
+
+config MITIGATION_RETBLEED
+	bool "Mitigate RETBleed hardware bug"
+	depends on (CPU_SUP_INTEL && MITIGATION_SPECTRE_V2) || MITIGATION_UNRET_ENTRY || MITIGATION_IBPB_ENTRY
+	default y
+	help
+	  Enable mitigation for RETBleed (Arbitrary Speculative Code Execution
+	  with Return Instructions) vulnerability.  RETBleed is a speculative
+	  execution attack which takes advantage of microarchitectural behavior
+	  in many modern microprocessors, similar to Spectre v2. An
+	  unprivileged attacker can use these flaws to bypass conventional
+	  memory security restrictions to gain read access to privileged memory
+	  that would otherwise be inaccessible.
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d20299b350d7..c6c404b1c6ac 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -990,7 +990,7 @@ static const char * const retbleed_strings[] = {
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
 	RETBLEED_MITIGATION_NONE;
 static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
-	RETBLEED_CMD_AUTO;
+	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
 
 static int __ro_after_init retbleed_nosmt = false;
 
-- 
2.43.0


