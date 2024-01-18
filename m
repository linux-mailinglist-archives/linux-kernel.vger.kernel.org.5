Return-Path: <linux-kernel+bounces-30423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 554DD831E71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8786D1C22316
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63862D638;
	Thu, 18 Jan 2024 17:32:38 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9859C2D624
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599158; cv=none; b=qk/nCHNRs9k/qHsh6YuqbEO2I5Ry0kLq0gduJoW6b5x7mDIpN9uqbpRSUUQ6iCNIwyDT/a0WRJjRLrTpL1iS4CRDoLXq9ufkZFV5UkJ2fKeYWZ1cYuXf3SV2sXqapq0GEMotozwJY2OxVXg99Ld2xlx1Bj9ybkV0vTHT1cgYvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599158; c=relaxed/simple;
	bh=4doGAHQnnqzVCFzwSTC4oYZ1ZI0QDPVBOXZ7uuD/Ejw=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=rQ2i7kzUja+QIy+FwABESBv833wNrtO0RY5tKTQbzXdYl1gF2RDkDW3iLjsoHuJuJynuS0XmimVcsLJLFqbzaIuq2Uk6YJbXSM9hE+MbgxRjFJF+W/t3nDnEebtQeUaXDleX5UAPZ8MzMmmcLIuNK1DDVSmBwXaZ45T2dq8dizE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a025bca6eso1226116a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705599155; x=1706203955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jbV2CYl4OTbu9y0UXRb9wohz91lwTslTApdIlsv4JU=;
        b=lPsW57NxLYK/K0lgom3TzR/a5Oo9BTd/b+WiX/4TeQbxnOAwpeNPExgoih1Q7zhhL5
         QmSMUlBXkUZKcBrftCvh9sHx6Vv6fXuJ+fnyZ6xfB02z++v7SyIeLYw28AvZXdJEhBoY
         if+DFdXxJG/gWi96fkOl16YWEKNzMFo55P34UPOsfi0pdI9Lru3KtXvN2TkAx5qhgnMZ
         P3jo33yh/DPyfXTxBMFCu1S9CWoImd6x86v5YnxaQFYoDeHLHmi1ekl1D5rJhBbQMd3s
         oMy527sOSbdcfs+TNwFMSc7C+tuaIWMERxY//s8C/RtYnHJW4vD+dF7fFv46fKm8UY0l
         mVPA==
X-Gm-Message-State: AOJu0Ywb8YDEMIeT/tjxPt+wUJOBhqB70I/1g3piITCypFm5WnHF2+AY
	RPKFeQOoK+s+z3TVTHdvS9TlFaFROHSH9Wgqu34iJK/MPjPjgHKj
X-Google-Smtp-Source: AGHT+IFkabOlFrAcHIbQ+1GKxcOlGnEvasE2Ed13exEPiUHEduHIyWrfv7vHNi6LxNT0UecCIauYDw==
X-Received: by 2002:a17:907:8744:b0:a2f:3f0f:9645 with SMTP id qo4-20020a170907874400b00a2f3f0f9645mr323060ejc.64.1705599154554;
        Thu, 18 Jan 2024 09:32:34 -0800 (PST)
Received: from localhost (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906c08400b00a2b10e20292sm9330225ejz.215.2024.01.18.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 09:32:34 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: mingo@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] x86/bugs: spectre_v2_user default mode depends on main default
Date: Thu, 18 Jan 2024 09:32:13 -0800
Message-Id: <20240118173213.2008115-4-leitao@debian.org>
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

Change the default value of spectre v2 in user mode to respect the
CONFIG_MITIGATION_SPECTRE_V2 config option.

Currently, user mode spectre v2 is set to auto
(SPECTRE_V2_USER_CMD_AUTO) by default, even if
CONFIG_MITIGATION_SPECTRE_V2 is disabled.

Set the Spectre_v2 value to auto (SPECTRE_V2_USER_CMD_AUTO) if the
Spectre v2 config (CONFIG_MITIGATION_SPECTRE_V2) is enabled, otherwise
set the value to none (SPECTRE_V2_USER_CMD_NONE).

Important to say the command line argument "spectre_v2_user" overwrites
the default value in both cases.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 11ccbadd8800..4f1da92784c6 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1221,8 +1221,11 @@ static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
 static enum spectre_v2_user_cmd __init
 spectre_v2_parse_user_cmdline(void)
 {
+	int ret, i, mode;
 	char arg[20];
-	int ret, i;
+
+	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
+		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
 
 	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:
@@ -1236,7 +1239,7 @@ spectre_v2_parse_user_cmdline(void)
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_USER_CMD_AUTO;
+		return mode;
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1246,8 +1249,8 @@ spectre_v2_parse_user_cmdline(void)
 		}
 	}
 
-	pr_err("Unknown user space protection option (%s). Switching to AUTO select\n", arg);
-	return SPECTRE_V2_USER_CMD_AUTO;
+	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
+	return mode;
 }
 
 static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
-- 
2.34.1


