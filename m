Return-Path: <linux-kernel+bounces-29558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AFD831030
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C6C2871E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B6928DAB;
	Wed, 17 Jan 2024 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS4vIWTM"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61028DA0;
	Wed, 17 Jan 2024 23:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705535398; cv=none; b=bKoIEV1yxsnC9feH5hVUSqBdQL17IdFyq4m+7woTjc5onP/nG0QlxS0LDk1YZUEJaJFfKLodpgLRS3KArAVMaYpBg97RmPBaIhFD3phfKpXT4aduB7OIvLF92tUOakIq9TFfRVHhLSiG/6XVhkX0kUe1n56T4PGYD/hk0Kvh8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705535398; c=relaxed/simple;
	bh=aam7oYF4g9EqqlqYBqV3eSxfKV7feMrcfKtaXfjRZzc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=cBI4qiLVb+VqACLNe67X5zkvFdsz+HbW2YsNDMJVDBBCQfSkDWa5YnzoalcUktOqyNRWOo5kE+4HzRCrrLa9R4ySZ9iw7S1XJnDk/+gxP16C0Gf/o/TQwtAkzZRm1GvI5bQWa8ERifrqUJAN8OVDdUuFn51L5CB0eh5g8+xvcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hS4vIWTM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9344f30caso141912b3a.1;
        Wed, 17 Jan 2024 15:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705535396; x=1706140196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAK0YIohDCD4eqIjGEjkntfc4ZRv0vFsNjgtuUpGJzk=;
        b=hS4vIWTMdj+37jcRQeX1A5+dc6gfvPnhdjGcP/XZeeLk1Ait4kp1QtRVgPTkcRDO6E
         rD6/fQp4LjoADwRr7n8xAu4AK+nQHiw6smYzHUCGOFI6ibZv//5lstbvKqr6hajz2NDo
         Mz7HVdgjm7voS7h09n9f4wwuJBl8Uj/Ytqtp/WCI+4fHZJVJuIyyZIDSWIOqx1Kfhe2i
         l97H+FKgFM5+DxcF2bfrp3beY1LTEE0X6my9lNSUeSf8D6RiT4CV9WBrWGKI7YESP0l/
         naODLVn3ThtemtPWZQsESz9Er7ubJKsfImI2qnHNsnYc9bFAqTqtX1aPkE1Vxk4MBAf0
         GqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705535396; x=1706140196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAK0YIohDCD4eqIjGEjkntfc4ZRv0vFsNjgtuUpGJzk=;
        b=TDPwosLvhhO+CBxRbIzE1U0uXIxRfegoNBSwlq83Hz+1+ISRSedkuPDvFTG6l+Z5Hg
         BufQ15IagWnTLvt1PeEMgnxhBLeLsyKVDvssSAnV8KlJXo1jEsI4Tkahl4eDy6waUz++
         KukjGrJxCb8rb+yr3zClNIdy6NJdUBO50rKchsIk6pM+2TdmuHuE4/BagJJwPzrhq6OR
         WT9u13+fhX+CXu+xU7t0iX+iHS1gS3qyYd5LynkPW29vgHSwhpmttW/sYEfcjhm0M7vw
         x1AmktHmybaI5AAK7QjKDB2AKuua97Yqh4BdIPhQXaaUub8uQmuRO9xG84hnLILUbQHK
         g/5g==
X-Gm-Message-State: AOJu0Yyk9L/cSNIHa9baKvAX91ALDkQRy93IO9dgjY0egN/rnXEkQl/D
	UMvZRA4mj9QqSAyr0jypa0WJZhx9vlk1kXS/Ju+Qxdn1k3L6jFvzkt2V3bSk
X-Google-Smtp-Source: AGHT+IH7xPafH8KvpsM4vbXJlq4re+OuijYTPfbCQ+YJ7Q1peqpvAzPfTDXAdQ9+c924WtLjZNGMQg==
X-Received: by 2002:a05:6a00:3923:b0:6da:ed17:bfa7 with SMTP id fh35-20020a056a00392300b006daed17bfa7mr124169pfb.6.1705535395774;
        Wed, 17 Jan 2024 15:49:55 -0800 (PST)
Received: from eldorado.. (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78494000000b006dab0d09ef0sm2001796pfn.45.2024.01.17.15.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 15:49:55 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MIPS: Alchemy: Fix missing prototypes
Date: Wed, 17 Jan 2024 15:49:44 -0800
Message-Id: <20240117234948.923273-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a number of missing prototypes warnings for board_setup(),
alchemy_set_lpj() and prom_init_cmdline(), prom_getenv() and
prom_get_ethernet_addr(). Fix those by providing definitions for the
first two functions in au1000.h which is included everywhere relevant,
and including prom.h for the last three.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/alchemy/common/prom.c            | 1 +
 arch/mips/alchemy/common/setup.c           | 4 +---
 arch/mips/include/asm/mach-au1x00/au1000.h | 3 +++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/alchemy/common/prom.c b/arch/mips/alchemy/common/prom.c
index b13d8adf3be4..20d30f6265cd 100644
--- a/arch/mips/alchemy/common/prom.c
+++ b/arch/mips/alchemy/common/prom.c
@@ -40,6 +40,7 @@
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
+#include <prom.h>
 
 int prom_argc;
 char **prom_argv;
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 2388d68786f4..a7a6d31a7a41 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -30,13 +30,11 @@
 #include <linux/mm.h>
 #include <linux/dma-map-ops.h> /* for dma_default_coherent */
 
+#include <asm/bootinfo.h>
 #include <asm/mipsregs.h>
 
 #include <au1000.h>
 
-extern void __init board_setup(void);
-extern void __init alchemy_set_lpj(void);
-
 static bool alchemy_dma_coherent(void)
 {
 	switch (alchemy_get_cputype()) {
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index a7eec3364a64..41546777902b 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -597,6 +597,9 @@
 
 #include <asm/cpu.h>
 
+void alchemy_set_lpj(void);
+void board_setup(void);
+
 /* helpers to access the SYS_* registers */
 static inline unsigned long alchemy_rdsys(int regofs)
 {
-- 
2.34.1


