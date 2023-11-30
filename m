Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51D27FEC53
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbjK3JzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjK3JzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:55:16 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA8D10F1;
        Thu, 30 Nov 2023 01:55:21 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a0029289b1bso92484566b.1;
        Thu, 30 Nov 2023 01:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701338120; x=1701942920; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMJA5AfP0P9yxCn+eRvuLh+vUtXzzmDbdcliSqXeJ88=;
        b=W3KHjea1Zs6fa9m28KdNeZdNzjrrIu+QW896YKa+THlaJ8ZuJFWxv0lqUMEDtP4nH3
         1SlEzfgn4zfZ9MOOMPeV6nfaB09wAMIvuPQLhQkNr4rA6yQRsFdHmARRTV6awLGSBrAd
         mN7lTATKEFG2YALqGnslQDi9e9NJlup15l3u6bU0mpC8Qh127wgeXcHc3L+miW+qw7P4
         RGkLklW1rVobS3Xu5mBY9wjNZPW2tpHW7365xsXs5loyLNkMC4i715pvy1bQ8ve1z4cU
         BNnwaHYoLMpXZKeguKPJmcsBfl1jMh1vICAoyXY+WjZgcRtzo6uJEGtIKzXbhFUZ2+x6
         HL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338120; x=1701942920;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMJA5AfP0P9yxCn+eRvuLh+vUtXzzmDbdcliSqXeJ88=;
        b=H8jxijvqpKXsZhqhqYddSBh1RMWTtAn9kiAUEAl/mETdgARFcir15z/VGc34ycjhev
         a+VR1kP4xq/FJyikW97aXlsaE1ugph6fbETcPcw2QQMGlM+2sawtEJym4gCXXYlUJkCG
         CUGkfU72i6nNICgga43IXrpysFahoyA3UZSo/rcCCaRV9JBTY85dECAIh+XUnHqyNOyB
         +osPGfIEEXIFRJbTYAJ+7jEBgkpWeEPV7w6kuOEy8zmks2DfSqXZq9Iyh3YVsFtb17Xg
         JTq5t70XuvvIL6bdiel5n0EMiKf4kW64ptDIc2KWC98uvqhyw9fbFPvSARxai4lkQh+l
         MNcw==
X-Gm-Message-State: AOJu0YyrgIR4VFAuh8FiZQ6tk7OeaTkHbveeVzl5baoVoHwLWWJiPpk3
        kja4t12om7iDXvJ5UO7WltA=
X-Google-Smtp-Source: AGHT+IEijT5IFhagvVJj2BSYxgKTlTUs0axftnkLk/i64ubFWskQfwihXRFfFN0WF38+KIQ8nTV70A==
X-Received: by 2002:a17:906:ca14:b0:a07:16e0:e0bc with SMTP id jt20-20020a170906ca1400b00a0716e0e0bcmr13673278ejb.76.1701338119585;
        Thu, 30 Nov 2023 01:55:19 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:257f:2c3:4a4d:4a99])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064a9800b00a0cd9d89a00sm485050eju.151.2023.11.30.01.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 01:55:19 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] docs: admin-guide: remove obsolete advice related to SLAB allocator
Date:   Thu, 30 Nov 2023 10:55:15 +0100
Message-Id: <20231130095515.21586-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1db9d06aaa55 ("mm/slab: remove CONFIG_SLAB from all Kconfig and
Makefile") removes the config SLAB and makes the SLUB allocator the only
default allocator in the kernel. Hence, the advice on reducing OS jitter
due to kworker kernel threads to build with CONFIG_SLUB instead of
CONFIG_SLAB is obsolete.

Remove the obsolete advice to build with SLUB instead of SLAB.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 .../admin-guide/kernel-per-CPU-kthreads.rst      | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
index 993c2a05f5ee..b6aeae3327ce 100644
--- a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
+++ b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
@@ -243,13 +243,9 @@ To reduce its OS jitter, do any of the following:
 3.	Do any of the following needed to avoid jitter that your
 	application cannot tolerate:
 
-	a.	Build your kernel with CONFIG_SLUB=y rather than
-		CONFIG_SLAB=y, thus avoiding the slab allocator's periodic
-		use of each CPU's workqueues to run its cache_reap()
-		function.
-	b.	Avoid using oprofile, thus avoiding OS jitter from
+	a.	Avoid using oprofile, thus avoiding OS jitter from
 		wq_sync_buffer().
-	c.	Limit your CPU frequency so that a CPU-frequency
+	b.	Limit your CPU frequency so that a CPU-frequency
 		governor is not required, possibly enlisting the aid of
 		special heatsinks or other cooling technologies.  If done
 		correctly, and if you CPU architecture permits, you should
@@ -259,7 +255,7 @@ To reduce its OS jitter, do any of the following:
 
 		WARNING:  Please check your CPU specifications to
 		make sure that this is safe on your particular system.
-	d.	As of v3.18, Christoph Lameter's on-demand vmstat workers
+	c.	As of v3.18, Christoph Lameter's on-demand vmstat workers
 		commit prevents OS jitter due to vmstat_update() on
 		CONFIG_SMP=y systems.  Before v3.18, is not possible
 		to entirely get rid of the OS jitter, but you can
@@ -274,7 +270,7 @@ To reduce its OS jitter, do any of the following:
 		(based on an earlier one from Gilad Ben-Yossef) that
 		reduces or even eliminates vmstat overhead for some
 		workloads at https://lore.kernel.org/r/00000140e9dfd6bd-40db3d4f-c1be-434f-8132-7820f81bb586-000000@email.amazonses.com.
-	e.	If running on high-end powerpc servers, build with
+	d.	If running on high-end powerpc servers, build with
 		CONFIG_PPC_RTAS_DAEMON=n.  This prevents the RTAS
 		daemon from running on each CPU every second or so.
 		(This will require editing Kconfig files and will defeat
@@ -282,12 +278,12 @@ To reduce its OS jitter, do any of the following:
 		due to the rtas_event_scan() function.
 		WARNING:  Please check your CPU specifications to
 		make sure that this is safe on your particular system.
-	f.	If running on Cell Processor, build your kernel with
+	e.	If running on Cell Processor, build your kernel with
 		CBE_CPUFREQ_SPU_GOVERNOR=n to avoid OS jitter from
 		spu_gov_work().
 		WARNING:  Please check your CPU specifications to
 		make sure that this is safe on your particular system.
-	g.	If running on PowerMAC, build your kernel with
+	f.	If running on PowerMAC, build your kernel with
 		CONFIG_PMAC_RACKMETER=n to disable the CPU-meter,
 		avoiding OS jitter from rackmeter_do_timer().
 
-- 
2.17.1

