Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F118A7DE9B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjKBAwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjKBAwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:52:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CD4E8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:52:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc5fa0e4d5so3403625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 17:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20230601.gappssmtp.com; s=20230601; t=1698886359; x=1699491159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEH7jgDGNi0IK8LdwBqEJDaZ1nOxkEDv/a4hPy0Cfvs=;
        b=SMaoJNPFXJIwsGMPPtrBxSj0JH0dRdOa2GBKQnKWzfVRg5PcVZI0HHlU2hIM4AIY2h
         Wg0InEuQJV3XQe1PnsjtCUdPDB/sY81bMzC/aQfARYe/KiSspahLe8wPq8gT2bXkAItu
         FChPi8CpZ9FczryOZyiKHh/1Qxg2nPG3IC/fHr4EzTuNsmNY8+J9G/WicZt9r1OS57rZ
         lDWkvvfFCm5szxjntr6Rrc82OM5m2Lx9kIyLizxxvQdLG2EefotD3tnJxBo8dqeHhzJZ
         ail1kFd+d8l/HiEoBBIqbwMTTwhhd7bLuJdQUB9XMZPOrsFe/UguSamXSp2Cv+8CTonT
         21TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698886359; x=1699491159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEH7jgDGNi0IK8LdwBqEJDaZ1nOxkEDv/a4hPy0Cfvs=;
        b=rFVVqOTUElcBK6P1kvbLKEOOJMjtEpdMtaUUvnaQTwLYR5uhx8bA9TviNiJUOPTppZ
         jWBbaVvcmyJRv16T1w9ZIwfzzilUJK7/vFtU+Wy5+3JtpIS6EqZEUHh/k1ou6vUAgAam
         6oQSnaQkMglva1W9vdaHwNjcK98iP3Me1t9Pjh2i7UayyTYwUXQUEJRz+5SwM4tvCS39
         DrzjlvFf1sI21xSjWttq9nFT70bOtWsHih6pZhfh39XFOYfnVvdkGw9noVUtYUGbXkgX
         a5PzZF1EQSN5rODlT7O88eWvM9fyaRhZM/OTpeiWP4junRoEHh04x+Xyx4bTQzwH3BM2
         KSzw==
X-Gm-Message-State: AOJu0YzLbTi2XJ3J4TG3f1v1j6pPkBrCOA2c7V/q9x658XB1HqxJV/8K
        J0hGSxom//u1WC4zsE+pwr0mtA==
X-Google-Smtp-Source: AGHT+IE+ZdLb3Aw+UkjefJkw08x3IgjX/CtA8o+83Guh4gaPv8UBFUr6Jry4WwmCNb1WOSCraNSQ3g==
X-Received: by 2002:a17:902:f688:b0:1cc:53db:f53a with SMTP id l8-20020a170902f68800b001cc53dbf53amr11579358plg.8.1698886359474;
        Wed, 01 Nov 2023 17:52:39 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2620:15c:2a3:200:8eb3:7c85:29f7:efa1])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b001cc29ffcd96sm1888663plb.192.2023.11.01.17.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 17:52:38 -0700 (PDT)
From:   william@wkennington.com
To:     tmaimon77@gmail.com, tali.perry1@gmail.com, avifishman70@gmail.com
Cc:     linux-arm-kernel@lists.ifradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Brian Ma <chma0@nuvoton.com>,
        "William A . Kennington III" <william@wkennington.com>
Subject: [PATCH RESEND] ARM: npcm: Add CPU hotplug callbacks for kexec support
Date:   Wed,  1 Nov 2023 17:52:27 -0700
Message-ID: <20231102005227.1303733-1-william@wkennington.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231102002453.1299195-1-william@wkennington.com>
References: <20231102002453.1299195-1-william@wkennington.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Ma <chma0@nuvoton.com>

Add callbacks required for kexec to function. The NPCM7xx/NPCN8xx does
not expose controls for powering down CPU cores, so just wait in idle
loop.

Signed-off-by: Brian Ma <chma0@nuvoton.com>
Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 arch/arm/mach-npcm/platsmp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-npcm/platsmp.c b/arch/arm/mach-npcm/platsmp.c
index 41891d3aa124..6cc7b5894f08 100644
--- a/arch/arm/mach-npcm/platsmp.c
+++ b/arch/arm/mach-npcm/platsmp.c
@@ -69,10 +69,27 @@ static void __init npcm7xx_smp_prepare_cpus(unsigned int max_cpus)
 
 	iounmap(scu_base);
 }
+#ifdef CONFIG_HOTPLUG_CPU
+static void npcm7xx_cpu_die(unsigned int cpu)
+{
+	while (1)
+		cpu_do_idle();
+}
+
+static int npcm7xx_cpu_kill(unsigned int l_cpu)
+{
+	return 1;
+}
+#endif
+
 
 static struct smp_operations npcm7xx_smp_ops __initdata = {
 	.smp_prepare_cpus = npcm7xx_smp_prepare_cpus,
 	.smp_boot_secondary = npcm7xx_smp_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die			= npcm7xx_cpu_die,
+	.cpu_kill			= npcm7xx_cpu_kill,
+#endif
 };
 
 CPU_METHOD_OF_DECLARE(npcm7xx_smp, "nuvoton,npcm750-smp", &npcm7xx_smp_ops);
-- 
2.42.0.820.g83a721a137-goog

