Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D0F7DE948
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjKBAZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjKBAZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:25:03 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4008110
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:25:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc4f777ab9so3092625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 17:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20230601.gappssmtp.com; s=20230601; t=1698884700; x=1699489500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEH7jgDGNi0IK8LdwBqEJDaZ1nOxkEDv/a4hPy0Cfvs=;
        b=qbEKCp/0tOv4LAiwqvUbcwVgiEhx+awjBmoUXVMRTHOqU2z/D7coDm0Qi5SJuwYz0X
         iLHvjqqFtOswbh54SMdjiMOTlSH4fJ/Hw29g2CPDQzI3v0vGAEQxuTczsTXkytXDK62K
         k2J8Mz5d8DaBovNKoDvG7GTA0nx1ugApviZmTkdnWWufL1e2mEIzGtYQe+yq1aEId3KQ
         3gVs4hjvQFrXWw6BB3mqGrSTgk4VgfxGrYfswq+RxU9mm9hRH9flCa/2XKtraS/rIvh7
         0A4RREFeMLAkMymCrKK0XROXtie5gfEzFNN2AVBNJ556+7l+VpE/8eNOdCuUey8jKZmt
         O/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698884700; x=1699489500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEH7jgDGNi0IK8LdwBqEJDaZ1nOxkEDv/a4hPy0Cfvs=;
        b=Pd9K3VK4FhpmG6iega2cer6id4vMBe4yg+kCh+HapmIkDgttzolEIGlcGF680H5rRs
         mlQ4tI5xuaTRgn1Y+kuBgNo6zdUMG7Q1EKJTAfgAueJgxd3RETfPhpVrB2yD2ITxgdCu
         0hpPJ8oiVu04BuMj/o4FY0eGn8c8LQhjb8yyJZsRZjStIRCtVFLv5+43zKpwD6JBoRaQ
         R7Div/GTyKVBlwVpN/dTC/qlC3MWvp6qTYrgD0cf1jw/JEosB0tLYrdP7G6BtuWzVmGT
         nsMFZVbwcEkz6Uio0tr9UFRbN/DurBHyQlfoDybgsiKK9w1My89tuw/MltygtEC0AAFh
         1mdA==
X-Gm-Message-State: AOJu0YxHoXOCochn/TAdgttLrlesw7/aNdaZdAPhB/I/4T4HiqXrsitn
        mGw6mijwz0oRz097QzgK78i6Fw==
X-Google-Smtp-Source: AGHT+IHbe87+pda9KMj8h9yADQPuHza8FZiqPMjNvMkuAQyzoKTXx8xKJQouIlGMQjgJJVcPPWLo1A==
X-Received: by 2002:a17:902:904a:b0:1ca:a290:4c0c with SMTP id w10-20020a170902904a00b001caa2904c0cmr13808328plz.16.1698884700253;
        Wed, 01 Nov 2023 17:25:00 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2620:15c:2a3:200:8eb3:7c85:29f7:efa1])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090330d200b001c771740da4sm1831210plc.195.2023.11.01.17.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 17:24:59 -0700 (PDT)
From:   william@wkennington.com
To:     tmaimon77@gmail.com, tali.perry1@gmail.com, avifishman70@gmail.com
Cc:     linux-arm-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Brian Ma <chma0@nuvoton.com>,
        "William A . Kennington III" <william@wkennington.com>
Subject: [PATCH] ARM: npcm: Add CPU hotplug callbacks for kexec support
Date:   Wed,  1 Nov 2023 17:24:53 -0700
Message-ID: <20231102002453.1299195-1-william@wkennington.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
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

