Return-Path: <linux-kernel+bounces-125976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971E8892EC8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B392823CC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 07:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD71C79F9;
	Sun, 31 Mar 2024 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwEAKnya"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900151C0DD3;
	Sun, 31 Mar 2024 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711868574; cv=none; b=oMAHO6cBAduQCDYBtaRVHPWwo4RyllC1eIAaVK8RqIfEVTQcMvsnJ9fdM6fDVjfsa9XpfVj3oealDXv2/nv9gf1jnUzAcj7/l4898q90SAgJ+oq0dN94MFp/Y03fxWhFD9sBBu8btpZM2GQoQ2LGmXObrtVCgeMmU6tDX1CiJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711868574; c=relaxed/simple;
	bh=dxne36p7CNzoDc1pQ1xQpNgyEGkny34AksP98O9zziA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hgscki+f26YADC+aTjTWdVuBQwQGfuQ4/aMf+/D6cqQ67IoH6auHyWSAYEH8jKLCnOtIp1rQ42d42F9M9BtXaKiRdOfY9XJaOWlpIWylskRVyZU4g+v+bOCMIzjANSZz5wWnpfDnJImGKRnMjFhPqi/QlIxUSOXR2lMtJUK0qnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwEAKnya; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-415482307b0so24398835e9.0;
        Sun, 31 Mar 2024 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711868570; x=1712473370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ftueHlK6SdS74xEyMEJM1z5ZFa9C8bMEaWxJQ9cgy6c=;
        b=BwEAKnyai9v8Zfz/zeL7DJ1FkrWk1V6Snn8hIkc/LzbmQ6Y+7VxQdTV9PTuynyeFMd
         LtpvqAv4Tn2d97qhlgMcneSdnwUV6WAo3GGvxgNX3XO9t4rvg6XI4mkGeA4YP86z6gH2
         FVFZJeO7Qq++JPXsc/bcNi5IvzH52TUFXEmmif/x/zR9Vbrswn0nIuqoDN+q1DE1xaB0
         T2jkbBit221y48NJZmcnFuB+9VeFIuP1J6rkFxm9etZXx/k5k+zMVxeO890McaFpqrIq
         4ECAGDv5o6BNj67vyeCHL+0eXhcwoYeQpO7dqQEiUqSs1yJVz+9yV50AW9hhrZ2GIR1d
         DmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711868570; x=1712473370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftueHlK6SdS74xEyMEJM1z5ZFa9C8bMEaWxJQ9cgy6c=;
        b=CJbu5vqLIsnn4hCPfMTvTlwXlDhufNkZ2/Xzjyqf1Vvw1e3diQQ7HuNJSGKuBsCeNR
         KfB3iWVq5o+qurcZoG7cLRNPCt0ru2Ipi1oAcsY3xOJoyjPzhzVflxEIwaDcEXRsYgUI
         kpuN6XKcFWPphvS22tY5R3PORY0T91LrRMoa7tWcXnEo4WigNjQfOSF9he7UvU92otnX
         scWG81phwsHM3WgLCU/lsESW5tNRt6dTmuOeoPnkqTkfa7u/pKILnGwOJgczkPt3DFP6
         ds2XGAoRm+VzOT+atIzUkvmIpahZnYBSG9AiFXoBBL7YDlKCGC66HlpqvDuaQQDEiQZG
         aQ6w==
X-Forwarded-Encrypted: i=1; AJvYcCU14EJfd4OFYrt0uec99LRjQ23eH1FFiAHn8f3K47tX2p7+ws2vTo/V0eNbjMl2nPTr9iZMWAw18Bv5QBeiboHxI/zdgxL0SmWL5biWmvw=
X-Gm-Message-State: AOJu0Yw7Fvogbq/gOX/4EIwglcIpEw6acxhyDo+RPLyF7XUpdjtO/Ybk
	Eff0x4f9HT77LzHKRRhGbsl9BYKESsY1NrgHNL5on0FoVd7YFUH2quMBfLsH5UA=
X-Google-Smtp-Source: AGHT+IF7lZOkvpocBQ55+s4W2G35MpHj5Sam1R7pxRZi/Ex6OgRPj7MDoU0YvUMkRqRFqBUvtGtBjg==
X-Received: by 2002:a05:600c:4f0d:b0:412:beee:36b3 with SMTP id l13-20020a05600c4f0d00b00412beee36b3mr5915412wmq.7.1711868569752;
        Sun, 31 Mar 2024 00:02:49 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id jb2-20020a05600c54e200b004155387c08esm5937826wmb.27.2024.03.31.00.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 00:02:49 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Davis <afd@ti.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-openrisc@vger.kernel.org
Subject: [PATCH] openrisc: Use do_kernel_power_off()
Date: Sun, 31 Mar 2024 08:02:28 +0100
Message-ID: <20240331070230.2252922-1-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 14c5678720bd ("power: reset: syscon-poweroff: Use
devm_register_sys_off_handler(POWER_OFF)") setting up of pm_power_off
was removed from the driver, this causes OpenRISC platforms using
syscon-poweroff to no longer shutdown.

The kernel now supports chained power-off handlers. Use
do_kernel_power_off() that invokes chained power-off handlers.  All
architectures have moved away from using pm_power_off except OpenRISC.

This patch migrates openrisc to use do_kernel_power_off() instead of the
legacy pm_power_off().

Fixes: 14c5678720bd ("power: reset: syscon-poweroff: Use devm_register_sys_off_handler(POWER_OFF)")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/process.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 86e02929f3ac..3c27d1c72718 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -65,7 +65,7 @@ void machine_restart(char *cmd)
 }
 
 /*
- * This is used if pm_power_off has not been set by a power management
+ * This is used if a sys-off handler was not set by a power management
  * driver, in this case we can assume we are on a simulator.  On
  * OpenRISC simulators l.nop 1 will trigger the simulator exit.
  */
@@ -89,10 +89,8 @@ void machine_halt(void)
 void machine_power_off(void)
 {
 	printk(KERN_INFO "*** MACHINE POWER OFF ***\n");
-	if (pm_power_off != NULL)
-		pm_power_off();
-	else
-		default_power_off();
+	do_kernel_power_off();
+	default_power_off();
 }
 
 /*
-- 
2.44.0


