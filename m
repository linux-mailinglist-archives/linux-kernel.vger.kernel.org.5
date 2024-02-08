Return-Path: <linux-kernel+bounces-58485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114E684E726
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA15CB2D73D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D32382D8F;
	Thu,  8 Feb 2024 17:46:15 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6726C1272A6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414375; cv=none; b=FYPVm3uIKNDIoNhpv/oCaZCMduWFfxaI6DH6OHvzpNvROVC6VbeuwTVESwb20mVLeNY7ociu4kz4CN+czeRxWvsaG7fx5M8MTjZyz9Z1FilkKElbvm43LtGnm7RLHY+kZ7D7JrQEhYy0N6RbU3wMxc2Eo+nkMCtDUAFYT/MJb5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414375; c=relaxed/simple;
	bh=V6SJDYhhfbsgsjuFz/DKNz7pq99SHkkbulZQPMkGtL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MXuxegUXIwYEOqKjKDfQz0AkrxAvDfd7G871uno95QltSRiolFPv61dlSjLjChAsCRtv3OGtc/c4ql/rpRpSCIhktclv5SBHHHOn/7VZnheoboizdzu3wS5rnSr1GQ4d1ymZALosLW1OVkf0trseCwUBwRguK+3xhrCIq6ZVsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3850ce741bso3522866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 09:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414371; x=1708019171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eurgVuL7EUuY+oG8xpKQlX9DZHWLlE9++VG+SZQp61g=;
        b=NSrmLr8GTlWyr+bWQX/yn78yNrPdefeU5e0nHV/qtMSxPnmXmL6uAE2HXns3JHwYpj
         kfps+0kbPBzn93+D+t+NWtVWfxEjQVmi39ytUZcolg5TpSHpNF74ijRwC3mLH+73oK+v
         sGsGN/Ubf+eP+FZuiKbdsBR5f2muTYlVwjkbUlHY/ndwPZJTQFCk10+U8gjPEJDQZV26
         QZY6DFOf9sxxzFLoEkIksmAf5NA4JsRsxZyQm9qU+sbdShGsAsXW5DD6t7jeKeqrVNNz
         +G0wBLZSOLQKWUaDE855NxNaDgjX2Dm5NiUuNjS9VdmUcK0/ifJC3QY+DJMp1Vqxjlie
         y2Qg==
X-Gm-Message-State: AOJu0YzGIdTaB9YYhiaKF3UvBOVLj07bz7JztkescmVaNctsnaqGdA46
	z6hESw53Bhq1eaWOR15x8QYEtIR/DgP//8GMi2arg8ckn3iNWixf
X-Google-Smtp-Source: AGHT+IE6H0+FCCdYFwlmbVyFqBn0xr4HtQx1wpphU6Nn0EvHm73s1Y/cR6ujxAMQL6+jqztC0j4i1g==
X-Received: by 2002:a17:906:3b5a:b0:a38:9148:60b4 with SMTP id h26-20020a1709063b5a00b00a38914860b4mr42920ejf.15.1707414371674;
        Thu, 08 Feb 2024 09:46:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWosqUu7ZF8tg2bRvkHwtsUbVs7AsjtbExYllIJYitSBxYagJ1OyCHKOZdsyPNpYWxE8fpEAOnb1lg68QkuQk5wTOk7WJkdRqx6im+HdGnAaD3jI+i5Uxlz2PN8JafDnTZniB9rBiBA0DQ+QqNi7a1DHm2Hev6CjZALWtL6XmQHwR7DLc0TbyIrZwewuOn/HeFbso9IkH83XpRZhLiz0k9yz1A4WJxFrKw7spr4NqCUE7KKqAAZLwsk3rROhPkROQOl5NY0InkYzBN3+DLmLQCvudpZRNYCjVVcCg==
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id ew8-20020a056402538800b0055c9280dc51sm1033142edb.14.2024.02.08.09.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:46:10 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: mingo@redhat.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] x86/bugs: spectre_v2_user default mode depends on main default
Date: Thu,  8 Feb 2024 09:45:54 -0800
Message-Id: <20240208174555.44200-3-leitao@debian.org>
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

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/kernel/cpu/bugs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0172bb0f61fe..1fe2e939c0b3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1216,9 +1216,13 @@ static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
 static enum spectre_v2_user_cmd __init
 spectre_v2_parse_user_cmdline(void)
 {
+	enum spectre_v2_user_cmd mode;
 	char arg[20];
 	int ret, i;
 
+	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
+		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
+
 	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:
 		return SPECTRE_V2_USER_CMD_NONE;
@@ -1231,7 +1235,7 @@ spectre_v2_parse_user_cmdline(void)
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_USER_CMD_AUTO;
+		return mode;
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1241,8 +1245,8 @@ spectre_v2_parse_user_cmdline(void)
 		}
 	}
 
-	pr_err("Unknown user space protection option (%s). Switching to AUTO select\n", arg);
-	return SPECTRE_V2_USER_CMD_AUTO;
+	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
+	return mode;
 }
 
 static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
-- 
2.39.3


