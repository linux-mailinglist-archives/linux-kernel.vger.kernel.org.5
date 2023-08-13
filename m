Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AF777A678
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjHMNMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 09:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMNMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 09:12:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01FC1710
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:12:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26b4dea0000so316987a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1691932339; x=1692537139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyaF8OQe7XuV6+81dQ8CVCJ81DcyiUEFM4INP5QUzaM=;
        b=2lW5yK6xonUvzaBodsPP0FKA6GNsRHH2PlO5peLkf/+TnGU2NWWx+tzmb2EBYqtfUD
         Am92fjoR+5X02+BWFj6F/mZ5xKfksJZgqGvPwTuZggP91dbdcpctPY0wF6HLT6R6U+qu
         LgwmrAAsKVzcqDrXTUqc6KDLXj8+iva/RIsa+pj6TggEbpKVxKfSLz9K/awANyovLj7q
         m3R/PpjfL+qf2kkUlvYQPT7gr/zHtPzK7hAzulMKVeodkIel32AqkmCNnPAGdew32rNj
         znRhLOVAxwCR7hB15fs6XzxlhbRyQqzgknnYb8pYBEVEnyNq7HzMGOU/ebBPWRQxQDzG
         zwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691932339; x=1692537139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyaF8OQe7XuV6+81dQ8CVCJ81DcyiUEFM4INP5QUzaM=;
        b=Y4q/oCVaOWIHYg/pEWwI86xePHDPhY73zTOh0dEBgTAErb4tn9bzj6HQIB91rD9yz7
         csgtUbVmRtlcAEx2DN4B00YDa8Fog2166wurwLzoSM/DahHxvZMb07tV2r7IUEmBVS2q
         XwFE8rfIUt4WG9KdUQq0oRBnS1W0gfhZQ373ZLwMxUY28gbTSwfiBsg4HGoSbzTLCDrh
         pHHocLNBov02DdCMnarV4CBxHpfBdDK2TvYMieX7sTFizmOG+IRhLpX2z/E3jiW4WajL
         YYlei0ykXSy9BYEEzDAWySPvVXziWuSEh49pkTtJ/ljXRFXObcbVtO6JiH6VVfJhF4uF
         Q+5g==
X-Gm-Message-State: AOJu0Yx4s9YMcOk5u/AqxiomaOSOuz4MLTYnvN3+1lN9a/LD5UccpVzx
        aTqPfj2XL6Al3HveGyb1XTgZ9Pvy0n5Vuy+qcUL/Pn0m
X-Google-Smtp-Source: AGHT+IHhXIKdAZymuyQJ9jjS4n656ZP96Jg0u6I6bavlwITLMslquBXKLX5M1WvySFxx+NtdAokwDg==
X-Received: by 2002:a17:90a:2a01:b0:262:f0e6:9e09 with SMTP id i1-20020a17090a2a0100b00262f0e69e09mr6043092pjd.14.1691932339346;
        Sun, 13 Aug 2023 06:12:19 -0700 (PDT)
Received: from nixos.tailf4e9e.ts.net ([47.75.78.161])
        by smtp.googlemail.com with ESMTPSA id c4-20020a63ea04000000b0055c178a8df1sm6556094pgi.94.2023.08.13.06.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 06:12:19 -0700 (PDT)
From:   Xueshi Hu <xueshi.hu@smartx.com>
To:     frederic@kernel.org, tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Xueshi Hu <xueshi.hu@smartx.com>
Subject: [PATCH] tick/nohz: remove unused tick_nohz_idle_stop_tick_protected()
Date:   Sun, 13 Aug 2023 21:11:53 +0800
Message-Id: <20230813131153.807850-1-xueshi.hu@smartx.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the caller has been removed since commit 336f560a8917 ("x86/xen: don't
let xen_pv_play_dead() return")

Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
---
 include/linux/tick.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 9459fef5b857..716d17f31c45 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -140,14 +140,6 @@ extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
-
-static inline void tick_nohz_idle_stop_tick_protected(void)
-{
-	local_irq_disable();
-	tick_nohz_idle_stop_tick();
-	local_irq_enable();
-}
-
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
@@ -170,8 +162,6 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
-
-static inline void tick_nohz_idle_stop_tick_protected(void) { }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
-- 
2.40.1

