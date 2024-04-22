Return-Path: <linux-kernel+bounces-153772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2DA8AD2EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B5DB21D93
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BEB1552F8;
	Mon, 22 Apr 2024 16:59:04 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317FA155314
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805143; cv=none; b=WJgJc67Ilr3dKMG6v6l6aWKs8MVK60EoP8aZ+FHLd/HAywcvyr5pj1KaTqyeZJ8qHTY9nKdvzxTrvSDqBMgBQGaUwT41iq98DmnPN0HV+yiTqqtwd2nrNymxunNC5ZbCxNOl8ZVs4IVLBgKdB0s8AIKtV8I5EuF2D3pN3kFcD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805143; c=relaxed/simple;
	bh=ucoBbncin5B2WXivebCu8MnWkr4EwZjdf99LIOzMXAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duqV11NmCYM+u3NHg3E0YX/g2EpWAG9I+UoNVpn5wGnxwiKif1SqdC0TxV3vLvfRdENjZc6IMWHxCz8Iu7u4toUsLnX/dqL3sUd0ZK5XJqC41IIZSETiMPEiZHaWjJlTrkcxw3Dp1wFe9YBxxAVg7KlbakcYHa8bl7cWQT02Vdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-346b146199eso3553683f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805140; x=1714409940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSeOQnWU630u1dd7rprYG6Ohpor9yXklkuz0WMDXmKo=;
        b=PiWT0sxdd/Yfo12lfftNZiU7B9bcj+DHkx5yk6kORheXIaT3sakLwnOSLNYkqjQByG
         S2D1iGAMkBxbkSBqvFPjcaexglPg6d3G6NnuAdw03N0N1vYtDhnJGtIveImajzEB6WZc
         qZC/X+hG/SCpyNOxMQSwxgxTmCxfdbg7dVtMSI3FYbRGqkSIAqA14KIPXzzPHbXvc/re
         WQbo0VDBA9vvuQKd+9Tx5PtC9xgeBNgRTcIWbFZKNMxvLMhOjxJdBccgM0c8LCiSQxEr
         FZ/24w72BNLvRUQBQ1oPOqJkHWO1QE8+3d4qpacIL1O5rzPNBq+IInu1i7ZOY00JaEo2
         FLDw==
X-Gm-Message-State: AOJu0YwWG2knxp816DWDuemE7NOcnUqA7ycpZ43A4jHdv2TvgQFXY5YR
	JBxuCRfsA0L6ksf8y6jEMDYHw4bI//BVpdTfOhf0i7onBeDeYObm
X-Google-Smtp-Source: AGHT+IE3n/u87NY+vjAv0ePCCME9pO0M5j2BtS0S50XtzR05b4GP9o6fxKjNxY8iIz2T+tEmQ3917A==
X-Received: by 2002:a05:6000:4022:b0:34a:5d59:5501 with SMTP id cp34-20020a056000402200b0034a5d595501mr8842558wrb.4.1713805140523;
        Mon, 22 Apr 2024 09:59:00 -0700 (PDT)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id hy25-20020a1709068a7900b00a4e03c28fd5sm5967668ejc.43.2024.04.22.09.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:59:00 -0700 (PDT)
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
Subject: [PATCH v3 07/10] x86/bugs: Add a separate config for Spectre v1
Date: Mon, 22 Apr 2024 09:58:21 -0700
Message-ID: <20240422165830.2142904-8-leitao@debian.org>
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

Create an entry for the Spectre v1 CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig           | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f5c941a0a837..43dd45720fb1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2708,6 +2708,16 @@ config MITIGATION_RETBLEED
 	  unprivileged attacker can use these flaws to bypass conventional
 	  memory security restrictions to gain read access to privileged memory
 	  that would otherwise be inaccessible.
+
+config MITIGATION_SPECTRE_V1
+	bool "Mitigate SPECTRE V1 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V1 (Bounds Check Bypass). Spectre V1 is a
+	  class of side channel attacks that takes advantage of speculative
+	  execution that bypasses conditional branch instructions used for
+	  memory access bounds check.
+	  See also <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c6c404b1c6ac..00c3438519be 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -875,7 +875,8 @@ enum spectre_v1_mitigation {
 };
 
 static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
-	SPECTRE_V1_MITIGATION_AUTO;
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V1) ?
+		SPECTRE_V1_MITIGATION_AUTO : SPECTRE_V1_MITIGATION_NONE;
 
 static const char * const spectre_v1_strings[] = {
 	[SPECTRE_V1_MITIGATION_NONE] = "Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers",
-- 
2.43.0


