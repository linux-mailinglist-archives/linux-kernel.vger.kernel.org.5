Return-Path: <linux-kernel+bounces-31687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD3833282
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA04281DC6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92F54C91;
	Sat, 20 Jan 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9L37c1a"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118E23CB
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705719064; cv=none; b=bsrpqbQLMtJYUXJw9HbNFoj3G8wPJmhPpUE8OSOXgUxno/Cp+VPs10KnArQ5KwLVTkme1slSvqpdJSsInp1S+jx/Frfgv3rNF0hnlJ2ltPLeiGFesTcnzW0HEVfPwL0+p8gFjeme8ERJZhsF8Nm0rT4nrIYLQyCANxDSL0kGYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705719064; c=relaxed/simple;
	bh=GR+LGRPOvczJk2j19x5KNSDuIXLUu4YgzDfiDXEi9cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T5SejcfEAklzsCdWJu3lX16T2ToRFK/h6fQQ6yJh30oSK4ePop5xCENk3dCj0hKlgt1s5uAFLjCYzrCABeBSsnuwK1jemf+qCN5eSOp6xvZIWTz6eYAleGY/ocse7KV0L96jvWT1SQzUO+VcnGSg64UPRShsEdMsb+jlD3kjP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9L37c1a; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so1374564276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705719062; x=1706323862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4yGOYCSVn8lyqdFOSiCVTXQVvYKRjg9XK/8kAi6PdU=;
        b=d9L37c1aIJGLDj+kvCHissK0/yu304CuV5dC/yrMl8V8T6STmfO0RczoljTXVJT8TO
         RohzmIt19T23RjqgIjLdqOF+QMDuBeWglMtsU/It8jp2L+zv5A+qJ61r4NS9o0Kp4qKI
         LOzWqoGZklx24wwO929/iBxfcr04wDEt0ObOt3KRJ115QPdzF2R3CMKw2JG26r3o6y89
         +jH4fnE97q/Grh5X3G8spjKMRnm1FKr0yuW6ZYv7QxfFLmk3JWxqyO5nqv5tiw5m6hny
         KjqvLEGF0gcID9benrYNRydUgcpf0KM0NskjZeN7KEF5qd8obD1kYfro8c7adBu3x13x
         6Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705719062; x=1706323862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4yGOYCSVn8lyqdFOSiCVTXQVvYKRjg9XK/8kAi6PdU=;
        b=QlsQi5dOx6cmyke4/hF2i7+XLjPVwlVXOFsrd+gnUwrOwHiIj2bbBLZXAA3RWKQNgp
         X8/9SYwzMUEI1kaNWkuzW4H9zfUbZYkuDLQcAfyPV1ZtpRGQ06BAlBVs48wv2P01r9dh
         q9TnfdQhmIE49KwIvLa42ZpD0vWQTvJ/R2d4AM5ZEZhyuFINzUfWSIcVAYRkumaDu/79
         RQZuH0yYUTiGrC1dput2oI0M4dSshAf3inIndZKGrL/sVALn5xSIjAksIegAyihOP7WE
         U+TpA+BdXLoF8mJVSwX4QoawXRABD2ISFCpnexCs09daSoopMHkyKr0rwU9tWQLdYoxW
         Umuw==
X-Gm-Message-State: AOJu0Yxtx3xA9+9esjqWkFw4SOMMEvw5fgHutBekIPU852I9CHS3jFX2
	Ui6heGTJ+T5vqh2g658IsCRy0vzz9WTKEg6gtC9Y++OW5Al76NxZ
X-Google-Smtp-Source: AGHT+IHtKrb3yU+scb81DPv7h/dROUP8AB720nTvll5J5n8vYbh0YXhMNXGk32S0K6Yvi/ymidAfkA==
X-Received: by 2002:a81:4e48:0:b0:5fb:550c:9e7c with SMTP id c69-20020a814e48000000b005fb550c9e7cmr773237ywb.9.1705719061704;
        Fri, 19 Jan 2024 18:51:01 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2288:782e:a717:678d])
        by smtp.gmail.com with ESMTPSA id m7-20020a817107000000b005ff8bcbe01dsm1557957ywc.16.2024.01.19.18.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 18:51:01 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 4/9] lib/group_cpus: optimize outer loop in grp_spread_init_one()
Date: Fri, 19 Jan 2024 18:50:48 -0800
Message-Id: <20240120025053.684838-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120025053.684838-1-yury.norov@gmail.com>
References: <20240120025053.684838-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to the inner loop, in the outer loop we can use for_each_cpu()
macro, and skip CPUs that have been moved.

With this patch, the function becomes O(1), despite that it's a
double-loop.

While here, add a comment why we can't merge outer logic into the inner
loop.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 0a8ac7cb1a5d..952aac9eaa81 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -17,16 +17,17 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 	const struct cpumask *siblmsk;
 	int cpu, sibl;
 
-	for ( ; cpus_per_grp > 0; ) {
-		cpu = cpumask_first(nmsk);
-
-		/* Should not happen, but I'm too lazy to think about it */
-		if (cpu >= nr_cpu_ids)
+	for_each_cpu(cpu, nmsk) {
+		if (cpus_per_grp-- == 0)
 			return;
 
+		/*
+		 * If a caller wants to spread IRQa on offline CPUs, we need to
+		 * take care of it explicitly because those offline CPUS are not
+		 * included in siblings cpumask.
+		 */
 		__cpumask_clear_cpu(cpu, nmsk);
 		__cpumask_set_cpu(cpu, irqmsk);
-		cpus_per_grp--;
 
 		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
@@ -38,6 +39,7 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 
 			__cpumask_clear_cpu(sibl, nmsk);
 			__cpumask_set_cpu(sibl, irqmsk);
+			cpu = sibl + 1;
 		}
 	}
 }
-- 
2.40.1


