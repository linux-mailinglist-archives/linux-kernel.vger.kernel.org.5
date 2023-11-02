Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A927DEF8B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345474AbjKBKKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjKBKKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:10:52 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BCE13D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:10:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso444946b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20230601.gappssmtp.com; s=20230601; t=1698919847; x=1699524647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odwL1J6AS5nuqoPCF8FI4fUOnDzh+OWjuHaoV8Nap8E=;
        b=jE9ABzcUs4ykxihsWPdjm5DtOVYkw9/QYvx2LskuQnri8o1sgamftAk9kEJZOxrdSq
         jKFQ/QmvYHIeWA1b8nR/imfhyGT73XG7+UdrCWAinX4UGxbVEeFPnII+gwFtEqbbbvYv
         bp2rpq/6Cq2NlfZXwXYoqKgeydFTPf3AT2PWNXQXvacjbG07IwdPaCKGCMDfX7x26jLe
         DzJZ8cV3ozp6zZmPSS2zQkTX5HVGvzXwQTZM2PWIg3NhCusAmzuz7PXzlNrPLGaWCtdW
         SInc5TWnIzjb2sap4gUo+vFFXfJoQuuyvdl/bglHf1xtZBoM/Euh2fm1b+Rv2AbcMoUA
         mWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698919847; x=1699524647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odwL1J6AS5nuqoPCF8FI4fUOnDzh+OWjuHaoV8Nap8E=;
        b=UwcO1Zwdcv7Sew1UiHOp6dI4Co/N3lkHdamnEpbgUA7iLbBDDEO/i4oCFdyQft8F5W
         XIhFCzqwh3Y6XSP95ATzalQgL78oM9A+41mlvNJeqP1nsR0FTPZFw8W+dX+xz4lhcwmv
         gnmXVWdlyIYwgwESk8EfstfTU9qXJHqQVKOmKPLH7wL8fN989y12IETPVrpxR7MAKXKR
         LlqWekdmmNrUcZUSDdBYAtSkKt+SGojFEh3ZLYRHfrjvF/zIJ6ec51EO/8pBvstS+9h+
         QVDIWAPaRUksisufi/mr0Af5IQ5jmcFtne4uWb84+S18ggZ5zwtTv0xVjeebq7JhuyoP
         7W9w==
X-Gm-Message-State: AOJu0Yxadw77OCGszQNBXFCcjI3h+HBHekVFqca+inBOvv7jV7zYTx6t
        upaVzmf7o4s9ODdv6jF6qH5WnA==
X-Google-Smtp-Source: AGHT+IEf7ZgC902FAtds2SgN5IYeyPxxxWqsIRQdyf4VSs9bXlV7zIMiF/oukOjY8Q/mn5suukmJWQ==
X-Received: by 2002:a05:6a20:7488:b0:16b:8132:b547 with SMTP id p8-20020a056a20748800b0016b8132b547mr17207560pzd.4.1698919847221;
        Thu, 02 Nov 2023 03:10:47 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2620:15c:2a3:200:4b75:12e:f4c2:92ac])
        by smtp.gmail.com with ESMTPSA id fb27-20020a056a002d9b00b006bdd7cbcf98sm2552127pfb.182.2023.11.02.03.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:10:46 -0700 (PDT)
From:   "William A. Kennington III" <william@wkennington.com>
To:     tmaimon77@gmail.com, tali.perry1@gmail.com, avifishman70@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Brian Ma <chma0@nuvoton.com>,
        "William A . Kennington III" <william@wkennington.com>
Subject: [PATCH v2] ARM: npcm: Add CPU hotplug callbacks for kexec support
Date:   Thu,  2 Nov 2023 03:10:09 -0700
Message-ID: <20231102101009.15104-1-william@wkennington.com>
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

Add callbacks required for kexec to function. The NPCM7xx does
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

