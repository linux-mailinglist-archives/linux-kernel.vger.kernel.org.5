Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79BF7DE9B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjKBAx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjKBAx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:53:27 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7065101
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:53:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso1227489b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 17:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20230601.gappssmtp.com; s=20230601; t=1698886404; x=1699491204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEH7jgDGNi0IK8LdwBqEJDaZ1nOxkEDv/a4hPy0Cfvs=;
        b=dWErfzAui2cK+FM9ru4SXx8kLKUZL0aQCsBU0VSnNXajFadcyUlstnSpNB8djE/49o
         jSJtnAYwnEvUPLpYSk0BIzORQvdjMDODjbQEYg96MemdRXS6FKjhJ49xyaUjkaoZvDVG
         BpQxLAH6b4eocpegFF6zjctjXOrSEF7i/4jRkQJzi4e4RFHfC8BO/vAhkh7v5bv/GTEs
         jnKEuvP9H0O12RX+Ra1i0/a3xNYfnfWSM+tbS2kgZPVXPgIzbYXUt/Uo7Iv18Qg65mIr
         cmcLntbYrHzRsV/YdyyTlYBOjyVZNA2H8zBH79O3gv5rVfb8ZU/Bf+tSRKIIyGLeYswV
         A//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698886404; x=1699491204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEH7jgDGNi0IK8LdwBqEJDaZ1nOxkEDv/a4hPy0Cfvs=;
        b=RXrYvIWDGtqiYM869vtM4mUza/QJ8pfn9xrUxdi1avSTaXHYImIOl4uSd4yHaagq1+
         F9IGnJ8CpIW5zqIKtWVeqpGsDL4q1VYNKe5zIVDA4DcfzyEllhc2fRrMO1UbMHGH61gM
         pcYd7N6PPh29yZxGFhN5escajStsZvp9EQU/QIzgBTXiw7rqMyrAMiJBqiIlW+K03fD8
         csU/8zidZ61vmJDBQeDnl1bTp+oeBs+mID2wWTBc6FO1dNY59lnVYsWlxG2kUTiA1OVi
         E7XBVvE6LM5iS9zqjuP6Zi9eurDrHnwl5RRkA7O6z/06S54ifgM/BiEu9iVxgosc4rqA
         b/tw==
X-Gm-Message-State: AOJu0YytJ5Nf8oovRPUmbxci+fCo4y05tEJbUj3bevqRPD0vMlac6RfZ
        BlX6bMD5Omo25dUdS0cQ/DdUHw==
X-Google-Smtp-Source: AGHT+IGSWXVKZ/Zqa3AgiAFvgieUYgWobPDkFn/aMZfv3jNm/vUrhTJokjt51yoYFUCRMB0d+zLJXw==
X-Received: by 2002:a05:6a20:1443:b0:17e:aa00:ca62 with SMTP id a3-20020a056a20144300b0017eaa00ca62mr10468558pzi.17.1698886404340;
        Wed, 01 Nov 2023 17:53:24 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2620:15c:2a3:200:8eb3:7c85:29f7:efa1])
        by smtp.gmail.com with ESMTPSA id n20-20020aa78a54000000b006c2d53e0b5fsm1768083pfa.57.2023.11.01.17.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 17:53:23 -0700 (PDT)
From:   william@wkennington.com
To:     tmaimon77@gmail.com, tali.perry1@gmail.com, avifishman70@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Brian Ma <chma0@nuvoton.com>,
        "William A . Kennington III" <william@wkennington.com>
Subject: [PATCH RESEND] ARM: npcm: Add CPU hotplug callbacks for kexec support
Date:   Wed,  1 Nov 2023 17:53:21 -0700
Message-ID: <20231102005321.1303809-1-william@wkennington.com>
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

