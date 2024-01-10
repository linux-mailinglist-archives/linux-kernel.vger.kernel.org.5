Return-Path: <linux-kernel+bounces-21823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258528294DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B793D1F261B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5008D3E47B;
	Wed, 10 Jan 2024 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHL9b00d"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A403E460;
	Wed, 10 Jan 2024 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1334661a12.0;
        Wed, 10 Jan 2024 00:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704874297; x=1705479097; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZaywHoOiMT3rUWnS91gy1WDghYyx7Hou7F1vPtGwj0=;
        b=fHL9b00dhJm9cxpIP8g6cUVDs5X2laatMkSIElMmxkCopp6XJIwJtpuRxGKvHEM2Y3
         sWun0yYkr6E5Tax3TRCrYGphM263Ui3+ctF+CBGOocl0nwvr7rOcgVq9rTWp/nnGfwJ+
         AieqPoD2d6dCdr93xHqE7aYYOgBEINdE7QmedWJuXZMFJxzaM+cWDUS9kphzzFEWghkr
         /QrYMU5Sff4wzcJFNXAE7yrRZ9xnVij/f9ivzQbH9htw7wQeVYT1D/avyWpH6Tc0kEw/
         6DDanRSpqR2571tBTJU6Eu6kJ7KcydGWwSPrnz6lSkKAg6w8cJJyp4G+RystA0t3ROp7
         VNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704874297; x=1705479097;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZaywHoOiMT3rUWnS91gy1WDghYyx7Hou7F1vPtGwj0=;
        b=b1bFlwuKPc1FB4wMkNZ7Zc/spv9u7KcWdbmyJcQ8cLwbZJfxoSoMNhrJwZKL1APHvh
         pNAbsXOPx4BNxZCYoz2cLfRsG5rwKuUUdVMx5QfL8KiidmFjV+0JdgWMuKdbP8PLJuTz
         5LxRu+y6/tWogB9J40Dv6Vd4gGbWJZUiYC0MtCHONgoun0g2RgjyoAWL0iiuy/+V01AK
         opvSt4Ij6wqtMngJV0Bk1JKkCUZiyQt/E1jbh5dbmPiPk9NLvj4qzGCJJ/ykFgHpBIM6
         fCbu4aw7BWLh28UASqUT6U5yEVgroVTUQq3N1nLR+/RctZUlyGONUvZVmvzOe+5iQ+Hc
         igzg==
X-Gm-Message-State: AOJu0Yz4OvcMsJit7kUJWQL7nOqtMM3APCB+foAReGTrS822FMBB1yLT
	AMCzD+PQOXRlnyvbQJFRXL78/95r460=
X-Google-Smtp-Source: AGHT+IGygMDDsV+XnbFYSvgL8KaqUurfHq2YVjd7FGO94vENdkAFc0QFkwIv9ekRxiW3kZpHTSj67Q==
X-Received: by 2002:a17:90a:69e4:b0:28c:f391:242d with SMTP id s91-20020a17090a69e400b0028cf391242dmr338137pjj.98.1704874297564;
        Wed, 10 Jan 2024 00:11:37 -0800 (PST)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id d18-20020a17090b005200b0028d70a8d854sm857733pjt.54.2024.01.10.00.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 00:11:37 -0800 (PST)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	quic_neeraju@quicinc.com,
	joel@joelfernandes.org,
	qiang.zhang1211@gmail.com
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/nocb: Fix WARN_ON_ONCE() in the rcu_nocb_bypass_lock()
Date: Wed, 10 Jan 2024 16:11:28 +0800
Message-Id: <20240110081128.18683-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

For the kernels built with CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y and
CONFIG_RCU_LAZY=y, here are the following scenarios that will trigger
WARN_ON_ONCE() in the rcu_nocb_bypass_lock() and rcu_nocb_wait_contended().

        CPU2                                               CPU11
kthread                                                   
rcu_nocb_cb_kthread                                       ksys_write
rcu_do_batch                                              vfs_write
rcu_torture_timer_cb                                      proc_sys_write
__kmem_cache_free                                         proc_sys_call_handler
kmemleak_free                                             drop_caches_sysctl_handler
delete_object_full                                        drop_slab
__delete_object                                           shrink_slab
put_object                                                lazy_rcu_shrink_scan
call_rcu                                                  rcu_nocb_flush_bypass
__call_rcu_commn                                            rcu_nocb_bypass_lock
                                                            raw_spin_trylock(&rdp->nocb_bypass_lock) fail
                                                            atomic_inc(&rdp->nocb_lock_contended);
rcu_nocb_wait_contended                                     WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
 WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended))                                          |
                            |_ _ _ _ _ _ _ _ _ _same rdp and rdp->cpu != 11_ _ _ _ _ _ _ _ _ __|

This commit therefore use the rcu_nocb_try_flush_bypass() instead of
rcu_nocb_flush_bypass() in lazy_rcu_shrink_scan(), if the nocb_bypass
queue is being flushed, the rcu_nocb_try_flush_bypass will return directly.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
--- 
 kernel/rcu/tree_nocb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index d82f96a66600..9b618842c324 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1381,7 +1381,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue;
 		}
-		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
+		rcu_nocb_try_flush_bypass(rdp, jiffies);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp, false);
 		sc->nr_to_scan -= _count;
-- 
2.17.1


