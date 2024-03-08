Return-Path: <linux-kernel+bounces-96915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B48FB87630E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57DF1C2121B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAD35B043;
	Fri,  8 Mar 2024 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2rMnosh"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F25823E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896723; cv=none; b=PHTxy3VHzlesWMEgQn7ZIEwUngiC6UYKfOipWRnPw+c65/LGWpt6vbfAU2kC/wkFfEuBrsWlr0ROZuu+CKxljCng3NaIhLmHf/SDRHg8RW4WaGOlRFta6oCrdPUML1ea87ZCvfx4wqqr7CIdrLcK4oYJ+TNRxCc0VlgMn90rKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896723; c=relaxed/simple;
	bh=3Ui4kzQ8HyLHw1fD3j8kBFgxut87ua7kY/lvg3h1zdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YG4peQe+hFoMXYiNv7ZLVGQqD3QpispjdeLdz+9LYgH20eJMRBTuXQev3sOaRWR9C4vDslt4713RggYN3Vt4545WXZXbKORStW/V8UZiMoT6W68QWazLmJh63sdG+dy2PY/kfjJK11IVKj0r5qwcjnHsPTlFXC9ysYgveUBoaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2rMnosh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e65ed1c3aso601757f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896719; x=1710501519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7utVQf7xMO0/FjNcW1e+QFSl1hivqvd6aOD+j/KAet0=;
        b=J2rMnoshRaE5g9rvhmdOLrpSbHKGOjiOQhzt9zXr3frVZKqRmTMxJG4uVmNQ35wFpw
         IcK4jomsfVTrAx9fDli4qfbJQs4iev6PIW/cxneL5wP7PCsXppyqz/kLyeav2YsJfNI1
         EH+WzIEranYavviwLzhgxOmATPQ4HY0h26Gyk4+SA8pFVmOjTkh0G87dMtzJIIi7T2GC
         PALFf/Drc63CyLvBrMWJZwm2v0BGP3R7dLjqd1u47ulFVoBMcqViPRFvMMTDV/fWYFCs
         MkXjH8fZkAGnmC7tlmDIcNm6jbql4qAmI1v4w+TqXjiTFPc0oumqv1GUmFEE/PJGLUow
         wACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896719; x=1710501519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7utVQf7xMO0/FjNcW1e+QFSl1hivqvd6aOD+j/KAet0=;
        b=B3C8qSyul3C8FG40J1AMZwdkvga9ob2lauO7HxyTzZ/AReWbZCRbo7fJUu1S4SrJg5
         jLEcxD48ANSRicDbcPC4qblXoCePOiiO4dpuhoxTpHdlLKoixL2Jp1yYQj15sJOo1xXk
         yVGN0n+yhLOPE70ANyf/PPU4g6q0zmZ3VM4H3sbINuPaRSuYAKOo7ZEdjVqpx0Xy69pl
         JYkpcI+rpUh1Cwnx6Y1jBE8899nxcfbHPtK0EL8Nqdv1oqduD46ckbeerS6XsDGZU0F1
         j/n0cJwA/6wmIxU0ZpRJOPjRDG+f0EcktGbvWXtWc0Bw99TKP5HXC7ZTDFygfllgE53l
         taMA==
X-Gm-Message-State: AOJu0YwUjbmbad/Mt77gDsb/xYz45C7rOpht04kFiOoWclKTK0OGQkb9
	eDUgpBF05gDxicFKWLplhGjKl8HrTm3QeMNhVAbLaFEuHtCZscw/vZrnkJlcSvc=
X-Google-Smtp-Source: AGHT+IFU+Ze4eEQh+9fuTJyuzTTlBHCBU901JRusgpUEQiMMuzkTQ/KjBLs72UOKrMxnm5dQQFY2kg==
X-Received: by 2002:adf:e60d:0:b0:33d:f60e:5c6c with SMTP id p13-20020adfe60d000000b0033df60e5c6cmr14331054wrm.53.1709896719377;
        Fri, 08 Mar 2024 03:18:39 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:38 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 07/13] sched/balancing: Rename find_src_rq() => sched_balance_find_src_rq()
Date: Fri,  8 Mar 2024 12:18:13 +0100
Message-Id: <20240308111819.1101550-8-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308111819.1101550-1-mingo@kernel.org>
References: <20240308111819.1101550-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e600cac7806d..1cd9a18b35e0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10959,9 +10959,9 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 }
 
 /*
- * find_src_rq - find the busiest runqueue among the CPUs in the group.
+ * sched_balance_find_src_rq - find the busiest runqueue among the CPUs in the group.
  */
-static struct rq *find_src_rq(struct lb_env *env,
+static struct rq *sched_balance_find_src_rq(struct lb_env *env,
 				     struct sched_group *group)
 {
 	struct rq *busiest = NULL, *rq;
@@ -11280,7 +11280,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		goto out_balanced;
 	}
 
-	busiest = find_src_rq(&env, group);
+	busiest = sched_balance_find_src_rq(&env, group);
 	if (!busiest) {
 		schedstat_inc(sd->lb_nobusyq[idle]);
 		goto out_balanced;
-- 
2.40.1


